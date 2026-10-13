# NEXO-FEFO

Torre de control para el cumplimiento del método FEFO (First Expired, First Out) en un centro de distribución de bebidas **sin sistema de gestión de almacenes (WMS)**. Trabajo final de grado — Licenciatura en Logística, UTN.

[Ver en el portfolio](https://claude.ai/artifact/U9pFuzwjdvDH79bHHoMqZk#nexo-fefo)

## Contexto del problema

El centro de distribución operaba sin WMS: el control de vencimientos se hacía caminando los pasillos y registrando a mano en planillas. Eso significaba que:

- Las roturas por vencimiento y los errores de rotación (sacar un lote más nuevo antes que uno más viejo) se descubrían cuando ya no había margen para corregirlos.
- No había trazabilidad de qué pallet se relevó, cuándo, ni quién lo hizo.
- El tiempo del equipo de depósito se iba en caminar y anotar, no en resolver desvíos.

## Metodología

La torre de control se armó sobre tres bloques:

1. **Captura sin fricción.** El operario saca una foto del lote/vencimiento del pallet y la manda por WhatsApp o Telegram — no hay que aprender una app nueva ni un dispositivo nuevo.
2. **Lectura automática.** Un modelo de IA multimodal interpreta la foto y extrae lote, fecha de vencimiento y ubicación.
3. **Orquestación y reglas de negocio.** Un workflow de n8n recibe ese dato, lo cruza contra las reglas FEFO (qué lote debería salir primero según vencimiento) y contra el historial de relevamientos, calcula desvíos y dispara alertas cuando corresponde.

Los datos quedan en una base relacional simple (ver `nexo-fefo-schema.sql`) y el panel de indicadores (compliance, desvíos, alertas a tiempo) se recalcula sobre esa base.

### Arquitectura

```
Foto del pallet (WhatsApp/Telegram)
        │
        ▼
IA multimodal (lectura de lote + vencimiento)
        │
        ▼
n8n (reglas FEFO, cálculo de desvío, alertas)
        │
        ▼
Base de datos (pallets, relevamientos, alertas)
        │
        ▼
Panel de indicadores (compliance %, desvíos, alertas a tiempo)
```

## Resultados (piloto de 12 semanas)

| Indicador | Antes del piloto | Semana 12 |
|---|---|---|
| Cumplimiento FEFO | 62% | 91% |
| Errores de rotación | — | −76% |
| Alertas detectadas a tiempo | — | 92% (meta ≥ 90%) |
| Adopción del personal | — | 84% (meta ≥ 80%) |

## Cómo leer este código

- [`nexo-fefo-schema.sql`](./nexo-fefo-schema.sql): modelo de datos (pallets, relevamientos, alertas, umbrales).
- [`nexo-fefo-medidas.dax`](./nexo-fefo-medidas.dax): medidas usadas en el panel (% cumplimiento, desvíos, alertas a tiempo).

Todas las cifras de este proyecto son del dataset sintético del piloto, inspirado en mi tesis — no hay datos de ningún cliente real involucrados acá.
