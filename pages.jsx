import React from 'react';
import Head from 'next/head';
import Image from 'next/image';
// Utilisation de chemins d'importation relatifs pour éviter l'erreur de module non trouvé.
import HeroSection from '../components/HeroSection';
import AboutSection from '../components/AboutSection';
import RoadmapSection from '../components/RoadmapSection';
import TokenomicsSection from '../components/TokenomicsSection';
import FAQSection from '../components/FAQSection';
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
        {/* Barre de navigation - on suppose que c'est un composant séparé */}
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
