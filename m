Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890BD433E83
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004247; cv=none; b=h0wfzbehmgp1AtoHFFaaZ876f9UKmHBz/AlYJw+SDUU2/gpckrYDk+jddkvTqQ/E9bn3AaZJHmK9FZIZbXLanA88EKwFynRMZ7aR0LfnKc5bfSW2p1z6yXry3iHoiAdq3QWn7fzwgoHX5KGeJjXxWVvIZkjTZVP17WniSJX3Wko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004247; c=relaxed/simple;
	bh=wTH/ET1uFYGC3olQ0JEGHkRc3WdxULcmCRUok/Osm0I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LPdXRledcf/AgeEAXKMJON6SdjUs3qmyF7l0XACDrJUuU1UNI5U2jLhih7U0MKXacJvHGuv/a+c/5cBZZPrjNZ24sSOeovSkZATFt09yb9v0Log1AhubJVHoSmbxdk6VCrdxlrO9hAzAI0ZIReYzaPjYRgIvEOrIrRGi5OI9uKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1B1pLPK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1B1pLPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B96B1F000E9;
	Thu,  2 Jul 2026 14:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783004246;
	bh=/D+SelDnK+rSlDMzU8mcBd4QpGdhdAGpiCsS7q+Rt6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W1B1pLPK3dAViCxcF2X0Pjfyny70nZTJuCt41N/Co3Y7vHJNX53hIRBPZ59k7QU1q
	 lFcVT8zgh99vaOXyIO13SJBNKeJ5xLegFaEulFMnamJ7slsSUbxIRxwrh/AP1iYvnb
	 gQp/B/arqjpvxW6bZutTtdguEDdwM1qWhvZt8ihPfaVw1+SVGPh/JwIM3AnHOrnOWv
	 bdy6wnJ47THgZxtBwFpUsQarfrECvR7Rctgv/5Dv4QJQu++Z36G1lr38EXecllinyw
	 cwE/nMDyrQDnns0WxWtiWQP7S0AJRGEyCMqKSdCtGezZ4mhI2++w624J42bugXc6aN
	 yyl5VErMBTL+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 2/2] bpf: Reject programs with inlined
 helpers if JIT is unavailable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702143656.28845-3-yangtiezhu@loongson.cn>
References: <20260702143656.28845-1-yangtiezhu@loongson.cn>
 <20260702143656.28845-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 14:57:24 +0000
Message-Id: <20260702145726.0B96B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch prevents loading BPF programs that use JIT-inlined helpe=
rs (e.g., `bpf_get_smp_processor_id`) when the BPF JIT is explicitly disabl=
ed at load time (`net.core.bpf_jit_enable=3D0`).
--

commit 01713d8606e656f4dadefe493f371f4c861d842b
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

bpf: Reject programs with inlined helpers if JIT is unavailable

This patch sets the jit_required flag to 1 when a BPF program uses helpers
that are expected to be inlined by the JIT compiler. This prevents a kernel
panic in the BPF interpreter by rejecting the program with -ENOTSUPP if
JIT compilation is unavailable at runtime.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 12a8a4eb757f1..94e0457a0aa33 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1841,8 +1841,10 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *en=
v)
>  		}
> =20
>  		/* Skip inlining the helper call if the JIT does it. */
> -		if (bpf_jit_inlines_helper_call(insn->imm))
> +		if (bpf_jit_inlines_helper_call(insn->imm)) {
> +			prog->jit_required =3D 1;
>  			goto next_insn;
> +		}

[Severity: High]
While this correctly prevents the interpreter panic, does this unconditiona=
lly
reject valid BPF programs when the JIT is explicitly disabled at load time
(e.g., net.core.bpf_jit_enable=3D0)?

If this block checked prog->jit_requested before skipping the fixup and
setting jit_required, wouldn't the verifier properly patch the instruction
when JIT is disabled, allowing the program to execute successfully in the
interpreter?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702143656.2884=
5-1-yangtiezhu@loongson.cn?part=3D2
