# Auditoría de Inventario

Panel de precisión de inventario (unidades físicas vs. lógicas) para una operación de retail/indumentaria, con seguimiento mensual de precisión neta vs. objetivo y detalle de faltantes y sobrantes por categoría.

[Ver en el portfolio](https://claude.ai/artifact/U9pFuzwjdvDH79bHHoMqZk#auditoria)

> **Confidencialidad:** este proyecto se basa en un trabajo real para una operación de retail/indumentaria. Acá se muestra con cifras simuladas y sin identificar al cliente. La lógica de las medidas (precisión neta, faltantes y sobrantes por categoría) es la misma que usé en el trabajo original.

## Contexto del problema

La diferencia entre el stock físico y el lógico se descubría en los recuentos trimestrales, cuando ya era tarde para corregir la causa: faltantes y sobrantes se acumulaban categoría por categoría sin que nadie los viera venir hasta el cierre.

## Metodología

1. **Precisión neta, no solo bruta.** La medida central compensa faltantes con sobrantes dentro de la misma categoría, para no sobreestimar el problema contando dos veces la misma diferencia.
2. **Frecuencia mensual.** En vez de esperar el recuento trimestral, el panel se actualiza mes a mes con el objetivo propio de la operación (97%).
3. **Desagregación por categoría.** Para que el equipo de auditoría priorice qué recontar antes del cierre, en vez de auditar todo por igual.

## Resultados

- De un seguimiento trimestral reactivo a monitoreo mensual con objetivo propio (97%).
- El año cerró en 97,8% de precisión neta, con el detalle de faltantes y sobrantes ya identificado por categoría.
- 1.280 SKUs relevados sobre 86.400 unidades físicas; 1.840 unidades faltantes y 560 sobrantes (diferencia neta −1.280).

## Cómo leer este código

- [`auditoria-inventario-medidas.dax`](./auditoria-inventario-medidas.dax): medidas de precisión neta, faltantes y sobrantes por categoría.
