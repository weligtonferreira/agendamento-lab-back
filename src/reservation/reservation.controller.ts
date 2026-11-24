import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  Post,
  Put,
} from '@nestjs/common';

import { ReservationService } from './reservation.service';
import { CreateReservationDto } from './dto/create-reservation.dto';
import { UpdateReservationDto } from './dto/update-reservation.dto';

@Controller('reservations')
export class ReservationController {
  constructor(private reservationService: ReservationService) {}

  @Post(':laboratoryId')
  @HttpCode(HttpStatus.CREATED)
  create(
    @Body() createReservationDto: CreateReservationDto,
    @Param('laboratoryId') laboratoryId: string,
  ) {
    return this.reservationService.create(createReservationDto, laboratoryId);
  }

  @Get()
  @HttpCode(HttpStatus.OK)
  findAll() {
    return this.reservationService.findAll();
  }

  @Get(':id')
  @HttpCode(HttpStatus.OK)
  findById(@Param('id') id: string) {
    return this.reservationService.findById(id);
  }

  @Put(':id')
  @HttpCode(HttpStatus.OK)
  updateById(
    @Param('id') id: string,
    @Body() updateReservationDto: UpdateReservationDto,
  ) {
    this.reservationService.updateById(id, updateReservationDto);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  deleteById(@Param('id') id: string) {
    this.reservationService.deleteById(id);
  }
}
