using System.Web.Mvc;

namespace Web.Areas.Admin.Controllers
{
    public class CategoryController : BaseController
    {
        public ActionResult Index(string key = "", int page = 1)
        {
            ViewBag.key = key;
            ViewBag.page = page;

            return View();
        }
    }
}