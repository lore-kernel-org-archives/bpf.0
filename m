Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AEE33C1B7
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624711; cv=none; b=ElQwBIpb66ABkWL0pUogPUVv4o+Rdesba2GsQK6NGID4d9p/nRLACNYLHe2yC0iM9zV0FvXGYSV9Dm1g2pNyG+UX+IZ2M5mv60qx6EDIeybdrK2XP8a/T4sKpHvtXyb4qOQH+jNq7oIgG5a9jjR6SIIbeT2C1sUcdLxMD3nn/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624711; c=relaxed/simple;
	bh=VSiyGxfdZVIG0tyRctlHDMGPxm+AvJ0o3D2U9ewR7M8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jqMkgTarQqwkWoAKq6YvN7RXn9F1otU0Zv/B6pRO8KRmk5+T572R92zEuPQEQ63lAhOmHdGFeregqMtiI6/xnBTDpNkJlJ/w/cw0WJ7giZL3fdu6C5o6gbQe7tNH0rl9tHWynM0HBbMcya+jUEIIWnTh1N3bsI6gW0pxl9xZR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7LPT7+S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7LPT7+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5161F000E9;
	Sun, 24 May 2026 12:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624709;
	bh=eYxjnhWDDcnE7fUXx5RNoufp32mgICX7TCWC/KQT950=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I7LPT7+StgniPHxJJpV/BoOAuuP+lnrTsHq8YicdpQxXvZuNdO2MwMIS7WFT9jJoz
	 erZbyJk84AjG0bPcnjwCxRnfNDwYjjr69ur7OAkFJQArweEToqhSZGVjy5wGJVEpeO
	 a8VvMQ2Vqa4ps8BX48slJP0ujdk1htfWxtqsvzvk+LrmpmoqtnRB+uB4/c4frGWvSr
	 eBXxy08lzjal55lDrNN2wgkUYswZr205CfIabwKFom0prQcA1GGf+A7V6xXus/fbJk
	 nkZKQOiWR8Ka2JGewSqeGtLWvPx6zOmKK8irzt0raJh6QPwJj4vdJXxSuQc+auLyVe
	 LIq1Vxg5jOGfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libbpf: load vmlinux BTF in gen_loader mode for
 struct_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Nayyar" <sidnayyar@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260524-libbpf-load-vmlinux-btf-in-gen_loader-mode-v1-1-6f57f191a7ad@google.com>
References: <20260524-libbpf-load-vmlinux-btf-in-gen_loader-mode-v1-1-6f57f191a7ad@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 12:11:49 +0000
Message-Id: <20260524121149.9C5161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Loading the host's vmlinux BTF during light skeleton generation br=
eaks cross-compilation and violates CO-RE portability.
- [High] gen_loader lacks the required serialization logic for struct_ops m=
aps, causing map creation and population to always fail at runtime.
--

commit 4a8af02f733008cd5b32a3e75eeb77e1a32175fb
Author: Siddharth Nayyar <sidnayyar@google.com>

libbpf: load vmlinux BTF in gen_loader mode for struct_ops

During light skeleton generation (bpftool gen skeleton -L), libbpf
runs in gen_loader mode. Previously, bpf_object__load_vmlinux_btf()
completely bypassed loading the kernel vmlinux BTF (obj->btf_vmlinux)
if gen_loader was active.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3a80a018fc7d5..cb1b7ea884a77 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3590,7 +3590,10 @@ static int bpf_object__load_vmlinux_btf(struct bpf=
_object *obj, bool force)
>  	int err;
> =20
>  	/* btf_vmlinux could be loaded earlier */
> -	if (obj->btf_vmlinux || obj->gen_loader)
> +	if (obj->btf_vmlinux)
> +		return 0;
> +
> +	if (obj->gen_loader && !obj_needs_vmlinux_btf(obj))
>  		return 0;

[Severity: High]
Does loading the host's vmlinux BTF during light skeleton generation break
cross-compilation and violate CO-RE portability?

Since obj_needs_vmlinux_btf() returns true for any object using CO-RE
relocations, generating a light skeleton on a build host without a kernel B=
TF
(common in CI/cross-compilation environments) will fail.

Additionally, for struct_ops, extracting layout information from the build
host's kernel violates CO-RE principles. The host's btf_vmlinux_value_type_=
id,
sizes, and offsets would be extracted and intended to be used on the target
machine, which could lead to mismatched types and memory corruption if the
kernel accepted it.

[Severity: High]
Is the required serialization logic for struct_ops maps missing from
gen_loader, causing map creation and population to fail at runtime?

In bpf_gen__map_create(), the code does not copy
map_attr->btf_vmlinux_value_type_id into the generated union bpf_attr
buffer, leaving it as 0. Because the kernel explicitly requires this ID
for BPF_MAP_TYPE_STRUCT_OPS maps, map creation will fail at runtime as
bpf_struct_ops_map_alloc_check returns -EINVAL.

Furthermore, gen_loader lacks the logic to emit BPF_MAP_UPDATE_ELEM
instructions to populate the struct_ops function pointers (kern_vdata).

> =20
>  	if (!force && !obj_needs_vmlinux_btf(obj))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524-libbpf-loa=
d-vmlinux-btf-in-gen_loader-mode-v1-1-6f57f191a7ad@google.com?part=3D1
