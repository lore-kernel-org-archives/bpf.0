Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92DB1A256E
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776624953; cv=none; b=N6yKXDkX/e410LF4xiKlPxSMFOvax5GAngSoZUzkduLG5XZSBMt0buYjnp6pyx2W7ft3tIo5vQ2StxLr81zSsRSjEPsSwAeCLrps64+avlZVpPgZSnDBCASyd7CjRUqwiCPIOHQcMPEC6itHEldjonOwirp6uZ9HlWDwp+MeJII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776624953; c=relaxed/simple;
	bh=Rg4QbZ50k4+ELZ82G/LGZVMH02cYkjakaR0aDvfDlAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaNrjYeHpGxoyPMrJKKUu6ACAYiViIMDFg2fXCNAHZdBDSurjV0sErKWQRC/+wpJOlL0CcLSRdPjgckEgLAOKM6YhtINZr0GCjpArDUJTmKCt2gAw5iXhPSrB/RyyVmF55l4abqGKYOWSAff/hmLYYvQBUny4yWYyXWdrdNLLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ak3DeHL0; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ak3DeHL0"
Message-ID: <2ea53044-02a6-4a2c-9571-1c5c9bda7413@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776624949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhHi0rjzXqMAkAY0B9X0+j8rqt7flGsnvFzBDWT9ND4=;
	b=ak3DeHL0CWnuf/iASOpqSRaAI4TrCOFxFNnrBdDg1V97eJVVYVN0VcT35DpdZ+3Vri7igF
	NIX9HoJ3+eGESrSusy835umGM48MhKKY1PEBauv9MJGGoKt3V93N9ZBtsAGS9cj9ka4kY6
	GXxQ34TvThavp1ykyq4FFGoY78lw5zo=
Date: Sun, 19 Apr 2026 11:55:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 14/17] bpf,x86: Implement JIT support for
 stack arguments
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260419163429.739002-1-yonghong.song@linux.dev>
 <20260419172541.BDF59C2BCAF@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260419172541.BDF59C2BCAF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/19/26 10:25 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 4 potential issue(s):
> - [Critical] Incoming Arg 6 mapped to volatile R9 is clobbered by calls, causing verifier type confusion.
> - [Critical] Sub-register BPF_LDX from incoming Arg 6 incorrectly copies the full 64-bit R9 register, breaking verifier bounds tracking.
> - [High] BPF_ST instructions for outgoing Arg 6 miss size checks, causing out-of-bounds stack corruption and uninitialized arguments.
> - [High] Sub-register BPF_STX to outgoing Arg 6 overwrites the entire 64-bit R9 register.
> --
>
> commit 16df4bd097c0d6a600a22bdb40ebfc360ece0fc6
> Author: Yonghong Song <yonghong.song@linux.dev>
>
>      bpf,x86: Implement JIT support for stack arguments
>
> This commit adds x86_64 JIT support for BPF functions with more than 5
> arguments. The extra arguments are passed through a stack area addressed by
> register r11 (BPF_REG_PARAMS), mapping Arg 6 to R9 and Args 7+ to the stack.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index ea9e707e8abff..06f33fef1e8e1 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>> @@ -2134,12 +2227,26 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
> Does this code handle 32-bit, 16-bit, or 8-bit stores to Arg 6 correctly?

No. Only 64-bit stores are supported. See patch "bpf: Enable r11 based insns".

>
> The check for dst_reg == BPF_REG_PARAMS && insn->off == -8 is uniquely placed
> inside the BPF_ST | BPF_MEM | BPF_DW case block. If a BPF program uses a
> smaller size store like BPF_W to prepare Arg 6, the code bypasses this check
> and falls through to the st: label.
>
> At the st: label, the insn_off calculation equates to RSP - 8 relative to
> RBP, emitting a memory store that corrupts unallocated stack memory. In
> addition, R9 is never updated, which leaves Arg 6 uninitialized for the callee.
>
> [ ... ]
>> @@ -2149,7 +2256,17 @@ st:			if (is_imm8(insn->off))
>>   		case BPF_STX | BPF_MEM | BPF_B:
>>   		case BPF_STX | BPF_MEM | BPF_H:
>>   		case BPF_STX | BPF_MEM | BPF_W:
>>   		case BPF_STX | BPF_MEM | BPF_DW:
>> -			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
>> +			if (dst_reg == BPF_REG_PARAMS && insn->off == -8) {
>> +				/* Arg 6: store register value in r9 */
>> +				EMIT_mov(X86_REG_R9, src_reg);
>> +				break;
>> +			}
> Does this full 64-bit move break semantics for partial writes?

It should be okay. llvm compiler will promote the value to 64bit before
r11 based load/store's.

>
> For smaller sizes like BPF_B or BPF_W, EMIT_mov generates a full 64-bit move
> that copies all 64 bits from src_reg to R9.
>
> BPF semantics dictate that a sub-register store should only modify the
> specified lower bytes of the target location, leaving the rest unmodified. This
> full copy could overwrite data previously stored in the upper bytes of Arg 6
> via other partial writes.
>
> [ ... ]
>> @@ -2248,6 +2365,19 @@ st:			if (is_imm8(insn->off))
>>   		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
>>   		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
>>   			insn_off = insn->off;
>> +			if (src_reg == BPF_REG_PARAMS) {
>> +				if (insn_off == 8) {
>> +					/* Incoming arg 6: read from r9 */
>> +					EMIT_mov(dst_reg, X86_REG_R9);
>> +					break;
>> +				}
> Can R9 be clobbered by function calls when used for Arg 6?

I think yes as you mentioned below for Arg 6 (r9) usage.

>
> The verifier treats incoming stack arguments as stable memory preserved across
> function calls. However, under the x86-64 System V ABI, R9 is a caller-saved
> (volatile) register.
>
> If a BPF program reads [r11+8] after making a helper, kfunc, or subprog call,
> it will read the clobbered value left in R9. The verifier will incorrectly
> track this as the uncorrupted argument, which could cause type confusion.

To make things easier, I think verifier can enforce all stack loads must
be before stack stores. And all stack loads must be before any function/kfunc
calls. The following is an example:

$ cat t.c
int bar1(int, int, int, int, int, int);
int foo(int a, int b, int c, int d, int e, int f) {
    int ret;
    ret = bar1(a, a, a, b, b, b);
    ret += bar1(a, a, a, b, b, f);
    return ret;
}

$ llvm-objdump -d t.o

t.o:    file format elf64-x86-64

Disassembly of section .text:

0000000000000000 <foo>:
        0: 55                            pushq   %rbp
        1: 41 57                         pushq   %r15
        3: 41 56                         pushq   %r14
        5: 53                            pushq   %rbx
        6: 50                            pushq   %rax
        7: 44 89 cb                      movl    %r9d, %ebx
        a: 89 f5                         movl    %esi, %ebp
        c: 41 89 fe                      movl    %edi, %r14d
        f: 89 fe                         movl    %edi, %esi
       11: 89 fa                         movl    %edi, %edx
       13: 89 e9                         movl    %ebp, %ecx
       15: 41 89 e8                      movl    %ebp, %r8d
       18: 41 89 e9                      movl    %ebp, %r9d
       1b: e8 00 00 00 00                callq   0x20 <foo+0x20>
       20: 41 89 c7                      movl    %eax, %r15d
       23: 44 89 f7                      movl    %r14d, %edi
       26: 44 89 f6                      movl    %r14d, %esi
       29: 44 89 f2                      movl    %r14d, %edx
       2c: 89 e9                         movl    %ebp, %ecx
       2e: 41 89 e8                      movl    %ebp, %r8d
       31: 41 89 d9                      movl    %ebx, %r9d
       34: e8 00 00 00 00                callq   0x39 <foo+0x39>
       39: 44 01 f8                      addl    %r15d, %eax
       3c: 48 83 c4 08                   addq    $0x8, %rsp
       40: 5b                            popq    %rbx
       41: 41 5e                         popq    %r14
       43: 41 5f                         popq    %r15
       45: 5d                            popq    %rbp
       46: c3                            retq

foo()'s argument 'f' is first loaded and saved to an callee saved register:
     movl    %r9d, %ebx

and after the first bar1(), it did
     movl    %ebx, %r9d
to push as #6 argument.

So I think we can enforce certain rules (as mentioned in the above)
in the verifier.

>
> Additionally, does EMIT_mov(dst_reg, X86_REG_R9) zero-extend sub-register
> loads?

Only 64-bit register-to-register is supported.

>
> This generates a full 64-bit register-to-register move regardless of the load
> size. For smaller loads like BPF_B, BPF semantics require the value to be
> zero-extended.
>
> Since the entire 64-bit R9 register is copied without zeroing the upper 56
> bits, garbage left by the caller in the upper bits will leak into the
> destination register, breaking the bounds tracked by the verifier.
>

