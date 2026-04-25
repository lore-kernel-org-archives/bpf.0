Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2F5CDF1
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 05:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777093751; cv=none; b=sZKOOGwKoC2+d6D5xtv/JFMrtRlkB0+i2ExM/tNzTi6kxPMvfp6cwjgU7h1noYNw2jPSm693Qe9VdmccXs7TeQib3RC+f48rUyNn8x4ET3DmzZTqepbt6aOPRkKXFJP4VUG6dxpz7XU6dSkWkPiARMutPEqcsNaTu4RvGoFNudY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777093751; c=relaxed/simple;
	bh=jTfWdCJqFDqG87TLPS/NXhMXCrdBdY/ZzsDJQ+4ZUPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4jgBz/nny3aHYFxu4LX8l3HQgZIHgVuvfeyZNKBssXTGmCIaaOFS/r2Ww55OYbDYn+nSEEPhqfAVuAOcw+ee4Ed30JJ03QzshNgCxNBQK8yWyBGU+Kgn0lxpK7zgwdr+Y3OBITcQ4mRD9UJ0pBZn/LBNqR4fuQmKJsQqTO5xv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mhwwsWyD; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mhwwsWyD"
Message-ID: <fa7819f9-0fbe-4bdb-a9a5-fa6ea7b6e628@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777093747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XDU3TNHATSjpasikbO2H39M+VaPFsbqzr6B+Zde52s=;
	b=mhwwsWyDF/Qo1kF+ZjhTD5ZrdZXQ58fBOeTWMvtSW1BS/FYD7gWN3zBiIgyLPpoQRrF4xW
	XvNBilPEohKZTtgX3jkHf28kNZy3cQ3eX7z06P0PD0sCnoH1ww8DzX6J/ieUppp4LGPML+
	audQeVZDQrppATYb6H9Ov0QnlgIN1NI=
Date: Fri, 24 Apr 2026 22:09:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 01/18] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260424171438.2034741-1-yonghong.song@linux.dev>
 <98641213c682008a7c4634976ef37edfe8338fdeaf196f3e119356d8c4c9a63a@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <98641213c682008a7c4634976ef37edfe8338fdeaf196f3e119356d8c4c9a63a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/24/26 11:13 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index d5b4303315dd..2cc349d7fc17 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
> [ ... ]
>
>> @@ -739,10 +759,13 @@ struct bpf_subprog_info {
>>   	bool keep_fastcall_stack: 1;
>>   	bool changes_pkt_data: 1;
>>   	bool might_sleep: 1;
>> -	u8 arg_cnt:3;
>> +	u8 arg_cnt:4;
>>
>>   	enum priv_stack_mode priv_stack_mode;
>> -	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
>> +	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
>> +	u16 incoming_stack_arg_depth;
>> +	u16 stack_arg_depth; /* incoming + max outgoing */
>> +	u16 max_out_stack_arg_depth;
>>   };
> Alexei Starovoitov raised a concern in the v6 review about duplicated
> fields. The incoming_stack_arg_depth, stack_arg_depth, and
> max_out_stack_arg_depth fields are present in both bpf_subprog_info and
> bpf_prog_aux structures. His comment was:
>
>    "but you already have them in prog_aux?! another copy in
>    bpf_subprog_info?! Remove one of them. JIT only need one set."
>
> Looking at include/linux/bpf.h, these fields appear in bpf_prog_aux:
>
>    struct bpf_prog_aux {
>        ...
>        u16 incoming_stack_arg_depth;
>        u16 stack_arg_depth;
>        ...
>    };
>
> Does the verifier actually need both copies? The concern was that having
> duplicate state creates maintenance burden.

Before jit_subprogs(), bpf_subprog_info stores the information for each subprog.
At this point, the subprog has not been allocated and only main prog is available.
Therefore, it is not possible to copy bpf_subprog_info to each subprog.

So I think it might be necessary to have both fields in bpf_prog_aux and
bpf_subprog_info.

This version made some changes so max_out_stack_arg_depth is not needed
any more. Will remove it in the next revision.

>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index ff6ff1c27517..bcf81692a22b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> +/*
>> + * Write a value to the outgoing stack arg area.
>> + * off is a negative offset from r11 (e.g. -8 for arg6, -16 for arg7).
>> + */
>> +static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_state *state,
>> +				 int off, int value_regno)
>> +{
>> +	int max_stack_arg_regs = MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS;
>> +	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
>> +	int spi = -off / BPF_REG_SIZE - 1;
>> +	struct bpf_func_state *cur;
>> +	struct bpf_reg_state *arg;
>> +	int err;
>> +
>> +	if (spi >= max_stack_arg_regs) {
>> +		verbose(env, "stack arg write offset %d exceeds max %d stack args\n",
>> +			off, max_stack_arg_regs);
>> +		return -EINVAL;
>> +	}
>> +
>> +	err = grow_stack_arg_slots(env, state, -off);
>> +	if (err)
>> +		return err;
>> +
>> +	/* Track the max outgoing stack arg access depth. */
>> +	if (-off > subprog->max_out_stack_arg_depth)
>> +		subprog->max_out_stack_arg_depth = -off;
>> +
>> +	cur = env->cur_state->frame[env->cur_state->curframe];
>> +	if (value_regno >= 0) {
>> +		state->stack_arg_regs[spi] = cur->regs[value_regno];
> Can this code handle offset=0 correctly? For an instruction like

This is not possible for this one and below other questions.
See commit 'bpf: Enable r11 based insns'. For load, the offset
must be 8, 16, .... For store, the offset must be -8, -16, etc.
And the size must be 8 (BPF_DW).

Also, at this point, r11 usage is not enabled and it will fail
at check_and_resolve_insns() way before any actual verification
(do_check_main()). So we should be okay.

> '*(u64 *)(r11 + 0) = r6', the computation spi = -0 / 8 - 1 = -1. The
> bounds check 'spi >= max_stack_arg_regs' would be false since -1 < 7,
> so execution proceeds to 'state->stack_arg_regs[-1]' which is an
> out-of-bounds array access.
>
> This also affects misaligned negative offsets. For off=-4, the result is
> spi = 4/8 - 1 = -1, causing the same OOB write.
>
> Additionally, there's no validation of the access size. A 4-byte write
> '*(u32 *)(r11 - 8) = r6' would be accepted and recorded as an 8-byte
> register spill in stack_arg_regs[0], but the JIT would emit a 4-byte
> store. The verifier's tracked state would not match the machine state.
>
> Looking at the referenced commit 5a36f6a2934e ("bpf: Enable r11 based
> insns") in the patch series, it adds validation in
> check_and_resolve_insns() that rejects r11 stores with off >= 0, non
> 8-byte aligned offsets, and non-BPF_DW sizes. Should this validation be
> in the current commit instead?
>
>> +/*
>> + * Read a value from the incoming stack arg area.
>> + * off is a positive offset from r11 (e.g. +8 for arg6, +16 for arg7).
>> + */
>> +static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf_func_state *state,
>> +				int off, int dst_regno)
>> +{
>> +	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
>> +	struct bpf_verifier_state *vstate = env->cur_state;
>> +	int spi = off / BPF_REG_SIZE - 1;
>> +	struct bpf_func_state *caller, *cur;
>> +	struct bpf_reg_state *arg;
>> +
>> +	if (state->no_stack_arg_load) {
>> +		verbose(env, "r11 load must be before any r11 store or call insn\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (off > subprog->incoming_stack_arg_depth) {
>> +		verbose(env, "invalid read from stack arg off %d depth %d\n",
>> +			off, subprog->incoming_stack_arg_depth);
>> +		return -EACCES;
>> +	}
>> +
>> +	caller = vstate->frame[vstate->curframe - 1];
>> +	arg = &caller->stack_arg_regs[spi];
> Can this handle off=0 safely? For a load '*(u64 *)(r11 + 0)', spi would
> be 0/8 - 1 = -1, and the check 'off > incoming_stack_arg_depth' (0 >
> non-negative) would be false. Execution would continue to
> 'caller->stack_arg_regs[-1]', which is out-of-bounds.
>
> What about when this runs in the main program where curframe==0? The
> expression 'vstate->frame[vstate->curframe - 1]' would compute
> frame[(u32)-1], accessing frame[0xFFFFFFFF] which is far beyond the
> bounds of the frame[] array (MAX_CALL_FRAMES entries).
>
> Additionally, the code does not validate access size. A 4-byte load
> 'r0 = *(u32 *)(r11 + 8)' would be accepted and the verifier would copy
> the full 8-byte register from caller->stack_arg_regs[0], but the JIT
> would emit a 4-byte read.
>
> The later commit 5a36f6a2934e ("bpf: Enable r11 based insns") adds
> validation requiring loads to be BPF_LDX|BPF_MEM|BPF_DW with off > 0 and
> 8-byte aligned. Should that be part of this commit?
>
>> @@ -6605,10 +6737,20 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   			  bool strict_alignment_once, bool is_ldsx,
>>   			  bool allow_trust_mismatch, const char *ctx)
>>   {
>> +	struct bpf_verifier_state *vstate = env->cur_state;
>> +	struct bpf_func_state *state = vstate->frame[vstate->curframe];
>>   	struct bpf_reg_state *regs = cur_regs(env);
>>   	enum bpf_reg_type src_reg_type;
>>   	int err;
>>
>> +	/* Handle stack arg read */
>> +	if (insn->src_reg == BPF_REG_PARAMS) {
>> +		err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
>> +		if (err)
>> +			return err;
>> +		return check_stack_arg_read(env, state, insn->off, insn->dst_reg);
>> +	}
> Does this dispatch check the BPF_SIZE? A non-BPF_DW load through r11
> (e.g., 'r0 = *(u32 *)(r11 + 8)' which is BPF_W) goes to
> check_stack_arg_read, which treats it as a full 8-byte register copy
> from the caller. The verifier state would not match what the JIT emits.
>
>> @@ -6637,10 +6779,20 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   static int check_store_reg(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   			   bool strict_alignment_once)
>>   {
>> +	struct bpf_verifier_state *vstate = env->cur_state;
>> +	struct bpf_func_state *state = vstate->frame[vstate->curframe];
>>   	struct bpf_reg_state *regs = cur_regs(env);
>>   	enum bpf_reg_type dst_reg_type;
>>   	int err;
>>
>> +	/* Handle stack arg write */
>> +	if (insn->dst_reg == BPF_REG_PARAMS) {
>> +		err = check_reg_arg(env, insn->src_reg, SRC_OP);
>> +		if (err)
>> +			return err;
>> +		return check_stack_arg_write(env, state, insn->off, insn->src_reg);
>> +	}
> Similarly for stores, does this gate on BPF_SIZE? A 4-byte store
> '*(u32 *)(r11 - 8) = r6' (BPF_W) would be accepted here and recorded as
> an 8-byte spill, creating the same verifier/JIT mismatch.
>
>> @@ -17627,6 +17804,14 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>>   		return check_store_reg(env, insn, false);
>>
>>   	case BPF_ST: {
>> +		/* Handle stack arg write (store immediate) */
>> +		if (insn->dst_reg == BPF_REG_PARAMS) {
>> +			struct bpf_verifier_state *vstate = env->cur_state;
>> +			struct bpf_func_state *state = vstate->frame[vstate->curframe];
>> +
>> +			return check_stack_arg_write(env, state, insn->off, -1);
>> +		}
> Does this check BPF_SIZE as well? A BPF_ST with dst_reg=BPF_REG_PARAMS
> and size != BPF_DW would have the same issue.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240

