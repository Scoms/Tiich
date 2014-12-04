﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using java.io;
using java.util;
using edu.stanford.nlp.ling;
using edu.stanford.nlp.tagger.maxent;

namespace ApiController.WordExtraction
{
    public class HomeMadeExtraction : IRelevantWords
    {
        public List<string> Extract(string text)
        {
            List<string> keywords = new List<string>();

            // Loading POS Tagger
            try
            {
                string cheminFrench = @"C:\Users\Eleonore\Source\Repos\Tiich\ApiController\WordExtraction\Dictionnary\french.tagger";

                var tagger = new edu.stanford.nlp.tagger.maxent.MaxentTagger(cheminFrench);
                //var tagger = new edu.stanford.nlp.tagger.maxent.MaxentTagger(edu.stanford.nlp.tagger.maxent.MaxentTagger.DEFAULT_NLP_GROUP_MODEL_PATH+@"\french.tagger");
                

                var sentences = MaxentTagger.tokenizeText(new StringReader(text)).toArray();
                foreach (ArrayList sentence in sentences)
                {
                    var taggedSentence = tagger.tagSentence(sentence);

                    ListIterator it = taggedSentence.listIterator();

                    while (it.hasNext())
                    {
                        TaggedWord w = (TaggedWord)it.next();
             
                        if (w.tag().Equals("NC"))
                            keywords.Add(w.value());
                        if (w.tag().Equals("NPP"))
                            keywords.Add(w.value());
                    }
                }
            }
            catch (Exception e)
            {
                e.ToString();
            }
            return keywords;

            //throw new NotImplementedException();
        }

        private static string RemoveSpecialCaracters(string text)
        {
            throw new NotImplementedException();
        }

        public List<string> Extract(List<string> lString)
        {
            List<string> res = new List<string>();
            foreach (string s in lString)
            {
                //if(!)
                res.AddRange(Extract(s));
            }
            return res;
        }
    }
}
