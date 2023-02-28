import "./Login.css";

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
                    <form method="post" action="">
                        <div className="inputbox">
                            <input type="text" name="username" placeholder="  USERNAME" />
                            <input type="password" name="password" placeholder="  PASSWORD" />
                            <select id="usertype" name="usertype">
                                <option > &nbsp;&nbsp;Designation</option>
                                <option value="0">Doctor</option>
                                <option value="1">Front Desk Operator</option>
                                <option value="2">Data Entry Operator</option>
                                <option value="3">Database Administrator</option>
                            </select>
                        </div>
                    </form>
                    <button>LOG IN</button>
                </div>

                <div className="signup hide">
                    <h2>SIGN UP</h2>
                    <form method="post" action="">
                        <div className="inputbox">
                            <input type="text" name="username" placeholder="  USERNAME" />
                            <input type="password" name="password" placeholder="  PASSWORD" />
                            <select id="usertype" name="usertype">
                                <option > &nbsp;&nbsp;Designation</option>
                                <option value="0">Doctor</option>
                                <option value="1">Front Desk Operator</option>
                                <option value="2">Data Entry Operator</option>
                                <option value="3">Database Administrator</option>
                            </select>
                        </div>
                    </form>
                    <button>SIGN UP</button>
                </div>
            </div>
        </div>

    );
}

export default Login;