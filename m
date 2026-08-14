Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B88368968;
	Fri, 14 Aug 2026 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786690196; cv=none; b=IY2a55Gr0+0m+dIe5K8zNJ7RUxSdE94HJeDQbp4MvuS4AFxzX3U7vDcuq5ZCg2oBHOHipRWi0s0WqXfOi5Re/nPfHNVOXkCp5iOIelvbwrO/9Pkvno1XeiHY2OnwVsziSqe/P0Um42gapRK2Kp4N+ifk7hHY2/4AWoC/dkpVm/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786690196; c=relaxed/simple;
	bh=gTgulqrmxhpfWFjYPb3r0bbR6P005em8nfBFHHhOjt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZhVrY+pFz6pwaLCG/4lrdKm1hzX3RSeRw59FLgCfRcIRxoK4Prp5ZRfpm3mABSrau737ycf3AI58asDd1zQYxuQjnnoHtrM5JmwEYT0ObTsIoBbZexgziAkaoa0MmpOxwmV9ufPUhSa8lfnFA/crpVUrmba24UB2GVPxflI33Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CWJXdXsG; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CWJXdXsG"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3sgyg4KvKSWq3DcPbMXyWixGh8SwL3fHtjef15Jgink=;
	b=CWJXdXsGWeDFdm0L1hwwA+U9mR3w0lZ/u2gnSNO0EwSMTwPeKRLqfrm8oYNLRojA0vMZ2dywZ
	W0JWyiI11vXU1kZTMUmlVqvBYNEuT3pWz+XOauP1LK86fDrxAMON9TRRsL4T+k013CAA5aOlu1F
	9Cp1k1e5dYjkLNs2sRPPdAQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hLsyM2VM3zRhVJ;
	Fri, 14 Aug 2026 14:39:07 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id B712040537;
	Fri, 14 Aug 2026 14:49:43 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 14 Aug
 2026 14:49:42 +0800
Message-ID: <25b9821d-113c-405f-93e9-585fb745a2d6@huawei.com>
Date: Fri, 14 Aug 2026 14:49:42 +0800
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100007.china.huawei.com (7.202.181.221)


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

Hi Feng Jiang,

Thanks for doing this. I'll squeeze the time to review this patchset, 
but there is currently an issue with RV64 kfunc [0]. Let's hold off for 
a moment.:)

[0] 
https://lore.kernel.org/bpf/20260814064726.3607615-1-pulehui@huaweicloud.com

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
>   		}
>   
>   		/* restore TCC to RV_REG_TCC before bpf2bpf call */
> @@ -1891,6 +1916,21 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   	case BPF_LDX | BPF_MEM | BPF_H:
>   	case BPF_LDX | BPF_MEM | BPF_W:
>   	case BPF_LDX | BPF_MEM | BPF_DW:
> +		if (insn->src_reg == BPF_REG_PARAMS) {
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
> +
>   	ctx->offset = kvzalloc_objs(int, prog->len);
>   	if (!ctx->offset)
>   		goto out_offset;
> 
