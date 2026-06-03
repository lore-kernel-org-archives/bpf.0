Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DCD428841;
	Wed,  3 Jun 2026 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484350; cv=none; b=ocL0Rnl4AmA2s5IiO0U35EoQ8SnTpU/IQzZW0Zo0u6TX95IexfwyjkA6IjjDnEIvKSvpx2ogOXe0cc4OHVo+ipENYzXUyn/LZg98ghxg/dGIrI13vV7b1Xcblgb2gZBbgSsXsQ8u5FElDFuRgHLmFM+ZHs/DQQF3gDetsK1KYcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484350; c=relaxed/simple;
	bh=t+cki3wXIG0nscmYAdmLLaMlAxKQc6RtuMI9PKrZleA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HkaBbw7W2eFnOklMpF/tTra+CX9YhHK03YMGVp4h0hclArjL6NwcKGgsqkn14yn1rGisn/mh7eg49F1FW++bmVYuJHv+pEvIAIkZSoVGdrE3p9VsD/+hwPwUNrc45JvPUtC0Ha7dvSF3+gmmnhLTUKL5wV1Xvf/Jc7zMBUFEuYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDgUhWjm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDgUhWjm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6291F00893;
	Wed,  3 Jun 2026 10:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780484349;
	bh=IBHUlSohGwOSoD+kQjNRJAfO05UWKQegIZEd4SWaE4U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BDgUhWjmGy8lESU54FHetczAY5zD2a1lZ12KSi7XrnfqI5LjaO4rOH4lrX70mVsq4
	 OYjCeemYDKaH0qhlW/LGzyov6Lg2O05mXoqt8D6AT9gkQT2LJJGxcLXsVjzybi+LVf
	 DzRhfG7U3vnS4PSCfX9ju2aDAOfygdzPbmbb8GKibleMuTAVOMlMeDhqMd+bkUrSca
	 PtOfoJMZ5ELr7TXQeKfJ3+Yz6G0YQj/xBqOR3Y8RQ3gPjgMQ2OEZVktsW6Nkoj1vZr
	 GkqgsShGTFwhWxX9pkSG4KuazJ92MkslcQv7rIqQH9jhFrycfHoiCuZblLhRBcuWLT
	 OkIUBEHDcWGtA==
Content-Type: multipart/mixed; boundary="===============4628976069350686524=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <af8f8f318aae78a9534bef53e3b753bcf9767bff15aaf92f59e69e847db6b65c@mail.kernel.org>
In-Reply-To: <20260603100438.2177817-2-zhaochenguang@kylinos.cn>
References: <20260603100438.2177817-2-zhaochenguang@kylinos.cn>
Subject: Re: [PATCH v2 1/4] LoongArch: bpf: Use amswap_db for BPF atomic xchg
From: bot+bpf-ci@kernel.org
To: zhaochenguang@kylinos.cn,chenhuacai@kernel.org,kernel@xen0n.name,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,yangtiezhu@loongson.cn
Cc: zhaochenguang@kylinos.cn,hengqi.chen@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  3 Jun 2026 10:59:08 +0000 (UTC)

--===============4628976069350686524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index 76b723590023..636cfc524b02 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -783,6 +783,8 @@ DEF_EMIT_REG3_FORMAT(amswapb, amswapb_op)
>  DEF_EMIT_REG3_FORMAT(amswaph, amswaph_op)
>  DEF_EMIT_REG3_FORMAT(amswapw, amswapw_op)
>  DEF_EMIT_REG3_FORMAT(amswapd, amswapd_op)
> +DEF_EMIT_REG3_FORMAT(amswapdbw, amswapdbw_op)
> +DEF_EMIT_REG3_FORMAT(amswapdbd, amswapdbd_op)
>
>  #define DEF_EMIT_REG3SA2_FORMAT(NAME, OP)				\
>  static inline void emit_##NAME(union loongarch_instruction *insn,	\

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 24913dc7f4e8..f071d913e054 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -482,11 +482,11 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
>  			emit_zext_32(ctx, src, true);
>  			break;
>  		case BPF_W:
> -			emit_insn(ctx, amswapw, src, t1, t3);
> +			emit_insn(ctx, amswapdbw, src, t1, t3);
>  			emit_zext_32(ctx, src, true);
>  			break;
>  		case BPF_DW:
> -			emit_insn(ctx, amswapd, src, t1, t3);
> +			emit_insn(ctx, amswapdbd, src, t1, t3);
>  			break;
>  		}
>  		break;

The commit message states that value-returning atomic RMW instructions
imply a full barrier per the LKMM.

This change only updates the BPF_W and BPF_DW BPF_XCHG cases.  Should the
other value-returning atomics in emit_atomic_rmw() get the same treatment?

The BPF_*_FETCH cases still emit the plain amadd/amand/amor/amxor variants:

arch/loongarch/net/bpf_jit.c:emit_atomic_rmw() {
	...
	case BPF_W:
		emit_insn(ctx, amaddw, src, t1, t3);
		emit_zext_32(ctx, src, true);
		break;
	case BPF_DW:
		emit_insn(ctx, amaddd, src, t1, t3);
		break;
	...
	case BPF_AND | BPF_FETCH:
		if (isdw) {
			emit_insn(ctx, amandd, src, t1, t3);
		} else {
			emit_insn(ctx, amandw, src, t1, t3);
	...
}

The sub-word BPF_XCHG cases (BPF_B and BPF_H) still emit plain
amswap.b/amswap.h:

arch/loongarch/net/bpf_jit.c:emit_atomic_rmw() {
	...
	case BPF_B:
		...
		emit_insn(ctx, amswapb, src, t1, t3);
	...
	case BPF_H:
		...
		emit_insn(ctx, amswaph, src, t1, t3);
	...
}

And BPF_CMPXCHG uses an ll/sc loop with no dbar barrier:

arch/loongarch/net/bpf_jit.c:emit_atomic_rmw() {
	...
	case BPF_CMPXCHG:
		move_reg(ctx, t2, r0);
		if (isdw) {
			emit_insn(ctx, lld, r0, t1, 0);
			emit_insn(ctx, bne, t2, r0, 4);
			move_reg(ctx, t3, src);
			emit_insn(ctx, scd, t3, t1, 0);
			emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -4);
		} else {
	...
}

These are also value-returning atomics.  If the LKMM requires a full
barrier for all of them, would these cases need updating too so that
lockless BPF algorithms stay sequentially consistent?

This was also raised by the Sashiko AI review on v2:
https://lore.kernel.org/bpf/20260603101633.25FFA1F00893@smtp.kernel.org

There is no Fixes: tag on this commit.

The amswap.{w,d} BPF_XCHG path was introduced when the LoongArch BPF JIT
first implemented BPF_XCHG.  Should this carry:

  Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26878707871
--===============4628976069350686524==--
