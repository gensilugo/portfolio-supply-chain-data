# Automatización con n8n

Dos workflows reales que armé para no depender de revisar planillas a mano: corren todas las mañanas, cruzan datos contra reglas de negocio y mandan una alerta por mail solo cuando hace falta actuar.

[Ver en el portfolio](https://claude.ai/artifact/U9pFuzwjdvDH79bHHoMqZk#automatizacion)

## 1. Control de frescura — Frente de estiba

Todos los días a las 8:00, lee el frente de estiba, calcula la fecha de bloqueo de cada lote (vencimiento menos días de bloqueo, o la fecha del waiver) y la compara con los días que tarda en agotarse el stock al ritmo de salida actual. Si hay productos en riesgo de bloqueo, envía una alerta por mail con los bultos afectados y la acción sugerida, y registra cada alerta en un historial.

**Nodos:** Schedule Trigger (8:00) → Google Sheets (leer frente de estiba) → Code (calcular frescura y fecha de bloqueo) → IF (¿hay productos en riesgo?) → rama sí: Gmail (alerta) + Google Sheets (registrar en historial) · rama no: sin acción.

## 2. Alerta temprana de stock crítico

Todos los días a las 8:00, lee el inventario, calcula los días de cobertura de cada insumo y los compara con el lead time del proveedor y el stock de seguridad. Si hay insumos en alerta (crítico o por debajo del punto de pedido), envía un mail con el detalle y la cantidad sugerida, y registra cada alerta en un historial.

**Nodos:** Schedule Trigger (8:00) → Google Sheets (leer inventario) → Code (calcular cobertura y estado) → IF (¿hay insumos en alerta?) → rama sí: Gmail (alerta) + Google Sheets (registrar en historial) · rama no: sin acción.

## Sobre los archivos JSON de esta carpeta

Los `.json` de esta carpeta son **plantillas reconstruidas** a partir de la estructura real de mis workflows (mismos nodos, mismo orden, misma lógica de ramas) para que se puedan importar en n8n y ver el flujo funcionando. No son el export literal de mis workflows en producción, porque ese export incluye credenciales, IDs de planillas y direcciones de mail reales que no corresponde publicar.

Si en algún momento quiero publicar el export real, el camino es:

1. En n8n: abrir el workflow → menú (`⋮`) → **Download**. Exporta un `.json` con nodos y conexiones, sin credenciales (las credenciales no se exportan por default).
2. Revisar igual el JSON exportado y reemplazar/borrar: URLs de webhook, IDs de spreadsheet de Google Sheets, direcciones de mail destino, y cualquier nombre de cliente o producto real que haya quedado en los nodos `Code` o en los parámetros de los nodos.
3. Reemplazar el archivo de plantilla correspondiente en esta carpeta por ese export ya revisado.

## Cómo importar las plantillas

En n8n: **Import from File** (o pegar el JSON con Ctrl+V sobre el canvas) → ajustar credenciales propias de Google Sheets/Gmail antes de activar.
