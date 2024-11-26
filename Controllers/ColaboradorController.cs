using AutoMapper;
using Colaboradores.Models;
using Colaboradores.Servicios;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Colaboradores.Controllers
{
    public class ColaboradorController : Controller
    {
        private readonly IRepositorioDepartamentos repositorioDepartamentos;
        private readonly IRepositorioColaboradores repositorioColaboradores;
        private readonly IMapper mapper;

        public ColaboradorController(IRepositorioDepartamentos repositorioDepartamentos,
                                 IRepositorioColaboradores repositorioColaboradores,
                                 IMapper mapper)
        {
            this.repositorioDepartamentos = repositorioDepartamentos;
            this.repositorioColaboradores = repositorioColaboradores;
            this.mapper = mapper;
        }

        public async Task<IActionResult> Index()
        {
            var colaboradoresDepartamento = await repositorioColaboradores.Buscar();

            var modelo = colaboradoresDepartamento.GroupBy(x => x.Departamento)
            //SELECCIONAMOS LOS REGISTROS Y SE LOS SETEAMOS AL MODELO DE LA VISTA
                                             .Select(grupo => new IndiceColaboradoresViewModel
                                             {
                                                 Departamento = grupo.Key,
                                                 Colaboradores = grupo.AsEnumerable()
                                             }).ToList();


            return View(modelo);
        }


        public async Task<IActionResult> Crear()
        {
            var modelo = new ColaboradorCreacionViewModel();
            modelo.Departamentos = await ObtenerDepartamentos();
            return View(modelo);
        }

        [HttpPost]
        public async Task<IActionResult> Crear(ColaboradorCreacionViewModel colaborador)
        {
            var departamento = await repositorioDepartamentos.ObtenerPorId(colaborador.DepartamentoId);

            if (departamento == null)
            {
                return RedirectToAction("Home", "NoEncontrado");
            }

            if (!ModelState.IsValid)
            {
                colaborador.Departamentos = await ObtenerDepartamentos();
                return View(colaborador);
            }

           var id = await repositorioColaboradores.Crear(colaborador);

            if (id == 0)
            {
                ModelState.AddModelError("DPI", "El DPI ya está registrado.");
                colaborador.Departamentos = await ObtenerDepartamentos();
                return View(colaborador);
            }

            return RedirectToAction("Index");
        }

        //CARGAR VISTA EDITAR
        public async Task<IActionResult> Editar(int id)
        {
            var colaborador = await repositorioColaboradores.ObtenerPorId(id);

            if (colaborador == null)
            {
                return RedirectToAction("NoEncontrado", "Home");
            }


            //SETTEANDO VALORES CON AUTOMAPPER
            var modelo = mapper.Map<ColaboradorCreacionViewModel>(colaborador);

            modelo.Departamentos = await ObtenerDepartamentos();

            return View(modelo);
        }

        //EDITAR DEP
        [HttpPost]
        public async Task<IActionResult> Editar(ColaboradorCreacionViewModel coladoradorEditar)
        {
            var colaborador = await repositorioColaboradores.ObtenerPorId(coladoradorEditar.Id);

            if (colaborador == null)
            {
                return RedirectToAction("NoEncontrado", "Home");
            }

            var departamento = await repositorioDepartamentos.ObtenerPorId(coladoradorEditar.DepartamentoId);

            if (departamento == null)
            {
                return RedirectToAction("NoEncontrado", "Home");
            }

            var resultado = await repositorioColaboradores.Editar(coladoradorEditar);

            if (resultado == 0)
            {
                ModelState.AddModelError("DPI", "El DPI ya está registrado.");
                coladoradorEditar.Departamentos = await ObtenerDepartamentos();
                return View(coladoradorEditar);
            }

            return RedirectToAction("Index");
        }

        //CARGAR VISTA BORRAR
        public async Task<IActionResult> Borrar(int id)
        {
            var colaborador = await repositorioColaboradores.ObtenerPorId(id);
            if (colaborador == null)
            {
                return RedirectToAction("Home", "NoEncontrado");
            }
            return View(colaborador);
        }

        //BORRAR DEP
        [HttpPost]
        public async Task<IActionResult> BorrarColaborador(int id)
        {
            var colaborador = await repositorioColaboradores.ObtenerPorId(id);
            if (colaborador == null)
            {
                return RedirectToAction("Home", "NoEncontrado");
            }
            await repositorioColaboradores.Borrar(id);
            return RedirectToAction("Index");

        }

        private async Task<IEnumerable<SelectListItem>> ObtenerDepartamentos()
        {
            var Departamentos = await repositorioDepartamentos.Buscar();
            return Departamentos.Select(x => new SelectListItem(x.Nombre, x.Id.ToString()));
        }
    }
}
