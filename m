Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0ED25771
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776536629; cv=none; b=iu6LyPhmh/aDTvEYaPsILtppHMSxuL+/9nO3/Aefqy6JM61Yn6dcyykDlvQIxDibM2zcqwX1zFJa3J+hgF/0w6wAQ/Dv1z6hjBHB8R2m2mJgameZwU5VMNtaU7yLdIK2/sPXuAJfoMDWF6gpXvQpODx2gUyxRcAWxvTQ1dq1yTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776536629; c=relaxed/simple;
	bh=2yRfw6Ue2scKQRmnl+qU3mJgFyTq2BccwUqngyJ73Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nm5ZqYN8epjSGXnircobVLsV2QhbbHq24XLwxKEY+bblSW8+/notMLtDPMi/unSQCxVvEnp41uaXlOE88x5Le3Ivg370sp0kkEYkCdCSHM27i9L82/KUTV/h9C9pYOaOygMAxYktLY8If+OGH/8u90dyo62a9EYg3ZGlhIh/gdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v8nPmDgY; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v8nPmDgY"
Message-ID: <661b6286-3c8c-4f94-9417-5d209920fb2f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776536625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCwjeYu9GZHz5x3Gw7byWmUuroQftN1xRW8VdveBi1Q=;
	b=v8nPmDgY6YaYSWCUtSz+A1BBLxqYp8Kwntm38d0fv8hrqGozKrmmPgQE3/qxhjpMcOWrV/
	Fxd7DctHYaNxvHnrby3G2Tz76YLAtvlA7LqwJqId95QmKdDzb31E7H2Ifl2/tfWTXPHuGI
	+bkRFkaNZmKWYuMiMXQufUd4faWL70M=
Date: Sat, 18 Apr 2026 11:23:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 13/16] bpf,x86: Implement JIT support for
 stack arguments
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260417034823.2632289-1-yonghong.song@linux.dev>
 <51f25fcf1ab708a8cdb69e6d0a0dccf440304394f4673046d703256a5c832878@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <51f25fcf1ab708a8cdb69e6d0a0dccf440304394f4673046d703256a5c832878@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/17/26 6:20 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 32864dbc2c4e..25b4357de023 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
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
>> +			if (is_imm8(insn_off))
>> +				EMIT2(add_1reg(0x40, dst_reg), insn_off);
>>   			else
>> -				EMIT1_off32(add_1reg(0x80, dst_reg), insn->off);
>> +				EMIT1_off32(add_1reg(0x80, dst_reg), insn_off);
> The special case for arg 6 at offset -8 is only implemented for
> BPF_ST | BPF_MEM | BPF_DW. What happens with smaller access sizes
> (BPF_B, BPF_H, BPF_W)?
>
> Looking at the code flow, if a BPF_ST with size B/H/W targets
> dst_reg == BPF_REG_PARAMS at offset -8, execution would fall through
> to the st: label. The offset translation formula would then be applied:
>
>      insn_off = outgoing_arg_base - outgoing_rsp - (-8) - 16
>               = outgoing_arg_base - outgoing_rsp - 8
>
> For example, with outgoing_arg_base = -40 and outgoing_rsp = 0,
> this yields -32, which would attempt to write at [rbp - 32], outside
> the designated outgoing argument area at [rsp].
>
> Does this allow writing out-of-bounds below the stack pointer instead
> of updating R9?
>
> Reference: https://lore.kernel.org/bpf/20260417044443.66D37C19425@smtp.kernel.org/
>
>> @@ -2144,7 +2251,17 @@ st:			if (is_imm8(insn->off))
>>   		case BPF_STX | BPF_MEM | BPF_H:
>>   		case BPF_STX | BPF_MEM | BPF_W:
>>   		case BPF_STX | BPF_MEM | BPF_DW:
>> -			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
>> +			if (dst_reg == BPF_REG_PARAMS && insn->off == -8) {
>> +				/* Arg 6: store register value in r9 */
>> +				EMIT_mov(X86_REG_R9, src_reg);
>> +				break;
>> +			}
>> +			insn_off = insn->off;
>> +			if (dst_reg == BPF_REG_PARAMS) {
>> +				insn_off = outgoing_arg_base - outgoing_rsp - insn_off - 16;
>> +				dst_reg = BPF_REG_FP;
>> +			}
> The offset translation formula subtracts the BPF offset, which reverses
> the addressing direction. While this correctly maps 8-byte aligned slot
> bases (e.g., -16 → rsp+0, -24 → rsp+8), can it handle partial writes
> within those slots?

Currently we do not support partial writes within those slots.
In llvm, all stack arguments are promoted to 64bit.

>
> For instance, if a program writes to the upper 32 bits of arg 7 at BPF
> offset -12:
>
>      insn_off = outgoing_arg_base - outgoing_rsp - (-12) - 16
>               = outgoing_arg_base - outgoing_rsp - 4
>
> With outgoing_arg_base = -40 and outgoing_rsp = 0, this computes to
> -36, mapping the access to [rbp - 36] instead of [rsp + 4].
>
> Does this formula produce out-of-bounds accesses below the stack pointer
> for partial writes?
>
> Reference: https://lore.kernel.org/bpf/20260417044443.66D37C19425@smtp.kernel.org/
>
> [ ... ]
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
> When reading incoming arg 6 with smaller access sizes (BPF_LDX |
> BPF_MEM | BPF_B/H/W), the code performs a full 64-bit move from R9
> to the destination register:
>
>      EMIT_mov(dst_reg, X86_REG_R9);

Again, we only support 64bit operations.

>
> For sub-64-bit arguments, are the upper bits of R9 guaranteed to be
> zero? If not, could this move garbage data into the upper bits of
> dst_reg, bypassing the verifier's strict bounds tracking which expects
> values to stay within their declared ranges (e.g., [0, 255] for
> bytes)?
>
> Reference: https://lore.kernel.org/bpf/20260417044443.66D37C19425@smtp.kernel.org/
>
> The JIT translation assumes that LDX operations target incoming
> arguments (positive offsets from r11) and STX/ST operations target
> outgoing arguments (negative offsets from r11). Is this assumption
> always valid?

Yes.

>
> Consider these scenarios:
>
> Scenario 1: A program writes to an outgoing argument slot at
> [r11 - 16] via STX, then reads it back via LDX. The JIT would:
>    - Store: apply outgoing translation → [rsp + 0]
>    - Load: apply incoming translation → [rbp + 16] (different location)

A LDX with [r11 - 16] will be rejected by verifier.

>
> The load would read from the BPF program stack area rather than the
> outgoing argument area, potentially returning uninitialized data.
>
> Scenario 2: A program attempts to modify an incoming argument at
> [r11 + 16] via STX. The JIT would apply the outgoing translation:

Again, this is illegal for STX with positive offset.

>
>      insn_off = outgoing_arg_base - outgoing_rsp - 16 - 16
>               = outgoing_arg_base - outgoing_rsp - 32
>
> With outgoing_arg_base = -40 and outgoing_rsp = 0, this yields -72,
> writing to [rbp - 72], which could be out-of-bounds below the allocated
> stack area.
>
> Does the verifier enforce a constraint that reads can only target
> positive r11 offsets and writes can only target negative r11 offsets?
>
> Reference: https://lore.kernel.org/bpf/20260417044443.66D37C19425@smtp.kernel.org/
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564

