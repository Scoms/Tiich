﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TiichRepository.Interface;
using TiichRepository.Repository;
using TiichService.Interface;
using Utils;

namespace TiichService.Service
{
    public class ServiceGeneric<T> : IService<T> where T :class
    {
        protected GenericRepository<T> _repo;

        public void Add(T obj, ErrorHandler eh)
        {
            GenericTests(obj, eh);

            if (!eh.hasErrors())
                _repo.Add(obj,eh);
        }

        public void Edit(T obj, ErrorHandler eh)
        {
            GenericTests(obj, eh);

            if (!eh.hasErrors())
                _repo.Edit(obj, eh);
        }

        public void Delete(int id, ErrorHandler eh)
        {
            throw new NotImplementedException();
        }

        virtual public void GenericTests(T obj, ErrorHandler eh)
        {
            // rien de generic
        }
    }
}