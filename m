Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF2638C43D;
	Tue, 24 Mar 2026 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345369; cv=none; b=rzIpFpx7qiqh8YtihwBBKnqbokXGPd3I2dw3FrSFDPosRfNld7JJ0eHKAxx20qYUjiHN2xyT+6NlrFmPn/TyrXUv7HxtarldVBOBhGpGUKdgit8oD5r2lvxL5AMBHOocYqn6T+5uTbyBa2JbNFKykjWQLBiVWQPXP3t+8Zhw8t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345369; c=relaxed/simple;
	bh=cOmymRh6eHE0j2p33Q1KgMqAmDq3K9jgiyb191hhoCQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=m/V6/lWrcJMWSLrqxleWIEDu5+I9tpi82UV/wJ6QTwRiEun/BkEuFiXfhL/nsauN6lZl1Y5jJf++W2cwNMS5QOc7dDVVKE7YrNT2WyhHkEqZNwFVGojcL8a2BPK/AV+XTkyDTCfxelHIYOGf1U3I5Cq6MWWXx4Xzz3pPrUZaUqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZ68vgoM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZ68vgoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32447C19424;
	Tue, 24 Mar 2026 09:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774345369;
	bh=cOmymRh6eHE0j2p33Q1KgMqAmDq3K9jgiyb191hhoCQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ZZ68vgoM8oxRKP8sl1X5+A594Pj2IIh6YlFXdaI1NWbGKnxGbIULMfEUG/bHhi+WZ
	 OarieXmuSLl+YpoemtxDXcb5Cl4eGCbSqTKC51pS6eRaxYCf/ux1c0e7KX+vMZsL+l
	 aXvSFwfTvWzE8bOfZgT66JM0uFOgExQkEtBk9cOzZP1iE+NJoneO8AQ+eQ7rBuC2fb
	 ha4G6yityK1iaE2zP3s+4hcpXVdClUYRJiuM7zWCLX2m5Nitp3nUUPwdUGShmeVAIm
	 xmv6Hm4LXmEL1K0TomaFTNgd9H4ENN+SO2gSCWk5Ie4DoYvyv1QPVp2VxBzaFNrLOh
	 kGdukgJMUOmTQ==
Content-Type: multipart/mixed; boundary="===============3029566825714952226=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5a2cfd2c3dddef83de46ea9b0f02bb5b90c29937c9b9d348542838fde1e29a93@mail.kernel.org>
In-Reply-To: <20260324090106.13527-7-yangtiezhu@loongson.cn>
References: <20260324090106.13527-7-yangtiezhu@loongson.cn>
Subject: Re: [RFC PATCH 6/7] LoongArch: BPF: Add load-acquire and store-release instructions
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,loongarch@lists.linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 24 Mar 2026 09:42:49 +0000 (UTC)

--===============3029566825714952226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index c9a32f124f5e..d1e9866911dd 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c

[ ... ]

> +	/* store_release(dst_reg + off16, src_reg) */
> +	case BPF_STORE_REL:
> +		switch (BPF_SIZE(insn->code)) {

[ ... ]

> +		case BPF_W:
> +			if (cpu_has_llacq_screl) {
> +				move_imm(ctx, t1, off, false);
> +				emit_insn(ctx, addd, t2, dst, t1);
> +				emit_insn(ctx, screlw, src, t2);

SCREL.W is a store-conditional instruction, not a plain store-release.
It checks LLbit and then overwrites rd with the success indicator
(1 or 0), which would clobber the BPF source register.

Looking at emit_atomic_rmw() in the same file for BPF_CMPXCHG, the
existing LL/SC usage carefully avoids this:

    move_reg(ctx, t3, src);
    emit_insn(ctx, scw, t3, t1, 0);
    emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -6);

Here SC.W is applied to the temp register t3 rather than the BPF
register, and t3 is then checked for 0 to retry the loop. This
confirms that SC-family instructions clobber their rd operand on
LoongArch.

Is SCREL.W/D the right instruction for a standalone store-release?
The other architectures use plain stores with ordering guarantees
for BPF_STORE_REL:

  - arm64 uses STLR (a true store-release, not store-conditional)
  - x86 uses a regular MOV (x86 stores have release semantics)
  - riscv uses fence + store
  - powerpc uses lwsync + store

This also appears to be the root cause of the test failure noted in
the cover letter, where "store-release, 64-bit @unpriv" returns 1
instead of the expected 0 -- the value 1 is the SCREL success
indicator that replaced the original register contents.

> +			} else {
> +				pr_err_once("bpf-jit: screl.w instruction is not supported\n");
> +				return -EINVAL;
> +			}
> +			break;
> +		case BPF_DW:
> +			if (cpu_has_llacq_screl) {
> +				move_imm(ctx, t1, off, false);
> +				emit_insn(ctx, addd, t2, dst, t1);
> +				emit_insn(ctx, screld, src, t2);

Same issue here with SCREL.D -- src will be clobbered.

> +			} else {
> +				pr_err_once("bpf-jit: screl.d instruction is not supported\n");
> +				return -EINVAL;
> +			}
> +			break;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23481783544
--===============3029566825714952226==--
