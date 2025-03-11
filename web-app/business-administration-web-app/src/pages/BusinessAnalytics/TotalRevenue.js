import React from "react";
import TotalRevenueChart from "../../components/Charts/TotalRevenueChart";

const TotalRevenue = () => {
    const revenueData = [
        { name: "Jan", value: 12000 },
        { name: "Feb", value: 15000 },
        { name: "Mar", value: 18000 },
        { name: "Apr", value: 22000 },
        { name: "May", value: 25000 },
        { name: "Jun", value: 27000 },
      ];

      const secondaryRevenueData = {
        title: "Projected Revenue",
        data: [
          { name: "Jan", value: 10000 },
          { name: "Feb", value: 14000 },
          { name: "Mar", value: 16000 },
          { name: "Apr", value: 21000 },
          { name: "May", value: 24000 },
          { name: "Jun", value: 26000 },
        ],
      };
    
      const productSalesData = [
        { name: "Product A", value: 5000 },
        { name: "Product B", value: 12000 },
        { name: "Product C", value: 8000 },
        { name: "Product D", value: 15000 },
        { name: "Product E", value: 10000 },
      ];
    
      const revenueBreakdownData = [
        { name: "Subscriptions", value: 40000 },
        { name: "One-time Purchases", value: 25000 },
        { name: "Enterprise Sales", value: 15000 },
      ];
    
      return (
        <div className="p-6">
          <h2 className="text-xl font-bold mb-4">Inspect Total Revenue</h2>
          <TotalRevenueChart type="line" data={revenueData} secondaryData={secondaryRevenueData} title="Revenue Trends" />
          <TotalRevenueChart type="bar" data={productSalesData} title="Top-Selling Products" />
          <TotalRevenueChart type="pie" data={revenueBreakdownData} title="Revenue Breakdown" />
        </div>
      );
};

export default TotalRevenue;