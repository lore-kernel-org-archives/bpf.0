Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488424EA90
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 03:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782098700; cv=none; b=b8C0cHhwROw9XkdQUBBAigCBf9LinxAE93lI2z1qCGpKT3gySZoQoPkhdAuz6gydrItquSEJ8JQjQbxQhmDb5+78JhSQ201Mt9yj8R5PNGozWdkhrHfFjZGBo2h6+GrCNur1CuiA/JTH2O4xib9VbJng4cIwqDBdk9I1Ss3U65g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782098700; c=relaxed/simple;
	bh=xlKK9tJp12CNqYiRXi0/CPQD7etJazB32jF8Rt4pgGE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q2qpFsJERQ932O5AMODSamY3T7vjJM+IXYFLmVReIQH7pjW9O+6iBGVyteB1zJXIs3QXllffyPY05xeSGC4cZfTw71X07ZPbkMNsUfAYO09RciFdHu/eMhZKkbyyl5kOp16P0e3VV9FfuRe0pPZ1/rvF4M6ym7inZoPuNcHlvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9pe7QGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9pe7QGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71211F000E9;
	Mon, 22 Jun 2026 03:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782098699;
	bh=lCDDDvwwAA2Zdz0znRXcuBmh3SBWVJSJ7ur35Hi6eWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k9pe7QGj4020Nyk8AUTh+kdIGp8TR3saFSngUY7gZat2Acvt+H2ZizQRYX0uGVDRd
	 pLKHKtlI9HvYAo+XyWcT5PpFm3hVPF+2mGZhkQ/LAMwJ5dnir257at1BE96LNfih4x
	 6Ho3blOPLV9u3kIxCzZBAK8Dii6WxPsIcNXbTcd0h2pUt5KBw4FTxNblxRCtUM3pib
	 2rycR21z6ZyUFSvopAyj1TN4/LxNtp6s/BF/k1LV4UwXFJPGPdBCPyyi9elzg7uSG7
	 390Id78yJQ6jgBwCqp9vbp0ahDKQH9HTYDiPBUr9AyRCmLT7G4GO8cmy6r1E4L0CIg
	 7N0WIW4Uxkzlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] tools/bpf/bpftool: Reset vmlinux BTF after
 struct_ops commands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yichong Chen" <chenyichong@uniontech.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <70577DC64C69EA1B+20260622031255.1160657-3-chenyichong@uniontech.com>
References: <20260622031255.1160657-1-chenyichong@uniontech.com>
 <70577DC64C69EA1B+20260622031255.1160657-3-chenyichong@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 03:24:58 +0000
Message-Id: <20260622032458.E71211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Unconditional memory leak of the global `btf_vmlinux` object dur=
ing cgroup tree traversal and batch mode.
--

commit bd1d63c4728bc77ece052cc69d67e204a7e59411
Author: Yichong Chen <chenyichong@uniontech.com>

tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands

struct_ops frees the global btf_vmlinux object. In batch mode, a later
struct_ops command can reuse stale state. This patch resets the BTF
pointer and cached map info state.

> diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_op=
s.c
> index aa43dead249cb..4dba7c96e5f60 100644
> --- a/tools/bpf/bpftool/struct_ops.c
> +++ b/tools/bpf/bpftool/struct_ops.c
> @@ -21,6 +21,15 @@ static __u32 map_info_alloc_len;
>  static struct btf *btf_vmlinux;
>  static __s32 map_info_type_id;
> =20
> +static void free_btf_vmlinux(void)
> +{
> +	btf__free(btf_vmlinux);
> +	btf_vmlinux =3D NULL;
> +	map_info_type =3D NULL;
> +	map_info_alloc_len =3D 0;
> +	map_info_type_id =3D 0;
> +}
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but since we are addressing BTF
memory management and stale state in batch mode, could we also look at
similar leaks in cgroup.c?

In tools/bpf/bpftool/cgroup.c, libbpf_find_kernel_btf() is called
unconditionally to initialize the btf_vmlinux pointer in both do_show() and
do_show_tree_fn(), without any subsequent cleanup.

For example, in the tree traversal:

tools/bpf/bpftool/cgroup.c:do_show_tree_fn() {
    ...
	btf_vmlinux =3D libbpf_find_kernel_btf();
	for (i =3D 0; i < ARRAY_SIZE(cgroup_attach_types); i++)
		show_bpf_progs(cgroup_fd, cgroup_attach_types[i], ftw->level);
    ...
}

Because do_show_tree_fn() is called by nftw() for every directory in the
cgroup tree, it repeatedly allocates a new BTF object and overwrites the
pointer without freeing the previous instance.

Could this cause an O(N) memory leak scaling with the number of cgroups,
potentially leading to OOM crashes of the bpftool process during traversal
or when running cgroup commands in batch mode?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622031255.1160=
657-1-chenyichong@uniontech.com?part=3D2
