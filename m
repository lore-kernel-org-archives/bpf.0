Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F163DB31E;
	Tue, 19 May 2026 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212258; cv=none; b=Atl9b+WgjVq0FXQzgvQ9xKY2hmU+KAOJcX+Y2iXgcGYQ6B0sezq4rgUokVDEz7LBWalNqOctc9NThL/XimJXWVrB7NI4RX8SKJfcJ88f2qdHJr+Ad8oZNgR87CqHZ5rE4Ap34paF3w/N2BlpDdPm3977/1aSXI48QeBjyG0XABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212258; c=relaxed/simple;
	bh=IWKfQ5aVjwoC15ehZskKKufRvKiU047/voNB+hQfCto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiY6tVbdxR98PnMmO7OCFeJb8ga3HviMZeujFMn3uHdNeYE+dbHE4gzUxHD+DsuT0AhQ7GmZMiUeYwLhpfVineo/tHhPAJ0WGomW/IrQfbsxEWzXKp/zwmPgyryUjfSV5FNHe88wCi17YT86rR84DJiJER5BQZ7qGRiJuTJIaAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evWSQBKG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evWSQBKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1439FC2BCB3;
	Tue, 19 May 2026 17:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779212258;
	bh=IWKfQ5aVjwoC15ehZskKKufRvKiU047/voNB+hQfCto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=evWSQBKGz1vmH4eW8Wg7ptlqp0zAsWPwWpOgIwL73Ik+OvBr2rX8dtNEn1OTgXFQI
	 14lOZYB9OCLwCfn/P4XdwpUXRICVHOtYj7oDCbfQGJV66eVBaORQWJc+Y3iMiWR/dd
	 +sqLhG/YQysfaPC5g69AYlTL683eOMts3Ef//gll85q6bdMwczpGGyf0RHUuqsko1w
	 08ZdsBcyIZn2PQVhwak/XbF65vYkrBRb06y739FmidD2cWHNmVvCvdbaT+s8c3/xne
	 3Ck+1D6Uc4OyquOcQgYGNeEvuGsy/pVErcbKSb/VNmCpnkasHxRRcReFkhhpIwonCw
	 149/SE5cd4Hag==
Date: Tue, 19 May 2026 13:37:34 -0400
From: Steven Rostedt <rostedt@kernel.org>
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
Message-ID: <20260519133734.2d3150df@fedora>
In-Reply-To: <20260519132830.3011a194@fedora>
References: <20260519130144.40e71a00@fedora>
	<20260519132830.3011a194@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 13:28:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 19 May 2026 13:01:44 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > @@ -636,11 +694,12 @@ static int parse_btf_arg(char *varname,
> >  	struct fetch_insn *code = *pcode;
> >  	const struct btf_param *params;
> >  	const struct btf_type *type;
> > +	struct btf *btf = ctx_btf(ctx);
> >  	char *field = NULL;
> >  	int i, is_ptr, ret;
> >  	u32 tid;
> >  
> > -	if (WARN_ON_ONCE(!ctx->funcname))
> > +	if (WARN_ON_ONCE(!ctx->funcname && !(ctx->flags & TPARG_FL_TYPECAST)))
> >  		return -EINVAL;
> >  
> >  	is_ptr = split_next_field(varname, &field, ctx);
> > @@ -653,6 +712,14 @@ static int parse_btf_arg(char *varname,
> >  		return -EOPNOTSUPP;
> >  	}
> >  
> > +	if (ctx->flags & TPARG_FL_TEVENT) {
> > +		int ret;
> > +
> > +		ret = parse_trace_event(varname, code, ctx);
> > +		if (ret < 0)
> > +			return ret;

Actually, since typecasting is currently only for eprobes, I'm going to
shuffle the code around a bit to only have the TYPECAST affect TEVENT,
and do the jump to found_type from here.

-- Steve


> > +	}
> > +
> >  	if (ctx->flags & TPARG_FL_RETURN && !strcmp(varname, "$retval")) {
> >  		code->op = FETCH_OP_RETVAL;
> >  		/* Check whether the function return type is not void */
> > @@ -672,7 +739,7 @@ static int parse_btf_arg(char *varname,
> >  		return 0;
> >  	}
> >  
> > -	if (!ctx->btf) {
> > +	if (!btf) {
> >  		ret = query_btf_context(ctx);  
> 
> Oops, need a:
> 
> 		btf = ctx->btf;
> 
> here!
> 
> -- Steve
> 
> >  		if (ret < 0 || ctx->nr_params == 0) {
> >  			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);  

