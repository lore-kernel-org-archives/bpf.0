Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C636404B
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124528; cv=none; b=dkZ1YegFgGtzmI9m7EXNVDKoRPaulXhlsLQxOGpQzBpIWJDbOw7W/VLgkLaQw1YwvqS01hj7SRbNSOavzCCj3IUWUFjGqfh/OC920yvm6Y31xcyaaFYzJUyXyEM6LXUU/K/eeGFPCC0Z2DPuzW0hry6KqzHe4svYko7M8rEv7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124528; c=relaxed/simple;
	bh=F/cO2EycPM+leD9ttJV4LuXn/OX3K5Xw8BpCJnCq6Cg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bjCaMsinRGzIeda7woxgN9ETkzx2Y7YViDF7PmHLzMQMnpxhk09bKnlRJ7ZExyBmRcxIvKYrFhLVVDBI4BRNuWNHo8GebUHN6sZTPiFUWGfQtJD9lPy0A9uLx/Do7ivhtRjn505wSjdlXlVQVnFvLn7/G5F+M5hKVgrHKYuopU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKwR70LU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKwR70LU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A2C1F000E9;
	Wed, 15 Jul 2026 14:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784124526;
	bh=tW4ZfXTkbcbWkWS+77OB1NLB6wyCJijsCCiGTUCMfDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kKwR70LUVWXKmH7KpPhsPt4I4bDIGHq7H5nGbq5DsPZDOypFVKhpWM5x5GGYdpSHc
	 vJcTCeaO+L27+TAbfsLsKQaMiqD+OPgeFZCK4GGWBLqPV27lSl0U4OSGOtvyIICj4p
	 9LSD5lEtQs7N+xQtLOMfUIRhasBDjBY+/ZpZKKo1p0yakX8Gg7uXmW0GNI18Dho0ob
	 HCvZkm5tvch8RFUeyosTbESoQKLR+Num9sCq2+Mf1KhG2dZlAcQJz+Zkip0n3VVLAk
	 cB2Ydi2xSS7TIH0erv/IfuiJXUKJ4Qe/d2KIqFhZrmMpSKdL5yA18CvqMvg1GMaL0K
	 P3lzNBofF5VLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 net 5/6] selftests/xsk: fix too-many-frags
 multi-buffer Tx test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714140722.111645-6-maciej.fijalkowski@intel.com>
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
 <20260714140722.111645-6-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:08:46 +0000
Message-Id: <20260715140846.70A2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] A newly added multi-line comment uses the deprecated kernel style w=
here text is placed on the same line as the opening `/*`.
--

--- Patch [5]: [PATCH v3 net 5/6] selftests/xsk: fix too-many-frags multi-b=
uffer Tx test ---
commit 41dfcc558e2b05136aed2feb3d3534323946fd99
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

selftests/xsk: fix too-many-frags multi-buffer Tx test

This commit updates the too-many-frags test to keep oversized Tx descriptors
valid so they can be accounted and reclaimed, while marking the correspondi=
ng
Rx packet invalid. It also adds a synchronization packet to verify the Tx
path recovers at the next packet boundary.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index 6eb9096d084c0..de17dd48f1764 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
[ ... ]
> @@ -2288,24 +2288,30 @@ int testapp_too_many_frags(struct test_spec *test)
[ ... ]
>  	if (pkt_stream_generate_custom(test, pkts, 2 * max_frags + 3)) {
>  		free(pkts);
>  		return TEST_FAILURE;
>  	}
> =20
> +	/* The generated Tx stream must keep the too-big packet valid so that
> +	 * __send_pkts() accounts its descriptors in outstanding_tx. The Rx
> +	 * stream, however, must not expect this packet on the wire.
> +	 */

[Severity: Low]
This isn't a bug, but could this multi-line comment be formatted to match
the preferred BPF subsystem style?

The BPF guidelines specify that multi-line comments should have the opening
/* on its own line, rather than having the comment text start on the same
line.

> +	test->ifobj_rx->xsk->pkt_stream->pkts[2].valid =3D false;
> +	test->ifobj_rx->xsk->pkt_stream->nb_valid_entries--;
> =20
>  	ret =3D testapp_validate_traffic(test);
>  	free(pkts);
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714140722.1116=
45-1-maciej.fijalkowski@intel.com?part=3D5
