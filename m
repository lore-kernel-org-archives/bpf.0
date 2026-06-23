Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B663B27E2
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782258823; cv=none; b=Wu/eMKducolmbv1uQMy7Wlnm1Vp7A2sYEFnfh/CNlIvRnepPA0jGTqBfXHQdNWsrn4WQnFyw+IDhqZGwHUKcQcJVKuoNznOF+l7L/bN7XrVQUNM4Ye5hPKYk5CoMDxkJe+jwKwp25FpIHhvqC5ybgmtCv+llCEe90Z5mAQQHGZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782258823; c=relaxed/simple;
	bh=uV9ALmcAAkiHykYWECMa1aoRFXerAqzTE01c9hOzRUo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MK8WAaDeM3nbQXPPafws2MRuVWGoLpcpPrBXA3Oy5ZsFqNsJ89Yf1R9fgiVY1tMjPXniMBw+8lzzm0+aUDIr3FTUj56Yrp/Yv1PCKH6SJ/9rtAip1Ma+0gPhw5mes02BKQq3fOMAaABjYZepzgOP7r9Ft825DxsQs1BSzqtl3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niZ5wTl9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niZ5wTl9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B1D1F000E9;
	Tue, 23 Jun 2026 23:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782258822;
	bh=2diG7krSBHy3mXxKfYKDloaDtgvFzCySJuNEjJNNuGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=niZ5wTl9ZQ5kCAL8YjfiF34i7Alk+yrzmV7+qPtrwco5RDB65ukZiiu7g3Qs3UcMi
	 LCqSy6ZtL08PCCnopFPZUcLsQeWaevv9spdKm2jID/BvXc10iG/2Vs3QcFBDq3DpGP
	 YgnjXDFkGFHTICLjmpM6Zq7boekpVEad4fCawGMzOGaVHHHm88lEIqgO5CYgclsIz4
	 +zkMqR32xX5wfLU4iHSiyYePl/dJYec/NtxKBrfzi2INzPXEzBrDtGmuL3ANJEzSSV
	 WKFoWMEwTF0aPxK5PEDRbey3MwAtGRQyL+Wjqs9clSR7+yZHfBOimqtKxYSuSk+KLG
	 x7kF3bkvcJADA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 13/15] libbpf: Support attaching struct_ops
 to a cgroup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623175006.3136053-14-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
 <20260623175006.3136053-14-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 23:53:41 +0000
Message-Id: <20260623235342.01B1D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf_map__attach_cgroup_opts() does not verify that the map has BPF=
_F_LINK set before calling bpf_map_update_elem(), leading to unintended glo=
bal registration of the struct_ops map.
--

commit 4549a23db01bbdf38f2f884251281fc0a75a8c97
Author: Martin KaFai Lau <martin.lau@kernel.org>
Subject: Add bpf_map__attach_cgroup_opts() to attach a struct_ops map to a =
cgroup

This commit introduces bpf_map__attach_cgroup_opts() to allow attaching a
struct_ops map to a cgroup via a BPF link. It also extends
bpf_prog_query_opts with a type_id field to select the struct_ops type
during a BPF_STRUCT_OPS query.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1368752aa13c..17f8466e33fa 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
[ ... ]
> @@ -14104,6 +14104,65 @@ struct bpf_link *bpf_map__attach_struct_ops(cons=
t struct bpf_map *map)
>  	return &link->link;
>  }
> =20
> +struct bpf_link *bpf_map__attach_cgroup_opts(const struct bpf_map *map, =
int cgroup_fd,
> +					     const struct bpf_cgroup_opts *opts)
> +{
[ ... ]
> +	link =3D calloc(1, sizeof(*link));
> +	if (!link)
> +		return libbpf_err_ptr(-ENOMEM);
> +
> +	err =3D bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);

[Severity: High]
Does this function need to verify that the map has the BPF_F_LINK flag
set before calling bpf_map_update_elem()?

If a user passes a struct_ops map without the BPF_F_LINK flag to
bpf_map__attach_cgroup_opts(), bpf_map_update_elem() will globally
register the struct_ops.

The subsequent bpf_link_create() call will then fail because
BPF_STRUCT_OPS links require BPF_F_LINK. This results in the struct_ops
remaining globally active on the system despite the API returning an error.

> +	if (err && err !=3D -EBUSY) {
> +		free(link);
> +		return libbpf_err_ptr(err);
> +	}
> +
> +	link->link.detach =3D bpf_link__detach_struct_ops;
> +
> +	fd =3D bpf_link_create(map->fd, cgroup_fd, BPF_STRUCT_OPS, &link_create=
_opts);
> +	if (fd < 0) {
> +		free(link);
> +		return libbpf_err_ptr(fd);
> +	}
> +
> +	link->link.fd =3D fd;
> +	link->map_fd =3D map->fd;
> +
> +	return &link->link;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623175006.3136=
053-1-ameryhung@gmail.com?part=3D13
