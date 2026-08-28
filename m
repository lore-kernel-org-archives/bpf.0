Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B223F1048;
	Fri, 28 Aug 2026 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787913035; cv=none; b=nqw6fVyixa6CCUUpFIjeGIH2GEZ9T7DeCVK6PS6uNJndxkqDYd77Xx0gU4NW7FML56QngMmQ93f+9CjS5eqzrqrRwCJXNa1C2Y+Bm2yU3nzGfDgZFTlEjcysT+OdciNHuEwdqi1pt+LfroW3rxNk80FAGmvxcmQ+3HerDcsQuuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787913035; c=relaxed/simple;
	bh=Wlt+2CO99ZmXhyR+lCIewkmzP6HA+pE7Y3qrqbEPgXk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ag5KyU3+GSpmCHti9P0G4boEuOYePxQjXHozSYC3QRssihS1ubNoCBDBTxYNAihTpDURCv7JTZcUFkLGclTyGSMTbzb422oCRXIpR0k4ggJZngNPKd/+L8oULQYwsCwsTYsL2nJi+lgrbA06z/1fh0g9u0fdBWv98tHcE7HDBes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjtdcSO0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjtdcSO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52D31F000E9;
	Fri, 28 Aug 2026 10:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787913033;
	bh=RmJoucMctLRMuSUCsTwyUyIfYdguA9J4mgZCdQkjssE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kjtdcSO0eP3Ok+JpjhQBBk2wSSquCcZM1MorQKfp71kYqmIu4yy90QSGbCweHX6np
	 wIJ9vL2irQndar13q7VvRzJ6S/tgl3O1iPQ6OL2vCb0mu15URfUAb2cJOu/oeM1OpY
	 mPapHns22xSDbyd6flFln6YxBGla+QWEChfXjVUj7w5jMLCi5SOgK2a/aGMt6d/cec
	 v8XhM2N8gOSPS24h+YjBpkqSCOtla9KL5RV2tuV+XOMDLlPenN8zk3cHwu5INk4dDP
	 3TD9qN8mDBpf83SnTa98tOQWY4Zs6y9GqMP5ZOtk2FSXduT3STRjoZ5LwncC6JHqxT
	 BenLbKFH3L+gg==
Content-Type: multipart/mixed; boundary="===============4366746843011688961=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <25c4fc03d83c879c13ac1df190046881f7f969ffa532b904597ca9947c750d53@mail.kernel.org>
In-Reply-To: <20260828-kasan-v8-4-7c1c0fdb9d7f@bootlin.com>
References: <20260828-kasan-v8-4-7c1c0fdb9d7f@bootlin.com>
Subject: Re: [PATCH bpf-next v8 4/8] bpf, x86: emit KASAN checks in x86 JITed programs
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,tglx@kernel.org,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org,mingo@redhat.com,andreyknvl@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,laoar.shao@gmail.com
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 28 Aug 2026 10:30:32 +0000 (UTC)

--===============4366746843011688961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 13ba3232993ac..adb62216dd204 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -1110,6 +1121,92 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, bool is64)
>  	*pprog = prog;
>  }
>
> +static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
> +			    u32 addr_reg, struct bpf_insn *insn, u8 *ip,
> +			    bool is_write)
> +{
> +#ifdef CONFIG_BPF_JIT_KASAN
> +	u32 bpf_size = BPF_SIZE(insn->code);
> +	s32 off = insn->off;

Does emit_kasan_check need to re-read insn->off here rather than taking
the effective displacement as a parameter? At the BPF_STX | BPF_MEM site
(line 2458), do_jit() remaps the offset for stack arguments:

    insn_off = insn->off;
    if (dst_reg == BPF_REG_PARAMS) {
        insn_off = outgoing_arg_base - outgoing_rsp - insn_off - 16;
        dst_reg = BPF_REG_FP;
    }
    ...
    emit_kasan_check(env, &prog, dst_reg, insn, ip, true);
    emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);

The check receives the remapped dst_reg (BPF_REG_FP) but re-derives the
offset from insn->off, so the check validates 'rbp + insn->off' while
emit_stx() writes to 'rbp + insn_off'.

The BPF_ST | BPF_MEM case (line 2432) has a second issue: the check
runs before any register remapping, so it is given the raw dst_reg:

    if (!accesses_stack_only) {
        err = emit_kasan_check(env, &prog, dst_reg, insn, ip, true);
        ...
    }
    emit_st(&prog, insn, dst_reg, outgoing_arg_base, outgoing_rsp);

When dst_reg == BPF_REG_PARAMS (MAX_BPF_REG == 11), emit_st() remaps
both the register and offset internally, but emit_kasan_check() receives
the raw value. reg2hex[] has no entry for index 11, so reg2hex[11] == 0
and EMIT_mov(BPF_REG_1, BPF_REG_PARAMS) encodes 'mov rdi, rax'. The
check then validates 'rax + insn->off' - RAX being BPF R0, an arbitrary
program value - while the store goes to the outgoing-argument slot.

In the BPF_DW / insn->off == -8 sub-case of BPF_ST, emit_st() performs
no memory access at all (the value is materialized into R9), yet a full
__asan_store8 check is still emitted.

The BPF_LDX path (line 2645) handles this correctly: it remaps to
BPF_REG_FP before calling emit_kasan_check(), and the incoming-arg case
skips the check entirely.

Would passing the effective displacement to emit_kasan_check() as an
explicit parameter fix both the BPF_STX offset mismatch and let the
BPF_ST path perform the remap before the check?

> +	u8 *prog = *pprog;
> +	void *kasan_func;
> +
> +	if (!env)
> +		return 0;

[ ... ]

> @@ -1911,10 +2026,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  		const s32 imm32 = insn->imm;
>  		u32 dst_reg = insn->dst_reg;
>  		u32 src_reg = insn->src_reg;
> +		bool accesses_stack_only;
>  		u8 b2 = 0, b3 = 0;
>  		u8 *start_of_ldx;
>  		s64 jmp_offset;
>  		s32 insn_off;
> +		int insn_idx;
>  		u8 jmp_cond;
>  		u8 *func;
>  		int nops;
> @@ -1931,6 +2048,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  			EMIT_ENDBR();
>
>  		ip = image + addrs[i - 1] + (prog - temp);
> +		insn_idx = i - 1 + bpf_prog->aux->subprog_start;
> +		accesses_stack_only =
> +			env ? !env->insn_aux_data[insn_idx].non_stack_access :
> +			      false;

This isn't a bug, but when env == NULL, accesses_stack_only is set to
false ('not stack-only, do instrument'), yet every call site then
enters emit_kasan_check() which only no-ops because of its own 'if
(!env) return 0;' guard. Would 'env ? ... : true' make the fail-safe
default self-evident and avoid depending on emit_kasan_check()'s
internal guard for correctness?

Also, the '!env' test plus 'insn_idx += aux->subprog_start' is already
encapsulated by bpf_insn_is_indirect_target() (kernel/bpf/core.c:1646-
1652). Would a small helper like bpf_insn_accesses_non_stack(env, prog,
i - 1) keep the arch-independent invariant in one place and let other
JITs reuse it when they gain KASAN support?

> +
>  		switch (insn->code) {
>  			/* ALU */

[ ... ]

> @@ -2311,6 +2432,13 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  		case BPF_ST | BPF_MEM | BPF_H:
>  		case BPF_ST | BPF_MEM | BPF_W:
>  		case BPF_ST | BPF_MEM | BPF_DW:
> +			if (!accesses_stack_only) {
> +				err = emit_kasan_check(env, &prog, dst_reg,
> +						       insn, ip, true);
> +				if (err)
> +					return err;
> +			}
> +
>  			emit_st(&prog, insn, dst_reg, outgoing_arg_base,
>  				outgoing_rsp);
>  			break;
> @@ -2330,6 +2458,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  				insn_off = outgoing_arg_base - outgoing_rsp - insn_off - 16;
>  				dst_reg = BPF_REG_FP;
>  			}
> +			if (!accesses_stack_only) {
> +				err = emit_kasan_check(env, &prog, dst_reg,
> +						       insn, ip, true);
> +				if (err)
> +					return err;
> +			}
>  			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
>  			break;
>

[ ... ]

> @@ -2572,28 +2711,42 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  			}
>  			fallthrough;
>  		case BPF_STX | BPF_ATOMIC | BPF_W:
> -		case BPF_STX | BPF_ATOMIC | BPF_DW:
> -			if (insn->imm == (BPF_AND | BPF_FETCH) ||
> -			    insn->imm == (BPF_OR | BPF_FETCH) ||
> -			    insn->imm == (BPF_XOR | BPF_FETCH)) {
> -				bool is64 = BPF_SIZE(insn->code) == BPF_DW;
> -				u32 real_src_reg = src_reg;
> -				u32 real_dst_reg = dst_reg;
> -				u8 *branch_target;
> -
> +		case BPF_STX | BPF_ATOMIC | BPF_DW: {
> +			bool is64 = BPF_SIZE(insn->code) == BPF_DW;
> +			u32 real_src_reg = src_reg;
> +			u32 real_dst_reg = dst_reg;
> +			u8 *branch_target;
> +			u8 *pprog;
> +			bool is_atomic_fetch =
> +				(insn->imm == (BPF_AND | BPF_FETCH) ||
> +				 insn->imm == (BPF_OR | BPF_FETCH) ||
> +				 insn->imm == (BPF_XOR | BPF_FETCH));
> +			if (is_atomic_fetch) {
>  				/*
>  				 * Can't be implemented with a single x86 insn.
>  				 * Need to do a CMPXCHG loop.
>  				 */
>
>  				/* Will need RAX as a CMPXCHG operand so save R0 */
> +				pprog = prog;
>  				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
>  				if (src_reg == BPF_REG_0)
>  					real_src_reg = BPF_REG_AX;
>  				if (dst_reg == BPF_REG_0)
>  					real_dst_reg = BPF_REG_AX;
> -
> +				ip += (prog - pprog);
> +			}
> +			if (!bpf_atomic_is_load_store(insn)) {
> +				if (!accesses_stack_only) {
> +					err = emit_kasan_check(env, &prog,
> +							       real_dst_reg,
> +							       insn, ip, true);
> +					if (err)
> +						return err;
> +				}
>  				branch_target = prog;
> +			}
> +			if (is_atomic_fetch) {
>  				/* Load old value */
>  				emit_ldx(&prog, BPF_SIZE(insn->code),
>  					 BPF_REG_0, real_dst_reg, insn->off);

This isn't a bug, but does the restructured atomic case now make
branch_target a dead store on the non-fetch paths? branch_target is
written for every non-load/store atomic (plain BPF_ADD, BPF_XCHG,
BPF_CMPXCHG without BPF_FETCH) but only read under 'if
(is_atomic_fetch)'. Would moving 'branch_target = prog;' into the
following 'if (is_atomic_fetch)' block keep the KASAN check outside the
retry loop while restoring the definition-next-to-use property?

Also, the new local 'u8 *pprog;' shadows the file-wide convention where
pprog is the u8 ** out-parameter of every emit_* helper.

> @@ -2625,15 +2778,16 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  			}
>
>  			if (bpf_atomic_is_load_store(insn))
> -				err = emit_atomic_ld_st(&prog, insn->imm, dst_reg, src_reg,
> -							insn->off, BPF_SIZE(insn->code));
> +				err = emit_atomic_ld_st(env, &prog, insn, ip,
> +							dst_reg, src_reg,
> +							accesses_stack_only);
>  			else
>  				err = emit_atomic_rmw(&prog, insn->imm, dst_reg, src_reg,
>  						      insn->off, BPF_SIZE(insn->code));
>  			if (err)
>  				return err;
>  			break;
> -
> +		}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33160000533
--===============4366746843011688961==--
