Received: from mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F2F3630AE
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789233579; cv=none; b=PQi9TIY0Z8q1jJKN1wXScTF/PSSp6XrmgFTFpdsemnM+MsbILE0YqDjGyITYZYKwqJ39GcUFZIi9e1ffijWcDaNxsAIYciv25hywYNP4bYeQ5OUjkAgaT75kOGQO/Jl6Dike4oRBLmdzu6Mg0fUR1HNeHaEoX1xZq5/GF9ge8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789233579; c=relaxed/simple;
	bh=O2/cRBFHOrxbSwTw3Ox1FCotxFubSMfLmcAOSYNnWdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Na7c3SvooUJdA8nIa9UDb+JljR7PStoizIIwpnMhaXhqjCyObOjcaDDh+KinTwZhoirdbppiEyUHzO2EUnjTEtDNh962RQHvPmhHv8/rhVZcQ5ABd5LeuV3EGlCNtOALM5QfF71JGZwjNc/zGo+1tkTtN7yIrySUlOEEqf9FEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FU+q+4x2; arc=none smtp.client-ip=91.218.175.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FU+q+4x2"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O2/cRBFHOrxbSwTw3Ox1FCotxFubSMfLmcAOSYNnWdI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789233575; v=1; x=1789838375;
 b=FU+q+4x2qiKvUKRwtRMasCMkGGxyo7aqrt7Gg74WlUSAEeke5HNaC+NQx3ek5466f9AiHLbG
 u+TPoqthoS6x11CBHh8FeL7z4lb/3PL1medY3jQHyReglL0bF8lOvF0mQva2ooLM1cXw83LGdfQ
 5972TJlJ2dEyLc6/Z9SY5Ve8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id aee5926d5ebd7bf4;
	Sat, 12 Sep 2026 17:19:25 +0000
X-Mizu-Trace-ID: aee5926d5ebd7bf4
X-Migadu-Flow: FLOW_OUT
Message-ID: <253573f1-eea7-4d4f-a083-20b7404fdd84@linux.dev>
Date: Sat, 12 Sep 2026 10:19:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 11/15] bpf, arm64: Move kfunc arguments into
 the arm64 calling convention
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260911155010.2011265-1-yonghong.song@linux.dev>
 <f4f7cb06233a74fad41e9ebb3da63dd916eb11b3842346e9fa7da6c9061211b7@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <f4f7cb06233a74fad41e9ebb3da63dd916eb11b3842346e9fa7da6c9061211b7@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/11/26 9:47 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 3aa3ea0bc30b..bbde7c0836ae 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
> [ ... ]
>
>> @@ -1262,19 +1268,20 @@ static void emit_stack_arg_store_imm(s32 imm, s16 bpf_off, const u8 tmp, struct
>>    * kern_vm_start. A nullable arg preserves NULL by skipping the add, tested
>>    * on the truncated value as arena NULL is offset 0.
>>    */
>> -static int emit_kfunc_arena_args(struct jit_ctx *ctx, const struct bpf_insn *insn)
>> +static int emit_kfunc_arena_args(struct jit_ctx *ctx, const struct btf_func_model *fm)
>>   {
>>   	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
>> -	const struct btf_func_model *fm;
>> -	int i;
>> -
>> -	fm = bpf_jit_find_kfunc_model(ctx->prog, insn);
>> -	if (!fm)
>> -		return -EINVAL;
>> +	int i, slot;
>>
>> -	for (i = 0; i < min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS); i++) {
>> -		const u8 reg = bpf2a64[BPF_REG_1 + i];
>> +	for (i = 0, slot = 0; i < fm->nr_args; i++) {
>> +		u32 arg_regs = (fm->arg_size[i] + 7) / 8;
>>   		u8 flags = fm->arg_flags[i];
>> +		u8 reg;
>> +
>> +		if (slot + arg_regs > MAX_BPF_FUNC_REG_ARGS)
>> +			break;
>> +		reg = bpf2a64[BPF_REG_1 + slot];
>> +		slot += arg_regs;
>>
>>   		if (!(flags & BTF_FMODEL_ARENA_ARG))
>>   			continue;
>> @@ -1293,6 +1300,52 @@ static int emit_kfunc_arena_args(struct jit_ctx *ctx, const struct bpf_insn *ins
>>   	return 0;
>>   }
>>
>> +static bool a64_arg_on_stack(u8 slot)
>> +{
>> +	return slot >= arm64_arg_abi.nr_arg_regs;
>> +}
>> +
>> +static s32 a64_arg_stack_off(u8 slot)
>> +{
>> +	return (slot - arm64_arg_abi.nr_arg_regs) * sizeof(u64);
>> +}
> This isn't a bug, but would it be worth expressing
> emit_stack_arg_load()/emit_stack_arg_store() in terms of
> a64_arg_on_stack()/a64_arg_stack_off() (or noting in a comment that the
> two forms describe the same slot-to-location map), so the layout lives
> in one place? The file now carries two independent encodings of the same
> physical outgoing-argument layout: the pre-existing helpers express it
> as 'idx = bpf slot - 5', register when idx < NR_STACK_ARG_REGS
> (x5/x6/x7) and memory at SP + (idx - NR_STACK_ARG_REGS) * 8 otherwise;
> the new helpers express it as 'slot', register when slot <
> arm64_arg_abi.nr_arg_regs and memory at SP + (slot - nr_arg_regs) * 8.

I think the code is self explained.

>
>> +
>> +/*
>> + * Move the arguments AAPCS64 places somewhere other than the argument slot the
>> + * BPF calling convention gave them. Slot N is X(N) up to the eighth, and the
>> + * outgoing stack argument area from SP beyond it, both for the slot an
>> + * argument comes from and for the one it goes to.
>> + *
>> + * AAPCS64 only ever moves an argument to a higher slot, so no move here ever
>> + * takes BPF_JIT_ARG_TMP: bpf_jit_plan_arg_moves() hands out the scratch only
>> + * for a convention that moves one down, which needs a register to carry the
>> + * value past its own destination.
>> + */
>> +static void emit_kfunc_arg_moves(struct jit_ctx *ctx, const struct btf_func_model *fm)
>> +{
>> +	struct bpf_jit_arg_move moves[BPF_JIT_MAX_ARG_MOVES];
>> +	const u8 tmp = bpf2a64[TMP_REG_1];
>> +	u32 i, n;
>> +
>> +	n = bpf_jit_plan_arg_moves(&arm64_arg_abi, fm, moves);
>> +
>> +	for (i = 0; i < n; i++) {
>> +		u8 dst = moves[i].dst, src = moves[i].src, reg;
>> +
>> +		if (a64_arg_on_stack(src)) {
>> +			reg = tmp;
>> +			emit(A64_LDR64I(reg, A64_SP, a64_arg_stack_off(src)), ctx);
>> +		} else {
>> +			reg = src;
>> +		}
>> +
>> +		if (a64_arg_on_stack(dst))
>> +			emit(A64_STR64I(reg, A64_SP, a64_arg_stack_off(dst)), ctx);
>> +		else if (reg != dst)
>> +			emit(A64_MOV(1, dst, reg), ctx);
>> +	}
>> +}
> [ ... ]
>
>> @@ -2534,7 +2598,13 @@ struct arg_aux {
>>   static int calc_arg_aux(const struct btf_func_model *m,
>>   			 struct arg_aux *a)
>>   {
>> -	int stack_slots, nregs, slots, i;
>> +	int stack_slots, nregs, slots, i, total;
>> +
>> +	/* arm64 supports up to MAX_BPF_FUNC_ARGS argument slots */
>> +	for (i = 0, total = 0; i < m->nr_args; i++)
>> +		total += (m->arg_size[i] + 7) / 8;
>> +	if (total > MAX_BPF_FUNC_ARGS)
>> +		return -ENOTSUPP;
>>
>>   	/* verifier ensures m->nr_args <= MAX_BPF_FUNC_ARGS */
>>   	for (i = 0; i < m->nr_args; i++) {
> This isn't a bug, but could the changelog say explicitly that arm64's
> trampoline path now rejects models whose arguments exceed
> MAX_BPF_FUNC_ARGS eightbytes (previously it accepted up to twice that),
> so the narrowing is visible to anyone bisecting an fentry attach
> failure? The third changelog paragraph describes the calc_arg_aux() hunk
> as adding support ('let us support up to MAX_BPF_FUNC_ARGS argument
> slots'), while on the trampoline path the hunk is a new restriction:
> calc_arg_aux() previously accepted any model btf_distill_func_proto()
> admitted (up to 12 arguments of up to 16 bytes, i.e. up to 24
> eightbytes), and now returns -ENOTSUPP for anything above 12 eightbytes,
> so arch_prepare_bpf_trampoline()/arch_bpf_trampoline_size() fail for
> those targets.

You are right. We shouldn't just reject. I will do proper implementation
to fix the issue.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34620351527

