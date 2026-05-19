Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47BA233947;
	Tue, 19 May 2026 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193886; cv=none; b=HGuWKbPtI/wPDed6f/NWFsZdosN6uoryRdYqENiVu2OZd6zDHtCz9aJ5I2p/jcXpjh5tpY3F0BuIcoQzvxFT2diVFIx+Sn+nU0KYOKmkBOxO3dpGgSuD+CYMTgLkdpNMgNdB6noRVVjsFC++0EV/UyYJhTR84vsDY1/be+QERgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193886; c=relaxed/simple;
	bh=irdEARsUY/799+d5PIx4NjR6fRgqB0VoX0iyPcgyTfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CF6nWKwX26AOsf8tTnAH3LZdGi6lqCIJKBeRkDnrmoqwQX68t4Yc2bz2qPWMEdZ7xrAcFBe4UfYJwJoujeCURO/zRZgiA1cppQOrPv39Ebyj7eqtJi7bAq5ipQY4KdjaeuV4wDNH90bBQKOQbMTjk9/Zpu2YlD4PO22f03yZPb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 982ACC1791;
	Tue, 19 May 2026 12:31:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 21D2817;
	Tue, 19 May 2026 12:31:12 +0000 (UTC)
Date: Tue, 19 May 2026 08:31:28 -0400
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
Message-ID: <20260519083128.5795c6af@gandalf.local.home>
In-Reply-To: <20260519185302.5fb527085a64567a388f24f3@kernel.org>
References: <20260518232312.0c78f055@gandalf.local.home>
	<20260519185302.5fb527085a64567a388f24f3@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 21D2817
X-Stat-Signature: zwkjfey7d6pb8qo4xjwtrdd13zj5n5k8
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+rDOXmIL87qB7jsKYFU+X9z/3f4Bg6Dds=
X-HE-Tag: 1779193872-357857
X-HE-Meta: U2FsdGVkX19rSaAw6l57NoZvFerrq/nFBEAwmGs8zpTJxAGA+SNZ2x4DVTFgZPAO/hypWT2JAnaUDw/P1xssvGeKyqU+daKcmqugjTsETVOWB+uPpvpy5329imGNEdkWVvJeEOwSbiByRvw3KNlPnj0yvD8R48SjoI7XJxpy/Au8w17zYS+DHpGne2rnK/wvkpwUut7m+rUwApuzf7pOeGW2xograSa3ps6O2aPqQFN1UUM7wDDXB2eLuVMvR9gr2rMyklhYwxGsIQLy56AhdF6j2dmjK5Is2OgpkJWjJf3eiIQMvm3w/w9p4D8N3AFy+n4Yv4yLVBmcDGdcHVHinCCqayTce2jorqWxiDy1x1q9NYuhGg/ka7vANiYKVik+nEYwC37Lm3Zc2vJwFW59tssRqnjiymVOODvJH9jQIYMkHgy951Ytg2hsyWodoSI/UHcvcg5eeByqxclPU6TI70QM1m5bEZO1SO4cEJ7gtXA=

On Tue, 19 May 2026 18:53:02 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > If BTF is in the kernel, then instead, the $skbaddr can be typecast to
> > sk_buff and use the normal dereference logic.
> > 
> >   # echo 'e:xmit net.net_dev_xmit (sk_buff*)$skbaddr->dev->name:string' >> dynamic_events  
> 
> Ah, eprobes supports "$PARAM" to access its parameter by name.
> That is a bit complicated. Should we allow user to access
> parameter without '$' prefix for eprobes?

I guess.

> 
> >   # echo 1 > events/eprobes/xmit/enable
> >   # cat trace
> > [..]
> >     sshd-session-1022    [000] b..2.   860.249343: xmit: (net.net_dev_xmit) arg1="enp7s0"
> >     sshd-session-1022    [000] b..2.   860.250061: xmit: (net.net_dev_xmit) arg1="enp7s0"
> >     sshd-session-1022    [000] b..2.   860.250142: xmit: (net.net_dev_xmit) arg1="enp7s0"
> >     sshd-session-1022    [000] b..2.   860.263553: xmit: (net.net_dev_xmit) arg1="enp7s0"
> >     sshd-session-1022    [000] b..2.   860.283820: xmit: (net.net_dev_xmit) arg1="enp7s0"
> >     sshd-session-1022    [000] b..2.   860.302716: xmit: (net.net_dev_xmit) arg1="enp7s0"
> >     sshd-session-1022    [000] b..2.   860.322905: xmit: (net.net_dev_xmit) arg1="enp7s0"
> >     sshd-session-1022    [000] b..2.   860.342828: xmit: (net.net_dev_xmit) arg1="enp7s0"
> >     sshd-session-1022    [000] b..2.   860.362268: xmit: (net.net_dev_xmit) arg1="enp7s0"
> >     sshd-session-1022    [000] b..2.   860.382335: xmit: (net.net_dev_xmit) arg1="enp7s0"
> >     sshd-session-1022    [000] b..2.   860.400856: xmit: (net.net_dev_xmit) arg1="enp7s0"
> >     sshd-session-1022    [000] b..2.   860.419893: xmit: (net.net_dev_xmit) arg1="enp7s0"  
> 
> Looks very nice!
> 
> > 
> > The syntax is simply: ([STRUCT]*)(VAR)->FIELD[->FIELD..]  
> 
> Is the STRUCT optional?? (because [] means optional.) I guess no.

Oops, no, I was tired when I wrote this, and just put '[' and ']' to make
it a variable. But I wasn't consistent. I'll fix that to be:

  The syntax is simply: (STRUCT*)(VAR)->FIELD[->FIELD..]  

> 
> I think we maybe possible to skip '*' (Or, make it optional)
> because this is not C-like typecasting, we don't support "struct"
> reserved word, and it does not support white-spaces in each
> fetcharg. In this case, (STRUCT)VAR->FIELD should work.

I could remove the '*' as it doesn't support the "struct" C word.

> 
> BTW, I'm also considering to support new cast syntax, which allows
> us to derefer a pointer with "container_of". This is typically
> used in the kernel.
> 
> We usually see this pattern:
> 
> struct {
> 	unsigned long		data;
> 	struct list_head	list;
> } foo;
> 
> void callback(struct list_head *foo_list)
> {
> 	unsigned long data = container_of(foo_list, struct foo, list)->data;
> 	...
> }
> 
> To access @data, simple casting does not work. Thus we need a
> new syntax:
> 
> 	(STRUCT)(PTR,ASSIGN)->FIELD
> 
> So the above case, we can do:
> 
> 	data=(foo)(foo_list,list)->data

Hmm, it may be better to make it one parenthesis?

       (STRUCT,PTR,ASSIGN)->FIELD

       data=(foo,foo_list,list)->data

That would make it easier to differentiate between a simple "typecast" and
a container_of() by checking if the content between the parenthesis has a
comma.

Maybe even reorder it to:

       (PTR,STRUCT,ASSIGN)->FIELD

       data=(foo_list,foo,list)->data

to match the order of container_of():

      data = container_of(foo_list, struct foo, list)->data;

?

> 
> This is naturally extend the type casting to support container_of()
> equivalent casting.
> 
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> > Changes since v3: https://patch.msgid.link/20260518095832.52659a3a@gandalf.local.home
> > 
> >  *** COMPLETE REWRITE FROM V3 ***
> > 
> > - Rewrote it to use typecasting instead of simply replacing BTF names with
> >   offsets.
> > 
> >  Documentation/trace/kprobetrace.rst |   3 +
> >  kernel/trace/trace_probe.c          | 110 ++++++++++++++++++++++++----
> >  kernel/trace/trace_probe.h          |   3 +
> >  3 files changed, 100 insertions(+), 16 deletions(-)
> > 
> > diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> > index 3b6791c17e9b..450ac646fe4c 100644
> > --- a/Documentation/trace/kprobetrace.rst
> > +++ b/Documentation/trace/kprobetrace.rst
> > @@ -54,6 +54,9 @@ Synopsis of kprobe_events
> >    $retval	: Fetch return value.(\*2)
> >    $comm		: Fetch current task comm.
> >    +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
> > +  (STRUCT*)FETCHARG->FIELD[->FIELD] : If BTF is supported, typecast FETCHARG to
> > +                  a pointer to STRUCT and then derference the pointer defined by
> > +                  ->FIELD.
> >    \IMM		: Store an immediate value to the argument.
> >    NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
> >    FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index e0d3a0da26af..b0829eb1cb52 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -464,6 +464,26 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
> >  	return NULL;
> >  }
> >  
> > +static int query_btf_struct(const char *sname, struct traceprobe_parse_context *ctx)
> > +{
> > +	int id;
> > +
> > +	if (!ctx->btf) {
> > +		struct btf *btf;  
> 
> This needs an empty line here.

Sure.

For conditional blocks, I don't always add a newline, but this is your code
and I'll follow your suggestions.

> 
> > +		id = bpf_find_btf_id(sname, BTF_KIND_STRUCT, &btf);
> > +		if (id < 0)
> > +			return -EINVAL;  
> 
> Why don't you return id (it has corresponding errno)?

Because I forgot to ;-)

> 
> > +		ctx->btf = btf;
> > +	} else {
> > +		id = btf_find_by_name_kind(ctx->btf, sname, BTF_KIND_STRUCT);
> > +		if (id < 0)
> > +			return -EINVAL;  
> 
> Ditto.
> 
> > +	}
> > +
> > +	ctx->last_struct = btf_type_by_id(ctx->btf, id);
> > +	return 0;
> > +}
> > +
> >  static int query_btf_context(struct traceprobe_parse_context *ctx)
> >  {
> >  	const struct btf_param *param;
> > @@ -471,12 +491,12 @@ static int query_btf_context(struct traceprobe_parse_context *ctx)
> >  	struct btf *btf;
> >  	s32 nr;
> >  
> > -	if (ctx->btf)
> > -		return 0;
> > -
> >  	if (!ctx->funcname)
> >  		return -EINVAL;
> >  
> > +	if (ctx->btf)
> > +		return 0;
> > +  
> 
> Could you tell me why this order is changed?
> I think this type casting will allow us to skip checking funcname
> because btf context is already specified.

I wanted this to fail if btf was already set but funcname wasn't, because
this should only be called for functions.

> 
> Ah, BTW, we may need to use a special struct btf* for type
> casting. If the target function is in a module and the
> casting type is defined in vmlinux, those are stored in
> the different places...

OK, I'll make a separate btf for it then. I'll have to make sure the btf
used for parsing knows which one to use. Shouldn't be too hard if we check
for the STRUCT flag in the ctx->flags.

> 
> 
> for example,
> 
>  p funcA (foo)$arg1->bar buz
> 
> In this case, buz needs to use BTF including funcA.
> Maybe we need to introduce ctx->func_btf, which resets ctx->btf
> in traceprobe_parse_probe_arg_body() where parse_probe_arg()
> is calling, e.g.
> 
> 	ctx->last_type = NULL;
> +	if (ctx->btf)
> +		btf_put(ctx->btf);
> +	ctx->btf = ctx->func_btf;
> 	ret = parse_probe_arg(arg, parg->type, &code, &code[FETCH_INSN_MAX - 1],
> 			      ctx);
> 
> 
> >  	type = btf_find_func_proto(ctx->funcname, &btf);
> >  	if (!type)
> >  		return -ENOENT;
> > @@ -514,6 +534,7 @@ static void clear_btf_context(struct traceprobe_parse_context *ctx)
> >  		ctx->proto = NULL;
> >  		ctx->params = NULL;
> >  		ctx->nr_params = 0;
> > +		ctx->last_struct = NULL;
> >  	}
> >  }
> >  
> > @@ -554,22 +575,28 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
> >  	struct fetch_insn *code = *pcode;
> >  	const struct btf_member *field;
> >  	u32 bitoffs, anon_offs;
> > +	bool is_struct = ctx->flags & TPARG_FL_STRUCT;
> >  	char *next;
> >  	int is_ptr;
> >  	s32 tid;
> >  
> >  	do {
> > -		/* Outer loop for solving arrow operator ('->') */
> > -		if (BTF_INFO_KIND(type->info) != BTF_KIND_PTR) {
> > -			trace_probe_log_err(ctx->offset, NO_PTR_STRCT);
> > -			return -EINVAL;
> > -		}
> > -		/* Convert a struct pointer type to a struct type */
> > -		type = btf_type_skip_modifiers(ctx->btf, type->type, &tid);
> > -		if (!type) {
> > -			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> > -			return -EINVAL;
> > +		if (!is_struct) {
> > +			/* Outer loop for solving arrow operator ('->') */
> > +			if (BTF_INFO_KIND(type->info) != BTF_KIND_PTR) {
> > +				trace_probe_log_err(ctx->offset, NO_PTR_STRCT);
> > +				return -EINVAL;
> > +			}
> > +
> > +			/* Convert a struct pointer type to a struct type */
> > +			type = btf_type_skip_modifiers(ctx->btf, type->type, &tid);
> > +			if (!type) {
> > +				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> > +				return -EINVAL;
> > +			}
> >  		}
> > +		/* Only the first type can skip being a pointer */
> > +		is_struct = false;
> >  
> >  		bitoffs = 0;
> >  		do {
> > @@ -635,12 +662,12 @@ static int parse_btf_arg(char *varname,
> >  {
> >  	struct fetch_insn *code = *pcode;
> >  	const struct btf_param *params;
> > -	const struct btf_type *type;
> > +	const struct btf_type *type = NULL;
> >  	char *field = NULL;
> >  	int i, is_ptr, ret;
> >  	u32 tid;
> >  
> > -	if (WARN_ON_ONCE(!ctx->funcname))
> > +	if (WARN_ON_ONCE(!ctx->funcname && !(ctx->flags & TPARG_FL_STRUCT)))
> >  		return -EINVAL;
> >  
> >  	is_ptr = split_next_field(varname, &field, ctx);
> > @@ -704,11 +731,18 @@ static int parse_btf_arg(char *varname,
> >  			goto found;
> >  		}
> >  	}
> > +
> > +	if (ctx->flags & TPARG_FL_STRUCT) {
> > +		type = ctx->last_struct;
> > +		goto found;  
> 
> I rather like to jump type_found: label instead of
> checking !type. (Or, save tid instead of type)
> 

OK.

> > +	}
> > +
> >  	trace_probe_log_err(ctx->offset, NO_BTFARG);
> >  	return -ENOENT;
> >  
> >  found:
> > -	type = btf_type_skip_modifiers(ctx->btf, tid, &tid);
> > +	if (!type)
> > +		type = btf_type_skip_modifiers(ctx->btf, tid, &tid);  
> 
> type_found:
> 
> >  	if (!type) {
> >  		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> >  		return -EINVAL;
> > @@ -952,6 +986,12 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
> >  	int ret = 0;
> >  	int len;
> >  
> > +	if (ctx->flags & TPARG_FL_STRUCT) {
> > +		ret = parse_btf_arg(orig_arg, pcode, end, ctx);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> >  	if (ctx->flags & TPARG_FL_TEVENT) {
> >  		if (code->data)
> >  			return -EFAULT;
> > @@ -1231,6 +1271,43 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
> >  				code->op = FETCH_OP_IMM;
> >  		}
> >  		break;
> > +	case '(':
> > +		tmp = strrchr(arg, ')');  
> 
> OK, in this step, we don't support nested cast etc. so this works.
> 
> > +		if (!tmp) {
> > +			trace_probe_log_err(ctx->offset + strlen(arg),
> > +					    DEREF_OPEN_BRACE);
> > +			return -EINVAL;
> > +		}
> > +
> > +		tmp--;
> > +		if (*tmp != '*') {
> > +			trace_probe_log_err(ctx->offset + (tmp - arg),
> > +					    NO_PTR_STRCT);
> > +			return -EINVAL;
> > +		}  
> 
> So I think this can be optional, not an error.

I'll just remove it.

> 
> > +		*tmp = '\0';
> > +		ret = query_btf_struct(arg + 1, ctx);
> > +		*tmp = '*';
> > +
> > +		if (ret < 0) {
> > +			trace_probe_log_err(ctx->offset + 1, NO_PTR_STRCT);
> > +			return -EINVAL;
> > +		}
> > +
> > +		ctx->flags |= TPARG_FL_STRUCT;
> > +		tmp += 2;
> > +
> > +		if (*tmp != '$') {
> > +			trace_probe_log_err(ctx->offset + (tmp - arg),
> > +					    BAD_VAR);
> > +			return -EINVAL;
> > +		}  
> 
> Ok, this limitation will be removed afterwards.

Yeah.

Thanks for reviewing.

-- Steve
