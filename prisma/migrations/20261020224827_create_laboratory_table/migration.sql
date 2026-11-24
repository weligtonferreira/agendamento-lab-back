/*
  Warnings:

  - You are about to drop the column `finishTime` on the `reservations` table. All the data in the column will be lost.
  - You are about to drop the column `startTime` on the `reservations` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `reservations` table. All the data in the column will be lost.
  - Added the required column `finish_time` to the `reservations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `start_time` to the `reservations` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "reservations" DROP CONSTRAINT "reservations_userId_fkey";

-- AlterTable
ALTER TABLE "reservations" DROP COLUMN "finishTime",
DROP COLUMN "startTime",
DROP COLUMN "userId",
ADD COLUMN     "finish_time" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "start_time" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "user_id" TEXT;

-- CreateTable
CREATE TABLE "laboratories" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "capacity" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "reservation_id" TEXT,

    CONSTRAINT "laboratories_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "reservations" ADD CONSTRAINT "reservations_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "laboratories" ADD CONSTRAINT "laboratories_reservation_id_fkey" FOREIGN KEY ("reservation_id") REFERENCES "reservations"("id") ON DELETE SET NULL ON UPDATE CASCADE;
