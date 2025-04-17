function Home() {
    const fetchData = async () => {
        fetch("http://localhost:5062/monthly-revenue?year=2025")
            .then((response) => {
                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }
                return response.json();
            })
            .then((jsonData) => {
                console.log(jsonData);
            });
    };

    return (
        <div>
            <h1>Pharma Flow</h1>
            <p>Welcome to the homepage!</p>
            <button
                className="bg-blue-500 text-white px-4 py-2 rounded"
                onClick={fetchData}
            >
                Test API
            </button>
        </div>
    );
}

export default Home;
