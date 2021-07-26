using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Model.EF;
using Model.DAO;

namespace Web.Areas.API.Controllers
{
    public class BookController : Controller
    {
        BookDAO dao = new BookDAO();

        [HttpGet]
        public JsonResult Gets(string key = "", string author = "", string category = "", string publisher = "", int publishYear = 0, int status = 2, int page = 1, int pageSize = 5)
        {
            try
            {
                List<Book> data = dao.Gets(key, author, category, publisher, publishYear, status, page, pageSize);
                int totalRow = dao.Count(key, category, publisher, publishYear, status);

                return Json(new
                {
                    data = data,
                    totalRow = totalRow
                }, JsonRequestBehavior.AllowGet);
            } 
            catch (Exception)
            {
                return Json(new
                {
                    data = DBNull.Value.ToString()
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult Get(string id)
        {
            try
            {
                Book data = dao.Get(id);

                return Json(new
                {
                    data = data
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(new
                {
                    data = DBNull.Value.ToString()
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult GetQuantityInStock(long id)
        {
            try
            {
                int data = dao.GetQuantityInStock(id);

                return Json(new
                {
                    data = data
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(new
                {
                    data = DBNull.Value.ToString()
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult Insert(Book model)
        {
            try
            {
                int status =  dao.Insert(model);

                return Json(new
                {
                    status = status
                });
            }
            catch (Exception)
            {
                return Json(new
                {
                    status = 0
                });
            }
        }

        [HttpPut]
        public JsonResult Update(Book model)
        {
            try
            {
                int status = dao.Update(model);

                return Json(new
                {
                    status = status
                });
            }
            catch (Exception)
            {
                return Json(new
                {
                    status = 0
                });
            }
        }

        [HttpPut]
        public JsonResult UpdateStatus(long id)
        {
            try
            {
                int status = dao.UpdateStatus(id);

                return Json(new
                {
                    status = status
                });
            }
            catch (Exception)
            {
                return Json(new
                {
                    status = 0
                });
            }
        }

        [HttpDelete]
        public JsonResult Delete(long[] id)
        {
            try
            {
                int[] status = new int[id.Length];

                for (int i = 0; i < id.Length; i++)
                {
                    status[i] = dao.Delete(id[i]);
                }

                return Json(new
                {
                    status = status
                });
            }
            catch (Exception)
            {
                return Json(new
                {
                    status = 0
                });
            }
        }
    }
}