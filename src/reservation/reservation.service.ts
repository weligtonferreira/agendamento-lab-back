import {
  BadRequestException,
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';

import { PrismaService } from '../prisma/prisma.service';
import { CreateReservationDto } from './dto/create-reservation.dto';
import { UpdateReservationDto } from './dto/update-reservation.dto';

@Injectable()
export class ReservationService {
  constructor(private prismaService: PrismaService) {}

  async create(reservationData: CreateReservationDto, laboratoryId: string) {
    console.log(reservationData);

    const startTime = new Date(reservationData.startTime);
    const finishTime = new Date(reservationData.finishTime);

    if (isNaN(startTime.getTime()) || isNaN(finishTime.getTime())) {
      throw new BadRequestException('Data ou horário inválido.');
    }

    if (finishTime <= startTime) {
      throw new BadRequestException(
        'O horário de término deve ser posterior ao horário de início.',
      );
    }

    const conflictingReservation =
      await this.prismaService.reservation.findFirst({
        where: {
          reservationLaboratories: {
            some: {
              laboratoryId,
            },
          },
          startTime: {
            lt: finishTime,
          },
          finishTime: {
            gt: startTime,
          },
        },
      });

    if (conflictingReservation) {
      throw new ConflictException(
        'Este laboratório já possui uma reserva para o período solicitado.',
      );
    }

    const reservation = await this.prismaService.reservation.create({
      data: {
        userId: reservationData.userId,
        startTime,
        finishTime,
        reservationLaboratories: {
          create: {
            laboratory: {
              connect: {
                id: laboratoryId,
              },
            },
          },
        },
      },
      include: {
        reservationLaboratories: {
          include: {
            laboratory: true,
          },
        },
      },
    });

    return reservation;
  }

  async findAll() {
    return await this.prismaService.reservation.findMany();
  }

  async findById(id: string) {
    const reservation = await this.prismaService.reservation.findUnique({
      where: { id },
    });

    if (!reservation) throw new NotFoundException('Reservation not found');

    return reservation;
  }

  async updateById(id: string, updateReservation: UpdateReservationDto) {
    await this.prismaService.reservation.update({
      data: updateReservation,
      where: { id },
    });
  }

  async deleteById(id: string) {
    await this.findById(id);

    await this.prismaService.reservation.delete({ where: { id } });
  }
}
