const nodemailer = require('nodemailer');


const transporter = nodemailer.createTransport({
    service: 'Gmail',
    auth: {
      user: 'exmaple.25@gmail.com',
      pass: '*******'
    }
  });


module.exports = transporter;
