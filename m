Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE260C2FF
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 01:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776474262; cv=none; b=k0UdsBsodPkmCIiRPV9HAuKTehQugy+aEKyD/Tgzved3ElybZynMxVz1g0W+2XDXmmK3G1NG9+KNE/pPVFnHukQqyy1beLxr7SFytmCRA9VkS/oNxgEBoALStopPzUL8hNZBvd2GQQCarW9IJwOo7JDwO8UA4rwnGJNzfKeWcOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776474262; c=relaxed/simple;
	bh=hfo3f++NQ108bC+q0ffX7FruurUFImAe2vFhHyxAWAM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ua0QKehDjKgDEc/ulNz/YbfKzOGybAkx8FORVZHF0dknu56Kdfjv7gjZseDYojQlrBY2+0XWldDvKevurIHN5Q4vxSaNUQbP85gDeFqESVnA0fi54S8vOkqZVTGfGFAwkwJ21XPN6ug2vAVUcGP7h1JoPtF+t2xIGdmHp6z7WZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7vUtI8P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7vUtI8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D75C2BCB3;
	Sat, 18 Apr 2026 01:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776474262;
	bh=hfo3f++NQ108bC+q0ffX7FruurUFImAe2vFhHyxAWAM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=J7vUtI8PrVhXkCNVSsovVS/yBRU1gNHkhUqxbT3894mJDcA5m0pAg1bOg7hvUHQ/1
	 N6PZR4HDYkBwoY5HWIeBAynqevNfdC0CoSb40x1TjW1NEjY3frjo3MFNqF9RUX/b4z
	 aT8zGh/JrLwsO407AqanFITe9+eWyjoHXjcz+3IYQbLAp2aZw5T/yzwzntupgZ5Tvj
	 WLNeeRyAVwuOA3RfqJaLGZnwL7achxY8ub+JITP2gb7EIE2uiS9ksAcWo36pAHKceW
	 Qw/8LRlGVs34V/9png1UP3PNuJb1hiEGpn8kWB+oK8TKD5y2KLHx/jFg/63sqIFm7/
	 Tvo2QeZixrM1A==
Content-Type: multipart/mixed; boundary="===============7393726217623599261=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eceac116558df04030d5f5dd6574f19bac5b65b539bb941fdf69484efe33933f@mail.kernel.org>
In-Reply-To: <20260417034729.2629367-1-yonghong.song@linux.dev>
References: <20260417034729.2629367-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 06/16] bpf: Limit the scope of BPF_REG_PARAMS usage
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 01:04:22 +0000 (UTC)

--===============7393726217623599261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> --- a/kernel/bpf/const_fold.c
> +++ b/kernel/bpf/const_fold.c
> @@ -51,13 +51,18 @@ static void const_reg_xfer(struct bpf_verifier_env *env, struct const_arg_info *ci_out,
>  			   struct bpf_insn *insn, struct bpf_insn *insns, int idx)
>  {
>  	struct const_arg_info unknown = { .state = CONST_ARG_UNKNOWN, .val = 0 };
> -	struct const_arg_info *dst = &ci_out[insn->dst_reg];
> -	struct const_arg_info *src = &ci_out[insn->src_reg];
> +	struct const_arg_info *dst, *src;
>  	u8 class = BPF_CLASS(insn->code);
>  	u8 mode = BPF_MODE(insn->code);
>  	u8 opcode = BPF_OP(insn->code) | BPF_SRC(insn->code);
>  	int r;
>
> +	/* Stack arguments using BPF_REG_PARAMS are outside the tracked register set. */
> +	if (insn->dst_reg >= MAX_BPF_REG || insn->src_reg >= MAX_BPF_REG)
> +		return;
> +
> +	dst = &ci_out[insn->dst_reg];
> +	src = &ci_out[insn->src_reg];

If we return early here during a BPF_LDX instruction where src_reg is
BPF_REG_PARAMS (11), doesn't this skip necessary state updates for
dst_reg (e.g., registers 0 through 9)?

Since dst_reg is not marked as unknown, won't it retain its stale
tracking state? Could bpf_prune_dead_branches() rely on this stale
constant to incorrectly rewrite conditional jumps, allowing verifier
safety checks to be bypassed?

A similar issue exists in liveness.c where the early return skips
clearing the arg_track state for the destination register when loading
from a stack argument.

>  	switch (class) {
>  	case BPF_ALU:
>  	case BPF_ALU64:

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
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

Can these instructions with BPF_REG_PARAMS trigger out-of-bounds
accesses in subsequent verification functions?

The regs array in struct bpf_func_state is declared as
regs[MAX_BPF_REG] with MAX_BPF_REG=11, giving valid indices 0-10.

When instructions with src_reg=BPF_REG_PARAMS (11) reach
check_load_mem():

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

The fix appears to arrive in subsequent commit 212295359353. Between
this commit and that fix, could user-provided BPF programs with
BPF_REG_PARAMS instructions trigger out-of-bounds memory access in the
kernel verifier?

>  		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
>  			struct bpf_insn_aux_data *aux;

[ ... ]

This commit fixes a bug but lacks a Fixes: tag. The commit prevents
out-of-bounds array accesses when BPF_REG_PARAMS is used as an index in
array-based register tracking. The bug was introduced when
BPF_REG_PARAMS was added as MAX_BPF_REG without adding bounds checks.

Suggested: Fixes: fa38458af04a ("bpf: Introduce bpf register BPF_REG_PARAMS")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564
--===============7393726217623599261==--
