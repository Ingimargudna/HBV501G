package hbv501g.folf;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {
    @GetMapping("../XMLFiles/login")
    public String showForm(){
        return "placeholder";
    }
}