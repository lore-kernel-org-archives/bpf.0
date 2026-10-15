Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011D483811
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090004; cv=none; b=U0ZM5zfO5nfF1KPZTejpijCSEAjX2BimLaQo6v1+IJpV34KBNUoG/ssZGwqticoIgQHkzKzDvwLp1Q3c2Lt+dfKE3DXdOoWJcqUaYv4ZNWQBhfriTZaXFMyU8O4qwnaUIJ6jfk6EzFfKvKwg62DgDbmDi0UmrgC2vn3O7VArYWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090004; c=relaxed/simple;
	bh=MBOAz85IXj7EzneVE2ipmMNG8/lWzsIuQlAOh4e3jQQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=r7ewXGl+GkPbz+RzplgGVFSo3vcOHMmw8MdjPlYmF8EDJ5geM1CoPJwT0Dp3a0mn+cT/iCsgwGrg0pFVhnol2qNUKe6BnTE+B2bkGFaGL2J8Pizn+/7/IE4z59GnbkkdojHJTEl/l63hrWJSuEyCWw/+moml4r80nCkdL8Jfwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7DFP/kJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7DFP/kJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74ABC1F000C4;
	Thu, 15 Oct 2026 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792090002;
	bh=Hxl8Kj0iAcZTFyYpokQdxD2Jj456tuqzaITWaTlTOz4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h7DFP/kJH68NSIrZyKgRxL3sUNEUHRI/4aK48kduuQ8Shg5a7YTfQoa0W7iTi6Zur
	 UlSdSNISOnk/y8omfZ5ssFE7Ukna7/u+zwi85zIin9d4jBIYWsUZ1JmRrPoPh++d/g
	 2KhZdp78+gykDvuLGf21kfOeR2SDXZdfnzRLWpZy45bG12JYiVibCbGUwNfMWSoGH2
	 Kloqp1mfj+XC1hPq7ttnRjJfhVlDpCLSSimHQ5kBV3gqLnp7z6DWDmjbNjlrqBR+T9
	 lkxbrCM60ZVt+TlzUjhpnrAiP4n/DJaox++56NL7awubV35YRwwDFFUUMUUNGG/bWR
	 +E/a+WvrTjrPw==
Message-ID: <sashiko-outbox-173325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 net-next 02/15] selftests: xsk: size the TX UMEM in
 HW_SW_MAX_RING_SIZE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261014184539.774708-3-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-3-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:46:41 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: xsk: infinite loop if hardware TX ring > 8200
--

commit 183d9676e829720fbcf94af5e89e100b2685ba42
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

selftests: xsk: size the TX UMEM in HW_SW_MAX_RING_SIZE

This patch configures the TX UMEM sizes in the testapp_hw_sw_max_ring_size
selftest to match the RX UMEM sizing. It addresses an issue where TX
would fail in two-interface mode due to the default UMEM being too small
for the batch sizes used in this test.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index 2a13628740924..16fe32e5afc06 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -2513,6 +2513,9 @@ int testapp_hw_sw_max_ring_size(struct test_spec *t=
est)
>  	test->ifobj_rx->xsk->umem->num_frames =3D max_descs;
>  	test->ifobj_rx->xsk->umem->fill_size =3D max_descs;
>  	test->ifobj_rx->xsk->umem->comp_size =3D max_descs;
> +	test->ifobj_tx->xsk->umem->num_frames =3D max_descs;
> +	test->ifobj_tx->xsk->umem->fill_size =3D max_descs;
> +	test->ifobj_tx->xsk->umem->comp_size =3D max_descs;

[Severity: Medium]
Since max_descs is fixed to 8192 (XSK_RING_PROD__DEFAULT_NUM_DESCS * 4), can
this cause an infinite loop in __send_pkts() on hardware with large rings?

Further down in testapp_hw_sw_max_ring_size(), the batch size is explicitly=
 set
based on the raw hardware maximums:

    test->ifobj_tx->xsk->batch_size =3D test->ifobj_tx->ring.tx_max_pending=
 - 8;

If a NIC supports a maximum TX ring size greater than 8200 (such as some ml=
x5
or bnxt cards), the calculated batch_size will strictly exceed the software
ring capacity (max_descs =3D 8192) configured here.

When that happens, __send_pkts() will enter an infinite loop:

    while (xsk_ring_prod__reserve(&xsk->tx, xsk->batch_size, &idx) < xsk->b=
atch_size) {
        ...
        complete_pkts(xsk, xsk->batch_size);
    }

Because xsk_ring_prod__reserve() can never grant a reservation larger than =
the
total ring capacity, this loop will spin indefinitely waiting for space that
can never exist.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014184539.7747=
08-1-maciej.fijalkowski@intel.com?part=3D2
