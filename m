Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F9C49550B
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549418; cv=none; b=gQZFUC9DTGv31UkbffGeMUFJpZrjYcwle7n7pkUkiFzAUlRB8eNulWhmBe0Ib7Wl7KdjvpmeYz0YGoQxxgj+SS1q4/ZsYRZwvqX2EhHyxYz1uNdh/GggKBBdM16r15CPKvJbyGJtdyokRst5sGbPqxuF78AglC4ZhmGq4GvQUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549418; c=relaxed/simple;
	bh=kGdIfPRgubGcaEAx3Q3dqZ5ZHMUUAv7LedldbnYi6nE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=E+ngSkKjv9ob/enhR8cIkUHOWQIfwtZBTzezwYrIO0ZaGjpOwBPbXpdhkFZztuxa69zKS08mI1lOqqrNzhi3cAhu0+HUaPfMmhFaHho8ziPpCQkKHzcEBtICdIr5ilbwSV8H1zBrRxjRGCEyPE2Za0ArxXeqlntKJ/I4G84Wzls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCgEvkQu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCgEvkQu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F251F0089B;
	Wed, 16 Sep 2026 09:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789549408;
	bh=Ce6gZoPzJiBTEvEWr2SfZSd2ZIBxUHnNZq1FJommxZs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eCgEvkQuBkBqNDGcIppxT+A16nzvYPghpYjpoT3n0C++4iRGecF9HQDLqat6HPSP1
	 ojnZ/PNgQT4+7xt8pQni+hre4FyJV/PMD+pl+nPwlD10LR9vmXDqZ8UtpgVAKa1j5I
	 9I0Nb5l2zA5wAWNUOCWkDd8ZSCwZYJOLZJqGcKZY4+Fv6/Ek/hvYIv/3i/r2otxxf0
	 c0Sw+yC2HV1GzWbP+cpfPyQiGl1BTTE4UGByZcHu3CaUjh2kyd9GOxivMe43W7f0ZW
	 I65Ihv74MZmBkrismkne4PJjLLRjU97rzc4EDoCBG0Keh6UjWz9v/D+IpeiOfA0af9
	 mAEc2UKeZmFxw==
Content-Type: multipart/mixed; boundary="===============3830223876571384478=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4f5e95167cdd0da82fb57b82890176275663e53f904e4987e4a6439eb681d2ad@mail.kernel.org>
In-Reply-To: <20260916074118.1007116-2-alan.maguire@oracle.com>
References: <20260916074118.1007116-2-alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 01/11] btf: Extend UAPI to support BTF location (inline site) info
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,jolsa@kernel.org
Cc: daniel@iogearbox.net,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,bpf@vger.kernel.org,nsc@kernel.org,puranjay@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 16 Sep 2026 09:03:27 +0000 (UTC)

--===============3830223876571384478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 618167cab4e61..a85d293f4127f 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
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

[ ... ]

> @@ -212,4 +214,65 @@ struct btf_enum64 {
>  	__u32	val_hi32;
>  };
>
> +/*
> + * BTF_KIND_LOC_PARAM is followed by a single "struct btf_loc_param"
> + * that contains flags specifying the contents of the vlen-specified
> + * number of 4-byte values that follow.
> + */
> +struct btf_loc_param {
> +	__u32 flags;
> +	__u32 values[];
> +};
> +
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
> + *   with vlen 2 it is a multi-register parameter.
> + * - a _REG | OFFSET describes an address without dereferencing it.
> + * - a _REG | DEREF with vlen 1 dereferences the value in the register
> + *   number specified.
> + * - a REG | DEREF | OFFSET with vlen specifies the register value in
> + *   the first 4-byte value and the offset in the remainder.

The REG | DEREF | OFFSET bullet is missing the vlen count after "with
vlen". Looking at the other bullets in this list, each states the exact
count ("with vlen 1", "with vlen 2").

Would it help to specify the count here? Since the description mentions
"the first 4-byte value and the offset in the remainder", it appears the
intended count is 2.

> + */
> +enum btf_loc_param_flags {
> +	BTF_LOC_PARAM_SIGNED		=	0x1,
> +	BTF_LOC_PARAM_CONST		=	0x2,
> +	BTF_LOC_PARAM_ADDR		=	0x4,
> +	BTF_LOC_PARAM_REG		=	0x8,
> +	BTF_LOC_PARAM_DEREF		=	0x10,
> +	BTF_LOC_PARAM_OFFSET		=	0x20,
> +};

[ ... ]

Looking at the unchanged struct btf_type definition in include/uapi/linux/btf.h
around line 57:

	__u32 info;
	/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64.
	 * "size" tells the size of the type it is describing.
	 *
	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
	 * FUNC, FUNC_PROTO, VAR, DECL_TAG and TYPE_TAG.
	 * "type" is a type_id referring to another type.
	 */
	union {
		__u32 size;
		__u32 type;
	};

Does the comment need updating for the new kinds? Looking at the
implementation in kernel/bpf/btf.c, btf_loc_param_check_meta() reads
t->size and validates it ("size = t->size; if (size > 16 ||
!is_power_of_2(size))"), so LOC_PARAM uses the size member.

For LOC_PROTO and LOCSEC, both btf_loc_proto_resolve() and
btf_locsec_resolve() require t->type == 0 ("if (t->type)... Invalid
loc_proto/locsec type").

Should the comment document which arm these new kinds use, the way it
already does for ENUM64, DECL_TAG, and TYPE_TAG?

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 7daf4c286c9b2..af5f161b5bddc 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -796,7 +815,9 @@ static bool btf_type_needs_resolve(const struct btf_type *t)
>  	       btf_type_is_var(t) ||
>  	       btf_type_is_func(t) ||
>  	       btf_type_is_decl_tag(t) ||
> -	       btf_type_is_datasec(t);
> +	       btf_type_is_datasec(t) ||
> +	       btf_type_is_loc_proto(t) ||
> +	       btf_type_is_locsec(t);
>  }

LOC_PROTO and LOCSEC are added to btf_type_needs_resolve() and
btf_type_nosize(), but I don't see them added to
btf_type_is_resolve_source_only() (kernel/bpf/btf.c:786-791).

DATASEC appears in both btf_type_needs_resolve and
btf_type_is_resolve_source_only. The two new section-like kinds follow
the same pattern as DATASEC (both are containers referencing other
types), so should they also be in btf_type_is_resolve_source_only?

Without this, a typedef or pointer to LOC_PROTO/LOCSEC would be handled
differently than a typedef or pointer to DATASEC.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35072175008
--===============3830223876571384478==--
