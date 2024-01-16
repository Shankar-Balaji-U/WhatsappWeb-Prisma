-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Contact" (
    "mobile" TEXT NOT NULL,
    "userId" INTEGER,
    CONSTRAINT "Contact_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("_id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Contact" ("mobile") SELECT "mobile" FROM "Contact";
DROP TABLE "Contact";
ALTER TABLE "new_Contact" RENAME TO "Contact";
CREATE UNIQUE INDEX "Contact_mobile_key" ON "Contact"("mobile");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
