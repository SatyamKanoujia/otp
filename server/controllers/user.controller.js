const bcryptjs=require('bcryptjs');
const userServices = require("../services/users.services");

exports.otpLogin = (req,res,next)=>{
    userServices.createOtp(req.body,(error,results)=>{
        if(error){
            return next(error);
        }
        return res.status(200).send({
            message:"Success",
            data: results
        })
    });
};

exports.verifyOTP = (req,res,next)=>{
    userServices.verifyOTP(req.body,(error,results)=>{
        if(error){
            return next(error);
        }
        return res.status(200).send({
            message:"Success",
            data: results
        })
    });
};