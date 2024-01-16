import { promisify } from 'util';
import { readFile as reader } from 'fs';
import { PrismaClient } from '@prisma/client';


const readFile = promisify(reader);

const prisma = new PrismaClient();

async function main() {
  const table_name = "user";
  const filePath = `./data/${table_name}.json`;
  var jsonData = await readFile(filePath, 'utf8');
  jsonData = JSON.parse(jsonData)
  
  console.log(jsonData);

  // const user = await prisma.user.create({
  //   data: {
  //     name: 'Alice',
  //     email: 'alice@prisma.io',
  //   },
  // });
  // console.log(user);

  // const users = await prisma.user.findMany();
  // console.log(users);
//   const user = await prisma.user.createMany({
//     data: []
//   });
//   console.log(user);

  // const usersWithPosts = await prisma.user.findMany({
  //   include: {
  //     posts: true,
  //   },
  // });
  // console.dir(usersWithPosts, { depth: null });
}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  });