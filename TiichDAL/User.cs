//------------------------------------------------------------------------------
// <auto-generated>
//     Ce code a été généré à partir d'un modèle.
//
//     Des modifications manuelles apportées à ce fichier peuvent conduire à un comportement inattendu de votre application.
//     Les modifications manuelles apportées à ce fichier sont remplacées si le code est régénéré.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TiichDAL
{
    using System;
    using System.Collections.Generic;
    
    public partial class User
    {
        public User()
        {
            this.Workshop = new HashSet<Workshop>();
            this.SeenWorkshop = new HashSet<Workshop>();
            this.ParticipateAt = new HashSet<Workshop>();
        }
    
        public string Password { get; set; }
        public string Email { get; set; }
        public string Bio { get; set; }
        public string Phone { get; set; }
        public string Avatar { get; set; }
        public Nullable<System.DateTime> Birthday { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int ID { get; set; }
    
        public virtual ICollection<Workshop> Workshop { get; set; }
        public virtual ICollection<Workshop> SeenWorkshop { get; set; }
        public virtual ICollection<Workshop> ParticipateAt { get; set; }
    }
}
