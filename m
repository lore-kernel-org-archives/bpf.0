Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803721A08A3
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433778; cv=none; b=lpRu33exEynmDOvqckzw/Fk3+bPQAVZdoPMKwHWjjtn2RdVqcu6Nk8DZwoqpQq3CK8PsWST3m1xLwrP/TahpS2HaHO40GnzK3FrpSpnKPb6uns27V6U14W/Q4Ni1+POlFl0tjx4DaWtF94pclf1sNRYeiFT1kzHYgLDLcbPhcR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433778; c=relaxed/simple;
	bh=ZoMewrWE9b0coK2xq1RUfJPx/mGG+sQBu7cvLeh1zcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlJQM4TQ2e/qZVPTJgfG2QLlgkNQEoaXVpJgGiM0RmaCyI5Ncliwm2PGPV5YBzsznniJBDhlB2ilcL7Jkp6dRGGO9i3gT8NFC+5P/H5Q0UB7IbXg5NYvmOTET/y+NHW9qLkcEojDpCA2afQgecwzgyic8RIX8Rs2ZMTPXfZl3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RRVOfWWz; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RRVOfWWz"
Message-ID: <f210561f-c8c9-4e86-9338-f68ab86bfad3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778433774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEzV0ZCztw7zMxfGGeW+4RDpES0lntrYPZz2n2pEhyM=;
	b=RRVOfWWz60wvZIAIMNa9qYNjplDYbqYWbhum+xvOsUCVzavcT5ldOqXvuH6zAnzQSMPsUB
	1rje2+k9EhURDfYCzCREyAjQFMkwTNyGBnQAMs5QiNhFAReLD8JidPVIXtrnz3cfVnum2m
	uYBEwpLxhqilNPacY5E7GqKo/fFEe10=
Date: Sun, 10 May 2026 10:22:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 15/23] bpf,x86: Implement JIT support for
 stack arguments
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260507213124.1132088-1-yonghong.song@linux.dev>
 <20260509022147.D0F50C2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260509022147.D0F50C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/9/26 4:21 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Critical] The offset translation formula for outgoing stack arguments (Args 7+) negates the BPF offset, reversing the memory layout and causing partial accesses to corrupt the stack.
> - [Critical] Immediate stores (`BPF_ST`) of 8, 16, or 32 bits to Arg 6 bypass the register routing check, writing out-of-bounds to the stack and leaving Arg 6 uninitialized.
> - [Critical] Partial loads and stores (`BPF_LDX` / `BPF_STX`) to Arg 6 unconditionally emit 64-bit register moves, ignoring size semantics and breaking verifier bounds tracking.
> - [Critical] Sub-register accesses to Arg 6 bypass exact-offset interception, falling through to memory operations that leak the kernel return address or corrupt the stack.
> --
>
> commit ee1dd512e669afb6db2ee6c05d9e78b43305dc79
> Author: Yonghong Song <yonghong.song@linux.dev>
>
>      bpf,x86: Implement JIT support for stack arguments
>
> This patch adds x86_64 JIT support for BPF functions and kfuncs with more
> than 5 arguments. The extra arguments are passed through a stack area
> addressed by the R11 register (BPF_REG_PARAMS), with argument 6 being routed
> to the R9 register.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index ea9e707e8abff..67c2f4a3b9cc3 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>> @@ -2134,12 +2227,27 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>>   				EMIT1(0xC7);
>>   			goto st;
>>   		case BPF_ST | BPF_MEM | BPF_DW:
>> +			if (dst_reg == BPF_REG_PARAMS && insn->off == -8) {
>> +				/* Arg 6: store immediate in r9 register */
>> +				emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31, (u32)imm32);
>> +				break;
>> +			}
> Are stores of 8, 16, or 32 bits to Arg 6 missing the register routing check?
> Because BPF_B, BPF_H, and BPF_W sizes jump directly to the st: label, they
> appear to skip this R9 check. Could this cause them to mistakenly apply the
> stack argument translation and write out-of-bounds, leaving R9 uninitialized?

Currently, all r11 based ldx/stx/st insns only support 8 byte value. So we
do not have the above or below issues.

>
>>   			EMIT2(add_1mod(0x48, dst_reg), 0xC7);
>>   
>> -st:			if (is_imm8(insn->off))
>> -				EMIT2(add_1reg(0x40, dst_reg), insn->off);
>> +st:			insn_off = insn->off;
>> +			if (dst_reg == BPF_REG_PARAMS) {
>> +				/*
>> +				 * Args 7+: reverse BPF negative offsets to
>> +				 * x86 positive rsp offsets.
>> +				 * BPF off=-16 → [rsp+0], off=-24 → [rsp+8], ...
>> +				 */
>> +				insn_off = outgoing_arg_base - outgoing_rsp - insn_off - 16;
>> +				dst_reg = BPF_REG_FP;
>> +			}
> Does subtracting the BPF offset reverse the memory layout within a stack slot?
>
> If a BPF program accesses the upper 4 bytes of Arg 7 (offset -12), the formula
> evaluates to BASE - (-12) - 16 = BASE - 4. This points out-of-bounds below
> the stack pointer. Similarly, writing to the upper 4 bytes of Arg 8 (-20)
> would evaluate to BASE + 4, overwriting the upper half of Arg 7.
>
> [ ... ]
>> @@ -2149,7 +2257,17 @@ st:			if (is_imm8(insn->off))
>>   		case BPF_STX | BPF_MEM | BPF_H:
>>   		case BPF_STX | BPF_MEM | BPF_W:
>>   		case BPF_STX | BPF_MEM | BPF_DW:
>> -			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
>> +			if (dst_reg == BPF_REG_PARAMS && insn->off == -8) {
>> +				/* Arg 6: store register value in r9 */
>> +				EMIT_mov(X86_REG_R9, src_reg);
>> +				break;
>> +			}
> Will sub-register stores to Arg 6 bypass this check? If a program writes to
> the upper 4 bytes of outgoing Arg 6 (insn->off == -4), the exact check fails
> and it will fall through to memory translation, potentially writing
> out-of-bounds.
>
> Also, does EMIT_mov() unconditionally emit a 64-bit move, ignoring the BPF_B,
> BPF_H, and BPF_W sizes? If a 1-byte store is performed, this might write 64
> bits to R9 instead of the intended size.
>
> [ ... ]
>> @@ -2248,6 +2366,19 @@ st:			if (is_imm8(insn->off))
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
> What happens if a program reads a sub-register of incoming Arg 6?
> If insn_off == 12 (the upper 4 bytes), the exact check fails, and src_reg
> becomes BPF_REG_FP (rbp). The resulting memory read from [rbp + 12]
> corresponds to the upper 4 bytes of the kernel return address, which could
> be leaked to the BPF program.
>
> Similarly, if the program performs a partial load of Arg 6 (insn_off == 8),
> EMIT_mov() moves the full 64-bit value from R9. Could this bypass the
> verifier's bounds tracking if the verifier assumes the upper 56 bits are
> properly zeroed for a 1-byte read?
>

