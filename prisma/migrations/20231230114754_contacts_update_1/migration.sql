/*
  Warnings:

  - You are about to drop the column `userId` on the `Contact` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Contact" (
    "mobile" TEXT NOT NULL
);
INSERT INTO "new_Contact" ("mobile") SELECT "mobile" FROM "Contact";
DROP TABLE "Contact";
ALTER TABLE "new_Contact" RENAME TO "Contact";
CREATE UNIQUE INDEX "Contact_mobile_key" ON "Contact"("mobile");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
