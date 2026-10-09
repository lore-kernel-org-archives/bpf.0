Received: from mta0.migadu.com (out-231.mta0.migadu.com [91.218.175.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572783B637C
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566416; cv=none; b=YS1JWi3AXQECSR3MmVwBqhCEZ+4e5PGU6wpQCEckNXxydIMbbHET/9nJYEpGHI/LnoTcH1q5WRX0mrp0JZGFCiwJPriy22+z7rnj7IFvGJli/XFF7oeqr605ON8U8P08cCTO0Y+aXUA32geFQGdO6pqCvPBMJ9m+M4dPZ9r4lqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566416; c=relaxed/simple;
	bh=RkxqhVgqnpXZtKgTxcZzgWHVETq/u1vjNlq1wEMUndo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amW0qyiHYdObvc6HWmloMFlR8IPuhDbynS31yR2LXhFi1qpWX4TOf1eivbTxSpCdo5wPAXUGEm3c+CSbzdpktUMNL8lFfeU/fFBkKqRUqvtls/j+OdGcfNX9FcPYzqDKtRGNxHS5Ek9IQghIXZHLfw3Vc1HHFDlVBHpbGfP4KIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QO4SLHMD; arc=none smtp.client-ip=91.218.175.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QO4SLHMD"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RkxqhVgqnpXZtKgTxcZzgWHVETq/u1vjNlq1wEMUndo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791566411; v=1; x=1792171211;
 b=QO4SLHMDaHsQJW1rJg8msqikiaMTe4pFZccb1FBt61psK7tSpPKtekx1WAQAWJxIKRVxYlF+
 0h8Fr2ddLDQcgnU0/vV+tX9vah89bEWAnm8GSdYoS82J8PpXQ+SeclJG+2GjVJMA5rSGmFWxus9
 2ayAue6Bw4SMnC5Jpi9/1o84=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a1474cda992cc2b6;
	Fri, 09 Oct 2026 17:20:10 +0000
X-Mizu-Trace-ID: a1474cda992cc2b6
X-Migadu-Flow: FLOW_OUT
Message-ID: <cb00a111-06de-4380-861b-ee8ef24bbba9@linux.dev>
Date: Fri, 9 Oct 2026 19:20:10 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/5] bpf: Keep the BPF calling convention for a
 trampoline on a BPF function
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261009064216.1239645-1-yonghong.song@linux.dev>
 <63a98d2d85f35e452858e2313b1c36b9d71dc124b0a9aa0f55ac67f382551818@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <63a98d2d85f35e452858e2313b1c36b9d71dc124b0a9aa0f55ac67f382551818@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/9/26 9:26 AM, bot+bpf-ci@kernel.org wrote:
>> bpf: Keep the BPF calling convention for a trampoline on a BPF function
> TL;DR: On arm64, the identity slot mapping for BPF targets may split a 16-byte
> argument across x7 and the stack; fexit/fentry could then read x8 or
> uninitialised stack, corrupting the traced function's values.
>
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
> [ ... ]
>
>> @@ -3342,6 +3342,18 @@ u32 bpf_jit_place_args(const struct bpf_jit_arg_abi *abi,
>>   	u32 i, k, nslots, slot = 0, nregs_used = 0, stack_off = 0;
>>   	bool on_stack = false;
>>
>> +	/*
>> +	 * A BPF function is called by BPF code, which passes slot N where
>> +	 * the kernel convention passes its Nth eightbyte, whatever the
>> +	 * arguments: no hole, no split refused and no register backfilled.
>> +	 */
>> +	if (fm->bpf_tgt_prog) {
>> +		for (i = 0; i < fm->nr_args; i++)
>> +			for (k = btf_func_model_arg_slots(fm, i); k > 0; k--, slot++)
>> +				pos_of_slot[slot] = slot;
>> +		return slot;
>> +	}
>> +
> Can this identity mapping split one 16-byte argument across the last
> register and the stack on arm64, which is the only trampoline calling
> bpf_jit_place_args() at this commit?
>
> Before this patch, arm64_arg_abi has no split_at_boundary, so every slot of
> an argument landed either in x0-x7 or on the stack.  calc_arg_aux() relies
> on that and only checks the first slot of each argument:
>
>      for (i = 0, slot = 0; i < m->nr_args; i++) {
>          slots = (m->arg_size[i] + 7) / 8;
>          if (a64_arg_on_stack(a->pos_of_slot[slot])) /* passed through register ? */
>              break;
>          slot += slots;
>      }
>
> save_args() then uses each pos_of_slot value of such an "in register"
> argument as a register number:
>
>      reg = a->pos_of_slot[slot++];
>      if (for_call_origin) {
>          emit(A64_LDR64I(reg, A64_SP, bargs_off), ctx);
>      ...
>      } else {
>          emit(A64_STR64I(reg, A64_SP, bargs_off), ctx);
>      }
>
> With the identity mapping, a 16-byte argument at BPF slot 7 gets
> pos_of_slot = {7, 8}.  This looks reachable: a static subprog can have up
> to 12 argument slots (btf_check_arg_slots(), and
> bpf_jit_supports_stack_args() is true on arm64), and btf_prepare_func_args()
> accepts scalar-only structs up to 16 bytes.  The selftest added later in
> this series (e5dd7e2f7244) has such a function:
>
>      static __noinline __u64 callee_stack(__u64 a, __u64 b, __u64 c, __u64 d,
>                                           __u64 e, __u64 f, __u64 g,
>                                           struct int128_arg h, __u64 i)
>
> The arm64 JIT passes h.lo in x7 (stack_arg_reg[2]) and h.hi at [SP+0]
> (emit_stack_arg_store(), idx 3).  calc_arg_aux() then returns
> args_in_regs = 8, regs_for_args = 9, bstack_for_args = 8 and
> ostack_for_args = 16, so:
>
> - fentry: save_args() stores A64_R(8) into ctx[8].  On arm64, x8 is
>    BPF_REG_0 of the calling BPF code (bpf2a64[BPF_REG_0] = A64_R(8)), not
>    h.hi, which is still at FP + 32 + 0.
>
> - fexit (BPF_TRAMP_F_CALL_ORIG): save_args(..., true, ...) loads the saved
>    value into x8 and never writes oargs_off + 0.  The original function then
>    reads h.hi from uninitialised trampoline stack.  If the split argument is
>    the last one, bstack_for_args and ostack_for_args are both 0, and the
>    function reads [SP+0] of the trampoline frame, which is the
>    bpf_tramp_run_ctx.
>
> Attaching fexit would then change the values the traced BPF function
> computes with, and what it returns.
>
> The new comment says the BPF convention has "no split refused", and the x86
> follow-up f5df67b558e5 ("bpf, x86: Place trampoline arguments by the x86-64
> calling convention") handles a split per slot for x86.  But no commit in the
> range updates arch/arm64/net/bpf_jit_comp.c.  The int128_tgt_prog selftest
> in e5dd7e2f7244 also runs on __aarch64__, where it would expect ctx[8] == 9
> but read x8.
>
> Should calc_arg_aux(), save_args() and restore_args() on arm64 classify and
> read each slot by its own position (register vs. FP + 32 +
> a64_arg_stack_off()), the way the x86 follow-up does, so that a split
> 16-byte argument works?

Indeed, I missed arm64 case. Will fix it in the next revision.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37897160282

