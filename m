Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506560;
	b=OlnEbBTq/GWnAJIqBgkvoekzXGjLz7ClsexfoG8a6Yoc8sEywqafff7NbylC+Pa7hbZe
	 jksZSyzaQiDJjlz0lgKk4mYqCu62wgiVK51gLViwWIg98nQ77/seiq64KULTw5QaHe+HR
	 qWvzfOqV8svs5DGla2oq1HVaKWj9dCz0ziztA5hclzbAhgOQkLo5IFpzdnv8cJHddb255
	 ymu4NlOT7nIoVeO18kcWJGktxurZLPC9c8DfJHEA0N+pbO71bMiefq674u2mLxjsxl0sV
	 WrOX1dQ9cFZOlQWCIsGcDP5h5KqHO091h9BSlkpdI3Qy6+27IUS58qPzt41Yn7+Hxjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506560;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=tnzmruvpw+zMT3qGYg1V/ubAlXjcG/6w9CFj+4EFdPg=;
	b=Zx4LgHdBLekRzhfYdp1ENbTwk+GPQCbyP0LaDtA+NY8qsHgQjZOc5QdSlSMMBod4jSG8
	 RMz/fz0nXkGPL0WVAH43tmzxCd7u4ni2vGaa5lSsyAKo2XlCNR0am2XC5e8zr1D5ieBmj
	 RH37sorAJmm4OYY9KxrFXxFnmI8OLmycLQEpNNodRmy0Vm/9q20KJ2COWRODzh/oUVOHY
	 okn4uKMZ0pUQ+ooVsvQRZAH+O8raHdMQVLmeSwoFfPLfi6vDDuHtCmlO+pdAhsBQImdSp
	 BiIMjG93P+3sScPO4oOYZoU5CxSUiv2mGrwBhAve+FeDOAD6RTPJroB0dkE8p5xC9CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZGqSLOg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E52C606A32D;
	Tue, 20 Oct 2026 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZGqSLOg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CB51F000C5;
	Tue, 20 Oct 2026 14:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792506560;
	bh=tnzmruvpw+zMT3qGYg1V/ubAlXjcG/6w9CFj+4EFdPg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iZGqSLOg7noAIeXh7qtTPCqn01JuhtGOa5VKCj/K1v9j1AzKxJh0P2qMSB8suaUxh
	 nEQaJ9gHY0w47W0YkeuuMId5cozVIBt2ViZRWwChpGD/1fWZIWc2Hb5HvZTi++G2gU
	 SCjExwsNzDsvMpnaC1UrNQKnIgli1Ah7Rq6Z9ivLXMnCzV9rec+KYsyFKdYX1PMdOg
	 YXZRKlvXranwG6urf3adyTzdI12spqJbfSDt6g9lxL8J8BMX9PdYIhBeseKq6oj38P
	 sZ6XslEOarwcO0kDQd/ke5KnTUsLBOuKA+MKSWTnW3DzpP3h2i8cbVFATzue/rw5zm
	 i7F556ICs8Euw==
Content-Type: multipart/mixed; boundary="===============8681009879540805806=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <ee5357d7518fed983436590b5132f93cea1427b57944419eb67e3b25c87ed5db@mail.kernel.org>
In-Reply-To: <38a798d59fc40d94c555c785a900e57c22cec2bc.1792503001.git.xukuohai@huawei.com>
References: <38a798d59fc40d94c555c785a900e57c22cec2bc.1792503001.git.xukuohai@huawei.com>
Subject: Re: [PATCH bpf-next 09/16] bpf: Teach verifier about arena percpu instructions
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,emil@etsalapatis.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 14:29:19 +0000 (UTC)

--===============8681009879540805806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Teach verifier about arena percpu instructions

TL;DR:
- Verifier state pruning may skip arena percpu bounds checks, so out-of-range
  accesses could load
- Possible vmlinux link failure on 32-bit/!MMU: no stubs for new arena helpers
- JIT constant blinding skipped for loader-controlled immediates

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7750df973494..5ffefcd5f15e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -674,6 +674,9 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
>  u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena);
>  u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena);
>  u64 bpf_arena_map_kern_vm_start(struct bpf_map *map);
> +u32 bpf_arena_percpu_chunk_off(const struct bpf_map *map);
> +u32 bpf_arena_percpu_chunk_sz(const struct bpf_map *map);
> +bool bpf_arena_percpu_off_in_range(const struct bpf_map *map, u32 off);
>  struct bpf_map *bpf_prog_arena(struct bpf_prog *prog);
>  int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
>  

Is this declaration reachable from a build that doesn't compile arena.c?

kernel/bpf/Makefile only builds arena.c when both options are set:

    ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
    obj-$(CONFIG_BPF_SYSCALL) += arena.o range_tree.o
    endif

verifier.o is built for every CONFIG_BPF_SYSCALL config, and this patch
calls the new helpers from it behind runtime map_type checks only, which the
compiler cannot remove:

    check_ld_imm():
        u64 pos = aux->map_off - bpf_arena_percpu_chunk_off(map);
        dst_reg->mem_size = bpf_arena_percpu_chunk_sz(map);

    check_and_resolve_insns():
        if (!bpf_arena_percpu_chunk_sz(map)) {
        if (!bpf_arena_percpu_off_in_range(map, off)) {

Can this fail to link vmlinux with undefined references to
bpf_arena_percpu_chunk_off, bpf_arena_percpu_chunk_sz and
bpf_arena_percpu_off_in_range on 32-bit or !MMU kernels with
CONFIG_BPF_SYSCALL=y?  In-tree examples are
arch/arm/configs/imx_v6_v7_defconfig, aspeed_g5_defconfig and
imxrt_defconfig (!MMU).

The other arena.c symbols used by always-built code all have a fallback.
kernel/bpf/core.c has __weak bpf_arena_get_user_vm_start() and
bpf_arena_get_kern_vm_start() stubs "for configs without MMU or 32-bit", and
include/linux/bpf.h wraps the arena kfuncs in
"#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)" with static inline stubs.

Nothing later in the series adds stubs for these three helpers.  The JIT
callers added later are 64-bit only, so stubs (or a CONFIG_MMU &&
CONFIG_64BIT guard) would be needed only for the verifier call sites.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index fc22d66d194a..29291101416a 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -1600,6 +1601,20 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
>  			continue;
>  		}
>  
> +		if (insn->code == (BPF_LD | BPF_IMM | BPF_DW) &&
> +		    insn->src_reg == BPF_PSEUDO_ARENA_PERCPU) {
> +			/*
> +			 * The imm of an arena percpu pseudo insn is the
> +			 * loader resolved address of the value in cpu 0's
> +			 * chunk, and the JIT translates the pseudo insn to
> +			 * step it into the running cpu's chunk. No need to
> +			 * blind it.
> +			 */
> +			insn++;
> +			i++;
> +			continue;
> +		}
> +
>  		/* We temporarily need to hold the original ld64 insn
>  		 * so that we can still access the first part in the
>  		 * second blinding run.

Is it safe to skip constant blinding for this instruction?

The new comment describes the imm as the "loader resolved address".
check_and_resolve_insns() builds it from loader chosen values:

    arena_map_direct_value_addr() + off
      == arena->user_vm_start + insn[1].imm

user_vm_start comes from attr->map_extra (any page aligned value that does
not cross a 32-bit boundary), and off can be any value inside the chunk.  So
the loader controls essentially all 64 bits that the JIT emits as an
immediate (movabs on x86, a mov sequence on arm64).

The bpf_pseudo_func() skip just above is justified because that address "is
not a user controlled constant".  This one is.  By comparison, a regular
arena global (BPF_PSEUDO_MAP_VALUE) has its src_reg cleared by
convert_pseudo_ld_imm64() and is blinded.

With net.core.bpf_jit_harden=2, can a CAP_BPF + CAP_PERFMON loader now place
chosen 8-byte immediates in the JIT image through this instruction?

The comment's reason ("the JIT translates the pseudo insn") explains why the
generic rewrite cannot be applied, since that would drop the src_reg marker.
It doesn't show that blinding is unnecessary, and the commit message does
not mention the exemption.

Would blinding the value while keeping the per-cpu step work, for example by
emitting the per-cpu add as a separate step after a blinded load?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 01434e1d23b5..0c0d3662ec76 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19080,10 +19100,27 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  	map = env->used_maps[aux->map_index];
>  
>  	if (insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
> -	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
> +	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE ||
> +	    insn->src_reg == BPF_PSEUDO_ARENA_PERCPU) {
>  		if (map->map_type == BPF_MAP_TYPE_ARENA) {
> -			__mark_reg_unknown(env, dst_reg);
> -			dst_reg->map_ptr = map;
> +			if (insn->src_reg == BPF_PSEUDO_ARENA_PERCPU) {
> +				u64 pos = aux->map_off - bpf_arena_percpu_chunk_off(map);
> +
> +				/*
> +				 * The register value tracks the position of
> +				 * the reference inside cpu 0's chunk and
> +				 * mem_size bounds accesses to the chunk.
> +				 * map_ptr and mem_size share a union and
> +				 * map_ptr is never read for PTR_TO_ARENA,
> +				 * so only mem_size is set.
> +				 */
> +				__mark_reg_known(dst_reg, pos);
> +				dst_reg->type = PTR_TO_ARENA;
> +				dst_reg->mem_size = bpf_arena_percpu_chunk_sz(map);
> +			} else {
> +				__mark_reg_unknown(env, dst_reg);
> +				dst_reg->map_ptr = map;
> +			}
>  			bpf_diag_mod_end(env);
>  			return 0;
>  		}

Does state pruning still distinguish these registers?

This patch gives PTR_TO_ARENA registers safety state.  var_off holds the
position inside cpu 0's chunk and mem_size holds the bound that
check_mem_access() enforces.  regsafe() in kernel/bpf/states.c was not
updated, and it still treats any two PTR_TO_ARENA registers as equivalent:

    case PTR_TO_ARENA:
        return true;

A path whose per-cpu reference is out of range can then be pruned against an
explored path whose reference is in range (or is a plain unbounded arena
pointer), and the bound check never runs for it.  For example:

    r0 = bpf_get_prandom_u32()
    r1 = ld_imm64 ARENA_PERCPU(off = chunk_off + chunk_sz - 4)
                                       ; pos = chunk_sz - 4
    if r0 == 0 goto L
    r1 = ld_imm64 ARENA_PERCPU(off = chunk_off)
                                       ; pos = 0
  L:
    r2 = *(u64 *)(r1 + 0)
    r0 = 0
    exit

The fall-through path (pos 0) is explored first, passes the 8 byte load at
L, and leaves a checkpoint there.  That needs enough preceding insns/jumps,
or BPF_F_TEST_STATE_FREQ.

When the pushed branch (pos chunk_sz - 4) reaches L, states_equal() ->
regsafe() returns true for r1.  r0 is not precise, so it matches too.  The
path is pruned and the program loads, even though that load reads 4 bytes
past cpu 0's chunk.

A plain arena pointer (e.g. after addr_space_cast) on the first path hides
an out-of-range per-cpu reference on the second path in the same way, so
whether the program is accepted depends on exploration order.

That contradicts the commit message ("If the offset or the access size goes
past cpu 0's chunk, the prog is rejected") and what the percpu_bounds
selftest added in 08224ba2de19 expects.  At runtime the access lands in the
next CPU's chunk, or past the last chunk.  Arena accesses are PROBE_MEM32,
so kernel memory is not exposed, but per-cpu data is silently shared across
CPUs.

Should regsafe() compare mem_size, and check range_within()/tnum_in() on
the position, for PTR_TO_ARENA registers with mem_size != 0?

This is not fixed later in the series.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39434884362
--===============8681009879540805806==--
