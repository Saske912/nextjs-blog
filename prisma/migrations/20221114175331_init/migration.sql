-- CreateEnum
CREATE TYPE "image_status_enum" AS ENUM ('published', 'creating');

-- CreateEnum
CREATE TYPE "plant_status_enum" AS ENUM ('published', 'updating', 'creating', 'inBucket', 'inOrder', 'delivered');

-- CreateEnum
CREATE TYPE "post_status_enum" AS ENUM ('published', 'creating', 'moderating');

-- CreateEnum
CREATE TYPE "user_roles_enum" AS ENUM ('client', 'seller');

-- CreateTable
CREATE TABLE "image" (
    "created" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(6),
    "id" SERIAL NOT NULL,
    "filename" VARCHAR NOT NULL,
    "path" VARCHAR NOT NULL,
    "mimetype" VARCHAR NOT NULL,
    "userID" INTEGER,
    "postID" INTEGER,
    "plantID" INTEGER,
    "imageSource" VARCHAR,
    "status" "image_status_enum" NOT NULL DEFAULT 'creating',

    CONSTRAINT "PK_d6db1ab4ee9ad9dbe86c64e4cc3" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "plant" (
    "created" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(6),
    "id" SERIAL NOT NULL,
    "title" VARCHAR,
    "price" INTEGER,
    "description" VARCHAR,
    "sellerID" INTEGER NOT NULL,
    "status" "plant_status_enum" NOT NULL DEFAULT 'creating',
    "clientID" INTEGER,
    "count" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "PK_97e1eb0d045aadea59401ece5ba" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "post" (
    "created" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(6),
    "id" SERIAL NOT NULL,
    "text" VARCHAR,
    "authorID" INTEGER NOT NULL,
    "status" "post_status_enum" NOT NULL DEFAULT 'creating',
    "commentedUserID" INTEGER,
    "commentedPlantID" INTEGER,

    CONSTRAINT "PK_be5fda3aac270b134ff9c21cdee" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "email" TEXT,
    "emailVerified" TIMESTAMP(3),
    "image" TEXT,
    "created" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(6),
    "password" VARCHAR,
    "phoneNumber" INTEGER,
    "firstName" VARCHAR,
    "lastName" VARCHAR,
    "roles" "user_roles_enum"[] DEFAULT ARRAY[]::"user_roles_enum"[],

    CONSTRAINT "PK_cace4a159ff9f2512dd42373760" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Account" (
    "id" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "providerAccountId" TEXT NOT NULL,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "token_type" TEXT,
    "scope" TEXT,
    "id_token" TEXT,
    "session_state" TEXT,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Session" (
    "id" TEXT NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VerificationToken" (
    "identifier" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "REL_fc1e5cd7576b718c143d04c7e2" ON "image"("userID");

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "UQ_f2578043e491921209f5dadd080" ON "user"("phoneNumber");

-- CreateIndex
CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON "Account"("provider", "providerAccountId");

-- CreateIndex
CREATE UNIQUE INDEX "Session_sessionToken_key" ON "Session"("sessionToken");

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_token_key" ON "VerificationToken"("token");

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_identifier_token_key" ON "VerificationToken"("identifier", "token");

-- AddForeignKey
ALTER TABLE "image" ADD CONSTRAINT "FK_6e5b050dcb332ab56adbcf3f7d1" FOREIGN KEY ("plantID") REFERENCES "plant"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "image" ADD CONSTRAINT "FK_ff720d9d676712e11e0065a9b54" FOREIGN KEY ("postID") REFERENCES "post"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "plant" ADD CONSTRAINT "FK_a007946009348f879bcca4b5f9c" FOREIGN KEY ("sellerID") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "plant" ADD CONSTRAINT "FK_f9cdccc067183040fc47688d748" FOREIGN KEY ("clientID") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "post" ADD CONSTRAINT "FK_087c691364791a2171ab15a6707" FOREIGN KEY ("commentedPlantID") REFERENCES "plant"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "post" ADD CONSTRAINT "FK_2d82c4a1da8536f1dde0a75b8cc" FOREIGN KEY ("authorID") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "post" ADD CONSTRAINT "FK_b0a61573ce14285d3286c9b9a8b" FOREIGN KEY ("commentedUserID") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;
