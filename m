Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0247357D0B;
	Fri, 31 Jul 2026 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534138; cv=none; b=adCXGXCPl5z+khrvV0F2PVZOdy0Ga7sinj4aZd8EzgiUkNaANWEwNB43Ath71U2ynUTypxh1ABfzJgszSNczL/ddsBrK+fzcaH4ZTzYiYvG0LlKPzg4G5WBbQHo/qrgyUiFBhGVkoam/SLEoqBVlaGMV1PowND0cw4ROw6xt1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534138; c=relaxed/simple;
	bh=0NOOYwwQ1TIVKt92gkmVVRgXfsAdTy/V3Md4uvzdGuI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bkpmSq2AAuNcGwpOsjp2oxGpGDvRDSzAbJKwMtN5ic9ReFwzWQnzgjSNZabduKaCKNC2f0QUVrfbSqGHi4wQF0tIK4ePszJ5XG8AokdRDdFdd0q3yDucMknMuppHaRYQJ++JDb4mxkSBYfxKZjKfI8wQ31JIsRl0sR28G9pOdkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+xKsEbs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+xKsEbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4AD1F00AC4;
	Fri, 31 Jul 2026 21:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785534137;
	bh=+YeiBRqriyWttSnuVzJ8T2X/WzHiPJ8L0llstU+niuM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=g+xKsEbsDA8dZ/RaksT9NkQFNEAGRd2/OCnGdcBJYszTJO4OcnKXIIWcMvd0rq2Y5
	 We+xV1qBOp8pk7uqX6W/cc2612jOiHVxu2r+8NU2B6HXpO/bvlsD+ubQrJPzhFK55P
	 oNoV4aaCzDEz8rXyhDTqYQpplNhViZd5yZCHxrfeUv4kTzu9QDawzyp1ayhjLcexLb
	 B4EFSVW/vJMr51xqalCYJN65Fs3VtPoAfSN5kACPD+6QWIWcT35aE8gXojtuXzri94
	 lOT/Lc2+0UOARXpOrHWHAXdQeUaSq9Z6+o/g/glRh83e654dOVCHWOX23jIwuFpD88
	 LBKyqIfHZqTDA==
Content-Type: multipart/mixed; boundary="===============2028487587190646803=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ca219edf78ea1ea8db81654d615a481b4837a6c9bc971b91050c2be047f65c10@mail.kernel.org>
In-Reply-To: <20260728031615.9389-2-yangtiezhu@loongson.cn>
References: <20260728031615.9389-2-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v1 1/2] LoongArch: BPF: Clean up and decouple is32 parameter from move_imm()
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,chenhuacai@kernel.org,hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 31 Jul 2026 21:42:16 +0000 (UTC)

--===============2028487587190646803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
> index a8e29be35fa8..9438fce49e69 100644
> --- a/arch/loongarch/net/bpf_jit.h
> +++ b/arch/loongarch/net/bpf_jit.h
> @@ -137,7 +137,7 @@ static inline void move_addr(struct jit_ctx *ctx, enum loongarch_gpr rd, u64 add
>  	emit_insn(ctx, lu52id, rd, rd, imm_63_52);
>  }
>
> -static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm, bool is32)
> +static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm)
>  {
>  	long imm_11_0, imm_31_12, imm_51_32, imm_63_52, imm_51_0, imm_51_31;
>
> @@ -150,7 +150,7 @@ static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm
>  	/* addiw rd, $zero, imm_11_0 */
>  	if (is_signed_imm12(imm)) {
>  		emit_insn(ctx, addiw, rd, LOONGARCH_GPR_ZERO, imm);
> -		goto zext;
> +		return;
>  	}
>
>  	/* ori rd, $zero, imm_11_0 */
>  	if (is_unsigned_imm12(imm)) {
>  		emit_insn(ctx, ori, rd, LOONGARCH_GPR_ZERO, imm);
>  		goto zext;
                     ^^^^^^^^^^

Does this code compile? The is_signed_imm12 branch now returns early, but
the is_unsigned_imm12 branch still jumps to the zext label that was removed
by the same commit:

> @@ -195,9 +195,6 @@ static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm
>  		if (!is_signed_imm52(imm))
>  			emit_insn(ctx, lu52id, rd, rd, imm_63_52);
>  	}
> -
> -zext:
> -	emit_zext_32(ctx, rd, is32);
>  }

This dangling goto zext; at the is_unsigned_imm12 path has no target after
the label was deleted. Should this become 'return;' to match the
is_signed_imm12 path?

[ ... ]

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 2738b4db1165..d676936e5b98 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c

[ ... ]

> @@ -765,7 +765,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>  	/* dst = imm */
>  	case BPF_ALU | BPF_MOV | BPF_K:
>  	case BPF_ALU64 | BPF_MOV | BPF_K:
> -		move_imm(ctx, dst, imm, is32);
> +		move_imm(ctx, dst, imm);
> +		emit_zext_32(ctx, dst, is32);
>  		break;

[ ... ]

> @@ -843,12 +847,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>  	case BPF_ALU | BPF_DIV | BPF_K:
>  	case BPF_ALU64 | BPF_DIV | BPF_K:
>  		if (!off) {
> -			move_imm(ctx, t1, imm, is32);
> +			move_imm(ctx, t1, imm);
> +			emit_zext_32(ctx, t1, is32);

All these call sites were updated to the three-argument form (as expected
after move_imm changed from taking four parameters to three). However:

build_insn() has a BPF_NEG case just before the BPF_AND case. Can you check
whether it was updated? Looking at the diff hunks: the BPF_MOD | BPF_K case
ends near line 895, and the next hunk starts at BPF_AND | BPF_K near line
918. The BPF_ALU/BPF_ALU64 | BPF_NEG cases fall between these two hunks, so
they would not appear in the diff if they were left unchanged. If the NEG
case still has 'move_imm(ctx, t1, imm, is32);' with four arguments, that
would be a function call with too many arguments and fail to compile.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30326478489
--===============2028487587190646803==--
