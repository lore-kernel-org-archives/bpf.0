Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF174368D7C;
	Thu, 21 May 2026 02:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332169; cv=none; b=jA7csMOotjUxn4iDIB5BsXc68eahJEU+552DbY03Hcd3LKK24wRMPcl/C1SAqJYC6Fk3WqCqvBnj+nSfWO50xcA0mgo3HGNJpTHKtnUxsNGnZL1CxyvXtrQ6mqyghF3xdzRqx/OhC6YR9uq6UMRgt2ImF28E5WWPNRIzcee2DAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332169; c=relaxed/simple;
	bh=pgrfirlt1XO7S9Mk+SK0oYJHLlmdsBVoEuYBG/wqY3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUt7AK1jvBzE2uOJrGzCuwzfnbOE7SMFUABTB1IexwOrn1GWdThzV0xaLRztxuxfGTwVf2Kx3pbTY1drfR4LKba5Hm9PxBTj10apGiS3nUPxWbA3Q1ETHJmRNXrn8Rxz5s6ffIBm05fsDaBrX4444B1b+YWbyapLS2pd6xNecUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id B9923A04D5;
	Thu, 21 May 2026 02:55:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id C7B5733;
	Thu, 21 May 2026 02:55:57 +0000 (UTC)
Date: Wed, 20 May 2026 22:55:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 bpf@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux trace
 kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260520225556.6e4104d2@fedora>
In-Reply-To: <20260521105804.a66cf40d48f796ff66ffface@kernel.org>
References: <20260519130144.40e71a00@fedora>
	<20260519174848.176A6C2BCB3@smtp.kernel.org>
	<20260519141726.613e2e54@fedora>
	<20260520152021.350e7017551ef202aace4cd5@kernel.org>
	<20260520124832.737a946a@gandalf.local.home>
	<20260521105804.a66cf40d48f796ff66ffface@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kepod7ba48jgakdzpn3js8m4q57bcy6t
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: C7B5733
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19H8wQoAeMFjUpyP57C2U/FrJAx4NAZmPk=
X-HE-Tag: 1779332157-947568
X-HE-Meta: U2FsdGVkX18uQmfm1xIP7KAsF3lCAmsLgX6WoI1yiBTsjqBB1VrpFIgB4YEK5wukQWOgrNsAnko6DsvBFuv/rDgeD296QzojxiqK8if6qTTEcYIYq2te9tI9gOfxPA92iiWf8TTV03qEHTaTSxZF9vAWluxs6K8V6JIh4Rv9xNhrtO9wdBMG755dL78ksPzohRj9R+yGO+JiU0TXukyWfXILVztlxO8drO9j58cUp0DefIfeBSn0tWLs/0ge4icBAOwSiqLzOFoUSIahQrF8o1SFt25DT2rTYKeecOaPdtnhKJUPJ+syDrBeRy0eE8+XlYuZi7faG7Y7+pfYhmYBygpbRyss0cl5UhrYkf2gMtY90L5DW7r8aQG3EkTL1MLLp9vX3tDgCdqVE4cGXjGdvw==

On Thu, 21 May 2026 10:58:04 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 20 May 2026 12:48:32 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 20 May 2026 15:20:21 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >   
> > > > > > @@ -515,6 +542,10 @@ static void clear_btf_context(struct traceprobe_parse_context *ctx)
> > > > > >  		ctx->params = NULL;
> > > > > >  		ctx->nr_params = 0;
> > > > > >  	}
> > > > > > +	if (ctx->struct_btf) {
> > > > > > +		btf_put(ctx->struct_btf);
> > > > > > +		ctx->last_struct = NULL;      
> > > > > 
> > > > > [Severity: Low]
> > > > > Should ctx->struct_btf be explicitly set to NULL after btf_put() drops
> > > > > the reference?    
> > > > 
> > > > I'm thinking of dropping it in the '(' switch case.    
> > > 
> > > Can you consider making the '(' switch case part as a helper
> > > function because it depends on CONFIG_DEBUG_INFO_BTF?  
> > 
> > Should we just encapsulate that entire case statement with:
> > 
> > #ifdef CONFIG_DEBUG_INFO_BTF
> > [..]
> > #endif  
> 
> Yeah that is possible, and I rather like to make it a separate
> function for simplifying switch-case block for readability.
> 

Hmm, but as a separate function, you mean something like this?

	case '(':
		ret = handle_typecast(...);
		break;

And have;

#ifdef CONFIG_DEBUG_INFO_BTF
static int handle_typecast(...)
{
	[ do the real work here ]
}
#else
static int handle_typecast(...)
{
	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
	return -EOPNOTSUPP;
}
#endif

  ?

-- Steve
