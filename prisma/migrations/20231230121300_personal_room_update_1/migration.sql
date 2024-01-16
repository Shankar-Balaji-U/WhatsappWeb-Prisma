/*
  Warnings:

  - You are about to drop the `MessageContent` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `contentId` on the `PersonalMessage` table. All the data in the column will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "MessageContent";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "PersonalMessageContent" (
    "messageId" TEXT NOT NULL PRIMARY KEY,
    "type" INTEGER NOT NULL DEFAULT 0,
    "text" TEXT,
    "path" TEXT,
    CONSTRAINT "PersonalMessageContent_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES "PersonalMessage" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_PersonalMessage" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "senderId" INTEGER NOT NULL,
    "roomId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "PersonalMessage_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "User" ("_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "PersonalMessage_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "PersonalRoom" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_PersonalMessage" ("createdAt", "id", "roomId", "senderId", "updatedAt") SELECT "createdAt", "id", "roomId", "senderId", "updatedAt" FROM "PersonalMessage";
DROP TABLE "PersonalMessage";
ALTER TABLE "new_PersonalMessage" RENAME TO "PersonalMessage";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
