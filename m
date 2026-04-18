Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AED242D84
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776524098; cv=none; b=SasnX3BIRvjra2Wd/AANxXT/qcwa2jq/VLP1Mg13ez75G8desIHatpCI5SzReBgywWe1V3wxOz3292qmIWT5+hHewsO9Ehvpwtu0o7abtEfWzG9clowFmZLIwx++xUMW1LOdWSm7QITDhqG/zsQok28xFYhmzw5jexojKnvFtUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776524098; c=relaxed/simple;
	bh=EUwtujJYN73AD93r2WSI2VqSfnb6VWODurpb+7aUsVU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u/VOoz+vB1nA0uENOx9p8jPRrAaluSNZ9Vv8ZYYa+1C3RPvWAzrRSKaStMICnrD0NzeJUfVRQT9rq1grFQf9LKzF5yxdiUUtqEw9U9Xf9LLK2/gz8LIRO+TmxR32WF2znEDHwWVNWZvtYa0PSHyCs/p/+PKv/BzYbdwwwpIauuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsWUqOSS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsWUqOSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13A4C19424;
	Sat, 18 Apr 2026 14:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776524098;
	bh=EUwtujJYN73AD93r2WSI2VqSfnb6VWODurpb+7aUsVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HsWUqOSS+2oBXQx1UUItlNVRY5Qf0ELA4SdNlBUE03oYnsHN4+5PI2u+V6ddUXajX
	 GWseqNcjyYdwnQzUIUalvkLUrpxIHXj4pG99BnzY0KXwGWvkyC2O7UJLsAXXmmFYms
	 jQRks+PGDkxpUb3ur6dl7QCNiS1qGaNx2M7zLkD/amQz7AVhIiwYlAjCYg/PZuS8S2
	 uOYFAXZkrG2sPsUXHQ0cTWccVnKTN/gmLg1f0xWusamMmR3xW4woTaZHH/GGyEpv4Z
	 nhE0UC50pbp3rf+ILxw27e1WMOsURHGWujbe1HJZRo3VcGCze5eoDDAtXJdspUHPQk
	 Gq955YJoZt4PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v13 3/6] bpf: add bpf_cpu_time_counter_to_ns
 kfunc
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260418131614.1501848-4-puranjay@kernel.org>
References: <20260418131614.1501848-4-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 14:54:57 +0000
Message-Id: <20260418145457.E13A4C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Critical] JIT-emitted IMUL instruction sign-extends the 32-bit cyc2ns_mu=
l multiplier, corrupting the nanosecond conversion.
- [High] 64-bit truncation in JITted bpf_cpu_time_counter_to_ns causes seve=
re time overflow for intervals larger than ~4.3 seconds.
- [High] API unit inconsistency and TOCTOU race on sched_clock_stable() cau=
se silent unit corruption.
--

commit d48481a8aafecd7a1cb43ba6a7f2840fa2d497e3
Author: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: bpf: add bpf_cpu_time_counter_to_ns kfunc

Adds a bpf_cpu_time_counter_to_ns() kfunc to convert CPU cycle deltas
into nanoseconds. The kfunc is JIT inlined on x86 for low overhead,
leveraging cyc2ns multiplication and shift values.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -2480,6 +2481,31 @@ st:			if (is_imm8(insn->off))
>  				break;
>  			}
> =20
> +			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
> +			    imm32 =3D=3D BPF_CALL_IMM(bpf_cpu_time_counter_to_ns) &&
> +			    bpf_jit_inlines_kfunc_call(imm32)) {
> +				struct cyc2ns_data data;
> +				u32 mult, shift;
> +
> +				/* stable TSC runs with fixed frequency and
> +				 * transformation coefficients are also fixed
> +				 */
> +				cyc2ns_read_begin(&data);
> +				mult =3D data.cyc2ns_mul;
> +				shift =3D data.cyc2ns_shift;
> +				cyc2ns_read_end();
> +				/* imul RAX, RDI, mult */
> +				maybe_emit_mod(&prog, BPF_REG_1, BPF_REG_0, true);
> +				EMIT2_off32(0x69, add_2reg(0xC0, BPF_REG_1, BPF_REG_0),
> +					    mult);

Can this IMUL instruction corrupt the multiplication? The IMUL r64,
r/m64, imm32 instruction (opcode 0x69) sign-extends the 32-bit
immediate to 64 bits. Since data.cyc2ns_mul is heavily scaled to
retain precision, it is frequently >=3D 0x80000000.

When cyc2ns_mul >=3D 0x80000000, it would be sign-extended to a negative
64-bit value, drastically altering the product when multiplied with the
unsigned cycle count. Would it be safer to zero-extend the multiplier
by loading it into a scratch register first?

Will this 64-bit multiplication overflow for longer time intervals? The
IMUL r64, r/m64, imm32 instruction computes a 64x64-bit multiplication
but only stores the lower 64 bits of the product in the destination
register.

Because cyc2ns_mul is scaled up for precision, the product could overflow
the 64-bit register when the cycle count exceeds roughly 2^33 (around
4.3 seconds on a typical 2 GHz CPU). Could this be avoided by using the
MUL r/m64 instruction to compute the full 128-bit product in RDX:RAX
followed by SHRD?

> +
> +				/* shr RAX, shift (which is less than 64) */
> +				maybe_emit_1mod(&prog, BPF_REG_0, true);
> +				EMIT3(0xC1, add_1reg(0xE8, BPF_REG_0), shift);
> +
> +				break;
> +			}

[ ... ]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4674,6 +4674,11 @@ __bpf_kfunc u64 bpf_get_cpu_time_counter(void)
>  	return ktime_get_raw_fast_ns();
>  }
> =20
> +__bpf_kfunc u64 bpf_cpu_time_counter_to_ns(u64 counter)
> +{
> +	return counter;
> +}

Does this introduce an API unit inconsistency? bpf_get_cpu_time_counter()
returns raw cycles when JIT inlining is active on x86, but falls back to
ktime_get_raw_fast_ns() (nanoseconds) when JIT is disabled or on other
architectures. BPF programs exporting this value might output different
units depending on the environment.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19791,6 +19791,9 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
> =20
>  	if (!bpf_jit_supports_far_kfunc_call())
>  		insn->imm =3D BPF_CALL_IMM(desc->addr);
> +	/* if JIT will inline kfunc verifier shouldn't change the code */
> +	if (bpf_jit_inlines_kfunc_call(insn->imm))
> +		return 0;

[ ... ]

> @@ -19851,7 +19854,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
>  		__fixup_collection_insert_kfunc(&env->insn_aux_data[insn_idx], struct_=
meta_reg,
>  						node_offset_reg, insn, insn_buf, cnt);
>  	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_=
ctx] ||
> -		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_cast]) {
> +		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_cast] ||
> +		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_cpu_time_counter_to_=
ns]) {
>  		insn_buf[0] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>  		*cnt =3D 1;

Is there a race condition here involving sched_clock_stable()?
bpf_jit_inlines_kfunc_call() reads sched_clock_stable() which can change
dynamically.

If sched_clock_stable() returns false during verification,
bpf_fixup_kfunc_call() will replace bpf_cpu_time_counter_to_ns with a MOV
instruction. If it transitions to true before the JIT phase,
bpf_get_cpu_time_counter() will be inlined to emit RDTSC. In that
scenario, the program would receive raw cycles from the get kfunc but
use a no-op for the conversion, silently treating raw cycles as
nanoseconds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418131614.1501=
848-1-puranjay@kernel.org?part=3D3
