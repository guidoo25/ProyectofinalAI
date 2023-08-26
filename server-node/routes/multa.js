const db = require('../db/db.js');
const transporter = require('../services/mail.js');
const express = require('express');
const router = express.Router(); // Agrega esta línea





router.post('/multar', async (req, res) => {
  console.log("Respuesta",req.body);
  const { placa, motivo, correo } = req.body;
  const query = 'INSERT INTO multas (placa, motivo, correo, fecha_hora_infraccion) VALUES (?, ?, ?, NOW())';

  try {
    const [results, fields] = await db.query(query, [placa, motivo, correo],err => {
      
      if (err) {  
        console.log("Error",err);
        res.status(500).send('Error al insertar multa');
      }
    });      


    const mailOptions = {
      from: 'MUNICIPIO DE QUITO',
      to: correo,
      subject: 'Multa registrada',
      text: 'Se ha registrado una multa para su vehículo .'+placa,
    };

    transporter.sendMail(mailOptions, (mailErr, info) => {
      if (mailErr) {
        console.error('Error al enviar correo:', mailErr);
        res.status(500).send('Error al enviar correo');
      } else {
        console.log('Multa registrada y correo enviado:', results);
        res.status(200).send('Multa registrada y correo enviado');
      }
    });
  } catch (err) {
    console.error('Error al insertar multa:', err);
    res.status(500).send('Error al insertar multa');
  }
});

router.get('/multas', async (req, res) => {
  const query = 'SELECT * FROM multas';
  
  try {
    const [results, fields] = await db.execute(query);
    console.log('Multas obtenidas:', results);
    res.status(200).json(results);
  } catch (err) {
    console.error('Error al obtener multas:', err);
    res.status(500).send('Error al obtener multas');
  }
});



module.exports = router; // Exporta el router
