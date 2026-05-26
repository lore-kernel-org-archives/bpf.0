Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370881D5CFB
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809321; cv=none; b=VMJ5NyogPI7QcZJ//HVQbUGP18qBDP50r9GvVmVdV5bP2WoCMyx1Ut6uQo9hp54w4/0sVltFQ9iKV2ME7JEFcIer67aj1iTtLHGsNwk1l87ckqAZSAMpjw6UvfodZKkhdmQ+Dan12dcNkR1P+6rRfp+LEYjOwSDuCmjZvc7aY3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809321; c=relaxed/simple;
	bh=LsPpajqk5PKwskbSTzhEfOKaIlgezGYNg9XRMFLRW+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lVVs2Z2+aZ5R6IKAGH8vVSlQDHcCTmmIY49/PxWpxBWQfgUxkclAXQuAmzCfRmvI9QzslNWLgipAs26xRt23WvH3TPw3Hgtu+p0+XpsskCiqmiJMgzj/QS0s/0HCvs1koDgm9nA1OHZUxkCdS923yfdbiFa0dsPHHhW8gMUSdp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T++/NWHu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T++/NWHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC111F000E9;
	Tue, 26 May 2026 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809319;
	bh=CrllTQdc3g0JJGgq+YnzJ+V1uPfcBHZcqYgvvcuFY+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T++/NWHuF6tbOdhAQnEbmCW7yaMy9/5yeTcLnnY6N88SSvC2Jt+YkFTyhU7HaBOTA
	 WE0F/bRjKOkps+jx5rLYF3uMGcDeXQlWiZiOJSx9/e7QeWNeo33Cu1H3d5Cg9SmPSX
	 fUxvBmr0PMOlRKSjwddaFZzZ01wdoLVg48sewNVLysMyYeaYqADMgsTGIu+w8ZCZCi
	 j2QPkJjXyRMWXwti0bpeHsFnziCKmo3tXRxU+NoihRlrzJTCkhqG3aH1AkfmJTI5rS
	 i9VbDIvmu4jQgRIpeV1uUBgVr32z9SKeQIpJGdXJqnqaej6Qa4eZKKjZaLId9Wrccu
	 GU6GIUqrlU/XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] libbpf: plumb btf_vmlinux_value_type_id and
 btf_fd in gen_loader
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Nayyar" <sidnayyar@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-3-5b4fa2a5e1a4@google.com>
References: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-3-5b4fa2a5e1a4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 15:28:39 +0000
Message-Id: <20260526152839.AEC111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch hardcodes the compilation machine's `btf_vmlinux_value_t=
ype_id` into the generated BPF loader, breaking cross-kernel portability fo=
r `STRUCT_OPS` light skeletons.
- [High] The patch fails to plumb `value_type_btf_obj_fd`, breaking `STRUCT=
_OPS` map creation for interfaces defined in kernel modules.
--

commit 85945ed0f098d529baa42010d50804b0ec6cb5d7
Author: Siddharth Nayyar <sidnayyar@google.com>

libbpf: plumb btf_vmlinux_value_type_id and btf_fd in gen_loader

This commit plumbs btf_vmlinux_value_type_id into the BPF map creation
system call attributes for STRUCT_OPS maps. It also modifies the condition
for copying btf_fd to populate the file descriptor when either
btf_value_type_id or btf_vmlinux_value_type_id is set.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index cd5c2543f54d8..a9be0c241025f 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -525,13 +525,14 @@ void bpf_gen__map_create(struct bpf_gen *gen,
>  	attr.max_entries =3D tgt_endian(max_entries);
>  	attr.btf_key_type_id =3D tgt_endian(map_attr->btf_key_type_id);
>  	attr.btf_value_type_id =3D tgt_endian(map_attr->btf_value_type_id);
> +	attr.btf_vmlinux_value_type_id =3D tgt_endian(map_attr->btf_vmlinux_val=
ue_type_id);

[Severity: High]
Does hardcoding btf_vmlinux_value_type_id here break cross-kernel
portability for STRUCT_OPS light skeletons?

Light skeletons are designed to be portable across different kernel
versions without relying on libbpf at runtime. Because BTF type IDs
are not stable across kernel builds, passing the build machine's BTF
ID to the target kernel might cause the target kernel's
sys_bpf(MAP_CREATE) to resolve to the wrong type or fail entirely with
-EINVAL.

Should gen_loader dynamically resolve the target kernel's BTF ID at
runtime, similarly to how it handles attach_btf_id?

[Severity: High]
Does this also miss plumbing value_type_btf_obj_fd for STRUCT_OPS
interfaces defined in kernel modules?

When a STRUCT_OPS map targets a kernel module, libbpf sets
value_type_btf_obj_fd in bpf_map_create_opts and adds
BPF_F_VTYPE_BTF_OBJ_FD to map_flags. The patch propagates map_flags
into gen_loader's map creation attributes but ignores
value_type_btf_obj_fd.

In bpf_gen__map_create(), attr_size is calculated as offsetofend(union
bpf_attr, map_extra), which truncates the struct before
value_type_btf_obj_fd. As a result, the generated loader program passes
the BPF_F_VTYPE_BTF_OBJ_FD flag to the kernel but implicitly provides 0
for the FD. The target kernel attempts to read BTF from fd=3D0 (stdin)
and rejects the map with -EINVAL.

Furthermore, even if the FD field were included, the loader cannot
hardcode the build machine's module FD; it must dynamically resolve
the module BTF FD on the target machine.

> =20
>  	map_create_attr =3D add_data(gen, &attr, attr_size);
>  	pr_debug("gen: map_create: %s idx %d type %d value_type_id %d, attr: of=
f %d size %d\n",
>  		 map_name, map_idx, map_type, map_attr->btf_value_type_id,
>  		 map_create_attr, attr_size);
> =20
> -	if (map_attr->btf_value_type_id)
> +	if (map_attr->btf_value_type_id || map_attr->btf_vmlinux_value_type_id)
>  		/* populate union bpf_attr with btf_fd saved in the stack earlier */
>  		move_stack2blob(gen, attr_field(map_create_attr, btf_fd), 4,
>  				stack_off(btf_fd));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-libbpf-loa=
d-vmlinux-btf-in-gen_loader-mode-v3-0-5b4fa2a5e1a4@google.com?part=3D3
