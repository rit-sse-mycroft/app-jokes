using System;
using System.Speech.Recognition.SrgsGrammar;

public class Grammar
{
    private SrgsDocument doc;

	public Grammar()
	{
        doc = new SrgsDocument();

        SrgsRule rule = new SrgsRule("joke");

        SrgsItem joke = new SrgsItem("Mycroft tell me a joke");

        rule.Add(question);
        rule.Scope = SrgsRuleScope.Public;

        doc.Rules.Add(rule);
        doc.Root = rule;
	}

    public SrgsDocument SRGS()
    {
        return doc;
    }
}
