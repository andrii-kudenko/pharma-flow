import React from "react";
import { Bar } from "react-chartjs-2";
import {
    Chart as ChartJS,
    CategoryScale,
    LinearScale,
    BarElement,
    Tooltip,
    Legend,
} from "chart.js";

ChartJS.register(CategoryScale, LinearScale, BarElement, Tooltip, Legend);

const HighValueCustomersChart = ({ data, title, label, color }) => {
    const chartData = {
        labels: data.map((item) => item.key),
        datasets: [
            {
                label: `${label}`,
                data: data.map((item) => item.value),
                backgroundColor: `${color}`,
            },
        ],
    };

    return (
        <div className="p-4 bg-white shadow-md rounded-lg h-96">
            <h2 className="text-lg font-semibold mb-2">{title}</h2>
            <Bar
                data={chartData}
                options={{ responsive: true, maintainAspectRatio: false }}
            />
        </div>
    );
};

export default HighValueCustomersChart;
