Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325E33F5B1
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640979; cv=none; b=HYhCmJW/lql/FjXYMoW/Z48eDRlSrow3wzOS6Spg+0TstZaAYwI20qfc1fMKWeohJ84nSfMFeSaYC2OXTHmPXGWoqyTwZO+8UNVaLpgDT9YXvVAOC48ETvAiUxq+pM7bKedckX4Bmsy/D4pE9CuOicmp5Z/ukjGj+uxXbJufLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640979; c=relaxed/simple;
	bh=T7f4tXnoY/hEozTaziiKAKOGF0srqtLlgr+HlO0N/OA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aL1yh+PTgbo01UQQDAMX4Smbt7dPBoB3A8Q++Gj2Q5xyGy+dTClluHl2OIE0dkfykwuUDkSBRQSVUuck3UsFEQngj3m/g5mqA4Hx2fb42ZWyF6Jasy6bvWVbOjIDny7GG5A7H7t+rIcqFxgdz8pyx4HybUkjiKB6BFXgIE3CYBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJVRsMu5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJVRsMu5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF4BC4CEF7;
	Wed,  4 Mar 2026 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772640979;
	bh=T7f4tXnoY/hEozTaziiKAKOGF0srqtLlgr+HlO0N/OA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=CJVRsMu5rhDuFWR3fw7kqBVymwu14o4LSUoXHgeZgiUIoIW/eeLMPxUtCM6YMycoc
	 gN9Ue6pgC/sooPSzqGzJ7iSXT1kVPrjCSALonkLpPur87Xr59CzB84xuNlRbXzxZBk
	 KvDbeCGfpXCYRqq/I9eiBKPkTLEujc8HdGL7Z4EEzCEVHf2Jh2y7/7kHOHVcpvg3g3
	 pgBA6oUJfspZFMX8pKJWvmnlGNevYKS/ch3or/xeU4w2wx9JnL0g7ysnmCYpYl11Bv
	 FqyjIkG1lD7FZHxf6Qqarcupl1mLlCSCTHW9ka0s5ES8en6RqA1GVPjQdvFiSumW9a
	 lWu/is52md3Uw==
Content-Type: multipart/mixed; boundary="===============8677841370066391576=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fef042048a6ecfc6de8186922df313d8b3e61cc6dffd714e046882ec3c3dc68b@mail.kernel.org>
In-Reply-To: <20260304151932.177995-2-cupertino.miranda@oracle.com>
References: <20260304151932.177995-2-cupertino.miranda@oracle.com>
Subject: Re: [PATCH v2 1/2] bpf: detect non null pointer with register operand in JEQ/JNE.
From: bot+bpf-ci@kernel.org
To: cupertino.miranda@oracle.com,bpf@vger.kernel.org
Cc: cupertino.miranda@oracle.com,david.faust@oracle.com,jose.marchesi@oracle.com,elena.zannoni@oracle.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 16:16:19 +0000 (UTC)

--===============8677841370066391576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17647,12 +17647,15 @@ struct linked_regs linked_regs = {};

[ ... ]

> 	/* detect if R == 0 where R is returned from bpf_map_lookup_elem().
> +	 * Also does the same detection for a register which the value is
> +	 * known to be 0.

Minor grammar nit: "a register which the value is known to be 0" reads
awkwardly.  Should this be "a register whose value is known to be 0"
to match the corrected commit message wording?

> 	 * NOTE: these optimizations below are related with pointer comparison
> 	 *       which will never be JMP32.
> 	 */
> +	if (!is_jmp32 && (opcode == BPF_JEQ || opcode == BPF_JNE) &&
> +	    type_may_be_null(dst_reg->type) &&
> +	    ((BPF_SRC(insn->code) == BPF_K && insn->imm == 0) ||
> +	     (BPF_SRC(insn->code) == BPF_X && register_is_null (src_reg)))) {
                                               ^^^^^^^^^^^^^^^^^

There is a space between the function name and the opening parenthesis.
Every other call to register_is_null() in verifier.c omits this space.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22676623004
--===============8677841370066391576==--
