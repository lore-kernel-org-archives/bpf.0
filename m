Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC142233A
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776536156; cv=none; b=Z8CtIG7qo951w8E4PFbXDcNFGpVFVqRz6uTUzTtkGiZjOOztknd8F6ifiHuuPK2wJJy12mADWEisLA3GFXtRdagRBPAQeWjxGjBnybiJso43dIGvll4FG7miDN8w83ZDdurVe8z+YJqZU+bX0GVgIcr0M52KBRLTIlW4gwljM4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776536156; c=relaxed/simple;
	bh=Yf9GAS6A3VOEp01qzRsNTqZP7AJz7DN8U3mpmW+BE6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCqc60Ym+KbVWMB91mt7t7LKXHuj8o1CBRGDqp/cRjp02kdj7r1RyfvNZ7LFLmks++PKaSHvLqHXOizgEVSx9aiUYZya9QjvZ8HbMEcKKkszcHdQg5t/hP4v8ZopaurT8kNf72LLTwMIZSLNjnTG+T+lt+Rle+QrAYxhasFDsCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pf5p42AP; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pf5p42AP"
Message-ID: <b4572484-396a-4dc7-ae16-0cf04b49176f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776536143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VbfqOZF/lK8jVyTR2XIx8rDozXAsmJM34X3zJ3tOqU=;
	b=Pf5p42AP4ts0IwpLdt6+bt0uOK6e+xo2IzfaiMpu4JkFr47hhnnLVx0brc5+Lw4jJLAI8z
	MxLM9nx3O01Af+ve9PDkFVXsG6fj2H5WCqyk4hlhH/CqkE43B/aoTCaQjFZd89PUVG4jhI
	z7gbx69b3Xa2E/ghv4CmA0JbSbuAumU=
Date: Sat, 18 Apr 2026 11:15:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 13/16] bpf,x86: Implement JIT support for
 stack arguments
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260417034823.2632289-1-yonghong.song@linux.dev>
 <20260417044443.66D37C19425@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260417044443.66D37C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/16/26 9:44 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 4 potential issue(s):
> - [High] Data corruption of Argument 6 across function calls due to caller-saved register clobbering.
> - [High] Missing size handling for Argument 6 allows verifier bounds tracking bypass and out-of-bounds memory writes.
> - [High] The offset translation formula for outgoing arguments 7+ reverses the memory layout, corrupting sub-slot accesses.
> - [Medium] The JIT misroutes stack accesses because it rigidly assumes LDX only targets incoming arguments and STX/ST only target outgoing arguments.
> --
>
> commit 41dcf99330b6b0a3804185f2a284a76be8340ed1
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf,x86: Implement JIT support for stack arguments
>
> Add x86_64 JIT support for BPF functions and kfuncs with more than
> 5 arguments. The extra arguments are passed through a stack area
> addressed by register r11 (BPF_REG_PARAMS) in BPF bytecode,
> which the JIT translates to native code.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 32864dbc2c4e8..25b4357de023b 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>
>> @@ -1664,16 +1692,45 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>   	stack_depth = bpf_prog->aux->stack_depth;
>> +	stack_arg_depth = bpf_prog->aux->stack_arg_depth;
>> +	incoming_stack_arg_depth = bpf_prog->aux->incoming_stack_arg_depth;
>> +	outgoing_stack_arg_depth = stack_arg_depth - incoming_stack_arg_depth;
>>   	priv_stack_ptr = bpf_prog->aux->priv_stack_ptr;
>>   	if (priv_stack_ptr) {
>>   		priv_frame_ptr = priv_stack_ptr + PRIV_STACK_GUARD_SZ + round_up(stack_depth, 8);
>>   		stack_depth = 0;
>>   	}
>>   
>> +	/*
>> +	 * Follow x86-64 calling convention for both BPF-to-BPF and
>> +	 * kfunc calls:
>> +	 *   - Arg 6 is passed in R9 register
>> +	 *   - Args 7+ are passed on the stack at [rsp]
> Can the use of the R9 register cause data corruption across function calls?
>
> The x86-64 C calling convention defines R9 as a caller-saved register.
> However, the BPF verifier models argument 6 as stack memory, which implies
> its value should be preserved across calls.
>
> If a BPF program reads incoming argument 6 after making a helper or kfunc
> call, will it receive a clobbered value instead of the original argument?
> Similarly, could a helper call scheduled by LLVM between the setup of
> outgoing argument 6 and the target call corrupt the R9 register?

Yes. This is correct. The verifier part needs to do proper invalidation
to avoid this issue in JIT.

>
> [ ... ]
>
>> +	/*
>> +	 * Base offset from rbp for translating BPF outgoing args 7+
>> +	 * to native offsets. BPF uses negative offsets from r11
>> +	 * (r11-8 for arg6, r11-16 for arg7, ...) while x86 uses
>> +	 * positive offsets from rsp ([rsp+0] for arg7, [rsp+8] for
>> +	 * arg8, ...). Arg 6 goes to R9 directly.
>> +	 *
>> +	 * The translation reverses direction:
>> +	 *   native_off = outgoing_arg_base - outgoing_rsp - bpf_off - 16
>> +	 *
>> +	 * Note that tail_call_reachable is guaranteed to be false when
>> +	 * stack args exist, so tcc pushes need not be accounted for.
>> +	 */
> Does this formula correctly handle multi-byte sub-slot accesses?
>
> Since the formula subtracts the BPF offset, the memory layout within the
> 8-byte slots appears mathematically reversed. While this correctly maps the
> 8-byte slot bases (e.g., -16 maps to rsp + 0), it seems to point to the
> wrong memory for partial writes.
>
> For example, if a program writes to the upper 32 bits of Arg 7 at BPF offset
> -12, the formula yields BASE - (-12) - 16 = BASE - 4. Will this map the
> access out-of-bounds below the stack pointer instead of to [rsp + 4]?

Currently, we do not support sub-slot access. All r11 load/store are 8 byte
size. I will ensure this in verifier checking.

>
> [ ... ]
>
>> @@ -2129,12 +2222,26 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>   				EMIT1(0xC7);
>>   			goto st;
>>   		case BPF_ST | BPF_MEM | BPF_DW:
>> +			if (dst_reg == BPF_REG_PARAMS && insn->off == -8) {
>> +				/* Arg 6: store immediate in r9 register */
>> +				emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31, (u32)imm32);
>> +				break;
>> +			}
>>   			EMIT2(add_1mod(0x48, dst_reg), 0xC7);
>>   
>> -st:			if (is_imm8(insn->off))
>> -				EMIT2(add_1reg(0x40, dst_reg), insn->off);
>> +st:			insn_off = insn->off;
>> +			if (dst_reg == BPF_REG_PARAMS) {
>> +				/* Args 7+: reverse BPF negative offsets to
>> +				 * x86 positive rsp offsets.
>> +				 * BPF off=-16 → [rsp+0], off=-24 → [rsp+8], ...
>> +				 */
>> +				insn_off = outgoing_arg_base - outgoing_rsp - insn_off - 16;
>> +				dst_reg = BPF_REG_FP;
>> +			}
> Are the size constraints missing for Argument 6 here?
>
> The check for Arg 6 (insn->off == -8) is only implemented under the BPF_DW
> case. For sizes B, H, and W, execution will fall through to the st: label.
> This would incorrectly translate the access as a normal stack operation
> using the formula above, writing out-of-bounds below the stack pointer at
> [rsp - 8] instead of populating R9.
>
> Additionally, for BPF_LDX, a 1-byte load emits a full 64-bit move to R9.
> Since the upper 56 bits of R9 are undefined for 1-byte arguments, could
> they contain garbage data? This would bypass the verifier's strict value
> bounds tracking, which assumes the loaded value is strictly within [0, 255].
>
> [ ... ]

Will enforce 8-byte width for r11 based load/stores.

>
>> @@ -2243,6 +2360,19 @@ st:			if (is_imm8(insn->off))
>>   		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
>>   		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
>>   			insn_off = insn->off;
>> +			if (src_reg == BPF_REG_PARAMS) {
>> +				if (insn_off == 8) {
>> +					/* Incoming arg 6: read from r9 */
>> +					EMIT_mov(dst_reg, X86_REG_R9);
>> +					break;
>> +				}
>> +				src_reg = BPF_REG_FP;
>> +				/*
>> +				 * Incoming args 7+: native_off == bpf_off
>> +				 * (r11+16 → [rbp+16], r11+24 → [rbp+24], ...)
>> +				 * No offset adjustment needed.
>> +				 */
>> +			}
> Does this logic misroute stack accesses by assuming LDX always targets
> incoming arguments and STX/ST always target outgoing arguments?

Yes.

>
> If a program writes an outgoing argument ([r11 - 16]) and then reads it back
> via LDX, the JIT appears to apply the incoming argument translation mapping
> the read to [rbp - 16] (the local stack) instead of [rsp] (the outgoing
> area). This would return uninitialized data.
>
> Conversely, if a program modifies an incoming argument ([r11 + 16]) using
> STX, the JIT would apply the outgoing translation formula, yielding
> BASE - 16 - 16 = BASE - 32, which writes out-of-bounds below the stack
> pointer.

In verifier, we have a check:

static int check_stack_arg_access(struct bpf_verifier_env *env,
                                   struct bpf_insn *insn, const char *op)
{
         int size = bpf_size_to_bytes(BPF_SIZE(insn->code));
                 
         if (size != BPF_REG_SIZE) {
                 verbose(env, "stack arg %s must be %d bytes, got %d\n",
                         op, BPF_REG_SIZE, size);
                 return -EINVAL;
         }
         if (insn->off == 0 || insn->off % BPF_REG_SIZE) {
                 verbose(env, "stack arg %s offset %d not aligned to %d\n",
                         op, insn->off, BPF_REG_SIZE);
                 return -EINVAL;
         }
         /* Reads use positive offsets (incoming), writes use negative (outgoing) */
         if (op[0] == 'r' && insn->off < 0) {
                 verbose(env, "stack arg read must use positive offset, got %d\n",
                         insn->off);
                 return -EINVAL;
         }
         if (op[0] == 'w' && insn->off > 0) {
                 verbose(env, "stack arg write must use negative offset, got %d\n",
                         insn->off);
                 return -EINVAL;
         }
         return 0;
}

load must have positive offset and store must have negative offset.
I will fix the above checking '< 0' => '<= 0" and '> 0' => '>= 0'.

