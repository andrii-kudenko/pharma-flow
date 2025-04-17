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
        <div style={{
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            justifyContent: 'center',
            height: '80vh',
            textAlign: 'center',
            padding: '20px'
        }}>
            <h1 style={{ fontSize: '3rem', color: '#2c3e50', marginBottom: '10px' }}>
                🚀 PharmaFlow
            </h1>
            <p style={{ fontSize: '1.25rem', color: '#555' }}>
                Your intelligent pharma distribution dashboard
            </p>
            <p style={{ fontSize: '1rem', color: '#aaa' }}>
                Monitor, manage, and make data-driven decisions
            </p>
        </div>
    );
}

export default Home;
