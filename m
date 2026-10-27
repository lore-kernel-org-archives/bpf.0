Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128081;
	b=0CwhGlQCc+vXQzy7JGekSiW6CB4geYiwGc7TLvax/pDq3OqiGwwONTEByjK1cgYtk/70
	 TcaCdO1ZuQtAMC14kJTc1BB9ETzqZVKWMFKbc2vnJDVe4nTxSS0ifIiIo0QWMrm/aHGUu
	 TT6/TagFrptMHyU/gm2O2hk5mObGZOlhxs6VHE/ZjLluFGfRD8rtkjvRcGE8mZj8O4wjK
	 nGp/NEYszzI7ayoHKBVdsHhuRJosEqb6D7o3oI5duLVnX7LR5p5FpmgRs/kx7H8W2bLVt
	 DU1m/6prKWXlePayeDLUW5lHlFgBVal4Saj6XYQNVvIP+bNKqItZQ9Ka7ql3lJ5oTuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128081;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=uDsbQ6xzvwRn2US6nyBEbGvELdN8FXkguf+L+AqI5k0=;
	b=fnO5qrQS0OurkJMk1AWeqtJX5aVwkdD905/n2Z0YS/vxL+dtSfFB2usFjH1ZbyuS6p+m
	 sKhob3dAE6oHLiIPdozEu/CjYyivk/SBwSU4HlK7sGdWloqM/Jda85A3w6C6miY2mKGq2
	 EYFoPX6EDzs9JGbVLpXGhQd3y5iJodxfDmfRU/oj2WUcq12lsBcMbz2a7HvECc6qDIP9x
	 twT2OF46rUsQgjyopugHNzMOYl11DxCkco9W9yDBRNSpElRIN0dXxyV95nkeQ/8eMPQcV
	 4T20T8vNjZ1i3WWDGRqKI9mKh1Dk4YRfjvDVnB2AzOFNSPNO78A6zVog8muU8pE13lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAW2Zij+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37003606A31F
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAW2Zij+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935171F01828;
	Tue, 27 Oct 2026 19:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793128080;
	bh=uDsbQ6xzvwRn2US6nyBEbGvELdN8FXkguf+L+AqI5k0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jAW2Zij+ii+TQzbxC9HuF479xyddFGchMD4Dp+uh/zGNKo1FHblyigPcb5f68XD82
	 yIFsfB03vo9opHjtQ6ZQ3u6xdjbYf5XffdWy59JvYe2dHbCJW1+AZmCf5zhVeUS8yr
	 EXMHmlueiPRAd1nSI9Oe9fl4L9wfMlCYksMaymwihlsxVAzfM8knZzewvx28srpWO5
	 ukCW3nAACEVj4i6+2zQJ6LtGIjAM+ekIV2nQe1+KusQDJUTM9Uew2jXc6CvOztpSDv
	 W7VJyLNojq2M+KcOBa7eNEuN0eVvJCsplefO+f3K8uDd+hyJbzEoQyKCyZgVAbG9sy
	 0FpZ4qpsk7nTg==
Content-Type: multipart/mixed; boundary="===============4854283968995429951=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7a1964197fbc263dea8647ff3c513ef65704fa224005543904ebf3a122d41b24@mail.kernel.org>
In-Reply-To: <20261027182445.1156335-16-daniel@iogearbox.net>
References: <20261027182445.1156335-16-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 15/21] bpf, arm64: Divide by constants via multiplication with a magic number
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,puranjay@kernel.org
Cc: memxor@gmail.com,ast@kernel.org,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 27 Oct 2026 19:08:00 +0000 (UTC)

--===============4854283968995429951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, arm64: Divide by constants via multiplication with a magic number

TL;DR: Design question, not a bug: emit_div_const() in the arm64 JIT
duplicates the x86 JIT's divisor handling (sign correction, pre-shift, shift
guard). Could it be shared in kernel/bpf/core.c?

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -593,6 +593,141 @@ static bool adjust_cmp_imm(u8 *op, s32 *imm)
> +static bool emit_div_const(const struct bpf_insn *insn, struct jit_ctx *ctx)
> +{

[ ... ]

> +		bpf_magic_sdiv(imm, &mag);
> +		/* q += n for d > 0 and m < 0, q -= n for d < 0 and m > 0 */
> +		if (imm > 0 && (s64)mag.m < 0)
> +			corr = 1;
> +		else if (imm < 0 && (s64)mag.m > 0)
> +			corr = -1;
> +	} else {

[ ... ]

> +		bpf_magic_udiv(imm, 0, &mag);
> +		/*
> +		 * Shift the dividend by the trailing zeros of an even divisor
> +		 * first, the magic number of the odd part then fits without
> +		 * the add sequence.
> +		 */
> +		if (mag.add && !(imm & 1)) {
> +			pre = __ffs(imm) & 31;
> +			bpf_magic_udiv(imm >> pre, pre, &mag);
> +			if (mag.add)
> +				return false;
> +		}
> +	}
> +	s = mag.s;
> +	/*
> +	 * The shift is at most 63, or 64 with the add sequence which shifts
> +	 * by s - 1 and needs s >= 1. Never hit for d >= 2, kept as a guard
> +	 * against an unencodable count.
> +	 */
> +	if (s > 64 - !mag.add || (mag.add && !s))
> +		return false;

this isn't a bug, but the divisor handling in emit_div_const() looks the
same as in emit_div_const() in arch/x86/net/bpf_jit_comp.c: the sign
correction chosen after bpf_magic_sdiv(), the pre-shift by the trailing zeros
with the second bpf_magic_udiv() call for an even divisor, and the shift
count guard, comments included.  Only the instruction emission differs.

Could the corr/pre/shift-guard selection sit in kernel/bpf/core.c next to
bpf_magic_udiv() and bpf_magic_sdiv(), so the two JITs share one copy?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40562673614
--===============4854283968995429951==--
