Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60923093D3
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 04:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153243; cv=none; b=iyVvURzjPMF1gfqtD9xcjQQCEosDAk9wuxKu/9UvnX1dwUnSDuTev0DZlHxrc6yQnbG6p2YpXYLHkGSPX7qBAUVHLdMIk7A+1rGKBaJiTDZjprxoXSrPXRs1frGtlOWa9oAmclZ10bOrSzHxojZbZbGHB+5aJVS4Q5TDsFoVe9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153243; c=relaxed/simple;
	bh=sGchXM5shQuKyj1fUga7kZyEFRAchsGo1yBw7bkdbMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uLouQra89fMTWVUI/qRk3FK4NRezzpUibB69+dm6qhvUdQzLRP7+ML0fY9wFTl0pzcxZ+tBHSOFBd67r4myJ8S/Stv8jCno/uNVbDLN5dGLsB7pytCotxTvY6ZpoqHCLPUBsxJmczMvSqoGJMGZaxn71LTWzII8rWwwq299qQYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAkWJHbM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAkWJHbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174351F00893;
	Thu, 11 Jun 2026 04:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781153242;
	bh=mebvjHF1fsE5X3+ob5362LwkH7DAUQLzkjhwC4G2t2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VAkWJHbMouu2uGNjO6RHsF7q6hwoWqO9ORbcwkTRjgWUUVZ7mXalClKE9KcOu6Sz7
	 SXBlKncEfJ+6XJgLCbeLgc5DebzP2aPLQpSOfoaZJ79vQCKPvo84mLq+Yy8YvhcmhJ
	 h6qPrCpijlCFdOC1WMEuUAu5NtVPDp1YCOpjXor18TxyqOsZ20Nre39wnI2nk0R42M
	 LxlOBrNUL2NcGGdYTCYfPM+3cBi59Jyk1wnyJH/mOiHIOqXKG12UA5nUvqcllyxUmY
	 qe+y15W9fmmVecV/RAhZ2I7ra15H9dPX3B/PL8nyqrKT5aqa25zXaq4Y+ddQLien+v
	 D/0zh7rzgSUQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover generic devmap egress
 last-dst rewrite
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sun Jian" <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611043317.512843-3-sun.jian.kdev@gmail.com>
References: <20260611043317.512843-3-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 04:47:21 +0000
Message-Id: <20260611044722.174351F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized `net_config` is passed to `cleanup_network()` on ear=
ly error paths, causing arbitrary shell commands to be executed via `system=
()`.
--

commit 60bbc3bd1e74368d2d682d8956f86b733750dfd9
Author: Sun Jian <sun.jian.kdev@gmail.com>
selftests/bpf: Cover generic devmap egress last-dst rewrite

This patch strengthens xdp_veth_egress to check that destinations observe
the correct MAC address for their own egress ifindex. It also adds a new
generic XDP last-destination test to cover cases where earlier destinations
do not have a devmap egress program.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/too=
ls/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> index 3e98a16659362..681415cacb75c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
[ ... ]
> +static void xdp_veth_egress_last_dst(u32 flags)
> +{
[ ... ]
> +	struct net_configuration net_config;
> +	int mac_map, egress_map, res_map;
> +	struct nstoken *nstoken =3D NULL;
> +	struct xdp_dummy *xdp_dummy;
> +	__be64 last_mac =3D 0;
> +	bool found =3D false;
> +	int err;
> +	int i;
> +
> +	xdp_dummy =3D xdp_dummy__open_and_load();
> +	if (!ASSERT_OK_PTR(xdp_dummy, "xdp_dummy__open_and_load"))
> +		return;
> +
> +	xdp_redirect_multi_kern =3D xdp_redirect_multi_kern__open_and_load();
> +	if (!ASSERT_OK_PTR(xdp_redirect_multi_kern, "xdp_redirect_multi_kern__o=
pen_and_load"))
> +		goto destroy_xdp_dummy;
> +
> +	xdp_redirect_map =3D xdp_redirect_map__open_and_load();
> +	if (!ASSERT_OK_PTR(xdp_redirect_map, "xdp_redirect_map__open_and_load"))
> +		goto destroy_xdp_redirect_multi_kern;
> +
> +	if (!ASSERT_OK(create_network(&net_config), "create network"))
> +		goto destroy_xdp_redirect_map;
[ ... ]
> +destroy_xdp_redirect_map:
> +	close_netns(nstoken);
> +	xdp_redirect_map__destroy(xdp_redirect_map);
> +destroy_xdp_redirect_multi_kern:
> +	xdp_redirect_multi_kern__destroy(xdp_redirect_multi_kern);
> +destroy_xdp_dummy:
> +	xdp_dummy__destroy(xdp_dummy);
> +
> +	cleanup_network(&net_config);

[Severity: High]
This isn't a bug introduced by this patch, but does this early error
handling path pass uninitialized stack memory to cleanup_network()?

If xdp_redirect_multi_kern__open_and_load() or
xdp_redirect_map__open_and_load() fail before create_network() is called,
the goto labels eventually reach cleanup_network(&net_config).

Since cleanup_network() passes net_config fields like ns0_name to SYS_NOFAIL
which executes system commands, could passing uninitialized stack garbage
here lead to unpredictable shell command execution as root?

Would it be safer to zero-initialize net_config with `=3D {}` when declarin=
g it?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611043317.5128=
43-1-sun.jian.kdev@gmail.com?part=3D2
