Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5A7367B7C;
	Tue, 19 May 2026 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214659; cv=none; b=AMaa2424OMAC+yK+HxT3TNhTYl4iY9qOWvN9opcKOVA0WT9eE+3lL+sxSUx3U03nGXifwLAbMXFX2n1ZYjKeNtAysaAn2iE9iLsrS4KBrUjrIaQTwifbxMMVgXZZeIlrAbhIT3vG4uegd0N3//vPT1+gSi7EfOZK7baeo9LhkR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214659; c=relaxed/simple;
	bh=Xscm9khAV5fwxprpZsOpY7a91iE/PVR1LkvJNAhG1Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EP1PWDFsCFs8TZmFJYDLWQIC2dgPtENSxR1iT82+tEcx5tvMIQBVqfznh901YteFaNrNbCKlgSNhwbExo9AFD4qvh9OAmTZCk/Whyxk9OnNhFbpfqHk+irC6qrR8mRCZNiPnFSMLa963VIWuMyXBabRjnbc7SAjRcHlKpZzwHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id DDB8C1408DF;
	Tue, 19 May 2026 18:17:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 036C642;
	Tue, 19 May 2026 18:17:27 +0000 (UTC)
Date: Tue, 19 May 2026 14:17:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [PATCH v5] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260519141726.613e2e54@fedora>
In-Reply-To: <20260519174848.176A6C2BCB3@smtp.kernel.org>
References: <20260519130144.40e71a00@fedora>
	<20260519174848.176A6C2BCB3@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 036C642
X-Stat-Signature: ojoqpestf56n3bjp476kj1w543wmgcx1
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Z1J3+bHKVx9Du++DWn38MbgQCZ0hJoCE=
X-HE-Tag: 1779214647-249727
X-HE-Meta: U2FsdGVkX1+ek3CS1dgaY7L9GiwmPFmBYqbuS4cXXdFPdQh2271xIFP6DGPhtFr1XgrM6iWU3509QsSDvweKQiELeRXRqwBthCP63yEoSTx3kJO00PfvgVb6s6b6Zym3BVLdsgnqgjB7TXS2K4tWxDhFmZM+FbtOre7NGffJyXeFiFhUEuB3b79oOohGuqgX7Sbmy7ErcVofPEfcPJSkwpZkhkmvB9CaDOGYQaRQKwBs0brXTteDCARE4Tor1HK39wMVne9jx7spLP/Nth82msBb+eWxM+Flt75lz3CNEfSXL89RIBv35F6KSDACKWieY3pW/p3+4pbjD8WzjFDzb4pXbBZDR2L32deKWAa+WV5AQA4tpPiEneLIADmfEdCLK0/g/rqnqYCckMUBLL0EiQ==

On Tue, 19 May 2026 17:48:47 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Using `(STRUCT)` typecasts for non-eprobes leaves the base fetch instruction uninitialized (`FETCH_OP_NOP`), silently breaking the probe.
> - [High] Prematurely clearing `TPARG_FL_TYPECAST` causes cross-BTF type confusion and breaks string fetches.
> - [Medium] Erroneous caching of `struct_btf` restricts a single trace probe to using typecasts from only one BTF object, preventing cross-module lookups.
> - [Medium] Cross-BTF string table access in `parse_btf_arg()` causes invalid string comparisons.
> - [Low] `clear_btf_context()` fails to clear `ctx->struct_btf` after dropping its reference.
> --
> 
> commit de4b6287a7069fde24b0e0f679a545a06fb9ae6c
> Author: Steven Rostedt <rostedt@goodmis.org>
> 
> tracing/eprobes: Allow use of BTF names to dereference pointers
> 
> Add syntax to the parsing of eprobes to be able to typecast a trace event
> field that is a pointer to a structure.
> 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index e1c73065dae51..2bc9f4ca8aa7e 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -464,6 +470,27 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
> >  	return NULL;
> >  }
> >  
> > +static int query_btf_struct(const char *sname, struct traceprobe_parse_context *ctx)
> > +{
> > +	int id;
> > +
> > +	if (!ctx->struct_btf) {
> > +		struct btf *btf;
> > +
> > +		id = bpf_find_btf_id(sname, BTF_KIND_STRUCT, &btf);
> > +		if (id < 0)
> > +			return id;
> > +		ctx->struct_btf = btf;
> > +	} else {
> > +		id = btf_find_by_name_kind(ctx->struct_btf, sname, BTF_KIND_STRUCT);  
> 
> [Severity: Medium]
> Does caching struct_btf here restrict a single trace probe event to using
> typecasts from only one BTF object?
> 
> If a probe attempts to typecast structures from two different kernel
> modules, wouldn't the lookup for the second module's struct fail because
> it only searches the cached BTF object of the first module (or vmlinux)?

Hmm, good point. I guess I should clear the struct_btf at the end of
the '(' switch case.

> 
> > +		if (id < 0)
> > +			return id;
> > +	}
> > +
> > +	ctx->last_struct = btf_type_by_id(ctx->struct_btf, id);
> > +	return 0;
> > +}  
> 
> [ ... ]
> 
> > @@ -515,6 +542,10 @@ static void clear_btf_context(struct traceprobe_parse_context *ctx)
> >  		ctx->params = NULL;
> >  		ctx->nr_params = 0;
> >  	}
> > +	if (ctx->struct_btf) {
> > +		btf_put(ctx->struct_btf);
> > +		ctx->last_struct = NULL;  
> 
> [Severity: Low]
> Should ctx->struct_btf be explicitly set to NULL after btf_put() drops
> the reference?

I'm thinking of dropping it in the '(' switch case.

> 
> While the traceprobe_parse_context might be destroyed shortly after
> parsing completes, leaving a dangling pointer could potentially lead to a
> use-after-free and double-free if any future refactoring reuses the
> parsing context across multiple trace events.
> 
> > +	}
> >  }  
> 
> [ ... ]
> 
> > @@ -672,7 +739,7 @@ static int parse_btf_arg(char *varname,
> >  		return 0;
> >  	}
> >  
> > -	if (!ctx->btf) {
> > +	if (!btf) {
> >  		ret = query_btf_context(ctx);
> >  		if (ret < 0 || ctx->nr_params == 0) {
> >  			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
> > @@ -682,7 +749,7 @@ static int parse_btf_arg(char *varname,
> >  	params = ctx->params;
> >  
> >  	for (i = 0; i < ctx->nr_params; i++) {
> > -		const char *name = btf_name_by_offset(ctx->btf, params[i].name_off);
> > +		const char *name = btf_name_by_offset(btf, params[i].name_off);  
> 
> [Severity: Medium]
> When parsing a typecast argument, btf evaluates to ctx->struct_btf. The
> parameter matching loop then calls btf_name_by_offset() using that btf.
> 
> Since params[i].name_off originates from the function's BTF (ctx->btf,
> populated by previous non-typecast arguments), could this lead to reading
> from the wrong string table if ctx->struct_btf is a different kernel
> module?

The new patch will skip this for TYPECAST arguments. Well, at least for
trace events.

> 
> This might result in invalid string comparisons or returning
> (invalid-name-offset) if it reads out of bounds.
> 
> >  
> >  		if (name && !strcmp(name, varname)) {
> >  			if (tparg_is_function_entry(ctx->flags)) {  
> 
> [ ... ]
> 
> > @@ -1231,6 +1301,30 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
> >  				code->op = FETCH_OP_IMM;
> >  		}
> >  		break;
> > +	case '(':
> > +		tmp = strchr(arg, ')');
> > +		if (!tmp) {
> > +			trace_probe_log_err(ctx->offset + strlen(arg),
> > +					    DEREF_OPEN_BRACE);
> > +			return -EINVAL;
> > +		}
> > +		*tmp = '\0';
> > +		ret = query_btf_struct(arg + 1, ctx);
> > +		*tmp = ')';
> > +
> > +		if (ret < 0) {
> > +			trace_probe_log_err(ctx->offset + 1, NO_PTR_STRCT);
> > +			return -EINVAL;
> > +		}
> > +
> > +		ctx->flags |= TPARG_FL_TYPECAST;
> > +		tmp++;
> > +
> > +		ctx->offset += tmp - arg;
> > +		ret = parse_btf_arg(tmp, pcode, end, ctx);  
> 
> [Severity: High]
> When parse_probe_arg() evaluates the (STRUCT) syntax for kprobes or
> fprobes, it sets TPARG_FL_TYPECAST and calls parse_btf_arg(). Inside
> parse_btf_arg(), ctx_btf() evaluates to ctx->struct_btf, so it bypasses
> query_btf_context() and jumps to found_type.
> 
> However, it doesn't seem to initialize code->op with a valid base fetch
> instruction like FETCH_OP_ARG or FETCH_OP_REG.
> 
> Could this leave the base instruction as FETCH_OP_NOP (0)? If so, it
> seems the base address would be 0, causing subsequent field dereferences
> to safely fail on 0 + offset due to copy_from_kernel_nofault(). This might
> allow unsupported syntax like (sk_buff)%di->dev to parse but silently
> fetch nothing.

Yeah, I may have to force this not to work with function types.

> 
> > +		ctx->flags &= ~TPARG_FL_TYPECAST;  
> 
> [Severity: High]
> The TPARG_FL_TYPECAST flag is cleared here, but ctx->last_type still
> points to a type originating from ctx->struct_btf.
> 
> Later in traceprobe_parse_probe_arg_body(),
> check_prepare_btf_string_fetch() is called. Since the flag is cleared,
> ctx_btf() will incorrectly return ctx->btf (vmlinux for kprobes, or
> NULL for eprobes).
> 
> Does this cause check_prepare_btf_string_fetch() to return 0 for eprobes
> and skip adding the necessary dummy FETCH_OP_DEREF for string fetches?
> Without this dummy dereference, string fetches on character pointers
> in eprobes might fail by reading the raw pointer value itself as a string.
> 
> Also, for kprobes, could this cause type confusion if
> btf_type_skip_modifiers() looks up a module's type ID inside the vmlinux
> BTF?

As mentioned above, I need to put and clear the last_struct here.

Thanks,

-- Steve


> 
> > +		ctx->last_struct = NULL;
> > +		break;  
> 

