Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524622;
	b=eWp5YL9tQXl0L2bzh6LTzxnK2ZYTLuSarJ2AsugurWNFWbIYH0Xwsc+a1RrStfMAtx1o
	 BDZK4wxe4lWx1qk4c4psWs5bWJbCVGcmT2Yk4WWqj3t1EhQ7GrZgnW4jugt9l4YVKZuVq
	 xQRf/suONGMVM/T5lMFB727vVvYhXiMmtKslzR4XO77XqgS4JIV+SQThi+THLMr4TpR+D
	 EFHBNn4Eigu/y6A6u6s6/nzVYyqs6Yg4anEc5CrJE782nM+IzJbzuqPdwqxWtZqkGjPYH
	 nbZ2FJZEKKvrb6eTnLgvOApBfcvWgC+Pq6f52OyYdwJua9+PuSxe8lR1tch5Y3vc2dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524622;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Hf/l5ua54ge2xZMIY0qC/k1BcvyVhAzucteCtS0To0M=;
	b=Bg4WcLiNjiLiwe7JJY2m23Cxo/L/vHDjz4eXKwznLHCOtok2h/FInRhwoTN8aWHBeNur
	 3qenCxl0DaJjK1FmPcNmNeYsL2PPg/noeFS3xtPAK8m2eQDVX+F7KQWaizoHnDVe1Hekp
	 75o+IgxomTnaLROgKUmQRcMU+BeWn+VdHvhP6V1DB2uf2WHjEoV4IpOEMeqBTWOGNpqOP
	 YMG34Y4D66wGwUrgp8QUBhKfzM78Z46fAo3wZ01XUN9rmXtLF2dR0p39ZA6JtEcAS0bhj
	 6OJsFbvjBmdx8+xgd82AHQGEUtXZzzJqlH5F+ez/q3rQozFYmeaMCwcJIt8xDBPwGSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8EPpWZP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8BD606A31B;
	Tue, 20 Oct 2026 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8EPpWZP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9B51F000CD;
	Tue, 20 Oct 2026 19:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792524621;
	bh=Hf/l5ua54ge2xZMIY0qC/k1BcvyVhAzucteCtS0To0M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A8EPpWZPt5KAIusZMx4XVQxklbyKzz9cUFGpkzzCSY7FxMX1Sl87Gzp43D8ebUiIt
	 VOPRF/rFITGAozo34Emscwq4JkcvXF1bmCBGVNrvsB2sDMINDWgi3sfCuJoFd64SPE
	 qPXU1gCWuFT2gbzr04Nm7lsS7WulsaldLqwYea4nDg18Ahhs1wg36NwQvhBgnhg8+e
	 B7Ie2OnzY1F+hnKZjGTZCOAmmra9o0/gnwqmtAZNWFo7XnfI8+plj8mUPfuuIb7OCv
	 6suoJUuaq9p5ijFg8AS8DLDPsSGqBLU2dOtbYDGqBLkoZWn+rzPetpuPxeIUMmpHN3
	 80prWsHV6aeiA==
Subject: Re: [PATCH v4 net-next 02/15] selftests: xsk: size the TX UMEM in
 HW_SW_MAX_RING_SIZE
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Tue, 20 Oct 2026 19:30:20 +0000
Message-ID: <179252462046.3135.1027737053245035744@kernel.org>
In-Reply-To: <20261016174338.787135-3-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-3-maciej.fijalkowski@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch fixes a hang that exists in the tree today, but it has
  no Fixes: tag.

--

selftests: xsk: size the TX UMEM in HW_SW_MAX_RING_SIZE

This commit gives the TX UMEM in testapp_hw_sw_max_ring_size() the same
size as the RX UMEM (8k frames and 8k rings). That way the test still
works with two interfaces once the single-interface mode is removed. It
also caps the second batch below the 8k XSK TX ring, so that
__send_pkts() cannot spin forever on NICs with large HW TX rings.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index 2a13628740924..05457f77ca52c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c

[ ... ]

> @@ -2521,10 +2525,12 @@ int testapp_hw_sw_max_ring_size(struct test_spec *test)
>  		return ret;
>  
>  	/* Set batch_size to 8152 for testing, as the ice HW ignores the 3 lowest bits when
> -	 * updating the Rx HW tail register.
> +	 * updating the Rx HW tail register. __send_pkts() waits until a whole batch fits
> +	 * in the XSK TX ring, so keep it below that ring's size on NICs with larger rings.
>  	 */
> -	test->ifobj_tx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
> -	test->ifobj_rx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
> +	batch_size = min(test->ifobj_tx->ring.tx_max_pending, max_descs) - 8;
> +	test->ifobj_tx->xsk->batch_size = batch_size;
> +	test->ifobj_rx->xsk->batch_size = batch_size;

[Severity: Low]
Should this patch carry a Fixes: tag?

The commit message describes the change as preparation for removing the
single-interface mode. The min() cap, though, fixes a hang that can
already happen in the current tree.

In the single-interface (shared UMEM) mode, thread_common_ops_tx()
copies the RX UMEM. xsk_configure_socket() then creates the XSK TX ring
with tx_size = umem->comp_size = 8192.

Before this patch the second batch was tx_max_pending - 8. On a NIC that
reports tx_max_pending above 8200, the reserve in __send_pkts() can
never succeed:

tools/testing/selftests/bpf/prog_tests/test_xsk.c:__send_pkts() {
    ...
	while (xsk_ring_prod__reserve(&xsk->tx, xsk->batch_size, &idx) < xsk->batch_size) {
    ...
}

When use_poll is false this loop has no timeout, so the test spins
forever.

This looks reachable on real hardware. nfp supports AF_XDP zero-copy and
reports tx_max_pending as max_qc_size / tx_min_desc_per_pkt, with
max_qc_size being SZ_64K or SZ_256K.

The two-interface case is also broken before this patch. With a
1024-frame TX UMEM and a 2048 batch, the in-flight limit in
__send_pkts() goes negative and TX never sends.

Would a Fixes: tag pointing at the commit that added HW_SW_MAX_RING_SIZE
help stable maintainers and backporters pick this up?

>  	if (pkt_stream_replace(test, max_descs, MIN_PKT_SIZE)) {
>  		clean_sockets(test, test->ifobj_tx);
>  		clean_sockets(test, test->ifobj_rx);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016174338.787135-1-maciej.fijalkowski%40intel.com
