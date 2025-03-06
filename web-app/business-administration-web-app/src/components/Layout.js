// src/components/Layout.js
import React, { useState } from 'react';
import { FaBars, FaTimes, FaAngleDoubleLeft } from 'react-icons/fa';

const Layout = ({ children }) => {
  const [isSidebarOpen, setIsSidebarOpen] = useState(true);

  const toggleSidebar = () => {
    setIsSidebarOpen(!isSidebarOpen);
  };

  return (
    <div className="flex h-screen">
      <div className={`bg-gray-800 text-white ${isSidebarOpen ? 'w-64' : 'w-16'} transition-width duration-300`}>
        <div className={`flex items-center justify-between p-4  ${isSidebarOpen ? 'nav-title' : ''}`}>
          <h1 className={`${isSidebarOpen ? 'block' : 'opacity-0'} text-xl font-bold`}>My</h1>
          <button id='nav-toggle-btn' onClick={toggleSidebar} className={`${isSidebarOpen ? 'block' : 'absolute'} text-xl`} >
            {isSidebarOpen ? <FaAngleDoubleLeft /> : <FaBars />}
          </button>
        </div>
        <nav className="px-2">
          <ul className={`${isSidebarOpen ? 'opacity-100' : 'opacity-0'}`}>
            <li className={`p-2 hover:bg-gray-700 transition-opacity duration-300 ease-in-out transform ${isSidebarOpen ? 'opacity-100 translate-x-0' : 'opacity-0 -translate-x-4'}`}><a href="#">Home</a></li>
            <li className={`p-2 hover:bg-gray-700 transition-opacity duration-300 ease-in-out transform ${isSidebarOpen ? 'opacity-100 translate-x-0' : 'opacity-0 -translate-x-4'}`}><a href="#">About</a></li>
            <li className={`p-2 hover:bg-gray-700 transition-opacity duration-300 ease-in-out transform ${isSidebarOpen ? 'opacity-100 translate-x-0' : 'opacity-0 -translate-x-4'}`}><a href="#">Contact</a></li>
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
