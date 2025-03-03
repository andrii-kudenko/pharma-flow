import logo from './logo.svg';
import pf_logo from './pf_logo_white.svg'
import './App.css';

import { BrowserRouter as Router, Routes, Route, Link } from "react-router-dom";
import Home from "./pages/Home";
import About from "./pages/About";

function App() {
  return (
    <Router>
      <div className='logo'>
      <img src={pf_logo} alt='logo' height={130}></img>
      </div>
      
      <nav>
        <Link to="/">Home</Link> | <Link to="/about">About</Link>
        
      </nav>

      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
      </Routes>
    </Router>
  );
}

export default App;
