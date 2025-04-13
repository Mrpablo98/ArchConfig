#!/bin/bash
# Ejemplo básico: extrae la temperatura de la CPU usando lm_sensors.
# Adapta el comando 'sensors' según tu hardware y salida.
# En este ejemplo se busca la línea que contiene "Package id 0:".
temp=$(sensors | grep -m 1 'Package id 0:' | awk '{print $4}' | tr -d '+°C')
if [ -z "$temp" ]; then
    exit 1
fi

# Extraer la parte entera (sin decimales)
temp_int=${temp%.*}

# Definir la clase según el rango de temperatura (puedes ajustar los umbrales)
if [ "$temp_int" -lt 50 ]; then
    css_class="temp_low"
elif [ "$temp_int" -lt 70 ]; then
    css_class="temp_mid"
else
    css_class="temp_high"
fi

# Salida en formato JSON
echo "{\"text\": \"${temp_int}°C\", \"class\": \"${css_class}\"}"

