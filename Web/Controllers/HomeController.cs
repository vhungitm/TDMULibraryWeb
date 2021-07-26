using System.Web.Mvc;
using Model.DAO;
using Web.Global;
using Model;

namespace Web.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index(string category = "", string publisher = "", int publishYear = 0, int page = 1, int pageSize = 6)
        {
            ViewBag.category = category;
            ViewBag.categoryName = category != "" ? new CategoryDAO().Get(category).Name : "Tất cả thể loại";

            ViewBag.publisher = publisher;
            ViewBag.publisherName = publisher != "" ? new PublisherDAO().Get(publisher).Name : "Tất cả nhà xuất bản";

            ViewBag.publishYear = publishYear;

            ViewBag.page = page;
            ViewBag.pageSize = pageSize;

            return View();
        }

        public PartialViewResult SlidePartial()
        {
            var bannerDAO = new BannerDAO();

            return PartialView(bannerDAO.Gets(1, 0, 0));
        }

        public PartialViewResult _NavbarCategoryPartial()
        {
            var categoryDAO = new CategoryDAO();
            var categories = categoryDAO.Gets("", 0, 0);

            return PartialView(categories);
        }

        public PartialViewResult _NavbarPublisherPartial()
        {
            var publisherDAO = new PublisherDAO();
            var categories = publisherDAO.Gets("", 0, 0);

            return PartialView(categories);
        }

        public PartialViewResult CategoryPartial()
        {
            var categoryDAO = new CategoryDAO();
            var categories = categoryDAO.Gets("", 0, 0);

            return PartialView(categories);
        }

        public PartialViewResult PublisherPartial()
        {
            var publisherDAO = new PublisherDAO();
            var publishers = publisherDAO.Gets("", 0, 0);

            return PartialView(publishers);
        }

        public ActionResult Login()
        {
            var user = (User)Session[Constants.USER];
            if (user != null)
            {
                return Redirect("/");
            }

            return View();
        }

        public ActionResult Contact()
        {
            return View();
        }

        public ActionResult Introduce()
        {
            return View();
        }
    }
}