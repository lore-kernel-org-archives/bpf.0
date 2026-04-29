Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB463F077B
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777463873; cv=none; b=sVv2PHJmU8zwsANgoTeJhYXpK6KSiQ+p99yyqYm2UnyFJ3y7uJlCG6DpCaOjvCUOco2AkdCncutiZSF8XNyZ8ZkJl/5ZYVajKpvZQzwTAt1y7XKbbhQ+V2uJw0XEeE0i8oNoovKFUpkk5SQ2Xe3/H2bJlzQyg8h8ptV1LAl9kFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777463873; c=relaxed/simple;
	bh=pdn+AkY8bW50TrgcAAV4i1IuSf0bty1nzLmh/Gyioqo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rs2WbAnlwv5TrNUNgIGusUZ5SA1NWHPUGzRwH4dCweiImjzbyLu3kiBXk/bSeTFo374HstiH2cDWFUa6CpCfLbtfld7at8pjkmsgTtYzLHvUuBLbT7cx4tF77N76/8prRVagopKRA8PARfAHUI6GKmoDMYxulbr3Q20O0bXg9oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx03F00H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx03F00H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09799C19425;
	Wed, 29 Apr 2026 11:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777463872;
	bh=pdn+AkY8bW50TrgcAAV4i1IuSf0bty1nzLmh/Gyioqo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Vx03F00HWosl4+yvVepv+JWdofkdn7Y8Tw+eNI6tA+njc9L4CdplsTtdB0XKqBzRm
	 DZMp8zkH8QqEMZpilF/2wi+H3u1t2+9h8DCtUzZReADVzN4fz+51oP0z3oWiTSkJ22
	 sR+z+tQELQ/NZoG0esvE5G8c8JqgnNtAAraVa8B331H1rcw0dQF7GzSRiUTAR3IxW+
	 N2uWOuyzSCMB8oxa9tmXSO0h66ZyJtcVnDF9zIV9Tzq+BqnLY72tLR5oKRLrwyJDr0
	 Y95gQRr2NiVacjg3FQ27V1Cy6OCmdUZsx4OUGXZxOLGVAmLNAq22iefcLTOvZbZwDN
	 9AzsXLs5VBo9w==
Content-Type: multipart/mixed; boundary="===============4518827398568603776=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4c8081076c40ee589523fd56267a00b0c7f18cb409fd11a8b285bcd87849bd61@mail.kernel.org>
In-Reply-To: <20260429105608.92741-3-tangyazhou@zju.edu.cn>
References: <20260429105608.92741-3-tangyazhou@zju.edu.cn>
Subject: Re: [PATCH bpf-next v8 2/3] bpf: Fix s16 truncation for large bpf-to-bpf call offsets
From: bot+bpf-ci@kernel.org
To: tangyazhou@zju.edu.cn,bpf@vger.kernel.org,ast@kernel.org,eddyz87@gmail.com,emil@etsalapatis.com,puranjay@kernel.org,xukuohai@huaweicloud.com
Cc: daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,ziye@zju.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Apr 2026 11:57:52 +0000 (UTC)

--===============4518827398568603776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index b77d0b06db6e..c4d25d78291b 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1152,9 +1152,6 @@ bool sk_filter_charge(struct sock *sk, struct sk_filter *fp);
>  void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp);
>
>  u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
> -#define __bpf_call_base_args \
> -	((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
> -	 (void *)__bpf_call_base)
>
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog);
>  void bpf_jit_compile(struct bpf_prog *prog);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index fcc881909969..8f7db5f0c7e5 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1771,6 +1771,9 @@ static u32 abs_s32(s32 x)
>  	return x >= 0 ? (u32)x : -(u32)x;
>  }
>
> +static u64 (*interpreters_args[])(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5,
> +				  const struct bpf_insn *insn);
> +
>  /**
>   *	___bpf_prog_run - run eBPF program on a given context
>   *	@regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
> @@ -2077,10 +2080,10 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>  		CONT;
>
>  	JMP_CALL_ARGS:
> -		BPF_R0 = (__bpf_call_base_args + insn->imm)(BPF_R1, BPF_R2,
> +		BPF_R0 = (interpreters_args[insn->off])(BPF_R1, BPF_R2,
>  							    BPF_R3, BPF_R4,
>  							    BPF_R5,
> -							    insn + insn->off + 1);
> +							    insn + insn->imm + 1);
>  		CONT;
>
>  	JMP_TAIL_CALL: {

[ ... ]

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 300e4e251931..8947ef74f6a8 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1250,9 +1250,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  		}
>  		if (!bpf_pseudo_call(insn))
>  			continue;
> -		insn->off = env->insn_aux_data[i].call_imm;
> -		subprog = bpf_find_subprog(env, i + insn->off + 1);
> -		insn->imm = subprog;
> +		insn->imm = env->insn_aux_data[i].call_imm;
> +		subprog = bpf_find_subprog(env, i + insn->imm + 1);
> +		insn->off = subprog;
>  	}
>
>  	prog->jited = 1;
> diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
> index e3785f9a697d..df43a0e0023f 100644
> --- a/tools/bpf/bpftool/cfg.c
> +++ b/tools/bpf/bpftool/cfg.c
> @@ -142,7 +142,7 @@ static bool cfg_partition_funcs(struct cfg *cfg, struct bpf_insn *cur,
>  			continue;
>  		if (cur->src_reg != BPF_PSEUDO_CALL)
>  			continue;
> -		func = cfg_append_func(cfg, cur + cur->off + 1);
> +		func = cfg_append_func(cfg, cur + cur->imm + 1);
>  			return true;
>  	}

A previous reviewer noted in v7 that while this change correctly updates
the call offset calculation from cur->off to cur->imm, there's a related
issue in cfg_partition_funcs() that appears unaddressed.

After the patch, when JIT is enabled and programs are exported as
translated, insn->off now holds the subprogram index rather than the jump
offset. The cfg_partition_funcs() function uses this to calculate the
target subprogram start for control-flow graph generation.

Since this code path processes JIT-enabled translated programs where
insn->off is now a subprogram index (not an offset), does the calculation
'cur + cur->imm + 1' correctly identify the target instruction? Or does
it need to look up the subprogram's actual address using the index stored
in cur->off?

This could affect "bpftool prog dump xlated visual" and potentially cause
corrupted graphs or out-of-bounds memory access.

Reference: https://lore.kernel.org/bpf/20260421204648.B573FC2BCB0@smtp.kernel.org/

[ ... ]

> diff --git a/tools/testing/selftests/bpf/disasm_helpers.c b/tools/testing/selftests/bpf/disasm_helpers.c
> index f529f1c8c171..96b1f2ffe438 100644
> --- a/tools/testing/selftests/bpf/disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/disasm_helpers.c
> @@ -4,7 +4,6 @@
>  #include "disasm.h"
>
>  struct print_insn_context {
> -	char scratch[16];
>  	char *buf;
>  	size_t sz;
>  };

The commit message states this patch series includes a selftest
(tools/testing/selftests/bpf/progs/call_large_imm.c) to verify the fix.

A reviewer raised a concern in v7 about the test design: the selftest
reportedly causes a kernel panic on unpatched kernels when JIT is disabled.
While reproducing the bug validates the fix, this behavior is disruptive
for CI systems and git bisect workflows that run the test suite on older
or unpatched kernel trees.

The reviewer suggested redesigning the test to fail gracefully. If the
large padding block were placed before the call instruction instead of
after it, the call site would be at a large positive offset. When the bug
triggers and the offset gets truncated to a negative value (e.g., -32768),
the jump would land safely inside the valid padding instructions rather
than jumping out of bounds and crashing the kernel.

Was this concern addressed in v8? The current disasm_helpers.c changes
don't appear related to this test design issue.

Reference: https://lore.kernel.org/bpf/20260421210253.5AB2AC2BCB0@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25105802774
--===============4518827398568603776==--
