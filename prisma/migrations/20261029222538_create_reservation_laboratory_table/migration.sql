/*
  Warnings:

  - You are about to drop the column `reservation_id` on the `laboratories` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "laboratories" DROP CONSTRAINT "laboratories_reservation_id_fkey";

-- AlterTable
ALTER TABLE "laboratories" DROP COLUMN "reservation_id";

-- CreateTable
CREATE TABLE "reservation_laboratory" (
    "reservationId" TEXT NOT NULL,
    "laboratoryId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reservation_laboratory_pkey" PRIMARY KEY ("reservationId","laboratoryId")
);

-- CreateTable
CREATE TABLE "_LaboratoryToReservation" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_LaboratoryToReservation_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "_LaboratoryToReservation_B_index" ON "_LaboratoryToReservation"("B");

-- AddForeignKey
ALTER TABLE "reservation_laboratory" ADD CONSTRAINT "reservation_laboratory_reservationId_fkey" FOREIGN KEY ("reservationId") REFERENCES "reservations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reservation_laboratory" ADD CONSTRAINT "reservation_laboratory_laboratoryId_fkey" FOREIGN KEY ("laboratoryId") REFERENCES "laboratories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_LaboratoryToReservation" ADD CONSTRAINT "_LaboratoryToReservation_A_fkey" FOREIGN KEY ("A") REFERENCES "laboratories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_LaboratoryToReservation" ADD CONSTRAINT "_LaboratoryToReservation_B_fkey" FOREIGN KEY ("B") REFERENCES "reservations"("id") ON DELETE CASCADE ON UPDATE CASCADE;
