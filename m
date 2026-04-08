Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA032720C
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623265; cv=none; b=ORsov/bCHI/NU1c1sRwYa74wuD9uUGMclQv88g9xs2bGgwzhkMxGRqXWO4yVHSeRMmm5kh4RtrMQ+I00XztnlGCjEB0xya54keoTwtZHhy8KUJepQF8h3+Nc0404b4PMGlY6NWty30R4QSW1jWYjhlzgP4nirx4a3cs47nHC5zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623265; c=relaxed/simple;
	bh=J3T8jTjfCOnNAy8g4BURRCc06xVl1WMtBEGP3pDqSGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XR29Fi3F3JHYB1o6DCWewkUiGx6rJ603ViiapHHvFMDnpJ3+Uhp/KocYFM5NNyTBkr4o8TQvB2XjtPr1MHMBSPyPI/z9Fh2mLHFbsGJsniAnswYK+wnbOLldokYr104ZLaUmUUkPgWPMU1mFfUaeiXTh6Er9tArnwwya9PdTPb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WaIXSjNM; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WaIXSjNM"
Message-ID: <85de8d23-f919-4e68-929e-d4d571bdea4d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775623261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEwdExbYRCDa0tpgsv2D1cgUgYoqggXV1EGeuSoFIlk=;
	b=WaIXSjNMmgeHWMAvZMynbCZ+6mKmWMU2gTb3TswWwJN4HvKe3Df4b7lmooupnstgorlSw/
	UMAu8DnbEUxljYRT4hJ2TpPx/MB/p8ZRTwQJWubpKzD0cXO7DGnAcDbr30TpOMQYKyovts
	98otqntRO4SSxsdtW/QzJjbm7217fHY=
Date: Tue, 7 Apr 2026 21:40:55 -0700
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
Content-Transfer-Encoding: 8bit
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

Yes, it could. So in next revision, we will disable private stack
if outgoing stack arguments is not empty.

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

