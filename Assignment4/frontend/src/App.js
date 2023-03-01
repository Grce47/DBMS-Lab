import "./App.css";
// import Login from "./components/Login";
import { useState, useEffect } from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";

const url = "http://127.0.0.1:8000/";

function App() {
  const [username, setUsername] = useState("");
  const [designation, setDesignation] = useState("");

  useEffect(() => {
    fetch(url.concat("api/getinfo/"), {
      method: "GET",
    })
      .then((res) => res.json())
      .then((data) => {
        console.log("====================================");
        console.log({ data });
        console.log("====================================");
        setUsername(data.user);
        setDesignation(data.job);
      });
  }, []);



  if (username == "-1") {
    window.location.replace(url.concat("login/"));
  } else {
   
    return <div>React</div>;
  }
}

export default App;
