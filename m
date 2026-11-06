Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939916;
	b=ego1JnIinJ667GsMjjp2H/NQEbwPtw/QELBx/xXS/5uOuqQnD0l2fbxXUKWqpK+9sNP8
	 +X3t/6XdldC5y/IdSOjIEf2c2RibEMYIHCn9dXX9eMUWOSBnSHF/I8/AVDu7YITArHQqb
	 kIH4yH9N5cZGDg66bLrvEsCjIovQ3D77dfNcaz+IOBRM3wku52QF5vxyGcs6lfwilmSJV
	 mzImm3XM/eZ0CV6cBh7ep3Ih8k+Q8luElDGlb35F9xCUZW0/udnb7bR8/S7xPQcwOtZZA
	 BFwkMRYoXxlomLzssN4emDubMjcWOHrQv2xyDu9LH1kcmVFO6PNNS7E8qa8Twqdtwog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939916;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=yHDyyjRCC7COU9V6N1infrP8W7l9zOY71rTlldikqZo=;
	b=L0lZYqF67HxEUG8fUeVmDcd+i7BcQfbg65kzmyDttpHPOyAT1zW+OxlPaH3LuUxjvSg7
	 xljC4hhliffcyTITkNExEpp3fdPe0cxgzBJ4E+SoBksiYEMjvVBz/PhkkOYuAB5SwgkLf
	 lzXVVvZI4ihyerqgSEMM5plNzMaX18+5OiiQy80SGdzkQTi3mSbVxSJEHV+obord+DLL5
	 fVb2/dX4L6fSAztpSEt8Rng83NblYUo6aQwBZby/l8zTBtNWf98DKoZMxoaBPsvPeBR8X
	 2TKkRseg7yifMKpdJ8wZBYXvVSYKhupzNyrB/kLA88EEHzCi94iUwbF6gPQl/QVhIMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJsWbzXE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C83606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJsWbzXE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAA51F0089F;
	Fri,  6 Nov 2026 04:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939915;
	bh=yHDyyjRCC7COU9V6N1infrP8W7l9zOY71rTlldikqZo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fJsWbzXEZ5EtKD8FSTHwF7uNJg831fCvZgKXABCoY85FhBRnCNSw/OU6LeNcJ8r5f
	 /DW+RPMjZhd1bQbq9Dc35FoRZ020s45uJrFEfd9FKQOVFq+eGIFZw7ZKSujdpqYYFn
	 Xt/Gfvn29rrHBQZ5otgPcZ0dRXVoCYfnxnqe3c8nu6FNqnMdLkEoobpR4OHfkpEK+W
	 ujvc+KdmeDb9V7rRUPvaCm/sx8MQKkbFsB7jYATBoSEW4p6PAYRh99uTMBo5fmQ7y4
	 CkFodEQqfvc2/Q7O2Ki4j51clt8spPgyJDAgjEdrZtqJTPHqpS09OpVYnGpY6lZf7e
	 K4rV7kiKhdnjA==
Content-Type: multipart/mixed; boundary="===============0407885057905434763=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <04a6be16b4612e81d619f21ff0889d54fb4feb8c4fbc5c830c2ff75dc1fdc527@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-14-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-14-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 13/45] bpf: Decide which states are not joined
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:38:35 +0000 (UTC)

--===============0407885057905434763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Decide which states are not joined

TL;DR: flow_flag_regs() in flow.c marks registers tested against 0 or 1 with
any operator (e.g. "if r < 0"), not only those telling 0 from 1; this
needlessly keeps states apart and costs states, though not unsound. Fix
comment or code?

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c

[ ... ]

> @@ -568,6 +569,19 @@ static u16 flow_tested_regs(struct bpf_verifier_env *env, int idx)
>  	return consts & BIT(insn->dst_reg) ? BIT(insn->src_reg) : 0;
>  }
>  
> +/* A jump that compares a register with 0 or 1 */
> +static u16 flow_flag_regs(struct bpf_verifier_env *env, int idx)
> +{
> +	struct bpf_insn *insn = &env->prog->insnsi[idx];
> +
> +	if (BPF_SRC(insn->code) != BPF_K || !bpf_insn_is_cond_jump(insn->code) ||
> +	    BPF_OP(insn->code) == BPF_JCOND)
> +		return 0;
> +	if (BPF_OP(insn->code) == BPF_JSET ? !(insn->imm & 1) : (u32)insn->imm > 1)
> +		return 0;
> +	return BIT(insn->dst_reg);
> +}

[ ... ]

> @@ -953,6 +967,15 @@ static u16 flow_base_regs(struct bpf_verifier_env *env, int idx)
> + * FLOW_NEED_FLAG: those of which a jump tells 0 from 1, see flow_join_makes_up(). As they are,
> + * extended, or masked: a bool is tested as "w1 &= 1; if w1 != 0". Not through a call.

The comment says FLOW_NEED_FLAG holds the registers of which a jump tells 0
from 1, but flow_flag_regs() selects any conditional jump against an
immediate of 0 or 1, whatever the operator.

Eight operator/immediate pairs send 0 and 1 down the same branch: JSLT 0,
JSGE 0, JLT 0, JGE 0, JGT 1, JLE 1, JSGT 1 and JSLE 1.  JSLT/JSGE 0 is the
usual 'if (err < 0)' test.

Take two states that meet where one has the register equal to 0 and the
other equal to 1, with an 'if rX s< 0' in this block or the next.
flow_needed_consts_differ(flow, FLOW_NEED_FLAG, ...) sees
flow_two_consts(..., flag=true) return true, so flow_join_makes_up() keeps
the states apart:

    flow_join_makes_up()
      flow_needed_consts_differ(flow, FLOW_NEED_FLAG, a, b)

The FLOW_NEED_JUMP part would have let them join, and the join [0, 1] makes
up nothing at that jump, because both values take the same branch.

This does not make verification unsound, since the rule only refuses joins,
but it costs states (the commit message prices this rule at 2^K states for K
flags).

Should the comment say 'compares with 0 or 1', or should flow_flag_regs()
leave out the operators for which 0 and 1 go the same way?

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============0407885057905434763==--
