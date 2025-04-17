import React, { useEffect, useState } from "react";
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
    const [monthlySales, setMonthlySales] = useState([]);
    const [loading, setLoading] = useState(true);
    const [year, setYear] = useState("2025"); // State to store the selected year

    const handleYearChange = (event) => {
        setYear(event.target.value); // Update state when a new year is selected
        console.log("Selected year:", event.target.value);
        fetchData(event.target.value); // Fetch data for the selected year
    };

    const fetchData = async (year = 2025) => {
        fetch(`http://localhost:5062/monthly-revenue?year=${year}`)
            .then((response) => {
                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }
                return response.json();
            })
            .then((jsonData) => {
                setMonthlySales(jsonData);
                console.log(jsonData);
                console.log(salesData);
            })
            .catch((error) => {
                console.error("Error fetching data:", error);
            })
            .finally(() => {
                setLoading(false); // Set loading to false after data is fetched
            });
    };

    // Use useEffect to trigger fetchData on page load
    useEffect(() => {
        fetchData();
    }, []); // Empty dependency array ensures it runs only once

    return (
        <div className="p-6">
            <h2 className="text-2xl font-bold relative">
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
                <SalesTrendsChart data={monthlySales} /> // Render the chart once data is ready
            )}
        </div>
    );
};

export default SalesTrends;
