import React, { useState, useEffect } from "react";
import ChartComponent from "../../components/Charts/TotalRevenueChart";
import HighValueCustomersChart from "../../components/Charts/HighValueCustomersChart";
import { title } from "framer-motion/client";

const HighValueCustomers = () => {
    const highValueCustomersData = [
        { name: "Customer A", value: 50000 },
        { name: "Customer B", value: 40000 },
        { name: "Customer C", value: 30000 },
        { name: "Customer D", value: 25000 },
        { name: "Customer E", value: 20000 },
    ];
    const [data, setData] = useState([]);
    const [ordersByCompany, setOrdersByCompany] = useState([]);
    const [spendingByCompany, setSpendingByCompany] = useState([]);
    const [loading, setLoading] = useState(true);
    const [year, setYear] = useState("2025"); // State to store the selected year

    const handleYearChange = (event) => {
        setYear(event.target.value); // Update state when a new year is selected
        console.log("Selected year:", event.target.value);
        fetchData(event.target.value); // Fetch data for the selected year
    };
    const fetchData = async (year = 2025) => {
        setLoading(true); // Set loading to true before fetching data
        try {
            // Fetch data for the first chart
            const customerResponse = await fetch(
                `http://localhost:5062/high-value-cutomers?year=${year}`
            );
            if (!customerResponse.ok)
                throw new Error("Failed to fetch monthly revenue data");
            const customerData = await customerResponse.json();
            setData(customerData);
            const ordersData = customerData.map((c) => ({
                key: c.companyName,
                value: c.ordersCount,
            }));
            const spendingData = customerData
                .map((c) => ({
                    key: c.companyName,
                    value: c.totalSpent,
                }))
                .sort((a, b) => b.totalSpent - a.totalSpent); // sort by revenue
            console.log("Orders by Company:", ordersData);
            console.log("Spending by Company:", spendingData);
            setOrdersByCompany(ordersData);
            setSpendingByCompany(spendingData);
        } catch (error) {
            console.error("Error fetching data:", error);
        } finally {
            setLoading(false); // Set loading to false after data is fetched
        }
    };
    // Use useEffect to trigger fetchData on page load
    useEffect(() => {
        fetchData();
    }, []); // Empty dependency array ensures it runs only once
    return (
        <div className="p-6">
            <h2 className="text-2xl font-bold mb-4 relative">
                High Value Customers
                <div className="absolute top-4 right-4">
                    <label for="year-select">Select a Year:</label>
                    <select
                        id="year-select"
                        value={year} // Bind the state value to the select input
                        onChange={handleYearChange} // Handle changes to update state
                        name="year"
                    >
                        <option value="2024">2024</option>
                        <option value="2025">2025</option>
                    </select>
                </div>
            </h2>

            {loading ? (
                <p>Loading...</p>
            ) : (
                <>
                    <HighValueCustomersChart
                        data={ordersByCompany}
                        title="By number of orders"
                        label="# of Orders"
                        color="rgba(121, 157, 236, 0.96)"
                    />
                    <br />
                    <HighValueCustomersChart
                        data={spendingByCompany}
                        title="By revenue"
                        label="Total amount $"
                        color="rgba(7, 98, 5, 0.96)"
                    />
                </>
            )}
        </div>
    );
};

export default HighValueCustomers;
