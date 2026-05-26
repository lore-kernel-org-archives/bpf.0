Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499FC25A655
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806106; cv=none; b=ALefV/iq9nbpzsld+r7TRam7FU3+HTr0r+rv5ryHLWYkXLQSd6pLtda3H56lK0MqRd8WWMN26V8eVzWurxtQY4mSPPw06tRmAMv8CipDpJf01pYjIPxuMkNqiIV9A+06Mcpwbd1J1oKFoEs1ax3FXG13cOiBcuQaJPlN7/dpGJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806106; c=relaxed/simple;
	bh=wfQin35MVxAfYir3Tp7o+QwFmuTCwZ/5VE6YpZUHAgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YP6sNEyQ7Uc0gK/n1k9qW9BaM318qN0o4x1k3o7+V3Ea0g6hbIKZUHLaTWw9G+l3yCqkgk82KSJtzRNjGVTEi7HOKyqDSZVgxsryHm1899IgmP1cMNUgIkTRHuiE1jCKaNpKmE2GJnVW8p3w7/SI2rWZpxL5VocSbo0xnFgWOGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERAxseIr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERAxseIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48301F00A3A;
	Tue, 26 May 2026 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779806104;
	bh=ISj5WOZkyxHQ2g+UOqU7zEKgMXDvCvhtt0n9YjA0TM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ERAxseIrf82p7vUgeed3CtkI1tQP+wlwLMrS9fA0vc53/s3jBsgLLUZLwyH7auUZ/
	 v9Bo39yhCm5xuK7zyyaAHgZ7BtqZzdp/juGPo/KPaRfH8lHdyo6MVQpifRtFos4Tk4
	 8gs57hvgNmfmoNcaZvfSLv+q6NHPqmzk2+WNHkJMFAOXAn0DBNyjDX6vSTOolx34KR
	 OSHWYdoO4qfXWzbYLpaIwLIhPQ1aYxbKx2dPE2JM3zDcbnj91nxFh38ufenj3htfOQ
	 kY0iJE+gkzt1E27MgaFW6LOrkzXDX3DgvFpXCBt9ovIZjfszP6jM/8dgs/xfLDRVHB
	 EQT5zYyJukjKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] libbpf: load vmlinux BTF in gen_loader mode for
 struct_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Nayyar" <sidnayyar@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-1-5b4fa2a5e1a4@google.com>
References: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-1-5b4fa2a5e1a4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 14:35:03 +0000
Message-Id: <20260526143504.D48301F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Light skeletons generated for `struct_ops` maps silently bake =
in the build host's specific BTF type IDs and struct layouts, breaking cros=
s-kernel portability.
- [High] The patch introduces a severe regression for light skeleton genera=
tion, causing build failures on machines lacking kernel BTF and adding unne=
cessary parsing overhead for CO-RE programs.
- [High] Light skeletons (`gen_loader`) lack the necessary logic to populat=
e and attach `struct_ops` maps, rendering the feature unusable even with th=
is patch.
--

commit 10cd8d15c2eb1d7b8f90e84836d289ccbf14bdbc
Author: Siddharth Nayyar <sidnayyar@google.com>

libbpf: load vmlinux BTF in gen_loader mode for struct_ops

This commit modifies bpf_object__load_vmlinux_btf() to allow loading the
host's vmlinux BTF even in gen_loader mode. This is intended to resolve
kernel-side struct type IDs and member sizes required for struct_ops maps
during light skeleton generation.

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
Will this cause build failures for standard CO-RE programs in environments
without a kernel BTF (like CI containers)?

The function obj_needs_vmlinux_btf() evaluates to true for any BPF object
containing standard CO-RE relocations. Prior to this patch, gen_loader
unconditionally bypassed loading the vmlinux BTF because light skeletons
defer all CO-RE relocations to the target kernel's runtime.

By deferring to obj_needs_vmlinux_btf(), bpftool is forced to load the
build host's vmlinux BTF for almost all light skeletons. This adds parsing
overhead and will abort generation if /sys/kernel/btf/vmlinux is missing.

[Severity: Critical]
Does this break the cross-kernel portability of light skeletons by hardcodi=
ng
the build host's BTF type IDs?

By allowing bpf_object__load_vmlinux_btf() to run on the build host during
gen_loader execution, the btf_vmlinux_value_type_id and map value_size are
resolved against the build host's specific vmlinux BTF.

When bpf_gen__map_create() later writes this map_attr->btf_vmlinux_value_ty=
pe_id
into the loader program's bpf_attr array, it passes the build host's arbitr=
ary
BTF type ID to the target kernel. Since gen_loader lacks CO-RE dynamic
relocation logic for this ID, it could lead to map creation failures or sil=
ent
memory corruption if the ID collides with a different struct on the target.

[Severity: High]
Can the generated loader actually populate and attach struct_ops maps?

For a struct_ops map to function, it needs to be populated with BPF program
function pointers via bpf_map_update_elem() and then attached. However, the
gen_loader implementation only seems to emit bpf_gen__map_update_elem() for
internal maps like .rodata and .data.

It appears to lack the logic to patch st_ops->kern_vdata with dynamically
loaded BPF program FDs, and the generated _skel__attach() doesn't include
attachment logic for struct_ops maps. Does this mean the generated loader
will merely create an empty, unattached struct_ops map even with this chang=
e?

> =20
>  	if (!force && !obj_needs_vmlinux_btf(obj))
>  		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-libbpf-loa=
d-vmlinux-btf-in-gen_loader-mode-v3-0-5b4fa2a5e1a4@google.com?part=3D1
