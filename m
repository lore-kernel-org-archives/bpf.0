Received: from mta0.migadu.com (out-143.mta0.migadu.com [91.218.175.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5783264FD
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848447; cv=none; b=RwTtWf9pd+KFxIxHEi8T5gCSi5nQSUAxHX8XtWMrDQvnhvHMLhaCuxb+QiBzWLoCP9v3KckqEz1J6yzByVMmYYi9R8XoP84kKmHSXCkNpPMsn6SjhB71w3nUmOZhZ33ak0oBkcs6GOEay6DhdxO5pSJxiozskgXRn0GI9u/uWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848447; c=relaxed/simple;
	bh=MPVAPsRuXwrkj6ts6DYdnPeDORFePZTcSjyINYPZsfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niqCfcXU8H+8BMokMYTJ3gi6xwhE83pgft7z0+a516padTbiRjYdIwdlpZejMOHkETb93Xlo/ihL/IXDSvi9d6rHt8AoJehfBHRDPolaj3EN7a8TMobGVeRoh+wghDi7rvu96q99JuOJ4uY9ZnjoeP0eLY+l8obghrKRQb2oQuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wJ6bkZuq; arc=none smtp.client-ip=91.218.175.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wJ6bkZuq"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MPVAPsRuXwrkj6ts6DYdnPeDORFePZTcSjyINYPZsfo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789848444; v=1; x=1790453244;
 b=wJ6bkZuq/xIAd64NHndkxUIxy3BxGc98/WgxnIDLWUD3oTfZplVc64LO9yFpdGusZMIXaAOU
 7v0Oq3Rn8NGaY+3wQ6u83XgzCbACGN6/BBAHwzzUPFLkThjjg4evD6RLuRah9UTeyT6C+qAJkfy
 cI4awUPaPGRnZlvrcgP0rgTI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 900945d90de1ae54;
	Sat, 19 Sep 2026 20:07:24 +0000
X-Mizu-Trace-ID: 900945d90de1ae54
X-Migadu-Flow: FLOW_OUT
Message-ID: <de117595-2c03-416a-9a22-2be7362716f2@linux.dev>
Date: Sat, 19 Sep 2026 13:07:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 12/20] bpf, arm64: Dispatch exception cleanup
 pads at run time
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260918044301.3290118-1-yonghong.song@linux.dev>
 <df5244af92cf0268c54eafb2546e7c37a9e6d8a2d534e2b62864b1b80f65ffb3@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <df5244af92cf0268c54eafb2546e7c37a9e6d8a2d534e2b62864b1b80f65ffb3@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/26 10:44 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 6c04fee468766..560eba305bca2 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
> [ ... ]
>
>> @@ -75,7 +76,21 @@ static const int bpf2a64[] = {
>>   	[ARENA_VM_START] = A64_R(28),
>>   };
>>
>> +/* Throw-site spill: the five pairs push_callee_regs() forces on, same size and
>> + * slot order, so arch_bpf_run_cleanup_pad() reads both alike.
>> + */
>> +#define A64_CLEANUP_SPILL_SZ	(5 * 16)
>> +
>> +/*
>> + * Where a landing pad's frame is anchored, since the stack pointer generated
>> + * code normally addresses it through is the walker's inside a pad. bpf2a64[]
>> + * maps nothing to x24, so nothing else in generated code touches it.
>> + */
>> +#define A64_CLEANUP_FP		A64_R(24)
>> +
>>   struct jit_ctx {
>> +	/* Bytes reserved for the throw-site spill; see bpf_cleanup_force_spill(). */
>> +	u32 throw_spill;
>>   	const struct bpf_prog *prog;
>>   	int idx;
>>   	int epilogue_offset;
> This isn't a bug, but would it read better to put throw_spill next to
> stack_size and stack_arg_size, which it is always used with, rather
> than ahead of prog at the head of the struct?

Okay, will do.

>
> [ ... ]
>
>> @@ -1367,6 +1411,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
>>   	const s16 off = insn->off;
>>   	const s32 imm = insn->imm;
>>   	const int i = insn - ctx->prog->insnsi;
>> +	const bool in_pad = bpf_cleanup_insn_in_pad(ctx->prog, i);
>>   	const bool is64 = BPF_CLASS(code) == BPF_ALU64 ||
>>   			  BPF_CLASS(code) == BPF_JMP;
>>   	u8 jmp_cond;
>> @@ -1378,9 +1423,14 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
>>   	int ret;
>>   	bool sign_extend;
>>
>> -	if (bpf_insn_is_indirect_target(env, ctx->prog, i))
>> +	if (bpf_insn_is_indirect_target(env, ctx->prog, i) ||
>> +	    bpf_cleanup_insn_is_pad(ctx->prog, i))
>>   		emit_bti(A64_BTI_J, ctx);
>>
>> +	if (bpf_cleanup_insn_is_pad(ctx->prog, i))
>> +		emit(A64_SUB_I(1, A64_CLEANUP_FP, fp,
>> +			       ctx->stack_size + ctx->stack_arg_size), ctx);
>> +
> This isn't a bug, but could the two bpf_cleanup_insn_is_pad() calls
> share a local the way in_pad does, and could the throw-site check
> further down use the existing 'i' instead of recomputing
> insn - ctx->prog->insnsi?

Will do.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711

