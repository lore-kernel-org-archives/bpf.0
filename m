Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE628B7EA;
	Tue,  2 Jun 2026 02:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368752; cv=none; b=sbRmnlOAyoIhrOiedSQLwnpyWZFbXY7ylHtdm7Q0DK/dI3BbspXcq4tzdNdfdSC6pDgCP4/2j1g5T4c2eHcoLqG+Vi1z1zNbNPLjROpf9b1gA4NmvQ8ZxzyTh64+LFUKseYL9AjllLlOqJgJEnXjOhkfFLg1EwTBgw9mSX0aAQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368752; c=relaxed/simple;
	bh=K4cn/QpSIf5Va1Lyu2kU9ycfdY+1xxc4PyVXelQCFzY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uozZhziowYlrMaHfePgFsatCo0nwMpn5mH11W9NOgfj3h8Pw+l/omvFzE5Wz1FZnwiE67l1Z8F43cxlZSR64QaV09KA4bycpfuMPssCWBCWCIsp+LJ+LmhAYYDI+udHWvdtnk4AvJ88cNGTdcbSRWRUmOIJUFPg85SMYm52JhSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U09tW/t3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U09tW/t3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504E71F00893;
	Tue,  2 Jun 2026 02:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780368750;
	bh=OCNI3phcRGTQey92eTGrjaMPDFvmHE2qoCnRNUbUDwY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=U09tW/t3rShHFxQ+z6fFkhqVMpGKyUXfVbuXhedOod/hM9P0TQQaDA20pMtS8xdQm
	 UfUwBR7C0PuEkXPV/trrblggP53g7UrOi5DqGDQ1U8KAIoYdFrBT31e4CprRvTjlBx
	 37PrLPEr8dHVUU2rXGxwdRXp9QOp/J9eP9P10RYXoYWgPRjNQtDJT5PLl4HzZg1L1E
	 XHh3S6fLp/sD50k9Po+pPLftuRqe9XGtg+Ydwl+jmfBoVEYgb1Waly9Ku0l3Tffi5E
	 VHa/d34LVb/G8smOvoUWXiFkgSZ5jiBr6zOTVFfdxln6NjEnOBYe5Soxz/QqenEs0J
	 t1/VybYfPrOgQ==
Content-Type: multipart/mixed; boundary="===============7943209665563870969=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d1d0000c239dc4e9c8f6a875d7df469b6f7bb1a528e1a97a757ff939ec482ec6@mail.kernel.org>
In-Reply-To: <20260602021515.214560-1-zhaochenguang@kylinos.cn>
References: <20260602021515.214560-1-zhaochenguang@kylinos.cn>
Subject: Re: [PATCH] LoongArch: bpf: Support kptr xchg inline
From: bot+bpf-ci@kernel.org
To: zhaochenguang@kylinos.cn,chenhuacai@kernel.org,kernel@xen0n.name,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,yangtiezhu@loongson.cn
Cc: zhaochenguang@kylinos.cn,hengqi.chen@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 02:52:30 +0000 (UTC)

--===============7943209665563870969==
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

[ ... ]

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 24913dc7f4e8..b2bc54b4ca87 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -486,7 +486,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
>  			emit_zext_32(ctx, src, true);
>  			break;
>  		case BPF_DW:
> -			emit_insn(ctx, amswapd, src, t1, t3);
> +			emit_insn(ctx, amswapdbd, src, t1, t3);
>  			break;
>  		}
>  		break;

The patch defines amswapdbw in asm/inst.h to provide the ordered 32-bit
exchange instruction, but does the BPF_W case of BPF_XCHG in
emit_atomic_rmw() also need to be updated?

Currently, the 32-bit exchange uses the weakly ordered amswapw instruction
at the BPF_W case:

arch/loongarch/net/bpf_jit.c:emit_atomic_rmw() {
    ...
    case BPF_W:
        emit_insn(ctx, amswapw, src, t1, t3);
        emit_zext_32(ctx, src, true);
    ...
}

Should this be updated to use the new amswapdbw instruction to ensure the
BPF memory ordering guarantees are met for 32-bit exchanges?

Reference: https://lore.kernel.org/bpf/20260602022526.C2C371F00898@smtp.kernel.org/

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26794506560
--===============7943209665563870969==--
