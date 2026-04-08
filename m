Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF016132A
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 04:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623350; cv=none; b=s9aP5SqIhgo5hbTv0lCAbOWFdtgo8dPq4jqLOL2iujFczOMRP7griRTDWduRFb0qpN9u0qTKniJMd8Ewp1UTVTHUkhr94h10KjbmnubfncDJZ5KDtezL9OfYGWMm9WIrS9DhuolFRGZ0MuQnJGPs0rp4u6d2WWRCx2Klcd7ED24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623350; c=relaxed/simple;
	bh=zdUWZ8l88jlDSBXgWeObqrdBZNUvf6VUXi4X/cvE7MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=om+rnetuC65WT2u2HgccgT+TbBYMQsX17a0OLQd2afIttYk6UfVHuJXtut/kFVyIpyv0j2vgCYMF72w75pbv7Wg8bK1Ip9GT6C63Rrrbek8fgDyFNJVIaOXtkcPr0yjb6BepOeMESiO+NOe0nWoWc39dY0+JtbyLU3uXteYWNp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kq3CHh4T; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kq3CHh4T"
Message-ID: <4f582a12-1227-47f3-805b-7cc038b68457@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775623347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRxJfHVlfNHeZ9evtiSVMFklaZtDUYu1VfXHfKLhgOs=;
	b=Kq3CHh4T4vg3Hbqt1flYzD5olrhXfshDrYp3CAutlpMcuE1xgS9bMGYXOZ7Zsf9Fy1fW7S
	NfTbub4ycbdMVgPezrplb/PTMC3nm0hveJEW2J498XKJS/HzVNpxXANPTgyBKxbDISCyD4
	Mo2FQam9aWpZJRoOKoPlFOg2Tcm9ef0=
Date: Tue, 7 Apr 2026 21:42:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 08/11] bpf,x86: Implement JIT support for
 stack arguments
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260405172626.1337674-1-yonghong.song@linux.dev>
 <e093e4d67ae569dd8183db5affaa8ec67c3d20c7b9a46c0f78a223041efc0921@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e093e4d67ae569dd8183db5affaa8ec67c3d20c7b9a46c0f78a223041efc0921@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/5/26 11:20 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 32864dbc2c4e..206f342a0ca0 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>
>> @@ -2449,6 +2529,41 @@ st:			if (is_imm8(insn->off))
>>   			}
>>   			if (!imm32)
>>   				return -EINVAL;
>> +
>> +			if (src_reg == BPF_PSEUDO_CALL && outgoing_stack_arg_depth > 0) {
>> +				s32 outgoing_base = -(prog_stack_depth + outgoing_stack_arg_depth);
>> +				int n_args = outgoing_stack_arg_depth / 8;
>> +
>> +				ip += push_stack_args(&prog, outgoing_base, n_args, 1);
>> +			}
>> +
>> +			if (src_reg != BPF_PSEUDO_CALL && insn->off > 0) {
>> +				/* Kfunc calls: arg 6 -> R9, args 7+ -> push. */
>> +				s32 outgoing_base = -(prog_stack_depth + outgoing_stack_arg_depth);
>> +				int kfunc_stack_args = insn->off;
>> +
>> +				stack_args = kfunc_stack_args > 1 ? kfunc_stack_args - 1 : 0;
>> +
>> +				/* Push args 7+ in reverse order */
>> +				if (stack_args > 0)
>> +					ip += push_stack_args(&prog, outgoing_base, kfunc_stack_args, 2);
>> +
>> +				/* mov r9, [rbp + outgoing_base] (arg 6) */
>> +				if (is_imm8(outgoing_base)) {
>> +					EMIT4(0x4C, 0x8B, 0x4D, outgoing_base);
>> +					ip += 4;
>> +				} else {
>> +					EMIT3_off32(0x4C, 0x8B, 0x8D, outgoing_base);
>> +					ip += 7;
>> +				}
>> +			}
>>   			if (priv_frame_ptr) {
>>   				push_r9(&prog);
>>   				ip += 2;
> When priv_frame_ptr is active (private stack in use), R9 holds the
> private frame pointer throughout the program. The existing push_r9 /
> pop_r9 around calls preserves R9 across the function call.
>
> With this new code, two issues arise when stack args and
> priv_frame_ptr are both active.
>
> For kfunc calls with stack args: the MOV R9, [rbp + outgoing_base]
> overwrites the priv_frame_ptr in R9 with arg6 before push_r9 saves
> it. After the call, pop_r9 restores arg6 into R9 instead of the
> priv_frame_ptr, so subsequent BPF_REG_FP accesses (which map to R9
> when priv_frame_ptr is set) would reference the wrong memory.
>
> For both kfunc and BPF-to-BPF calls: push_r9 inserts an extra 8
> bytes onto the stack between the pushed args and the CALL
> instruction. The callee then sees the wrong values for its stack
> arguments. For example, with a BPF-to-BPF call the callee's
> incoming arg formula expects [rbp + 16] to be the first stack arg,
> but instead it finds the caller's saved R9 value:
>
>      push_stack_args:  [RSP] = arg1, [RSP+8] = arg2
>      push_r9:          [RSP] = R9,   [RSP+8] = arg1, [RSP+16] = arg2
>      CALL:             [RSP] = ret,  [RSP+8] = R9 ...
>      callee prologue:  [rbp+16] = R9  (expected arg1)
>
> Both priv_stack_mode and stack_arg_depth are set independently per
> subprog in jit_subprogs(), so can this combination actually be
> reached?

You are right. Similar to my previous comments, private stack will
be disabled if outgoing stack arguments are not empty.

>
>> @@ -2458,6 +2573,14 @@ st:			if (is_imm8(insn->off))
>>   				return -EINVAL;
>>   			if (priv_frame_ptr)
>>   				pop_r9(&prog);
>> +			if (stack_args > 0) {
>> +				/* add rsp, stack_args * 8 */
>> +				EMIT4(0x48, 0x83, 0xC4, stack_args * 8);
>> +			}
>> +			if (src_reg == BPF_PSEUDO_CALL && outgoing_stack_arg_depth > 0) {
>> +				/* add rsp, outgoing_stack_arg_depth */
>> +				EMIT4(0x48, 0x83, 0xC4, outgoing_stack_arg_depth);
>> +			}
>>   			break;
>>   		}
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24006922024

