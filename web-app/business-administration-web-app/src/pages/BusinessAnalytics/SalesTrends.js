import React, { useEffect, useState } from "react";
import ChartComponent from "../../components/Charts/TotalRevenueChart";
import SalesTrendsChart from "../../components/Charts/SalesTrendsChart";
import TotalRevenueChart from "../../components/Charts/TotalRevenueChart";

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
    const [monthlySales, setMonthlySales] = useState([]);
    const [topFiveProducts, setTopFiveProducts] = useState([]);
    const [salesBreakdownProducts, setSalesBreakdownProducts] = useState([]);
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
            const salesResponse = await fetch(
                `http://localhost:5062/monthly-quantity?year=${year}`
            );
            if (!salesResponse.ok)
                throw new Error("Failed to fetch monthly revenue data");
            const salesData = await salesResponse.json();
            setMonthlySales(salesData);

            // Fetch data for the second chart
            const salesBreakdownResponse = await fetch(
                `http://localhost:5062/top-items-quantity?year=${year}&top=5`
            );
            if (!salesBreakdownResponse.ok)
                throw new Error("Failed to fetch top selling data");
            const salesBreakdownData = await salesBreakdownResponse.json();
            const topFiveProducts = salesBreakdownData.slice(0, 5); // Take the first 5 records
            console.log("Top Five Products:", topFiveProducts);
            setTopFiveProducts(topFiveProducts); // Update state with the top 5 products
            setSalesBreakdownProducts(salesBreakdownData);
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
                Sales Trends Over Time{" "}
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
                    <SalesTrendsChart data={monthlySales} />
                    <br />
                    <TotalRevenueChart
                        type="bar"
                        data={topFiveProducts}
                        title="Most Bought Products"
                    />
                    <br />
                    <TotalRevenueChart
                        type="pie"
                        data={salesBreakdownProducts}
                        title="Sales Breakdown"
                    />
                </>
            )}
        </div>
    );
};

export default SalesTrends;
