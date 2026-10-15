<#
.SYNOPSIS
    Script de automatización para registrar Casos de Prueba (Test Cases) en Azure DevOps.
.DESCRIPTION
    Registra formalmente los casos de prueba para los ejercicios de MSTest y xUnit
    en el proyecto 'Pruebas unitarias con MSTest xUnit' de Azure DevOps utilizando su API REST.
.NOTES
    Autor: Gerardo Antonio Batres Moreno (GABM)
    Módulo: Pruebas unitarias con MSTest y xUnit (.NET)
#>

param (
    [string]$Organization = "gerardobatres06",
    [string]$Project = "Pruebas unitarias con MSTest xUnit",
    [string]$Token = $env:AZURE_DEVOPS_PAT
)

if ([string]::IsNullOrWhiteSpace($Token)) {
    Write-Warning "Por favor proporciona un Personal Access Token (PAT) mediante el parámetro -Token o la variable de entorno `$env:AZURE_DEVOPS_PAT"
    return
}

$base64Auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$Token"))

function Send-PatchRequest {
    param (
        [string]$Uri,
        [string]$Method,
        [string]$JsonPayload
    )
    $utf8Bytes = [System.Text.Encoding]::UTF8.GetBytes($JsonPayload)
    return Invoke-RestMethod -Uri $Uri -Method $Method -Headers @{ Authorization = "Basic $base64Auth" } -ContentType "application/json-patch+json; charset=utf-8" -Body $utf8Bytes
}

Write-Host "Verificando conexión con Azure DevOps..." -ForegroundColor Cyan

# Definición de Casos de Prueba
$testCases = @(
    @{
        Id = "TC-MST-01"
        Title = "TC-MST-01: Conversión de Celsius a Fahrenheit - Temperatura Ambiente (25°C a 77°F)"
        Priority = 2
        Severity = "2 - High"
        Description = "<div><h3>Información de Caso de Prueba</h3><ul><li><b>Módulo Fuente:</b> GABM.Temperatura</li><li><b>Clase:</b> TemperatureConverter</li><li><b>Método:</b> CelsiusToFahrenheit(double celsius)</li><li><b>Proyecto de Pruebas:</b> GABM.Temperatura.UnitTestMSTest</li><li><b>Tipo de Prueba:</b> Valor Normal / Funcional</li></ul><h3>Precondiciones</h3><ol><li>Solución GABM.sln compilada sin errores.</li><li>GABM.Temperatura referenciada en GABM.Temperatura.UnitTestMSTest.</li></ol><h3>Criterio de Aceptación</h3><p>La fórmula (25.0 * 9.0 / 5.0) + 32.0 debe retornar exactamente 77.0 °F.</p></div>"
        StepsXml = '<steps id="0" last="3"><step id="2" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;1. Instanciar la clase TemperatureConverter.&lt;BR/&gt;2. Invocar CelsiusToFahrenheit(25.0).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;El método devuelve exactamente 77.0.&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step><step id="3" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;3. Validar con Assert.AreEqual(77.0, resultado, 0.001).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;La aserción es exitosa (Passed).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step></steps>'
    },
    @{
        Id = "TC-MST-02"
        Title = "TC-MST-02: Conversión de Celsius a Fahrenheit - Punto de Congelación del Agua (0°C a 32°F)"
        Priority = 1
        Severity = "1 - Critical"
        Description = "<div><h3>Información de Caso de Prueba</h3><ul><li><b>Módulo Fuente:</b> GABM.Temperatura</li><li><b>Clase:</b> TemperatureConverter</li><li><b>Método:</b> CelsiusToFahrenheit(double celsius)</li><li><b>Proyecto de Pruebas:</b> GABM.Temperatura.UnitTestMSTest</li><li><b>Tipo de Prueba:</b> Valor Límite / Borde Inferior Estándar</li></ul><h3>Precondiciones</h3><ol><li>Framework MSTest listo en el proyecto de pruebas.</li></ol><h3>Criterio de Aceptación</h3><p>Para un valor de 0.0 °C, el método debe retornar exactamente 32.0 °F.</p></div>"
        StepsXml = '<steps id="0" last="3"><step id="2" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;1. Instanciar TemperatureConverter.&lt;BR/&gt;2. Ejecutar CelsiusToFahrenheit(0.0).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;El método retorna el valor 32.0.&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step><step id="3" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;3. Comprobar mediante Assert.AreEqual(32.0, resultado).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;Prueba superada (Passed).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step></steps>'
    },
    @{
        Id = "TC-MST-03"
        Title = "TC-MST-03: Conversión de Fahrenheit a Celsius - Punto de Ebullición del Agua (212°F a 100°C)"
        Priority = 2
        Severity = "2 - High"
        Description = "<div><h3>Información de Caso de Prueba</h3><ul><li><b>Módulo Fuente:</b> GABM.Temperatura</li><li><b>Clase:</b> TemperatureConverter</li><li><b>Método:</b> FahrenheitToCelsius(double fahrenheit)</li><li><b>Proyecto de Pruebas:</b> GABM.Temperatura.UnitTestMSTest</li><li><b>Tipo de Prueba:</b> Valor Límite / Borde Superior Estándar</li></ul><h3>Precondiciones</h3><ol><li>Solución compilada y proyecto de pruebas MSTest operativo.</li></ol><h3>Criterio de Aceptación</h3><p>La fórmula (212.0 - 32.0) * 5.0 / 9.0 debe retornar 100.0 °C.</p></div>"
        StepsXml = '<steps id="0" last="3"><step id="2" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;1. Instanciar TemperatureConverter.&lt;BR/&gt;2. Invocar FahrenheitToCelsius(212.0).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;El método retorna el valor 100.0.&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step><step id="3" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;3. Validar con Assert.AreEqual(100.0, resultado, 0.001).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;Aserción aprobada satisfactoriamente.&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step></steps>'
    },
    @{
        Id = "TC-MST-04"
        Title = "TC-MST-04: Conversión de Fahrenheit a Celsius - Punto de Intersección de Escalas (-40°F a -40°C)"
        Priority = 2
        Severity = "2 - High"
        Description = "<div><h3>Información de Caso de Prueba</h3><ul><li><b>Módulo Fuente:</b> GABM.Temperatura</li><li><b>Clase:</b> TemperatureConverter</li><li><b>Método:</b> FahrenheitToCelsius(double fahrenheit)</li><li><b>Proyecto de Pruebas:</b> GABM.Temperatura.UnitTestMSTest</li><li><b>Tipo de Prueba:</b> Valor Borde / Escala Negativa Extrema</li></ul><h3>Precondiciones</h3><ol><li>Soporte para números reales negativos.</li></ol><h3>Criterio de Aceptación</h3><p>A -40 grados Fahrenheit, el método debe retornar exactamente -40.0 °C.</p></div>"
        StepsXml = '<steps id="0" last="3"><step id="2" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;1. Instanciar TemperatureConverter.&lt;BR/&gt;2. Invocar FahrenheitToCelsius(-40.0).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;Retorna el valor numérico -40.0.&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step><step id="3" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;3. Validar con Assert.AreEqual(-40.0, resultado, 0.001).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;Prueba superada (Passed).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step></steps>'
    },
    @{
        Id = "TC-XUN-01"
        Title = "TC-XUN-01: Inversión de Cadena Alfanumérica Estándar (Valor Normal)"
        Priority = 2
        Severity = "2 - High"
        Description = "<div><h3>Información de Caso de Prueba</h3><ul><li><b>Módulo Fuente:</b> GABM.ManipuladorCadenas</li><li><b>Clase:</b> StringManipulator</li><li><b>Método:</b> ReverseString(string input)</li><li><b>Proyecto de Pruebas:</b> GABM.ManipuladorCadenas.UnitTestAppxUnit</li><li><b>Tipo de Prueba:</b> Valor Normal / Funcional</li></ul><h3>Precondiciones</h3><ol><li>Proyecto xUnit referenciando a GABM.ManipuladorCadenas.</li></ol><h3>Criterio de Aceptación</h3><p>Al procesar 'Hola Mundo', debe retornar 'odnuM aloH'.</p></div>"
        StepsXml = '<steps id="0" last="3"><step id="2" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;1. Instanciar StringManipulator en método [Fact].&lt;BR/&gt;2. Invocar ReverseString(&amp;quot;Hola Mundo&amp;quot;).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;El método retorna &amp;quot;odnuM aloH&amp;quot;.&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step><step id="3" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;3. Comprobar con Assert.Equal(&amp;quot;odnuM aloH&amp;quot;, resultado).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;Prueba aprobada en xUnit Runner.&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step></steps>'
    },
    @{
        Id = "TC-XUN-02"
        Title = "TC-XUN-02: Inversión de Cadena Vacía (Valor Límite / Borde)"
        Priority = 1
        Severity = "1 - Critical"
        Description = "<div><h3>Información de Caso de Prueba</h3><ul><li><b>Módulo Fuente:</b> GABM.ManipuladorCadenas</li><li><b>Clase:</b> StringManipulator</li><li><b>Método:</b> ReverseString(string input)</li><li><b>Proyecto de Pruebas:</b> GABM.ManipuladorCadenas.UnitTestAppxUnit</li><li><b>Tipo de Prueba:</b> Valor Borde / Cadena Vacía</li></ul><h3>Precondiciones</h3><ol><li>Lógica defensiva ante cadenas de longitud cero.</li></ol><h3>Criterio de Aceptación</h3><p>Al pasar string.Empty, el método devuelve string.Empty sin excepciones de índice.</p></div>"
        StepsXml = '<steps id="0" last="3"><step id="2" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;1. Instanciar StringManipulator.&lt;BR/&gt;2. Ejecutar ReverseString(string.Empty).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;Retorna cadena vacía &amp;quot;&amp;quot;.&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step><step id="3" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;3. Validar con Assert.Equal(string.Empty, resultado).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;Aserción exitosa (Passed).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step></steps>'
    },
    @{
        Id = "TC-XUN-03"
        Title = "TC-XUN-03: Eliminación de Espacios en Frase con Múltiples Espacios (Valor Normal)"
        Priority = 2
        Severity = "2 - High"
        Description = "<div><h3>Información de Caso de Prueba</h3><ul><li><b>Módulo Fuente:</b> GABM.ManipuladorCadenas</li><li><b>Clase:</b> StringManipulator</li><li><b>Método:</b> RemoveSpaces(string input)</li><li><b>Proyecto de Pruebas:</b> GABM.ManipuladorCadenas.UnitTestAppxUnit</li><li><b>Tipo de Prueba:</b> Valor Normal / Complejo</li></ul><h3>Precondiciones</h3><ol><li>Proyecto xUnit funcional y compilado.</li></ol><h3>Criterio de Aceptación</h3><p>La cadena \'  Pruebas   Unitarias   C#  \' debe quedar como \'PruebasUnitariasC#\'.</p></div>"
        StepsXml = '<steps id="0" last="3"><step id="2" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;1. Instanciar StringManipulator.&lt;BR/&gt;2. Invocar RemoveSpaces(&amp;quot;  Pruebas   Unitarias   C#  &amp;quot;).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;Retorna &amp;quot;PruebasUnitariasC#&amp;quot;.&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step><step id="3" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;3. Validar con Assert.Equal(&amp;quot;PruebasUnitariasC#&amp;quot;, resultado).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;Prueba superada (Passed).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step></steps>'
    },
    @{
        Id = "TC-XUN-04"
        Title = "TC-XUN-04: Eliminación de Espacios en Cadena Únicamente con Espacios en Blanco (Valor Límite)"
        Priority = 3
        Severity = "3 - Medium"
        Description = "<div><h3>Información de Caso de Prueba</h3><ul><li><b>Módulo Fuente:</b> GABM.ManipuladorCadenas</li><li><b>Clase:</b> StringManipulator</li><li><b>Método:</b> RemoveSpaces(string input)</li><li><b>Proyecto de Pruebas:</b> GABM.ManipuladorCadenas.UnitTestAppxUnit</li><li><b>Tipo de Prueba:</b> Valor Límite / Solo espacios</li></ul><h3>Precondiciones</h3><ol><li>Manejo de cadenas con solo espacios en blanco.</li></ol><h3>Criterio de Aceptación</h3><p>Al pasar una cadena de 5 espacios, devuelve cadena vacía.</p></div>"
        StepsXml = '<steps id="0" last="3"><step id="2" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;1. Instanciar StringManipulator.&lt;BR/&gt;2. Invocar RemoveSpaces(&amp;quot;     &amp;quot;).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;Retorna cadena vacía &amp;quot;&amp;quot;.&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step><step id="3" type="ValidateStep"><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;3. Validar con Assert.Equal(&amp;quot;&amp;quot;, resultado).&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><parameterizedString isformatted="true">&lt;DIV&gt;&lt;P&gt;Prueba completada y aprobada.&lt;/P&gt;&lt;/DIV&gt;</parameterizedString><description/></step></steps>'
    }
)

Write-Host "Casos de prueba preparados para sincronización." -ForegroundColor Green
