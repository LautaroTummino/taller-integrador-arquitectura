# 📄 Informe Taller Integrador

## Arquitectura de Computadoras

---

## 📌 Resumen

En este informe se describe cómo se logró que el robot siguiera una línea utilizando un código en lenguaje ensamblador.
El objetivo del proyecto fue implementar este código para el funcionamiento del robot utilizando el kit ZYC00002.

---

## 📖 Introducción

Este proyecto aplicó los conocimientos adquiridos en la materia Arquitectura de Computadoras.
Se buscó programar el robot ZYC00002 utilizando Arduino UNO, sensores de línea y motores para el control de movimiento.

---

## ⚙️ Desarrollo

* Se comenzó con la construcción del robot, asegurando que todos los componentes estuvieran correctamente ubicados para su funcionamiento.

* Se utilizó la librería `AFMotor.h` de Arduino IDE para controlar los motores de forma independiente, resolviendo problemas de configuración de velocidad mediante prueba y error.

* Se implementaron las funciones `config()`, `entradas()`, `control()` y `retardo()` en lenguaje ensamblador, utilizando el set de instrucciones del Atmega328P.

* Se adaptó y modificó la función de retardo del Taller 3 para generar un retardo de un segundo, fundamental para el funcionamiento del robot.

* Se configuraron los puertos C4 y C5 como entradas para los sensores izquierdo y derecho, respectivamente, utilizando la función `config()`.

* En la función `entradas()` se determinó el estado de los sensores para luego aplicar la lógica de control en función de si detectan o no la línea.

* Se implementó la lógica de control para ajustar la velocidad de los motores y realizar giros correctos cuando se detecta la línea negra.

---

## 📊 Conclusiones

* La actividad resultó desafiante pero divertida, especialmente en el montaje del vehículo y la resolución de problemas de código.

* Se logró implementar exitosamente la lógica para que el robot siga la línea y realice giros adecuados, lo cual fue gratificante.

* El proyecto permitió aplicar conceptos de performance, microcontroladores y lenguaje ensamblador vistos a lo largo del curso.

---