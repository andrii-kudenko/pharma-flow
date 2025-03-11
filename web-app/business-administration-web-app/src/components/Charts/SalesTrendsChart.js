import React from "react";
import { Line } from "react-chartjs-2";
import { Chart as ChartJS, CategoryScale, LinearScale, PointElement, LineElement, Tooltip, Legend } from "chart.js";

ChartJS.register(CategoryScale, LinearScale, PointElement, LineElement, Tooltip, Legend);

const SalesTrendsChart = ({ data, secondaryData }) => {
  const chartData = {
    labels: data.map((item) => item.name),
    datasets: [
      {
        label: "Sales Volume",
        data: data.map((item) => item.value),
        borderColor: "blue",
        backgroundColor: "rgba(0, 123, 255, 0.2)",
        tension: 0.3,
        fill: true,
      },
      secondaryData && {
        label: secondaryData.title || "Projected Sales",
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
    scales: {
      x: { title: { display: true, text: "Time" } },
      y: { title: { display: true, text: "Units Sold" } },
    },
  };

  return (
    <div className="p-4 bg-white shadow-md rounded-lg">
      <h2 className="text-lg font-semibold mb-2">Sales Trends</h2>
      <div className="h-72">
        <Line data={chartData} options={options} />
      </div>
    </div>
  );
};

export default SalesTrendsChart;