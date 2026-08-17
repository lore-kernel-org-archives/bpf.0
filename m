Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC0305665;
	Mon, 17 Aug 2026 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931556; cv=none; b=Jmhdee9JwXli/qmAAybI90n6EfB7SXwJBRkx9yEBtZy+8fyyme+j0coZCHRXZy6tU08g9DhoBlx+YXcJ7gJpoAGApfS+RPTh40jCp6QTuit75iLOC96PI8yIGb7tx159mvRGfdNAESaDe4SS9KWMeLYrRWn0RRjTd4O2c4jDMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931556; c=relaxed/simple;
	bh=Em5+JleXmfQ+tSKIywginRF4M4++sM3CUoEfoqJB7OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OXA6dWqJfYdSRLwzlOppXMKMTTICNRFl5MqEplYj09Le+VYMpYXf3EfGZ7LihnbpHCo36pFfy0bW+joct8NmHiouqc9IdgWlLoemJnBp/aE5u27NnsW1J2+Fvy+MQ3696WORDSRKEpw8CgT6SfvSnwZpgPYmZaDrxXu/QsfCAvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ofTbkbQt; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ofTbkbQt"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IJmVtDUb7XIXFtur5WMo0s7yV4lH1fkofPtZwxK+itg=;
	b=ofTbkbQtdBBQ+yJPEy7FUu3xAYwE6iKLjhMprk41MzSXuZE4ws9IDxxr2ddP/XGp9vE+py+m1
	T66MFV6wW8yPCmERJgPJMfMkhY8q2tqW6q1HKgVerDvDNfiXss+HL+vPMJ0EQ4HHXEV9MG1BPpK
	pq6Ru4C4y3wD4g0YzBhjvX0=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hNbCq1p5wz1cyPY;
	Mon, 17 Aug 2026 09:41:43 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F9A940578;
	Mon, 17 Aug 2026 09:52:22 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 17 Aug
 2026 09:52:21 +0800
Message-ID: <729d2110-20b2-4e63-af44-99ca8cebdbfd@huawei.com>
Date: Mon, 17 Aug 2026 09:52:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf, riscv: Add BPF stack arguments
 support for RV64 JIT
Content-Language: en-US
To: Feng Jiang <jiangfeng@kylinos.cn>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang
	<xi.wang@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
CC: <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20260814-bpf-riscv-stack-args-v3-0-2160de56fea3@kylinos.cn>
 <20260814-bpf-riscv-stack-args-v3-1-2160de56fea3@kylinos.cn>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260814-bpf-riscv-stack-args-v3-1-2160de56fea3@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100007.china.huawei.com (7.202.181.221)

Hi Feng Jiang,

On 2026/8/14 9:29, Feng Jiang wrote:
> Add bpf_jit_supports_stack_args() for the RV64 JIT so BPF subprograms
> and kfuncs can receive more than 5 arguments via the stack
> (BPF_REG_PARAMS / r11).
> 
> For BPF-to-BPF calls the caller writes outgoing arguments at the
> bottom of its frame (SP-relative). The callee reads them with
> FP-relative loads. Its FP is set to the caller SP in the prologue,
> so the offsets match.
> 
> The RISC-V ABI puts arguments 6-8 in A5-A7 and arguments 9+ at
> SP+0. Before each kfunc call, load arguments 6-8 from the outgoing
> area into A5-A7 and copy any remaining arguments down so argument 9
> lands at SP+0.

bpf2bpf calls pass extra arguments entirely on the stack, whereas kfuncs 
pass them via a mix of registers and the stack. This inconsistency not 
only wastes stack slots in kfunc scenarios but is also error-prone and 
easy to overlook during maintenance.

To make argument passing more straightforward and consistent, I think we 
can align it with the standard riscv calling convention: use a0-a7 for 
the first 8 arguments and pass any remaining arguments on the stack.

To support this, the current bpf-to-rv register mapping needs to be revised:

T0 -> BPF_REG_0 (ftrace use T0 too, but it might not be an issue / needs 
verification)
T6 -> TCC
T7 -> BPF_REG_AX (rarely used, so let's move to t7)

Note that this remapping affects multiple places and requires careful 
auditing.

> 
> A5 (BPF_REG_0), A6 (TCC) and A7 are safe to clobber here: R0 is not
> live before a call, TCC is backed up on the stack, and A7 is unused
> by the JIT.



> 
> Limit the existing kfunc sign-extension loop to MAX_BPF_FUNC_REG_ARGS
> iterations; otherwise idx >= 5 resolves to S1-S5 (BPF_R6-FP) and
> corrupts callee-saved registers.
> 
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
> ---
>   arch/riscv/net/bpf_jit.h        |  1 +
>   arch/riscv/net/bpf_jit_comp64.c | 79 +++++++++++++++++++++++++++++++++++++++--
>   arch/riscv/net/bpf_jit_core.c   |  4 +++
>   3 files changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 419b9d795f2a..9eb4e149505d 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -82,6 +82,7 @@ struct rv_jit_context {
>   	unsigned long flags;
>   	int stack_size;
>   	int tcc_offset;
> +	u16 stack_arg_size;
>   	u64 arena_vm_start;
>   	u64 user_vm_start;
>   };
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 6b9972b07c1b..58cb3e5ff6b4 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1815,18 +1815,43 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   
>   		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>   			const struct btf_func_model *fm;
> -			int idx;
> +			int idx, nargs;
>   
>   			fm = bpf_jit_find_kfunc_model(ctx->prog, insn);
>   			if (!fm)
>   				return -EINVAL;
>   
> -			for (idx = 0; idx < fm->nr_args; idx++) {
> +			nargs = min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS);
> +			for (idx = 0; idx < nargs; idx++) {
>   				u8 reg = bpf_to_rv_reg(BPF_REG_1 + idx, ctx);
>   
>   				if (fm->arg_size[idx] == sizeof(int))
>   					emit_sextw(reg, reg, ctx);
>   			}
> +
> +			/* BPF stack args -> RISC-V ABI: args 6-8 in A5-A7, 9+ at SP+0 */
> +			if (fm->nr_args > MAX_BPF_FUNC_REG_ARGS) {
> +				int n_stack = fm->nr_args - MAX_BPF_FUNC_REG_ARGS;
> +				int n_reg = min_t(int, n_stack,
> +						  RV_MAX_REG_ARGS - MAX_BPF_FUNC_REG_ARGS);
> +
> +				for (idx = 0; idx < n_reg; idx++) {
> +					int sz = fm->arg_size[MAX_BPF_FUNC_REG_ARGS + idx];
> +
> +					emit_ld(RV_REG_A5 + idx, idx * 8, RV_REG_SP, ctx);
> +					if (sz == sizeof(int))
> +						emit_sextw(RV_REG_A5 + idx, RV_REG_A5 + idx, ctx);
> +				}
> +
> +				for (idx = n_reg; idx < n_stack; idx++) {
> +					int sz = fm->arg_size[MAX_BPF_FUNC_REG_ARGS + idx];
> +
> +					emit_ld(RV_REG_T1, idx * 8, RV_REG_SP, ctx);
> +					if (sz == sizeof(int))
> +						emit_sextw(RV_REG_T1, RV_REG_T1, ctx);
> +					emit_sd(RV_REG_SP, (idx - n_reg) * 8, RV_REG_T1, ctx);
> +				}
> +			}

looks a bit complicated, how about the following after redefine regmap:

```
for (idx = 0; idx < fm->nr_args; idx++) {
   if (idx < RV_MAX_REG_ARGS) {
     u8 reg = RV_REG_A0 + idx;

     sign_extend(reg, reg, xxx)
   } else {
     load from stack to T1
     sign_extend
     retore from T1 to orig stack slot
   }
}
```

>   		}
>   
>   		/* restore TCC to RV_REG_TCC before bpf2bpf call */
> @@ -1891,6 +1916,21 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   	case BPF_LDX | BPF_MEM | BPF_H:
>   	case BPF_LDX | BPF_MEM | BPF_W:
>   	case BPF_LDX | BPF_MEM | BPF_DW:
> +		if (insn->src_reg == BPF_REG_PARAMS) {

pls use is_stack_arg_ldx/st/stx instead.

> +			int idx = off / 8 - 1;
> +
> +			if (is_12b_int(idx * 8)) {
> +				emit_ldx_insn(rd, idx * 8, RV_REG_FP, BPF_SIZE(code), false, ctx);
> +			} else {
> +				emit_imm(RV_REG_T1, idx * 8, ctx);
> +				emit_add(RV_REG_T1, RV_REG_T1, RV_REG_FP, ctx);
> +				emit_ldx_insn(rd, 0, RV_REG_T1, BPF_SIZE(code), false, ctx);
> +			}
> +			if (BPF_SIZE(code) != BPF_DW && insn_is_zext(&insn[1]))
> +				return 1;
> +			break;

This piece of code was refactored not long ago. Let's see if we can 
merge it into the logic below or fold it into emit_ldx—let's give it a try.

> +		}
> +		fallthrough;
>   	case BPF_LDX | BPF_PROBE_MEM | BPF_B:
>   	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
>   	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
> @@ -1938,6 +1978,20 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   	case BPF_ST | BPF_MEM | BPF_H:
>   	case BPF_ST | BPF_MEM | BPF_W:
>   	case BPF_ST | BPF_MEM | BPF_DW:
> +		if (insn->dst_reg == BPF_REG_PARAMS) {
> +			int idx = -off / 8 - 1;
> +
> +			emit_imm(RV_REG_T1, imm, ctx);
> +			if (is_12b_int(idx * 8)) {
> +				emit_stx_insn(RV_REG_SP, idx * 8, RV_REG_T1, BPF_SIZE(code), ctx);
> +			} else {
> +				emit_imm(RV_REG_T2, idx * 8, ctx);
> +				emit_add(RV_REG_T2, RV_REG_SP, RV_REG_T2, ctx);
> +				emit_stx_insn(RV_REG_T2, 0, RV_REG_T1, BPF_SIZE(code), ctx);
> +			}
> +			break;
> +		}
> +		fallthrough;

ditto

>   	/* ST | PROBE_MEM32: *(size *)(dst + RV_REG_ARENA + off) = imm */
>   	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
>   	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
> @@ -1960,6 +2014,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   	case BPF_STX | BPF_MEM | BPF_H:
>   	case BPF_STX | BPF_MEM | BPF_W:
>   	case BPF_STX | BPF_MEM | BPF_DW:
> +		if (insn->dst_reg == BPF_REG_PARAMS) {
> +			int idx = -off / 8 - 1;
> +
> +			if (is_12b_int(idx * 8)) {
> +				emit_stx_insn(RV_REG_SP, idx * 8, rs, BPF_SIZE(code), ctx);
> +			} else {
> +				emit_imm(RV_REG_T1, idx * 8, ctx);
> +				emit_add(RV_REG_T1, RV_REG_SP, RV_REG_T1, ctx);
> +				emit_stx_insn(RV_REG_T1, 0, rs, BPF_SIZE(code), ctx);
> +			}
> +			break;
> +		}
> +		fallthrough;

ditto

>   	/* STX | PROBE_MEM32: *(size *)(dst + RV_REG_ARENA + off) = src */
>   	case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
>   	case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
> @@ -2036,6 +2103,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
>   
>   	stack_adjust = round_up(stack_adjust, STACK_ALIGN);
>   	stack_adjust += bpf_stack_adjust;
> +	stack_adjust += ctx->stack_arg_size;
>   
>   	store_offset = stack_adjust - 8;
>   
> @@ -2093,7 +2161,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
>   	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
>   
>   	if (bpf_stack_adjust)
> -		emit_addi(RV_REG_S5, RV_REG_SP, bpf_stack_adjust, ctx);
> +		emit_addi(RV_REG_S5, RV_REG_SP, ctx->stack_arg_size + bpf_stack_adjust, ctx);
>   
>   	ctx->stack_size = stack_adjust;
>   
> @@ -2171,3 +2239,8 @@ bool bpf_jit_supports_timed_may_goto(void)
>   {
>   	return true;
>   }
> +
> +bool bpf_jit_supports_stack_args(void)
> +{
> +	return true;
> +}
> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> index cbfcd287ea16..844a0f3e0fa9 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -72,6 +72,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   	ctx->arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
>   	ctx->user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
>   	ctx->prog = prog;
> +
> +	ctx->stack_arg_size = round_up(bpf_out_stack_arg_cnt(env, prog) *
> +				       sizeof(u64), STACK_ALIGN);

It's not u64—since every stack slot is aligned to the pointer size 
(sizeof(long)), I think using 8 is fine.

> +
>   	ctx->offset = kvzalloc_objs(int, prog->len);
>   	if (!ctx->offset)
>   		goto out_offset;
> 
