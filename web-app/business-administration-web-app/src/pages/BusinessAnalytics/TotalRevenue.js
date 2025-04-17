import React, { useEffect, useState } from "react";
import TotalRevenueChart from "../../components/Charts/TotalRevenueChart";

const TotalRevenue = () => {
    const [monthlyRevenue, setMonthlyRevenue] = useState([]);
    const [topFiveProducts, setTopFiveProducts] = useState([]);
    const [revenueBreakdownProducts, setRevenueBreakdownProducts] = useState(
        []
    );
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
            const revenueResponse = await fetch(
                `http://localhost:5062/monthly-revenue?year=${year}`
            );
            if (!revenueResponse.ok)
                throw new Error("Failed to fetch monthly revenue data");
            const revenueData = await revenueResponse.json();
            setMonthlyRevenue(revenueData);

            // Fetch data for the second chart
            const revenueBreakdownResponse = await fetch(
                `http://localhost:5062/top-items?year=${year}&top=5`
            );
            if (!revenueBreakdownResponse.ok)
                throw new Error("Failed to fetch top selling data");
            const revenueBreakdownData = await revenueBreakdownResponse.json();
            const topFiveProducts = revenueBreakdownData.slice(0, 5); // Take the first 5 records
            console.log("Top Five Products:", topFiveProducts);
            setTopFiveProducts(topFiveProducts); // Update state with the top 5 products
            setRevenueBreakdownProducts(revenueBreakdownData);
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
            { month: "Jan", value: 10000 },
            { month: "Feb", value: 14000 },
            { month: "Mar", value: 16000 },
            { month: "Apr", value: 21000 },
            { month: "May", value: 24000 },
            { month: "Jun", value: 26000 },
        ],
    };

    const productSalesData = [
        { month: "Product A", value: 5000 },
        { month: "Product B", value: 12000 },
        { month: "Product C", value: 8000 },
        { month: "Product D", value: 15000 },
        { month: "Product E", value: 10000 },
    ];

    const revenueBreakdownData = [
        { month: "Subscriptions", value: 40000 },
        { month: "One-time Purchases", value: 25000 },
        { month: "Enterprise Sales", value: 15000 },
    ];

    return (
        <div className="p-6">
            <h2 className="text-xl font-bold mb-4 relative">
                Inspect Total Revenue
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
                <p>Loading...</p> // Display a loading indicator while data is being fetched
            ) : (
                <>
                    <TotalRevenueChart
                        type="line"
                        data={monthlyRevenue}
                        title="Revenue Trends"
                    />{" "}
                    <TotalRevenueChart
                        type="bar"
                        data={topFiveProducts}
                        title="Top-Selling Products"
                    />
                    <TotalRevenueChart
                        type="pie"
                        data={revenueBreakdownProducts}
                        title="Revenue Breakdown"
                    />
                </>
            )}
        </div>
    );
};

export default TotalRevenue;
