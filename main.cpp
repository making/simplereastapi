#define CPPHTTPLIB_OPENSSL_SUPPORT
#include <httplib.h>
#include <iostream>
#include <cstdlib>
#include <nlohmann/json.hpp>

using json = nlohmann::json;

int main() {
    httplib::Server svr;

    svr.Get("/", [](const httplib::Request&, httplib::Response& res) {
        json response;
        response["message"] = "Hello, World!";
        res.set_content(response.dump(), "application/json");
    });

    svr.Post("/echo", [](const httplib::Request& req, httplib::Response& res) {
        res.set_content(req.body, "application/json");
    });


    int port = std::getenv("PORT") ? std::stoi(std::getenv("PORT")) : 8080;
    std::cout << "Server is running on port " << port << "..." << std::endl;
    svr.listen("0.0.0.0", port);

    return 0;
}

