Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3541F35C
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625534; cv=none; b=ldaKI95GwYhq2Ct3rlcZyKnXbLqaCyLSUARiEwrQFQHZ+LYapns7UTB8n4NmDKtTZUozlDqOhKDVxQwh7uDKPHN/gA6w9hhP0xqrjx1bR5lx77mM3NZW7zIbV/fpHjI6JM6hlKObzqV0beb0v//i8lLdxmxaheusCyARWY/KjDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625534; c=relaxed/simple;
	bh=qKKdtZbJUZxt2rWeOPP1TwpBUKgfAVltCBdxHypVVtg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QeLioL8lGpDyaFlj3WwqtSiQyoYaLK2vF2hVxOgBCCWsSQcg9w4RNDOAxNS2KD5ZI5O9Rqu721DI5jH3Soi87ibxIsnchTpIEvkNOKzESzUhzlfVyIM8wxvN2M3cnuA3WX/CAKMM3POGkZwf8uePZl0OqGoQFYOjQV/L7CfPgiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2B5PCAY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2B5PCAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515111F000FF;
	Thu, 17 Sep 2026 06:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789625532;
	bh=1rK2w3xtTKiFRH2TLHOB5AgQq7tL8mcbPaxWQlzLorE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h2B5PCAYm+2R9R6CXOlV1R7z/CJfo4Bbvs5WxlPvSozSDvfRKVIQTvsnCJr1pIVQg
	 ZwQFf2pAKAVdL+i2uRbPHMC1pa17n5FjBoKWfjOtR3VWop07JCt7/wqhBQjDjlKRpc
	 lIZkMytedrnNL5TvhulRw/mab0s76JjmkIzxCQuph7Cf1pMAdN19Lap+jg/cZfHVoH
	 rg77I9Zir1jIigCZ2i9A4Di+dzCEfZyl/uu0tqTgxqyzzioYk8lSznQBI323kLqLGp
	 L4OyPebSI5nEp8nUDJHc3hq/tOJQ1kD/3Bb5gjNMtkOLlFWhdIyNc8+/xkGpqaEFwP
	 JBjxiKmtdOWUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 15/20] libbpf: Collect .bpf_cleanup records and
 pass them to the kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917055802.3933672-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
 <20260917055802.3933672-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:12:11 +0000
Message-Id: <20260917061212.515111F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: undefined behavior when calling qsort with a NULL pointer
- [Low] bpf: array bounds violation via type-punned pointer arithmetic
--

commit 1e591245d7ec663b872eae44c8fa7f02cfd956a4
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Collect .bpf_cleanup records and pass them to the kernel

This commit parses the compiler-emitted .bpf_cleanup section and hands
the resulting table to BPF_PROG_LOAD so the kernel can resolve exceptions.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ea1c09fa37939..d7cb93a70f58d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -4847,6 +4885,214 @@ static struct bpf_program *find_prog_by_sec_insn(=
const struct bpf_object *obj,

[ ... ]

> +static int bpf_prog_collect_cleanup_info(struct bpf_object *obj,
> +					 struct bpf_program *prog)
> +{
> +	size_t i;
> +	int j;
> +
> +	for (i =3D 0; i < obj->cleanup_rec_cnt; i++) {
> +		struct cleanup_raw_rec *raw =3D &obj->cleanup_recs[i];
> +		struct bpf_program *owner =3D NULL;
> +		struct bpf_cleanup_info ci =3D {};
> +		__u32 *fields =3D (__u32 *)&ci;
> +		void *tmp;
> +
> +		for (j =3D 0; j < CLEANUP_REC_FIELDS; j++) {
> +			size_t idx =3D raw->insn_idx[j], final;
> +			struct bpf_program *p;

[ ... ]

> +			if (owner =3D=3D prog) {
> +				final =3D raw->insn_idx[j] - prog->sec_insn_off;
> +			} else if (prog_is_subprog(obj, owner) && owner->sub_insn_off) {
> +				/* sub_insn_off is where this subprogram was
> +				 * appended to the main program being relocated;
> +				 * zero means it is not part of it.
> +				 */
> +				final =3D owner->sub_insn_off +
> +					raw->insn_idx[j] - owner->sec_insn_off;
> +			} else {
> +				owner =3D NULL;
> +				break;
> +			}
> +			fields[j] =3D final;

[Severity: Low]
Is it safe to cast a pointer to a struct field into an array pointer and ac=
cess
subsequent members via pointer arithmetic in this loop?

The struct bpf_cleanup_info fields are populated by casting a pointer to the
struct to a __u32 * array and indexing into it in a loop.

According to C11 6.5.6, pointer arithmetic on a pointer to a scalar (the fi=
rst
struct field) only allows accessing up to one element past it, making field=
s[1]
and fields[2] undefined behavior.=20

This can trigger compiler warnings (-Warray-bounds) and potentially cause
aggressive optimizers to generate incorrect code.

> +		}
> +		if (!owner)
> +			continue;
> +
> +		tmp =3D libbpf_reallocarray(prog->cleanup_info, prog->cleanup_info_cnt=
 + 1,
> +					  sizeof(*prog->cleanup_info));
> +		if (!tmp)
> +			return -ENOMEM;
> +		prog->cleanup_info =3D tmp;
> +		prog->cleanup_info_rec_size =3D sizeof(struct bpf_cleanup_info);
> +		prog->cleanup_info[prog->cleanup_info_cnt++] =3D ci;
> +
> +		pr_debug("prog '%s': cleanup region [%u,%u) -> landing pad %u\n",
> +			 prog->name, ci.begin_off, ci.end_off, ci.landing_pad_off);
> +	}
> +
> +	qsort(prog->cleanup_info, prog->cleanup_info_cnt,
> +	      sizeof(*prog->cleanup_info), cmp_cleanup_info);

[Severity: Medium]
Can this unconditionally call qsort() with a NULL base pointer?

If obj->cleanup_rec_cnt is 0, or if none of the records match the program,
prog->cleanup_info_cnt remains 0 and prog->cleanup_info will be NULL.=20

Calling qsort() with a NULL pointer invokes undefined behavior under C11 7.=
1.4,
even if the element count is 0. This triggers UBSAN errors (nonnull attribu=
te
violation in libc headers) and can fail runtime checks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917055645.3926=
444-1-yonghong.song@linux.dev?part=3D15
