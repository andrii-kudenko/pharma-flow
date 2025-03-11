import React from "react";
import ChartComponent from "../../components/Charts/TotalRevenueChart";
import SalesForecastChart from "../../components/Charts/SalesForecastChart";

const actualSalesData = [
    { name: "Jan", value: 300 },
    { name: "Feb", value: 450 },
    { name: "Mar", value: 500 },
    { name: "Apr", value: 700 },
    { name: "May", value: 750 },
    { name: "Jun", value: 800 },
  ];

  const forecastSalesData = [
    { name: "Jul", value: 820 },
    { name: "Aug", value: 850 },
    { name: "Sep", value: 900 },
    { name: "Oct", value: 950 },
    { name: "Nov", value: 1000 },
    { name: "Dec", value: 1100 },
  ];

const SalesForecast = () => {
  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold">Sales Forecast</h1>
      <SalesForecastChart actualData={actualSalesData} forecastData={forecastSalesData} />
    </div>
  );
};

export default SalesForecast;