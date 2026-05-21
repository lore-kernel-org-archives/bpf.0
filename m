Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38BD27FB2A;
	Thu, 21 May 2026 01:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779328688; cv=none; b=VH+FI2JCJmCLwfRKFvzr9nubMxIYDaICXlnj0iMSWBaYC33+GhObsqFNFoRaMlcBGQ07uw4cvqJ6GeXbqnpJKrq90zU7nXerhIJGwNUUhHT02sVQcZ+Zcawi+A/PNbP9yHdhDCAlx3KEE8m2SDqvHFZjqglCfv2nwQljnZKkUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779328688; c=relaxed/simple;
	bh=LJrrC/kUTyHGONWWmOe8duskx0uC0LM62/ZIvjAZhtU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XDeBabDZogOXYh0nrsMsT3yyKn8STa5OLrbS/m7P4UGsrP1+cd88heNfggCeJEU9RJWu35WSG/v3fLXrMifEy1ZPpB7P7wM8W+an2Qb2iLB2T6Xb8ahkPNbch8RMfELf9Mnzx5e+MYjk+EdjSrcE5FBmxpd78TL9W64CtMhLFFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bsfhzp8n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bsfhzp8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AE71F000E9;
	Thu, 21 May 2026 01:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779328687;
	bh=O+zt/3jmAWiawk5JC2/3AugCj/iMHmuRP6iadlMzo18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Bsfhzp8nMswzcW9T/HWr3TkBuBSffR84SZXDrSLCHYtbIU8nijMF0F/XTYOcW7LT2
	 WFuMbnlYw5wcCKPhNwxG0hgQKa/KbFek7QGfhSNr3N1akC14C5yXOn7cieu0fWrJJ9
	 XQK/5tGhNV1T1aHQ0EYY+xGJEyWekWYkYBQx6UcYMKvZ1MSmr8H6PQz+DliFY9QBQ1
	 oLh/DrN4W1YZhhah1msCMcsfux2AwrpnZMYfEzqlg5Be/5ErBWZkYmjNvf4qne4OCS
	 QDhXb2h/WBzQeWiYkBfdkmMkPtbZcpeIpY6IR76/eQJEbXQWFwDheKnKVV4SrYJSzj
	 eCLAKTTdBF1NA==
Date: Thu, 21 May 2026 10:58:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 bpf@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux trace
 kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-Id: <20260521105804.a66cf40d48f796ff66ffface@kernel.org>
In-Reply-To: <20260520124832.737a946a@gandalf.local.home>
References: <20260519130144.40e71a00@fedora>
	<20260519174848.176A6C2BCB3@smtp.kernel.org>
	<20260519141726.613e2e54@fedora>
	<20260520152021.350e7017551ef202aace4cd5@kernel.org>
	<20260520124832.737a946a@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 12:48:32 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 20 May 2026 15:20:21 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > > > @@ -515,6 +542,10 @@ static void clear_btf_context(struct traceprobe_parse_context *ctx)
> > > > >  		ctx->params = NULL;
> > > > >  		ctx->nr_params = 0;
> > > > >  	}
> > > > > +	if (ctx->struct_btf) {
> > > > > +		btf_put(ctx->struct_btf);
> > > > > +		ctx->last_struct = NULL;    
> > > > 
> > > > [Severity: Low]
> > > > Should ctx->struct_btf be explicitly set to NULL after btf_put() drops
> > > > the reference?  
> > > 
> > > I'm thinking of dropping it in the '(' switch case.  
> > 
> > Can you consider making the '(' switch case part as a helper
> > function because it depends on CONFIG_DEBUG_INFO_BTF?
> 
> Should we just encapsulate that entire case statement with:
> 
> #ifdef CONFIG_DEBUG_INFO_BTF
> [..]
> #endif

Yeah that is possible, and I rather like to make it a separate
function for simplifying switch-case block for readability.

Thank you,

> 
>  ?
> 
> -- Steve
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
