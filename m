Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF74408004;
	Tue, 19 May 2026 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204405; cv=none; b=eBirz8fPJUBkgYFOlbbO5H9ELzxgVt66BSYNV5UhhYEm0GwybOZunkeYyIe7XjSd0gG+qeGHtvAj67sPJRIMFBm/cPgu/xkYLF+smWXS6Pt+wk3ZvHTYX7/alJGO/qmoTwVk43hRRV0bB4Uzj+psjUDRue7D8AZytIHORf3bm90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204405; c=relaxed/simple;
	bh=DNTJvRmMRi4offeiUVL2k3hnBa0Ow5+gC3xtFfZDCtI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s4JzwnuYTPHPckJLVrR9XV8c8HJ8opcymAleYBu2L4c+srmQHL2iYXM6eVdXLbYU6fExgUhSwxNsupWIPutp5Xt9AU4UjN4y2sG00NWlvXrP7kpNEn0+sKFZfhmNW30sYwjTI1tWus1WuPHXE6qTCE5LNSRPsCzY3aBloybyCFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKpbOIu4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKpbOIu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B73C2BCB3;
	Tue, 19 May 2026 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779204405;
	bh=DNTJvRmMRi4offeiUVL2k3hnBa0Ow5+gC3xtFfZDCtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pKpbOIu47JTsvRy8/Jfd9LYt9HCNaBCdTADrCktxE39I9ErqzvKDRzhQQqtjdv5FD
	 QhxsyS09QzbaE/xWYSTpu3Gvpxt5vqtEgcJh2WNPA4ox+fDA4lsAdyAcwHM5k5X7JZ
	 jz1lgPZ3p4n/1atBfdh5yhNnFUAjFVNcHcdjnPVk//LvWkScTBT8ylZ1rsXkaF2XR3
	 mdn3vzW5tBr/PdYqngzbLKnD2+LaGTdY19+alHGV5Q24m7qvh678/T8cHBGxZK8Xk0
	 eWQrjAa4lIjPPfQ1v3IcwG870QeSY4mgncmjW1Mn5mwSndYQXQX4n+wC2pMq4xZJCs
	 JFAFV0oDTGL7Q==
Date: Wed, 20 May 2026 00:26:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Namhyung Kim
 <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH v4] tracing/probes: Allow use of BTF names to
 dereference pointers
Message-Id: <20260520002640.d372bd044ceba9364b1f168f@kernel.org>
In-Reply-To: <20260519083128.5795c6af@gandalf.local.home>
References: <20260518232312.0c78f055@gandalf.local.home>
	<20260519185302.5fb527085a64567a388f24f3@kernel.org>
	<20260519083128.5795c6af@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 08:31:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > 
> > To access @data, simple casting does not work. Thus we need a
> > new syntax:
> > 
> > 	(STRUCT)(PTR,ASSIGN)->FIELD
> > 
> > So the above case, we can do:
> > 
> > 	data=(foo)(foo_list,list)->data
> 
> Hmm, it may be better to make it one parenthesis?
> 
>        (STRUCT,PTR,ASSIGN)->FIELD
> 
>        data=(foo,foo_list,list)->data

OK, but I don't like this 3 parameters conversion. I want to
make it a kind of type casting with an option.

	(STRUCT,ASSIGN)PTR->FIELD

	data=(foo,list)foo_list->data

The second parenthesis will be eventually needed for nested casting,
for example, in above case, if the data is a pointer to another data
structure:

struct bar {
	int	value;
	...
};

	value=(bar)((foo,list)foo_list->data)->value


> 
> That would make it easier to differentiate between a simple "typecast" and
> a container_of() by checking if the content between the parenthesis has a
> comma.
> 
> Maybe even reorder it to:
> 
>        (PTR,STRUCT,ASSIGN)->FIELD
> 
>        data=(foo_list,foo,list)->data
> 
> to match the order of container_of():
> 
>       data = container_of(foo_list, struct foo, list)->data;
> 
> ?

This doesn't seem to conform to the rule here of using parentheses for
type casting, so I personally don't like it.


> > > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > > index e0d3a0da26af..b0829eb1cb52 100644
> > > --- a/kernel/trace/trace_probe.c
> > > +++ b/kernel/trace/trace_probe.c
> > > @@ -464,6 +464,26 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
> > >  	return NULL;
> > >  }
> > >  
> > > +static int query_btf_struct(const char *sname, struct traceprobe_parse_context *ctx)
> > > +{
> > > +	int id;
> > > +
> > > +	if (!ctx->btf) {
> > > +		struct btf *btf;  
> > 
> > This needs an empty line here.
> 
> Sure.
> 
> For conditional blocks, I don't always add a newline, but this is your code
> and I'll follow your suggestions.

Ah, this is just for fixing checkpatch.pl warning :-)

> 
> > 
> > > +		id = bpf_find_btf_id(sname, BTF_KIND_STRUCT, &btf);
> > > +		if (id < 0)
> > > +			return -EINVAL;  
> > 
> > Why don't you return id (it has corresponding errno)?
> 
> Because I forgot to ;-)
> 
> > 
> > > +		ctx->btf = btf;
> > > +	} else {
> > > +		id = btf_find_by_name_kind(ctx->btf, sname, BTF_KIND_STRUCT);
> > > +		if (id < 0)
> > > +			return -EINVAL;  
> > 
> > Ditto.
> > 
> > > +	}
> > > +
> > > +	ctx->last_struct = btf_type_by_id(ctx->btf, id);
> > > +	return 0;
> > > +}
> > > +
> > >  static int query_btf_context(struct traceprobe_parse_context *ctx)
> > >  {
> > >  	const struct btf_param *param;
> > > @@ -471,12 +491,12 @@ static int query_btf_context(struct traceprobe_parse_context *ctx)
> > >  	struct btf *btf;
> > >  	s32 nr;
> > >  
> > > -	if (ctx->btf)
> > > -		return 0;
> > > -
> > >  	if (!ctx->funcname)
> > >  		return -EINVAL;
> > >  
> > > +	if (ctx->btf)
> > > +		return 0;
> > > +  
> > 
> > Could you tell me why this order is changed?
> > I think this type casting will allow us to skip checking funcname
> > because btf context is already specified.
> 
> I wanted this to fail if btf was already set but funcname wasn't, because
> this should only be called for functions.

Hmm, OK. Then, can you make a separate patch for this?

> 
> > 
> > Ah, BTW, we may need to use a special struct btf* for type
> > casting. If the target function is in a module and the
> > casting type is defined in vmlinux, those are stored in
> > the different places...
> 
> OK, I'll make a separate btf for it then. I'll have to make sure the btf
> used for parsing knows which one to use. Shouldn't be too hard if we check
> for the STRUCT flag in the ctx->flags.

Yeah, and personally, I think that flag should be the TYPECAST flag.
 
Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
