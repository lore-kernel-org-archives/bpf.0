Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA453630BC
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 03:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775014725; cv=none; b=RNiac5wtRuHnge75I1I/2+MY5KyYvFHoEhC9vcEje2Pp7COXxQHJeb3YWqfLS0LSRbNTyOINngW1qun3HTnFo3fw4kdLAJ1VYLnuyDt8cf/EfNGzyLcHCcGL5fmjqLIYR4I4UcKY21zWVqxi2YAGgHbKVf1TLqvZVsfpKiP5iBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775014725; c=relaxed/simple;
	bh=5RY38Vlcw52b9Kmt2GKopnotR1X7JySt1HTNOGAD9fM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=F636RnhGdoSiKy84Y37fv0ZnTp2OvtJIZfaoJmA3b83jiuctDUtJdMXsKrpnmyGcVKmk3uuqV5bQUJAZJgr09trvRTjbR/YnjbfYsahefPp4yBQ51b7F/NZYFNSrzqHI4yDazHM0gEDG+ZseDMfeFdGNEGDQ6Sw0cLWdc9bEEdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uB/u2fZC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uB/u2fZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B446CC4CEF7;
	Wed,  1 Apr 2026 03:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775014725;
	bh=5RY38Vlcw52b9Kmt2GKopnotR1X7JySt1HTNOGAD9fM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=uB/u2fZCJgD+hHgg9EQpqOAVBJR7+A/Q5BnbxlRJX4DWhbSDAilIKSmJD/XCzfZnw
	 a/oy4HuMVJFSnQdat8iFmKNm36rteDIi0NJOTZKYL+SN2Ooi1KqcjymV+Ui7HN5fmD
	 Ed25X7lWJm1AiRlP215O3Em2vItsBDlLfVabyfyM9FwP3gzoOeK/IME7nt6LKZwBw3
	 Uu/G5ohV5JRRJNcUhszE6u2OKrAfPbsXeGIUtpOurMEe9UMqHQeuhbaJpRWXykMMTp
	 +xlZEF0Yd0nFCeTxJkVKSuBvzfRbcwWUQUNRnxcfkrbGRsNVzT2f0JRHUVEzyfK4Ey
	 BzAdsF1PKhwNA==
Content-Type: multipart/mixed; boundary="===============3742509769056409801=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7d2a686a5bae52a650a378e26d84ccdee3cec258044119a1183c4fbda16dae8e@mail.kernel.org>
In-Reply-To: <20260401021635.34636-2-alexei.starovoitov@gmail.com>
References: <20260401021635.34636-2-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: Do register range validation early
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,memxor@gmail.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Apr 2026 03:38:44 +0000 (UTC)

--===============3742509769056409801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... mark_reg_known_zero, mark_reg_unknown, mark_reg_not_init
      WARN_ON guards removed ... ]

> @@ -3957,11 +3936,6 @@ static int __check_reg_arg(...)
>  	struct bpf_insn *insn = env->prog->insnsi + env->insn_idx;
>  	struct bpf_reg_state *reg;
>  	bool rw64;
> -
> -	if (regno >= MAX_BPF_REG) {
> -		verbose(env, "R%d is invalid\n", regno);
> -		return -EINVAL;
> -	}
>
>  	mark_reg_scratched(env, regno);

[ ... ]

> @@ -22070,6 +22044,14 @@
> 			verbose(env, "unknown opcode %02x\n", insn->code);
> 			return -EINVAL;
> 		}
> +		if (insn->dst_reg >= MAX_BPF_REG) {
> +			verbose(env, "R%d is invalid\n", insn->dst_reg);
> +			return -EINVAL;
> +		}
> +		if (insn->src_reg >= MAX_BPF_REG) {
> +			verbose(env, "R%d is invalid\n", insn->src_reg);
> +			return -EINVAL;
> +		}
>  	}

These new checks are placed after the BPF_LD_IMM64 handling block
in resolve_pseudo_ldimm64(). That block exits via the next_insn
label:

    next_insn:
            insn++;
            i++;
            continue;

The continue skips the new dst_reg/src_reg validation for
BPF_LD_IMM64 instructions. Since insn->dst_reg is a 4-bit
field (range 0-15) and MAX_BPF_REG is 11, could a crafted
BPF_LD_IMM64 instruction with dst_reg >= 11 reach
check_ld_imm() without ever being validated?

check_ld_imm() passes insn->dst_reg to check_reg_arg(),
which calls __check_reg_arg(), where the bounds check was
removed by this patch. That leads to regs[regno] with
regno >= MAX_BPF_REG, which is an out-of-bounds access on
struct bpf_func_state.regs[MAX_BPF_REG].

The fields immediately after regs[] in bpf_func_state are
callsite, frameno, and subprogno, so the OOB write would
corrupt verifier state.

Would it make sense to add the dst_reg/src_reg validation
inside the BPF_LD_IMM64 block, or move the new checks above
that block so they apply to all instructions?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23828931033
--===============3742509769056409801==--
