# Ventas & Rentabilidad

Modelado de ventas, rentabilidad y costos en Power BI, segmentado por zona geográfica, medio de pago y tamaño de producto, con indicadores de desempeño vs. objetivo.

[Ver en el portfolio](https://claude.ai/artifact/U9pFuzwjdvDH79bHHoMqZk#ventas)

> Datos ilustrativos — ejercicio de análisis comercial, no corresponde a ningún cliente real.

## Contexto del problema

Las planillas de ventas vivían separadas de las de costos y medios de pago, así que nadie veía de un vistazo qué combinación de zona, producto y medio de cobro realmente dejaba margen. Las decisiones de pricing y de qué medios de pago incentivar se tomaban sin ese cruce.

## Metodología

1. **Modelo único.** Se integraron ventas, costos y medio de pago en un mismo modelo estrella en Power BI, en vez de planillas sueltas por área.
2. **Rentabilidad por segmento.** Medidas de margen calculadas por zona, medio de pago y tamaño de producto, no solo a nivel total.
3. **Comparación contra objetivo.** Cada indicador se contrasta contra una meta mensual, para que el equipo comercial vea de inmediato dónde está por debajo.

## Resultados

- Visibilidad de qué medios de pago diluyen margen: efectivo 19,2% vs. billetera virtual 30,4%.
- Lectura mensual de ventas vs. objetivo que antes tomaba armar a mano.
- $182,4M de ventas anuales, 24,6% de rentabilidad total, sobre 318.400 unidades vendidas.

## Cómo leer este código

- [`ventas-rentabilidad-medidas.dax`](./ventas-rentabilidad-medidas.dax): medidas de ventas, costos y rentabilidad por segmento.
