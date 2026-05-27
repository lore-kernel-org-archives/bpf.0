Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B62459E5
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891044; cv=none; b=Q3oMRR9ddVHySUi2O7johG307cnnqIKxA4pQJr4qi+pCapb9uNrqO7+H/36uAGelqoiBci33W5I/IZn7cedpa307KH0vLRMy5suzNwp/DNGcMlUHDU2obmgnes9Y2en5xWYCkxkXqKZVTuekgGLD/5enKGJ109y86gq5cLZy9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891044; c=relaxed/simple;
	bh=UyRTCRZ48neXRrSbpouwBubiwyAcivtvc4ZzzJqW6CY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DBqd/uR4yvnjQDoOtSVjjSp7t5iETAsD0jEUoH19KjCwNrjC73tmr9Fi7PQnPXFfFkLn2YtUrSif43TxGZvjBHDQxav8es3QFwXjn+l2XBxV+kHrOjczYJbGTC7hy0bEqAzZajxa4dawK8Xr76Go1SxUE0D4oJ0Y68FI077OvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GunCRIdZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GunCRIdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B632E1F000E9;
	Wed, 27 May 2026 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779891043;
	bh=MOo/KfV7cqDWgWw8V6/Dka49eHXe2NH/b8KTlaAswLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GunCRIdZEQCAYWeu61gEh/xa5xHUBVTUxQHjiT8C2zOZemiWhBC9x/wwdBmOQkXWG
	 qOL2+6w+gG3mKJW0ld/oXatnfRHFJqVsIzKPH3YoEYjdbmLI8waeR9Cc1nLAoWRHcY
	 3WX88vQRTN8Grr2YZMJS5lVrsjjpyk9L1LwhUr7b8T2GjNnVAwBEe5k5NJwKrOECYe
	 AOrJ2IB+X0sI4y177+nd7JhAz5tqTf8eEgvD5dVKgGwlwB2OL+RlCG3naZx1tMnQ2l
	 5mvTkz9PdKfZcUqH0a9/AezBbKxNRg05V3BCj5nWrtGKnt9rIgoYcHhSZWuS4cZZu0
	 GYUocZHh7azlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] libbpf: plumb btf_vmlinux_value_type_id and
 btf_fd in gen_loader
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Nayyar" <sidnayyar@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-3-27daa15487a9@google.com>
References: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-3-27daa15487a9@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 14:10:42 +0000
Message-Id: <20260527141042.B632E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch truncates the bpf_attr payload, dropping `value_type_btf=
_obj_fd`, which breaks module-backed STRUCT_OPS maps in gen_loader.

Pre-existing issues:
- [Critical] Double-close of `inner_map_fd` in the gen_loader cleanup path =
can hijack and close an unrelated file descriptor.
- [High] The condition to populate `btf_fd` incorrectly omits `btf_key_type=
_id`, causing map creation to fail if only a key BTF type is defined.
- [High] Memory leak of dynamic arrays `gen->relos`, `gen->ksyms`, and `gen=
->core_relos` in the error path.
--

commit b58090bc2b448f8a5c71dbba37463b5a9e73fdd5
Author: Siddharth Nayyar <sidnayyar@google.com>

libbpf: plumb btf_vmlinux_value_type_id and btf_fd in gen_loader

This commit updates the BPF map creation generator to plumb the kernel-side
structure value type ID (btf_vmlinux_value_type_id) into the map creation
system call attributes. It also modifies the condition for copying the
userspace BTF file descriptor so it populates btf_fd when either
btf_value_type_id or btf_vmlinux_value_type_id is set.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -525,13 +525,14 @@ void bpf_gen__map_create(struct bpf_gen *gen,
>  	attr.max_entries =3D tgt_endian(max_entries);
>  	attr.btf_key_type_id =3D tgt_endian(map_attr->btf_key_type_id);
>  	attr.btf_value_type_id =3D tgt_endian(map_attr->btf_value_type_id);
> +	attr.btf_vmlinux_value_type_id =3D tgt_endian(map_attr->btf_vmlinux_val=
ue_type_id);

[Severity: High]
Does this code truncate the bpf_attr payload and drop value_type_btf_obj_fd?

At the top of bpf_gen__map_create(), attr_size is calculated as
offsetofend(union bpf_attr, map_extra). However, value_type_btf_obj_fd was
introduced after map_extra in the union. By plumbing btf_vmlinux_value_type=
_id
here without expanding attr_size, the loader may send a truncated payload to
the kernel.

For module-backed struct_ops maps, libbpf sets the BPF_F_VTYPE_BTF_OBJ_FD f=
lag,
but the kernel would receive value_type_btf_obj_fd =3D 0 (stdin). Could this
cause btf_get_by_fd(0) to fail and break map creation?

> =20
>  	map_create_attr =3D add_data(gen, &attr, attr_size);
>  	pr_debug("gen: map_create: %s idx %d type %d value_type_id %d, attr: of=
f %d size %d\n",
>  		 map_name, map_idx, map_type, map_attr->btf_value_type_id,
>  		 map_create_attr, attr_size);
> =20
> -	if (map_attr->btf_value_type_id)
> +	if (map_attr->btf_value_type_id || map_attr->btf_vmlinux_value_type_id)

[Severity: High]
This is a pre-existing issue, but does this condition incorrectly omit
btf_key_type_id?

If a map defines only a BTF key type but no value type, btf_key_type_id wil=
l be
non-zero while btf_value_type_id remains zero.

This means gen_loader would skip populating btf_fd in this case, sending
btf_fd =3D 0 alongside the non-zero btf_key_type_id. Since the kernel stric=
tly
validates that btf_fd must be valid if any BTF type ID is set, will the ker=
nel
reject this with -EINVAL?

>  		/* populate union bpf_attr with btf_fd saved in the stack earlier */
>  		move_stack2blob(gen, attr_field(map_create_attr, btf_fd), 4,
>  				stack_off(btf_fd));

[Severity: Critical]
This is a pre-existing issue, but can the inner map handling later in this
function lead to a double-close regression in the cleanup path?

When emit_sys_close_stack() is called for inner_map_fd, it issues the sys_c=
lose
BPF helper but doesn't zero out the memory slot containing the file descrip=
tor
on the loader stack.

If a subsequent command in the loader program fails, the cleanup routine lo=
ops
over the loader stack and calls sys_close on any file descriptor greater th=
an
zero. Because the inner_map_fd slot was never cleared, it gets closed a sec=
ond
time. If another thread opened a new file or socket in the interim, could t=
his
hijack and close the unrelated resource?

[Severity: High]
This is a pre-existing issue, but is there a memory leak in the error path =
for
the dynamic arrays used during generation?

The arrays gen->relos, gen->ksyms, and gen->core_relos are dynamically allo=
cated
using libbpf_reallocarray(). They are expected to be freed by cleanup_relos=
()
at the end of bpf_gen__prog_load().

If the loader encounters an error earlier in the process, the program aborts
and bpf_gen__free() is called. However, bpf_gen__free() appears to fail to =
free
these arrays or call cleanup_relos(), causing a permanent memory leak. For
long-running daemons parsing untrusted objects, could this be exploited to
cause an out-of-memory crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527-libbpf-loa=
d-vmlinux-btf-in-gen_loader-mode-v4-0-27daa15487a9@google.com?part=3D3
