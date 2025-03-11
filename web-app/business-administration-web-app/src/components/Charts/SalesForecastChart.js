import React from "react";
import { Line } from "react-chartjs-2";
import { Chart as ChartJS, CategoryScale, LinearScale, PointElement, LineElement, Tooltip, Legend } from "chart.js";

ChartJS.register(CategoryScale, LinearScale, PointElement, LineElement, Tooltip, Legend);

const SalesForecastChart = ({ actualData, forecastData }) => {
  const chartData = {
    labels: actualData.map((item) => item.name),
    datasets: [
      {
        label: "Actual Sales",
        data: actualData.map((item) => item.value),
        borderColor: "blue",
        backgroundColor: "rgba(0, 123, 255, 0.2)",
        tension: 0.3,
        fill: true,
      },
      {
        label: "Forecasted Sales",
        data: forecastData.map((item) => item.value),
        borderColor: "green",
        backgroundColor: "rgba(0, 255, 0, 0.2)",
        tension: 0.3,
        fill: false,
        borderDash: [5, 5],
      },
    ],
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
      <h2 className="text-lg font-semibold mb-2">Sales Forecast</h2>
      <div className="h-72">
        <Line data={chartData} options={options} />
      </div>
    </div>
  );
};

export default SalesForecastChart;