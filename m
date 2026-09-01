Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AAA48EBF1;
	Tue,  1 Sep 2026 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285353; cv=none; b=RHGEkjSXbjpUjBdf5W6mzz5mKHkSfDhQI+/0STJuEpMCtm0JyLy65N7PLERm/1rlhJuS6ieG18aOgy+7ZXKt04V1wCJ46axZeDf2cVxpf9pWBjplVS+MqI8giUSDLZfhs90ho4DePzh40L1PBBOx9o8YxneHVe+DIOKtBHrOnU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285353; c=relaxed/simple;
	bh=EDz70nD0Qshxj1kwNiDaCZ9r8e+FhcrKLk4Dovzh48w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dM5RHiZMyH7OTAoZuW9MNpofjR741bdooVxGyjTgwTVf61Vw4CQQmn0fJcCVqUp+xm8mvM4m3z+4msPk5uPie4NhPrmWyZuOdF1gnikrn+SQPdUwQyhKB14NzOIlUYeOYfToFbe3J/cNJ4ogGZw4+FhZSQyWNQpOfURfnUafD4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvi92i9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvi92i9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C930C1F00A3A;
	Tue,  1 Sep 2026 17:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788285352;
	bh=Qbo9xnFHa5xWJc3QM00uTi90JSoIFD7Q+LFx2CgWL9A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kvi92i9NqBaDMSte2mDZBrVD2N+B41Ntw3S/BomMvi12GO/wASf7ksNEN8Yhdid1t
	 EGBa/La3JX4vGVNbYMZoqg5Q3o7VLlaKawfzzGANpPIyttalG4waYo3QM7d2ym2yqh
	 gQ1x/2v4EGH5vx+i7GqHpbQmah4ReGHEVAjex//bsmyqtQC+wCOku3w/6vsZyWxAf5
	 yC02BZ2ROkqrab4ofujoJF6SgORh+IoS5cScpdswiBL2rT1HQrZnIPpKTuxgzcg4+F
	 U6kiTbbsAEZD3yOMG9wOJkXAsDRr5O+a4P4dI/Hgu8YZS6F170qS2mraocgpY1JL5Q
	 Mb3v0WWNaZUag==
Content-Type: multipart/mixed; boundary="===============8310105665022421972=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <af8e4dfcad947bcf2b4cb4022503de3440343726bbb225289cfadcde54859f9c@mail.kernel.org>
In-Reply-To: <20260901165757.801449-2-alan.maguire@oracle.com>
References: <20260901165757.801449-2-alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 01/18] btf: Extend UAPI to support BTF location (inline site) info
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,eddyz87@gmail.com,jolsa@kernel.org,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,mcgrof@kernel.org,petr.pavlu@suse.com,tj@kernel.org,kees@kernel.org,bpf@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,arnd@arndb.de,puranjay@kernel.org,yatsenko@meta.com,atenart@kernel.org,ojeda@kernel.org,linux-modules@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 17:55:50 +0000 (UTC)

--===============8310105665022421972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index ddd0f4f32d24..a4412bc16688 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -559,7 +574,7 @@ struct btf_field_desc {
>  	/* member struct size, or zero, if no members */
>  	int m_sz;
>  	/* repeated per-member offsets */
> -	int m_off_cnt, m_offs[1];
> +	int m_off_cnt, m_offs[2];
>  };

Eduard Zingerman noted in the RFC v1 review that this change to m_offs[2]
should be moved to patch #2, since that patch's commit message explains
why it is needed. The change was acknowledged but not addressed in v2.

See: https://lore.kernel.org/bpf/531305ee76a5ef186b1204dc8281ebc7ebb2b1c0.camel@gmail.com/

> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 618167cab4e6..6062c9958034 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h

[ ... ]

> +/*
> + * The combination of size, vlen and flags gives us the means to interpret
> + * the following vlen-specified set of 4-byte values:
> + *
> + * - a BTF_LOC_PARAM_CONST is a constant value; combination
> + *   of size, vlen and _SIGNED flag determines it. If the value requires
> + *   64 bits it is stored in {lo,hi} order.
> + * - a BTF_LOC_PARAM_ADDR is an address that will be normalized with
> + *   respect to kernel base address.
> + * - a BTF_LOC_PARAM_REG with vlen 1 is a simple register number;
> + *   with vlen 2 it is a multi-register parameter.
> + * - a _REG | DEREF with vlen 1 dereferences the value in the register
> + *   number specified.
> + * - a REG | DEREF | OFFSET with vlen specifies the register value in
> + *   the first 4-byte value and the offset in the remainder.
> + * - binary logical operators operate on a combination of register
> + *   number and constant value, aside from _NOT which operates on
> + *   a register
> + */
> +enum btf_loc_param_flags {
> +	BTF_LOC_PARAM_SIGNED		=	0x1,
> +	BTF_LOC_PARAM_CONST		=	0x2,
> +	BTF_LOC_PARAM_ADDR		=	0x4,
> +	BTF_LOC_PARAM_REG		=	0x8,
> +	BTF_LOC_PARAM_DEREF		=	0x10,
> +	BTF_LOC_PARAM_OFFSET		=	0x20,
> +};

Does the comment above the enum match the actual flags? The text mentions
"binary logical operators" and "_NOT which operates on a register," but
the enum defines only SIGNED, CONST, ADDR, REG, DEREF and OFFSET. Where
is BTF_LOC_PARAM_NOT and where are the logical operator flags?

This same mismatch appears in tools/include/uapi/linux/btf.h as well.

> +/*
> + * BTF_KIND_LOC_PROTO specifies location prototypes; i.e. how locations relate
> + * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed by a
> + * a vlen-specified number of __u32 BTF type ids which specify the associated
> + * BTF_KIND_LOC_PARAM for each function parameter associated with the
> + * location.  The type should either be 0 (no location info) or point at
> + * a BTF_KIND_LOC_PARAM.
> + */

This isn't a bug, but there's a duplicated word: "followed by a / a
vlen-specified number". The same duplication appears in the tools copy at
tools/include/uapi/linux/btf.h.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9c2cab08bb79..d74c8668aa3f 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> +static s32 btf_loc_param_check_meta(struct btf_verifier_env *env,
> +				    const struct btf_type *t,
> +				    u32 meta_left)
> +{
> +	const struct btf_loc_param *p = btf_loc_param(t);
> +	u32 meta_needed;
> +	u32 size;
> +
> +	meta_needed = sizeof(*p) + sizeof(__u32) * btf_vlen(t);
> +	if (meta_left < meta_needed) {
> +		btf_verifier_log_basic(env, t,
> +				       "meta_left:%u meta_needed:%u",
> +				      meta_left, meta_needed);
> +		return -EINVAL;
> +	}
> +
> +	if (t->name_off) {
> +		btf_verifier_log_type(env, t, "Invalid name");
> +		return -EINVAL;
> +	}
> +	size = t->size;
> +	if (size > 16 || !is_power_of_2(size)) {
> +		btf_verifier_log_type(env, t, "Unexpected size");
> +		return -EINVAL;
> +	}
> +
> +	return meta_needed;
> +}

Does this handler miss the trailing btf_verifier_log_type(env, t, NULL)
call before returning successfully? Looking at __btf_verifier_log_type()
in this file, the comment states: "btf verifier prints all types it is
processing via btf_verifier_log_type(..., fmt = NULL)". Every other
check_meta handler in kernel/bpf/btf.c ends with that call on the
success path (int, ptr, array, struct, enum, enum64, fwd, typedef,
func_proto, func, var, datasec, decl_tag, float), but
btf_loc_param_check_meta, btf_loc_proto_check_meta, and
btf_locsec_check_meta all return successfully without it.

When userspace passes a log buffer to BPF_BTF_LOAD, wouldn't the per-type
"[id] KIND name ..." trace skip every LOC_PARAM/LOC_PROTO/LOCSEC type,
creating gaps in the [id] sequence? Since env->log_type_id advances
inside btf_verifier_log_type() and not on the successful path here, could
later error messages for subsequent types be attributed to the wrong id?

> +static void btf_locsec_log(struct btf_verifier_env *env,
> +			   const struct btf_type *t)
> +{
> +	const struct btf_loc *loc = btf_type_loc_secinfo(t);
> +	u32 nr_locs = btf_type_vlen(t), i;
> +	const struct btf *btf = env->btf;
> +
> +	btf_verifier_log(env, "locsec %s locs=(",
> +			 __btf_name_by_offset(btf, t->name_off));
> +	for (i = 0; i < nr_locs; i++, loc++) {
> +		btf_verifier_log(env, "\n\tfunc %u loc_proto %u offset 0x%x%s",
> +				 loc->func, loc->loc_proto, loc->offset,
> +				 i + 1 == nr_locs ? ")" : ", ");
> +	}
> +}

A subsystem pattern flags this as potentially concerning: the log_details
callback re-prints the kind and name that __btf_verifier_log_type() has
already emitted, so the output would read "[7] LOCSEC name locsec name
locs=(...)". Every other log_details handler (btf_datasec_log,
btf_struct_log, etc.) prints only the kind-specific tail.

Also, if vlen is zero, does the loop body that would print the closing
parenthesis ever run? A zero-vlen LOCSEC would pass check_meta and leave
a dangling "(" in the log. The same pattern appears in btf_loc_proto_log
and btf_loc_param_log.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33537080133
--===============8310105665022421972==--
