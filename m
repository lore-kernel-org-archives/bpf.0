Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6D847ECDF
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251925; cv=none; b=hIrJqv8EN/6173pC9z310n2Dnl9tfHGrFEexH8kRLcnwYRKu6xmsIgM16mf9zyAn1uGTf31xCeJJVY4HtJTs9gu5eQhr6TYD2FSNYqV7lbjG2tL2QizzH3nFHhufzNA/ug7fzBu4I6u++9suQEgfxNEPqfN2itv1dFdnRl7GY54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251925; c=relaxed/simple;
	bh=3zrxIeFHEnBh2NGN4tFW1e9xccrm2B6otucfLy9Uo8Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kjziARlh3nQahE2JXEHpeHisMpgnfbh8CbALTLfb1QDn1Dodw094BPfq3AQOFwqepswLjA6HGd/Iij1iKN95kkO4v+cz2e+kO0Ah+/rxHLfBcD91wjpwNqH/+eChdog+i01vs6yeTSAJU/tuxRu7cSbTJjJOr0bHtZvueJzDcW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njPKnelg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njPKnelg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443B81F00893;
	Thu, 24 Sep 2026 12:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790251923;
	bh=9RwzWEE2Xhiet83po+5ltyzynFNK3ltaauu2N15vID4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=njPKnelgqk0F3jXPpK8FAAsasdhvxXNR08pNpelYSntr3jbQlhnlO6SeXYSiHdr73
	 sm4mQCzB/EAf/BGtPxB/Rbu21lZHKJoGWqjx47Ya3ynutQxT7NosJTSZdPHHFXAMCo
	 JY6y0PdgdQ5SQFzINtibTrOjqvzvpdiEun/wopP2hsXZIXWbATzexGwsOUw3fjhvvo
	 +J36OS9g3i8hQnAi24kDYExNw/33lfOCBsiwlTaPY3xZ1pg2oR3EMeYsOUFbGDZuP7
	 EI+MG8QuHmFMWw9ApErHUhBEBNvwQP/9e9dXxzqccFZXYYdTjGitbh1QpAikpAWvJO
	 dOYdi6M4iiL0A==
Content-Type: multipart/mixed; boundary="===============1906308828920781715=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <75a4a976cc982fde75d65c3f0bff82d5852cc72ca0244a99982360e3c08d592c@mail.kernel.org>
In-Reply-To: <20260924111428.75957-2-alan.maguire@oracle.com>
References: <20260924111428.75957-2-alan.maguire@oracle.com>
Subject: Re: [PATCH v4 bpf-next 01/11] btf: Extend UAPI to support BTF location (inline site) info
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,qmo@kernel.org
Cc: jolsa@kernel.org,daniel@iogearbox.net,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,bpf@vger.kernel.org,nsc@kernel.org,puranjay@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 12:12:01 +0000 (UTC)

--===============1906308828920781715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index ddd0f4f32d24..f29ed358b7a8 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h

[ ... ]

> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 618167cab4e6..11d65871d163 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h

[ ... ]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 4a1fa4fbdf4e..5a0179cc1676 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> +static s32 btf_locsec_check_meta(struct btf_verifier_env *env,
> +				 const struct btf_type *t,
> +				 u32 meta_left)
> +{
> +	u32 i, meta_needed, vlen = btf_type_vlen(t);
> +	const struct btf_loc *loc;
> +
> +	meta_needed = sizeof(struct btf_loc) * vlen;
> +
> +	if (meta_left < meta_needed) {
> +		btf_verifier_log_basic(env, t,
> +				       "meta_left:%u meta_needed:%u",
> +				       meta_left, meta_needed);
> +		return -EINVAL;
> +	}
> +
> +	if (btf_type_kflag(t)) {
> +		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
> +		return -EINVAL;
> +	}
> +
> +	if (!t->name_off ||
> +	    !btf_name_valid_section(env->btf, t->name_off)) {
> +		btf_verifier_log_type(env, t, "Invalid name");
> +		return -EINVAL;
> +	}
> +
> +	for_each_loc(i, t, loc) {
> +		/* A loc func, loc proto cannot be in type void */
> +		if (!loc->func || !BTF_TYPE_ID_VALID(loc->func)) {
> +			btf_verifier_log_loc(env, t, loc, "Invalid func");
> +			return -EINVAL;
> +		}
> +		if (!loc->loc_proto || !BTF_TYPE_ID_VALID(loc->loc_proto)) {
> +			btf_verifier_log_loc(env, t, loc, "Invalid loc_proto");
> +			return -EINVAL;
> +		}
> +		btf_verifier_log_loc(env, t, loc, NULL);
> +	}
> +
> +	return meta_needed;
> +}

Does btf_locsec_check_meta() ever log the LOCSEC type itself?

Looking at btf_datasec_check_meta() which this code was modeled after,
it calls btf_verifier_log_type(env, t, NULL) just before the
for_each_vsi() loop to print the type header.

kernel/bpf/btf.c:btf_datasec_check_meta() {
    ...
    btf_verifier_log_type(env, t, NULL);

    for_each_vsi(i, t, vsi) {
        ...
        btf_verifier_log_vsi(env, t, vsi, NULL);
    }
}

The new btf_verifier_log_loc() helper is a copy of btf_verifier_log_vsi()
and only prints the type header when env->phase != CHECK_META:

kernel/bpf/btf.c:btf_verifier_log_loc() {
    ...
    if (env->phase != CHECK_META)
        btf_verifier_log_type(env, locsec_type, NULL);

    __btf_verifier_log(log, "\t func=%u loc_proto=%u offset=%u", ...);
}

So it relies on the caller to print "[id] LOCSEC <name> vlen=N" first.

Since btf_locsec_check_meta() runs during CHECK_META phase but never
calls btf_verifier_log_type(env, t, NULL) before for_each_loc(), the
verifier log would show bare "\t func=0 loc_proto=1 offset=0" lines
with no LOCSEC header and no [type_id]. This means the loaded BTF log
would be missing the LOCSEC type entry entirely, and any "Invalid func"
or "Invalid loc_proto" errors could not be tied to a type ID or section.

Should btf_verifier_log_type(env, t, NULL) be added before for_each_loc()
to match the datasec pattern?

[ ... ]

> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
> index 618167cab4e6..11d65871d163 100644
> --- a/tools/include/uapi/linux/btf.h
> +++ b/tools/include/uapi/linux/btf.h
> @@ -92,7 +92,9 @@ enum {
>  	BTF_KIND_DECL_TAG	= 17,	/* Decl Tag */
>  	BTF_KIND_TYPE_TAG	= 18,	/* Type Tag */
>  	BTF_KIND_ENUM64		= 19,	/* Enumeration up to 64-bit values */
> -
> +	BTF_KIND_LOC_PARAM	= 20,	/* Location parameter information */
> +	BTF_KIND_LOC_PROTO	= 21,	/* Location prototype for site */
> +	BTF_KIND_LOCSEC		= 22,	/* Location section */
>  	NR_BTF_KINDS,
>  	BTF_KIND_MAX		= NR_BTF_KINDS - 1,
>  };

Does raising BTF_KIND_MAX cause issues with bpftool in this commit?

tools/bpf/bpftool/btf.c declares btf_kind_str[NR_BTF_KINDS] but at this
commit only fills entries up to BTF_KIND_ENUM64. Its guard is:

tools/bpf/bpftool/btf.c:btf_kind_safe() {
    return kind <= BTF_KIND_MAX ? kind : BTF_KIND_UNKN;
}

Before this patch, kinds 20-22 were above BTF_KIND_MAX and printed as
"UNKNOWN". After it, btf_kind_safe() returns 20..22 unchanged, and
btf_kind_str[20..22] are NULL.

The in-tree libbpf can parse these kinds when the BTF has a kind layout
section, so `bpftool btf dump file <btf>` on such a blob reaches:

tools/bpf/bpftool/btf.c:dump_btf_type() {
    ...
    if (json_output) {
        jsonw_string_field(w, "kind", btf_kind_str[btf_kind_safe(kind)]);
    } else {
        printf("[%u] %s '%s'", id, btf_kind_str[btf_kind_safe(kind)], ...);
    }
}

With -j, jsonw_string_field() passes NULL to jsonw_string(), which
runs `for (; *str; ++str)` on NULL and segfaults. The plain output
passes NULL to %s, which is undefined behaviour.

This is fixed later in the series by commit 68746bde8eed
("bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC")
which adds the three strings to btf_kind_str[]. Would it be better to
add the btf_kind_str[] entries in the same commit as the header sync,
so the series stays bisectable?

[ ... ]

> +/*
> + * The combination of size, vlen and flags gives us the means to interpret
> + * the following vlen-specified set of 4-byte values:
> + *
> + * - a BTF_LOC_PARAM_CONST is a constant value; combination
> + *   of size, vlen and _SIGNED flag determines it. If the value requires
> + *   64 bits it is stored in {lo,hi} order.
> + * - a BTF_LOC_PARAM_ADDR|BTF_LOC_PARAM_CONST is an address that should be
> + *   normalized with respect to kernel/module base address.
> + * - a BTF_LOC_PARAM_REG with vlen 1 is a simple register number;
> + *   with vlen 2 it is a multi-register parameter.  Register numbers are
> + *   numbers derived from DW_OP_reg values, i.e. 0 is DW_OP_reg0; since
> + *   DW_OP_fbreg has its own special DW_OP_value and DW_OP_regx can refer
> + *   to an arbitrary register number, we reserve BTF_LOC_PARAM_FBREG for
> + *   the frame base register to avoid collisions.
> + * - a _REG | OFFSET describes an address without dereferencing it.
> + * - a _REG | DEREF with vlen 1 dereferences the value in the register
> + *   number specified.
> + * - a REG | DEREF | OFFSET with vlen > 1 specifies the register number
> + *   in the first 4-byte value and the offset in the remainder.
> + *   In the case of REG and OFFSET combinations, the OFFSET has the width
> + *   of the value words while the type size describes the represented parameter,
> + *   so for example a REG | DEREF | OFFSET with size 8 and vlen 2 would be
> + *   an 8-byte register dereference with signed 4-byte offset, since the vlen 2
> + *   values consist of a register value and the signed value.
                                                     ^^^^^^
> + */
> +enum btf_loc_param_flags {
> +	BTF_LOC_PARAM_SIGNED		=	0x1,
> +	BTF_LOC_PARAM_CONST		=	0x2,
> +	BTF_LOC_PARAM_ADDR		=	0x4,
> +	BTF_LOC_PARAM_REG		=	0x8,
> +	BTF_LOC_PARAM_DEREF		=	0x10,
> +	BTF_LOC_PARAM_OFFSET		=	0x20,
> +};

Does the example comment accurately describe when offsets are signed?

The comment says a REG | DEREF | OFFSET parameter (no
BTF_LOC_PARAM_SIGNED) has "a signed 4-byte offset". The only place it
mentions _SIGNED is for constants: "a BTF_LOC_PARAM_CONST is a constant
value; combination of size, vlen and _SIGNED flag determines it".

That contradicts how the rest of the series defines the encoding.
Documentation/bpf/btf.rst (at 64003e032e13) says "BTF_LOC_PARAM_SIGNED
makes a constant or offset signed ... For a register-relative offset,
its signed width is the number of offset value words times 32 bits".

bpftool's btf_loc_param_str() (at 68746bde8eed) applies sign handling
only `if (p->flags & BTF_LOC_PARAM_SIGNED)`.

The selftests expect flags=0x38 (REG|DEREF|OFFSET) to print
'*(reg2 + 0x10)' and use flags=0x39 (with SIGNED) for '*(fbreg - 0x20)'.

A producer written from this header would leave out BTF_LOC_PARAM_SIGNED
for negative frame-base offsets, which are the common case. Consumers
built with the series would then read -0x20 as +0xffffffe0 and compute
the wrong parameter address.

Should the example say the offset is signed only when
BTF_LOC_PARAM_SIGNED is set, and should the _SIGNED description cover
offsets as well as constants?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35993586374
--===============1906308828920781715==--
