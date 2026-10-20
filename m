Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506695;
	b=F4QQA0w2B7+HWDsxBbYBeN+MA+Jbc0M09Meiq1aY4wGZSV9/B+VIIquMq+ipUjh7ChXF
	 hwfion/FaiJsgpAKEY64qWQooYRKijGDSCLf2Xo/vtSP0o3Gnx9GmVbl+7VgE4UKAX4lq
	 bJDlBv213BgMreqU8KDYgm5Vdov0VxE6L9tWUYtVFQpN4jrNna75cAiYDJ8VXNSge4na2
	 Pxa/sIyBzXjHRXNBSqlMLFYDj86zhY0xerfCpK0JdmOGUjSJnJMEf9ZKS5n498Z4Oe/nj
	 BtBl97mDNaum1tL/mPPkWAVUSIfYrqPinUb/o87pYQQh4fzOerxVTMMG7OI224LmVDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506695;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6lYKorWj87iYcvhys8M/egze+aiLqjvheFL9Lt/9ki4=;
	b=DMkkC7v7d7b0mhSsFfl+U1WLypNEanDMXN/eu8u48P7TiTFGrj1C6SaqjB3cKQXL630R
	 iuFS1tv8wyDDHzbuwrZXOnOKO7yX75iOMGUh6ePN6mrt9lAul0ySS6jayXQ09zLNOazKD
	 KW+NDoisVXMj9P80ms4ZRywHKe5ey6bU/jO0RTftZZnRivagtC7ivdfvFyjyrLGpO7K53
	 /a7lCfl1efUeDHYaA5CFweuRgAeWZa1NCqIqUqsAeWLuBtZkmo+BJG5t2tU18vtOSmPAO
	 0fZVcqmbKlmAa5xOdGiI9pjeWarH8e03eaqHQy+fP0UNX1nZ7mkmlEvAchp0S3w/5Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcGTrHKm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C8606A31E
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcGTrHKm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D191F000C4;
	Tue, 20 Oct 2026 14:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792506694;
	bh=6lYKorWj87iYcvhys8M/egze+aiLqjvheFL9Lt/9ki4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EcGTrHKmUoliUhTD6KxW2H6HiSAoWwrStf/z2ClFHVJY/rfSjkM121sUR5SeB4QJl
	 ckKP6Nl/fGA3L/GC2NJ+QrN1xFW91bNthb1Pos5Yhj/PpWkexKaGHz8PO9z044JUHK
	 sxTttDklQy0pfSRjv9Tz37nn0mGnO/uxpYsO4kNf8zSYohm/QHFtDXZfudtBSWS1AK
	 22wHE5MStPsCvHL9KKvpGSqIydLazoqJddmSlqIZwtPu6IwKApZkrS/9DU4B4oSxys
	 /3PKevjRtV/Kz7EN04h5sXggR993udu9hThk4WDYH0wmIZStJqvjkIOlJ5a9t0feFe
	 ZvKyHJJhtZOSA==
Message-ID: <sashiko-outbox-179141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 11/16] bpf, arm64: Add support for arena percpu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
In-Reply-To: <1ada7d01118df6deb0707b1a17ff11e041d6ca80.1792503001.git.xukuohai@huawei.com>
References: <cover.1792503001.git.xukuohai@huawei.com>
 <1ada7d01118df6deb0707b1a17ff11e041d6ca80.1792503001.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:31:33 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf, arm64: upper 32 bits not cleared for arena percpu in buil=
d_insn()
- [Low] bpf, arm64: link failure in build_insn() when CONFIG_BPF_SYSCALL=3Dn
--

commit 06cd99f2557b7d24037d63a9c40cf67ca1795637
Author: Xu Kuohai <xukuohai@huawei.com>

bpf, arm64: Add support for arena percpu

This commit adds arm64 JIT support for the BPF_PSEUDO_ARENA_PERCPU pseudo
instruction by computing smp_processor_id() * chunk_sz and adding it to CPU
0's arena address.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 1d5f4cf88d331..998806cc700eb 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -1829,6 +1835,26 @@ static int build_insn(const struct bpf_verifier_en=
v *env, const struct bpf_insn
>  		else
>  			emit_a64_mov_i64(dst, imm64, ctx);
> =20
> +#ifdef CONFIG_SMP
> +		if (insn->src_reg =3D=3D BPF_PSEUDO_ARENA_PERCPU) {
> +			u32 chunk_sz =3D bpf_arena_percpu_chunk_sz(bpf_prog_arena(ctx->prog));

[Severity: Low]
Will linking vmlinux fail with undefined references to bpf_prog_arena() and
bpf_arena_percpu_chunk_sz() when building with CONFIG_BPF_JIT=3Dy,
CONFIG_SMP=3Dy, and CONFIG_BPF_SYSCALL=3Dn?

arch/arm64/net/Makefile compiles bpf_jit_comp.o whenever CONFIG_BPF_JIT=3Dy,
whereas kernel/bpf/Makefile only builds arena.o when CONFIG_BPF_SYSCALL=3Dy:

kernel/bpf/Makefile:
    ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
    obj-$(CONFIG_BPF_SYSCALL) +=3D arena.o range_tree.o
    endif

Other arena helpers used by the JIT, such as bpf_arena_get_user_vm_start() =
and
bpf_arena_get_kern_vm_start(), have __weak fallbacks in kernel/bpf/core.c or
inline stubs in include/linux/bpf.h, but bpf_prog_arena() and
bpf_arena_percpu_chunk_sz() are only defined in kernel/bpf/arena.c.

> +
> +			/* tmp =3D smp_processor_id() */
> +			emit_current_cpu_id(tmp, ctx);
> +			/*
> +			 * tmp *=3D chunk_sz
> +			 * arena_map_alloc() guarantees
> +			 * chunk_sz * nr_cpu_ids <=3D vm_range <=3D 4 GiB and
> +			 * cpu_number < nr_cpu_ids, so a 32-bit mul
> +			 * cannot overflow here.
> +			 */
> +			emit_a64_mov_i(0, tmp2, chunk_sz, ctx);
> +			emit(A64_MUL(0, tmp, tmp, tmp2), ctx);
> +			/* dst +=3D tmp */
> +			emit(A64_ADD(1, dst, dst, tmp), ctx);
> +		}
> +#endif
> +
>  		return 1;
>  	}

[Severity: Critical]
Can this leave non-zero upper 32 bits in dst when arena->user_vm_start is at
or above 4 GiB, causing subsequent arena memory operations on dst to access
out-of-bounds kernel virtual memory?

In kernel/bpf/verifier.c:check_and_resolve_insns(), BPF_PSEUDO_ARENA_PERCPU
is resolved via arena_map_direct_value_addr() to the full 64-bit
arena->user_vm_start + off:

    err =3D map->ops->map_direct_value_addr(map, &addr, off);
    ...
    aux->map_off =3D off;
    addr +=3D off;
    ...
    insn[0].imm =3D (u32)addr;
    insn[1].imm =3D addr >> 32;

Unlike BPF_PSEUDO_MAP_VALUE (which marks the register as SCALAR_VALUE so th=
at
dereferencing it requires an addr_space_cast or scalar access fixup that
truncates the value to 32 bits), check_ld_imm() marks the destination regis=
ter
of BPF_PSEUDO_ARENA_PERCPU directly as PTR_TO_ARENA:

    if (insn->src_reg =3D=3D BPF_PSEUDO_ARENA_PERCPU) {
        u64 pos =3D aux->map_off - bpf_arena_percpu_chunk_off(map);
        ...
        __mark_reg_known(dst_reg, pos);
        dst_reg->type =3D PTR_TO_ARENA;
        dst_reg->mem_size =3D bpf_arena_percpu_chunk_sz(map);
    }

Because dst_reg is already PTR_TO_ARENA, it can be dereferenced directly by
BPF_LDX, BPF_STX, BPF_ST, or BPF_ATOMIC instructions without an intervening
addr_space_cast. In arch/arm64/net/bpf_jit_comp.c:build_insn(), the
BPF_PROBE_MEM32, BPF_PROBE_MEM32SX, and BPF_PROBE_ATOMIC handlers assume the
upper 32 bits of a PTR_TO_ARENA register are already cleared and perform an
unmasked 64-bit addition with arena_vm_base (kern_vm_start):

    if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32 ||
        BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32SX) {
        emit(A64_ADD(1, tmp2, src, arena_vm_base), ctx);
        src =3D tmp2;
    }

However, for BPF_PSEUDO_ARENA_PERCPU, build_insn() loads the full 64-bit im=
m64
via emit_a64_mov_i64(dst, imm64, ctx) and then either adds tmp with a 64-bit
A64_ADD(1, dst, dst, tmp) on CONFIG_SMP or leaves dst untouched on
!CONFIG_SMP. In both cases, bits [63:32] of dst retain user_vm_start >> 32,=
 so
dereferencing dst accesses kern_vm_start + user_vm_start + off + cpu_off
instead of kern_vm_start + (u32)(user_vm_start + off + cpu_off).

Should BPF_PSEUDO_ARENA_PERCPU zero-extend the 32-bit address on both
CONFIG_SMP and !CONFIG_SMP (for example, loading only the 32-bit imm and us=
ing
a 32-bit A64_ADD(0, dst, dst, tmp))?

[ ... ]

>
>--=20
>2.39.5
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792503001.gi=
t.xukuohai@huawei.com?part=3D11
