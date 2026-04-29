Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE1324B33
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777452462; cv=none; b=kf84Ct6ptWtRTPazM8700B6t9CYWa2d8UxKgBztZZCzDGRAO1SYQfEhrAPJx/ftl2W/Itbro9INz7uevq9UyrgR4hytAXs7rlTpbNm9yFj5GyMrYK1O9mi4lsve6BueLUh+d5qqDmF7KPejaqk1zGnfoo5ZPVxcDdg9IE5LzDZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777452462; c=relaxed/simple;
	bh=7yOeVS0DZWwtjZ+F463d27ycMV/Uu3X1q46MKJw7fnA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VPjW73jgnsukVqIcdgB4qTT8SjcuHelfJJKh/Mfxdck7oG69yziqcjfBPX1PNyUFTLHjaTDJYkB1kAipNU13RBKPG+UTTgW10aYFRek/XkDANwRl+N4TSCYaAFZg5Th1MySplj4G8UQcLeU0ri8RMnky8Io+QXGrgH6B7sAm64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gb7hCtjl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gb7hCtjl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C263C19425;
	Wed, 29 Apr 2026 08:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777452462;
	bh=7yOeVS0DZWwtjZ+F463d27ycMV/Uu3X1q46MKJw7fnA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gb7hCtjlshp85AnlhLwzsfRZBLzjU4LJSxdJuFcBg7DKJgffqsf5cJwalPw2y/Q+o
	 0Bw8VXMUMsbii0YolZrVdG+xPEl5l4EgP2bQTItZDwDQMe7ohYNVrlcQLVtAQzMcNt
	 3GBUTUttIY0qdGmMkCSRXsCua7kuRA4XP29nv0uok8/0fYTNLOe0OEM9eoF2ylOPxh
	 zIsvEPE2rfU9HYoNdU2XH9umhz6L9WrxU2siScm4KxDP8fO9+HqGXyYJckyg7fx/md
	 dz5YKQo6shL2QICffxI9rK/mS/irx72pKyhIMJtZs45H2pRI2W1kNfLXGw1xxKNDt8
	 a06YFLkRDU2Xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] selftests/xsk: Eliminate umem reference from
 ifobject
Reply-To: sashiko@lists.linux.dev
To: "Tushar Vyavahare" <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428080317.702124-3-tushar.vyavahare@intel.com>
References: <20260428080317.702124-3-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 08:47:41 +0000
Message-Id: <20260429084742.5C263C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The poll timeout validation in `__receive_pkts()` checks the loc=
al RX UMEM instead of the peer TX UMEM, breaking tests that expect an inten=
tional timeout.
- [Medium] In shared UMEM mode, the TX and RX interfaces share the exact sa=
me `xsk_umem_info` object, causing the TX thread to inherit the RX's `base_=
addr` and corrupt the RX thread's memory partition.
--

commit 71e22f338d62604f1b7ed413a8905cfd021770d6
Author: Tushar Vyavahare <tushar.vyavahare@intel.com>

selftests/xsk: Eliminate umem reference from ifobject

This commit moves UMEM storage into the xsk_socket_info structure and uses
that pointer instead of the ifobject-level UMEM reference. This change is
intended to support multiple distinct UMEM instances on the same interface.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index d5cd8f590b25..ad5ada9216fc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c

[ ... ]

> @@ -1007,7 +1010,7 @@ static int __receive_pkts(struct test_spec *test, s=
truct xsk_socket_info *xsk)
>  			return TEST_FAILURE;
> =20
>  		if (!ret) {
> -			if (!is_umem_valid(test->ifobj_tx))
> +			if (!is_umem_valid(umem))
>  				return TEST_PASS;
> =20
>  			ksft_print_msg("ERROR: [%s] Poll timed out\n", __func__);

Will this cause tests that expect an intentional timeout to loop infinitely
or falsely fail?

Previously, this code handled a poll() timeout by checking the peer TX
thread's validity (!is_umem_valid(test->ifobj_tx)). If the TX thread was
inactive or had torn down its UMEM, this correctly evaluated to true.

By checking the local RX socket's UMEM (umem), which is actively polling
and always valid, the check will always fail. This causes the test to
incorrectly print an error and return TEST_CONTINUE instead of passing
gracefully.

[ ... ]

> @@ -1504,14 +1507,20 @@ static int xsk_configure(struct test_spec *test, =
struct ifobject *ifobject,
> =20
>  static int thread_common_ops_tx(struct test_spec *test, struct ifobject =
*ifobject)
>  {
> -	int ret =3D xsk_configure(test, ifobject, test->ifobj_rx->umem, true);
> +	struct xsk_umem_info *umem_rx;
> +	int ret;
> =20
> +	if (!test->ifobj_rx || !test->ifobj_rx->xsk_arr[0].umem ||
> +	    !test->ifobj_rx->xsk_arr[0].umem->umem) {
> +		ksft_print_msg("Error: RX UMEM is not initialized before shared-UMEM T=
X setup\n");
> +		return -EINVAL;
> +	}
> +
> +	umem_rx =3D test->ifobj_rx->xsk_arr[0].umem;
> +	ret =3D xsk_configure(test, ifobject, umem_rx, true);
>  	if (ret)
>  		return ret;
> -	ifobject->xsk =3D &ifobject->xsk_arr[0];
>  	ifobject->xskmap =3D test->ifobj_rx->xskmap;
> -	memcpy(ifobject->umem, test->ifobj_rx->umem, sizeof(struct xsk_umem_inf=
o));
> -	ifobject->umem->base_addr =3D 0;
> =20
>  	return 0;
>  }

Can the removal of the deep copy and base_addr reset cause the TX thread to
inherit the RX's base_addr and corrupt the RX thread's memory partition?

In shared UMEM mode, the TX thread previously made a copy of the UMEM object
and explicitly set its base_addr =3D 0 to allocate from the first half of t=
he
doubled UMEM.

By directly assigning the RX's UMEM object to the TX socket without
adjusting the base address, the TX thread allocates frames using the exact
same base_addr and next_buffer state as the RX thread. This causes a data
race on next_buffer and makes the TX thread allocate packets into the RX
thread's designated memory partition.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428080317.7021=
24-1-tushar.vyavahare@intel.com?part=3D2
