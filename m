Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D170808
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780962470; cv=none; b=GTZ5eIA+sZvjX6Ev3oct+1CUscf2jDnjeqnSZOrt6+paKcgxIa8CoEG+6+Fq5w/6JvbCjV6Gum4lFnsc5PnuBEGGB0r47wB0vyj2n+qSBOnKUbkU1btaQF8aef3YnjXtcGmI1GWO+13HbNi7WRbMGnfJ9XbYjw21GinzKoDkpfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780962470; c=relaxed/simple;
	bh=qsw3gFuEDDd/10GTCx1sLdDEfaGN1mHdgkhpswkXXtU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=akS1Wbj8fQmjSPJdSLUYNlaHc6+v+yrKeP95YoLOz/awTHG+Y3Fku1hOCFcun7c24gmfTRPSPZ9Y/R5kz/fwdiBzJIB6wQZvra8oXkxOkJDlSn4KR+x5kvk/GA8w8PaOUmMaMv3NKMTFYtkg7kyDiGaAS5GZWXp1dckda1jOKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrSfX23V; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrSfX23V"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3078e0dcd67so2924172eec.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 16:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780962468; x=1781567268; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N2/aQwU8OTPKgUWRmAxXsCOG+ZY1qYT2b6xmL/fJ8x4=;
        b=PrSfX23VQvCKILVC0DPmqdz5w1Y0eXawf02zeXCpc9w2qC5mNJdO3nLaQzPMTDSYyT
         AgVXmbvXT2ZnV8PkLpFtZKt5zuc+35484mqwewxIk1V+IvBl1cgaHHRWD5AYoWykSVKO
         eQmmGP8KR0sbWT9FyMJnk7jOtl7tVmPqy39fwyZE6jE6Q2GuWFL/rtwpKA3E36ntZrig
         1QvhwnsOU466UOc1nqZ/ttCIrCt8OZt8O61FI4eHnvk76o58oXGS7SRV41GuTI47cXHX
         tNYBFhvZGjHKbcf2Tp3Hlf32RHUYmqNV3GrTz6NFwa4d4u6SrKPuhIHvPStawU6SX3E1
         3ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780962468; x=1781567268;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2/aQwU8OTPKgUWRmAxXsCOG+ZY1qYT2b6xmL/fJ8x4=;
        b=USG7MC1XbUwxjr9xS7b8alq66v3bvUm3kLfmVHQAtTsyCMrR+GOGIrjP4Svnk2Y0fT
         KCI4rf+AJMinCrS37gQ0C9sJZez6naHUk7xoVRpmW9z/Xe3dsrBQx/p0xFbZ7SJIPP8C
         uV+NzcYL8DVpbey0r701EepSUJZwdVxJctvwfhafN0LOSz9pnZ0yGLK6Oi7pUcYZ5uKi
         cmRl68eLJlFzLI1Hf5QZsXqzH2O0NBVcUkcsiPwv093+m8nXX1ub6aCNyFcmYJFg83h8
         DghOANTicz0kw+1sZiwR/iMQ0IN2ZHkfiRCBxCgAjR8ptQ6q+cxGVcYFm+G6lOVW+qwI
         7wkA==
X-Forwarded-Encrypted: i=1; AFNElJ/zbdBC1YmZPsF7NIJHezxeicTulf3EX1JVIt5mN+uWl0UvBybtM/m9WHXbSy/BUW967+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrFXhrMUPwNTLxCWzgz1DkkZOYoxv7vmj8Vyr+U8SusFfBhnKp
	TkMx+I6KIryQ33RGtjK489mOBJbuEeM9HTCnDhG06ZvJ+ziqdI4AkLw2fGKB98dD
X-Gm-Gg: Acq92OG5IEDNypGX4Qf96SOVX8XcY1UM+31/aiAPhIqJshD+0cEhutVKVp49rg6PjVa
	NXSFfsbiGvhP3e6AQpvGLL2jN1zhl72Mag3a93i0+WTjn6Pz51M2erYnJJNDf0wVnU9aDb1n1Zl
	ITSc3rfBlBD92m3Ou4QIoOQVHp+oB69qSB3TvWN8gninFlBYJKpGIuK540SZhyC28ozfja0/4Rd
	F7OEuudY+WPVvBwE0JAfCpi0BtLgP3eTINuGhYa+n49zVMRUUQqnzgn6lH+Z36hC+HcDThmGrJp
	+psxWdrxqtQA8+rLtGoK31U0XU9mubrVF/71LT5sdShWqAYj2wYnHVoQRVvYYFqWqxC8uLuEQUu
	nf42QMjbrplUU55yX1XJqsJv9NM3FO7iWo+IQzQvZBx4csisrn4yv/+oD8WY6Vd/brfo3gYUYCZ
	oHsFLSmaUbOiv0/ixw5AxlL5p3ssR0NSgWj8F7xYGMNW3d4H5MfUAH1gVt/On+PT55DNK750ZBF
	IU/HwO9FmtJSDEowAI=
X-Received: by 2002:a05:7300:2209:b0:304:c651:bdea with SMTP id 5a478bee46e88-3077b22a913mr10557497eec.21.1780962467732;
        Mon, 08 Jun 2026 16:47:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cde6:fb53:a1a3:a385? ([2620:10d:c090:500::3:b685])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8e76sm18001055eec.18.2026.06.08.16.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 16:47:47 -0700 (PDT)
Message-ID: <028ed8571ea0aee867facb2defc8340e8421b258.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 08/17] bpf: Report Register Type Safety
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Mon, 08 Jun 2026 16:47:45 -0700
In-Reply-To: <20260605063412.974640-9-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
	 <20260605063412.974640-9-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 08:33 +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 7a122c5025c2..920ac17758c2 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -457,6 +457,16 @@ static const char *bpf_diag_context_name(enum bpf_di=
ag_context_kind kind)
>  	}
>  }
> =20
> +static u32 bpf_diag_current_frameno(const struct bpf_verifier_env *env)
> +{
> +	const struct bpf_verifier_state *state =3D env->cur_state;
> +
> +	if (!state || !state->frame[state->curframe])
> +		return 0;
> +
> +	return state->frame[state->curframe]->frameno;
> +}

Nit: this can be `return state->frame[state->curframe]->frameno;`,
     it is never called in a context when there is no current state.


[...]

> +void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 ins=
n_idx,
> +				   int regno, const char *reg_name,
> +				   const char *type_name,
> +				   enum bpf_diag_invalid_deref_kind kind,
> +				   s64 offset)

Nit: bpf_diag_report_register_type() accepts reason as a char*, while
     this function uses an enum. Maybe keep the interface consistent
     between similar functions?


[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7bb2a81ee353..adf660ab9e7d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -13707,12 +13736,28 @@ static int adjust_ptr_min_max_vals(struct bpf_v=
erifier_env *env,
>  		verbose(env,
>  			"R%d 32-bit pointer arithmetic prohibited\n",
>  			dst);
> +		scnprintf(reason, sizeof(reason),
> +			  "R%d holds %s. 32-bit ALU operations on pointers discard pointer pr=
ovenance, so the verifier cannot keep the result as a safe "
> +			  "pointer.",
> +			  dst, bpf_diag_reg_type_plain(env, ptr_reg->type));
> +		bpf_diag_report_register_type(env, env->insn_idx, dst,
> +					      "32-bit pointer arithmetic",
> +					      reason,
> +					      "Use 64-bit pointer arithmetic with an allowed, bounded scala=
r offset, or convert the value to a scalar only after pointer use "
> +					      "is complete.");

Nit: What is our recommended way to convert a pointer to a scalar?
     Might be non-trivial, I'd drop this suggestion or provided a recipe.

>  		return -EACCES;
>  	}
> =20
>  	if (ptr_reg->type & PTR_MAYBE_NULL) {
>  		verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it f=
irst\n",
>  			dst, reg_type_str(env, ptr_reg->type));
> +		scnprintf(reason, sizeof(reason),
> +			  "R%d may be NULL (%s). Pointer arithmetic is allowed only after the=
 program proves the pointer is non-NULL on this path.",
> +			  dst, reg_type_str(env, ptr_reg->type));
> +		bpf_diag_report_register_type(env, env->insn_idx, dst,
> +					      "pointer arithmetic before NULL check",
> +					      reason,
> +					      "Add a NULL check first, and do the pointer arithmetic only o=
n the non-NULL branch.");

Nit: "Make sure that a NULL check precedes any arithmetic performed on the =
pointer."
     (as this is most likely because of the compiler shenanigans).

>  		return -EACCES;
>  	}
> =20
> @@ -13749,6 +13794,13 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env,
>  	default:
>  		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
>  			dst, reg_type_str(env, ptr_reg->type));
> +		scnprintf(reason, sizeof(reason),
> +			  "R%d holds %s. This pointer kind does not allow arithmetic because =
changing its offset would lose the verifier's required provenance.",
> +			  dst, bpf_diag_reg_type_plain(env, ptr_reg->type));
> +		bpf_diag_report_register_type(env, env->insn_idx, dst,
> +					      "pointer arithmetic is not allowed",
> +					      reason,
> +					      "Keep this pointer unchanged, or derive an allowed pointer ty=
pe before applying a bounded offset.");
                                                                           =
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                                                           =
 What does this mean?
                                                                           =
 As far as I understand, this check would fire for sockets
                                                                           =
 and CONST_PTR_TO_DYNPTR. I'd drop this suggestion altogether.

>  		return -EACCES;
>  	}
> =20
> @@ -13758,9 +13810,26 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env,
>  	dst_reg->type =3D ptr_reg->type;
>  	dst_reg->id =3D ptr_reg->id;
> =20
> -	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type) ||
> -	    !check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type))
> +	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type)) {
> +		scnprintf(reason, sizeof(reason),
> +			  "The scalar offset used with R%d has a range the verifier cannot sa=
fely add to %s.",
> +			  dst, bpf_diag_reg_type_plain(env, ptr_reg->type));

Maybe print what counts as a sane offset as well?

> +		bpf_diag_report_register_type(env, env->insn_idx, dst,
> +					      "pointer offset is not safe",
> +					      reason,
> +					      "Clamp or bound-check the scalar offset before adding it to t=
he pointer.");
> +		return -EINVAL;
> +	}
> +	if (!check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type)) {
> +		scnprintf(reason, sizeof(reason),
> +			  "R%d already has an offset that is outside the verifier's safe poin=
ter range for %s.",
> +			  dst, bpf_diag_reg_type_plain(env, ptr_reg->type));
> +		bpf_diag_report_register_type(env, env->insn_idx, dst,
> +					      "pointer offset is not safe",
> +					      reason,
> +					      "Keep the base pointer within the verifier's allowed offset r=
ange before applying more arithmetic.");
>  		return -EINVAL;
> +	}
> =20
>  	/* pointer types do not carry 32-bit bounds at the moment. */
>  	__mark_reg32_unbounded(dst_reg);
> @@ -13803,6 +13872,14 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env,
>  			/* scalar -=3D pointer.  Creates an unknown scalar */
>  			verbose(env, "R%d tried to subtract pointer from scalar\n",
>  				dst);
> +			scnprintf(reason, sizeof(reason),
> +				  "This operation subtracts a pointer from scalar register R%d. The =
verifier does not allow pointer provenance to flow through scalar "

Nit: I'd just say that verifier does not allow this, avoiding the provenanc=
e flow.

> +				  "subtraction.",
> +				  dst);
> +			bpf_diag_report_register_type(env, env->insn_idx, dst,
> +						      "pointer subtracted from scalar",
> +						      reason,
> +						      "Keep pointer values in pointer registers, or use explicit s=
calar values that do not come from pointer arithmetic.");

Nit: "Keep pointer values in pointer registers...", I'd drop this,
     it is not very clear what the pointer register is.

>  			return -EACCES;
>  		}
>  		/* We don't allow subtraction from FP, because (according to
> @@ -13812,6 +13889,14 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env,
>  		if (ptr_reg->type =3D=3D PTR_TO_STACK) {
>  			verbose(env, "R%d subtraction from stack pointer prohibited\n",
>  				dst);
> +			scnprintf(reason, sizeof(reason),
> +				  "R%d is derived from the frame pointer. Subtracting from a stack p=
ointer is not allowed because stack accesses must stay within the "
> +				  "verifier's tracked frame offsets.",
> +				  dst);
> +			bpf_diag_report_register_type(env, env->insn_idx, dst,
> +						      "subtraction from stack pointer",
> +						      reason,
> +						      "Use fixed negative stack offsets from R10, and avoid arithm=
etic that moves the frame pointer backward.");

This is a misleading suggestion. We do allow varying offset access for R10.
Also, the final offset must be negative, but intermediate values can be pos=
itive.

>  			return -EACCES;
>  		}
>  		dst_reg->r64 =3D cnum64_add(ptr_reg->r64, cnum64_negate(off_reg->r64))=
;

[...]
