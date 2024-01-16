-- CreateTable
CREATE TABLE "MessageContent" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "type" INTEGER NOT NULL DEFAULT 0,
    "text" TEXT,
    "path" TEXT
);

-- CreateTable
CREATE TABLE "PersonalMessage" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "senderId" INTEGER NOT NULL,
    "roomId" TEXT NOT NULL,
    "contentId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "PersonalMessage_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "User" ("_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "PersonalMessage_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "PersonalRoom" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "PersonalMessage_contentId_fkey" FOREIGN KEY ("contentId") REFERENCES "MessageContent" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "PersonalRoom" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "firstName" TEXT,
    "lastName" TEXT,
    "mobile" TEXT NOT NULL,
    "email" TEXT,
    "password" TEXT NOT NULL,
    "hashPassword" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "role" INTEGER NOT NULL DEFAULT 0,
    "personalRoomId" TEXT,
    CONSTRAINT "User_personalRoomId_fkey" FOREIGN KEY ("personalRoomId") REFERENCES "PersonalRoom" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_User" ("_id", "createdAt", "email", "firstName", "hashPassword", "isActive", "lastName", "mobile", "password", "role") SELECT "_id", "createdAt", "email", "firstName", "hashPassword", "isActive", "lastName", "mobile", "password", "role" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_mobile_key" ON "User"("mobile");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
