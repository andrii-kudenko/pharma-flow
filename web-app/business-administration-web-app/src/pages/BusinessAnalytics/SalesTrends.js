import React from "react";
import ChartComponent from "../../components/Charts/TotalRevenueChart";
import SalesTrendsChart from "../../components/Charts/SalesTrendsChart";

const salesData = [
    { name: "Jan", value: 300 },
    { name: "Feb", value: 450 },
    { name: "Mar", value: 500 },
    { name: "Apr", value: 700 },
    { name: "May", value: 750 },
    { name: "Jun", value: 800 },
  ];

  const projectedSalesData = {
    title: "Projected Sales",
    data: [
      { name: "Jan", value: 280 },
      { name: "Feb", value: 420 },
      { name: "Mar", value: 480 },
      { name: "Apr", value: 680 },
      { name: "May", value: 720 },
      { name: "Jun", value: 780 },
    ],
  };

const SalesTrends = () => {
  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold">Sales Trends Over Time</h1>
      <SalesTrendsChart data={salesData} secondaryData={projectedSalesData} />
    </div>
  );
};

export default SalesTrends;
