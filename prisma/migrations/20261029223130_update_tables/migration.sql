/*
  Warnings:

  - You are about to drop the column `createdAt` on the `laboratories` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `laboratories` table. All the data in the column will be lost.
  - The primary key for the `reservation_laboratory` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `createdAt` on the `reservation_laboratory` table. All the data in the column will be lost.
  - You are about to drop the column `laboratoryId` on the `reservation_laboratory` table. All the data in the column will be lost.
  - You are about to drop the column `reservationId` on the `reservation_laboratory` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `reservation_laboratory` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `reservations` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `reservations` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `users` table. All the data in the column will be lost.
  - Added the required column `updated_at` to the `laboratories` table without a default value. This is not possible if the table is not empty.
  - Added the required column `laboratory_id` to the `reservation_laboratory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `reservation_id` to the `reservation_laboratory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `reservation_laboratory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `reservations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "reservation_laboratory" DROP CONSTRAINT "reservation_laboratory_laboratoryId_fkey";

-- DropForeignKey
ALTER TABLE "reservation_laboratory" DROP CONSTRAINT "reservation_laboratory_reservationId_fkey";

-- AlterTable
ALTER TABLE "laboratories" DROP COLUMN "createdAt",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "reservation_laboratory" DROP CONSTRAINT "reservation_laboratory_pkey",
DROP COLUMN "createdAt",
DROP COLUMN "laboratoryId",
DROP COLUMN "reservationId",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "laboratory_id" TEXT NOT NULL,
ADD COLUMN     "reservation_id" TEXT NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL,
ADD CONSTRAINT "reservation_laboratory_pkey" PRIMARY KEY ("reservation_id", "laboratory_id");

-- AlterTable
ALTER TABLE "reservations" DROP COLUMN "createdAt",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "users" DROP COLUMN "createdAt",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AddForeignKey
ALTER TABLE "reservation_laboratory" ADD CONSTRAINT "reservation_laboratory_reservation_id_fkey" FOREIGN KEY ("reservation_id") REFERENCES "reservations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reservation_laboratory" ADD CONSTRAINT "reservation_laboratory_laboratory_id_fkey" FOREIGN KEY ("laboratory_id") REFERENCES "laboratories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
