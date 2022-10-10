

//Importar datos
import excel "https://github.com/tintanegrainsp/datoslongitudinales/blob/main/ile.xlsx?raw=true", sheet("ile") firstrow

// Generación y formateo de variable tiempo a mes
gen Mes = mofd(Fecha)
format Mes %tm

// Declarar serie de tiempo

tsset Mes

// Gráfica serie de tiempo y prueba Dickey-Fuller

tsline Promedio
dfuller Promedio

// Si hay estacionalidad, así que no se realiza diferencia

ac Promedio
corrgram Promedio

//Análisis de ruido y suavizamiento

tssmooth ma PromedioS = Promedio, window(2 1)
tsline Promedio PromedioS

// Modelo ARIMA

arima Promedio, arima(0,0,1)

// Análisis de residuos

predict aj

twoway (tsline Promedio) (tsline aj)

predict r

tsline r
qnorm r
kdensity r, normal

// Generación de diferencia debido a distribución discretamente alejada de lo normal

drop aj r

gen PromedioD = D.Promedio

arima Promedio, arima(0,1,1)

predict  aj
predict r

twoway (tsline PromedioD) (tsline aj)

tsline r
qnorm r
kdensity r, normal

// La diferenciación no resulta en un mejor modelo, por lo que el modelo original permanece

