Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3853423909F
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778934689; cv=none; b=TlC6YI5CVr8/rebX14CZqGEMvGplyVGYkang1oZJNxrmL4c0Vq175b3j93OX5XLO5s/NJlCeKJjRnB5IdPsg32DryvoVrnPEfY5Z2WrFpK3PckiGR6K5HIn8No0+9qr/axeSruWe7iJgslbHdswmCwqIsnM0SrmFfuGmFG6t4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778934689; c=relaxed/simple;
	bh=jGqOAY46AGREW/kNtz8FV7EUlxCdYQ33BVfBLC4lEvc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nmocmtq1uq8sBF2sYCOjhH+7a+fpahpTvgdgGTvFWx69iK4ZY6dvwgDuxh27MGX75J5NZk99uwgFH5RclwjiVfu+VZOv4IPKAOl8a4x2pGL/SrppawK/fCcUT9ChWTasnP0NxPDqs7dm0T4D2HtQjE/+/HSdlg0hLry5vVlDSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VajkZwrW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VajkZwrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA67BC19425;
	Sat, 16 May 2026 12:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778934688;
	bh=jGqOAY46AGREW/kNtz8FV7EUlxCdYQ33BVfBLC4lEvc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VajkZwrWeXwtyvCnvjiLDCTUGepAxB182ty7bJHyBMtrNXIQ5dNmIcAA0aY/WIJvy
	 syXFU/mMR9hsGgLmXc8i2Ly3XF6//QHdTuImg8vEHDPFdMTJTLpAa0ZC7cTYyPgvyd
	 7aUQbTN56Gz6Tq9NdB/7YSUVb2chl9r1Iyq7Hjn3+76Is1GwghmkSFPzKeDMa+IIE1
	 vwQFgknjFAuf9YlFUG0M6ogG6CA+PvPjwi83i3OMNBjjiz8sefoGvdbGDg3u9oXfc/
	 D3blayLSa9tQtFilsZbqeEkqsEFyvDRZQ9UudjCJF3r5ym7mnW8TuMgseU7Xpk1NhP
	 ObwRCPyB+uMBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 5/5] selftests/xsk: fix multi-buffer invalid desc
 tests for drain_cont
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515123018.80147-6-kerneljasonxing@gmail.com>
References: <20260515123018.80147-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 12:31:28 +0000
Message-Id: <20260516123128.BA67BC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Premature exit in the newly added `wait_for_tx_completion` drain l=
oop causes the test to silently strand valid packets.
- [High] Clamping `outstanding_tx` to 0 in `complete_pkts` degrades test st=
rictness by silently discarding unexpected completions.
- [High] Unhandled `EOVERFLOW` error in `kick_tx()` causes spurious test fa=
ilures when the kernel synchronously processes invalid packets.
--

commit 51fe3cee29ff3a261580a926424f8e6171690b0d
Author: Jason Xing <kerneljasonxing@gmail.com>

selftests/xsk: fix multi-buffer invalid desc tests for drain_cont

This commit updates the selftests to account for the kernel returning CQ
entries for dropped and drained multi-buffer descriptors. It clamps the
outstanding TX count, adds a drain loop to consume extra CQ entries, and
modifies test descriptors to stop drains at packet boundaries.

>     - wait_for_tx_completion: add a drain loop that consumes CQ entries
>       after outstanding_tx reaches zero. Ensure remaining valid packets
>       are transmitted. This change is made because of patch 3 in the
>       series adds a logic in __xsk_generic_xmit(): return -EOVERFLOW
>       after detecting and handling the remaining part of the skb.

Since the kernel now returns -EOVERFLOW after handling invalid packets,
will kick_tx() abort the test when it encounters this new error code?

kick_tx() is called by complete_pkts(), which checks its return value:

test_xsk.c:complete_pkts() {
    if (xsk_ring_prod__needs_wakeup(&xsk->tx)) {
        ret =3D kick_tx(xsk);
        if (ret)
            return TEST_FAILURE;
    }
    ...
}

If kick_tx() does not tolerate -EOVERFLOW, this might cause spurious test
failures when the kernel synchronously processes invalid packets.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index 7950c504ed289..488ace93ff663 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c

[ ... ]

> @@ -950,17 +950,11 @@ static int complete_pkts(struct xsk_socket_info *xs=
k, int batch_size)
> =20
>  	rcvd =3D xsk_ring_cons__peek(&xsk->umem->cq, batch_size, &idx);
>  	if (rcvd) {
> -		if (rcvd > xsk->outstanding_tx) {
> -			u64 addr =3D *xsk_ring_cons__comp_addr(&xsk->umem->cq, idx + rcvd - 1=
);
> -
> -			ksft_print_msg("[%s] Too many packets completed\n", __func__);
> -			ksft_print_msg("Last completion address: %llx\n",
> -				       (unsigned long long)addr);
> -			return TEST_FAILURE;
> -		}
> -
>  		xsk_ring_cons__release(&xsk->umem->cq, rcvd);
> -		xsk->outstanding_tx -=3D rcvd;
> +		if (rcvd > xsk->outstanding_tx)
> +			xsk->outstanding_tx =3D 0;
> +		else
> +			xsk->outstanding_tx -=3D rcvd;

Does clamping xsk->outstanding_tx to 0 mask underlying regressions by
silently discarding unexpected completions?

If the kernel correctly generates CQ entries for invalid descriptors now,
could outstanding_tx be incremented by the total number of submitted
descriptors instead of only the valid ones?

Tracking total descriptors would allow the test to use the existing
timeout-backed wait loop and eliminate the need for this clamping.

>  	}
> =20
>  	return TEST_PASS;

[ ... ]

> @@ -1293,6 +1289,14 @@ static int wait_for_tx_completion(struct xsk_socke=
t_info *xsk)
>  		complete_pkts(xsk, xsk->batch_size);
>  	}
> =20
> +	do {
> +		if (xsk_ring_prod__needs_wakeup(&xsk->tx))
> +			kick_tx(xsk);
> +		rcvd =3D xsk_ring_cons__peek(&xsk->umem->cq, xsk->batch_size, &idx);
> +		if (rcvd)
> +			xsk_ring_cons__release(&xsk->umem->cq, rcvd);
> +	} while (rcvd);

Can this loop exit prematurely and strand valid packets?

In asynchronous modes, kick_tx() wakes the NAPI thread and returns
immediately. Because packet processing happens asynchronously, the hardware
may not have populated the completion queue before the peek() occurs.

If the queue is not yet populated, xsk_ring_cons__peek() will return 0,
causing the loop to break instantly before the valid packets have actually
completed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515123018.8014=
7-1-kerneljasonxing@gmail.com?part=3D5
