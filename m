Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505780;
	b=f4VG35Sv3sFJtGIMOrnL91CFwzJWLUIz1n38TBqzbQDwFEQ2A9yNgYy3j5HqDdoHH94m
	 X2xZ4Wjupv4eSWleWy9BON109SppaHcWOmOkNh9tSuYW0LhnWb22Sg8WpYRGbGyhvSSu+
	 QUo4j1PZaxftaVmCvhiMsYPfZzl7IAga5WghcHZm18N1xa+FvfAx7vP8csa75JsFdRtKe
	 IjTteTg+mrZvQvdXtFxIh0IUuk0PXH6tQBRs7dhqmaeqd5Ss/cLKE3/iF5/I6NKX615jz
	 X7VjgBJsm449BhDXTGoGZWNRXH3z6zkATcN2itj4+eRzM3lmKickdwODneEJvGJB2Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505780;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4x8uH/DGv/CD/1Mxw5Aj75i5s9Y5FtjMjuc3jjdt2uc=;
	b=eKMIeK1gJHU3Jp+j9/QqScXNEikdAjXGl/q4/vv9EnNcsK8CefQ20WJVTgHZHvpWy0Xg
	 eaoJjLlD6CoW2V1kvtOUa6IvRV+7nDF9oCLBQ61GlUKXW99jPR9vJhD8y3QiSILt+8XjF
	 EZMguHWW46N0GVJSzsMYfbEDn+68Y9fRtmW5ZAal83pIb/b50WQpmLSEPpo+dJxUDI/n1
	 4DuljCmi3Y2YS62Enmz/4CJS0np+qbKHa7grUQIurtxSZYB9bAJfhCICmG4Z6y8mdeBKc
	 rVQdFzV+jUXS16h79QBcBjJIYWAEV6ABk3uMYDx+QVfaq1FirkqowqX6XacTRnm7Y9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4lR0tUo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06D606AA0F
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4lR0tUo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB641F000CA;
	Tue, 20 Oct 2026 14:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505780;
	bh=4x8uH/DGv/CD/1Mxw5Aj75i5s9Y5FtjMjuc3jjdt2uc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=O4lR0tUoiO0EAgylzjFoCVMGivumEv66NkjTXXpCCfD1oOQAkj0xf/xKLzkPr9QiA
	 A01g+rwC9Q+V1eZTh0V9LjRIJcS5LlJrba5NkdG9gkyecKFk22Iafalq6Srz0ctoZE
	 8x+DCMCC1UxseIGO2LmJ70s4grs+5QLrA0Hk/1qxGksa/nWg4A5GDQ83RsO3nnqZCk
	 bTrYnH0Nm/sr/+ANw/8WNaabkzwJtENswz0FCmiz8SJsakphJJxQqvDkuuvuOQDxs0
	 BPCLk7quzTIDDt3U21Oa5pE7nGW4XBgJBWXwNJ6S3G17FKTvMwdBSdSOloQ70QwyRm
	 8ENUR6QvHKIwA==
Message-ID: <sashiko-outbox-179106@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 09/16] bpf: Teach verifier about arena percpu
 instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
In-Reply-To: <38a798d59fc40d94c555c785a900e57c22cec2bc.1792503001.git.xukuohai@huawei.com>
References: <cover.1792503001.git.xukuohai@huawei.com>
 <38a798d59fc40d94c555c785a900e57c22cec2bc.1792503001.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:16:19 +0000
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
- [High] bpf: regsafe() ignores per-cpu chunk bounds for PTR_TO_ARENA
- [Low] bpf: missing weak stubs for arena percpu helpers on 32-bit or !CONF=
IG_MMU
--

commit 5dc561c4f5d4d59e121d23f2ab5a7ee680b5b149
Author: Xu Kuohai <xukuohai@huawei.com>

bpf: Teach verifier about arena percpu instructions

This commit teaches the BPF verifier to validate arena per-cpu pseudo
instructions by checking that the target offset and memory access bounds
stay within CPU 0's per-cpu chunk.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 05cd6397adae0..310573a2661bb 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -102,6 +102,29 @@ u64 bpf_arena_map_kern_vm_start(struct bpf_map *map)
>  	return bpf_arena_get_kern_vm_start(container_of(map, struct bpf_arena, =
map));
>  }
> =20
> +u32 bpf_arena_percpu_chunk_off(const struct bpf_map *map)
> +{
> +	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> +
> +	return arena->percpu_chunk_off;
> +}
> +
> +u32 bpf_arena_percpu_chunk_sz(const struct bpf_map *map)
> +{
> +	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> +
> +	return arena->percpu_chunk_sz;
> +}
> +
> +bool bpf_arena_percpu_off_in_range(const struct bpf_map *map, u32 off)
> +{
> +	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> +	u32 chunk_off =3D arena->percpu_chunk_off;
> +	u32 chunk_sz =3D arena->percpu_chunk_sz;
> +
> +	return off >=3D chunk_off && off - chunk_off < chunk_sz;
> +}

[Severity: Low]
Will this cause link failures on 32-bit or !CONFIG_MMU builds when
CONFIG_BPF_SYSCALL is enabled?

In kernel/bpf/Makefile, verifier.o is built whenever CONFIG_BPF_SYSCALL=3Dy,
whereas arena.o is only built when both CONFIG_MMU=3Dy and CONFIG_64BIT=3Dy:

    ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
    obj-$(CONFIG_BPF_SYSCALL) +=3D arena.o range_tree.o
    endif

For configs without MMU or on 32-bit, kernel/bpf/core.c provides __weak
stubs for other arena functions referenced outside arena.c:

    /* for configs without MMU or 32-bit */
    __weak const struct bpf_map_ops arena_map_ops;
    __weak u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
    {
    	return 0;
    }
    __weak u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
    {
    	return 0;
    }

Since check_ld_imm() and check_and_resolve_insns() in kernel/bpf/verifier.c
call bpf_arena_percpu_chunk_off(), bpf_arena_percpu_chunk_sz(), and
bpf_arena_percpu_off_in_range() unconditionally, should __weak fallbacks in
kernel/bpf/core.c (or inline stubs in include/linux/bpf.h) be added for
these three helpers as well?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 01434e1d23b59..0c0d3662ec765 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -7415,6 +7419,17 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, struct b
>  		if (!err && value_regno >=3D 0 && (rdonly_mem || t =3D=3D BPF_READ))
>  			mark_reg_unknown(env, regs, value_regno);
>  	} else if (reg->type =3D=3D PTR_TO_ARENA) {
> +		/*
> +		 * A per-cpu reference is bounded to cpu 0's chunk through
> +		 * mem_size. A plain arena pointer has no bound and only
> +		 * faults at runtime.
> +		 */
> +		if (reg->mem_size) {
> +			err =3D check_mem_region_access(env, reg, argno, off, size,
> +						      reg->mem_size, false);
> +			if (err)
> +				return err;
> +		}
>  		if (t =3D=3D BPF_READ && value_regno >=3D 0)
>  			mark_reg_unknown(env, regs, value_regno);
>  	} else {
[ ... ]
> @@ -19080,10 +19100,27 @@ static int check_ld_imm(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
>  	map =3D env->used_maps[aux->map_index];
> =20
>  	if (insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE ||
> -	    insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX_VALUE) {
> +	    insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX_VALUE ||
> +	    insn->src_reg =3D=3D BPF_PSEUDO_ARENA_PERCPU) {
>  		if (map->map_type =3D=3D BPF_MAP_TYPE_ARENA) {
> -			__mark_reg_unknown(env, dst_reg);
> -			dst_reg->map_ptr =3D map;
> +			if (insn->src_reg =3D=3D BPF_PSEUDO_ARENA_PERCPU) {
> +				u64 pos =3D aux->map_off - bpf_arena_percpu_chunk_off(map);
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
> +				dst_reg->type =3D PTR_TO_ARENA;
> +				dst_reg->mem_size =3D bpf_arena_percpu_chunk_sz(map);
> +			} else {
> +				__mark_reg_unknown(env, dst_reg);
> +				dst_reg->map_ptr =3D map;
> +			}
>  			bpf_diag_mod_end(env);
>  			return 0;
>  		}

[Severity: High]
Can verifier state pruning bypass the per-cpu chunk bounds check in
check_mem_access() because regsafe() ignores mem_size and offset ranges for
PTR_TO_ARENA?

In check_ld_imm(), loading a BPF_PSEUDO_ARENA_PERCPU instruction sets
dst_reg->type =3D PTR_TO_ARENA, records the offset within CPU 0's chunk via
__mark_reg_known(dst_reg, pos), and sets dst_reg->mem_size to the chunk
size. Then check_mem_access() relies on reg->mem_size and the tracked
register bounds in check_mem_region_access() to reject accesses outside CPU
0's chunk.

However, in kernel/bpf/states.c, regsafe() still handles PTR_TO_ARENA as:

    case PTR_TO_ARENA:
    	return true;

If an earlier verified path reaches a prune point with an unbounded
PTR_TO_ARENA (rold->mem_size =3D=3D 0, such as from an addr_space_cast or a=
fter
pointer arithmetic clears mem_size) or a per-cpu PTR_TO_ARENA at a small
offset like pos =3D 0 where a subsequent memory access is valid, won't a
second path reaching the same prune point with a per-cpu PTR_TO_ARENA near
the end of the chunk (e.g. pos =3D chunk_sz - 4) be considered equivalent by
regsafe() and pruned before check_mem_access() can reject the out-of-bounds
per-cpu access?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792503001.gi=
t.xukuohai@huawei.com?part=3D9
