Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F135C3BB9F1
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792259078; cv=none; b=kiPje09K32nBS4Nt8MVEaj30oOS6zGe4kEnPROWhxxhwH8w+Xv6Mym1LOmYF8BalIanVHYFCh1nR0Ry9BG9pqRfnqdtroB2ZHYFhTQS8roaTiNptLqPb+OV2GMaIqlF2j3z6U8VE5Eq0XEN1xQJaYD+F4cJBzCmEP4TtPRitDgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792259078; c=relaxed/simple;
	bh=yBejo2AGwzwN65j68IdzLswKF/Zp7jvGV2g98Grhsts=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=IiZ0KwFwtx2QUN4F6TykH1bLoNarPwiAsM3b1vesbgzV+0Jq2sUE5OYJ9LdO1O0jMbUFybR6TKrFiG+srbCL3JYNcgSndW2Eo7CEakDUImBGKeoGmXt5jGK043iW0Wmg8JRpjl+U5EcHTFCBwTv/sASKs++/vN2BcCaALp8Biqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/UU+fPn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/UU+fPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40651F000C6;
	Sat, 17 Oct 2026 17:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792259075;
	bh=n43TjyaCii5yVcS/+WuibJcd81TvtPIxeXg1pvaUeo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g/UU+fPnC0Lo6gEjZe6Tz0eTjZcVmlWQFgAI+6T6ej+WLZjUc9Dc6GR18Ev3YoM9m
	 p0Wol4anTK/r0u84VpZpfxkuY97Z1cQP9ekTuwyQ0Kyd771mWIlPtKenjlpAVzwguY
	 mPKyq6jIK+rCovzeGfvx0jyWPZ1hXuil6dNJBmJjaqGcNKjIcpHRq4MCjbAvlnRdk/
	 yOt74Kah+dNjDRXMGVTTUa6kaRyJRifme3TtZ5T9mA5bUFM1lGnaOEA3zpjq8uy4k3
	 ZhaTMz3+W0hWK/ZF74+wCh56NyBT06bYv2o5hfQZAi62NBWY+bLdZtueNfLdyykQYG
	 MiuHlS272EEnw==
Message-ID: <sashiko-outbox-175716@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 net-next 02/15] selftests: xsk: size the TX UMEM in
 HW_SW_MAX_RING_SIZE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261016174338.787135-3-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
 <20261016174338.787135-3-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 17:44:35 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: integer underflow calculating xsk batch_size
- [Low] bpf: multi-line comment does not follow kernel style
--

commit 743c541687fdf2d7592285088f7c482d5114a852
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

selftests: xsk: size the TX UMEM in HW_SW_MAX_RING_SIZE

This commit sizes the TX UMEM like the RX one to avoid failures in
dual-interface mode and caps the batch size below the XSK ring size to avoid
infinite loops.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index 2a13628740924..05457f77ca52c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
[ ... ]
> @@ -2521,10 +2525,12 @@ int testapp_hw_sw_max_ring_size(struct test_spec =
*test)
>  		return ret;
> =20
>  	/* Set batch_size to 8152 for testing, as the ice HW ignores the 3 lowe=
st bits when
> -	 * updating the Rx HW tail register.
> +	 * updating the Rx HW tail register. __send_pkts() waits until a whole =
batch fits
> +	 * in the XSK TX ring, so keep it below that ring's size on NICs with l=
arger rings.
>  	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF subsystem
style guidelines?

The guidelines request the opening /* to be on its own line.

> -	test->ifobj_tx->xsk->batch_size =3D test->ifobj_tx->ring.tx_max_pending=
 - 8;
> -	test->ifobj_rx->xsk->batch_size =3D test->ifobj_tx->ring.tx_max_pending=
 - 8;
> +	batch_size =3D min(test->ifobj_tx->ring.tx_max_pending, max_descs) - 8;

[Severity: Medium]
Can this subtraction underflow if tx_max_pending is less than 8?

If an interface supports ethtool get_ringparam but reports a tx_max_pending
smaller than 8 (such as netdevsim altered via debugfs or drivers that leave
it 0), the unsigned subtraction would underflow and produce a massive
batch_size.

Could this cause __send_pkts() to infinite loop or hang the test while tryi=
ng
to reserve descriptors that exceed the ring capacity?

> +	test->ifobj_tx->xsk->batch_size =3D batch_size;
> +	test->ifobj_rx->xsk->batch_size =3D batch_size;
>  	if (pkt_stream_replace(test, max_descs, MIN_PKT_SIZE)) {
>  		clean_sockets(test, test->ifobj_tx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016174338.7871=
35-1-maciej.fijalkowski@intel.com?part=3D2
