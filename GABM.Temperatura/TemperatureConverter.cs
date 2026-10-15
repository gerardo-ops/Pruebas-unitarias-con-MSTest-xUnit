namespace GABM.Temperatura;

/// <summary>
/// Clase para la conversión de unidades de temperatura entre Celsius y Fahrenheit.
/// </summary>
public class TemperatureConverter
{
    /// <summary>
    /// Convierte una temperatura en grados Celsius a grados Fahrenheit.
    /// </summary>
    /// <param name="celsius">Temperatura en grados Celsius.</param>
    /// <returns>Temperatura equivalente en grados Fahrenheit redondeada a 2 decimales.</returns>
    public double CelsiusToFahrenheit(double celsius)
    {
        double fahrenheit = (celsius * 9.0 / 5.0) + 32.0;
        return Math.Round(fahrenheit, 2);
    }

    /// <summary>
    /// Convierte una temperatura en grados Fahrenheit a grados Celsius.
    /// </summary>
    /// <param name="fahrenheit">Temperatura en grados Fahrenheit.</param>
    /// <returns>Temperatura equivalente en grados Celsius redondeada a 2 decimales.</returns>
    public double FahrenheitToCelsius(double fahrenheit)
    {
        double celsius = (fahrenheit - 32.0) * 5.0 / 9.0;
        return Math.Round(celsius, 2);
    }
}
