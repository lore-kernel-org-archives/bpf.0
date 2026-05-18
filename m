Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A93DD523;
	Mon, 18 May 2026 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085077; cv=none; b=rVHtzlRhVYMaw6+cVDvcZAKTmYdvzdW5shzrFqBfp/H6Z6yu2zfEdppVkCeMZh/iz+cChAt6TYvfZGrzXELgsmT4Ai1KIQoZGAgWyJ7CGKe2Q834im/hCnjdsT1K6QQV3YZ5R645YdOJklO8hjx4xGGdQor393aTmdPL9NmK/3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085077; c=relaxed/simple;
	bh=D2+OrM+LMwkQZikSLMNXinXIb7BHYNvAaXstapjXBqw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=vAd6SigOg2XyYIYGIoTUR2x8PbnRovCcF4+E5fDDp98QsCjOyjP+UVKllIvooAMsH99v7SI6DycE+ElOGtW/Ahxb3y9h3R87aysWwkngzv2BeMJs6BeY7+qXrceCCVNKVzjpSsKtRa8tANYa3arhRftiin699HO5h8s5b8+aglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2ynqu0q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2ynqu0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE48C2BCB7;
	Mon, 18 May 2026 06:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779085076;
	bh=D2+OrM+LMwkQZikSLMNXinXIb7BHYNvAaXstapjXBqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J2ynqu0q8o/IUaGLbdIXy1sPwhLaPp0xPERpV09Fxx4/9gBY+04pNTMyqDWynJMVe
	 Az+A9xxNpCFG8EbF0wvPtqT/u953li2hhPbV6cZJYJRShnBYPz7v+hI15po9ixGhw/
	 0smb5rxK00JPdMQ2NRjrXXmhR5ZTpvJMdeY1ahZg6/XlnS0UYfFtP/++Ir+hwCS72p
	 LVqq6O9UMIbUY9nMT9LM66royBNy0av6HOEL5X83rB78iKGyCRHVvXphd/1VDTEoyc
	 ApgeQ3FjJpErZbyjXHUjmpCkRNegCtUS2gNMub/xCGEZ43pRkAcgZLBx+uoWhlMNz8
	 TIPhfZlDQy3ZA==
Date: Mon, 18 May 2026 15:17:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>, Tom Zanussi
 <zanussi@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>, Jiri Olsa
 <olsajiri@gmail.com>
Subject: Re: [PATCH v2] tracing/probes: Allow use of BTF names to
 dereference pointers
Message-Id: <20260518151753.3b9ba7fcf6556ef580bc5c7a@kernel.org>
In-Reply-To: <20260516173310.1dbad146@fedora>
References: <20260516173310.1dbad146@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 May 2026 17:33:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

>  Function arguments at kretprobe
>  -------------------------------
> diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
> index 00172f301f25..be88cc4d97dd 100644
> --- a/kernel/trace/trace_btf.c
> +++ b/kernel/trace/trace_btf.c
> @@ -120,3 +120,114 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
>  	return member;
>  }
>  
> +#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> +
> +static int find_member(const char *ptr, struct btf *btf,
> +		       const struct btf_type **type, int level)

We already have a similar function.

/*
 * Find a member of data structure/union by name and return it.
 * Return NULL if not found, or -EINVAL if parameter is invalid.
 * If the member is an member of anonymous union/structure, the offset
 * of that anonymous union/structure is stored into @anon_offset. Caller
 * can calculate the correct offset from the root data structure by
 * adding anon_offset to the member's offset.
 */
const struct btf_member *btf_find_struct_member(struct btf *btf,
						const struct btf_type *type,
						const char *member_name,
						u32 *anon_offset)

And this seems useful for you,


> +{
> +	const struct btf_member *member;
> +	const struct btf_type *t = *type;
> +	int i;
> +
> +	/* Max of 3 depth of anonymous structures */
> +	if (level > 3)
> +		return -E2BIG;
> +
> +	for_each_member(i, t, member) {
> +		const char *tname = btf_name_by_offset(btf, member->name_off);
> +
> +		if (strcmp(ptr, tname) == 0) {
> +			int offset = __btf_member_bit_offset(t, member);
> +			*type = btf_type_by_id(btf, member->type);
> +			return BITS_ROUNDDOWN_BYTES(offset);
> +		}
> +
> +		/* Handle anonymous structures */
> +		if (strlen(tname))
> +			continue;
> +
> +		*type = btf_type_by_id(btf, member->type);
> +		if (btf_type_is_struct(*type)) {
> +			int offset = find_member(ptr, btf, type, level + 1);
> +
> +			if (offset < 0)
> +				continue;
> +
> +			return offset + BITS_ROUNDDOWN_BYTES(member->offset);
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +/**
> + * btf_find_offset - Find an offset of a member for a structure
> + * @arg: A structure name followed by one or more members
> + * @offset_p: A pointer to where to store the offset
> + *
> + * Will parse @arg with the expected format of: struct.member[[.member]..]
> + * It is delimited by '.'. The first item must be a structure type.
> + * The next are its members. If the member is also of a structure type it
> + * another member may follow ".member".
> + *
> + * Note, @arg is modified but will be put back to what it was on return.
> + *
> + * Returns: 0 on success and -EINVAL if no '.' is present
> + *    or -ENXIO if the structure or member is not found.
> + *    Returns -EINVAL if BTF is not defined.
> + *  On success, @offset_p will contain the offset of the member specified
> + *    by @arg.
> + */
> +int btf_find_offset(char *arg, long *offset_p)

And this can share the inner loop of parse_btf_field().
(BTW, parse_btf_field() supports bitfield, but this does not.)

> +{
> +	const struct btf_type *t;
> +	struct btf *btf;

As Sashiko pointed, btf = NULL here.
But I think we would better to have DEFINE_FREE(btf_put).

> +	long offset = 0;
> +	char *ptr;
> +	int ret;
> +	s32 id;
> +
> +	ptr = strchr(arg, '.');
> +	if (!ptr)
> +		return -EINVAL;
> +
> +	*ptr = '\0';
> +
> +	ret = -ENXIO;
> +	id = bpf_find_btf_id(arg, BTF_KIND_STRUCT, &btf);
> +	if (id < 0)
> +		goto error;
> +
> +	/* Get BTF_KIND_FUNC type */
> +	t = btf_type_by_id(btf, id);
> +
> +	/* May allow more than one member, as long as they are structures */
> +	do {
> +		ret = -ENXIO;
> +		if (!t || !btf_type_is_struct(t))
> +			goto error;
> +
> +		*ptr++ = '.';
> +		arg = ptr;
> +		ptr = strchr(ptr, '.');
> +		if (ptr)
> +			*ptr = '\0';
> +

So, if you don't share the inner loop, you can just reuse
btf_field_struct_member() as below (this should be equivalent
to find_member()):

		field = btf_find_struct_member(btf, t, arg, &anon_offs);
		if (IS_ERR_OR_NULL(field)) {
			ret = field ? PTR_ERR(field) : -ENOENT;
			goto error;
		}

		offset += field->offset + anon_offs;

> +
> +	} while (ptr);
> +
> +	btf_put(btf);
> +	*offset_p = offset;
> +	return 0;
> +
> +error:
> +	btf_put(btf);
> +	if (ptr)
> +		*ptr = '.';
> +	return ret;
> +}
> diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
> index 4bc44bc261e6..7b0797a6050b 100644
> --- a/kernel/trace/trace_btf.h
> +++ b/kernel/trace/trace_btf.h
> @@ -9,3 +9,13 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
>  						const struct btf_type *type,
>  						const char *member_name,
>  						u32 *anon_offset);
> +
> +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> +/* Will modify arg, but will put it back before returning. */
> +int btf_find_offset(char *arg, long *offset);
> +#else
> +static inline int btf_find_offset(char *arg, long *offset)
> +{
> +	return -EINVAL;
> +}
> +#endif
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index e0d3a0da26af..6fcede2de1a5 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1165,7 +1165,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  
>  	case '+':	/* deref memory */
>  	case '-':
> -		if (arg[1] == 'u') {
> +		if (arg[1] == 'u' && isdigit(arg[2])) {

As Sashiko pointed, This can be broken if STRUCT name starts
with "u[0-9]". What about using "()" for this case?

e.g. 

+u(user_unreg.disable_addr)(uarg)


>  			deref = FETCH_OP_UDEREF;
>  			arg[1] = arg[0];
>  			arg++;
> @@ -1178,7 +1178,22 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  			return -EINVAL;
>  		}
>  		*tmp = '\0';
> -		ret = kstrtol(arg, 0, &offset);
> +		if (arg[0] != '-' && !isdigit(*arg)) {
> +			int err = 0;
> +			ret = btf_find_offset(arg, &offset);
> +			switch (ret) {
> +			case -ENODEV: err = TP_ERR_NOSUP_BTFARG; break;
> +			case -E2BIG: err = TP_ERR_MEMBER_TOO_DEEP; break;
> +			case -EINVAL: err = TP_ERR_BAD_STRUCT_FMT; break;
> +			case -ENXIO: err = TP_ERR_BAD_BTF_TID; break;

This should have -ENOENT and default case for unknown error.
(There is TP_ERR_NO_BTF_FIELD already)

> +			}
> +			if (err)
> +				__trace_probe_log_err(ctx->offset, err);
> +			if (ret < 0)
> +				return ret;
> +		} else {
> +			ret = kstrtol(arg, 0, &offset);
> +		}
>  		if (ret) {
>  			trace_probe_log_err(ctx->offset, BAD_DEREF_OFFS);
>  			break;
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 262d8707a3df..d649bb9f5b7c 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -563,7 +563,9 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),\
>  	C(TOO_MANY_ARGS,	"Too many arguments are specified"),	\
>  	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),	\
> -	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),
> +	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"), \
> +	C(MEMBER_TOO_DEEP,	"Too many indirections of anonymous structure"), \
> +	C(BAD_STRUCT_FMT,	"Unknown BTF structure"),
>  
>  #undef C
>  #define C(a, b)		TP_ERR_##a
> -- 
> 2.53.0
> 

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
