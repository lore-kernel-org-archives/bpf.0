Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748402C159A;
	Sat, 18 Apr 2026 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776530590; cv=none; b=kG/Z79LvvYVQICra2fRe3V+5Pj5yMK4xA6QUyfnRQNeOkH5MTXJgsa3MXeVsOdjfW+75M5uptO2DUyWa+WXGF6/g62do3mkCiV/cexXyHZ0SN0cmDMn7tz3xWudnKCI3W4pLFSltJ7TZuJYKXMyPPvvImICPW93B9b/dcWSLYpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776530590; c=relaxed/simple;
	bh=gUl9wFwl/EkshrHahMjm655VgjyXxXiXxD1MKAwY6D4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k7Zd93F+BTkhGDNA0LMufo8KTkqCzRnASb+kD4FjW2HsgZNsX+f1OYgtn0hUx3XVY1VbhD0YH58JMNAPGTVop4WjGOAkr+ahyHav8tB80uF2ihUDbK7kfynXyIhuev3rT0yGYNX36RcB0wYPDLyhvxC2iS3UDOZfaUtN0CU9/YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrqO0eqa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrqO0eqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A73C19424;
	Sat, 18 Apr 2026 16:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776530590;
	bh=gUl9wFwl/EkshrHahMjm655VgjyXxXiXxD1MKAwY6D4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XrqO0eqaTBm1wSjaPkzi1IDg2TunOFRyHW2WCK+d1fJ0uW8vOOHmkIQaAe2zVr/8b
	 AedQyP3Pildb4WRe3cFM0lQc+h3ZKfrm4v1+hX5iW384lyNiYToBg3AxUHfNynN9Dh
	 gbA5cAG1k9NLmN1x+ucivYiqWEpflyGsUrs+NppfyeoF0fuRIihKKlBLF6Gt76ZuEH
	 +5l2wB+ksDdF7jv7CWyP6YmcCIfkKXOPD59OOpMWFRn59bUuMWe9CUAhd8yua4Jl5s
	 79yqwc0x2JfEnBI9cViZT3wU6ADB3JuDmJMNQ1awkZu+RkQ9ISD25tVW7EDpwJAW4i
	 N1qQ0OFS4BXEg==
From: Puranjay Mohan <puranjay@kernel.org>
To: sashiko@lists.linux.dev, Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next v5 13/16] bpf,x86: Implement JIT support for
 stack arguments
In-Reply-To: <20260417044443.66D37C19425@smtp.kernel.org>
References: <20260417034823.2632289-1-yonghong.song@linux.dev>
 <20260417044443.66D37C19425@smtp.kernel.org>
Date: Sat, 18 Apr 2026 17:43:03 +0100
Message-ID: <m2se8s1ap4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Sashiko AI review found 4 potential issue(s):
> - [High] Data corruption of Argument 6 across function calls due to calle=
r-saved register clobbering.
> - [High] Missing size handling for Argument 6 allows verifier bounds trac=
king bypass and out-of-bounds memory writes.
> - [High] The offset translation formula for outgoing arguments 7+ reverse=
s the memory layout, corrupting sub-slot accesses.
> - [Medium] The JIT misroutes stack accesses because it rigidly assumes LD=
X only targets incoming arguments and STX/ST only target outgoing arguments.
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
>
> [ ... ]
>
>> @@ -1664,16 +1692,45 @@ static int do_jit(struct bpf_prog *bpf_prog, int=
 *addrs, u8 *image, u8 *rw_image
>>  	stack_depth =3D bpf_prog->aux->stack_depth;
>> +	stack_arg_depth =3D bpf_prog->aux->stack_arg_depth;
>> +	incoming_stack_arg_depth =3D bpf_prog->aux->incoming_stack_arg_depth;
>> +	outgoing_stack_arg_depth =3D stack_arg_depth - incoming_stack_arg_dept=
h;
>>  	priv_stack_ptr =3D bpf_prog->aux->priv_stack_ptr;
>>  	if (priv_stack_ptr) {
>>  		priv_frame_ptr =3D priv_stack_ptr + PRIV_STACK_GUARD_SZ + round_up(st=
ack_depth, 8);
>>  		stack_depth =3D 0;
>>  	}
>>=20=20
>> +	/*
>> +	 * Follow x86-64 calling convention for both BPF-to-BPF and
>> +	 * kfunc calls:
>> +	 *   - Arg 6 is passed in R9 register
>> +	 *   - Args 7+ are passed on the stack at [rsp]
>
> Can the use of the R9 register cause data corruption across function call=
s?
>
> The x86-64 C calling convention defines R9 as a caller-saved register.
> However, the BPF verifier models argument 6 as stack memory, which implies
> its value should be preserved across calls.
>
> If a BPF program reads incoming argument 6 after making a helper or kfunc
> call, will it receive a clobbered value instead of the original argument?
> Similarly, could a helper call scheduled by LLVM between the setup of
> outgoing argument 6 and the target call corrupt the R9 register?
>
> [ ... ]

This is correct analysis, I just realized that sashiko has already found
this!

>
>> +	/*
>> +	 * Base offset from rbp for translating BPF outgoing args 7+
>> +	 * to native offsets. BPF uses negative offsets from r11
>> +	 * (r11-8 for arg6, r11-16 for arg7, ...) while x86 uses
>> +	 * positive offsets from rsp ([rsp+0] for arg7, [rsp+8] for
>> +	 * arg8, ...). Arg 6 goes to R9 directly.
>> +	 *
>> +	 * The translation reverses direction:
>> +	 *   native_off =3D outgoing_arg_base - outgoing_rsp - bpf_off - 16
>> +	 *
>> +	 * Note that tail_call_reachable is guaranteed to be false when
>> +	 * stack args exist, so tcc pushes need not be accounted for.
>> +	 */
>
> Does this formula correctly handle multi-byte sub-slot accesses?
>
> Since the formula subtracts the BPF offset, the memory layout within the
> 8-byte slots appears mathematically reversed. While this correctly maps t=
he
> 8-byte slot bases (e.g., -16 maps to rsp + 0), it seems to point to the
> wrong memory for partial writes.
>
> For example, if a program writes to the upper 32 bits of Arg 7 at BPF off=
set
> -12, the formula yields BASE - (-12) - 16 =3D BASE - 4. Will this map the
> access out-of-bounds below the stack pointer instead of to [rsp + 4]?
>
> [ ... ]
>
>> @@ -2129,12 +2222,26 @@ static int do_jit(struct bpf_prog *bpf_prog, int=
 *addrs, u8 *image, u8 *rw_image
>>  				EMIT1(0xC7);
>>  			goto st;
>>  		case BPF_ST | BPF_MEM | BPF_DW:
>> +			if (dst_reg =3D=3D BPF_REG_PARAMS && insn->off =3D=3D -8) {
>> +				/* Arg 6: store immediate in r9 register */
>> +				emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31, (u32)imm32);
>> +				break;
>> +			}
>>  			EMIT2(add_1mod(0x48, dst_reg), 0xC7);
>>=20=20
>> -st:			if (is_imm8(insn->off))
>> -				EMIT2(add_1reg(0x40, dst_reg), insn->off);
>> +st:			insn_off =3D insn->off;
>> +			if (dst_reg =3D=3D BPF_REG_PARAMS) {
>> +				/* Args 7+: reverse BPF negative offsets to
>> +				 * x86 positive rsp offsets.
>> +				 * BPF off=3D-16 =E2=86=92 [rsp+0], off=3D-24 =E2=86=92 [rsp+8], ...
>> +				 */
>> +				insn_off =3D outgoing_arg_base - outgoing_rsp - insn_off - 16;
>> +				dst_reg =3D BPF_REG_FP;
>> +			}
>
> Are the size constraints missing for Argument 6 here?
>
> The check for Arg 6 (insn->off =3D=3D -8) is only implemented under the B=
PF_DW
> case. For sizes B, H, and W, execution will fall through to the st: label.
> This would incorrectly translate the access as a normal stack operation
> using the formula above, writing out-of-bounds below the stack pointer at
> [rsp - 8] instead of populating R9.
>
> Additionally, for BPF_LDX, a 1-byte load emits a full 64-bit move to R9.
> Since the upper 56 bits of R9 are undefined for 1-byte arguments, could
> they contain garbage data? This would bypass the verifier's strict value
> bounds tracking, which assumes the loaded value is strictly within [0, 25=
5].
>
> [ ... ]
>
>> @@ -2243,6 +2360,19 @@ st:			if (is_imm8(insn->off))
>>  		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
>>  		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
>>  			insn_off =3D insn->off;
>> +			if (src_reg =3D=3D BPF_REG_PARAMS) {
>> +				if (insn_off =3D=3D 8) {
>> +					/* Incoming arg 6: read from r9 */
>> +					EMIT_mov(dst_reg, X86_REG_R9);
>> +					break;
>> +				}
>> +				src_reg =3D BPF_REG_FP;
>> +				/*
>> +				 * Incoming args 7+: native_off =3D=3D bpf_off
>> +				 * (r11+16 =E2=86=92 [rbp+16], r11+24 =E2=86=92 [rbp+24], ...)
>> +				 * No offset adjustment needed.
>> +				 */
>> +			}
>
> Does this logic misroute stack accesses by assuming LDX always targets
> incoming arguments and STX/ST always target outgoing arguments?
>
> If a program writes an outgoing argument ([r11 - 16]) and then reads it b=
ack
> via LDX, the JIT appears to apply the incoming argument translation mappi=
ng
> the read to [rbp - 16] (the local stack) instead of [rsp] (the outgoing
> area). This would return uninitialized data.
>
> Conversely, if a program modifies an incoming argument ([r11 + 16]) using
> STX, the JIT would apply the outgoing translation formula, yielding
> BASE - 16 - 16 =3D BASE - 32, which writes out-of-bounds below the stack
> pointer.
>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417034658.26=
25353-1-yonghong.song@linux.dev?part=3D13
