Received: from mta0.migadu.com (out-125.mta0.migadu.com [91.218.175.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B26737189C
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 05:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789104862; cv=none; b=XxfODybbTNHv5Mc6utRLDVGaL2SfkZY0YhwGuu/GZtOOEzwlmHnHx+5JwQ3Ls7Bmjta+QUjY0nbluksnZq388zwo2/8+A8hq37oVtUwjRIwTK7ufa5uaonUQ0ymRH8vNr2d/Aw5rAjjf1BiAtLCYK7gRGqzNeUyQfN3VwxpDqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789104862; c=relaxed/simple;
	bh=QLrUQdoEb+WRmIhtbNrc93z1UP3HxRiY7UU2z3nJbfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/dgwXTeG0ohqkR7ULzVSP6W/kADXWt3pIpUznXKdkALmtByrZmkGpEqQ1YIeMAxH+T0xY0PxNSeX1gl49T9pP9Bx+gTzpAq5tyhpTaSHBAP0V1YKiqjjnBAW9J2bWjLv6vCwoJt4vqWlVIwwpbx7QACAzRPralkBJ9+MSi3/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZkF+7KTR; arc=none smtp.client-ip=91.218.175.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZkF+7KTR"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QLrUQdoEb+WRmIhtbNrc93z1UP3HxRiY7UU2z3nJbfo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789104858; v=1; x=1789709658;
 b=ZkF+7KTR7LIzvy7+s9m1uUW7ClwtLQZdWnT6FOPBs4QVxxvU59spb56VdECMqyAF85QwwugM
 AsaiztUBnhiq9u5LtHxjzdzQSGq/veGuxY/8gmeixc5OLCniSa9gYn0cKo9ZDz+2UqoaxbwkTfe
 Zu5iq209Y5zR8sOjC0DyEfho=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5439cc4172ab65c8;
	Fri, 11 Sep 2026 05:34:18 +0000
X-Mizu-Trace-ID: 5439cc4172ab65c8
X-Migadu-Flow: FLOW_OUT
Message-ID: <4b6edd53-acda-4852-963d-fe233fd2d192@linux.dev>
Date: Thu, 10 Sep 2026 22:34:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 09/12] bpf, arm64: Move kfunc arguments into
 the arm64 calling convention
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260909062610.4008921-1-yonghong.song@linux.dev>
 <41db2f5f6481cb0e9ca5a73d5a597578ebffa4bd39cbcf98aabbcaf87048809f@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <41db2f5f6481cb0e9ca5a73d5a597578ebffa4bd39cbcf98aabbcaf87048809f@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/9/26 12:30 AM, bot+bpf-ci@kernel.org wrote:
>> commit 7c4f41d1b9c4dfdbada8f6d1b1097849ccb20de8
>> Author: Yonghong Song <yonghong.song@linux.dev>
>>
>>      bpf, arm64: Move kfunc arguments into the arm64 calling convention
>>
>>      Do proper move from bpf calling convention to arm64 calling convention
>>      to satisfy native requirement. AAPCS64 only ever moves an argument to a
>>      higher slot, so the moves need one scratch register to carry an eightbyte
>>      from one stack slot to another, and never the one a convention moving an
>>      argument down would need.
>>
>>      In addition, the arena argument walk counts eightbytes rather than
>>      parameters, as an argument may take two registers. The walk takes the
>>      func model from the caller now, as the moves need it too, and runs first
>>      so that they carry the rebased value.
>>
>>      Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> This looks like a bug fix for multi-slot kfunc argument support.
> Should this include:
>
>    Fixes: 2092c3247e45 ("bpf: Prepare kfunc arguments for the JIT from an ABI description")
>
> In v1 of this series, Alexei Starovoitov raised a design concern about
> the overall approach. He questioned why the BPF calling convention should
> diverge from x86-64/arm64, noting that both JIT patches doing argument
> shuffling is a sign that the approach may be wrong on the BPF side. He
> suggested adjusting the BPF calling convention to match arm64 (the
> stricter of the two architectures) rather than forcing all JITs to adapt:
>
>    "Why cannot we adjust bpf calling convention to match arm64/x86 the
>    best? Since arm64 is stricter, I'd pick that style. There are no kfuncs
>    that use int128 or 16+ byte args, so it's a matter of bpf subprogs
>    calling bpf subprogs. Seems cleaner to adjust what llvm emits instead of
>    forcing all jits to adapt."
>
> The v2 took the opposite approach - keeping the BPF calling convention
> and implementing JIT argument shuffling in both x86 and arm64. Was this
> design decision explicitly discussed and agreed upon?

Yes, we will keep original bpf calling convention and then jit will
do proper adjustment.

>
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 3aa3ea0bc30b..bdac930dbdec 100644
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
> [ ... ]
>
>> @@ -1293,6 +1300,45 @@ static int emit_kfunc_arena_args(struct jit_ctx *ctx, const struct bpf_insn *ins
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
>> +
>> +/*
>> + * AAPCS64 only ever moves an argument to a higher slot, so the planner asks
>> + * for the scratch only to carry an eightbyte from one stack slot to another.
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
>> +			reg = a64_arg_on_stack(dst) ? tmp : dst;
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
> This isn't a bug, but would it be clearer to say the plan never needs a
> scratch on AAPCS64 and that TMP_REG_1 is only this helper's
> stack-to-stack carrier? As written, the comment reads as though moves[]
> can contain BPF_JIT_ARG_TMP (which the loop does not handle - unlike the
> x86 version at arch/x86/net/bpf_jit_comp.c which does), and the ': dst'
> arm in the conditional looks unreachable for the same reason (src on the
> stack implies dst on the stack, since dst >= src >= nr_arg_regs).

Okay, will fix.

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34320399441

