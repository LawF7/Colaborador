using AutoMapper;
using Colaboradores.Models;
using Colaboradores.Servicios;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using X.PagedList;
using X.PagedList.Extensions;

namespace Colaboradores.Controllers
{
    public class DepartamentoController : Controller
    {
        private readonly IRepositorioDepartamentos repositorioDepartamentos;
        private readonly IMapper mapper;

        public DepartamentoController(IRepositorioDepartamentos repositorioDepartamentos,
                                 IMapper mapper)
        {
            this.repositorioDepartamentos = repositorioDepartamentos;
            this.mapper = mapper;
        }

        public async Task<IActionResult> Index(int? page)
        {
            int pageSize = 10; // Número de registros por página
            int pageNumber = page ?? 1; // Página actual, por defecto la primera

            // Obtener todos los departamentos del repositorio
            var departamentos = await repositorioDepartamentos.Buscar();

            // Convertir la lista en una lista paginada
            var paginatedList = departamentos.ToPagedList(pageNumber, pageSize);

            return View(paginatedList);
        }


        public async Task<IActionResult> Crear()
        {
            ViewBag.EstatusList = new List<SelectListItem>
            {
                new SelectListItem { Value = "0", Text = "Inactivo" },
                new SelectListItem { Value = "1", Text = "Activo" }
            };

            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Crear(Departamento departamento)
        {
            if (!ModelState.IsValid)
            {
                // Volver a llenar el SelectList si hay errores de validación
                ViewBag.EstatusList = new List<SelectListItem>
                {
                    new SelectListItem { Value = "0", Text = "Inactivo" },
                    new SelectListItem { Value = "1", Text = "Activo" }
                };
                return View(departamento);
            }

            var id = await repositorioDepartamentos.Crear(departamento);

            if (id == 0)
            {
                ModelState.AddModelError("Nombre", "El nombre del departamento ya está registrado.");
                ViewBag.EstatusList = new List<SelectListItem>
                {
                    new SelectListItem { Value = "0", Text = "Inactivo" },
                    new SelectListItem { Value = "1", Text = "Activo" }
                };
                return View(departamento);
            }

            return RedirectToAction("Index");
        }


        //CARGAR VISTA EDITAR
        public async Task<IActionResult> Editar(int id)
        {
            var empresa = await repositorioDepartamentos.ObtenerPorId(id);

            if (empresa == null)
            {
                return RedirectToAction("NoEncontrado", "Home");
            }

            ViewBag.EstatusList = new List<SelectListItem>
                {
                    new SelectListItem { Value = "0", Text = "Inactivo" },
                    new SelectListItem { Value = "1", Text = "Activo" }
                };

            return View(empresa);
        }

        //EDITAR DEP
        [HttpPost]
        public async Task<IActionResult> Editar(Departamento departamentoEditar)
        {
            var departamento = await repositorioDepartamentos.ObtenerPorId(departamentoEditar.Id);

            if (departamento == null)
            {
                return RedirectToAction("NoEncontrado", "Home");
            }

            var resultado = await repositorioDepartamentos.Editar(departamentoEditar);

            if (resultado == 0)
            {
                ModelState.AddModelError("Nombre", "El nombre del departamento ya está registrado.");
                ViewBag.EstatusList = new List<SelectListItem>
                {
                    new SelectListItem { Value = "0", Text = "Inactivo" },
                    new SelectListItem { Value = "1", Text = "Activo" }
                };
                return View(departamentoEditar);
            }

            return RedirectToAction("Index");
        }


        //CARGAR VISTA BORRAR
        public async Task<IActionResult> Borrar(int id)
        {
            var empresa = await repositorioDepartamentos.ObtenerPorId(id);
            if (empresa == null)
            {
                return RedirectToAction("Home", "NoEncontrado");
            }
            return View(empresa);
        }

        //BORRAR DEP
        [HttpPost]
        public async Task<IActionResult> BorrarDepartamento(int id)
        {
            var departamento = await repositorioDepartamentos.ObtenerPorId(id);
            if (departamento == null)
            {
                return RedirectToAction("Home", "NoEncontrado");
            }

            try
            {
                await repositorioDepartamentos.Borrar(id);
                return RedirectToAction("Index");
            }
            catch (SqlException ex)
            {
                if (ex.Number == 547)
                {
                    // Agrega un mensaje de error para mostrar en la vista
                    ViewData["ErrorMessage"] = "No se puede eliminar la empresa porque tiene dependencias con otros registros.";
                    return View("Borrar", departamento); // Regresa la misma vista con el modelo
                }
                else
                {
                    ViewData["ErrorMessage"] = "Ocurrió un error al intentar eliminar la empresa.";
                    return View("Borrar", departamento);
                }
            }
            catch (Exception ex)
            {
                ViewData["ErrorMessage"] = $"Ocurrió un error inesperado: {ex.Message}";
                return View("Borrar", departamento);
            }
        }

    }
}
