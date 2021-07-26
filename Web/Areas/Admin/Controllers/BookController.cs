using System.Web.Mvc;
using Model.DAO;

namespace Web.Areas.Admin.Controllers
{
    public class BookController : BaseController
    {
        public ActionResult Index(string key = "", string category = "", string publisher = "", int publishYear = 0, int status = 2, int page = 1)
        {
            ViewBag.key = key;
            
            ViewBag.categoryId = category;
            ViewBag.categoryName = category != "" ? new CategoryDAO().Get(category).Name : "Tất cả sách";

            ViewBag.publisherId = publisher;
            ViewBag.publisherName = publisher != "" ? new PublisherDAO().Get(publisher).Name : "Tất cả sách";

            ViewBag.publishYear = publishYear;
            ViewBag.status = status;
            ViewBag.page = page;

            return View();
        }
    }
}