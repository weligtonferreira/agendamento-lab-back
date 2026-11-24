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
import { LaboratoryService } from './laboratory.service';
import { CreateLaboratoryDto } from './dto/create-laboratory.dto';
import { UpdateLaboratoryDto } from './dto/update-laboratory.dto';

@Controller('laboratories')
export class LaboratoryController {
  constructor(private laboratoryService: LaboratoryService) {}

  @Post()
  @HttpCode(HttpStatus.CREATED)
  create(@Body() createLaboratoryDto: CreateLaboratoryDto) {
    return this.laboratoryService.create(createLaboratoryDto);
  }

  @Get()
  @HttpCode(HttpStatus.OK)
  findAll() {
    return this.laboratoryService.findAll();
  }

  @Get(':id')
  @HttpCode(HttpStatus.OK)
  findById(@Param('id') id: string) {
    return this.laboratoryService.findById(id);
  }

  @Put(':id')
  @HttpCode(HttpStatus.OK)
  updateById(
    @Param('id') id: string,
    @Body() updateLaboratoryDto: UpdateLaboratoryDto,
  ) {
    this.laboratoryService.updateById(id, updateLaboratoryDto);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  deleteById(@Param('id') id: string) {
    this.laboratoryService.deleteById(id);
  }
}
