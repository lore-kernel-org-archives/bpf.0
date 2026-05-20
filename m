Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF1374182;
	Wed, 20 May 2026 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258025; cv=none; b=QEiXtuKDYFVACBdqGscC0rxo5WMD2+5WvQr6Rew0DwI+2ptyaneB0jkkth8VEmurc21Q8wMJFYJi+PwLpZMD0m/lSVlE5TJVTP42gzu/CtLyU05OtWIN+akf2iA9DdwTtrqF33ECyaybfMs0BrMcirS/df4IrEiEiUBfYWkI/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258025; c=relaxed/simple;
	bh=uR+AhcxoqPDfxegqYGtvZe8CtPtevsfk0UlxiZv2gag=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NNQExLu5eppt40tY7WGi90j90IGsESyIHmyVeJj3BiGHA8sJ9DOAB5kDUZz8f96S56oRh3Z3+R1OcpI/DsGkFqTNGV/NoU4DevvJI4Jmfg0ayoGX8MOqOLK+LrImf3g+e3diOgiRhdV3PxoAPIoq4x0hNBNzRku2kNCmEKNGLo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofl/Igrx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofl/Igrx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0091F00893;
	Wed, 20 May 2026 06:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258023;
	bh=9oVsgRfRzih1TVPNAGEGp2Wdkc8uoz8Yc1aNUpxSXqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ofl/IgrxjOLmaYdxNhSs++J9At/u/o9B0j7FrHZmSt+hwyPwMvlUAAWTjP/K5b4Fm
	 ba8BQvg53m3IuyD5Q5Iwet6gJVK0ulTPrwnpjdehYuvOS40BjeQQDhwuH7ly0WJ45/
	 tO5CGpzGAC6YEKxa8uSE0rONXzMmx7GDlqZ1/hdGeF3yBqYFpZGkBzCcs/30LnIeoz
	 3Hv3v4Xi6KBZ3gK5XqQWyym3qeijkjrF8Xk+2Od6nCKeUqXbf8QFd81OvnT78LGz0H
	 dHurs3cMOXx30pyuQ3SGVk63a+Wc4SzTuwjDPn0EkuL44lm78nozxR2xDmoZnww4CM
	 nt0pq1w7Hxceg==
Date: Wed, 20 May 2026 15:20:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 bpf@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux trace
 kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [PATCH v5] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-Id: <20260520152021.350e7017551ef202aace4cd5@kernel.org>
In-Reply-To: <20260519141726.613e2e54@fedora>
References: <20260519130144.40e71a00@fedora>
	<20260519174848.176A6C2BCB3@smtp.kernel.org>
	<20260519141726.613e2e54@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 14:17:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 19 May 2026 17:48:47 +0000
> sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> > - [High] Using `(STRUCT)` typecasts for non-eprobes leaves the base fetch instruction uninitialized (`FETCH_OP_NOP`), silently breaking the probe.
> > - [High] Prematurely clearing `TPARG_FL_TYPECAST` causes cross-BTF type confusion and breaks string fetches.
> > - [Medium] Erroneous caching of `struct_btf` restricts a single trace probe to using typecasts from only one BTF object, preventing cross-module lookups.
> > - [Medium] Cross-BTF string table access in `parse_btf_arg()` causes invalid string comparisons.
> > - [Low] `clear_btf_context()` fails to clear `ctx->struct_btf` after dropping its reference.
> > --
> > 
> > commit de4b6287a7069fde24b0e0f679a545a06fb9ae6c
> > Author: Steven Rostedt <rostedt@goodmis.org>
> > 
> > tracing/eprobes: Allow use of BTF names to dereference pointers
> > 
> > Add syntax to the parsing of eprobes to be able to typecast a trace event
> > field that is a pointer to a structure.
> > 
> > > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > > index e1c73065dae51..2bc9f4ca8aa7e 100644
> > > --- a/kernel/trace/trace_probe.c
> > > +++ b/kernel/trace/trace_probe.c
> > > @@ -464,6 +470,27 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
> > >  	return NULL;
> > >  }
> > >  
> > > +static int query_btf_struct(const char *sname, struct traceprobe_parse_context *ctx)
> > > +{
> > > +	int id;
> > > +
> > > +	if (!ctx->struct_btf) {
> > > +		struct btf *btf;
> > > +
> > > +		id = bpf_find_btf_id(sname, BTF_KIND_STRUCT, &btf);
> > > +		if (id < 0)
> > > +			return id;
> > > +		ctx->struct_btf = btf;
> > > +	} else {
> > > +		id = btf_find_by_name_kind(ctx->struct_btf, sname, BTF_KIND_STRUCT);  
> > 
> > [Severity: Medium]
> > Does caching struct_btf here restrict a single trace probe event to using
> > typecasts from only one BTF object?
> > 
> > If a probe attempts to typecast structures from two different kernel
> > modules, wouldn't the lookup for the second module's struct fail because
> > it only searches the cached BTF object of the first module (or vmlinux)?
> 
> Hmm, good point. I guess I should clear the struct_btf at the end of
> the '(' switch case.

Yes, it should be reset before parsing next argument.

> 
> > 
> > > +		if (id < 0)
> > > +			return id;
> > > +	}
> > > +
> > > +	ctx->last_struct = btf_type_by_id(ctx->struct_btf, id);
> > > +	return 0;
> > > +}  
> > 
> > [ ... ]
> > 
> > > @@ -515,6 +542,10 @@ static void clear_btf_context(struct traceprobe_parse_context *ctx)
> > >  		ctx->params = NULL;
> > >  		ctx->nr_params = 0;
> > >  	}
> > > +	if (ctx->struct_btf) {
> > > +		btf_put(ctx->struct_btf);
> > > +		ctx->last_struct = NULL;  
> > 
> > [Severity: Low]
> > Should ctx->struct_btf be explicitly set to NULL after btf_put() drops
> > the reference?
> 
> I'm thinking of dropping it in the '(' switch case.

Can you consider making the '(' switch case part as a helper
function because it depends on CONFIG_DEBUG_INFO_BTF?
 
Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
