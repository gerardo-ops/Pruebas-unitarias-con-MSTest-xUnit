namespace GABM.ManipuladorCadenas.UnitTestAppxUnit;

using GABM.ManipuladorCadenas;
using Xunit;

/// <summary>
/// Suite de pruebas unitarias con xUnit para la clase StringManipulator.
/// Vinculada a los Casos de Prueba registrados en Azure DevOps (TC-XUN-01 a TC-XUN-04).
/// </summary>
public class StringManipulatorTests
{
    private readonly StringManipulator _manipulator = new();

    /// <summary>
    /// TC-XUN-01: Inversión de Cadena Alfanumérica Estándar (Valor Normal).
    /// </summary>
    [Fact]
    public void ReverseString_StandardAlphanumericString_ReturnsReversedString()
    {
        // Arrange
        string input = "Hola Mundo";
        string expected = "odnuM aloH";

        // Act
        string actual = _manipulator.ReverseString(input);

        // Assert
        Assert.Equal(expected, actual);
    }

    /// <summary>
    /// TC-XUN-02: Inversión de Cadena Vacía (Valor Límite / Borde).
    /// </summary>
    [Fact]
    public void ReverseString_EmptyString_ReturnsEmptyString()
    {
        // Arrange
        string input = string.Empty;
        string expected = string.Empty;

        // Act
        string actual = _manipulator.ReverseString(input);

        // Assert
        Assert.Equal(expected, actual);
    }

    /// <summary>
    /// TC-XUN-02 (Robustez): Inversión con entrada nula debe lanzar ArgumentNullException.
    /// </summary>
    [Fact]
    public void ReverseString_NullInput_ThrowsArgumentNullException()
    {
        // Arrange
        string? input = null;

        // Act & Assert
        Assert.Throws<ArgumentNullException>(() => _manipulator.ReverseString(input!));
    }

    /// <summary>
    /// Prueba complementaria: Inversión de un palíndromo conserva el mismo valor.
    /// </summary>
    [Theory]
    [InlineData("reconocer")]
    [InlineData("radar")]
    [InlineData("A")]
    public void ReverseString_PalindromesAndSingleChar_ReturnsSameString(string palindrome)
    {
        // Act
        string actual = _manipulator.ReverseString(palindrome);

        // Assert
        Assert.Equal(palindrome, actual);
    }

    /// <summary>
    /// TC-XUN-03: Eliminación de Espacios en Frase con Múltiples Espacios Intermedios y Extremos.
    /// </summary>
    [Fact]
    public void RemoveSpaces_MultipleIntermediateAndEdgeSpaces_ReturnsStringWithoutSpaces()
    {
        // Arrange
        string input = "  Pruebas   Unitarias   C#  ";
        string expected = "PruebasUnitariasC#";

        // Act
        string actual = _manipulator.RemoveSpaces(input);

        // Assert
        Assert.Equal(expected, actual);
    }

    /// <summary>
    /// TC-XUN-04: Eliminación de Espacios en Cadena Únicamente con Espacios en Blanco (Valor Límite).
    /// </summary>
    [Fact]
    public void RemoveSpaces_OnlySpaces_ReturnsEmptyString()
    {
        // Arrange
        string input = "     ";
        string expected = string.Empty;

        // Act
        string actual = _manipulator.RemoveSpaces(input);

        // Assert
        Assert.Equal(expected, actual);
    }

    /// <summary>
    /// Robustez: RemoveSpaces con entrada nula debe lanzar ArgumentNullException.
    /// </summary>
    [Fact]
    public void RemoveSpaces_NullInput_ThrowsArgumentNullException()
    {
        // Arrange
        string? input = null;

        // Act & Assert
        Assert.Throws<ArgumentNullException>(() => _manipulator.RemoveSpaces(input!));
    }

    /// <summary>
    /// Caso normal sin espacios: la cadena debe mantenerse idéntica.
    /// </summary>
    [Fact]
    public void RemoveSpaces_StringWithoutSpaces_ReturnsOriginalString()
    {
        // Arrange
        string input = "SinEspacios";
        string expected = "SinEspacios";

        // Act
        string actual = _manipulator.RemoveSpaces(input);

        // Assert
        Assert.Equal(expected, actual);
    }
}
