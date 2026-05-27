Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5312E405872;
	Wed, 27 May 2026 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889186; cv=none; b=DBCCRdJY+1AAi/zWvCFBFuzS2t1CaU3FRzIODotI+p6Af/QC4LS3l/KfKrJauhZIK9AKepG97vYuhoNRwczNO/bZX8CHjAb65K0mVPPTrdZFJgRCighMS7aIjh/i4+PE47UK9MrGfZSNpeGg7tffiP4ngLSOH3WaoRS3PlCEVT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889186; c=relaxed/simple;
	bh=mtk+sHdvYWXucGDm7lzb6IdkUSLsXbGUZa6hk5fB/Mw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Rsmjog/MxgzTNcRs1MX2SrIPdSJohKvySCVIjMVqFZSufiz4GHqge0YOfkpu46mbLlLtR9jt6WfruIh9K5IzHLN0CRnYbJFIOssnmReBZHZyq6eQhnaeqMFcejuR9PdzrVaIpTJSn9sGnHfrvIkNLPETcxl4sk7qkALuYLrfRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH28/Xel; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH28/Xel"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598EA1F000E9;
	Wed, 27 May 2026 13:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779889182;
	bh=ptzqvbGu5MMR9lreaD14JD9Ny5U3t9SWdQft24QtXMk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TH28/XeliQob3pxxa5WMBgDt60cG1UWubnMfFwtqgk3FV6rXO6ghv0ouDE2n7emrn
	 KHujwELgH9hPeuIXRh/+3EdfZpMXrKzfRtyGup7ZT4h03Y+rZw7Ayj377ipBwNRH3v
	 E1g5mclhm3FJjWqZjSCL1ij1bdepH20+aoAhXk1soZAwAhOBu3dCFPA/LzIZ3rcCjg
	 VJOKc8YYyl+XbJeoLro5HCkZqcwF/lBTqqX84Ydpx2gxnOSOEkKMqMhoxuGu3BYNEC
	 G4ePx6XYNFqcBLwi6WJlBpFkTT/EOrLRgmbACBKh1DWe9eG2AMFrxwAmJtN62GAFEo
	 HgyZjGdIbicNA==
Content-Type: multipart/mixed; boundary="===============0920188431839944315=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1b7e66da1ffd1d3324dc48b9002bb3a596e7bb39eb9c48046f8fddddbf4c5aff@mail.kernel.org>
In-Reply-To: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-3-27daa15487a9@google.com>
References: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-3-27daa15487a9@google.com>
Subject: Re: [PATCH v4 3/3] libbpf: plumb btf_vmlinux_value_type_id and btf_fd in gen_loader
From: bot+bpf-ci@kernel.org
To: sidnayyar@google.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,gprocida@google.com,maennich@google.com,sidnayyar@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 27 May 2026 13:39:42 +0000 (UTC)

--===============0920188431839944315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 9478b8f78f26..b0d8551272f2 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -525,13 +525,14 @@ void bpf_gen__map_create(struct bpf_gen *gen,
>  	attr.max_entries = tgt_endian(max_entries);
>  	attr.btf_key_type_id = tgt_endian(map_attr->btf_key_type_id);
>  	attr.btf_value_type_id = tgt_endian(map_attr->btf_value_type_id);
> +	attr.btf_vmlinux_value_type_id = tgt_endian(map_attr->btf_vmlinux_value_type_id);

Does hardcoding btf_vmlinux_value_type_id here break cross-kernel
portability for STRUCT_OPS light skeletons?

Light skeletons are designed to be portable across different kernel
versions without relying on libbpf at runtime. Because BTF type IDs are
not stable across kernel builds, passing the build machine's BTF ID to
the target kernel might cause the target kernel's sys_bpf(MAP_CREATE) to
resolve to the wrong type or fail entirely with -EINVAL.

Should gen_loader dynamically resolve the target kernel's BTF ID at
runtime, similarly to how it handles attach_btf_id?

>
>  	map_create_attr = add_data(gen, &attr, attr_size);

Does this also miss plumbing value_type_btf_obj_fd for STRUCT_OPS
interfaces defined in kernel modules?

When a STRUCT_OPS map targets a kernel module, libbpf sets
value_type_btf_obj_fd in bpf_map_create_opts and adds
BPF_F_VTYPE_BTF_OBJ_FD to map_flags. The patch propagates map_flags into
gen_loader's map creation attributes but ignores value_type_btf_obj_fd.

In bpf_gen__map_create(), attr_size is calculated as offsetofend(union
bpf_attr, map_extra), which truncates the struct before
value_type_btf_obj_fd. As a result, the generated loader program passes
the BPF_F_VTYPE_BTF_OBJ_FD flag to the kernel but implicitly provides 0
for the FD. The target kernel attempts to read BTF from fd=0 (stdin) and
rejects the map with -EINVAL.

Furthermore, even if the FD field were included, the loader cannot
hardcode the build machine's module FD; it must dynamically resolve the
module BTF FD on the target machine.

>  	pr_debug("gen: map_create: %s idx %d type %d value_type_id %d, attr: off %d size %d\n",
>  		 map_name, map_idx, map_type, map_attr->btf_value_type_id,
>  		 map_create_attr, attr_size);
>
> -	if (map_attr->btf_value_type_id)
> +	if (map_attr->btf_value_type_id || map_attr->btf_vmlinux_value_type_id)
>  		/* populate union bpf_attr with btf_fd saved in the stack earlier */
>  		move_stack2blob(gen, attr_field(map_create_attr, btf_fd), 4,
>  				stack_off(btf_fd));

--- Commit Message ---

>     libbpf: plumb btf_vmlinux_value_type_id and btf_fd in gen_loader
>
>     BPF `STRUCT_OPS` maps (such as `sched_ext_ops` maps) require resolving
>     and plumbing the kernel-side structure value type ID
>     (`btf_vmlinux_value_type_id`) into the BPF map creation system call
>     attributes. Additionally, when `btf_vmlinux_value_type_id` is supplied,
>     the kernel requires a valid userspace BTF file descriptor (`btf_fd`) to
>     be supplied to verify types.
>
>     Previously, the `gen_loader` map creation generator
>     (`bpf_gen__map_create()`) omitted plumbing `btf_vmlinux_value_type_id`.
>     Furthermore, `gen_loader.c` only copied the loaded `btf_fd` from the
>     stack to the attributes blob if `btf_value_type_id` was non-zero.
>     Because `STRUCT_OPS` maps explicitly zero out `btf_value_type_id`, the
>     loader program skipped copying `btf_fd`, leaving it as `0` (standard
>     input), which caused the kernel's `btf_get_by_fd(0)` check to fail.
>
>     Fix this by:
>
>     1. Copying `btf_vmlinux_value_type_id` from the options inside
>        `bpf_gen__map_create()`.
>     2. Modifying the `btf_fd` copying condition to populate `btf_fd` if
>        either `btf_value_type_id` OR `btf_vmlinux_value_type_id` is set.
>
>     Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>

This looks like a bug fix for STRUCT_OPS map creation in gen_loader. The
bug was introduced in commit 67234743736a ("libbpf: Generate loader
program out of BPF ELF file.") which created gen_loader.c but omitted
copying btf_vmlinux_value_type_id to the map creation attributes and only
conditionally copied btf_fd when btf_value_type_id was set. This caused
STRUCT_OPS maps (which zero out btf_value_type_id but set
btf_vmlinux_value_type_id) to fail with btf_get_by_fd(0) errors. Should
this include:

  Fixes: 67234743736a ("libbpf: Generate loader program out of BPF ELF file.")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26512949106
--===============0920188431839944315==--
