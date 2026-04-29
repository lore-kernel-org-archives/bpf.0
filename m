Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA1A3F54AA;
	Wed, 29 Apr 2026 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468408; cv=none; b=mcfN2fErG4PcmtXwcfAH6gfU+fF2nxmnotOS2nSlFp8tmLwIi6j04itfrVAVgTITdoPDgWAzoIklYGISmC0RPYYZDPMsuA5nSjnN+88C9qBN9Ek3oZIHeqMyEHSFuVN6zu4vy6bqtlYwDzO33zbE124BHfl/hiZCsY6asj+mjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468408; c=relaxed/simple;
	bh=IVUujablr4MgQBnJMVr/PI5mqLf/UiwDGu7fRHBTPhs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=R/Lm84w++ziU6DodZfoUWZ4a+WAG4Jvq21JX/XCKLeaQFN7HYnIFK/nzjiyiJ/KmqFddTvUcAc0jVy9+Pkvd49aG4AT3m7+4P8n9s/JSj4PwtKmSHYTp3Oau7f5uc4323zFxyl4JgZNsFk0ATF4QbiuyyeTVqpKvWzWL5/AOUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbShTKQA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbShTKQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B99C19425;
	Wed, 29 Apr 2026 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468407;
	bh=IVUujablr4MgQBnJMVr/PI5mqLf/UiwDGu7fRHBTPhs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ZbShTKQA+Z/1J33zT7I9IGOwp4IiZ+EBhHsxSQDLTGAKPE13cno2WDMvPKVLy60MG
	 ghejryKO8DyR6Cxkg+yRfG7nTri3HGFO3DdmfMlseful2EnEnRN1YweYqSFVvZ0D77
	 0Pl0Y6fU0R0mVWbG/TWbwOmUYH6+y9KjY+8eF4mghYxeeG1FIZEGAqtBXOBpxfMJk5
	 t4hB2zExcfIjS31njE1oP+DE/4av6YBBa2Z66ck4X2IEtOQ6iR6GEVHGzvnKu8q+3p
	 PQ+e1dfX9pwHjKpXVFKLauR+FqPPyV8l+sTFyfo1dd2lhQsFY1E9YS8qKDNAT+ZDB2
	 XsJEib2tJ0DTg==
Content-Type: multipart/mixed; boundary="===============6202103066093586817=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6e8625d76aa00e21260cbed92fdc217191ab162f42a4544aadd75c49f3242ec3@mail.kernel.org>
In-Reply-To: <20260429123513.3477780-2-visitorckw@gmail.com>
References: <20260429123513.3477780-2-visitorckw@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] riscv, bpf: Fix support for BPF_SDIV and BPF_SMOD in RV32 JIT
From: bot+bpf-ci@kernel.org
To: visitorckw@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,luke.r.nels@gmail.com,xi.wang@gmail.com,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,alex@ghiti.fr,jserv@ccns.ncku.edu.tw,eleanor15x@gmail.com,marscheng@google.com,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,visitorckw@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Apr 2026 13:13:27 +0000 (UTC)

--===============6202103066093586817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
> index 592dd86fbf81..7396899ea276 100644
> --- a/arch/riscv/net/bpf_jit_comp32.c
> +++ b/arch/riscv/net/bpf_jit_comp32.c
> @@ -509,7 +509,7 @@ static void emit_alu_r64(const s8 *dst, const s8 *src,
>  }
>
>  static void emit_alu_r32(const s8 *dst, const s8 *src,
> -			 struct rv_jit_context *ctx, const u8 op)
> +			 struct rv_jit_context *ctx, const u8 op, bool is_sdiv)
>  {
>  	const s8 *tmp1 = bpf2rv32[TMP_REG_1];
>  	const s8 *tmp2 = bpf2rv32[TMP_REG_2];
> @@ -539,10 +539,16 @@ static void emit_alu_r32(const s8 *dst, const s8 *src,
>  		emit(rv_mul(lo(rd), lo(rd), lo(rs)), ctx);
>  		break;
>  	case BPF_DIV:
> -		emit(rv_divu(lo(rd), lo(rd), lo(rs)), ctx);
> +		if (is_sdiv)
> +			emit(rv_div(lo(rd), lo(rd), lo(rs)), ctx);
> +		else
> +			emit(rv_divu(lo(rd), lo(rd), lo(rs)), ctx);
>  		break;
>  	case BPF_MOD:
> -		emit(rv_remu(lo(rd), lo(rd), lo(rs)), ctx);
> +		if (is_sdiv)
> +			emit(rv_rem(lo(rd), lo(rd), lo(rs)), ctx);
> +		else
> +			emit(rv_remu(lo(rd), lo(rd), lo(rs)), ctx);
>  		break;
>  	case BPF_LSH:
>  		emit(rv_sll(lo(rd), lo(rd), lo(rs)), ctx);
> @@ -959,6 +965,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>  	u8 code = insn->code;
>  	s16 off = insn->off;
>  	s32 imm = insn->imm;
> +	bool is_sdiv = false;
>
>  	const s8 *dst = bpf2rv32[insn->dst_reg];
>  	const s8 *src = bpf2rv32[insn->src_reg];
> @@ -1041,7 +1048,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>  			emit_imm32(tmp2, imm, ctx);
>  			src = tmp2;
>  		}
> -		emit_alu_r32(dst, src, ctx, BPF_OP(code));
> +		if ((BPF_OP(code) == BPF_DIV || BPF_OP(code) == BPF_MOD) && insn->off == 1)
> +			is_sdiv = true;
> +		emit_alu_r32(dst, src, ctx, BPF_OP(code), is_sdiv);
>  		break;
>
>  	case BPF_ALU | BPF_MOV | BPF_K:
> @@ -1065,7 +1074,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>  		 * src is ignored---choose tmp2 as a dummy register since it
>  		 * is not on the stack.
>  		 */
> -		emit_alu_r32(dst, tmp2, ctx, BPF_OP(code));
> +		emit_alu_r32(dst, tmp2, ctx, BPF_OP(code), false);
>  		break;
>
>  	case BPF_ALU | BPF_END | BPF_FROM_LE:


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25109627626
--===============6202103066093586817==--
