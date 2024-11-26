using Colaboradores.Validaciones;
using System.ComponentModel.DataAnnotations;

namespace Colaboradores.Models
{
    public class Colaborador
    {
        public int Id { get; set; }
        [Display(Name = "Departamento")]
        public int DepartamentoId { get; set; }
        public string? Departamento { get; set; }

        [Required(ErrorMessage = "El campo {0} es requerido")]
        [StringLength(maximumLength: 13,MinimumLength = 13,ErrorMessage = "Ingrese un DPI valido")]
        [RegularExpression(@"^\d+$", ErrorMessage = "Ingrese un DPI valido")]
        public string? DPI { get; set; }
        [Required(ErrorMessage = "El campo {0} es requerido")]
        [Display(Name = "Nombre Completo")]
        [PrimeraLetraMayuscula]
        [RegularExpression(@"^[a-zA-Z\s]+$", ErrorMessage = "Solo se permiten letras en el campo {0}")]
        public string? NombreCompleto { get; set; }
        [StringLength(maximumLength: 15)]
        [Phone(ErrorMessage = "Ingresa un teléfono valido")]
        [Required(ErrorMessage = "El campo {0} es requerido")]
        public string? Telefono { get; set; }
        [EmailAddress(ErrorMessage = "Ingresa un email valido")]
        [Required(ErrorMessage = "El campo Correo es requerido")]
        [Display(Name = "Email")]
        public string? CorreoElectronico { get; set; }
        public DateTime FechaCreacion { get; set; } = DateTime.Now;

    }
}
