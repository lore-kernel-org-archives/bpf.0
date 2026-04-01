Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586B82C21E6
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 03:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775015376; cv=none; b=mHM0D6IwL9tQQvOkzSc7p4RmXGVFD/l8RvrGHLgTyOptEHH8PPTj2AKMpU9U7wmxUBsTsuwRMT8K2o6FFQoguDcXf9QfkegzxFkVXSiglrUUjak4gnSqQpq1J/NrIT7h4zgyT97AQyCbmxx8DbP4ZIyypWiKX/5bo671x3R3lYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775015376; c=relaxed/simple;
	bh=44322AcTWUKPKpAt9NA+9e5JyUG1N7XWv2hG468Aezk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ofz+Z6SrQhkqj5kFGoLm+yKdmhA5LXNfR2oQnoORa1Nx8i8+gK4ZM63E3zg9qLwcArSAJDJ6X9d48ERuEuG2/qX6zqGrQmtbjCyrLZOgmNGlIs8eCPOy4qNbhNKXI7MwKe3BdNRPmqK286ja66fKsCzu5ne/uZuMSdzVgcLhXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQZKdo7e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQZKdo7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B925FC4CEF7;
	Wed,  1 Apr 2026 03:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775015376;
	bh=44322AcTWUKPKpAt9NA+9e5JyUG1N7XWv2hG468Aezk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=nQZKdo7eHJ9qPyp5NNR0epVPCLyCYQUyp9afjj1d4UCt1tcs00Hc0w+E5JnKcWBmF
	 FS0LSMr0IivfoJtE6JSpkiCeVh1IKEVkcaR786SvHfSYw/F53zPnsVpclLWtu/7tT4
	 z78h62c6OzGu7glsC97yXdjyhrGopPtEXQ+uJXP1if611JyD9fHWCzN1xhjEo/6ytE
	 uWtxl+xXz6n7PyF9519Rv3lhIwgwfS50+IORuRVDQ7XX+KwX//IK0ssZ6BSr6DG6rs
	 sqpVrKU28W02arr6zU/ODLBzrIOX1aOZMhvLA3L59NsLlloNZxBfB+Q9+/3vFrTXic
	 kbA78GKw/CSHw==
Content-Type: multipart/mixed; boundary="===============2552787901460480277=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2db51a83b7dcd83a4d5d0d23c5c01807a7ab4b07888976731aa0ba404a2d68ff@mail.kernel.org>
In-Reply-To: <20260401021635.34636-5-alexei.starovoitov@gmail.com>
References: <20260401021635.34636-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 4/6] bpf: Add compute_const_regs() and prune_dead_branches() passes
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,memxor@gmail.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Apr 2026 03:49:35 +0000 (UTC)

--===============2552787901460480277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> new file mode 100644
> index 000000000000..9e5abc6ab46a
> --- /dev/null
> +++ b/kernel/bpf/const_fold.c

[ ... ]

> +	/* Save computed constants into insn_aux[] if they fit into 32-bit */
> +	for (i = 0; i < insn_cnt; i++) {
> +		u16 mask = 0, map_mask = 0, subprog_mask = 0;
> +		struct bpf_insn_aux_data *aux = &insn_aux[i];
> +		struct const_arg_info *ci = ci_in[i];
> +
> +		for (r = BPF_REG_0; r < MAX_BPF_REG; r++) {

The loop iterates r from 0 to MAX_BPF_REG - 1 (= 10), but
const_reg_vals[] in bpf_insn_aux_data is declared with 10 elements
(indices 0-9).  When r == 10 and the register happens to be tracked
as a constant, this writes past the end of const_reg_vals[]:

> +			switch (c->state) {
> +			case CONST_ARG_CONST: {
> +				u64 val = c->val;
> +
> +				if (val != (u32)val)
> +					break;
> +				mask |= BIT(r);
> +				aux->const_reg_vals[r] = val;

Would this overflow const_reg_vals[] when r is BPF_REG_10?
The array has 10 entries but the loop goes up to 10 inclusive.

Since compute_const_regs() runs before the main verifier pass,
register numbers in instructions haven't been validated yet.  A
crafted program with dst_reg = BPF_REG_FP in an ALU instruction
would cause the analysis to track R10 as a constant, then
write one element past the array into the next instruction's
bpf_insn_aux_data.

Similarly, in const_reg_xfer():

> +	struct const_arg_info *dst = &ci_out[insn->dst_reg];
> +	struct const_arg_info *src = &ci_out[insn->src_reg];

ci_out is a stack-local array of MAX_BPF_REG (11) elements, but
dst_reg/src_reg are 4-bit fields that can hold values 0-15.
Could instructions with register values above 10 cause an
out-of-bounds access on the stack before the verifier rejects them?

[ ... ]

> +int prune_dead_branches(struct bpf_verifier_env *env)
> +{

[ ... ]

> +		if (BPF_SRC(insn->code) == BPF_K) {
> +			src_val = (u32)insn->imm;

For 64-bit JMP instructions (BPF_JMP class) with BPF_K source, the
BPF interpreter sign-extends the 32-bit immediate to 64 bits:

kernel/bpf/core.c, COND_JMP macro:
    JMP_##OPCODE##_K:
        if ((SIGN##64) DST CMP_OP (SIGN##64) IMM) {

where IMM is insn->imm (s32), so (u64) IMM and (s64) IMM both
sign-extend.

Here the cast (u32)insn->imm zero-extends instead.  For negative
immediates these produce different 64-bit values.  For example,
with imm = -1:

    (u32)(-1) = 0x00000000FFFFFFFF  (what prune_dead_branches uses)
    (s64)(s32)(-1) = 0xFFFFFFFFFFFFFFFF  (what the interpreter uses)

A concrete case: r1 = 0, then "if r1 s> -1 goto target":

    interpreter: (s64)0 > (s64)(-1) = true, branch taken
    prune_dead_branches: (s64)0 > (s64)0xFFFFFFFF = false, not taken

The branch would be incorrectly rewritten to fall-through, and the
jump target becomes dead code.  This also affects unsigned comparisons
when both operands happen to match at 32 bits -- for instance
JGE with dst_val = 0xFFFFFFFF and imm = -1:

    interpreter: 0xFFFFFFFF >= 0xFFFFFFFFFFFFFFFF = false
    prune: 0xFFFFFFFF >= 0xFFFFFFFF = true

Should this be sign-extended to match the interpreter, something like
src_val = insn->imm (relying on the implicit s32 to u64 conversion)?
The JMP32 path already handles this correctly via the subsequent
(s32) cast.

> +		} else {
> +			if (!(aux->const_reg_mask & BIT(insn->src_reg)))
> +				continue;
> +			src_val = aux->const_reg_vals[insn->src_reg];
> +		}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23828931033
--===============2552787901460480277==--
