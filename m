Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9A3B8D5C
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140632; cv=none; b=jRrnOiR8JRKMTF2lHQyJFhauEIDGNhBj+n3JgukdZKXGtlSGhjbOjOVwp0mcrXC6mDv6f/JdlNB6zg+u6BjYJQP7fx6kZIiZaX6xG4FBKCKroSoxp1EO4mnJPMaq27Y/H9saMlWpWKW7BoWxmWGi1/jPUQU5tiliLRzjGlzXN+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140632; c=relaxed/simple;
	bh=1qkkHWrbmB8GbJRa1daENfyN5HDPDg65PAqAyGVES9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ELLvjtkHDsg4Mj6ksGhXRDP4mYoeRsUupKLYZRWq4kpbmjcAVf2LkLE4JN21swYnUrT3W123rB6aDsIBAbT8SeT7dfjdDfIef5V+Mcv7O3k1lxIFdXCLRGTCW/sVbUKUW1R0mW+Zpl47VeoIHgvyYBF6W5YGszZB6X2ILKOEB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=YJ3hnzbq; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="YJ3hnzbq"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506984b6d83so9532431cf.3
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 13:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772140623; x=1772745423; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gq5mOF+SJUFiGcPwVZyypyyuyc2ozhC/CT81PmE1Pmw=;
        b=YJ3hnzbqofFtj+JZpXhEzPz817m5Xx4gH+rUqcGX3Uls7xD9fn9RaNPwKNaursccny
         vXiUAVFqoVHsOLDmDkqYs4HQ7FJ9QZI5I4ynRSenUnaeSoUqh/l+M2ehoszXtrU40XBr
         4Qljm7BhkkjEbh3kr6jA5nJg0Jgg1amNzkFd73iF1OfuaFA6F2WF2bHh3wAjaREbFLtA
         sfK4+ublSmYqVcefDmEcBlU/h3bGDazzVjj1S2n3mup8WMitGX9Z4nSejnmPEXcnkKEj
         g82baQo0AdS9PyZUi5OSlyQ+VCtWqWKPRSeN2xGLeSrs5DwN4aRIIHvvNrS4+z1B4ZQU
         qjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140623; x=1772745423;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gq5mOF+SJUFiGcPwVZyypyyuyc2ozhC/CT81PmE1Pmw=;
        b=Qptk5J7lKDFK8Z/Kky2xoVlQQmnvtRaGS2ujchaplb6hszRJcFAu9ed63Xo0IGpG3b
         wciX2KGWgBGTZenBR8p+EgDESI9YSsuWevnHMkfZpW/jAIvtUI8o03rllY0jOR77+FGt
         m7ETYJ2UrmHWYUYoIngVqmPVlK/nA7G/7H8Pb+DcWjpixz8NOmUHmXP3tNoTzj5lvSd1
         PfblmitPE+PY+jw7CW8cEPOtZ27BnURG5MP2ToqFf5NBWcCBfiGHMFRhSAxYYGfm8ucx
         GsFbOj7zGzlBWf8lyUxRAheJq78bv2PrAVyxS07ltNnMCGePKoXjUgqqaD9BQMMJtNFi
         /Fww==
X-Forwarded-Encrypted: i=1; AJvYcCUSqR8vg8zFSn7Iy9LMi+VE90KkEgKWI5Br0fRqHRvOPGB4vwAsrn77PWSJZ5mH/cuRAJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFAFaojxn1GSHkzcaLvuoJyO0/SBWE3GzXgXA3EZJ1jCYECdl7
	QeMAHlHhutQcXRWuVpGQKgpJO3goq0zHtx1YFOruHSi5qFV++lzP0/SFqR7IrbzIt2o=
X-Gm-Gg: ATEYQzxJ12SHxwEH7/IflsTm5OAQPf1VzB1TRHPnLewWbcDmIgyWj0r0JfcNVTp679C
	Q8z5DotZnfSX/gM7zp3Bwag55j+fIepyUfJO0Dt9kJVseHsSu6um1nltBRdlGhlcyAwVK79asaL
	iSq3fqy5Gmg59wCOULmRrDeJLsa+Xe2wb29PU22JweFomzVzmtXdPKK+EcwsawPLsp+zM/zCWKD
	UViYAn0dhUcNiHQWQEEpvTfTo23zsJ/u3JUUwCgqmtwMenI0PNRTl0T65M5HkENpF+Fll4hJT7e
	ZBox2b3hdV6AFbKqAU/loqatrib5UmFL+aijvuh93lH2JTbR98aE6JPurcW68byWZ6t0kX1laPV
	IKWdp+d5T6Kf1/7s5HFTastUBCWQjYNAjXRBdu6HnhUORZx/EgWY5U722cq1wv0kvJwpBhNv07n
	rXSculaIUyJDoK9DVN3Jh7HrE=
X-Received: by 2002:ac8:7c50:0:b0:506:1c5e:d1c2 with SMTP id d75a77b69052e-507528cea2cmr4960811cf.27.1772140623241;
        Thu, 26 Feb 2026 13:17:03 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744afbba3sm31709011cf.33.2026.02.26.13.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 13:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Feb 2026 16:17:01 -0500
Message-Id: <DGP7F6QOXDK0.1LUCS3MPFYJOL@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <martin.lau@kernel.org>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Factor out program return value
 calculation
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260225033356.518313-1-emil@etsalapatis.com>
 <20260225033356.518313-2-emil@etsalapatis.com>
 <7d080cc5fe67d32fef566a13cee0cd933b13d6f8.camel@gmail.com>
In-Reply-To: <7d080cc5fe67d32fef566a13cee0cd933b13d6f8.camel@gmail.com>

On Wed Feb 25, 2026 at 6:31 PM EST, Eduard Zingerman wrote:
> On Tue, 2026-02-24 at 22:33 -0500, Emil Tsalapatis wrote:
>> Factor the return value range calculation logic in check_return_code
>> out of the function in preparation for separating the return value
>> validation logic for BPF_EXIT and bpf_throw().
>>=20
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>
> I like this refactoring, thank you! The logic seem to be preserved.
> A few nits below.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
>> =C2=A0kernel/bpf/verifier.c | 205 +++++++++++++++++++++++---------------=
----
>> =C2=A01 file changed, 114 insertions(+), 91 deletions(-)
>>=20
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index edf5342b982f..96ec27a36b32 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -17837,82 +17837,14 @@ static int check_ld_abs(struct bpf_verifier_en=
v *env, struct bpf_insn
>> *insn)
>> =C2=A0	return 0;
>> =C2=A0}
>> =C2=A0
>> -static int check_return_code(struct bpf_verifier_env *env, int regno, c=
onst char *reg_name)
>> +
>> +static int return_retval_range(struct bpf_verifier_env *env, struct bpf=
_retval_range *range,
>> +		bool *return_32bit)
>
> Nit: maybe make this function bool?
>      It does not seem to return any errors.


Annoyingly, there is a _single_ -EOPNOTSUPP for TRACING programs that do
not have one of 6 attach types (FENTRY/FEXIT/FSESSION/RAW_TP/MODIFY_RETURN/=
TRACE_ITER).=20
IIUC This is actually an exhaustive list of all attach types for a TRACING =
program, so the
-EOPNOTSUPP is redundant - we check the attach type is valid at attach/link=
 creation time=20
with bpf_prog_attach_check_attach_type. We can have any invalid attach type=
s for TRACING=20
progs fall through to the default range and turn the whole function into a =
bool.

>
>> =C2=A0{
>> -	const char *exit_ctx =3D "At program exit";
>> -	struct tnum enforce_attach_type_range =3D tnum_unknown;
>> -	const struct bpf_prog *prog =3D env->prog;
>> -	struct bpf_reg_state *reg =3D reg_state(env, regno);
>> -	struct bpf_retval_range range =3D retval_range(0, 1);
>> =C2=A0	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
>> -	int err;
>> -	struct bpf_func_state *frame =3D env->cur_state->frame[0];
>> -	const bool is_subprog =3D frame->subprogno;
>> -	bool return_32bit =3D false;
>> -	const struct btf_type *reg_type, *ret_type =3D NULL;
>> -
>> -	/* LSM and struct_ops func-ptr's return type could be "void" */
>> -	if (!is_subprog || frame->in_exception_callback_fn) {
>> -		switch (prog_type) {
>> -		case BPF_PROG_TYPE_LSM:
>> -			if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
>> -				/* See below, can be 0 or 0-1 depending on hook. */
>> -				break;
>> -			if (!prog->aux->attach_func_proto->type)
>> -				return 0;
>> -			break;
>> -		case BPF_PROG_TYPE_STRUCT_OPS:
>> -			if (!prog->aux->attach_func_proto->type)
>> -				return 0;
>> -
>> -			if (frame->in_exception_callback_fn)
>> -				break;
>> -
>> -			/* Allow a struct_ops program to return a referenced kptr if it
>> -			 * matches the operator's return type and is in its unmodified
>> -			 * form. A scalar zero (i.e., a null pointer) is also allowed.
>> -			 */
>> -			reg_type =3D reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NULL=
;
>> -			ret_type =3D btf_type_resolve_ptr(prog->aux->attach_btf,
>> -							prog->aux->attach_func_proto->type,
>> -							NULL);
>> -			if (ret_type && ret_type =3D=3D reg_type && reg->ref_obj_id)
>> -				return __check_ptr_off_reg(env, reg, regno, false);
>> -			break;
>> -		default:
>> -			break;
>> -		}
>> -	}
>> =C2=A0
>> -	/* eBPF calling convention is such that R0 is used
>> -	 * to return the value from eBPF program.
>> -	 * Make sure that it's readable at this time
>> -	 * of bpf_exit, which means that program wrote
>> -	 * something into it earlier
>> -	 */
>> -	err =3D check_reg_arg(env, regno, SRC_OP);
>> -	if (err)
>> -		return err;
>> -
>> -	if (is_pointer_value(env, regno)) {
>> -		verbose(env, "R%d leaks addr as return value\n", regno);
>> -		return -EACCES;
>> -	}
>> -
>> -	if (frame->in_async_callback_fn) {
>> -		exit_ctx =3D "At async callback return";
>> -		range =3D frame->callback_ret_range;
>> -		goto enforce_retval;
>> -	}
>> -
>> -	if (is_subprog && !frame->in_exception_callback_fn) {
>> -		if (reg->type !=3D SCALAR_VALUE) {
>> -			verbose(env, "At subprogram exit the register R%d is not a scalar va=
lue
>> (%s)\n",
>> -				regno, reg_type_str(env, reg->type));
>> -			return -EINVAL;
>> -		}
>> -		return 0;
>> -	}
>> +	/* Default return value range. */
>> +	*range =3D retval_range(0, 1);
>> =C2=A0
>> =C2=A0	switch (prog_type) {
>> =C2=A0	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>> @@ -17925,16 +17857,14 @@ static int check_return_code(struct bpf_verifi=
er_env *env, int regno, const
>> char
>> =C2=A0		=C2=A0=C2=A0=C2=A0 env->prog->expected_attach_type =3D=3D BPF_CG=
ROUP_INET4_GETSOCKNAME ||
>> =C2=A0		=C2=A0=C2=A0=C2=A0 env->prog->expected_attach_type =3D=3D BPF_CG=
ROUP_INET6_GETSOCKNAME ||
>> =C2=A0		=C2=A0=C2=A0=C2=A0 env->prog->expected_attach_type =3D=3D BPF_CG=
ROUP_UNIX_GETSOCKNAME)
>> -			range =3D retval_range(1, 1);
>> +			*range =3D retval_range(1, 1);
>> =C2=A0		if (env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET4_BIND=
 ||
>> =C2=A0		=C2=A0=C2=A0=C2=A0 env->prog->expected_attach_type =3D=3D BPF_CG=
ROUP_INET6_BIND)
>> -			range =3D retval_range(0, 3);
>> +			*range =3D retval_range(0, 3);
>> =C2=A0		break;
>> =C2=A0	case BPF_PROG_TYPE_CGROUP_SKB:
>> -		if (env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET_EGRESS) {
>> -			range =3D retval_range(0, 3);
>> -			enforce_attach_type_range =3D tnum_range(2, 3);
>> -		}
>> +		if (env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET_EGRESS)
>> +			*range =3D retval_range(0, 3);
>> =C2=A0		break;
>> =C2=A0	case BPF_PROG_TYPE_CGROUP_SOCK:
>> =C2=A0	case BPF_PROG_TYPE_SOCK_OPS:
>> @@ -17945,14 +17875,14 @@ static int check_return_code(struct bpf_verifi=
er_env *env, int regno, const
>> char
>> =C2=A0	case BPF_PROG_TYPE_RAW_TRACEPOINT:
>> =C2=A0		if (!env->prog->aux->attach_btf_id)
>> =C2=A0			return 0;
>> -		range =3D retval_range(0, 0);
>> +		*range =3D retval_range(0, 0);
>> =C2=A0		break;
>> =C2=A0	case BPF_PROG_TYPE_TRACING:
>> =C2=A0		switch (env->prog->expected_attach_type) {
>> =C2=A0		case BPF_TRACE_FENTRY:
>> =C2=A0		case BPF_TRACE_FEXIT:
>> =C2=A0		case BPF_TRACE_FSESSION:
>> -			range =3D retval_range(0, 0);
>> +			*range =3D retval_range(0, 0);
>> =C2=A0			break;
>> =C2=A0		case BPF_TRACE_RAW_TP:
>> =C2=A0		case BPF_MODIFY_RETURN:
>> @@ -17967,40 +17897,37 @@ static int check_return_code(struct bpf_verifi=
er_env *env, int regno, const
>> char
>> =C2=A0		switch (env->prog->expected_attach_type) {
>> =C2=A0		case BPF_TRACE_KPROBE_SESSION:
>> =C2=A0		case BPF_TRACE_UPROBE_SESSION:
>> -			range =3D retval_range(0, 1);
>> =C2=A0			break;
>> =C2=A0		default:
>> =C2=A0			return 0;
>> =C2=A0		}
>> =C2=A0		break;
>> =C2=A0	case BPF_PROG_TYPE_SK_LOOKUP:
>> -		range =3D retval_range(SK_DROP, SK_PASS);
>> +		*range =3D retval_range(SK_DROP, SK_PASS);
>> =C2=A0		break;
>> =C2=A0
>> =C2=A0	case BPF_PROG_TYPE_LSM:
>> =C2=A0		if (env->prog->expected_attach_type !=3D BPF_LSM_CGROUP) {
>> =C2=A0			/* no range found, any return value is allowed */
>> -			if (!get_func_retval_range(env->prog, &range))
>> +			if (!get_func_retval_range(env->prog, range))
>> =C2=A0				return 0;
>> =C2=A0			/* no restricted range, any return value is allowed */
>> -			if (range.minval =3D=3D S32_MIN && range.maxval =3D=3D S32_MAX)
>> +			if (range->minval =3D=3D S32_MIN && range->maxval =3D=3D S32_MAX)
>
> Tangential to this refactoring. Looking at get_func_retval_range() it
> seems that S32_{MIN,MAX} special case can never happen.
> It defers to bpf_lsm_get_retval_range() which either does not set the
> range or it to [0, 1] or [-MAX_ERRNO, 0].
> Maybe remove it as a separate patch?
>

Ack, will do.

>> =C2=A0				return 0;
>> -			return_32bit =3D true;
>> +			*return_32bit =3D true;
>
> Nit: maybe make this a special case in check_return_code(),
>      as with enforce_attach_type_range?
>      Or push 'return_32bit' to be a field in retval_range?

Ack, I think return_32bit as a field is cleaner conceptually. I will
keep the default value false to avoid churn on all retval_range()=20
call sites.

>
>> =C2=A0		} else if (!env->prog->aux->attach_func_proto->type) {
>> =C2=A0			/* Make sure programs that attach to void
>> =C2=A0			 * hooks don't try to modify return value.
>> =C2=A0			 */
>> -			range =3D retval_range(1, 1);
>> +			*range =3D retval_range(1, 1);
>> =C2=A0		}
>> =C2=A0		break;
>> =C2=A0
>> =C2=A0	case BPF_PROG_TYPE_NETFILTER:
>> -		range =3D retval_range(NF_DROP, NF_ACCEPT);
>> +		*range =3D retval_range(NF_DROP, NF_ACCEPT);
>> =C2=A0		break;
>> =C2=A0	case BPF_PROG_TYPE_STRUCT_OPS:
>> -		if (!ret_type)
>> -			return 0;
>> -		range =3D retval_range(0, 0);
>> +		*range =3D retval_range(0, 0);
>> =C2=A0		break;
>> =C2=A0	case BPF_PROG_TYPE_EXT:
>> =C2=A0		/* freplace program can return anything as its return value
>
> [...]

