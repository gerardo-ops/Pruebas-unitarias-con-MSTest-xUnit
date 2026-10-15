namespace GABM.ManipuladorCadenas;

/// <summary>
/// Clase de utilidad para realizar manipulaciones sobre cadenas de texto.
/// </summary>
public class StringManipulator
{
    /// <summary>
    /// Invierte el orden de los caracteres de la cadena proporcionada.
    /// </summary>
    /// <param name="input">Cadena de texto a invertir.</param>
    /// <returns>Cadena con los caracteres en orden inverso.</returns>
    /// <exception cref="ArgumentNullException">Se lanza si la cadena de entrada es nula.</exception>
    public string ReverseString(string input)
    {
        if (input == null)
        {
            throw new ArgumentNullException(nameof(input), "La cadena de entrada no puede ser nula.");
        }

        if (input.Length <= 1)
        {
            return input;
        }

        char[] charArray = input.ToCharArray();
        Array.Reverse(charArray);
        return new string(charArray);
    }

    /// <summary>
    /// Elimina todos los caracteres de espacio en blanco de la cadena proporcionada.
    /// </summary>
    /// <param name="input">Cadena de texto original.</param>
    /// <returns>Cadena resultante sin espacios en blanco.</returns>
    /// <exception cref="ArgumentNullException">Se lanza si la cadena de entrada es nula.</exception>
    public string RemoveSpaces(string input)
    {
        if (input == null)
        {
            throw new ArgumentNullException(nameof(input), "La cadena de entrada no puede ser nula.");
        }

        return input.Replace(" ", string.Empty);
    }
}
