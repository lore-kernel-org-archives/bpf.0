Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225837FF54;
	Mon, 13 Apr 2026 04:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776055760; cv=none; b=Ch11xOvLkd/u4CHyhVY8FHpARrXEuHmalArgO5ntOCC7jY+KcnnK0c3Sks7aTwr5ebYF5t2dSfOPhjKX5+LRkPLEGLMYOerkfmHYIz9DYRp63ugnjS9rcfbfqYaoPkaPf3JRWSU8Tzw6hMTkSqB4GcNOWgUuVx85v1IeoY5v4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776055760; c=relaxed/simple;
	bh=50BPTvIj3kIA/KT5yv3UiM2at1LwHEHbBZXiESSyABI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tL4lBdt/uf15xbAWTy5UG3mJxtJ2A4AZvTo4havA/SBxEVuMgnf598+2EAwFiHB4UgWnPrehBJII4UWPmsAq2KSpH6LzxlDZi3+6Oy0/JCS+5tOnqTkc3Yp3NSlj+AvXWfd1PHGku9NgtrUsVav6CIs2WWmwJ1Oy3FJiIGB4NyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX0aU+l6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX0aU+l6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485B5C116C6;
	Mon, 13 Apr 2026 04:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776055760;
	bh=50BPTvIj3kIA/KT5yv3UiM2at1LwHEHbBZXiESSyABI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=lX0aU+l6QiwDflFjf28iaDRPoBPl8lTZ4rHGYOQ+NocZLkv0CuwjsEzw0uINnN4Nl
	 5zG8yh9cAv17/Xni1dIQjXYg3UTkgoI2dZsv1Dl9PYD8h6VlC4DwpOaqQo0MPDsaMy
	 Js2Wb4kW9t1DA77fA8KRNGVx78edMQymzAv/GrOe4kbcw3SbALxrlP0EG57nn6plC5
	 Sb4NCca8dQsu5EdZhgbqUUn+LWscwcsWz00xqFhMTeQCu8pLd+BYvC2cmUnW1IIIF0
	 0DtOUVkAIZ0TWL2IMjG6jqNaaF94qKU09p4Ra/MWnrcpxUkTyO+SftDFqrxfTfr+En
	 v/mvfsDjq+DPQ==
Content-Type: multipart/mixed; boundary="===============7323906579465492613=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8822e0eb47985fc0bcb8bc6c9b0fcdfb55566144517d90a8e77f2690c44ee8df@mail.kernel.org>
In-Reply-To: <20260413040506.26640-4-yangtiezhu@loongson.cn>
References: <20260413040506.26640-4-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v3 3/5] LoongArch: BPF: Support 8 and 16 bit read-modify-write instructions
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,chenhuacai@kernel.org,hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 13 Apr 2026 04:49:20 +0000 (UTC)

--===============7323906579465492613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index fefda4050a20..c9a32f124f5e 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c

[ ... ]

> @@ -388,11 +408,32 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
>  	/* src = atomic_fetch_<op>(dst + off, src) */
>  	case BPF_ADD | BPF_FETCH:
> +		switch (BPF_SIZE(insn->code)) {
> +		case BPF_B:
> +			if (cpu_has_lam_bh) {
> +				emit_insn(ctx, amaddb, src, t1, t3);
> +				emit_zext_32(ctx, src, true);

Is emit_zext_32() sufficient for zero-extending an 8-bit value here?

emit_zext_32() uses lu32id to clear bits [63:32], but for a byte-width
atomic fetch the returned value needs bits [63:8] zeroed. If amadd.b
follows the LoongArch convention of sign-extending sub-word results
(as amadd.w does for 32-bit values), then a byte value like 0x80 would
produce 0x00000000ffffff80 after emit_zext_32() instead of the expected
0x0000000000000080.

Elsewhere in this file, 16-bit zero-extension already uses bstrpickd:

    emit_insn(ctx, bstrpickd, dst, dst, 15, 0);

Should the BPF_B and BPF_H cases here use bstrpickd with the
appropriate bit range (7,0 for bytes and 15,0 for halfwords) instead
of emit_zext_32()?

> +		case BPF_H:
> +			if (cpu_has_lam_bh) {
> +				emit_insn(ctx, amaddh, src, t1, t3);
> +				emit_zext_32(ctx, src, true);

Same concern for the halfword case -- emit_zext_32() would leave
bits [31:16] with sign-extended values if amadd.h sign-extends.

[ ... ]

> @@ -421,11 +462,32 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
>  	/* src = atomic_xchg(dst + off, src); */
>  	case BPF_XCHG:
> +		switch (BPF_SIZE(insn->code)) {
> +		case BPF_B:
> +			if (cpu_has_lam_bh) {
> +				emit_insn(ctx, amswapb, src, t1, t3);
> +				emit_zext_32(ctx, src, true);

Same question applies to the exchange path -- amswap.b and amswap.h
return the old value and would need proper sub-word zero-extension
rather than the 32-bit emit_zext_32().

> +		case BPF_H:
> +			if (cpu_has_lam_bh) {
> +				emit_insn(ctx, amswaph, src, t1, t3);
> +				emit_zext_32(ctx, src, true);

Same here for amswap.h.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24325384786
--===============7323906579465492613==--
