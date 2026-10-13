# Ocupación de Depósito

Panel de disponibilidad y ocupación de posiciones para un centro de distribución de consumo masivo operado por un 3PL, con seguimiento por sector, módulo y pasillo para priorizar reubicaciones.

[Ver en el portfolio](https://claude.ai/artifact/U9pFuzwjdvDH79bHHoMqZk#ocupacion)

> **Confidencialidad:** este proyecto se basa en un trabajo real para un cliente de consumo masivo. Acá se muestra con cifras simuladas y sin identificar al cliente ni al 3PL. La estructura del modelo (sector → módulo → pasillo) y la lógica de las medidas sí son las mismas que usé en el trabajo original.

## Contexto del problema

El equipo decidía reubicaciones "a ojo", caminando el depósito. No había forma rápida de ver qué sectores estaban saturados y cuáles subutilizados, así que las reubicaciones llegaban tarde y terminaban frenando la recepción cuando un sector se bloqueaba por falta de espacio.

## Metodología

1. **Maestro de ubicaciones.** Cada posición del depósito (sector, módulo, pasillo, nivel) se modeló como una dimensión propia, separada de las transacciones de stock.
2. **Medidas de ocupación en DAX.** % ocupado, libre y bloqueado, calculado por posición y agregable a cualquier nivel (sector, módulo, centro completo).
3. **Autoservicio para el equipo de turno.** Filtros por sector, módulo, cámara/ambiente y punto de picking (POP/PTERM), para que el equipo revisara el estado del depósito sin pedirme el dato a mí cada vez.

## Resultados

- De revisar ocupación **una vez por semana** a **monitoreo diario**.
- Sectores por encima del 95% de ocupación se detectan y resuelven **antes** de frenar la recepción, en vez de descubrirse cuando ya es tarde.
- 4.320 posiciones bajo seguimiento, con banda objetivo de ocupación de 80–90%.

## Cómo leer este código

- [`ocupacion-deposito-medidas.dax`](./ocupacion-deposito-medidas.dax): medidas de % ocupación, libre y bloqueado, por posición y por sector.

Todas las cifras de este README y del dashboard son simuladas.
