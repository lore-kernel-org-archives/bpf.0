Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1051FC7
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 03:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782098726; cv=none; b=YwU3FcHu5qRLKo31Yu7WlCFIdB+QkxBaIFIe3aUVD0Twcxs71cghjdVrWpFgVY/Gy9/v86aYJivDarJIcWDHm+Jnyr4MMW5hVjW4g0DvnOuncRzUC58uLh4+wnAbHfd7KOLht+4snV9siooV1Oq30Z1culF2hmvy4V5wr4ACpkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782098726; c=relaxed/simple;
	bh=LFvKCNVKWX8yk07ZA3gm/CZdHBrpRmNwu2lnmYNrUXo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qr7ivYCjCGt25nIQz3VBQkIPWIgEFt70lBMg4OJKyi9DWetAEKieXIKQzgMsiUhSsJrOwS44TxGpYaH8ZzeEL7Zy9CfekdvhkUFStljuaks73rAFYbJV42fs2azbbt7Mm8i/d/QeZlWexUE9PxFMLojinIwJEaIGMIVE+WO367Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCtAz6hI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCtAz6hI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62AC1F000E9;
	Mon, 22 Jun 2026 03:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782098724;
	bh=YZqbQALFuyQYAHfFXw/rt9x+Mvcs8IlE7W3s2LWCaIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NCtAz6hIv6TQtuon15bODj7QlY2mUmBluzG0xsR0N4BHD/5dfluBU0rkeSnUpzm0i
	 8oAy/F4YSEpXTSOVJ/Bhvb/StNkLCGoDoFz2Hb+66geM8Tz6MSk5sq2Ma20esvfSjH
	 yxBqxXgEPLTQPLuN/fCSvZizkVBespQYXgFGSl7Vz0yduR4qMEWpvXglAGXwreK+fF
	 ykyNuMz3yg6WkvmKNKYe+K7KMrjxh0euSgPIbA8zwzbC7jg84u0zxerKn1R6hmMTXL
	 Fy081Ty09+m0B1T9cHTBI3bjWuHurdkhIoB3DhqYuygBdS7v3J9+xNLAk1JQX6JMIr
	 lREBthnOm+26Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] tools/bpf/bpftool: Reset vmlinux BTF after map
 commands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yichong Chen" <chenyichong@uniontech.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <70577B1B956C33F3+20260622031255.1160657-2-chenyichong@uniontech.com>
References: <20260622031255.1160657-1-chenyichong@uniontech.com>
 <70577B1B956C33F3+20260622031255.1160657-2-chenyichong@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 03:25:24 +0000
Message-Id: <20260622032524.B62AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded memory leak of vmlinux BTF object during `bpftool cgroup=
 tree` execution.
--

commit c2cdea6fdb621f7e2e4a217204d6fd383a327434
Author: Yichong Chen <chenyichong@uniontech.com>

tools/bpf/bpftool: Reset vmlinux BTF after map commands

This commit fixes a use-after-free in bpftool map commands by correctly
resetting the global btf_vmlinux pointer when the map command releases
the object. This prevents batch mode from reusing a dangling pointer.

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
This isn't a bug introduced by this patch, but while you are fixing the
btf_vmlinux cleanup here, does tools/bpf/bpftool/cgroup.c need similar
attention?

Looking at do_show_tree_fn() in cgroup.c, it unconditionally allocates a
new BTF object over the global pointer:

        btf_vmlinux =3D libbpf_find_kernel_btf();
        for (i =3D 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {

Since do_show_tree_fn() is called by nftw() for every directory in the
cgroup tree, it overwrites the global pointer without freeing the previous
object. Could this lead to an unbounded memory leak and potential OOM killer
invocation when walking extensive cgroup trees?

The same pattern also appears in do_show() for batch mode:

        btf_vmlinux =3D libbpf_find_kernel_btf();
        for (i =3D 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {

Would it make sense to reuse the new free_btf_vmlinux() logic to plug
this leak as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622031255.1160=
657-1-chenyichong@uniontech.com?part=3D1
