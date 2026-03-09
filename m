Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1044346FDB
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080572; cv=none; b=NxDX4Smu6BgR0B5qKx99AtvlPMI3Zs+pKuSlp2x7N8PDstvlSdPZQcQKFhThw/j0gabPYnp7C0FnAqJgrGCP8PSyKYJ9cncEpmGTzwPGCwpP22QVvftUgdcAPtnMpzIzAr7j/iPPK2KlgwugQafh4EfyPYsFMFPZvacbiq+CQ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080572; c=relaxed/simple;
	bh=xtZh6X5BqW24DGxggwr4iluMOopD0PAj33zPmaSI1kU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ku7QQFKJsLLlnXjQ7EAbN5n1Nbi5+9wI2lWDdDiXl5rdA0RopF92di6YapCnrtDOBPtTNzbPEvv7CNfZpaAcEaHnZg/yB2v1jItn3H1J6ub91JxXHKRM0Tdf8jjMIcbXlGlYdg6NM0rC2noYcUNl+i86U7yIRxPlh3tZG7gB66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXilAz0w; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXilAz0w"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852f73d0a3so19004735e9.3
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773080568; x=1773685368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gR8a84+24YkPR3dczxCEAOyEBBkVahn4zcX8hC44WAk=;
        b=jXilAz0wNsMwUZEiF10mSFoiTZx2aNfLmctcG9wWZWqFZ+hc86RkdN/vUjV/FnQX0M
         PMfi3M7EVDh/yuzir6ZSr7E41j33+6Ja2cpMIdAVBQozAbDcnjEf66pN8msKYdXY5BYy
         Ul/hYqNRYq35oFO65/9X3nltUFT5tOsgSHW3YTgnBfr3L8vPmZ+KtUco574qpnVUBOD4
         kIzLhErhsaQ71pbx4ugWMFP3tJL+hyjBcFILKQdML6DHDbneXPTmW5dog66pdHxJyZ5P
         HXIzwbXvZv6+jEK2Z3OeXCTChUejwUCTnVEUwH6bIlX5dmoawY51kAwSp9zhCMeT2R2r
         lvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773080568; x=1773685368;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gR8a84+24YkPR3dczxCEAOyEBBkVahn4zcX8hC44WAk=;
        b=LsJeaNx8W4EAd0KsFQ8gS8lvQArsdBOe1asiz2a2MhPPuSJ5FJgIvV7LAIA0w7N/az
         DHpimOOE6Cl75VL7Sk1zcO75xRw8TezaO6ElIhBIyg6RpGb+0ERI5Ix6Cb1Fo7rgVj7T
         cTOw64Rv8R8f88UbMBkJvjpUqF2I9TJB9ICf15tJ7dM2MuYj67Is1ZodWKbBBlJ/KYzL
         3uYgVZK6pRPQRuc92PctEv/N4+O0rV4EIFTp0O7I+HZm6AmBcpmPX+9X/LS2kYppRBI0
         vKYwJzQ98lsbfSAOt6u996XCIIENUrZVykX0zfWZ+BjCBgAp4vOBmpN9SjF37Si1zRM5
         OTlA==
X-Forwarded-Encrypted: i=1; AJvYcCWKRfnpv81oDMuEslRGoCu8erXedg9vGo2+TYdZppcVZ6Hz1LdnH+0xGdPdgeCi8DeWi9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzkn+rHGyoyoZPSlo5VcTolp9vO0LE9X6j7ZDL1WHJle7s1n6p
	TTd1dHm0XbCmhob1CduodxzYSU+gsp3rAB3cDQhntbhE2EgGtoTnIxcN
X-Gm-Gg: ATEYQzx2LSGIJUwSkbjwDl+cA1bZ7+BGkmZxQ+E98KMO0YsJjO0MyFVF+5Ei4H29kVh
	1Xc/R3o6gT3RaBeHVa2XgMUrfw3Lz665KRlFlnBvU4yxHFdg2s+40D/Tp1l+vFmS4WeDIiKT9zW
	xWwwoxhlijFWfsdHcS0fRhDyjEwf0oixCQJB3+fcfRgcM31ffmBWnnyKwu9tpYkV9BwviAfPWph
	+NoUckC0yd9ZM3nrwkee6E0Y4pB8QQDHSXEBq6o2fqhPN9thv46qp08/INx0FL8mDbD8Mg3U3z5
	o/gV+6YE9UUl9oqhge19EpPlGUgTWguEOMOBvCJVj1TdmRLMeFGNAjCDFTl9ki45jz2D4xp/77v
	XizMuBe59kEIJAKzHBjUozoSNJQhdsUEiG5iZo4US0O9kGqcy1dG6s+bn9cKwSOjBURS4kKVmRi
	pxPSQXbDXMeXIGU7m/4Q==
X-Received: by 2002:a05:600c:4f07:b0:485:3171:7845 with SMTP id 5b1f17b1804b1-48531717a94mr135970605e9.4.1773080567914;
        Mon, 09 Mar 2026 11:22:47 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:f6fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a7f182sm12891385e9.5.2026.03.09.11.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 11:22:47 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Jenny Guanni Qu <qguanni@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org, lkp@intel.com,
 Jenny Guanni Qu <qguanni@gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: Fix undefined behavior in interpreter
 sdiv/smod for INT_MIN
In-Reply-To: <20260306190855.937198-2-qguanni@gmail.com>
References: <20260306190855.937198-1-qguanni@gmail.com>
 <20260306190855.937198-2-qguanni@gmail.com>
Date: Mon, 09 Mar 2026 18:22:46 +0000
Message-ID: <87cy1cn9qh.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jenny Guanni Qu <qguanni@gmail.com> writes:

> The BPF interpreter's signed 32-bit division and modulo handlers use
> the kernel abs() macro on s32 operands. The abs() macro documentation
> (include/linux/math.h) explicitly states the result is undefined when
> the input is the type minimum. When DST contains S32_MIN (0x80000000),
> abs((s32)DST) triggers undefined behavior and returns S32_MIN unchanged
> on arm64/x86. This value is then sign-extended to u64 as
> 0xFFFFFFFF80000000, causing do_div() to compute the wrong result.
>
> The verifier's abstract interpretation (scalar32_min_max_sdiv) computes
> the mathematically correct result for range tracking, creating a
> verifier/interpreter mismatch that can be exploited for out-of-bounds
> map value access.
>
> Introduce __safe_abs32() which handles S32_MIN correctly and replace
> all 8 abs((s32)...) call sites in the interpreter's sdiv32/smod32
> handlers.
>
> Fixes: ec0e2da95f72 ("bpf: Support new signed div/mod instructions.")
> Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> ---
>  kernel/bpf/core.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 3ece2da55625..663b9af6d19b 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -16,7 +16,6 @@
>   * Andi Kleen - Fix a few bad bugs and races.
>   * Kris Katterjohn - Added many additional checks in bpf_check_classic()
>   */
> -
>  #include <uapi/linux/btf.h>
>  #include <crypto/sha1.h>
>  #include <linux/filter.h>
> @@ -1736,6 +1735,12 @@ bool bpf_opcode_in_insntable(u8 code)
>  }
>=20=20
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> +/* Safe absolute value for s32 - abs() is undefined for S32_MIN */
> +static inline u32 __safe_abs32(s32 x)
> +{
> +	return x >=3D 0 ? (u32)x : x =3D=3D S32_MIN ? (u32)S32_MIN : (u32)-x;
can we write it as x >=3D 0 ? (u32)x : -(u32)x; ?
By casting to u32 first, the negation operates in unsigned arithmetic
where overflow does not happen =E2=80=94 it wraps.
Please correct me if I'm wrong.
> +}
> +
>  /**
>   *	___bpf_prog_run - run eBPF program on a given context
>   *	@regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
> @@ -1900,8 +1905,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct =
bpf_insn *insn)
>  			DST =3D do_div(AX, (u32) SRC);
>  			break;
>  		case 1:
> -			AX =3D abs((s32)DST);
> -			AX =3D do_div(AX, abs((s32)SRC));
> +			AX =3D __safe_abs32((s32)DST);
> +			AX =3D do_div(AX, __safe_abs32((s32)SRC));
>  			if ((s32)DST < 0)
>  				DST =3D (u32)-AX;
>  			else
> @@ -1928,8 +1933,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct =
bpf_insn *insn)
>  			DST =3D do_div(AX, (u32) IMM);
>  			break;
>  		case 1:
> -			AX =3D abs((s32)DST);
> -			AX =3D do_div(AX, abs((s32)IMM));
> +			AX =3D __safe_abs32((s32)DST);
> +			AX =3D do_div(AX, __safe_abs32((s32)IMM));
>  			if ((s32)DST < 0)
>  				DST =3D (u32)-AX;
>  			else
> @@ -1955,8 +1960,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct =
bpf_insn *insn)
>  			DST =3D (u32) AX;
>  			break;
>  		case 1:
> -			AX =3D abs((s32)DST);
> -			do_div(AX, abs((s32)SRC));
> +			AX =3D __safe_abs32((s32)DST);
> +			do_div(AX, __safe_abs32((s32)SRC));
>  			if (((s32)DST < 0) =3D=3D ((s32)SRC < 0))
>  				DST =3D (u32)AX;
>  			else
> @@ -1982,8 +1987,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct =
bpf_insn *insn)
>  			DST =3D (u32) AX;
>  			break;
>  		case 1:
> -			AX =3D abs((s32)DST);
> -			do_div(AX, abs((s32)IMM));
> +			AX =3D __safe_abs32((s32)DST);
> +			do_div(AX, __safe_abs32((s32)IMM));
>  			if (((s32)DST < 0) =3D=3D ((s32)IMM < 0))
>  				DST =3D (u32)AX;
>  			else
> --=20
> 2.34.1
