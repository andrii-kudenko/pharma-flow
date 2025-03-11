import React from "react";
import ChartComponent from "../../components/Charts/TotalRevenueChart";
import HighValueCustomersChart from "../../components/Charts/HighValueCustomersChart";


const HighValueCustomers = () => {

    const highValueCustomersData = [
        { name: "Customer A", value: 50000 },
        { name: "Customer B", value: 40000 },
        { name: "Customer C", value: 30000 },
        { name: "Customer D", value: 25000 },
        { name: "Customer E", value: 20000 },
      ];
  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold">High Value Customers</h1>
      <HighValueCustomersChart data={highValueCustomersData} />
    </div>
  );
};

export default HighValueCustomers;