import "./App.css";
import VM from "./assets/Virtual-Machine.svg";
import Azure from "./assets/Microsoft_Azure.svg";

function App() {
  return (
    <>
      <div>
        <h1>
          Running webpage in&nbsp;
          <img src={VM} alt="Azure" width={50} />
          &nbsp;<span style={{ color: "lightblue" }}>Azure</span> using&nbsp;
          <img src={Azure} alt="VM" width={50} />
          &nbsp;<span style={{ color: "orange" }}>Virtual Machine</span>
        </h1>
      </div>
    </>
  );
}

export default App;
