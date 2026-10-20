Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505844;
	b=k61fREuuQNmRGYyhWisNF6oGIUqo4Amc8qs5CZi/6AYbuZOgXYtKyGFqwjJkfHdzJqYh
	 5n/H7zQGOuET5rwLc9Ll8G4GNHweO+cwnWa04sZcYij+dklFpRma3MjCEbuTgIVBu7e4w
	 m7DDg1eT285mW7m0s1+gQFZzbu9GARiaRD2bzAPumfHLCAJI3FViS0IRnaLgBwutqpzIo
	 7idNZHhs9ErL0n4tHOEbqwKUIOHHFjc1bG3ZPOMVbPYw09gJvdwODpJzXu0YLqvqmRJ36
	 va4fRXw76MKmovqin4b3KOtSI7n9S3udGKStvZ3DCNzuNL60GJnbnH+QFTLXOhAIADw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505844;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=aYc1taK7uMyYnTsEH7WsazZvUMSVLI5YHVVoN7GDU9c=;
	b=nC/bplG6rMFy7YuKBtxgJOYlKUZSVUEeKAJbScBurttuAK6TBEtMWLfpg0+f19OlKbnG
	 K1qZAXWZAMpTqC91Z9dLDxfpfBdPM3Prd5s9mTgOypjOVp2zbIaLynUPDz610L7KgFN9h
	 uzscCAV4zL4RUdssWCZG+9k82Cw6VWGkP50obroCuzrlRLos3E0TMd84lFmtsviBqjqfj
	 RwMQ03BH3/pX1EGwoYgZj2MUzjqyBIrMHwBJRL4zWMTNazlfhJKLDDWCmaIedQiirFGb1
	 VqtuxBsMdH1mSYiCBnQ2335OBvI/4BkqUKRZMAYuIwZ2JQLRH019y3/AiOnvDZSNA+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luoYzxmc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB99606C235;
	Tue, 20 Oct 2026 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luoYzxmc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1640D1F000C4;
	Tue, 20 Oct 2026 14:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505843;
	bh=aYc1taK7uMyYnTsEH7WsazZvUMSVLI5YHVVoN7GDU9c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=luoYzxmc/F+UTlNlze62vT2dJLaBdLezV3sc598QmYRj1xZ3jQ/lD9w7kM2gdu5aL
	 +Y6NfwJ9UiwacblsV5r41p9s7grb1Fx/HkcjRQm340xZKsQf62XVeMnXQO3YTFno+5
	 jCQ5Qo7UxlkGMxNiBntnro0I1qRLvAa4sEKLJbletH7Hfb0xYFVlsxyLvZ0NyeiXiK
	 m85el9SUy1p0kj3L6BNapGzXySJ9IpExU7p2rDOmau1sqItto7EEt2fX76asjtPpsW
	 ZhNgJcpgbafVRjgktJQknP6UFNEEG7niwisUVrnYJ+G6+TU0zhZZ70QwfKPFVzHHrV
	 gHrGeSCs6yirw==
Content-Type: multipart/mixed; boundary="===============6288732239154521085=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8ee602c2c5d8b13b9cab72d89dc69c6bdb29a3ee729334bb597759d5500b315c@mail.kernel.org>
In-Reply-To: <1ada7d01118df6deb0707b1a17ff11e041d6ca80.1792503001.git.xukuohai@huawei.com>
References: <1ada7d01118df6deb0707b1a17ff11e041d6ca80.1792503001.git.xukuohai@huawei.com>
Subject: Re: [PATCH bpf-next 11/16] bpf, arm64: Add support for arena percpu
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,emil@etsalapatis.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 14:17:23 +0000 (UTC)

--===============6288732239154521085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, arm64: Add support for arena percpu

TL;DR: On arm64 (and likely x86), the arena percpu ld_imm64 yields a full
64-bit user address, so a direct load/store without addr_space_cast may hit
the wrong kernel address instead of the arena.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 1d5f4cf88d33..998806cc700e 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -1829,6 +1835,26 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
>  		else
>  			emit_a64_mov_i64(dst, imm64, ctx);
>  
> +#ifdef CONFIG_SMP
> +		if (insn->src_reg == BPF_PSEUDO_ARENA_PERCPU) {
> +			u32 chunk_sz = bpf_arena_percpu_chunk_sz(bpf_prog_arena(ctx->prog));
> +
> +			/* tmp = smp_processor_id() */
> +			emit_current_cpu_id(tmp, ctx);
> +			/*
> +			 * tmp *= chunk_sz
> +			 * arena_map_alloc() guarantees
> +			 * chunk_sz * nr_cpu_ids <= vm_range <= 4 GiB and
> +			 * cpu_number < nr_cpu_ids, so a 32-bit mul
> +			 * cannot overflow here.
> +			 */
> +			emit_a64_mov_i(0, tmp2, chunk_sz, ctx);
> +			emit(A64_MUL(0, tmp, tmp, tmp2), ctx);
> +			/* dst += tmp */
> +			emit(A64_ADD(1, dst, dst, tmp), ctx);

Can a direct dereference of this register end up outside the arena window?

For BPF_PSEUDO_ARENA_PERCPU, imm64 is user_vm_start + off (set up by
check_and_resolve_insns() from arena_map_direct_value_addr()), so after this
sequence dst holds the full 64-bit user virtual address plus cpu * chunk_sz.

The verifier types this register as PTR_TO_ARENA in check_ld_imm(), and
convert_ctx_accesses() rewrites loads and stores through it to
BPF_PROBE_MEM32 without any truncation.

Elsewhere a PTR_TO_ARENA register only holds a 32-bit arena offset.  The
cast_kern conversion is a mov32, and adjust_reg_min_max_vals() turns ALU64 on
PTR_TO_ARENA into ALU32.  Arena pages are mapped at kern_vm_start +
(u32)uaddr (see arena_vm_fault()).

The arm64 JIT then forms the address with a 64-bit add.  For LDX in
build_insn():

    if (BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
        BPF_MODE(insn->code) == BPF_PROBE_MEM32SX) {
            emit(A64_ADD(1, tmp2, src, arena_vm_base), ctx);
            src = tmp2;
    }

The ST and STX cases in build_insn() use the same pattern with dst, and so do
the PROBE_ATOMIC paths in emit_atomic_ld_st() and emit_lse_atomic():

    emit(A64_ADD(1, tmp, reg, arena_vm_base), ctx);

So a direct access through the pseudo-load result would touch
kern_vm_start + user_vm_start + off + cpu * chunk_sz, instead of
kern_vm_start + (u32)(user_vm_start + off) + cpu * chunk_sz.

These only agree when upper_32_bits(user_vm_start) == 0.  The verifier
requires user_vm_start to be set, and it is normally a high mmap address or
whatever map_extra the loader picked.

If the resulting address is unmapped, the exception handler zeroes the load
or skips the store, so the access silently fails.  If something else in
vmalloc space is mapped there, the program reads or writes unrelated kernel
memory, and map_extra lets the loader steer the offset.

There appear to be two ways to reach this.  One is the raw instruction
pattern used by the selftest at the end of this series (08224ba2de19):

    BPF_LD_IMM64_RAW(BPF_REG_1, BPF_PSEUDO_ARENA_PERCPU, 0)
    BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 0)

which loads successfully and only needs to be run.  The other is an object
built with the bpf_arena_common.h fallback (#define __arena_percpu
SEC(".arena.percpu") without __BPF_FEATURE_ADDR_SPACE_CAST, or with
BPF_ARENA_FORCE_ASM), where the compiler emits no addr_space_cast between the
ld_imm64 and the load or store.  LLVM output that does insert cast_kern is
not affected, since the mov32 truncates the value.

Before this patch arm64 rejected the pseudo instruction with -EOPNOTSUPP, so
returning true from bpf_jit_supports_arena_percpu_insn() is what makes this
reachable on arm64.  The x86 lowering in a27c971d206b looks to have the same
problem, since its PROBE_MEM32 addressing is [src + r12 + off] with a 64-bit
src.  No later commit in the series touches the kernel code.

Would keeping only the low 32 bits for the PTR_TO_ARENA view work, for
example a 32-bit move of (u32)imm64 followed by a 32-bit ADD of the per-cpu
offset?  Alternatively, should the verifier type the result like a regular
arena ld_imm64 (scalar / user address), so that the kernel-side access goes
through the existing 32-bit conversion?

> +		}
> +#endif


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39434884362
--===============6288732239154521085==--
