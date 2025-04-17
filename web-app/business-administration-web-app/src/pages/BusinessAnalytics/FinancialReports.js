import React, { useEffect, useState } from "react";
import ChartComponent from "../../components/Charts/TotalRevenueChart";
import { saveAs } from "file-saver";
import Papa from "papaparse";
import * as XLSX from "xlsx";
import jsPDF from "jspdf";

const FinancialReports = () => {
    const [format, setFormat] = useState("csv");
    const [dateRange, setDateRange] = useState({ start: "", else: "" });
    const [report, setReport] = useState(null);
    const [loading, setLoading] = useState(false);
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
            const reportResponse = await fetch(
                `http://localhost:5062/financial-report?year=${year}`
            );
            if (!reportResponse.ok)
                throw new Error("Failed to fetch financial report data");
            const reportData = await reportResponse.json();
            setReport(reportData);
            console.log("Financial Report Data:", reportData);
        } catch (error) {
            console.error("Error fetching data:", error);
        } finally {
            setLoading(false); // Set loading to false after data is fetched
        }
    };

    useEffect(() => {
        fetchData();
    }, []); // Fetch data on component mount

    const dummyData = [
        { id: 1, name: "John Doe", sales: 12000 },
        { id: 2, name: "Jane Smith", sales: 15000 },
        { id: 3, name: "Alice Johnson", sales: 10000 },
    ];

    const generateCSV = () => {
        if (!report) return;

        const rows = [
            {
                section: "Summary",
                label: "Total Revenue",
                value: report.totalRevenue,
            },
            {
                section: "Summary",
                label: "Total Orders",
                value: report.totalOrders,
            },
            {
                section: "Summary",
                label: "Average Order Value",
                value: report.averageOrderValue,
            },
            {
                section: "Summary",
                label: "Items Sold",
                value: report.itemsSold,
            },
            {
                section: "Top Customer",
                label: "Name",
                value: report.topCustomer?.name,
            },
            {
                section: "Top Customer",
                label: "Total Spent",
                value: report.topCustomer?.totalSpent,
            },
            ...report.monthlyRevenue.map((m) => ({
                section: "Monthly Revenue",
                label: `Month ${m.key}`,
                value: m.value,
            })),
            ...report.topItems.map((item) => ({
                section: "Top Items",
                label: item.codeName,
                value: `Qty: ${item.quantity}, Rev: $${item.revenue}`,
            })),
        ];

        const csv = Papa.unparse(rows);
        const blob = new Blob([csv], { type: "text/csv" });
        saveAs(blob, `financial-report-${year}.csv`);
    };

    const generateExcel = () => {
        const rows = [
            {
                section: "Summary",
                label: "Total Revenue",
                value: report.totalRevenue,
            },
            {
                section: "Summary",
                label: "Total Orders",
                value: report.totalOrders,
            },
            {
                section: "Summary",
                label: "Average Order Value",
                value: report.averageOrderValue,
            },
            {
                section: "Summary",
                label: "Items Sold",
                value: report.itemsSold,
            },
            {
                section: "Top Customer",
                label: "Name",
                value: report.topCustomer?.name,
            },
            {
                section: "Top Customer",
                label: "Total Spent",
                value: report.topCustomer?.totalSpent,
            },
            ...report.monthlyRevenue.map((m) => ({
                section: "Monthly Revenue",
                label: `Month ${m.key}`,
                value: m.value,
            })),
            ...report.topItems.map((item) => ({
                section: "Top Items",
                label: item.codeName,
                value: `Qty: ${item.quantity}, Rev: $${item.revenue}`,
            })),
        ];

        const ws = XLSX.utils.json_to_sheet(rows); // from same logic as above
        const wb = { Sheets: { data: ws }, SheetNames: ["data"] };
        const excelBuffer = XLSX.write(wb, { bookType: "xlsx", type: "array" });
        const blob = new Blob([excelBuffer], {
            type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        });
        saveAs(blob, `financial-report-${year}.xlsx`);
    };

    const generatePDF = () => {
        if (!report) return;

        const doc = new jsPDF();
        doc.setFontSize(16);
        doc.text("Financial Report", 20, 20);

        let y = 30;
        doc.setFontSize(12);
        doc.text(`Total Revenue: $${report.totalRevenue}`, 20, (y += 10));
        doc.text(`Total Orders: ${report.totalOrders}`, 20, (y += 10));
        doc.text(
            `Average Order Value: $${report.averageOrderValue.toFixed(2)}`,
            20,
            (y += 10)
        );
        doc.text(`Items Sold: ${report.itemsSold}`, 20, (y += 10));

        if (report.topCustomer) {
            doc.text(
                `Top Customer: ${report.topCustomer.name} ($${report.topCustomer.totalSpent})`,
                20,
                (y += 10)
            );
        }

        doc.text("Monthly Revenue:", 20, (y += 15));
        report.monthlyRevenue.forEach((m) => {
            doc.text(`Month ${m.key}: $${m.value}`, 30, (y += 8));
        });

        doc.text("Top Items:", 20, (y += 15));
        report.topItems.forEach((item) => {
            doc.text(
                `${item.codeName}: ${item.quantity} units - $${item.revenue}`,
                30,
                (y += 8)
            );
        });

        doc.save(`financial-report-${year}.pdf`);
    };

    const handleGenerateReport = () => {
        if (format === "csv") {
            generateCSV();
        } else if (format === "excel") {
            generateExcel();
        } else if (format === "pdf") {
            generatePDF();
        }
    };

    return (
        <div className="p-6">
            <h2 className="text-2xl font-bold relative">
                Financial Reports
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
                    <div className="mb-4">
                        <h3 className="block mt-2 font-bold text-lg">
                            Report Ready ✅{" "}
                        </h3>
                        <label className="block mb-2 font-medium">
                            Select Format:
                        </label>
                        <select
                            className="p-2 border rounded w-full"
                            value={format}
                            onChange={(e) => setFormat(e.target.value)}
                        >
                            <option value="csv">CSV</option>
                            <option value="excel">Excel</option>
                            <option value="pdf">PDF</option>
                        </select>
                    </div>

                    {/* <div className="mb-4">
                        <label className="block mb-2 font-medium">
                            Select Date Range:
                        </label>
                        <div className="flex gap-4">
                            <input
                                type="date"
                                className="p-2 border rounded w-full"
                                value={dateRange.start}
                                onChange={(e) =>
                                    setDateRange({
                                        ...dateRange,
                                        start: e.target.value,
                                    })
                                }
                            />
                            <input
                                type="date"
                                className="p-2 border rounded w-full"
                                value={dateRange.end}
                                onChange={(e) =>
                                    setDateRange({
                                        ...dateRange,
                                        end: e.target.value,
                                    })
                                }
                            />
                        </div>
                    </div> */}

                    <button
                        className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600"
                        onClick={handleGenerateReport}
                    >
                        Download Report
                    </button>
                </>
            )}
        </div>
    );
};

export default FinancialReports;
