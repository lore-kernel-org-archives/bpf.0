Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A143C0606;
	Sat, 17 Oct 2026 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206372; cv=none; b=JW4c/Zqg4c7Tt6fJqDA13Szc9Lgb7egb/e/IcxSUg+MKsIJVCT5jbsWsShKTL7KxiVA2wyKThRbYSEOzLagRPTjaE3F+8bYufKWXQpAd3c7CJ0I+JBh9co9KXSSCAzZfneRkcWHY8wy7sShIuAbihgYKCxbjJ3CEPLgG/Su5FQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206372; c=relaxed/simple;
	bh=S+YzpH0+29EbYNufSbiYub4Qo7e+bez8KN/HNh83Zx4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GBgFq4280yK4UPPf8E0+VNCxIqhilGWubCCLlskBoKVduU8wjOKR7LF8Nb/jOLwjAUN9z8/6Y8V7cXM/5tdW0jiCQCmgbCrgVEwb/Lp1CjWkAThERnTJnH7EVrY0+UOkMW93sn1ZUmTNAubeJXKpszpQ5loGJULHbNE84ormgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDmtOVft; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDmtOVft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C211F000C4;
	Sat, 17 Oct 2026 03:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206371;
	bh=jEM5HYuSKh2YpDnBuUc1gpKMIww/0cE9Hw3ioFtu/jA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TDmtOVfthXwM4AJ8EEUpskU3IK1aTrnGONEk5D9Tqi48iBUDXU9FKgae1/aHEYZEg
	 wMBk7F2ojMw3BosJkXuqAYEhr+ZrbpMvm1JKmKl5Eh+u2LL5DbnxKEBAQg1Q9Yhfzn
	 68ATxv93O7FtI41H8tnpQYXvoRwrNo/zhC+lLbljyvr81MV5RlMNumCOTowbgsKqcA
	 RhtqksHAL+xbE9l6e+5e0B53tvPwVLOBXtyB0pi+OPqiM/faS5ys0yURFQBhbvUhhF
	 5c+X1jiGM38b9injDT0vE6wHMHNBvoyteNr/QTeJSRKgeQKovSrRP7ktMSn9Cwmizw
	 n7JOm6cVHch9w==
Subject: Re: [PATCH v3 net-next 12/15] selftests: xsk: pass non-test traffic
 to the stack in hardware mode
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Sat, 17 Oct 2026 03:06:10 +0000
Message-ID: <179220637066.434549.1580492265406805082@kernel.org>
In-Reply-To: <20261014184539.774708-13-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-13-maciej.fijalkowski@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In hardware mode, adjust_tail_grow_skip()
  (tools/testing/selftests/net/lib/xsk/test_xsk.c) can make the two…
- [Low] This feature patch also carries the only fix for a real userspace
  stack buffer overflow, without a Fixes: tag.

--

selftests: xsk: pass non-test traffic to the stack in hardware mode

In hardware mode, the xskxceiver XDP programs now redirect only the
UDP/IPv4 packets sent to the test port and pass everything else to the
stack. xsk_xdp_adjust_tail() now accounts for the IPv4 and UDP headers,
so the XDP_ADJUST_TAIL_GROW cases can run with --hw. is_adjust_tail_supported()
now reads adjust_value through the skeleton instead of copying all of
.bss into an int.

> diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
> index a280956d53f4..b70dbefe9729 100644
> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
> @@ -944,31 +944,12 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
>  	return true;
>  }
>  
> -static int is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx, bool *supported)
> +static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx)
>  {
> -	struct bpf_map *data_map;
> -	int adjust_value = 0;
> -	int key = 0;
> -	int ret;
> -
> -	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
> -	if (!data_map || !bpf_map__is_internal(data_map)) {
> -		ksft_print_msg("Error: could not find bss section of XDP program\n");
> -		return -EINVAL;
> -	}
> -
> -	ret = bpf_map_lookup_elem(bpf_map__fd(data_map), &key, &adjust_value);

[Severity: Low]
The replacement below looks correct. Should this part go out as its own
fix with a Fixes: tag, though?

The removed bpf_map_lookup_elem() copies the whole value_size of the
internal "xsk_xdp_.bss" map into the 4-byte stack int adjust_value.
Before hw_port was added, .bss already held idx, adjust_value, count and
drop_idx. So the copy writes at least 12 bytes and overwrites nearby
stack slots such as key, ret and data_map.

The commit message mentions the overrun. However, the fix is bundled
with the hardware-mode feature and depends on the move to selftests/net.
The same code is still in tools/testing/selftests/bpf/prog_tests/test_xsk.c,
which test_progs runs in trees without this series.

A standalone patch carrying:

Fixes: 4b302092553c ("selftests/xsk: Add tail adjustment tests and support check")

would let the fix be backported to net and stable.

> -	if (ret) {

[ ... ]

> +	return skel_rx->bss->adjust_value != -EOPNOTSUPP;
>  }

[ ... ]

> @@ -2774,10 +2754,20 @@ int testapp_adjust_tail_shrink_mb(struct test_spec *test)
>  	return testapp_adjust_tail(test, -XSK_UMEM__MAX_FRAME_SIZE, XSK_UMEM__LARGE_FRAME_SIZE * 2);
>  }
>  
> +/* Generic XDP leaves no room to grow the tail. Only the RX endpoint runs the
> + * program on the test flow, and a hardware TX endpoint, which does not know
> + * the mode of its peer, leaves that skip to the RX endpoint.
> + */
> +static bool adjust_tail_grow_skip(struct test_spec *test)
> +{
> +	if (hw_test && !ifobj_is_local(test->ifobj_rx))
> +		return false;

[Severity: Low]
Can the two hardware endpoints disagree on the skip here?

With --hw and a local RX endpoint in SKB mode, testapp_adjust_tail_grow()
and testapp_adjust_tail_grow_mb() return TEST_SKIP before
sync_endpoints() is reached. The RX side then closes the control
connection.

On the TX side, ifobj_rx is the non-local shadow. adjust_tail_grow_skip()
therefore always returns false, and TX continues:

testapp_adjust_tail()->worker_testapp_validate_tx()->sync_endpoints()
  ->xsk_peer_ready()

worker_testapp_validate_tx() {
    ...
	err = sync_endpoints(test);
	if (err)
		return err;
    ...
}

xsk_peer_ready() in xsk_peer.c {
    ...
	err = peer_send(peer, XSK_PEER_READY, 0);
	while (!err && !peer->ready_seen)
		err = peer_recv_one(peer);
    ...
}

There is no "peer skipped" message, so TX gets EPIPE or ECONNRESET.
The run ends with TX failing and RX skipping.

The old check (test->mode == TEST_MODE_SKB || hw_test) skipped on both
sides. That matches the existing convention in testapp_stats_rx_dropped():

	/* Hardware endpoints run different modes, so ZC would skip on one only. */
	if (hw_test)
		return TEST_SKIP;

Later in the series, "selftests: drv-net: test AF_XDP zero-copy with an
SKB peer" adds drivers/net/hw/xsk.py. Its _test() reports the case as a
skip when either side returns SKIP_CODE:

    if SKIP_CODE in (dut_ret, remote_ret):
        raise KsftSkipEx("xskxceiver skipped the case")

Also, "selftests: xsk: list the hardware test cases" puts the grow cases
only in hw_rx_tests, where the SKB remote is the TX side.

At this commit, no in-tree runner drives --hw. Is the one-sided failure
the intended result for manual xskxceiver --hw runs?

> +	return test->mode == TEST_MODE_SKB;
> +}
> +
>  int testapp_adjust_tail_grow(struct test_spec *test)
>  {
> -	/* The XDP program numbers the grown tail after a non-UDP header. */
> -	if (test->mode == TEST_MODE_SKB || hw_test)
> +	if (adjust_tail_grow_skip(test))
>  		return TEST_SKIP;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014184539.774708-1-maciej.fijalkowski%40intel.com
