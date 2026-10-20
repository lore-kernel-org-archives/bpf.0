Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505572;
	b=sYeOVy9nQjqp7JTKA1NY+QuCccd1kmXZpOnF6XH3rhJDd8DDeP438xn8yNZi0ZdFq6Q9
	 tsEkq8jfHi24nlIFm7uPJacWn1Jn5CqpoyIEzr2AZw7noBdET2wCoQfYlIB3YqCeGgNOr
	 S0s5uRqLzcWC+nQSscrYgizgQqkdu08TCI5TLn0D0Xt8la5Sl3dse7AsWvxVx8a//gxKs
	 FtG46f2k/L/npRgeWlcYFFYEwOO6ebUsRLql44ihFwJAwOmEdMJFHELrCH1OJdeor7kav
	 PatNnkS76WpUmUFTuONA1iVjOtp1QmGKao50/PTmE/q9lqY3K//uHOvcKZgAAA2w7Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505572;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GD5llvseKZs+O5b0Tu0mTD1CIuSikTJlCdK4rXSWDW0=;
	b=jpa0jJ3xG3OXIKBquqM0XBAppeB6kZxE1M5s1wNhHscaiRx6Fy7PeJ72Ge+QypGs5Uzp
	 8Mqk8RVdoZq5pk0VQRF3fStqZbaNVe9M8hkFvK4QgbcNTl8aJbwtwLepvbxO+uFQVMX/0
	 8TVUbHjF6O/BhFZGN1cTpGSUfZy0jf3Opbk6PL0BBriV8TZSKWGvQwnR2xdHr7A5ujhZc
	 VxCFhbK3pQUiVQIVMTJIsJ9/EZKdUUHTxKhzmjBSvG1L+MqZkKh/llcWjeJQGGfiJj46U
	 LxOZ9YqgGxFAyEa5i4cBrKWXNMN7fGENOhGyNdJL1OlXbzmjpzsXAKwHdy8gZmxo0Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HJlGw38/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF260A2604
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJlGw38/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF75E1F000C4;
	Tue, 20 Oct 2026 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505572;
	bh=GD5llvseKZs+O5b0Tu0mTD1CIuSikTJlCdK4rXSWDW0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HJlGw38/k+DX5iAAnfiVBHGxituzp0ZER86E6T52rjl7YpdTan+HtIYTBLmKPoba/
	 GjxePVkq8Y344gtyIV2YrStN3t0siC0Btc+anlRH0s3ArSxVkejuMAicEUvik9HjCC
	 j0IBhXXWNbv5Af9uSa9mCoouLMywkNOqdVes34L7zVYj+7tTESVPhT5PbTUeu1Nt4A
	 8gGrReQXA0suGmX8/WXYNiFciLfPdquE9dy4IePiDI25bog6BQ3gYdmzlahDmtoiQR
	 6waitZ4Epu2uk0xiKgehr1R+gFiuBzAnLlhGyA8F/jyDswSN79urMY4c/HqUeV74k6
	 AX4AEdX9NXnkg==
Message-ID: <sashiko-outbox-179094@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 10/16] bpf, x86: Add support for arena percpu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
In-Reply-To: <f7b5dd9137eb77203be0c03841da50f9b020417f.1792503001.git.xukuohai@huawei.com>
References: <cover.1792503001.git.xukuohai@huawei.com>
 <f7b5dd9137eb77203be0c03841da50f9b020417f.1792503001.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:12:50 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf, x86: non-zero upper 32 bits in do_jit() for BPF_PSEUDO_AR=
ENA_PERCPU
--

commit 34dfe71210a640d381ba611ce04d0354e5fd7cd0
Author: Xu Kuohai <xukuohai@huawei.com>

bpf, x86: Add support for arena percpu

This commit adds x86 JIT support for the BPF_PSEUDO_ARENA_PERCPU pseudo
instruction, translating the per-CPU arena address by adding
smp_processor_id() * chunk_sz to CPU 0's address.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 72a2a0a89e033..7c09a4d90cd17 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2772,6 +2772,34 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
> =20
>  		case BPF_LD | BPF_IMM | BPF_DW:
>  			emit_mov_imm64(&prog, dst_reg, insn[1].imm, insn[0].imm);
> +
> +#ifdef CONFIG_SMP
> +			if (insn->src_reg =3D=3D BPF_PSEUDO_ARENA_PERCPU) {
> +				u32 chunk_sz =3D bpf_arena_percpu_chunk_sz(bpf_prog_arena(bpf_prog));
> +
> +				/* aux =3D smp_processor_id(); mov aux, gs:[cpu_number] */
> +				EMIT2(0x65, add_2mod(0x40, 0, AUX_REG));
> +				EMIT3(0x8B, add_2reg(0x04, 0, AUX_REG), 0x25);
> +				EMIT((u32)(unsigned long)&cpu_number, 4);
> +
> +				/*
> +				 * aux *=3D chunk_sz
> +				 * arena_map_alloc() guarantees
> +				 * chunk_sz * nr_cpu_ids <=3D vm_range <=3D 4 GiB and
> +				 * cpu_number < nr_cpu_ids, so a 32-bit imul
> +				 * cannot overflow here.
> +				 */
> +				maybe_emit_mod(&prog, AUX_REG, AUX_REG, false);
> +				/* imul aux, aux, imm32 */
> +				EMIT2_off32(0x69, add_2reg(0xC0, AUX_REG, AUX_REG),
> +					    chunk_sz);
> +
> +				/* dst +=3D aux */
> +				maybe_emit_mod(&prog, dst_reg, AUX_REG, true);
> +				EMIT2(0x01, add_2reg(0xC0, dst_reg, AUX_REG));
> +			}
> +#endif

[Severity: Critical]
Does this leave non-zero upper 32 bits in dst_reg for BPF_PSEUDO_ARENA_PERC=
PU
instructions?

In check_and_resolve_insns(), BPF_PSEUDO_ARENA_PERCPU resolves the base
address via arena_map_direct_value_addr(), which sets
addr =3D arena->user_vm_start + off and populates insn[1].imm with the uppe=
r 32
bits:

kernel/bpf/verifier.c:check_and_resolve_insns() {
	...
	err =3D map->ops->map_direct_value_addr(map, &addr, off);
	...
	aux->map_off =3D off;
	addr +=3D off;
	...
	insn[0].imm =3D (u32)addr;
	insn[1].imm =3D addr >> 32;
}

In check_ld_imm(), BPF_PSEUDO_ARENA_PERCPU marks dst_reg directly as
PTR_TO_ARENA, so the verifier allows direct BPF_LDX, BPF_STX, BPF_ST, and
BPF_ATOMIC accesses through dst_reg without an intervening addr_space_cast =
or
32-bit truncation:

kernel/bpf/verifier.c:check_ld_imm() {
	...
	if (insn->src_reg =3D=3D BPF_PSEUDO_ARENA_PERCPU) {
		u64 pos =3D aux->map_off - bpf_arena_percpu_chunk_off(map);

		__mark_reg_known(dst_reg, pos);
		dst_reg->type =3D PTR_TO_ARENA;
		dst_reg->mem_size =3D bpf_arena_percpu_chunk_sz(map);
	}
}

In do_jit(), arena loads, stores, and atomics emit 64-bit indexed addressing
with r12 (kern_vm_start) via emit_ldx_r12(), emit_ldsx_r12(), emit_stx_r12(=
),
emit_st_r12(), and emit_atomic_rmw_index(), and ex_handler_bpf() passes the
faulting register value to bpf_prog_report_arena_violation(), which all rely
on the upper 32 bits of a PTR_TO_ARENA register being zero.

However, emit_mov_imm64() loads the full 64-bit user_vm_start + off into
dst_reg (including non-zero insn[1].imm when user_vm_start >=3D 4 GiB), and=
 the
64-bit addition on CONFIG_SMP (or no-op on !CONFIG_SMP) preserves those upp=
er
32 bits. When dst_reg is dereferenced, the memory access computes
kern_vm_start + user_vm_start + off + cpu * chunk_sz instead of
kern_vm_start + (u32)(user_vm_start + off + cpu * chunk_sz), accessing out =
of
bounds of the arena vmalloc region (or arbitrary 64-bit kernel virtual
addresses via user-controlled attr->map_extra).

Should BPF_PSEUDO_ARENA_PERCPU zero-extend the 32-bit address on both
CONFIG_SMP and !CONFIG_SMP (for example by loading only the lower 32 bits
insn[0].imm and using a 32-bit add)?

> +
>  			insn++;
>  			i++;
>  			break;

[ ... ]

=E5=AE=8C=E7=BE=8E=EF=BC=81=E8=BE=93=E5=87=BA=E7=BB=93=E6=9D=9F=E3=80=82

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792503001.gi=
t.xukuohai@huawei.com?part=3D10
