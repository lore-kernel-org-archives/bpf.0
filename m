Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745473B6347
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200285; cv=none; b=Cwi8oSrApAvApapwzWXYpzAcQRJLriZggra3mZlANsIIWFoJV9iYDJVFgJinNDvb9MnV2zF9XGk/HBicuviI3S1C38TYOnZrPXtUJVdz3FRCWvyupyXYhatnnFAkM4ja1z5Rwh1RxkaM3ve8rSSsswiMMMDwZqbJ1m/+hWCkuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200285; c=relaxed/simple;
	bh=P4bsC2aLci1DbmNem0FXNu0pu7IfZSRID6UA1P/8uRk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rdFUv1l2MmTus422XhLNTaJbmlTk+vQSMAhIkgFh2zRLOxOopFdzCMnbMMsQCLd3O51/cwMprCpwp6uqJ4SsejV8ubXlz2nMknUrxsHgK+EAp+JjhJghnlFIsUfuPB9FxrwgopmvgkcrKNsYrPPFTsm0+txmjyNeWlsOmX9dYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lpw4uLEv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lpw4uLEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015511F00A3A;
	Tue, 23 Jun 2026 07:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782200284;
	bh=AiXi3Pbhun4kwaiXjRCLaAJ741IWIlUCusw1lExhz/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lpw4uLEvfsvFh8enLccwODR4eVHs3T6Gko91VVFi43o/wMD4vP1KXe0P2++6BWNGD
	 uL7HOq845oO3mCKes7K41q75I6EmcX+Z9fmjYRylWMeoZo/V8f0Ctp27dd9raCwuPF
	 BLi9wWCBW5m5LHHk0bMD6hage/FzrRYTOY2zlBxV2FY8fF6JCTB5Ey777p+bXWo0fV
	 jxV18ne6y0UEWjpvaBYEjNm6kXDeveaGuxCBvVCqklTUSrD+WPINMvZAF44Exb+mFC
	 A1oAErRfQcPMmqBVOu4kyPbX01CyJ0jCgSEO7G1HSkL8qsYP0ssQjuUJaqSGu9kH5c
	 fmyXYhqu7kmAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] tools/bpf/bpftool: Reset vmlinux BTF after map
 commands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yichong Chen" <chenyichong@uniontech.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <E2D0E58A0333B7F3+20260623072220.1421837-2-chenyichong@uniontech.com>
References: <20260623072220.1421837-1-chenyichong@uniontech.com>
 <E2D0E58A0333B7F3+20260623072220.1421837-2-chenyichong@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 07:38:03 +0000
Message-Id: <20260623073804.015511F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of btf_vmlinux in cgroup.c subcommands
--

commit 20f01631a8680469e5ce832fb9e313bcd34e8d13
Author: Yichong Chen <chenyichong@uniontech.com>

tools/bpf/bpftool: Reset vmlinux BTF after map commands

get_map_kv_btf() caches the vmlinux BTF object when a map uses
btf_vmlinux_value_type_id. This commit introduces free_btf_vmlinux() to
properly clean up the cached btf_vmlinux pointer when the map command relea=
ses
the object, keeping batch mode from reusing a freed BTF object.

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 71a45d96617ed..6b9649294ca1a 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -790,6 +790,12 @@ static int maps_have_btf(int *fds, int nb_fds)
> =20
>  static struct btf *btf_vmlinux;
> =20
> +static void free_btf_vmlinux(void)
> +{
> +	btf__free(btf_vmlinux);
> +	btf_vmlinux =3D NULL;
> +}

[Severity: High]
This isn't a bug introduced by this patch, but since you are fixing the
btf_vmlinux leak here, could there be a similar memory leak of btf_vmlinux =
in
tools/bpf/bpftool/cgroup.c?

In do_show_tree_fn() and do_show() in cgroup.c, a new BTF object is allocat=
ed
with libbpf_find_kernel_btf() and unconditionally assigned to btf_vmlinux
without freeing the previous instance:

tools/bpf/bpftool/cgroup.c:do_show_tree_fn() {
    ...
    btf_vmlinux =3D libbpf_find_kernel_btf();
    ...
}

Since do_show_tree_fn() is called for each cgroup during nftw() traversal,
could this repeatedly leak the kernel BTF object (which can be several
megabytes) on each cgroup processed? This seems like it could lead to an
out-of-memory crash when running the "bpftool cgroup tree" command on a sys=
tem
with a moderate number of cgroups.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623072220.1421=
837-1-chenyichong@uniontech.com?part=3D1
