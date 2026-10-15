Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111A3BCD37
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067080; cv=none; b=U/eKIJHDRKqDBYCK6jEcfzp2ScZ+DHb92Uj6KF7yc6+frsCVubNX4qZR8BYNNbSsVgauSSC9BJ7jxJFbQ8CsMPEUnTuAMFD07lu3jwAnnhyDXeIOSSk46i1Kx3joJWLl7PaZlj7UrStUDzyeDjwUI7zjAY4UCiBw4Cprwx0OzBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067080; c=relaxed/simple;
	bh=dset35RhGMmS5sVq5zirnSXgjVc1M1gjy3gg9nYncrA=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=ovBAXl/5vHRP6re0kotq6AJIt5FRyytkQV3Bej0wVgbuaPWmTRkKuwKGYNnM9i211u5iUxPZs2SU4T1/Bu+sfTrw9f/eOmQCWI3LPXY9oA6C9Kjiu+D+9RF6SgPLDk9WpZmQaVhGosh5Y92VeNa23vNHsU6Wk2DRR0ybHWx1XwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9AJSyhD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9AJSyhD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC7C1F000C4;
	Thu, 15 Oct 2026 12:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067079;
	bh=xxh7pDUB2zFyM6bEbZzsoRc/WGSTWrPkASxP1kEIUyQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=K9AJSyhDBAc+V8TLyKvXTDG6Siy1Ta9zHpVYiqtQsHh52vFXy7BZijDvrWf70nOFy
	 zA4bcj1+Q5n6iw0qTNW0I7mM2wsiLbjCAFcmzlRtnD6Oqg2oeL7+QOwA70AR4S5NQS
	 YtM3bCD4jf6h0vOyMwMjMG5BLN783J/whHyXow3HmVFAAJN2oWxufXLbfV8nrUavn3
	 of8F3BV4gNcfhxuqhvO0yPe+Jw1TbzNvXd1AafYPr2pJn3fF7c8PLrstCC9VZcbcPo
	 4S8E1XZAdUeDxVQFu+crFXJhUXsJjdxrPpNyFXY/lumvjEgDenVVSDwhKMHk2fI0am
	 RyDsOBU7O+REA==
Message-ID: <sashiko-outbox-172791@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/1] bpf: reject raw iteration over managed
 sk_storage values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiling Zou" <zhilinz@nebusec.ai>, bpf@vger.kernel.org
In-Reply-To: <1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai>
References: <cover.1791980149.git.zhilinz@nebusec.ai>
 <1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:24:38 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: bpf_link_update bypasses iterator map->record safety check
--

commit 756d826567f6b13fb5453e6e861ce172e85fb4c1
Author: Zhiling Zou <zhilinz@nebusec.ai>

bpf: reject raw iteration over managed sk_storage values

The sk_storage iterator exposes values as raw memory. This commit attaches
validation checks against value_size to prevent BPF programs from modifying
BTF-managed fields like kptrs.

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 1d295a8769fad..b54fd90d4bde9 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -863,6 +863,12 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
>  	if (map->map_type !=3D BPF_MAP_TYPE_SK_STORAGE)
>  		goto put_map;
> =20
> +	/* The iterator exposes values as raw buffers, bypassing field checks. =
*/
> +	if (map->record && prog->aux->max_rdwr_access) {
> +		err =3D -EACCES;
> +		goto put_map;
> +	}

[Severity: High]
This security check is only performed during initial attachment. Can this be
bypassed using link replacement?

If an initial BPF iterator program is loaded with max_rdwr_access =3D=3D 0,
attached to an sk_storage map containing managed fields, and then replaced =
via
bpf_link_update with a program where max_rdwr_access > 0, won't it bypass
this check?

Looking at bpf_iter_link_replace() in kernel/bpf/bpf_iter.c:

static int bpf_iter_link_replace(struct bpf_link *link,
				 struct bpf_prog *new_prog,
				 struct bpf_prog *old_prog)
{
	...
	if (link->prog->type !=3D new_prog->type ||
	    link->prog->expected_attach_type !=3D new_prog->expected_attach_type ||
	    link->prog->aux->attach_btf_id !=3D new_prog->aux->attach_btf_id) {
		ret =3D -EINVAL;
		goto out_unlock;
	}

	old_prog =3D xchg(&link->prog, new_prog);
	...
}

It swaps the program without checking the new program's max_rdwr_access
against the attached map's BTF record.

> +
>  	if (prog->aux->max_rdwr_access > map->value_size) {
>  		err =3D -EACCES;
>  		goto put_map;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791980149.gi=
t.zhilinz@nebusec.ai?part=3D1
