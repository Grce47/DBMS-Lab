import "./Login.css";
import CSRFToken from "./CSRFToken";
import axios from "axios";

const server = "http://10.147.178.240:8000/";

function Login() {

    function login() {
        document.getElementsByClassName("loginMsg")[0].classList.toggle("visibility");
        document.getElementsByClassName("frontbox")[0].classList.toggle("moving");
        document.getElementsByClassName("signupMsg")[0].classList.toggle("visibility");

        document.getElementsByClassName("signup")[0].classList.toggle("hide");
        document.getElementsByClassName("login")[0].classList.toggle("hide");
    }

    function signup() {
        document.getElementsByClassName("loginMsg")[0].classList.toggle("visibility");
        document.getElementsByClassName("frontbox")[0].classList.toggle("moving");
        document.getElementsByClassName("signupMsg")[0].classList.toggle("visibility");

        document.getElementsByClassName("signup")[0].classList.toggle("hide");
        document.getElementsByClassName("login")[0].classList.toggle("hide");
    }

    function submit_signup(){
        var username = document.getElementsByName("username")[1].value;
        var password = document.getElementsByName("password")[1].value;
        var designation = document.getElementsByName("designation")[1].value;
        var data = {
            "username": username,
            "password": password,
            "designation": designation
        }
        console.log(data);
        fetch(server.concat("register/"), {
            method: "POST",
            headers: {
                "Content-type": "application/json; charset=UTF-8",
                "X-CSRFToken": getCookie("csrftoken")
            },
            body: JSON.stringify(data)
        }).then(response => response.json()).then(data => {
            if(data.hasOwnProperty("success")){
                document.getElementById("signup-msg").innerHTML = "Sign up successful";
                document.getElementById("signup-msg").style.color = "green";
            }
            else{
                document.getElementById("signup-msg").innerHTML = data["error"];
                document.getElementById("signup-msg").style.color = "red";
            }
        }).catch(error => {
            console.log(error);
        });
    }

    function getCookie(name) {
        var cookieValue = null;
        if (document.cookie && document.cookie !== '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = cookies[i].trim();
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) === (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }

    function submit_login(e){
        e.preventDefault();
        
        var username = e.target.username.value;
        var password = e.target.password.value;
        var designation = e.target.designation.value;
        var data = {
            "username": username,
            "password": password,
            "designation": designation
        }
        console.log(data);

        var csrftoken = getCookie('csrftoken');
        console.log(csrftoken);
        var headers = new Headers();
        headers.append('X-CSRFToken', csrftoken);
        headers.append('Content-Type', 'application/json');
        fetch(server.concat("login/"), {
            method: "POST",
            headers: headers,
            credentials: 'same-origin',
            body: JSON.stringify(data)
        }).then(response => response.json()).then(data => {
            if(data.hasOwnProperty("success")){
                document.getElementById("login-msg").innerHTML = "login successful";
                document.getElementById("login-msg").style.color = "green";
            }
            else{
                document.getElementById("login-msg").innerHTML = data["error"];
                document.getElementById("login-msg").style.color = "red";
            }
        }).catch(error => {
            console.log(error.headers['Set-Cookie']);
        });
    
    }

    return (
        <div className="container">
            <div className="backbox">
                <div className="loginMsg">
                    <div className="textcontent">
                        <p className="title">Don't have an account?</p>
                        <p>Sign up to save all your graph.</p>
                        <button onClick={login} id="switch1">Sign Up</button>
                    </div>
                </div>
                <div className="signupMsg visibility">
                    <div className="textcontent">
                        <p className="title">Have an account?</p>
                        <p>Log in to see all your collection.</p>
                        <button onClick={signup} id="switch2">LOG IN</button>
                    </div>
                </div>
            </div>

            <div className="frontbox">
                <div className="login">
                    <h2>LOG IN</h2>
                    <form onSubmit={e => submit_login(e)}>
                        <div className="inputbox">
                            <CSRFToken />
                            <input type="text" name="username" placeholder="  USERNAME" />
                            <input type="password" name="password" placeholder="  PASSWORD" />
                            <select name="designation">
                                <option > &nbsp;&nbsp;Designation</option>
                                <option value="0">Doctor</option>
                                <option value="1">Front Desk Operator</option>
                                <option value="2">Data Entry Operator</option>
                                <option value="3">Database Administrator</option>
                            </select>
                        </div>
                    <button type="submit">LOG IN</button>
                    </form>
                    <div id="login-msg"></div>
                </div>

                <div className="signup hide">
                    <h2>SIGN UP</h2>
                    <div className="inputbox">
                        {/* <CSRFToken /> */}
                        <input type="text" name="username" placeholder="  USERNAME" />
                        <input type="password" name="password" placeholder="  PASSWORD" />
                        <select name="designation">
                            <option > &nbsp;&nbsp;Designation</option>
                            <option value="doctor">Doctor</option>
                            <option value="front_desk_operator">Front Desk Operator</option>
                            <option value="data_entry_operator">Data Entry Operator</option>
                            <option value="database_admin">Database Administrator</option>
                        </select>
                        
                    </div>
                    <div id="signup-msg"></div>
                    <button onClick={submit_signup}>SIGN UP</button>
                </div>
            </div>
        </div>

    );
}

export default Login;