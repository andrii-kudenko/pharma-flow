import React from "react";
import ChartComponent from "../components/Charts/TotalRevenueChart";

const revenueData = [
  { name: "Jan", value: 50000 },
  { name: "Feb", value: 55000 },
  { name: "Mar", value: 48000 },
];

const customerData = [
  { name: "Customer A", value: 12000 },
  { name: "Customer B", value: 9500 },
  { name: "Customer C", value: 8700 },
];

const productCategoryData = [
  { name: "Medical Equipment", value: 40 },
  { name: "Pharmaceuticals", value: 35 },
  { name: "Lab Supplies", value: 15 },
  { name: "Other", value: 10 },
];

const Dashboard = () => {
  return (
    <div className="p-6 space-y-6">
      <h1 className="text-2xl font-bold">Business Analytics Dashboard</h1>
      <ChartComponent data={revenueData} title="Monthly Sales Revenue" />
      <ChartComponent data={customerData} title="Top Spending Customers" />
      <ChartComponent data={productCategoryData} title="Revenue by Product Category" />
    </div>
  );
};

export default Dashboard;