-- NEXO-FEFO · modelo de datos (simplificado, dataset sintético)
-- Objetivo: trazar cada pallet relevado, compararlo contra la regla FEFO
-- y registrar los desvíos/alertas que dispara la torre de control.

CREATE TABLE productos (
    sku             VARCHAR(20) PRIMARY KEY,
    descripcion     VARCHAR(120) NOT NULL,
    dias_bloqueo    INT NOT NULL,          -- días antes del vencimiento en que el lote se bloquea
    categoria       VARCHAR(40)
);

CREATE TABLE pallets (
    pallet_id       VARCHAR(20) PRIMARY KEY,
    sku             VARCHAR(20) NOT NULL REFERENCES productos(sku),
    lote            VARCHAR(30) NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    ubicacion       VARCHAR(20) NOT NULL,  -- sector-módulo-pasillo
    fecha_ingreso   DATE NOT NULL
);

CREATE TABLE relevamientos (
    relevamiento_id SERIAL PRIMARY KEY,
    pallet_id       VARCHAR(20) NOT NULL REFERENCES pallets(pallet_id),
    fecha_relevamiento TIMESTAMP NOT NULL,
    canal           VARCHAR(20) NOT NULL,  -- 'whatsapp' | 'telegram'
    orden_detectado INT NOT NULL,          -- posición en la que se sacó el pallet ese día
    orden_esperado_fefo INT NOT NULL,      -- posición que le correspondía por FEFO
    es_desvio       BOOLEAN GENERATED ALWAYS AS (orden_detectado <> orden_esperado_fefo) STORED,
    semana_piloto   INT NOT NULL           -- 1..12, para el gráfico de evolución
);

CREATE TABLE alertas (
    alerta_id       SERIAL PRIMARY KEY,
    pallet_id       VARCHAR(20) NOT NULL REFERENCES pallets(pallet_id),
    tipo            VARCHAR(30) NOT NULL,  -- 'desvio_fefo' | 'riesgo_vencimiento' | 'bloqueado'
    fecha_disparo   TIMESTAMP NOT NULL,
    fecha_resolucion TIMESTAMP,
    detectada_a_tiempo BOOLEAN NOT NULL    -- true si se resolvió antes del vencimiento/bloqueo
);

-- Ejemplo: compliance semanal (% de relevamientos sin desvío)
-- usado como base de la medida DAX "Cumplimiento FEFO %"
SELECT
    semana_piloto,
    ROUND(100.0 * SUM(CASE WHEN NOT es_desvio THEN 1 ELSE 0 END) / COUNT(*), 1) AS cumplimiento_pct
FROM relevamientos
GROUP BY semana_piloto
ORDER BY semana_piloto;
