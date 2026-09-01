Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B94490BFE;
	Tue,  1 Sep 2026 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285558; cv=none; b=uvq5pVkU5tnh6qyhtEKhxUSgwqCQUWloF/mKXc0+EeqjLhCMi6FIY/G9qi/lwO50OYOBcYwE3UaVp7zyivArftCEeQpSBFI0/Vh/oUKHzhJZME0x/OrqPi8QXVL6oXa4fEJjxxC6d+myaof4vhFgEMWLahn184f76xwq93R5yOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285558; c=relaxed/simple;
	bh=roF+e+hdaiMHtH92MP23h6CasbLm+AugGgJns+zy0lk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Hv07eQ1SJ5wBkzqZBlCaYsok1Mr5NWteqksfUs/RJvDSPvzKsEz+Il5xTUr/KNpGrFn/OE4nUiKS1qM6Ik0zLbpmTdAKeSlSVqZWqysUFIHSi1CczWYOObG+vg6xmKjVI5LO9tBWWB4ChcBd/ndAIt19QBOQQ81Vc33Wly6dAuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0g1dp5U/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0g1dp5U/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F242A4E414A2;
	Tue,  1 Sep 2026 17:59:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B929B6053C;
	Tue,  1 Sep 2026 17:59:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 632ED11C7929D;
	Tue,  1 Sep 2026 19:58:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788285547; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZGg5+0PXOpr2qKFOyZDL1NQc/onpOdowko845pW6LhU=;
	b=0g1dp5U/kpCeWZ3Kju2KhkhNfbtl7+eM4Xd4Z7HN49CZcsYmL8fpofuUOdsjuZL4vEhbau
	aJ/qPMmP9MnguFUszlo5wYPE4PPdCM+GtS6P04ferWkCIkZHkrLeCsKL62Xxl5q909tY/N
	rpnippCjBV5hoxpPAp+emdkvPdKi3rToq7iQfoG7IfAxX6C0ZC0zqjLCghdf2w9UQVgSUm
	E/ReHcV2JVIP3dVIVVj+oE1nBAO+dveI0EiL3AvdI+HZaPOUL7rQIcvLdvBIThavWmHFNA
	IVxSOODQqsXRWyfe7tat/v0TTZbzNVd191jCtm3QGmsu+qQBJ+myZQCRtioN5g==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 19:58:54 +0200
Message-Id: <DL46BD4OVWZ2.6X01VIKUVCA5@bootlin.com>
Subject: Re: [PATCH bpf-next v8 4/8] bpf, x86: emit KASAN checks in x86
 JITed programs
Cc: <ebpf@linuxfoundation.org>, <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <martin.lau@kernel.org>, <clm@meta.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <bot+bpf-ci@kernel.org>, <alexis.lothore@bootlin.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <tglx@kernel.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, <hpa@zytor.com>, <shuah@kernel.org>, <mingo@redhat.com>,
 <andreyknvl@gmail.com>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <laoar.shao@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260828-kasan-v8-4-7c1c0fdb9d7f@bootlin.com>
 <25c4fc03d83c879c13ac1df190046881f7f969ffa532b904597ca9947c750d53@mail.kernel.org>
In-Reply-To: <25c4fc03d83c879c13ac1df190046881f7f969ffa532b904597ca9947c750d53@mail.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Aug 28, 2026 at 12:30 PM CEST, bot+bpf-ci wrote:
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 13ba3232993ac..adb62216dd204 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>
> [ ... ]
>
>> @@ -1110,6 +1121,92 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, =
bool is64)
>>  	*pprog =3D prog;
>>  }
>>
>> +static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
>> +			    u32 addr_reg, struct bpf_insn *insn, u8 *ip,
>> +			    bool is_write)
>> +{
>> +#ifdef CONFIG_BPF_JIT_KASAN
>> +	u32 bpf_size =3D BPF_SIZE(insn->code);
>> +	s32 off =3D insn->off;
>
> Does emit_kasan_check need to re-read insn->off here rather than taking
> the effective displacement as a parameter? At the BPF_STX | BPF_MEM site
> (line 2458), do_jit() remaps the offset for stack arguments:
>
>     insn_off =3D insn->off;
>     if (dst_reg =3D=3D BPF_REG_PARAMS) {
>         insn_off =3D outgoing_arg_base - outgoing_rsp - insn_off - 16;
>         dst_reg =3D BPF_REG_FP;
>     }
>     ...
>     emit_kasan_check(env, &prog, dst_reg, insn, ip, true);
>     emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
>
> The check receives the remapped dst_reg (BPF_REG_FP) but re-derives the
> offset from insn->off, so the check validates 'rbp + insn->off' while
> emit_stx() writes to 'rbp + insn_off'.

This one is right, I managed to reproduce it with a sample program
similar to those for the args on stack selftests, JIT hardening
enabled and cpuv4:
- arg pushed on stack with cpuv4: BPF_ST|BPF_MEM|BPF_DW with dst_reg =3D
  BPF_REG_PARAMS
- hardening + ST on constant: constant pushed on stack is blinded,
  program is patched with MOV + XOR + STX, the last one is marked as
  non-stack accessing, per commit 1/8
- JIT compiler enters the branch mentioned above and uses wrong offset
  for the KASAN check, so we insert an unwanted stack access check AND
  we check it at the wrong offset.

This made me realize that the series did not have this specific issues,
as args-on-stack feature has been merged quite recently. Rather than
adjusting the offset for a check that isn't really wanted (this is still
a stack access), I plan to just skip the KASAN check insertion if
dst_reg =3D=3D BPF_REG_PARAMS (or src_reg =3D=3D BPF_REG_PARAMS, for LDX).

> The BPF_ST | BPF_MEM case (line 2432) has a second issue: the check
> runs before any register remapping, so it is given the raw dst_reg:
>
>     if (!accesses_stack_only) {
>         err =3D emit_kasan_check(env, &prog, dst_reg, insn, ip, true);
>         ...
>     }
>     emit_st(&prog, insn, dst_reg, outgoing_arg_base, outgoing_rsp);
>
> When dst_reg =3D=3D BPF_REG_PARAMS (MAX_BPF_REG =3D=3D 11), emit_st() rem=
aps
> both the register and offset internally, but emit_kasan_check() receives
> the raw value. reg2hex[] has no entry for index 11, so reg2hex[11] =3D=3D=
 0
> and EMIT_mov(BPF_REG_1, BPF_REG_PARAMS) encodes 'mov rdi, rax'. The
> check then validates 'rax + insn->off' - RAX being BPF R0, an arbitrary
> program value - while the store goes to the outgoing-argument slot.
>
> In the BPF_DW / insn->off =3D=3D -8 sub-case of BPF_ST, emit_st() perform=
s
> no memory access at all (the value is materialized into R9), yet a full
> __asan_store8 check is still emitted.

Will be fixed the same way: skipping kasan check if dst_reg =3D=3D
BPF_REG_PARAMS.

> The BPF_LDX path (line 2645) handles this correctly: it remaps to
> BPF_REG_FP before calling emit_kasan_check(), and the incoming-arg case
> skips the check entirely.

And I'll make sure to skip the KASAN check in the LDX path as well.
>
> Would passing the effective displacement to emit_kasan_check() as an
> explicit parameter fix both the BPF_STX offset mismatch and let the
> BPF_ST path perform the remap before the check?
>
>> +	u8 *prog =3D *pprog;
>> +	void *kasan_func;
>> +
>> +	if (!env)
>> +		return 0;
>
> [ ... ]
>
>> @@ -1911,10 +2026,12 @@ static int do_jit(struct bpf_verifier_env *env, =
struct bpf_prog *bpf_prog, int *
>>  		const s32 imm32 =3D insn->imm;
>>  		u32 dst_reg =3D insn->dst_reg;
>>  		u32 src_reg =3D insn->src_reg;
>> +		bool accesses_stack_only;
>>  		u8 b2 =3D 0, b3 =3D 0;
>>  		u8 *start_of_ldx;
>>  		s64 jmp_offset;
>>  		s32 insn_off;
>> +		int insn_idx;
>>  		u8 jmp_cond;
>>  		u8 *func;
>>  		int nops;
>> @@ -1931,6 +2048,10 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
>>  			EMIT_ENDBR();
>>
>>  		ip =3D image + addrs[i - 1] + (prog - temp);
>> +		insn_idx =3D i - 1 + bpf_prog->aux->subprog_start;
>> +		accesses_stack_only =3D
>> +			env ? !env->insn_aux_data[insn_idx].non_stack_access :
>> +			      false;
>
> This isn't a bug, but when env =3D=3D NULL, accesses_stack_only is set to
> false ('not stack-only, do instrument'), yet every call site then
> enters emit_kasan_check() which only no-ops because of its own 'if
> (!env) return 0;' guard. Would 'env ? ... : true' make the fail-safe
> default self-evident and avoid depending on emit_kasan_check()'s
> internal guard for correctness?

I'm not really convinced it would make things better. Having 'env ? ...
: true' would also require to rename the variable to something likely
mouthful, as accesses_something_else_other_than_stack (yes, I'm
exaggerating a bit, but not so much), and as discussed in previous
reviews, the emit_kasan_checks calls will stay anyway, even in the no-op
case.

> Also, the '!env' test plus 'insn_idx +=3D aux->subprog_start' is already
> encapsulated by bpf_insn_is_indirect_target() (kernel/bpf/core.c:1646-
> 1652). Would a small helper like bpf_insn_accesses_non_stack(env, prog,
> i - 1) keep the arch-independent invariant in one place and let other
> JITs reuse it when they gain KASAN support?

There's a clear intent _not_ to bring KASAN support to other JIT
compilers, so there's no much value in a dedicated helper just to check
this flag. If that ever changes, I'll happily reconsider.

[...]

>> @@ -2572,28 +2711,42 @@ static int do_jit(struct bpf_verifier_env *env, =
struct bpf_prog *bpf_prog, int *
>>  			}
>>  			fallthrough;
>>  		case BPF_STX | BPF_ATOMIC | BPF_W:
>> -		case BPF_STX | BPF_ATOMIC | BPF_DW:
>> -			if (insn->imm =3D=3D (BPF_AND | BPF_FETCH) ||
>> -			    insn->imm =3D=3D (BPF_OR | BPF_FETCH) ||
>> -			    insn->imm =3D=3D (BPF_XOR | BPF_FETCH)) {
>> -				bool is64 =3D BPF_SIZE(insn->code) =3D=3D BPF_DW;
>> -				u32 real_src_reg =3D src_reg;
>> -				u32 real_dst_reg =3D dst_reg;
>> -				u8 *branch_target;
>> -
>> +		case BPF_STX | BPF_ATOMIC | BPF_DW: {
>> +			bool is64 =3D BPF_SIZE(insn->code) =3D=3D BPF_DW;
>> +			u32 real_src_reg =3D src_reg;
>> +			u32 real_dst_reg =3D dst_reg;
>> +			u8 *branch_target;
>> +			u8 *pprog;
>> +			bool is_atomic_fetch =3D
>> +				(insn->imm =3D=3D (BPF_AND | BPF_FETCH) ||
>> +				 insn->imm =3D=3D (BPF_OR | BPF_FETCH) ||
>> +				 insn->imm =3D=3D (BPF_XOR | BPF_FETCH));
>> +			if (is_atomic_fetch) {
>>  				/*
>>  				 * Can't be implemented with a single x86 insn.
>>  				 * Need to do a CMPXCHG loop.
>>  				 */
>>
>>  				/* Will need RAX as a CMPXCHG operand so save R0 */
>> +				pprog =3D prog;
>>  				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
>>  				if (src_reg =3D=3D BPF_REG_0)
>>  					real_src_reg =3D BPF_REG_AX;
>>  				if (dst_reg =3D=3D BPF_REG_0)
>>  					real_dst_reg =3D BPF_REG_AX;
>> -
>> +				ip +=3D (prog - pprog);
>> +			}
>> +			if (!bpf_atomic_is_load_store(insn)) {
>> +				if (!accesses_stack_only) {
>> +					err =3D emit_kasan_check(env, &prog,
>> +							       real_dst_reg,
>> +							       insn, ip, true);
>> +					if (err)
>> +						return err;
>> +				}
>>  				branch_target =3D prog;
>> +			}
>> +			if (is_atomic_fetch) {
>>  				/* Load old value */
>>  				emit_ldx(&prog, BPF_SIZE(insn->code),
>>  					 BPF_REG_0, real_dst_reg, insn->off);
>
> This isn't a bug, but does the restructured atomic case now make
> branch_target a dead store on the non-fetch paths? branch_target is
> written for every non-load/store atomic (plain BPF_ADD, BPF_XCHG,
> BPF_CMPXCHG without BPF_FETCH) but only read under 'if
> (is_atomic_fetch)'. Would moving 'branch_target =3D prog;' into the
> following 'if (is_atomic_fetch)' block keep the KASAN check outside the
> retry loop while restoring the definition-next-to-use property?

Indeed, I'll bring it back under the relevant if branch.

> Also, the new local 'u8 *pprog;' shadows the file-wide convention where
> pprog is the u8 ** out-parameter of every emit_* helper.

True, I'll rename it.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

