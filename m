Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D4E3D331A
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780698722; cv=none; b=C2vNrQfVOlx2sle4P7pxQfA97tY8ONR38QWbEvvFAfLPaWaCMLHIypKvm2mBRlNZXufbYqu2k7Q6AMhm4OwFNhzqhaNQYDkixEyZ0pmmSy57DgHsCGcGOeUULHXAOPqsSwxJXggI1iM9d2nZXA0bw/AaxfKHQDXyhJfhViFgqqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780698722; c=relaxed/simple;
	bh=vRIqkTQJBMhVRiTkHCg3BIo6pdzhZL5uarQ1lBAwOUQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R8XVu5aNFAOpRSvugnVFPKIWOXyqnHx+W1N+EXSvWllpWCryMpJwV+nsAh5nn766yWfEWfg56VQImtbUo+i39GgibrtsQNeO/SCzV4VNqoC24fxjCDLyB5HnefTtoQd9y5PxYW+Cx9gjWaw5kmpXa4Ij471GGPOAglbsXRdUdEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kt733rJg; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt733rJg"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-137dd5161feso5189389c88.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 15:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780698720; x=1781303520; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mMyj5px4rHEyS7MnvfgqcPPHu8R2iFpHIBXaqLDvhI4=;
        b=kt733rJgwCYbgj6VcmOV0IjkRjnFU9l+mfjEDCkjBc0D017euMHO4pE3aroOiQVCzZ
         mmyuvvsQT8zU9DBexD5uMCGAPXaWnCOfqV/DUejvciPlnPHTfbwL/MRmEi/K2Om+9iQ0
         d9Ns5PsIY3TC/gNTx19X0Uj0f7W72X3601/2amJ9hsSUCZ6+gteN2SWWSAtGNKUSxWTw
         GR4D24Tv4PoOcYgxgCkOMFrYBa+MfYgv3E+ym6cK2LWIcC83MI+smxwM5JAvoAp0lAW8
         oSsYNQChWD9spOXMJfJddp0KT1KnwHQCNbGNMikCieh8nf47n6tvPJ1u3yR4mVG7JAcL
         T/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780698720; x=1781303520;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMyj5px4rHEyS7MnvfgqcPPHu8R2iFpHIBXaqLDvhI4=;
        b=G21zO8UeIwUEMx/I2rIsXRPVIpx44Asvx9yOATP9bjEO5QAeJjxr/AEI4wVgCcSMuO
         F+BgU+Lo+4Mvkzju4ed+s0VZeomDnXrISNHHMddRd9BuK6KMjsx5MRvBDK3V095bmBkZ
         axpuFE5Ty1fujX4CvI1P/aMK4Y5ncgkJNxE2UJC6JuYSttbDGjEYIILgooUOrrEVvxda
         xArQrR4u2mAsLUvyHNha4jX7Ppp8mwwsaaFV4j91HHAlOXfvY1hlXyAbue/rkBz4Mh35
         dCWZu1FblzNhSJwJTYYxOyHLSooPGxcB4B7Z2Lcz3Ly1THLW1fs3YiDmu1ZzmMPpbDCg
         uoJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4eqsgphC08n1XLoWRXQA+LnIGsrIaNYilE3XfoVfc5YV3M1TueqmLuC1spC3XEU0lfeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybtp29t5r9yE/YwoJTpi2K9yFM1pNOx8KtEvoYBCI8ErYBf8F5
	cc0qetgOpz2cngtb+GcJlpMCZVLpubSPM85aR+DVLWiWVMazxddtF5qP
X-Gm-Gg: Acq92OGfGd32S+K0NSpczeYjAlL6vyfxOIM8TUbKK8i7MhWTYp6RA5ibHY27txsHV8V
	U+0AjnNop6a5HdxEWjzWQRn0B42OQoamc9MSVEtW6fGUVgM+3uid+qkov+HRTDRXHXkpzjrc5Jf
	GvhZfsHzwbqhiqk66B7GCrnJBjJBBOqBnR9oJemMj6pDF7tJq6AONdApGWtjDx9h2tzgx94kX1x
	5J1BLOW7jP+HX7Q10Obf9TRVTNm64H7cQpwTjAeSUZThNEAOARJp7YdDEchYtEibJo3Fu2Vgci3
	zAe3wleezJi6xI2+nC+TOjBCqB7a9oLEqrUFIbFqphr5cr6awDfF61jydZr9v6lDEozkReWB2YH
	VeEqYLxWun+x7EW1rK9pJfhxtXbfJnDIXGXzc9bXYG0aq92B3YNkakPEqlMSTfKLn1vgwbEt7kZ
	NumZDcfwY0XL2XBlriZB8mJ8UadlG1S/taWAVKmt+KJUae48U5Lxc9FxoFQycBdRf0AhwxeqHr3
	Jq/D+9jZbspz1+a
X-Received: by 2002:a05:7300:d4ce:b0:307:3a6c:e708 with SMTP id 5a478bee46e88-3077aeed393mr2978175eec.5.1780698719979;
        Fri, 05 Jun 2026 15:31:59 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5171:6892:c6a6:f1b4? ([2620:10d:c090:500::8271])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcbe995sm11570703eec.13.2026.06.05.15.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:31:59 -0700 (PDT)
Message-ID: <50a43d44aa67aba3d04202ad7ddc4e98d160eee7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 05/17] bpf: Track verifier register
 diagnostic history
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Fri, 05 Jun 2026 15:31:57 -0700
In-Reply-To: <20260605063412.974640-6-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
		 <20260605063412.974640-6-memxor@gmail.com>
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

In general this history collection resembles v1/v2 log very much.
It is clearly useful for error reporting.
Hence, I'd suggest that we should bite the bullet and convert log
capture to a binary format, accumulate in the bpf_verifier_env() and
render as we see fit.
Most logging events are exactly kind of modifications that are tracked
here. Logging events unnecessary for the error reporting can be marked
as "unstructured" and saved directly as string messages. At-least as a
stop-gap while migrating to the new scheme.

[...]

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 50cc50a394ca..1bdc7e69fbce 100644

[...]

> @@ -86,6 +87,34 @@ static void bpf_diag_print_wrapped_text(struct bpf_ver=
ifier_env *env,
>  					BPF_DIAG_TEXT_INDENT, text);
>  }
> =20
> +void bpf_diag_format_btf_type(char *buf, size_t size,
> +			      const struct btf_type *type,
> +			      const char *type_name)
> +{

Can we reuse btf.c:btf_show_name() for this?

> +	const char *kind;
> +
> +	switch (BTF_INFO_KIND(type->info)) {
> +	case BTF_KIND_STRUCT:
> +		kind =3D "struct";
> +		break;
> +	case BTF_KIND_UNION:
> +		kind =3D "union";
> +		break;
> +	case BTF_KIND_ENUM:
> +	case BTF_KIND_ENUM64:
> +		kind =3D "enum";
> +		break;
> +	default:
> +		kind =3D btf_type_str(type);
> +		break;
> +	}
> +
> +	if (type_name && *type_name)
> +		scnprintf(buf, size, "'%s %s'", kind, type_name);
> +	else
> +		scnprintf(buf, size, "'%s'", kind);
> +}
> +
>  static void bpf_diag_vprint_indented(struct bpf_verifier_env *env,
>  				     const char *fmt, va_list args)
>  {

[...]

> @@ -442,6 +480,77 @@ void bpf_diag_report_suggestion(struct bpf_verifier_=
env *env, const char *fmt, .


[...]

> +static void bpf_diag_format_scalar_range(char *buf, size_t size,
> +					 s64 smin, s64 smax,
> +					 u64 umin, u64 umax)
> +{

Note: tools/testing/selftests/bpf/prog_tests/reg_bounds.c:snprintf_num()
      does something similar.

> +	char smin_buf[32], smax_buf[32], umin_buf[32], umax_buf[32];
> +
> +	bpf_diag_format_s64_value(smin_buf, sizeof(smin_buf), smin);
> +	bpf_diag_format_s64_value(smax_buf, sizeof(smax_buf), smax);
> +	bpf_diag_format_u64_value(umin_buf, sizeof(umin_buf), umin);
> +	bpf_diag_format_u64_value(umax_buf, sizeof(umax_buf), umax);
> +
> +	scnprintf(buf, size,
> +		  "signed range [%s, %s], unsigned range [%s, %s]",
> +		  smin_buf, smax_buf, umin_buf, umax_buf);
> +}
> +

[...]

> +static int bpf_diag_history_start_idx(const struct bpf_verifier_state *s=
tate,
> +				      const struct bpf_diag_history_opts *opts)
> +{
> +	int i;
> +
> +	if (!opts || (opts->scope !=3D BPF_DIAG_HISTORY_SCOPE_REG &&
> +		      opts->scope !=3D BPF_DIAG_HISTORY_SCOPE_STACK_ARG))
> +		return 0;
> +
> +	for (i =3D state->diag_history_cnt; i > 0; i--) {
> +		const struct bpf_diag_history_event *event =3D &state->diag_history[i =
- 1];
> +
> +		if (opts->scope =3D=3D BPF_DIAG_HISTORY_SCOPE_REG &&
> +		    event->kind =3D=3D BPF_DIAG_HISTORY_REG_MOD &&
> +		    event->reg.dst_reg =3D=3D opts->regno &&
> +		    event->reg.frameno =3D=3D opts->frameno)
> +			return i - 1;
> +		if (opts->scope =3D=3D BPF_DIAG_HISTORY_SCOPE_STACK_ARG &&
> +		    event->kind =3D=3D BPF_DIAG_HISTORY_STACK_ARG &&
> +		    event->stack_arg.slot =3D=3D opts->stack_arg_slot &&
> +		    event->stack_arg.frameno =3D=3D opts->frameno)
> +			return i - 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool bpf_diag_history_event_visible(const struct bpf_diag_history=
_event *event,
> +					   const struct bpf_diag_history_opts *opts)
> +{

I think the history printing loop needs to repeat the logic
backtracking does, tracking a mask of the values to show.
Otherwise a simple stack spill would move the value out of scope.

> +	if (!opts || opts->scope =3D=3D BPF_DIAG_HISTORY_SCOPE_ALL)
> +		return true;
> +
> +	switch (event->kind) {
> +	case BPF_DIAG_HISTORY_BRANCH:
> +		return true;
> +	case BPF_DIAG_HISTORY_REG_MOD:
> +		return opts->scope =3D=3D BPF_DIAG_HISTORY_SCOPE_REG &&
> +		       event->reg.dst_reg =3D=3D opts->regno &&
> +		       event->reg.frameno =3D=3D opts->frameno;
> +	case BPF_DIAG_HISTORY_STACK_ARG:
> +		return opts->scope =3D=3D BPF_DIAG_HISTORY_SCOPE_STACK_ARG &&
> +		       event->stack_arg.slot =3D=3D opts->stack_arg_slot &&
> +		       event->stack_arg.frameno =3D=3D opts->frameno;
> +	default:
> +		return false;
> +	}
> +}

[...]

> +static void bpf_diag_format_reg_snapshot(struct bpf_verifier_env *env, c=
har *buf,
> +					 size_t size,
> +					 const struct bpf_diag_reg_snapshot *snapshot)
> +{

Would it be possible to create a fake bpf_reg_state here and reuse log.c:pr=
int_reg_state()?

[...]

> +}
> +

[...]

> diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
> index 1392ff5fb027..b8dfe8103966 100644
> --- a/kernel/bpf/diagnostics.h
> +++ b/kernel/bpf/diagnostics.h
> @@ -19,6 +19,34 @@ enum bpf_diag_category {
>  	BPF_DIAG_CATEGORY_VERIFIER_INTERNAL_ERROR,
>  };
> =20
> +struct bpf_map;
> +struct btf;
> +struct btf_type;
> +
> +void bpf_diag_format_btf_type(char *buf, size_t size,
> +			      const struct btf_type *type,
> +			      const char *type_name);
> +
> +struct bpf_diag_reg_snapshot {
> +	u32 type;
> +	const struct bpf_map *map_ptr;
> +	const struct btf *btf;
> +	u32 btf_id;
> +	bool var_off_known;

As mark is recorded, there is no reason to record this flag.

> +	s64 var_off_value;
> +	u64 var_off_mask;
> +	s64 smin_value;
> +	s64 smax_value;
> +	u64 umin_value;
> +	u64 umax_value;

I'd use `struct tnum` and `struct cnum64` here instead of *_value and var_o=
ff_mask.

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d60e1309957a..188201d48108 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -8956,10 +9031,24 @@ static int release_reference(struct bpf_verifier_=
env *env, int id)
>  					return err;
>  			}
> =20
> +			old_reg =3D *reg;
> +			regno =3D bpf_diag_func_regno(state, reg);
> +			slot =3D bpf_diag_stack_arg_slot(state, reg);
>  			if (!stack || stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_SPILL)
>  				mark_reg_invalid(env, reg);
>  			else if (stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_DYNPTR)
>  				invalidate_dynptr(env, stack);
> +			if (regno >=3D 0)
> +				bpf_diag_record_reg_invalidate(vstate,
> +							       env->insn_idx,
> +							       regno,
> +							       BPF_DIAG_REG_MOD_REF_RELEASE,
> +							       &old_reg, reg);
> +			if (slot >=3D 0)
> +				bpf_diag_record_stack_arg(vstate, env->insn_idx,
> +							  state->frameno, slot,
> +							  BPF_DIAG_STACK_ARG_REF_RELEASE,
> +							  &old_reg, reg);

It appears mark_reg_invalid() in invalidate_non_owning_refs() is not covere=
d.
Maybe push these calls down to mark_reg_invalid() and add a few to it?

>  		}));
>  	}
> =20

[...]
