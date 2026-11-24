import { Injectable, NotFoundException } from '@nestjs/common';

import { PrismaService } from '../prisma/prisma.service';
import { CreateLaboratoryDto } from './dto/create-laboratory.dto';
import { UpdateLaboratoryDto } from './dto/update-laboratory.dto';

@Injectable()
export class LaboratoryService {
  constructor(private prismaService: PrismaService) {}

  async create(laboratoryData: CreateLaboratoryDto) {
    const laboratory = await this.prismaService.laboratory.create({
      data: laboratoryData,
    });

    return laboratory;
  }

  async findAll() {
    return await this.prismaService.laboratory.findMany();
  }

  async findById(id: string) {
    const laboratory = await this.prismaService.laboratory.findUnique({
      where: { id },
    });

    if (!laboratory) throw new NotFoundException('Laboratory not found');

    return laboratory;
  }

  async updateById(id: string, updateLaboratory: UpdateLaboratoryDto) {
    await this.findById(id);

    await this.prismaService.laboratory.update({
      data: updateLaboratory,
      where: { id },
    });
  }

  async deleteById(id: string) {
    await this.findById(id);

    await this.prismaService.laboratory.delete({ where: { id } });
  }
}
