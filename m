Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CCD25BF13
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 04:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779163768; cv=none; b=g5syhTimJoSxDfI5xHvUo3aokth4AqQTnErfeT96LAZuHg7kxTmSSjEDSGU6DR57Pie3nLcDTqQbm7g3RT9YqKRvy3ww2AAUwzFgZ4mM56Hif4mAu3m88HSOiBUlotjfyN8wxiK6MlC90s2xVQiwFyy2a8+KV6wkbTAAmwyk6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779163768; c=relaxed/simple;
	bh=DTUd5vp9uElV8Wp7D6ETvdziBtRKGRA38Omuo4Ke8IY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pNxTihI6XV77aO405aHRzbekTI0iphveGkJyqRb6F0ijnPH36NiYLPn8qxGsfj0b3ZySTEyPtxNx6au4HRDWQQbVeNImy9+a9sCn5qr806f5ZgeT5/c4lzOlRKpGeGCh4Z1uENiiPYlEgl82w7Z4Hq9V3Txo9vWqQ8Epp3I3Yrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0K79FcK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0K79FcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458C4C2BCB3;
	Tue, 19 May 2026 04:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779163768;
	bh=DTUd5vp9uElV8Wp7D6ETvdziBtRKGRA38Omuo4Ke8IY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=n0K79FcKyrdjUJZzWhRuCIxpFnEH2qJlJVugC8DeSsTf5s0dntnqxtZVLK+sd+EHC
	 3AVFT5EZUsEEVeFbjMpZR8KOil2AR/Jaby37sOGYXzP7V7ASa9YBxbyfygyARKXTgG
	 cUm719rD78UxmCyISvMrRenRNZatUbTDY7BQE+SDN8lv/G9ztaB+0ZRYUKlDQBaLMp
	 VvF5gQxuNHa0xLDECFUqBROnL1nCvSR7gxM5xQe0nkrsKGvfeEaXc8ET0OY4QBkKJy
	 cudcNY88DSjtf9GnwljKJ9FSSciaamaj4uJPuh3EcKM2c1qPpCBPyGl4+YJkQSdrVB
	 RC5ShLXWvRmkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] tracing/probes: Allow use of BTF names to
 dereference pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260518232312.0c78f055@gandalf.local.home>
References: <20260518232312.0c78f055@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 04:09:27 +0000
Message-Id: <20260519040928.458C4C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] NULL pointer dereference in `parse_btf_arg()` when typecasting `$r=
etval`
- [High] Instruction stream corruption when typecasting BTF variables with =
field dereferences
- [High] Parser state corruption breaks multi-argument probes and standard =
BTF parameter resolution
- [Medium] Hardcoded syntax check strictly prohibits typecasting hardware r=
egisters and standard BTF arguments
- [Medium] Using `strrchr` causes parsing failures for memory dereferences =
containing parentheses
--

commit 8ce6119a14206ed21706a773d9694dc24e53436e
Author: Steven Rostedt <rostedt@goodmis.org>

tracing/probes: Allow use of BTF names to dereference pointers

This commit adds syntax to FETCHARG parsing to allow typecasting a value
to a pointer to a structure. This allows users to rely on BTF to figure out
member offsets instead of manually finding and hardcoding numerical offsets.

> But for event probes, or generic kprobes that records a register that
> happens to be a pointer to a structure, they cannot dereference these
> values with BTF naming, but must use numerical offsets.

Does the code actually support dereferencing a register here? Hardware
registers (like %rdi) and standard BTF arguments (like skb) do not begin
with a $ character, but the parser explicitly enforces that the cast is
followed by a $.

> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index e1c73065dae51..29b5a99074d76 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
[ ... ]
> @@ -471,12 +491,12 @@ static int query_btf_context(struct traceprobe_pars=
e_context *ctx)
>  	struct btf *btf;
>  	s32 nr;
> =20
> -	if (ctx->btf)
> -		return 0;
> -
>  	if (!ctx->funcname)
>  		return -EINVAL;
> =20
> +	if (ctx->btf)
> +		return 0;
> +

If a user creates a probe with a struct cast for the return value (like
(struct task_struct*)$retval), query_btf_struct() resolves the struct and
sets ctx->btf but leaves ctx->proto as NULL.

When parse_btf_arg() later handles $retval, it calls query_btf_context(),
which will return 0 here because ctx->btf is already set. Does this lead
to parse_btf_arg() unconditionally dereferencing a NULL ctx->proto?

Additionally, for multi-argument probes where the first argument is a cast
(like arg1=3D(struct foo*)$arg1 arg2=3Dskb), setting ctx->btf for the first
argument causes this check to return early for the second argument. Could
this skip populating ctx->params and ctx->nr_params, causing valid BTF
arguments to be rejected?

[ ... ]
> @@ -952,6 +986,12 @@ static int parse_probe_vars(char *orig_arg, const st=
ruct fetch_type *t,
>  	int ret =3D 0;
>  	int len;
> =20
> +	if (ctx->flags & TPARG_FL_STRUCT) {
> +		ret =3D parse_btf_arg(orig_arg, pcode, end, ctx);
> +		if (ret < 0)
> +			return ret;
> +	}
> +

When parse_btf_arg() successfully parses a typecast with field dereferences,
it emits a FETCH_OP_DEREF instruction and advances the *pcode pointer.

Since this block doesn't return upon success, execution continues and match=
es
the base variable name later in parse_probe_vars(). The local code pointer
is not updated to reflect the advanced *pcode, so it writes a new instructi=
on
(like FETCH_OP_ARG) into the same slot.

Will this overwrite the FETCH_OP_DEREF instruction and corrupt the trace pr=
obe
bytecode?

[ ... ]
> @@ -1231,6 +1271,43 @@ parse_probe_arg(char *arg, const struct fetch_type=
 *type,
>  				code->op =3D FETCH_OP_IMM;
>  		}
>  		break;
> +	case '(':
> +		tmp =3D strrchr(arg, ')');

If a user attempts to cast a standard memory dereference that itself
contains parentheses (such as (struct foo*)+0($arg1)), strrchr() will
find the final parenthesis of $arg1).

Will this cause the pointer validation logic below to evaluate the wrong
segment of the string and incorrectly fail with NO_PTR_STRCT?

> +		if (!tmp) {
> +			trace_probe_log_err(ctx->offset + strlen(arg),
> +					    DEREF_OPEN_BRACE);
> +			return -EINVAL;
> +		}
> +
> +		tmp--;
> +		if (*tmp !=3D '*') {
> +			trace_probe_log_err(ctx->offset + (tmp - arg),
> +					    NO_PTR_STRCT);
> +			return -EINVAL;
> +		}
> +		*tmp =3D '\0';
> +		ret =3D query_btf_struct(arg + 1, ctx);
> +		*tmp =3D '*';
> +
> +		if (ret < 0) {
> +			trace_probe_log_err(ctx->offset + 1, NO_PTR_STRCT);
> +			return -EINVAL;
> +		}
> +
> +		ctx->flags |=3D TPARG_FL_STRUCT;
> +		tmp +=3D 2;
> +
> +		if (*tmp !=3D '$') {

Is this strict check for '$' intentional?

As mentioned regarding the commit message, this prevents typecasting hardwa=
re
registers and standard BTF arguments since they do not start with a '$',
effectively restricting the feature to $retval, $stack, and $argN.

> +			trace_probe_log_err(ctx->offset + (tmp - arg),
> +					    BAD_VAR);
> +			return -EINVAL;
> +		}
> +
> +		ctx->offset +=3D tmp - arg;
> +		ret =3D parse_probe_vars(tmp, type, pcode, end, ctx);
> +		ctx->flags &=3D ~TPARG_FL_STRUCT;
> +		ctx->last_struct =3D NULL;
> +		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518232312.0c78=
f055@gandalf.local.home?part=3D1
