import React from "react";
import { Line, Bar, Pie } from "react-chartjs-2";
import {
    Chart as ChartJS,
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    BarElement,
    ArcElement,
    Tooltip,
    Legend,
} from "chart.js";

ChartJS.register(
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    BarElement,
    ArcElement,
    Tooltip,
    Legend
);

const TotalRevenueChart = ({
    type,
    data,
    title,
    secondaryData,
    xAxis,
    yAxis,
}) => {
    const chartData = {
        labels: data.map((item) => item.key),
        datasets: [
            {
                label: title,
                data: data.map((item) => item.value),
                borderColor: "blue",
                backgroundColor: "rgba(0, 123, 255, 0.2)",
                tension: 0.3,
                fill: true,
            },
            secondaryData && {
                label: secondaryData.title || "Secondary Data",
                data: secondaryData.data.map((item) => item.value),
                borderColor: "red",
                backgroundColor: "rgba(255, 99, 132, 0.2)",
                tension: 0.3,
                fill: false,
            },
        ].filter(Boolean),
    };

    const options = {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                display: true,
                position: "top",
            },
            tooltip: {
                enabled: true,
            },
        },
        scales:
            type !== "pie"
                ? {
                      x: { title: { display: true, text: "Category" } },
                      y: { title: { display: true, text: "Value" } },
                  }
                : {},
    };

    const ChartTypes = {
        line: Line,
        bar: Bar,
        pie: Pie,
    };

    const ChartTag = ChartTypes[type] || Line;

    return (
        <div className="p-4 bg-white shadow-md rounded-lg">
            <h2 className="text-lg font-semibold mb-2">{title}</h2>
            <div className="h-72">
                <ChartTag data={chartData} options={options} />
            </div>
        </div>
    );
};

export default TotalRevenueChart;
