Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998605;
	b=TPdgf31e51CjPfLc4QAI8AKE5XocD6Ds7DbN5J2H9lEpNYVAvhNnyy3D9zKYtj8l/YdQ
	 +EiYInPtl+oPhD9W/TFCVjyzzKOFGMkX+8U0rUU46yvGYP+jILxi0BZCiz3J5u5e0cYeA
	 cNFZQPM8GHYW6I4NapQHJNKV/jYMytR0bdt9h24fyDEbHxs0Gt/EKeYJC0QpgXlUqlmZr
	 xibjhTWYDugtyHEfB5tRaY0RR9RSHFFU8PwX+6UYp41QTn8efIFxuGEh/4ehYR/SQ707O
	 ULCgjd64ei1iJy9OCicSSPdjx8hfDXwisnzjJoO5XY7FAwcRruUdLwXbqhT/u0kThNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998605;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=7kUmmUJe/UuFXhf56bQ2uwbQHYzUSUQRv4Jf5deDYVU=;
	b=oSBiqanO3uxEtJjO7BBotwkQZjxGd8GD/0USD7/WvbRdd0WkmPH46hSX9Kg1HtQND3Kw
	 YfD9qNrdsEiRfAj+EoZfTsnfXnpxCcfzUhIVMl5OCogXFAM8UjHE+aAgKFhO6AK1739Th
	 rXczcDC93fE7NwpZ40zbJm0OPuplUPPP6qensuEG/zuubxMMMNlnBlgO70k7bmv0ZFE3J
	 UwbumFVEwwYBPlSL3o4GA8f1XyQck8C/CX6S9KzH6uiWhK9uq449uqWOocgeJH9ScDk1b
	 /hXOIN+cAngc5op8PI5NZismTYVLFTncvp6XEEUIVVa0KJTTp7Zr6HX6rveBQopz+Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=leEB80fj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174FF606D815;
	Fri,  6 Nov 2026 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=leEB80fj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8501F008A3;
	Fri,  6 Nov 2026 20:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998599;
	bh=7kUmmUJe/UuFXhf56bQ2uwbQHYzUSUQRv4Jf5deDYVU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=leEB80fj9R2LVxkgiyPGC+gW2Z+39k+nQdYEaqBahp7lRcswEin+JPQK76wub/uOm
	 WrAGA2ffe8rhjzP7tiCd18N8gpf5vibpoYPUGnyNC+K2kBT2bWqGnLEPm8HayQXXt+
	 E02H5jNhKMqnufgg3KYSGGhXBBcXLe3Qr2uQd0To9EKRBQtQyeWBtBIt5nHigNKzHb
	 6kPOfrzFz4m59ADkGGkG7Lv1lLysVa6m1x4TV4Xdl0ZdJAjKf7wagmXRiEGXCKaOsm
	 ULsbCvlJMd4UQJjfUlYwSamp2a71UyzgOhHy2lV/cH+2RYBjiSLyXmFF7gCexx+R47
	 MipQCPYcMX4mg==
Content-Type: multipart/mixed; boundary="===============9131375726227593508=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4a50ecb63eb8d22a98d6a2253ead9f7d1127b70e42266263f75c7d56141199e1@mail.kernel.org>
In-Reply-To: <20261106-lskel-struct-ops-v1-2-a4486ffc79cb@google.com>
References: <20261106-lskel-struct-ops-v1-2-a4486ffc79cb@google.com>
Subject: Re: [PATCH RFC bpf-next 2/7] libbpf: Implement bpf_gen__init_kern_struct_ops() for light skeletons
From: bot+bpf-ci@kernel.org
To: sidnayyar@google.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,gprocida@google.com,nkapron@google.com,tweek@google.com,mripard@kernel.org,sidnayyar@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 20:56:39 +0000 (UTC)

--===============9131375726227593508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Implement bpf_gen__init_kern_struct_ops() for light skeletons

TL;DR:
- Light-skeleton struct_ops loader may overflow into adjacent kern_vdata
  members: kernel member size/kind unchecked
- Module BTF fds may leak on loader failure paths
- Type lookups may resolve in different BTF objects, failing module struct_ops
  loads

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c

[ ... ]

> +static void emit_st_ops_member_val(struct bpf_gen *gen, const char *mname,
> +				   const void *mdata, __u32 msize,
> +				   int kern_vdata_off)
> +{

[ ... ]

> +	mdata_off = add_data(gen, mdata, msize);
> +	emit_bpf_get_struct_member_info(gen, mname);
> +
> +	/* Extract member byte offset (lower 32 bits of R7), add kern_data_off, and bound it */
> +	emit(gen, BPF_MOV32_REG(BPF_REG_2, BPF_REG_7));
> +	emit(gen, BPF_ALU32_REG(BPF_ADD, BPF_REG_2, BPF_REG_9));
> +	emit(gen, BPF_JMP_IMM(BPF_JLE, BPF_REG_2, KERN_VDATA_MAX_SIZE - msize, 2));
> +	emit(gen, BPF_MOV64_IMM(BPF_REG_7, -E2BIG));
> +	emit_check_err(gen);

The gen path copies msize bytes, where msize is the size of the local
member, to the kernel member's offset.  The only bound here is the 4096
byte kern_vdata buffer.  The kernel member's size and kind, and val_sz,
are not checked.

bpf_map__init_kern_struct_ops() rejects both cases with -ENOTSUP:

    if (BTF_INFO_KIND(mtype->info) != BTF_INFO_KIND(kern_mtype->info)) {
        ...
        return -ENOTSUP;
    }
    ...
    kern_msize = btf__resolve_size(kern_btf, kern_mtype_id);
    if (kern_msize < 0 || msize != kern_msize) {
        ...
        return -ENOTSUP;
    }

If a local struct_ops definition (a ___flavor type, or a vmlinux.h from
another kernel) has a non-zero scalar member that is wider than the
running kernel's, or is a scalar where the kernel has a function pointer,
can the loader write the extra bytes into the following kernel members of
kern_vdata?

If the init_member() callback accepts those values, the map could be
registered with wrong values, and bytes landing in a function pointer slot
are later read as a prog fd by bpf_struct_ops_map_update_elem().

The regular libbpf load of the same object fails cleanly.  Was dropping
these checks intended, or could bpf_btf_get_struct_member_info() also
return the member size, or the loader at least check against val_sz?

[ ... ]

> +void bpf_gen__init_kern_struct_ops(struct bpf_gen *gen, struct btf *btf,
> +				   struct bpf_struct_ops *st_ops,
> +				   __u32 *vtype_id_off,
> +				   unsigned int *val_sz_off)
> +{

[ ... ]

> +	/* 1. Resolve BTF ID of struct bpf_struct_ops_<tname> */
> +	*vtype_id_off = add_data(gen, NULL, sizeof(__u64));
> +	relo.name = stname;
> +	emit_bpf_find_by_name_kind(gen, &relo);
> +	emit_check_err(gen);
> +	emit(gen, BPF_MOV64_REG(BPF_REG_8, BPF_REG_7));
> +	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
> +					 0, 0, 0, *vtype_id_off));
> +	emit(gen, BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_7, 0));

For a struct_ops type that lives in a module, each
bpf_btf_find_by_name_kind() call (steps 1 and 3) creates a new module BTF
fd.  The fd is kept only in the upper 32 bits of the blob slots
*vtype_id_off and st_ops->type_id_off.

The cleanup label emitted by bpf_gen__init() closes only the loader_stack
slots (btf_fd, inner_map_fd, prog_fd[]) and the map entries of fd_array,
so these fds are not closed when emit_check_err() jumps to cleanup.

This commit adds no close at all.  Later in the series, c8839efa9329
("libbpf: Support BPF_MAP_TYPE_STRUCT_OPS in bpf_gen__map_create()")
closes the step 1 fd right after BPF_MAP_CREATE, and b5342aeba917
("libbpf: Implement bpf_gen__struct_ops_update_elem() for light
skeletons") closes the step 3 fd only in bpf_gen__struct_ops_update_elem(),
which runs after every program has loaded.

Can a failure in between leak these BTF fds in the calling process?  For
example a missing kernel member (-ENOENT from
bpf_btf_get_struct_member_info()), the -E2BIG bound check, BTF load, an
earlier map create, or a verifier rejection of any program would each
jump to cleanup with the fds still open.

bpf_gen__prog_load() already closes attach_btf_obj_fd and the kfunc BTF
fds right after PROG_LOAD ("successful or not, close btf module FDs").
Could these fds be kept in extra loader_stack slots that the cleanup label
closes, or be closed before the next emit_check_err() when not needed
later?

[ ... ]

> +	/* 3. Resolve BTF ID of struct <tname> */
> +	st_ops->type_id_off = add_data(gen, NULL, sizeof(__u64));
> +	relo.name = tname;
> +	emit_bpf_find_by_name_kind(gen, &relo);
> +	emit_check_err(gen);

Step 3 looks up struct <tname> with a fresh, global
bpf_btf_find_by_name_kind() call that is not tied to the BTF object where
step 1 found struct bpf_struct_ops_<tname>.  The kernel's bpf_find_btf_id()
searches vmlinux first and then every module BTF in idr order, so the two
lookups can land in different BTF objects.

The non-gen path looks up the value type first and then looks up tname in
the same btf:

    kern_vtype_id = find_ksym_btf_id(obj, stname, BTF_KIND_STRUCT, &btf, mod_btf);
    ...
    kern_type_id = btf__find_by_name_kind(btf, tname, BTF_KIND_STRUCT);

and bpf_map__init_kern_struct_ops() then sets prog->attach_btf_obj_fd to
mod_btf->fd.

A concrete case is net/smc/smc_hs_bpf.c, which registers the smc_hs_ctrl
struct_ops from smc.ko.  struct smc_hs_ctrl is also fully defined in
vmlinux BTF, because net/ipv4/tcp_output.c includes <net/smc.h>.  In gen
mode:

    step 1 finds bpf_struct_ops_smc_hs_ctrl in smc.ko and returns
           (smc_fd << 32) | vtype_id
    step 3 finds smc_hs_ctrl in vmlinux and returns
           (0 << 32) | type_id

With ee35678a566a ("libbpf: Support BPF_PROG_TYPE_STRUCT_OPS in
bpf_gen__prog_load()"), prog_load takes attach_btf_obj_fd from the upper
half of type_id_off, which is 0.  bpf_prog_load() then falls back to
vmlinux BTF, and check_struct_ops_btf_id() -> bpf_struct_ops_find() does
not find the type in vmlinux's struct_ops_tab, so the load fails with
"attach_btf_id %u is not a supported struct" and -ENOTSUPP.

The same mismatch can occur when another module loaded earlier carries its
own copy of struct <tname> in its split BTF.  No later commit in the
series changes this lookup, and the selftests only use bpf_testmod_ops,
which exists only in bpf_testmod.ko.

Could the interface type be resolved within the BTF object returned in
step 1, or could the step 1 fd be paired with the type id when the step 3
result comes from vmlinux?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42289585064
--===============9131375726227593508==--
