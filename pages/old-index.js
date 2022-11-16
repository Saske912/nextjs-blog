import Head from 'next/head';
import Layout, { siteTitle } from '../components/layout';
import { PrismaClient } from '@prisma/client';
import Nav from '../components/nav'

export async function getStaticProps() {
    const prisma = new PrismaClient()
    const users = await prisma.user.findMany();
    return {
        props: {
            users,
        },
    };
}

export default function Home({ allPostsData }) {
  return (
      <Nav>
        <Head>
          <title>{siteTitle}</title>
        </Head>
      </Nav>
  );
}

Home.getLayout = function getLayout(page) {
    return (
        <Layout>{page}</Layout>
    )
}