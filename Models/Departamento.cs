using Colaboradores.Validaciones;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Colaboradores.Models
{
    public class Departamento
    {

        public int Id { get; set; } // Clave primaria

        [Required(ErrorMessage = "El campo {0} es obligatorio.")]
        [StringLength(100, ErrorMessage = "El campo {0} no puede tener más de {1} caracteres.")]
        [RegularExpression(@"^[a-zA-Z\s]+$", ErrorMessage = "El campo {0} solo puede contener letras y espacios.")]
        public string Nombre { get; set; } // Nombre del departamento

        [Required(ErrorMessage = "El campo {0} es obligatorio.")]
        [Range(0, 1, ErrorMessage = "El campo {0} debe ser 0 (Inactivo) o 1 (Activo).")]
        public string? Estatus { get; set; } // Estatus (0 = Inactivo, 1 = Activo)
        public DateTime FechaCreacion { get; set; } // Fecha de creación
    }
}



