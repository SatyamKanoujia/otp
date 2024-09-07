const userController = require("../controllers/user.controller");
const express = require("express");
const router = express.Router();

router.post("/otpLogin",userController.otpLogin);
router.post("/verifyOTP",userController.verifyOTP);

module.exports = router;