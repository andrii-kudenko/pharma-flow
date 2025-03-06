import React from 'react';
import Layout from './components/Layout';
import pf_logo from './assets/images/pf_logo_white.svg'
import './assets/styles/App.css'
import './assets/styles/tailwind.css'
import { useState } from 'react';
import LoadingScreen from './components/LoadingScreen';

import { BrowserRouter as Router, Routes, Route, Link } from "react-router-dom";
import Home from "./pages/Home";
import About from "./pages/About";
import BusinessAnalytics from './pages/BusinessAnalytics';

function App() {
  const [isLoaded, setIsLoaded] = useState(false)
  return (
    <>
      {!isLoaded && <LoadingScreen onFinish={() => setIsLoaded(true)} />}
      {isLoaded && <HomePage />}
    </>
  )
}

const HomePage = () => (
  <Router>
    <Layout>
      <Routes>        
        <Route path="/" element={<Home/>} />
        <Route path="/business-analytics" element={<BusinessAnalytics/>} />
        <Route path="/about" element={<About/>} />
      </Routes>
    </Layout>
  </Router>  
);

export default App;


{/* <div className='logo'>
    <img src={pf_logo} alt='logo' className='h-30'></img>
</div>
<Router>
    <nav>
      <Link to="/" className='text-3xl'>Home</Link> | <Link to="/about">About</Link>
      
    </nav>

    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/about" element={<About />} />
    </Routes>
  </Router>
*/}