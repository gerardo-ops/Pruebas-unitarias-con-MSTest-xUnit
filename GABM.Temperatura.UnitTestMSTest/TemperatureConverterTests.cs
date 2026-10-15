namespace GABM.Temperatura.UnitTestMSTest;

using GABM.Temperatura;

/// <summary>
/// Suite de pruebas unitarias con MSTest para la clase TemperatureConverter.
/// Vinculada a los Casos de Prueba registrados en Azure DevOps.
/// </summary>
[TestClass]
public class TemperatureConverterTests
{
    private readonly TemperatureConverter _converter = new();

    /// <summary>
    /// TC-MST-01: Conversión de Celsius a Fahrenheit - Temperatura Ambiente (25°C a 77°F).
    /// </summary>
    [TestMethod]
    public void CelsiusToFahrenheit_StandardTemperature25C_Returns77Fahrenheit()
    {
        // Arrange
        double celsius = 25.0;
        double expected = 77.0;

        // Act
        double actual = _converter.CelsiusToFahrenheit(celsius);

        // Assert
        Assert.AreEqual(expected, actual, 0.001, "La conversión de 25°C a Fahrenheit debe ser 77.0°F.");
    }

    /// <summary>
    /// TC-MST-02: Conversión de Celsius a Fahrenheit - Punto de Congelación del Agua (0°C a 32°F).
    /// </summary>
    [TestMethod]
    public void CelsiusToFahrenheit_FreezingPoint0C_Returns32Fahrenheit()
    {
        // Arrange
        double celsius = 0.0;
        double expected = 32.0;

        // Act
        double actual = _converter.CelsiusToFahrenheit(celsius);

        // Assert
        Assert.AreEqual(expected, actual, 0.001, "0°C debe equivaler a 32.0°F.");
    }

    /// <summary>
    /// Prueba complementaria: Conversión de 20°C a 68°F (temperatura estándar de laboratorio).
    /// </summary>
    [TestMethod]
    public void CelsiusToFahrenheit_LaboratoryTemperature20C_Returns68Fahrenheit()
    {
        // Arrange
        double celsius = 20.0;
        double expected = 68.0;

        // Act
        double actual = _converter.CelsiusToFahrenheit(celsius);

        // Assert
        Assert.AreEqual(expected, actual, 0.001, "20°C debe equivaler a 68.0°F.");
    }

    /// <summary>
    /// TC-MST-03: Conversión de Fahrenheit a Celsius - Punto de Ebullición del Agua (212°F a 100°C).
    /// </summary>
    [TestMethod]
    public void FahrenheitToCelsius_BoilingPoint212F_Returns100Celsius()
    {
        // Arrange
        double fahrenheit = 212.0;
        double expected = 100.0;

        // Act
        double actual = _converter.FahrenheitToCelsius(fahrenheit);

        // Assert
        Assert.AreEqual(expected, actual, 0.001, "212°F debe equivaler a 100.0°C.");
    }

    /// <summary>
    /// TC-MST-04: Conversión de Fahrenheit a Celsius - Punto de Intersección de Escalas (-40°F a -40°C).
    /// </summary>
    [TestMethod]
    public void FahrenheitToCelsius_IntersectScaleMinus40F_ReturnsMinus40Celsius()
    {
        // Arrange
        double fahrenheit = -40.0;
        double expected = -40.0;

        // Act
        double actual = _converter.FahrenheitToCelsius(fahrenheit);

        // Assert
        Assert.AreEqual(expected, actual, 0.001, "-40°F debe equivaler a -40.0°C.");
    }
}
