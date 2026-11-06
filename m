Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998438;
	b=Bu+E4GE2bct8RlwfiriufvLV5nAPy5VRmSqLm4Xmn9AN3Hyuiw8wrogw9c2YTpIBSvns
	 BcesgqxzwZ2kaBLBVQHv5Z/uYbu4Hub274XldTekFNEKz3K/YNYkQFI0k57KGeDMfmxOH
	 l63IlkDR56WIMj7NBLe/vcVt/yXXtc7PRcJSVySSdrfM2o/sWL3H09NpExnTrQO4DDbKI
	 ZwWIYKKwgD3xs/bwmBPM5BZ/piMLcyIrKhWEwaHMOVw9cQGObZS/X7d689F2b4EhJ1ulV
	 Y5xwOnN7OvWqn7b0fE9OoO/sIuQzRgysbRtd4U30HWrq1LYe7b4vUOFuLvSnbJkJpIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998438;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AczNF++isiZcZzW2QayVKZ7O9PGGI7BKcDurz/IdjAw=;
	b=g/uklNaWF/aDZLBj6fghjeVEUW0yWLMUQOG8V/qY9oXlPkG0nQurJPjmcqlgNXD6CW9u
	 hkAShLNEy6/0sgINU8GKdOQAHTcnVZi0WJofIXceUw2fEEJvQGSJeRs8iqj/zhGkseA5P
	 RA9hQigHTY495vzX654u7EAtq9TNYRWuYNGOhbBW9IhCgTvGj/T0aL6WgDX1TkdFKN7YJ
	 VA3O2m//pCSaJe+4xhAd8CeXK+40VGC6pX/zbLOKrF4Fnyq2FpxOh/ZjfBr+3yYLBkAXZ
	 44WgHqGdRfnWbg8wiAwLxm+HeVSbxpYVUzIdCeVaiHUC9Hc4MHCG5uGagIRl5vU37yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btZsurqQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2576B606A32C
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btZsurqQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968311F008A1;
	Fri,  6 Nov 2026 20:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998437;
	bh=AczNF++isiZcZzW2QayVKZ7O9PGGI7BKcDurz/IdjAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=btZsurqQ6bqsPenVE1DcBqQ4sUDCDIipJiy6TbVUAr7mdZeOMOLZ2BND7omT7REXO
	 JbK5IPEnRwzIQAhh+oaQXd7Kd+yAg5QzOj6VwUUr83A38F6potulPoeUFmRPNVdnAA
	 DfjS9ogBTeHj3yks2lLu+iU2uCiUC7GKCpCNbRTZGTdbgPgLgtkibWDsEGWNqtGm3I
	 r+oNE/GV3Z7SSb2KTwvx0K4SJ2fhJSSdOfVZDgWt8OJLtqK3s/lbq5bGxa243lKLDc
	 eQd/4D09KTgRVPefxKmZ3Xqp3qWAwUJoUOY8WDSZGk9RHx3MaUs1oiYHC37nkEa0Xs
	 VBRLYY150ipgw==
Message-ID: <sashiko-outbox-202259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 2/7] libbpf: Implement
 bpf_gen__init_kern_struct_ops() for light skeletons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Nayyar" <sidnayyar@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261106-lskel-struct-ops-v1-2-a4486ffc79cb@google.com>
References: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
 <20261106-lskel-struct-ops-v1-2-a4486ffc79cb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:53:57 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] libbpf: missing KERN_VDATA_MAX_SIZE check on value_size in
  bpf_gen__init_kern_struct_ops()
- [Medium] libbpf: lost module BTF FD in bpf_gen__init_kern_struct_ops()
- [Medium] libbpf: module BTF FD leak on error paths in
  bpf_gen__init_kern_struct_ops()
- [Medium] libbpf: missing prog validation in
  bpf_gen__init_kern_struct_ops()
- [Low] libbpf: non-compliant multi-line comment style in gen_loader.c
  and libbpf_internal.h
--

commit 47fbca753e635bfa549db1f089e51f9bbdfd0f38
Author: Siddharth Nayyar <sidnayyar@google.com>

libbpf: Implement bpf_gen__init_kern_struct_ops() for light skeletons

This commit adds bpf_gen__init_kern_struct_ops() in gen_loader.c and wires =
it
up in bpf_object__init_kern_struct_ops_maps() to resolve kernel struct_ops =
BTF
information and populate kern_vdata in the loader data blob for light
skeletons.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 555d4757a898c..09713c39f71ec 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
[ ... ]
> @@ -1338,3 +1341,197 @@ void bpf_gen__map_freeze(struct bpf_gen *gen, int=
 map_idx)
>  	debug_ret(gen, "map_freeze");
>  	emit_check_err(gen);
>  }
> +
> +/* Expects:
> + * BPF_REG_8 - (btf_obj_fd << 32) | btf_id
> + *
> + * Overwrites BPF_REG_{0, 1, 2, 3, 4, 7}
> + * Returns result in BPF_REG_7
> + */
> +static void emit_bpf_get_struct_member_info(struct bpf_gen *gen, const c=
har *mname)

[Severity: Low]
This isn't a bug, but BPF coding style places the opening /* of multi-line
comments on its own line with the comment text starting on the next line.
This also applies to the new multi-line comments above
emit_st_ops_member_val(), above and inside emit_st_ops_member_prog(), and in
struct bpf_struct_ops in tools/lib/bpf/libbpf_internal.h.

[ ... ]

> +void bpf_gen__init_kern_struct_ops(struct bpf_gen *gen, struct btf *btf,
> +				   struct bpf_struct_ops *st_ops,
> +				   __u32 *vtype_id_off,
> +				   unsigned int *val_sz_off)
> +{
> +	struct ksym_relo_desc relo =3D { .kind =3D BTF_KIND_STRUCT };
> +	const struct btf_member *member;
> +	const struct btf_type *type;
> +	char tname[192], stname[256];
> +	const char *tname_raw;
> +	__u32 i;
> +
> +	type =3D btf__type_by_id(btf, st_ops->type_id);
> +	tname_raw =3D btf__name_by_offset(btf, type->name_off);
> +	snprintf(tname, sizeof(tname), "%.*s",
> +		 (int)bpf_core_essential_name_len(tname_raw), tname_raw);
> +	snprintf(stname, sizeof(stname), "%s%s", STRUCT_OPS_VALUE_PREFIX, tname=
);
> +
> +	/* 1. Resolve BTF ID of struct bpf_struct_ops_<tname> */
> +	*vtype_id_off =3D add_data(gen, NULL, sizeof(__u64));
> +	relo.name =3D stname;
> +	emit_bpf_find_by_name_kind(gen, &relo);
> +	emit_check_err(gen);
> +	emit(gen, BPF_MOV64_REG(BPF_REG_8, BPF_REG_7));
> +	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
> +					 0, 0, 0, *vtype_id_off));
> +	emit(gen, BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_7, 0));

[Severity: Medium]
Does this leak module BTF file descriptors on error paths?

When struct bpf_struct_ops_<tname> (or struct <tname> in step 3) belongs to=
 a
kernel module, bpf_btf_find_by_name_kind() allocates a new BTF file
descriptor and returns it in the upper 32 bits of R0/R7.  Those file
descriptors are stored at *vtype_id_off and st_ops->type_id_off in the data
blob rather than in loader_stack or gen->fd_array.  If a subsequent
emit_check_err() in bpf_gen__init_kern_struct_ops(), bpf_gen__load_btf(),
bpf_gen__map_create(), or bpf_gen__prog_load() jumps to gen->cleanup_label
before the normal close points in commit "libbpf: Support
BPF_MAP_TYPE_STRUCT_OPS in bpf_gen__map_create()" and commit "libbpf:
Implement bpf_gen__struct_ops_update_elem() for light skeletons" are reache=
d,
gen->cleanup_label will not close either module BTF file descriptor.

> +
> +	/* 2. Use the BTF ID to find the struct_ops value struct size and "data=
" offset */
> +	*val_sz_off =3D add_data(gen, NULL, sizeof(__u32));
> +	emit_bpf_get_struct_member_info(gen, NULL);
> +	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
> +					 0, 0, 0, *val_sz_off));
> +	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_7, 0));
> +
> +	emit_bpf_get_struct_member_info(gen, "data");
> +	emit(gen, BPF_MOV32_REG(BPF_REG_9, BPF_REG_7));
> +
> +	/* 3. Resolve BTF ID of struct <tname> */
> +	st_ops->type_id_off =3D add_data(gen, NULL, sizeof(__u64));
> +	relo.name =3D tname;
> +	emit_bpf_find_by_name_kind(gen, &relo);
> +	emit_check_err(gen);
> +	emit(gen, BPF_MOV64_REG(BPF_REG_8, BPF_REG_7));
> +	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
> +					 0, 0, 0, st_ops->type_id_off));
> +	emit(gen, BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_7, 0));

[Severity: Medium]
Can resolving struct <tname> with a separate bpf_btf_find_by_name_kind() ca=
ll
lose the module BTF file descriptor needed for attach_btf_obj_fd?

A kernel module can register a struct_ops whose wrapper struct
bpf_struct_ops_<tname> lives in the module's split BTF while the interface
struct <tname> is defined in vmlinux BTF (the case handled for standard mode
by 0cc114dc358c ("libbpf: Fix error when st-prefix_ops and ops from differ
btf")).  Because bpf_btf_find_by_name_kind() searches vmlinux BTF before
module BTFs, looking up <tname> in step 3 finds it in vmlinux BTF and stores
btf_obj_fd =3D=3D 0 in the upper 32 bits of st_ops->type_id_off.  When
bpf_gen__prog_load() in commit "libbpf: Support BPF_PROG_TYPE_STRUCT_OPS in
bpf_gen__prog_load()" copies that upper 32-bit value into
prog_load_attr.attach_btf_obj_fd, the kernel falls back to vmlinux BTF in
check_struct_ops_btf_id() and rejects BPF_PROG_LOAD with -ENOTSUPP.

> +
> +	/* 4. Allocate and populate space in the data blob for kern_vdata */
> +	st_ops->kern_vdata_off =3D add_data(gen, NULL, KERN_VDATA_MAX_SIZE);

[Severity: Medium]
Can a kernel struct bpf_struct_ops_<tname> larger than KERN_VDATA_MAX_SIZE
cause an out-of-bounds read from the loader data blob?

Step 2 stores the runtime BTF size of struct bpf_struct_ops_<tname> into
*val_sz_off without checking that it does not exceed KERN_VDATA_MAX_SIZE
(4096), while step 4 allocates a fixed 4096-byte buffer at
st_ops->kern_vdata_off.  Although emit_st_ops_member_val() bounds-checks the
individual fields populated by the BPF object, unpopulated trailing fields =
are
skipped.  If the wrapper struct exceeds 4096 bytes while all initialized
members lie within the first 4096 bytes, BPF_MAP_CREATE in commit "libbpf:
Support BPF_MAP_TYPE_STRUCT_OPS in bpf_gen__map_create()" creates the map w=
ith
value_size > 4096, and BPF_MAP_UPDATE_ELEM in commit "libbpf: Implement
bpf_gen__struct_ops_update_elem() for light skeletons" reads value_size byt=
es
past the 4096-byte buffer at st_ops->kern_vdata_off.

> +	member =3D btf_members(type);
> +	for (i =3D 0; i < btf_vlen(type); i++, member++) {
[ ... ]
> +		mtype =3D skip_mods_and_typedefs(btf, member->type, NULL);
> +		if (btf_is_ptr(mtype)) {\n> +			struct bpf_program *prog =3D *(void **=
)mdata;
> +
> +			emit_st_ops_member_prog(gen, mname, st_ops, i, prog);
> +		} else {
> +			emit_st_ops_member_val(gen, mname, mdata, msize,
> +					       st_ops->kern_vdata_off);
> +		}
> +	}
> +}

[Severity: Medium]
What happens if a struct_ops type has a non-function pointer member, an
invalid program pointer in st_ops->data, or a program reused across
incompatible slots?

In standard mode, bpf_map__init_kern_struct_ops() checks resolve_func_ptr()
and validates prog with is_valid_st_ops_program() before dereferencing it, =
and
rejects a program reused across different struct_ops types or member indice=
s.
Here, any btf_is_ptr(mtype) member in st_ops->data is cast to struct
bpf_program * and dereferenced in bpf_program__set_expected_attach_type() a=
nd
bpf_object__init_kern_struct_ops_maps() without checking that the member is=
 a
function pointer or that prog is a valid struct_ops program.  In addition, =
if
the same program is assigned to multiple slots, emit_st_ops_member_prog() a=
nd
bpf_object__init_kern_struct_ops_maps() overwrite prog->expected_attach_type
and prog->attach_btf_id with the last slot's blob offsets instead of reject=
ing
the conflicting reuse.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lskel-stru=
ct-ops-v1-0-a4486ffc79cb@google.com?part=3D2
