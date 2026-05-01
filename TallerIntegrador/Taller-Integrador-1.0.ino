#include <AFMotor.h>
// Funciones predefinidas por el docente
extern "C" {
    void config();
    void control();
    void entradas();
    void retardo();
}

//Definición de registros
uint8_t *R10=(uint8_t*)0X0A;
uint8_t *R11=(uint8_t*)0X0B;
uint8_t *R12=(uint8_t*)0X0C;
//.....
uint8_t *R16=(uint8_t*)0X10;
uint8_t *R17=(uint8_t*)0X11;
uint8_t *R18=(uint8_t*)0X12;
uint8_t *R19=(uint8_t*)0X13;
uint8_t *R20=(uint8_t*)0X14;
uint8_t *R21=(uint8_t*)0X15;

//Definición de objetos de bibliotecas
AF_DCMotor MI(1);     //Motor 1
AF_DCMotor MD(3);     //Motor 2


void setup() {
    config();
    MI.run(BACKWARD);            //Asigno direccion a los motores
    MD.run(FORWARD);            //La velocidad se da dentro de LOOP
}

void loop() {
    entradas();
    control();
    salidas();
    delay(20);
    //retardo();

}

void salidas(){
    //MI.run(BACKWARD);
    MI.setSpeed(*R10); //   -> EJEMPLO
    MD.setSpeed(*R11); //   -> EJEMPLO
}