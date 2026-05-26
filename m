Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C81A2C0B
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 02:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779763306; cv=none; b=gPFXPu+hveamnGMtv/Vt8vah0cZzmdhvDzAwTyT5bZDYW7yea61djma/zyUMxB7rh0DsCmqKVvOCrnoJTHQYJVS4UuT0MOVlLd2NcL2rWSmCIxxe4xm0a/TywbT9gGzROnz9MmQHsRY53nB5lT2zDQurBvaGwbE/dDXBDlL1nnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779763306; c=relaxed/simple;
	bh=7K6b35/Ns2ec9TuPKzzNU/OT+/AYh4ZmF8emTS8VXPQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IloP939HHGBp+N0QMbGDf66dfhHh+qmz+aa2c00qfF0AbgyNv5RiXFU7PpO7OHrLLRKsXcs3fLDSbINuqJJ/eYjcDsltGWLE8/AzU7Ki31oxDJdVkpvNvnYb9CGGwemXsQ/VaAb/IQ5fFcLFDCjg7pp/uzcr62oAAritWd3QtXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ48MGBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ48MGBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5309F1F000E9;
	Tue, 26 May 2026 02:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779763305;
	bh=bRUlFvsg8rvQ21TUyCTO4vbqTyEXg1Fa2SEKtxhwgrk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gJ48MGBKEnn7zbmhlZbWimwiS29ZdIAKGA/RYlkUI70jCttGCpcqR8DVTIc3tgfx6
	 1Tz/B+gFcUDXYXfJz+2wbtqkl6FZ87OHo2a/DUuQ1C/scAsVqJ+Ld0mGSQ/Tf6cxva
	 K3Y0Apa1vFuQIw6tIOoPwKo0SMz4mnNlY4XMJuBshAiYR2rhCeLnrrAt/KjGRkP8mJ
	 XAsLiWTPjIyQk7O4L2nGB42iRm/Fb61d97RRcsTR+9cgXV/wlsgzxnzU89mHvuAn+V
	 5jF6rlqx/bGq44Vw3UipByahEoN6Of6wKHnkYSmBT5BD3tVat+SZxHGJfw+kaSpBSu
	 oaa6KD4tCtixA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v7 03/11] libbpf: fix return value on
 memory allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: tj@kernel.org, bpf@vger.kernel.org, mkoutny@suse.com, hannes@cmpxchg.org
In-Reply-To: <8bfb7027abcc02c21db565cf52d6af78a6ce5b7d.1779760876.git.zhuhui@kylinos.cn>
References: <8bfb7027abcc02c21db565cf52d6af78a6ce5b7d.1779760876.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 02:41:44 +0000
Message-Id: <20260526024145.5309F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_map__attach_struct_ops() and bpf_map__init_kern_struct_ops() c=
an dereference a NULL map->st_ops pointer if the map type is manually set t=
o BPF_MAP_TYPE_STRUCT_OPS or maliciously defined in an ELF file.
--

commit c643fee98cc31443df8f0acc1fcfd6c87f93a4f8
Author: Roman Gushchin <roman.gushchin@linux.dev>

libbpf: fix return value on memory allocation failure

This commit fixes the return value of bpf_map__attach_struct_ops() to
correctly return -ENOMEM instead of -EINVAL when memory allocation for
the link structure fails.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -13701,7 +13701,7 @@ struct bpf_link *bpf_map__attach_struct_ops(const=
 struct bpf_map *map)
> =20
>  	link =3D calloc(1, sizeof(*link));
>  	if (!link)
> -		return libbpf_err_ptr(-EINVAL);
> +		return libbpf_err_ptr(-ENOMEM);
> =20
>  	/* kern_vdata should be prepared during the loading phase. */
>  	err =3D bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);

[Severity: High]
This is a pre-existing issue, but can this dereference a NULL map->st_ops
pointer?

If a user manually changes a map's type to BPF_MAP_TYPE_STRUCT_OPS using
bpf_map__set_type(), or if a malformed BPF object file defines a map in the
.maps section with this type, map->st_ops is never allocated.

The bpf_object_init_struct_ops() function only allocates st_ops for maps
found in the .struct_ops and .struct_ops.link sections.

Because bpf_map__is_struct_ops() only checks map->def.type, could a missing
NULL check on map->st_ops here and in bpf_map__init_kern_struct_ops() lead
to a crash when privileged daemons parse untrusted BPF ELF files?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779760876.gi=
t.zhuhui@kylinos.cn?part=3D3
