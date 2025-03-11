// src/components/Layout.js
import React, { useState } from 'react';
import { FaBars, FaAngleDoubleLeft } from 'react-icons/fa';
import { NavLink, useLocation } from 'react-router-dom';
import pf_logo from '../assets/images/pf_logo_white.svg';

const Layout = ({ children }) => {
  const [isSidebarOpen, setIsSidebarOpen] = useState(false);
  const [isSublistOpen, setIsSublistOpen] = useState(false);

  const location = useLocation();

  const toggleSidebar = () => {
    console.log(isSidebarOpen);
    setIsSidebarOpen(!isSidebarOpen);
  };

  const toggleSublist = () => {
    setIsSublistOpen(!isSublistOpen);
  };

  const getPageTitle = () => {
    switch (location.pathname) {
      case '/':
        return 'Home';
      case '/business-analytics':
        return 'Business Analytics';
      case '/inspect-sales-trends':
        return 'Inspect Sales Trends';
      case '/inspect-sales-forecast':
        return 'Inspect Sales Forecast';
      case '/inspect-total-revenue':
        return 'Inspect Total Revenue';
      case '/evaluate-high-value-customers':
        return 'Evaluate High Value Customers';
      case '/generate-financial-reports':
        return 'Generate Financial Reports';
      case '/about':
        return 'About';
      default:
        return 'Pharma Flow';
    }
  };

  return (
    <div className="flex h-screen">
      {/* Sidebar */}
      <div className={`fixed inset-y-0 left-0 bg-gray-800 text-white transform ${isSidebarOpen ? 'translate-x-0 md:w-58' : '-translate-x-full md:w-16'} md:relative md:translate-x-0 transition-width transition-transform duration-300 ease-in-out z-50`}>
        <div className="flex items-center justify-between p-4 h-20">
          <h1 className={`${isSidebarOpen ? 'block' : 'hidden'} text-xl font-bold truncate`}>My Account</h1>
          <button id='nav-toggle-btn' onClick={toggleSidebar} className="text-xl">
            {isSidebarOpen ? <FaAngleDoubleLeft /> : <FaBars className='hidden md:block'/> }
            
          </button>
        </div>
        <nav className="pl-2">
          <ul className={`${isSidebarOpen? 'opacity-100' : 'hidden'} transition-opacity duration-300 ease-in-out`}>
            <li className="hover:bg-gray-700 transition-opacity duration-300 ease-in-out">
              <NavLink to="/" className="block w-full h-full p-4" activeClassName="bg-gray-900">Home</NavLink>
            </li>
            <li className="hover:bg-gray-700 transition-opacity duration-300 ease-in-out">
              <button onClick={toggleSublist} className="block w-full h-full p-4 text-left">Business Analytics</button>
              {isSublistOpen && (
                <ul className="pl-4">
                  <li className="hover:bg-gray-700 transition-opacity duration-300 ease-in-out">
                    <NavLink to="/inspect-sales-trends" className="block w-full h-full p-4" activeClassName="bg-gray-900">Inspect Sales Trends</NavLink>
                  </li>
                  <li className="hover:bg-gray-700 transition-opacity duration-300 ease-in-out">
                    <NavLink to="/inspect-sales-forecast" className="block w-full h-full p-4" activeClassName="bg-gray-900">Inspect Sales Forecast</NavLink>
                  </li>
                  <li className="hover:bg-gray-700 transition-opacity duration-300 ease-in-out">
                    <NavLink to="/inspect-total-revenue" className="block w-full h-full p-4" activeClassName="bg-gray-900">Inspect Total Revenue</NavLink>
                  </li>
                  <li className="hover:bg-gray-700 transition-opacity duration-300 ease-in-out">
                    <NavLink to="/evaluate-high-value-customers" className="block w-full h-full p-4" activeClassName="bg-gray-900">Evaluate High Value Customers</NavLink>
                  </li>
                  <li className="hover:bg-gray-700 transition-opacity duration-300 ease-in-out">
                    <NavLink to="/generate-financial-reports" className="block w-full h-full p-4" activeClassName="bg-gray-900">Generate Financial Reports</NavLink>
                  </li>
                </ul>
              )}
            </li>
            <li className="hover:bg-gray-700 transition-opacity duration-300 ease-in-out">
              <NavLink to="/about" className="block w-full h-full p-4" activeClassName="bg-gray-900">About</NavLink>
            </li>
          </ul>
        </nav>
      </div>

      {/* Main content */}
      <div className="flex-1 overflow-auto">
        <div className="flex items-center justify-center md:justify-between bg-gray-800 p-2 h-20">
          <button id='nav-toggle-btn' onClick={toggleSidebar} className="text-xl md:hidden absolute left-2">
            <FaBars />
          </button>
          <h1 className="text-2xl text-white font-bold">{getPageTitle()}</h1>
          <img src={pf_logo} alt='logo' className='h-10 absolute right-2 md:relative'></img>
        </div>
        <div className='p-2'>
          {children}
        </div>
      </div>
    </div>
  );
};

export default Layout;
