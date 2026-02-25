Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF4292936
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 23:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772062314; cv=none; b=sXBcWUfVoLdQwx9PzJEFva7lPEZZh9cyy8ZYGrCqj2bvb6eTJ5Fbvf6f+Gn77f1PVvCeGF7Vqjayh+eqmgZb050X6hJR7mw1GPZ7Mpw7yKytMmb6ClsG1hXoGGrYKE4zWfajEWAsj2EyGNpV1brkSnmZSqk0ul0UsxicbAtnHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772062314; c=relaxed/simple;
	bh=KHY1UoSL9o7TGbHWwqhfVXhL+dScRKTtxNM5WaqCTrA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=errfkkjVvSgeuc25vpXwwCSsoErfyOkhHq3YoJ8bjUQ1OcKC7a7VDahG4cz9ozqTwXTveNXtPKDX1d8GyMAw5FPkmnZuGZBlxDGESxj/9FVpBRao3CscJXHHCvraKgpvdzXLjM2Tn97P6G2Fa8ENvHdjPk2iUbM2QEhyQK5s7S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MA8wAQ9F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA8wAQ9F"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ade1806c28so1098595ad.1
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 15:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772062312; x=1772667112; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OJo20Hzc+GmpvPuL+15jEyOQHQs2kDUmGzjQsNv8hok=;
        b=MA8wAQ9FbySd/Yq+8U6fEnxUmWlEpaKmuu5LVA9WvCPi45QTIm8xigDOvyU/44WRnH
         2j9p64mAbNyiExXFE9FZ4gK0nHdYVzIUBW0KxDtRaBE0yf/MdAWkjDFiWH13R8Kkb1b9
         B10zFRExjGc3aDT/+tK0XK2rCXtmxU6NUaBCkvP7Nn9Hw2fim5flUHx3qii8VRv52XB3
         JUxWZBQhinpTrftNVtYxIdtv8U3z3tfH/WhQetGYDz1laeyELNyWXgp+HDFUYNBnQ2xz
         xXbq6FQzFEYq/LeYCxCbNtjPIuk3V+4WIoXBM+cVQZ0atcmVqBjBZFKACNW60IVL/FXs
         YnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772062312; x=1772667112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJo20Hzc+GmpvPuL+15jEyOQHQs2kDUmGzjQsNv8hok=;
        b=PM6e4+Bv9tOQOXqBZEZAb5U1KPiAznk3jTplmkItDWoqNYlYKBqMKGkXjjDj28ImuN
         WctDD2PJXYT5NCu5el/cy8WwTy4IEemCPdUqTVhw5fDTh/OcE7RHkMhpCZMO9h0ma62s
         nTh7OFu09YnaO0rmnFqIzwHL0Js8GAO5kpPCJkeJKRAPcTeU5gC8kR2KmcyOMbBrm9/J
         JHSNPoqageGp4eMgT2p0z184m4KldnLyQAPsvMOIQUrxYtN6wYKjmW0YmIGKi3KduX7D
         DioGW1EP0MXgKL9sm3nn5XzsKPg8aKEMNPMJZI7TzgFfDyuP3okfdEUSSGg3xABW6DyM
         JInA==
X-Forwarded-Encrypted: i=1; AJvYcCXFdVE4TBd0hPBH4gpBWoNc8qAbvyA+ayjfXmf+0AzRARX6CVX2K2Gd8mrzHdYFckIorIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyP1txp7jGpXyFqx50FSHc56tuhTZA5MhFz3XJROa0zsymqIUR
	6J7eZ68mdKtrrfXppk5y2btuP5RWHil9NtMmfdTwQwKLPBWn++yjt2owANWC5jCH
X-Gm-Gg: ATEYQzy6znqDRPDUapsvBcO9WUqEuS4RvNveolkQI9VM2PB4WxgzBRSQWzwJKWK2npu
	PA490SyOR0kVzi/o3IoFwHrXf4toH8Z7wvWu69AhObRtRwptqiGHYf0m0IafF1eCzYIQtqIZxkd
	k7IrIOE/Bvdkvvta56qbVHHFGlCEf0erUdJUwGojwoiBzGXk+d44ZZ+p8wFFODXYT+wCREnjS9B
	h25lbnVperWHfcpOtjSFQcRvrTl0WFCxMffL/rJ81GiUVg8GQHG9oYERA3IBiJepsKTbhsIVFTr
	M3HVMmD0R0OQE2fObyRZ+BIhyxMbHP2XNb252vD9q5tdoAvFWOdUF+X7jzMDQR/rJFJYkGDzj3z
	hbXvZ13ntNzVxO8y4k3ocF/FQEjKsp8Pp5wUShwrREc372U6UGXPmqMiYtOxT20nAy50T5sWt7c
	TrwckFymXGZeyi2T4Qj/G85xYcYhzlNQyrG0czlTgc5pmptx310LY=
X-Received: by 2002:a17:902:f607:b0:299:bda7:ae3c with SMTP id d9443c01a7336-2ae0297ca76mr2226495ad.14.1772062311756;
        Wed, 25 Feb 2026 15:31:51 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6c4dd0sm3335225ad.70.2026.02.25.15.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 15:31:51 -0800 (PST)
Message-ID: <7d080cc5fe67d32fef566a13cee0cd933b13d6f8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Factor out program return value
 calculation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
Date: Wed, 25 Feb 2026 15:31:48 -0800
In-Reply-To: <20260225033356.518313-2-emil@etsalapatis.com>
References: <20260225033356.518313-1-emil@etsalapatis.com>
	 <20260225033356.518313-2-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-24 at 22:33 -0500, Emil Tsalapatis wrote:
> Factor the return value range calculation logic in check_return_code
> out of the function in preparation for separating the return value
> validation logic for BPF_EXIT and bpf_throw().
>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

I like this refactoring, thank you! The logic seem to be preserved.
A few nits below.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> =C2=A0kernel/bpf/verifier.c | 205 +++++++++++++++++++++++----------------=
---
> =C2=A01 file changed, 114 insertions(+), 91 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index edf5342b982f..96ec27a36b32 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17837,82 +17837,14 @@ static int check_ld_abs(struct bpf_verifier_env=
 *env, struct bpf_insn
> *insn)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static int check_return_code(struct bpf_verifier_env *env, int regno, co=
nst char *reg_name)
> +
> +static int return_retval_range(struct bpf_verifier_env *env, struct bpf_=
retval_range *range,
> +		bool *return_32bit)

Nit: maybe make this function bool?
     It does not seem to return any errors.

> =C2=A0{
> -	const char *exit_ctx =3D "At program exit";
> -	struct tnum enforce_attach_type_range =3D tnum_unknown;
> -	const struct bpf_prog *prog =3D env->prog;
> -	struct bpf_reg_state *reg =3D reg_state(env, regno);
> -	struct bpf_retval_range range =3D retval_range(0, 1);
> =C2=A0	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
> -	int err;
> -	struct bpf_func_state *frame =3D env->cur_state->frame[0];
> -	const bool is_subprog =3D frame->subprogno;
> -	bool return_32bit =3D false;
> -	const struct btf_type *reg_type, *ret_type =3D NULL;
> -
> -	/* LSM and struct_ops func-ptr's return type could be "void" */
> -	if (!is_subprog || frame->in_exception_callback_fn) {
> -		switch (prog_type) {
> -		case BPF_PROG_TYPE_LSM:
> -			if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
> -				/* See below, can be 0 or 0-1 depending on hook. */
> -				break;
> -			if (!prog->aux->attach_func_proto->type)
> -				return 0;
> -			break;
> -		case BPF_PROG_TYPE_STRUCT_OPS:
> -			if (!prog->aux->attach_func_proto->type)
> -				return 0;
> -
> -			if (frame->in_exception_callback_fn)
> -				break;
> -
> -			/* Allow a struct_ops program to return a referenced kptr if it
> -			 * matches the operator's return type and is in its unmodified
> -			 * form. A scalar zero (i.e., a null pointer) is also allowed.
> -			 */
> -			reg_type =3D reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NULL;
> -			ret_type =3D btf_type_resolve_ptr(prog->aux->attach_btf,
> -							prog->aux->attach_func_proto->type,
> -							NULL);
> -			if (ret_type && ret_type =3D=3D reg_type && reg->ref_obj_id)
> -				return __check_ptr_off_reg(env, reg, regno, false);
> -			break;
> -		default:
> -			break;
> -		}
> -	}
> =C2=A0
> -	/* eBPF calling convention is such that R0 is used
> -	 * to return the value from eBPF program.
> -	 * Make sure that it's readable at this time
> -	 * of bpf_exit, which means that program wrote
> -	 * something into it earlier
> -	 */
> -	err =3D check_reg_arg(env, regno, SRC_OP);
> -	if (err)
> -		return err;
> -
> -	if (is_pointer_value(env, regno)) {
> -		verbose(env, "R%d leaks addr as return value\n", regno);
> -		return -EACCES;
> -	}
> -
> -	if (frame->in_async_callback_fn) {
> -		exit_ctx =3D "At async callback return";
> -		range =3D frame->callback_ret_range;
> -		goto enforce_retval;
> -	}
> -
> -	if (is_subprog && !frame->in_exception_callback_fn) {
> -		if (reg->type !=3D SCALAR_VALUE) {
> -			verbose(env, "At subprogram exit the register R%d is not a scalar val=
ue
> (%s)\n",
> -				regno, reg_type_str(env, reg->type));
> -			return -EINVAL;
> -		}
> -		return 0;
> -	}
> +	/* Default return value range. */
> +	*range =3D retval_range(0, 1);
> =C2=A0
> =C2=A0	switch (prog_type) {
> =C2=A0	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> @@ -17925,16 +17857,14 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const
> char
> =C2=A0		=C2=A0=C2=A0=C2=A0 env->prog->expected_attach_type =3D=3D BPF_CGR=
OUP_INET4_GETSOCKNAME ||
> =C2=A0		=C2=A0=C2=A0=C2=A0 env->prog->expected_attach_type =3D=3D BPF_CGR=
OUP_INET6_GETSOCKNAME ||
> =C2=A0		=C2=A0=C2=A0=C2=A0 env->prog->expected_attach_type =3D=3D BPF_CGR=
OUP_UNIX_GETSOCKNAME)
> -			range =3D retval_range(1, 1);
> +			*range =3D retval_range(1, 1);
> =C2=A0		if (env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET4_BIND =
||
> =C2=A0		=C2=A0=C2=A0=C2=A0 env->prog->expected_attach_type =3D=3D BPF_CGR=
OUP_INET6_BIND)
> -			range =3D retval_range(0, 3);
> +			*range =3D retval_range(0, 3);
> =C2=A0		break;
> =C2=A0	case BPF_PROG_TYPE_CGROUP_SKB:
> -		if (env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET_EGRESS) {
> -			range =3D retval_range(0, 3);
> -			enforce_attach_type_range =3D tnum_range(2, 3);
> -		}
> +		if (env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET_EGRESS)
> +			*range =3D retval_range(0, 3);
> =C2=A0		break;
> =C2=A0	case BPF_PROG_TYPE_CGROUP_SOCK:
> =C2=A0	case BPF_PROG_TYPE_SOCK_OPS:
> @@ -17945,14 +17875,14 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const
> char
> =C2=A0	case BPF_PROG_TYPE_RAW_TRACEPOINT:
> =C2=A0		if (!env->prog->aux->attach_btf_id)
> =C2=A0			return 0;
> -		range =3D retval_range(0, 0);
> +		*range =3D retval_range(0, 0);
> =C2=A0		break;
> =C2=A0	case BPF_PROG_TYPE_TRACING:
> =C2=A0		switch (env->prog->expected_attach_type) {
> =C2=A0		case BPF_TRACE_FENTRY:
> =C2=A0		case BPF_TRACE_FEXIT:
> =C2=A0		case BPF_TRACE_FSESSION:
> -			range =3D retval_range(0, 0);
> +			*range =3D retval_range(0, 0);
> =C2=A0			break;
> =C2=A0		case BPF_TRACE_RAW_TP:
> =C2=A0		case BPF_MODIFY_RETURN:
> @@ -17967,40 +17897,37 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const
> char
> =C2=A0		switch (env->prog->expected_attach_type) {
> =C2=A0		case BPF_TRACE_KPROBE_SESSION:
> =C2=A0		case BPF_TRACE_UPROBE_SESSION:
> -			range =3D retval_range(0, 1);
> =C2=A0			break;
> =C2=A0		default:
> =C2=A0			return 0;
> =C2=A0		}
> =C2=A0		break;
> =C2=A0	case BPF_PROG_TYPE_SK_LOOKUP:
> -		range =3D retval_range(SK_DROP, SK_PASS);
> +		*range =3D retval_range(SK_DROP, SK_PASS);
> =C2=A0		break;
> =C2=A0
> =C2=A0	case BPF_PROG_TYPE_LSM:
> =C2=A0		if (env->prog->expected_attach_type !=3D BPF_LSM_CGROUP) {
> =C2=A0			/* no range found, any return value is allowed */
> -			if (!get_func_retval_range(env->prog, &range))
> +			if (!get_func_retval_range(env->prog, range))
> =C2=A0				return 0;
> =C2=A0			/* no restricted range, any return value is allowed */
> -			if (range.minval =3D=3D S32_MIN && range.maxval =3D=3D S32_MAX)
> +			if (range->minval =3D=3D S32_MIN && range->maxval =3D=3D S32_MAX)

Tangential to this refactoring. Looking at get_func_retval_range() it
seems that S32_{MIN,MAX} special case can never happen.
It defers to bpf_lsm_get_retval_range() which either does not set the
range or it to [0, 1] or [-MAX_ERRNO, 0].
Maybe remove it as a separate patch?

> =C2=A0				return 0;
> -			return_32bit =3D true;
> +			*return_32bit =3D true;

Nit: maybe make this a special case in check_return_code(),
     as with enforce_attach_type_range?
     Or push 'return_32bit' to be a field in retval_range?

> =C2=A0		} else if (!env->prog->aux->attach_func_proto->type) {
> =C2=A0			/* Make sure programs that attach to void
> =C2=A0			 * hooks don't try to modify return value.
> =C2=A0			 */
> -			range =3D retval_range(1, 1);
> +			*range =3D retval_range(1, 1);
> =C2=A0		}
> =C2=A0		break;
> =C2=A0
> =C2=A0	case BPF_PROG_TYPE_NETFILTER:
> -		range =3D retval_range(NF_DROP, NF_ACCEPT);
> +		*range =3D retval_range(NF_DROP, NF_ACCEPT);
> =C2=A0		break;
> =C2=A0	case BPF_PROG_TYPE_STRUCT_OPS:
> -		if (!ret_type)
> -			return 0;
> -		range =3D retval_range(0, 0);
> +		*range =3D retval_range(0, 0);
> =C2=A0		break;
> =C2=A0	case BPF_PROG_TYPE_EXT:
> =C2=A0		/* freplace program can return anything as its return value

[...]
