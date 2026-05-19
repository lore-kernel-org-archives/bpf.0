Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D88840803F;
	Tue, 19 May 2026 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208125; cv=none; b=r89sPSlQ0vr2vZV8QykyRP7OnGBJ49sZMM+R5+/qpV6GGiOizgKHYOspmilFpINL8VrDRNnZMa5IGGLIAZZ8J8LDbDiSB7oiHwpr3XMvw7h4+73Y+QrOElcQQE4mVwag8VNGVgHfGbbfTkMxSEWVsMBTVt/IOoOnyTEJ8HizEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208125; c=relaxed/simple;
	bh=wkbJ4WV4ydeiB6L02Yks8hyZyILbcfbwA8MZQrQj9AE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LiSnCSENO6isgRCcpzZfXJv3dCv1a6/MoIKOfZGPpJKTv/EyjtrtwXUlFr9JH6CqbRQ8nXrv/FGeVYaopIrxpy6p5zHLPRPOrpmuUNfPP1Ma09sInlsDx/94S/Ktczwvlacb8lXAHZClpQxTbrf5W3S+2ig02wHPgd6o9yBXz2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id CFED1C1AFB;
	Tue, 19 May 2026 16:28:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 8056C20010;
	Tue, 19 May 2026 16:28:37 +0000 (UTC)
Date: Tue, 19 May 2026 12:28:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
Message-ID: <20260519122836.0bfded70@fedora>
In-Reply-To: <20260520002640.d372bd044ceba9364b1f168f@kernel.org>
References: <20260518232312.0c78f055@gandalf.local.home>
	<20260519185302.5fb527085a64567a388f24f3@kernel.org>
	<20260519083128.5795c6af@gandalf.local.home>
	<20260520002640.d372bd044ceba9364b1f168f@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8056C20010
X-Rspamd-Server: rspamout06
X-Stat-Signature: p5wyjdtyqrzq7zkr5kdh1wtq57htp8wa
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/HFSMlBAH252OTplepd1WfPZWv99wzgeU=
X-HE-Tag: 1779208117-803839
X-HE-Meta: U2FsdGVkX181h80Qk1ZbJ8RKwc74Hf4SIEno10clTyGAHeFSmxOMtgl8O6Y5Xk8v+uagn4F5ATL19WUPqdlcV6tWA2DSpxMuax64BwtW54zkTrs9pZL2XAD1u3CiGfwlwI6SWQJG1hXae18a5eRXl72jnNYt3zN5RjEx2D8SjZ1mUQHGhoGoK/eyAHWIUwaUnLVs13UjCgmI4c6lEyZ2pLc4X5AHHmq2PIAzxeWu4mFoHLJlwQVpcmQc+l+0oOrLmMNYLYSD6lzlCViG/mg/Q/L0q7o7A7QUrJkzsP/oT2twqHTpQVLlGZ3v9TVPGuWghLPVPja9rmkKW3Itf9awDumlZY9P3eyx

On Wed, 20 May 2026 00:26:40 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > Hmm, it may be better to make it one parenthesis?
> > 
> >        (STRUCT,PTR,ASSIGN)->FIELD
> > 
> >        data=(foo,foo_list,list)->data  
> 
> OK, but I don't like this 3 parameters conversion. I want to
> make it a kind of type casting with an option.
> 
> 	(STRUCT,ASSIGN)PTR->FIELD
> 
> 	data=(foo,list)foo_list->data
> 
> The second parenthesis will be eventually needed for nested casting,
> for example, in above case, if the data is a pointer to another data
> structure:
> 
> struct bar {
> 	int	value;
> 	...
> };
> 
> 	value=(bar)((foo,list)foo_list->data)->value

Have fun with the parenthesis parsing ;-)

> 
> 
> > 
> > That would make it easier to differentiate between a simple "typecast" and
> > a container_of() by checking if the content between the parenthesis has a
> > comma.
> > 
> > Maybe even reorder it to:
> > 
> >        (PTR,STRUCT,ASSIGN)->FIELD
> > 
> >        data=(foo_list,foo,list)->data
> > 
> > to match the order of container_of():
> > 
> >       data = container_of(foo_list, struct foo, list)->data;
> > 
> > ?  
> 
> This doesn't seem to conform to the rule here of using parentheses for
> type casting, so I personally don't like it.

OK, as long as it's intuitive and is easy to remember. I hate having to
look up the documents every time I have to do some probe argument
parsing :-(

> 
> 
> > > > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > > > index e0d3a0da26af..b0829eb1cb52 100644
> > > > --- a/kernel/trace/trace_probe.c
> > > > +++ b/kernel/trace/trace_probe.c
> > > > @@ -464,6 +464,26 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
> > > >  	return NULL;
> > > >  }
> > > >  
> > > > +static int query_btf_struct(const char *sname, struct traceprobe_parse_context *ctx)
> > > > +{
> > > > +	int id;
> > > > +
> > > > +	if (!ctx->btf) {
> > > > +		struct btf *btf;    
> > > 
> > > This needs an empty line here.  
> > 
> > Sure.
> > 
> > For conditional blocks, I don't always add a newline, but this is your code
> > and I'll follow your suggestions.  
> 
> Ah, this is just for fixing checkpatch.pl warning :-)

I added it to keep your checkpatch happy.


> > > > @@ -471,12 +491,12 @@ static int query_btf_context(struct traceprobe_parse_context *ctx)
> > > >  	struct btf *btf;
> > > >  	s32 nr;
> > > >  
> > > > -	if (ctx->btf)
> > > > -		return 0;
> > > > -
> > > >  	if (!ctx->funcname)
> > > >  		return -EINVAL;
> > > >  
> > > > +	if (ctx->btf)
> > > > +		return 0;
> > > > +    
> > > 
> > > Could you tell me why this order is changed?
> > > I think this type casting will allow us to skip checking funcname
> > > because btf context is already specified.  
> > 
> > I wanted this to fail if btf was already set but funcname wasn't, because
> > this should only be called for functions.  
> 
> Hmm, OK. Then, can you make a separate patch for this?

I added a struct_btf (I can change it to typecast_btf) and have a
helper function that is:

static struct btf *ctx_btf(struct traceprobe_parse_context *ctx)
{
	return ctx->flags & TPARG_FL_STRUCT ?
		ctx->struct_btf : ctx->btf;
}

And have all functions get their btf from that. This way we can keep
the two allocations separate.

> 
> >   
> > > 
> > > Ah, BTW, we may need to use a special struct btf* for type
> > > casting. If the target function is in a module and the
> > > casting type is defined in vmlinux, those are stored in
> > > the different places...  
> > 
> > OK, I'll make a separate btf for it then. I'll have to make sure the btf
> > used for parsing knows which one to use. Shouldn't be too hard if we check
> > for the STRUCT flag in the ctx->flags.  
> 
> Yeah, and personally, I think that flag should be the TYPECAST flag.

I'll update it.

Thanks,

-- Steve
