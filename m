Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59A14BFE90
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992812; cv=none; b=hY961qsFuG/rMSy4vfv6IM2ECKtoa5oofSLagtSL7EFq2BXUqY9kt70fFApPR0123VWlJ/YnXtkJ4H2buhCgvMdKR8MmMWTLgyG5N3iOsRA1XyW1De/qsVCIL+dcx8ozTVVJT7nKUxqndzeHH4M/JvELVEkt6O5FXu8SMwVsw10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992812; c=relaxed/simple;
	bh=CMc3Vsr7iweLoRN9H3y84ZJWlLhrHj7i+Kvx2VN2Uog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bbSNtgbsmvHm33qnlOCmVl4ffshaMLnL0aOXyr53w8+6cvUKNDouFeGQqTzCO7V3AsDj6B9oZ7Dn11Mz3KxCgl3008kBZcWi51DjF9MvdZ80qVT9L3SzDRlENq/30Icu9D07QWm7N97XpiPsdYze9hoVda4vJeTtOe2FO90TTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHan+4uS; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHan+4uS"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc439bfb2d8so4247770a12.2
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788992809; x=1789597609; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GJIj44arWcgfsXqCTf5jusWng1C5DNidnSVlW5EdX58=;
        b=PHan+4uSrRW9YGfK+NT2JBQ3Ekb+7WQlQjyUzSJ7YladZ0+ws3P9bhcE2iBMlH7Tme
         TUptviXTK9wXY9BfVd+tuvyWa+lZz3VMJbFYlbk58GZZXy1Ooq3OCuUGhItzAYzaqtQR
         gyXJLP3KaZf1ZYA03eEM+yisRAO/3sLlJgNrEE6+nDRwGyZ2OYUrnMVzGxYNLlTfHqxm
         c0QX/RA/I9g/pPj2nTea4Dp3l7ZJap6kw7mfGrpSVEuKku4W+0YPc8+J4hs1jwTWSk6N
         bxfc0k3Z/y8FiZL8hhGGZ91L+RsxG8nVc6ngsPVMS2hiG1jAR9smA/brARUX7YD6JfhT
         wS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992809; x=1789597609;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJIj44arWcgfsXqCTf5jusWng1C5DNidnSVlW5EdX58=;
        b=IS7LdsM/8mAehfnmVWCXj3seiGtp0oAbVLE/uOVCmJLWYfIxb4UZsKKRa9M9a0/c2B
         ECSBrcjoE91AoibWHgBTzXhzyk9cFuYEu53ckiNluEDAQrV30HJuo5D0Cromdf6BFNPu
         JCHKLLA4Z4fyleFT8FiZwKMGvUIadKEBVjYWb3IFI98pfQuowVXi1DvR76Vwq1FDeR0g
         aB4fnoVLClvU7cth4Pw5JTfzPG/Mlkn748kaDty9mXBVcedb2VfioClfSPflxKgH6WWB
         cJFcS68BYewIHEselOrn0NlptPMVblB0Fl8RfCLJWxsG2V/SgJs+CJHBSB930cLSXW7E
         x5oA==
X-Forwarded-Encrypted: i=1; AKwUvBzauEg+qttG4PnZhlH9zJqjON9ImXQQM0M+OQgPSBqOoDqsRsJkirFrUmhkEIKJtZ/4bkk=@vger.kernel.org
X-Gm-Message-State: AFuF++lXrfmsUA2LCJuaQuV3pbzxB3qCZT0WLGIia+H/WyXaZx83fTQi
	Bgz74YPRJxTU2PVZvbVpG9bRPwc/HBP9T4tfmCxhLTvmA4Cz6dT3ENfa
X-Gm-Gg: AYBFou2KDj+epznp348109RIkbVGfXWlty0hrPm9wVJUSlQSg2qTP895VEw02PYHSiv
	Xf4dY5CG3iTG4SmSD0E26W/lCnqsiUE7BQbHiRb3pMKKzLtT0a7RB0EyxFBn0Ruat8xoFoeTnqp
	uwtjTBhV76CZz61P5+Ei3FrtPmU7g+76n0NqGQlFykLI8gGlx8S+T/T816ytFMXRwvIlBEZFF7O
	msk3iHup/cxt7ad+NzlXX7XS9zDxBrwTXFui5srILu/yXf6+arfWWBqKj2x2WF5byY6glkx8tag
	IVVGw5+DS/hnCka6g0BGwIzpBV9CIehlmVv4QX2YwLijVhx4SjTZS+IJZVpcf8/KWEuSbI//Gev
	xKhRlhG1pAE+/NchQs7T776pwnGC+4QnQXfRJFiDBd+cNUTIEbI0Tgaa+5TweLdDB/0kzLHlicQ
	5pHS0mBKF2t5HTycrnDFyRwCxqVC2qZrGf47AcLpGFjrvgfoinD7eMmremNlAiTmSoQ34FI8f5r
	+TCsN+r9OQ7J9bpLuojAv3AqPI=
X-Received: by 2002:a17:90b:1643:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-39b26272f04mr54383045a91.14.1788992808747;
        Wed, 09 Sep 2026 15:26:48 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d77608fb4sm1613529a91.15.2026.09.09.15.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:26:48 -0700 (PDT)
Message-ID: <791206dfa4759027377273185e3940156dc9b976.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/18] btf: Extend UAPI to support BTF
 location (inline site) info
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, jolsa@kernel.org, ihor.solodrai@linux.dev, 
	yonghong.song@linux.dev, song@kernel.org, qmo@kernel.org,
 martin.lau@linux.dev, 	memxor@gmail.com, emil@etsalapatis.com,
 mcgrof@kernel.org, petr.pavlu@suse.com, 	tj@kernel.org, kees@kernel.org,
 bpf@vger.kernel.org, nathan@kernel.org, 	nsc@kernel.org, arnd@arndb.de,
 puranjay@kernel.org, yatsenko@meta.com, 	atenart@kernel.org,
 ojeda@kernel.org, linux-modules@vger.kernel.org
Date: Wed, 09 Sep 2026 15:26:45 -0700
In-Reply-To: <20260901165757.801449-2-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
		 <20260901165757.801449-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-01 at 17:57 +0100, Alan Maguire wrote:
> Add BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO and BTF_KIND_LOCSEC
> to help represent location information for functions.
>=20
> BTF_KIND_LOC_PARAM is used to represent how we retrieve data at a
> location; either via register(s), or register+offset, a dereference
> of a register+offset or a constant value.
>=20
> BTF_KIND_LOC_PROTO represents location information about a location
> with multiple BTF_KIND_LOC_PARAMs.
>=20
> And finally BTF_KIND_LOCSEC is a set of location sites, each
> of which has
>=20
> - a BTF_KIND_FUNC function associated with the inline site
> - a location prototype specifying where to find the function
> =C2=A0 parameters
> - an address offset relative to the kernel base address
>=20
> This can be used to support representing
>=20
> - a fully-inlined function at potentially multiple inline sites
> =C2=A0 with potentially different parameter availability
> - a partially-inlined function where some _LOC_PROTOs represent
> =C2=A0 inlined sites as above and others have normal _FUNC representation=
s
>=20
> Also BTF_KIND_LOCSEC struct btf_loc will have two type id
> references; one for the associated func, the other for the loc_proto.
> Accordingly increase the number of m_offs references in btf_field_desc
> to 2.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index ddd0f4f32d24..a4412bc16688 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h

...

> +static inline struct btf_loc_param *btf_loc_param(const struct btf_type =
*t)
> +static inline __u32 *btf_loc_params(const struct btf_type *t)

Maybe rename the latter to btf_loc_proto_params?

...

> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 618167cab4e6..6062c9958034 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h

...

> @@ -212,4 +214,65 @@ struct btf_enum64 {
> =C2=A0	__u32	val_hi32;
> =C2=A0};
> =C2=A0
> +/*
> + * BTF_KIND_LOC_PARAM is followed by a single "struct btf_loc_param"
> + * that contains flags specifying the contents of the vlen-specified
> + * number of 4-byte values that follow.
> + */
> +struct btf_loc_param {
> +	__u32 flags;

Wdyt about adding a flexible array member here?

	__u32 params[];

Would make btf_loc_param_log() a little bit easier to follow.

> +};
> +
> +/*
> + * The combination of size, vlen and flags gives us the means to interpr=
et
> + * the following vlen-specified set of 4-byte values:
> + *
> + * - a BTF_LOC_PARAM_CONST is a constant value; combination
> + *=C2=A0=C2=A0 of size, vlen and _SIGNED flag determines it. If the valu=
e requires
> + *=C2=A0=C2=A0 64 bits it is stored in {lo,hi} order.
> + * - a BTF_LOC_PARAM_ADDR is an address that will be normalized with
> + *=C2=A0=C2=A0 respect to kernel base address.

Nit: pahole generates ADDR | CONST.

> + * - a BTF_LOC_PARAM_REG with vlen 1 is a simple register number;
> + *=C2=A0=C2=A0 with vlen 2 it is a multi-register parameter.

Nit: REG | OFFSET is not discussed.

> + * - a _REG | DEREF with vlen 1 dereferences the value in the register
> + *=C2=A0=C2=A0 number specified.
> + * - a REG | DEREF | OFFSET with vlen specifies the register value in
> + *=C2=A0=C2=A0 the first 4-byte value and the offset in the remainder.

--- >8 ---

> + * - binary logical operators operate on a combination of register
> + *=C2=A0=C2=A0 number and constant value, aside from _NOT which operates=
 on
> + *=C2=A0=C2=A0 a register

--- 8< ---

This is probably a leftover.

> + */
> +enum btf_loc_param_flags {
> +	BTF_LOC_PARAM_SIGNED		=3D	0x1,
> +	BTF_LOC_PARAM_CONST		=3D	0x2,
> +	BTF_LOC_PARAM_ADDR		=3D	0x4,
> +	BTF_LOC_PARAM_REG		=3D	0x8,
> +	BTF_LOC_PARAM_DEREF		=3D	0x10,
> +	BTF_LOC_PARAM_OFFSET		=3D	0x20,
> +};
> +
> +/*
> + * BTF_KIND_LOC_PROTO specifies location prototypes; i.e. how locations =
relate
> + * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed by=
 a
> + * a vlen-specified number of __u32 BTF type ids which specify the assoc=
iated
> + * BTF_KIND_LOC_PARAM for each function parameter associated with the
> + * location.=C2=A0 The type should either be 0 (no location info) or poi=
nt at
> + * a BTF_KIND_LOC_PARAM.
> + */
> +
> +/*
> + * BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_loc"
> + * containing location site-specific information;
> + *
> + * - function (func)
> + * - location prototype type id (loc_proto)
> + * - address offset (offset) relative to kernel base address

pahole uses loc->section_offset to create LOCSEC entries,
which corresponds to an offset within an ELF containing
the function section. Would it make sense to rephrase the
above comment a bit?

> + */
> +
> +struct btf_loc {
> +	__u32 func;
> +	__u32 loc_proto;
> +	__u32 offset;
> +};
> +
> =C2=A0#endif /* _UAPI__LINUX_BTF_H__ */

...


