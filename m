Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF7B3DB322;
	Tue, 19 May 2026 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211725; cv=none; b=WTm4o4OvL24YDRu4UoJI8t5xfNZHdMS0GDqqdV376uTAESrL4kEIFt96X/VgjVdXkq76awAHAkZdAXcOpiP7IB2BSYPye93jjErRQIWpBYE9ZrgU7Ty4gFtJSG5b4SgOCc9TEyifziJ0tZG0BMZq29OywfpZuxha0X17fm3AF0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211725; c=relaxed/simple;
	bh=T9hREriq6Hj7qPgkQnbk793C5GrK+/K0Nk82MV1WxZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJLTOYBpe2fYQzW6bGL8YdjvnU/N8iNQ8ydlhfzdWBs6mi/INAE3pP1oqMev2+kgLDjrl3JBOnp+kuSuFUQ2IBeU2UW9p3F3I9nf+mhh5hBxnTsaVDIWbK90ieBx3hGnusKAk52Y0tpsxiJUkCiHtlHVER22AkV9wcl5ArznTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id BA0E41A077D;
	Tue, 19 May 2026 17:28:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 8A6CE2002D;
	Tue, 19 May 2026 17:28:31 +0000 (UTC)
Date: Tue, 19 May 2026 13:28:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH v5] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260519132830.3011a194@fedora>
In-Reply-To: <20260519130144.40e71a00@fedora>
References: <20260519130144.40e71a00@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4qbe33i11rufx5kuhp1xncycfw1me9si
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 8A6CE2002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/+LWA6x3RFONIpxf2g8f9HT1NtJ1jdfaY=
X-HE-Tag: 1779211711-555163
X-HE-Meta: U2FsdGVkX1/xLdAcePz4fwTBNrplzDnnZeFK9XAQD92Xj+DjGJ4gI75OSff6usIdCrVlwlhmKNWV5uckBLxVMr9iCi+IIMInh9n+SUDOFksXEUH+WXwgi55wGJh/3r4vNl9Qf3lCd3CNVFg/uZpCGic0NqdrxAeTK6dIy94IKPskIXChxY3HkWTw4s0sYSFONnPvhM7SWrNYSjDvcdARcsk/PX/Pnj0S9cm5hKn0WS28lx+JKYDY3AyoChj3qX8LNGLcCXkb5B02ZuYXnzfFsgZSj6vOHwJVYRrqLNtGqJk+vb0JOgGBOAy+7baW7GlsMMcdlOGo/5Z9E3TSrd4hosExl6f6wvuouOPyXBS6z+WUs65W1R1NloN/aK/5Ovzl

On Tue, 19 May 2026 13:01:44 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -636,11 +694,12 @@ static int parse_btf_arg(char *varname,
>  	struct fetch_insn *code = *pcode;
>  	const struct btf_param *params;
>  	const struct btf_type *type;
> +	struct btf *btf = ctx_btf(ctx);
>  	char *field = NULL;
>  	int i, is_ptr, ret;
>  	u32 tid;
>  
> -	if (WARN_ON_ONCE(!ctx->funcname))
> +	if (WARN_ON_ONCE(!ctx->funcname && !(ctx->flags & TPARG_FL_TYPECAST)))
>  		return -EINVAL;
>  
>  	is_ptr = split_next_field(varname, &field, ctx);
> @@ -653,6 +712,14 @@ static int parse_btf_arg(char *varname,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (ctx->flags & TPARG_FL_TEVENT) {
> +		int ret;
> +
> +		ret = parse_trace_event(varname, code, ctx);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	if (ctx->flags & TPARG_FL_RETURN && !strcmp(varname, "$retval")) {
>  		code->op = FETCH_OP_RETVAL;
>  		/* Check whether the function return type is not void */
> @@ -672,7 +739,7 @@ static int parse_btf_arg(char *varname,
>  		return 0;
>  	}
>  
> -	if (!ctx->btf) {
> +	if (!btf) {
>  		ret = query_btf_context(ctx);

Oops, need a:

		btf = ctx->btf;

here!

-- Steve

>  		if (ret < 0 || ctx->nr_params == 0) {
>  			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
