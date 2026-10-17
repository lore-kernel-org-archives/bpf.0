Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7DF3C0601
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792259077; cv=none; b=KQW6TtZ/RTrFYmvA3zD7Z0SdOc2mY9iyoow136tLsdTtLx6K3hL/esWJgirmzD7SjcpOIpXjh0Aaej+FOhyWyQWPItjhTcdV2fT0SLDMjVfNJ4pvxJJe7pK+I9eRGhYmQWGu3P4H6AIi4jwrsenAPaHKJGsZxbxhR5qhulcl57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792259077; c=relaxed/simple;
	bh=s8VHHCB9SzqHlLMWP3m8JyB+zGj0pDwXi/fVTTzTxSY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TY42IHXM1TItMli/+zI8bhiW4UgevA35A8QDs1N6LZoyrFKQMh/jdIMkKR9PskUPSpMMPKssdYLPBjYF+SovmKnDxKirffge8IhUc9rtW5h6aNQhcSzFj9nliS/fDPKFrZNe0W89lZ7z4NbAbrQKhvHALmynLKumW8VLE30ur7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQfbBpej; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQfbBpej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5677F1F000C5;
	Sat, 17 Oct 2026 17:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792259076;
	bh=zsOJ9AbvUwHvWxQE+QTmDAfVT81x0CopZVVZrzCuy68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nQfbBpejr+iOAch/0d7fzpn6CwW7qS1ittoBNw9QcW/JBEDyF5G2rcIWAdM3U9w6K
	 PUI7ARER/85g/EIiEvelRGO72svKUf6riLMmbJRO2fVaK0MIHwujWEoJ2QMzALxhZ5
	 GNoAE7UxNi3VDpzc9MPQvTV5QnLGb2BvoUJBTnoHKtZAqPrR2HhM70ZJi8O/y+9ud9
	 xha/V/hz3909PyHHLU6soHFnsr7WcVJVhI8vcxY3/wfG9TGdI3DXQ5Xhj5uO+2i61m
	 RuVJ4NrpOTktCUpuaCSkkjph4Jdrutyplbm7uM3McfHdLU7XXilV8rdp9K2yeWzX61
	 sw/P3DTpyRxpA==
Message-ID: <sashiko-outbox-175717@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 net-next 03/15] selftests: xsk: drop the
 single-interface loopback mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261016174338.787135-4-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
 <20261016174338.787135-4-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 17:44:35 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: Multi-line comments do not start with /* on its own line
--

commit f56c850eb3f84acec00c6d23c81d2796961df979
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

selftests: xsk: drop the single-interface loopback mode

This commit drops the single-interface loopback mode from xsk selftests,
removes the shared-UMEM TX setup and resizing code, and sets up hardware-ba=
sed
traffic testing using ntuple and RSS configuration instead.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index 05457f77ca52c..b9126fe66e1a7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
[ ... ]
> @@ -2481,14 +2379,19 @@ int testapp_xdp_metadata_mb(struct test_spec *tes=
t)
>  	return testapp_xdp_metadata_copy(test);
>  }
> =20
> +/* Expects the HW TX ring of the sender to hold DEFAULT_BATCH_SIZE
> + * descriptors.
> + */

[Severity: Low]
This isn't a bug, but does the comment for testapp_hw_sw_min_ring_size
in tools/testing/selftests/bpf/prog_tests/test_xsk.c violate the BPF
subsystem multi-line comment style? The BPF guidelines specify that
multi-line comments should start with an empty /* line instead of putting
text on the opening line.

>  int testapp_hw_sw_min_ring_size(struct test_spec *test)
>  {
>  	int ret;
[ ... ]
> @@ -2501,16 +2404,21 @@ int testapp_hw_sw_min_ring_size(struct test_spec =
*test)
>  	return testapp_validate_traffic(test);
>  }
> =20
> +/* Expects the HW TX ring of the sender and the HW RX ring of the receiv=
er
> + * at their maximum sizes.
> + */

[Severity: Low]
This isn't a bug, but does the comment for testapp_hw_sw_max_ring_size
in tools/testing/selftests/bpf/prog_tests/test_xsk.c violate the BPF
subsystem multi-line comment style? Similar to the previous finding, BPF
multi-line comments should start with the opening /* on its own line.

>  int testapp_hw_sw_max_ring_size(struct test_spec *test)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016174338.7871=
35-1-maciej.fijalkowski@intel.com?part=3D3
