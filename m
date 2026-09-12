Received: from mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3510B47ACF6
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789233300; cv=none; b=jX8sPBZ8vnCSMuBaWQDZGxlyO3q2SF2ZBJNTvclpyJOsR5QuDasHDN4AJ0/wcyD8mUSUSoDt6U9nTFLPfl7C4ZQ2M5RCl+dOZDwP6jZWrFJ7zJ/mgLB5G85MO9JWfHZki0rBYcOH5jMBrJAeOomzv7wVHsMs4peV/seey+E7ZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789233300; c=relaxed/simple;
	bh=JCgdaj5HVXALxwhW1vBwIuV/H6AsN72ghVFOqNws5f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pki+Ko48KcI84hij9zOoX0F3Y7Op6XRhNbySHb8jh9UjL5vbGd6GxEeYcj+5B1pSRs6Rg+bDVo/3HAwkEWepDEwTMcwo7rLMk1Zn5dXFGBc997qLikza7/nEgRcAGhT38yin+jbd01vZEWB2Y/LGH119AIt1iBzPkbT49fXvoko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UDKA/9UF; arc=none smtp.client-ip=91.218.175.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UDKA/9UF"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JCgdaj5HVXALxwhW1vBwIuV/H6AsN72ghVFOqNws5f4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789233294; v=1; x=1789838094;
 b=UDKA/9UFSZN4SyF7uVT/AAl9XIwIwNpgb/SiHv5f8CC1FwvEVmb06dXE6bBTi5Fc4u4pNhPH
 Luun8ixJpaEKo2/iuLWL6Ey4NOS7IjLdTefc48s8F7DA3OLKSYgrC4cTCYFrLd0Njx0YoTXnL4E
 yejIoudADCH65AixYvnSo8Xw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 21b783b58ee0e74b;
	Sat, 12 Sep 2026 17:14:54 +0000
X-Mizu-Trace-ID: 21b783b58ee0e74b
X-Migadu-Flow: FLOW_OUT
Message-ID: <2c9edda1-1565-4742-ae21-55c9533bdf6a@linux.dev>
Date: Sat, 12 Sep 2026 10:14:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 10/15] bpf, x86: Move kfunc arguments into the
 x86-64 calling convention
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260911155005.2010021-1-yonghong.song@linux.dev>
 <0b84d8722fb6870aa98302b2ee8a71a0be1da1f4925204529c5545a66e1a4ba1@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0b84d8722fb6870aa98302b2ee8a71a0be1da1f4925204529c5545a66e1a4ba1@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/11/26 9:47 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index bba351944202..0496607a7003 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -1839,6 +1839,60 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
>>   	return 0;
>>   }
>>
>> +static const struct bpf_jit_arg_abi x86_arg_abi = {
>> +	.nr_arg_regs		= 6,
>> +	.backfill_after_stack	= true,
>> +	.even_stack_align	= true,
>> +};
>> +
>> +static const u8 x86_arg_reg[] = {
>> +	BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5, X86_REG_R9,
>> +};
>> +
>> +/*
>> + * Move the arguments the x86-64 ABI places somewhere other than the argument
>> + * slot the BPF calling convention gave them. @stack_base addresses the
>> + * outgoing stack argument area from RBP. Return the number of emitted bytes.
>> + */
>> +static int emit_kfunc_arg_moves(const struct btf_func_model *fm, s32 stack_base, u8 **pprog)
>> +{
>> +	struct bpf_jit_arg_move moves[BPF_JIT_MAX_ARG_MOVES];
>> +	const u8 nreg = x86_arg_abi.nr_arg_regs;
>> +	u8 *prog = *pprog, *start = prog;
>> +	u32 i, n;
>> +
>> +	n = bpf_jit_plan_arg_moves(&x86_arg_abi, fm, moves);
>> +
>> +	for (i = 0; i < n; i++) {
>> +		u8 dst = moves[i].dst, src = moves[i].src, reg;
>> +		bool dst_mem = dst != BPF_JIT_ARG_TMP && dst >= nreg;
>> +		bool src_mem = src != BPF_JIT_ARG_TMP && src >= nreg;
>> +
>> +		/* Take the value into a register. */
>> +		if (src == BPF_JIT_ARG_TMP) {
>> +			reg = AUX_REG;
>> +		} else if (src_mem) {
>> +			reg = dst_mem || dst == BPF_JIT_ARG_TMP ? BPF_REG_AX : x86_arg_reg[dst];
>> +			emit_ldx(&prog, BPF_DW, reg, BPF_REG_FP,
>> +				 stack_base + (src - nreg) * 8);
>> +		} else {
>> +			reg = x86_arg_reg[src];
>> +		}
>> +
>> +		/* And leave it where the argument belongs. */
>> +		if (dst == BPF_JIT_ARG_TMP)
>> +			emit_mov_reg(&prog, true, AUX_REG, reg);
> This isn't a bug, but for the memory-source case, could reg be AUX_REG when
> dst == BPF_JIT_ARG_TMP so the load lands directly in the scratch instead of
> going through BPF_REG_AX?
>
> The case is reachable: a prototype such as (u64 a..e, struct {u64; u64;}
> s, u64 f) backfills f into R9 and hands the planner a down-move whose
> source is a stack slot. With the current code, emit_kfunc_arg_moves()
> generates:
>
>      mov r10, [rbp+off]
>      mov r11, r10
>
> when this would do:
>
>      mov r11, [rbp+off]
>
> Picking AUX_REG when dst == BPF_JIT_ARG_TMP (and BPF_REG_AX only for the
> memory-to-memory case) would drop the extra instruction from every such
> call site.

Sounds good. A little bit optimization. Will do.

>> +		else if (dst_mem)
>> +			emit_stx(&prog, BPF_DW, BPF_REG_FP, reg,
>> +				 stack_base + (dst - nreg) * 8);
>> +		else if (reg != x86_arg_reg[dst])
>> +			emit_mov_reg(&prog, true, x86_arg_reg[dst], reg);
>> +	}
>> +
>> +	*pprog = prog;
>> +	return prog - start;
>> +}
> [ ... ]
>
>> @@ -2837,6 +2897,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>>   				if (err < 0)
>>   					return err;
>>   				ip += err;
>> +				ip += emit_kfunc_arg_moves(fm, outgoing_arg_base -
>> +							   outgoing_rsp, &prog);
>>   			}
> [ ... ]
>
>>      bpf, x86: Move kfunc arguments into the x86-64 calling convention
>>
>>      Do the proper move from the BPF calling convention to the x86-64 calling
>>      convention to satisfy the native requirement.
> This isn't a bug, but could the changelog name the case that actually
> needs a move (a by-value argument spilling to the stack followed by a
> backfilled register argument) and note that at most one argument moves
> down, so the scratch register carry is safe?
>
> The current wording says what the patch does without saying which
> arguments actually end up somewhere other than their BPF slot, or why a
> reviewer has to reconstruct that from bpf_jit_place_args() and
> bpf_jit_plan_arg_moves().

Indeed, the above description is not enough. I will add more things like you
mentioned above.

>
>>      In addition, the arena argument walk counts eightbytes rather than
>>      parameters, as an argument may take two registers.
> (This second paragraph reads well and is concrete.)
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34620351527

