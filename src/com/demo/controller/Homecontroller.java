package com.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Homecontroller {

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("message", "Hello Spring MVC from VS Code + Tomcat 9!!!");
        return "home";
    }
}
