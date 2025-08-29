// C'est le composant principal qui affiche votre page d'accueil.
import React from 'react';
import Head from 'next/head';
import Image from 'next/image';
import HeroSection from '../components/HeroSection';
import AboutSection from '../components/AboutSection';
import RoadmapSection from '../components/RoadmapSection'; // Changement ici
import TokenomicsSection from '../components/TokenomicsSection';
import FAQSection from '../components/FAQSection'; // Changement ici
import SocialSection from '../components/SocialSection';
import Footer from '../components/Footer';

const HomePage = () => {
  return (
    <>
      <Head>
        <title>MAWA - The People's Coin</title>
        <meta name="description" content="MAWA - The People's Coin on Solana" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <div className="bg-gray-900 text-white min-h-screen font-sans">
        {/* Navigation Bar - Assuming a separate component */}
        {/* <Navbar /> */}

        <main>
          <HeroSection />
          <AboutSection />
          <RoadmapSection />
          <TokenomicsSection />
          <FAQSection />
          <SocialSection />
        </main>

        <Footer />
      </div>
    </>
  );
};

export default HomePage;
