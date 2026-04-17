Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662B3624B9
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 04:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400212; cv=none; b=DjaY0xu6xx9WBGyYFXTQwKZPn02OHaw4F2Zpgb4OUDjIwg2a3fZO3l1eCnRwaNvnzEUiuUy6tAmQpe7gLJ8IOlAYEr9HyUfjx6VjbsswHfXXi7RKyFX1mpueHuCrYwUV7BX4ZrKbsHUBa8ebW9bKwgQDm0AumlCVw0sgrXf6bgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400212; c=relaxed/simple;
	bh=jvFCxOtcKkhJ78fU8G7YXtTmwlKsOGpmfKv12NDwFVQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=h7qZNVUdQDaD0F/Kiv5waUXxOOIy3oQKYO1SWFz+NrlPuQf2r7MhofYnPZOevYDVvbcU3XDTo1FU+lpPMHBHIuxNn1cHiOkGjprUKN8bwQBQVo8lBA+vfATHB8XqvpeO+A6rzswq/uh8AcwV5a6GIAICkvCEb7V0kzugN3cn8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgnKx310; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgnKx310"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEE3C19425;
	Fri, 17 Apr 2026 04:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776400212;
	bh=jvFCxOtcKkhJ78fU8G7YXtTmwlKsOGpmfKv12NDwFVQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=kgnKx3104s2fJbEsytxg3X3ZT+g9jxS32Xz8wneMMRsNnNarOjOyUNvQgVc9H+za7
	 x8B1QuKfAb3flk9s2h/gMmCmVyWydqOqqyfVdptKAlDCvmzwhSq/XjfTYFsasHKXNA
	 uLqlCSeKBBBN4+wHq98BmrXnuh2dncbIxv7KJ7jkNB4x/esgNEFeeHN2PXpISlEn5+
	 PuZ25abX1r1RnNsUfPNRIgimc7YCeqeBOMJG9+y9DLwqx4ist+y8rDIjRQdLA/vKHR
	 MRER6ksMvO3GrFGyEbHfMvzif5sUPxXtiGTjjIqkHJ2/dGT6cq9Dp1wtdNYMrBYeSt
	 08RGruM9yD5gA==
Content-Type: multipart/mixed; boundary="===============3911593946012350801=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0384d4ba23e7f159c6e80c79a64b4dcd2186fa97b53ae7b2eb721a9cd3156775@mail.kernel.org>
In-Reply-To: <20260417034729.2629367-1-yonghong.song@linux.dev>
References: <20260417034729.2629367-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 06/16] bpf: Limit the scope of BPF_REG_PARAMS usage
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 04:30:12 +0000 (UTC)

--===============3911593946012350801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> index db73c4740b1e..09db7fdb370f 100644
> --- a/kernel/bpf/const_fold.c
> +++ b/kernel/bpf/const_fold.c

[ ... ]

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 1fb4c511db5a..993d7e543e9f 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ff0c55d80311..f25a56cfabac 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18487,13 +18487,22 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
>  		return err;
>
>  	for (i = 0; i < insn_cnt; i++, insn++) {
> +		u8 class = BPF_CLASS(insn->code);
> +		u8 mode = BPF_MODE(insn->code);
> +
>  		if (insn->dst_reg >= MAX_BPF_REG) {
> -			verbose(env, "R%d is invalid\n", insn->dst_reg);
> -			return -EINVAL;
> +			if (insn->dst_reg != BPF_REG_PARAMS ||
> +			    !((class == BPF_ST  || class == BPF_STX) && mode == BPF_MEM)) {
> +				verbose(env, "R%d is invalid\n", insn->dst_reg);
> +				return -EINVAL;
> +			}
>  		}
>  		if (insn->src_reg >= MAX_BPF_REG) {
> -			verbose(env, "R%d is invalid\n", insn->src_reg);
> -			return -EINVAL;
> +			if (insn->src_reg != BPF_REG_PARAMS || class != BPF_LDX ||
> +			    mode != BPF_MEM) {
> +				verbose(env, "R%d is invalid\n", insn->src_reg);
> +				return -EINVAL;
> +			}
>  		}
>  		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
>  			struct bpf_insn_aux_data *aux;

Can these instructions with BPF_REG_PARAMS trigger out-of-bounds accesses
in subsequent verification functions? The regs array in struct
bpf_func_state is declared as regs[MAX_BPF_REG] with MAX_BPF_REG=11,
giving valid indices 0-10.

When instructions with src_reg=BPF_REG_PARAMS (11) reach check_load_mem():

kernel/bpf/verifier.c:check_load_mem() {
    ...
    src_reg_type = regs[insn->src_reg].type;
    ...
}

This performs regs[11] which is one past the end of the array.

Similarly, when instructions with dst_reg=BPF_REG_PARAMS reach
__check_reg_arg():

kernel/bpf/verifier.c:__check_reg_arg() {
    ...
    reg = &regs[regno];
    ...
}

The commit message states "array-based register tracking indexed by
register number would cause out-of-bounds accesses. So do early return
if needed." However, the patch adds early returns in const_fold.c and
liveness.c but not in the main verification path functions like
check_load_mem() or __check_reg_arg().

The fix appears to arrive in subsequent commit 212295359353 ("bpf:
Support stack arguments for bpf functions"). Between this commit and
that fix, could user-provided BPF programs with BPF_REG_PARAMS
instructions trigger out-of-bounds memory access in the kernel verifier?

This commit also lacks a Fixes: tag. The suggested tag would be:

Fixes: 595885eced33 ("bpf: Introduce bpf register BPF_REG_PARAMS")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24546989054
--===============3911593946012350801==--
