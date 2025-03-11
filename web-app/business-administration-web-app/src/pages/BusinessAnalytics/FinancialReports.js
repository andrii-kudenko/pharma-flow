import React, {useState} from "react";
import ChartComponent from "../../components/Charts/TotalRevenueChart";
import {saveAs} from 'file-saver';
import Papa from 'papaparse';
import * as XLSX from 'xlsx';
import jsPDF from 'jspdf';


const FinancialReports = () => {
    const [format, setFormat] = useState('csv');
    const [dateRange, setDateRange] = useState({start: "", else: ""});

    const dummyData = [
        {id : 1, name: "John Doe", sales: 12000},
        {id : 2, name: "Jane Smith", sales: 15000},
        {id : 3, name: "Alice Johnson", sales: 10000},
    ]

    const generateCSV = () => {
        const csv = Papa.unparse(dummyData);
        const blob = new Blob([csv], {type: "text/csv"});
        saveAs(blob, "financial-report.csv");
    }

    const generateExcel = () => {
        const ws = XLSX.utils.json_to_sheet(dummyData);
        const wb = {Sheets: {data: ws}, SheetNames: ["data"]};
        const excelBuffer = XLSX.write(wb, {bookType: "xlsx", type: "array"});
        const blob = new Blob([excelBuffer], {type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"});
        saveAs(blob, "financial-report.xlsx");
    }

    const generatePDF = () => {
        const doc = new jsPDF();
        doc.text("Financial Report", 20, 20);
        dummyData.forEach((row, index) => {
            doc.text(`${row.id}. ${row.name} - $${row.sales}`, 20, 30 + (index * 10));
        });
        doc.save("financial-report.pdf");
    }

    const handleGenerateReport = () => {
        if(format === "csv") {
            generateCSV();
        } else if(format === "excel") {
            generateExcel();
        } else if(format === "pdf") {
            generatePDF();
        }
    }


  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold">Financial Reports</h1>
      <div className="mb-4">
        <label className="block mb-2 font-medium">Select Format:</label>
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
      
      <div className="mb-4">
        <label className="block mb-2 font-medium">Select Date Range:</label>
        <div className="flex gap-4">
          <input
            type="date"
            className="p-2 border rounded w-full"
            value={dateRange.start}
            onChange={(e) => setDateRange({ ...dateRange, start: e.target.value })}
          />
          <input
            type="date"
            className="p-2 border rounded w-full"
            value={dateRange.end}
            onChange={(e) => setDateRange({ ...dateRange, end: e.target.value })}
          />
        </div>
      </div>
      
      <button
        className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600"
        onClick={handleGenerateReport}
      >
        Download Report
      </button>
    </div>
  );
};

export default FinancialReports;