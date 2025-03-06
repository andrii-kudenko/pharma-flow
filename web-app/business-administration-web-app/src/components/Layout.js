// src/components/Layout.js
import React, { useState } from 'react';
import { FaBars, FaAngleDoubleLeft } from 'react-icons/fa';
import { Link } from 'react-router-dom';

const Layout = ({ children }) => {
  const [isSidebarOpen, setIsSidebarOpen] = useState(true);

  const toggleSidebar = () => {
    setIsSidebarOpen(!isSidebarOpen);
  };

  return (
    <div className="flex h-screen">
      <div className={`bg-gray-800 text-white ${isSidebarOpen ? 'w-64' : 'w-16'} transition-width duration-300`}>
        <div className={`flex items-center justify-between p-4 ${isSidebarOpen ? 'nav-title' : ''}`}>
          <h1 className={`${isSidebarOpen ? 'block' : 'hidden'} text-xl font-bold truncate`}>My Account</h1>
          <button id='nav-toggle-btn' onClick={toggleSidebar} className={`text-xl`}>
            {isSidebarOpen ? <FaAngleDoubleLeft /> : <FaBars />}
          </button>
        </div>
        <nav className="px-2">
          <ul className={`${isSidebarOpen ? 'opacity-100' : 'opacity-0'}`}>
            <li className={`p-2 hover:bg-gray-700 transition-opacity duration-300 ease-in-out ${isSidebarOpen ? 'opacity-100' : 'opacity-0'}`}>
              <Link to="/" className="block w-full h-full">Home</Link>
            </li>
            <li className={`p-2 hover:bg-gray-700 transition-opacity duration-300 ease-in-out ${isSidebarOpen ? 'opacity-100' : 'opacity-0'}`}>
              <Link to="/business-analytics" className="block w-full h-full truncate">Business Analytics</Link>
            </li>
            <li className={`p-2 hover:bg-gray-700 transition-opacity duration-300 ease-in-out ${isSidebarOpen ? 'opacity-100' : 'opacity-0'}`}>
              <Link to="/about" className="block w-full h-full">About</Link>
            </li>
          </ul>
        </nav>
      </div>
      <div className="flex-1 p-4 overflow-auto">
        {children}
      </div>
    </div>
  );
};

export default Layout;
