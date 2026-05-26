Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EDF357CFD
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 02:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779764306; cv=none; b=JdsUDEcCaocmoCTHDKg7GtbxIrm7CXdrZOCm4DzJLPU11yMKpylGZPei6fKF6g3PxFOv9ZbBPvbCyc8kVhcBHqJ95l+5jewg2XAjQYJYuMAFI8VVs8GnHVxmDHsMOAkfqRmlDoJ0wDKIzlMq1Des4JKyGZdTYaMw5rU07bfsC6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779764306; c=relaxed/simple;
	bh=h+d/K4Z3AmkUr86ZY9TKK7hlkK9F0awt/UXIqqqy7Dw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QtIn5iA7xNoTxismWeD91fkgTV8DyTMTHCuauzU3+FwbFI0SrrIIOhPFK0D/L3kd0v52ocpKXCohdpLe6b/vLBKAlXWwoMebOZex3ujuSJyIGSYH4VcswDvYNy1DuD0eeCKut2BVqhanf7YkzngEfS8QvnXjAyGCNpSkPafa+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECZCTqud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECZCTqud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBDA1F000E9;
	Tue, 26 May 2026 02:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779764305;
	bh=GrA/Ah0JiVcxRFuLUbtvNQiKDvZAtOyAvqXHNjanPrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ECZCTqud8j+NhEsh2DZ8ktr5/4OQX3DCVMBN1JjuGl+gVx6lp2pozgEZ5JRFXyFUP
	 YOZ9q5Iolb/bP6F+Wd2mCZZGxfXYPhlOmMnT9A1HcHCAfEspthRUU46veVFTnEgv3q
	 anJW+j3kpNPiytrLE9xhxt+AvNIdRDOPClR1IvRizbLvoRUNGSKMDFTr8CIWJlK9/y
	 XgWve3233tNo3PO/LAFsCFcGrxIq+i9tS4hXMgeDmLqiLXA5aZJ+ljacMYJ57FcaNa
	 8swbDSQvxvJckL8uSq5RdcCiK6u9zhbUnHHRoVRLNr/fNBbmuRge7SSyEn9oEk/9z5
	 xJyBm1d3fu32g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v7 04/11] libbpf: introduce
 bpf_map__attach_struct_ops_opts()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org, hannes@cmpxchg.org, tj@kernel.org, mkoutny@suse.com
In-Reply-To: <20bdaa33cc19364f5f10208c79ef94fe43bd5ac1.1779760876.git.zhuhui@kylinos.cn>
References: <20bdaa33cc19364f5f10208c79ef94fe43bd5ac1.1779760876.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 02:58:24 +0000
Message-Id: <20260526025824.ACBDA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `expected_revision` field in `struct bpf_struct_ops_opts` is s=
ilently ignored.
- [High] Silent fallback to global struct_ops attachment when `target_fd` i=
s provided but the map lacks `BPF_F_LINK`.
--

commit 38a993fa39aa42f01d7ad014d6fc85b69daffad3
Author: Roman Gushchin <roman.gushchin@linux.dev>

libbpf: introduce bpf_map__attach_struct_ops_opts()

This commit introduces an extended version of bpf_map__attach_struct_ops()
which takes an additional struct bpf_struct_ops_opts argument. This enables
passing a target_fd and the BPF_F_CGROUP_FD flag for cgroup attachment.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1e8688975d16d..a1b54da1ded25 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
[ ... ]
> @@ -13724,7 +13731,9 @@ struct bpf_link *bpf_map__attach_struct_ops(const=
 struct bpf_map *map)
>  		return &link->link;
>  	}
> =20

[Severity: High]
If a user provides a cgroup FD via opts->target_fd to restrict the attachme=
nt
to a specific cgroup, but the map was not created with BPF_F_LINK, does this
silently fall back to global registration?

Looking slightly above this block:

	if (!(map->def.map_flags & BPF_F_LINK)) {
		/* w/o a real link */
		link->link.fd =3D map->fd;
		link->map_fd =3D -1;
		return &link->link;
	}

If BPF_F_LINK is missing, it returns early before extracting and applying
opts->target_fd. Should we explicitly reject the operation if opts->target_=
fd
or opts->flags are set but the map lacks BPF_F_LINK, to prevent subverting
the user's intent to isolate the struct_ops?

> -	fd =3D bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
> +	link_opts.flags =3D OPTS_GET(opts, flags, 0);
> +	target_fd =3D OPTS_GET(opts, target_fd, 0);

[Severity: High]
Is the expected_revision field intended to be extracted here?

It is defined in struct bpf_struct_ops_opts but never extracted via
OPTS_GET() or checked. If users attempt to use expected_revision to prevent
TOCTOU races during atomic replacements, will they experience silent
failures because the field is completely ignored?

Should the library either remove this field from the struct, or explicitly
check for OPTS_GET(opts, expected_revision, 0) and return an error?

> +	fd =3D bpf_link_create(map->fd, target_fd, BPF_STRUCT_OPS, &link_opts);
>  	if (fd < 0) {
>  		free(link);
>  		return libbpf_err_ptr(fd);
[ ... ]
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index bba4e84643967..18af178547ad5 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
[ ... ]
> @@ -945,6 +945,20 @@ bpf_program__attach_cgroup_opts(const struct bpf_pro=
gram *prog, int cgroup_fd,
>  struct bpf_map;
> =20
>  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_=
map *map);
> +
> +struct bpf_struct_ops_opts {
> +	/* size of this struct, for forward/backward compatibility */
> +	size_t sz;
> +	__u32 flags;
> +	__u32 target_fd;
> +	__u64 expected_revision;
> +	size_t :0;
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779760876.gi=
t.zhuhui@kylinos.cn?part=3D4
