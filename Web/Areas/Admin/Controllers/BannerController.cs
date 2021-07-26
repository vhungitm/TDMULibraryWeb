using System.Web.Mvc;

namespace Web.Areas.Admin.Controllers
{
    public class BannerController : BaseController
    {
        public ActionResult Index(int status = 2, int page = 1)
        {
            ViewBag.status = status;
            ViewBag.page = page;

            return View();
        }
    }
}