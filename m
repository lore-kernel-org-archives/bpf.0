Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35E32ED24
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212929; cv=none; b=tmJ/HAF0JnFiCABKE1dFnriB2MtNczHVRLG5F9nOzX6ysqsKEZHmZ8lD8uqGmK1xtsbY3O6AnaoCRXRuRb71gp/2fTIJD9NGWqJsHAKR+Uu4BLP/nUgrfcxGMHnegZaSaBYnTGG+DIaCF/znxwhbc8Kjn0WUfR1SENdqHkZaias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212929; c=relaxed/simple;
	bh=QI8pl5oL1l209w82CBneaiYlEXXwD4XFdGbDkLP5iNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NopIdmjMO6H50boPKOWkDCm7tTaAsiuJd7jLr5zfcTw/0HNRxHRTZxr2bNBZVVaAXigxKjXmmZwPWgWBwp/C4PoKa8WPyvpr6xNLiHtB6jVBvVPMPmo1lEzHyqveL2zfWPtdn5rV/S2WUJQftUqdMQvvGnghrM46Ni8Gpq9AI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UO+Y9khu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UO+Y9khu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176A6C2BCB3;
	Tue, 19 May 2026 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779212928;
	bh=QI8pl5oL1l209w82CBneaiYlEXXwD4XFdGbDkLP5iNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UO+Y9khu4UQFGZsJemKFMfoByvoUUzqNs6c9LTazJMPcAstNAUH+2+GrRCaQZrNwM
	 p+Bk5F5tU9T/zDmdTChLVes+Iz5o/THQPmzyBdWzCHQtz7Cil+LsnvjmEqtJMG3TZ7
	 mowSpvvZYtZ6j3Coy+rh7xeDQTLyAcsiMKnPsiSpvAq4DrEUOVJko6yUOjSB8pIKdz
	 NotApaASkwKTap3WqT2VsAfzLtLffBpZGj3x8gCpN49TwAJ/3N0V2wSoNWwf4VQBgV
	 DfOY8k41T3rj/EZ+lv145Jd2rq4ifU26DIq95ELrQKzupmDwl/m8LjnsymjpFnY5rp
	 DP19/zEffTfhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519130144.40e71a00@fedora>
References: <20260519130144.40e71a00@fedora>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 17:48:47 +0000
Message-Id: <20260519174848.176A6C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Using `(STRUCT)` typecasts for non-eprobes leaves the base fetch i=
nstruction uninitialized (`FETCH_OP_NOP`), silently breaking the probe.
- [High] Prematurely clearing `TPARG_FL_TYPECAST` causes cross-BTF type con=
fusion and breaks string fetches.
- [Medium] Erroneous caching of `struct_btf` restricts a single trace probe=
 to using typecasts from only one BTF object, preventing cross-module looku=
ps.
- [Medium] Cross-BTF string table access in `parse_btf_arg()` causes invali=
d string comparisons.
- [Low] `clear_btf_context()` fails to clear `ctx->struct_btf` after droppi=
ng its reference.
--

commit de4b6287a7069fde24b0e0f679a545a06fb9ae6c
Author: Steven Rostedt <rostedt@goodmis.org>

tracing/eprobes: Allow use of BTF names to dereference pointers

Add syntax to the parsing of eprobes to be able to typecast a trace event
field that is a pointer to a structure.

> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index e1c73065dae51..2bc9f4ca8aa7e 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -464,6 +470,27 @@ static const char *fetch_type_from_btf_type(struct b=
tf *btf,
>  	return NULL;
>  }
> =20
> +static int query_btf_struct(const char *sname, struct traceprobe_parse_c=
ontext *ctx)
> +{
> +	int id;
> +
> +	if (!ctx->struct_btf) {
> +		struct btf *btf;
> +
> +		id =3D bpf_find_btf_id(sname, BTF_KIND_STRUCT, &btf);
> +		if (id < 0)
> +			return id;
> +		ctx->struct_btf =3D btf;
> +	} else {
> +		id =3D btf_find_by_name_kind(ctx->struct_btf, sname, BTF_KIND_STRUCT);

[Severity: Medium]
Does caching struct_btf here restrict a single trace probe event to using
typecasts from only one BTF object?

If a probe attempts to typecast structures from two different kernel
modules, wouldn't the lookup for the second module's struct fail because
it only searches the cached BTF object of the first module (or vmlinux)?

> +		if (id < 0)
> +			return id;
> +	}
> +
> +	ctx->last_struct =3D btf_type_by_id(ctx->struct_btf, id);
> +	return 0;
> +}

[ ... ]

> @@ -515,6 +542,10 @@ static void clear_btf_context(struct traceprobe_pars=
e_context *ctx)
>  		ctx->params =3D NULL;
>  		ctx->nr_params =3D 0;
>  	}
> +	if (ctx->struct_btf) {
> +		btf_put(ctx->struct_btf);
> +		ctx->last_struct =3D NULL;

[Severity: Low]
Should ctx->struct_btf be explicitly set to NULL after btf_put() drops
the reference?

While the traceprobe_parse_context might be destroyed shortly after
parsing completes, leaving a dangling pointer could potentially lead to a
use-after-free and double-free if any future refactoring reuses the
parsing context across multiple trace events.

> +	}
>  }

[ ... ]

> @@ -672,7 +739,7 @@ static int parse_btf_arg(char *varname,
>  		return 0;
>  	}
> =20
> -	if (!ctx->btf) {
> +	if (!btf) {
>  		ret =3D query_btf_context(ctx);
>  		if (ret < 0 || ctx->nr_params =3D=3D 0) {
>  			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
> @@ -682,7 +749,7 @@ static int parse_btf_arg(char *varname,
>  	params =3D ctx->params;
> =20
>  	for (i =3D 0; i < ctx->nr_params; i++) {
> -		const char *name =3D btf_name_by_offset(ctx->btf, params[i].name_off);
> +		const char *name =3D btf_name_by_offset(btf, params[i].name_off);

[Severity: Medium]
When parsing a typecast argument, btf evaluates to ctx->struct_btf. The
parameter matching loop then calls btf_name_by_offset() using that btf.

Since params[i].name_off originates from the function's BTF (ctx->btf,
populated by previous non-typecast arguments), could this lead to reading
from the wrong string table if ctx->struct_btf is a different kernel
module?

This might result in invalid string comparisons or returning
(invalid-name-offset) if it reads out of bounds.

> =20
>  		if (name && !strcmp(name, varname)) {
>  			if (tparg_is_function_entry(ctx->flags)) {

[ ... ]

> @@ -1231,6 +1301,30 @@ parse_probe_arg(char *arg, const struct fetch_type=
 *type,
>  				code->op =3D FETCH_OP_IMM;
>  		}
>  		break;
> +	case '(':
> +		tmp =3D strchr(arg, ')');
> +		if (!tmp) {
> +			trace_probe_log_err(ctx->offset + strlen(arg),
> +					    DEREF_OPEN_BRACE);
> +			return -EINVAL;
> +		}
> +		*tmp =3D '\0';
> +		ret =3D query_btf_struct(arg + 1, ctx);
> +		*tmp =3D ')';
> +
> +		if (ret < 0) {
> +			trace_probe_log_err(ctx->offset + 1, NO_PTR_STRCT);
> +			return -EINVAL;
> +		}
> +
> +		ctx->flags |=3D TPARG_FL_TYPECAST;
> +		tmp++;
> +
> +		ctx->offset +=3D tmp - arg;
> +		ret =3D parse_btf_arg(tmp, pcode, end, ctx);

[Severity: High]
When parse_probe_arg() evaluates the (STRUCT) syntax for kprobes or
fprobes, it sets TPARG_FL_TYPECAST and calls parse_btf_arg(). Inside
parse_btf_arg(), ctx_btf() evaluates to ctx->struct_btf, so it bypasses
query_btf_context() and jumps to found_type.

However, it doesn't seem to initialize code->op with a valid base fetch
instruction like FETCH_OP_ARG or FETCH_OP_REG.

Could this leave the base instruction as FETCH_OP_NOP (0)? If so, it
seems the base address would be 0, causing subsequent field dereferences
to safely fail on 0 + offset due to copy_from_kernel_nofault(). This might
allow unsupported syntax like (sk_buff)%di->dev to parse but silently
fetch nothing.

> +		ctx->flags &=3D ~TPARG_FL_TYPECAST;

[Severity: High]
The TPARG_FL_TYPECAST flag is cleared here, but ctx->last_type still
points to a type originating from ctx->struct_btf.

Later in traceprobe_parse_probe_arg_body(),
check_prepare_btf_string_fetch() is called. Since the flag is cleared,
ctx_btf() will incorrectly return ctx->btf (vmlinux for kprobes, or
NULL for eprobes).

Does this cause check_prepare_btf_string_fetch() to return 0 for eprobes
and skip adding the necessary dummy FETCH_OP_DEREF for string fetches?
Without this dummy dereference, string fetches on character pointers
in eprobes might fail by reading the raw pointer value itself as a string.

Also, for kprobes, could this cause type confusion if
btf_type_skip_modifiers() looks up a module's type ID inside the vmlinux
BTF?

> +		ctx->last_struct =3D NULL;
> +		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519130144.40e7=
1a00@fedora?part=3D1
