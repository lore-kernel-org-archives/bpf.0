Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524630;
	b=myUjWJ5rhQ6zxJq0zcRc5wvdVRmskZtbTs3EGlCAYSwBTiAEfJrFDlNAssP3FM4ibY+T
	 IS6bTW+4p10EEdRQVQ9BBOoSxtfyJjzYC1r3JqrhgAiP2zEMMtGPVTj4eEbkx/fua7UdU
	 TSSk6G3G0qHBIVuA4YjHrBU/O+agxdV0JytzqVpCWkxHtErIVpl6A1urV/MwH571UC/sR
	 reIr5ksyZDncyD9CVhUqevP6mlXTmOk9z8/oOgxB2OY9z3Nyu5AEHNS+Nz1ovgPHQge1N
	 tjR6O10/qVM8Kq1MyX9lSW/C5WB3ZD8T/OrHqaN68IZSujDN/tmp6TXb3ncoOLyjBQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524630;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3/6lfOiLcuVyA3cX0EYsczIjRwzeAaCSLhLn+i8CtDI=;
	b=2ipiKY3YaPHCMYe59wNNytIiRDOCw0oYHXocKYWOgrrv2w3LipyCH1JmXPWKO1XZ8oJc
	 /HoEr8ecSt0kqoUz+aL9Jsv68R47btHuSIjgdztsV+iXDlsDPpMWpDw97cOmbrVBP8Hh4
	 sYl8ztpXjEUaFSxucjbXQFMzg2ZytqSHk3rsygu3HoSSnm4krUU8NcRaS4dVR3OtIe2WX
	 EepIXu7ZRJr8GLTQmBHFhboWkSAgTebI4wY3HnWpB0PRRYdRKk00ag5KsrFCI+Aeuc3gZ
	 PuoADchUtDa+jxVW1VzdFbW7CvrRBSdX1236v3GFypJXasmSicGFsbaUEyqvKVqxlYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QdfHw1Lk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674CC606A32D;
	Tue, 20 Oct 2026 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QdfHw1Lk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7961F000D1;
	Tue, 20 Oct 2026 19:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792524630;
	bh=3/6lfOiLcuVyA3cX0EYsczIjRwzeAaCSLhLn+i8CtDI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QdfHw1LkD5+b+rGvqANXS2NVfo2wC9RlgwMb803Le9givN6mxXU/EUuJKXwiTYTn1
	 9UMg5yBtcTHf8bFr8Y0CA4bFOGvTizUIRC310n0OlibZlFvrKJ0cDOLM3a5wYTaHfw
	 Yku2I+RWIkp3ceBRLNOwWZu3cy3FjIFpS64I2b9OZy8Z1XEvkgBpTe4Hh0tYVWQfS4
	 B9sdv7b3FgRv9eZj1/poIng9lZEUvyHb3/G2zejVkdbiQ41oIME/aoRoM/SDq0Wjr4
	 0WFkqIRZVJ1Q5eqMsH982nI/R0N/zErNdDHwTtk9pj7fJ7AQDgiyT9lUfryiGGe2Kn
	 I+HDUHdytOLcQ==
Subject: Re: [PATCH v4 net-next 12/15] selftests: xsk: prepare xskxceiver for
 endpoints on two hosts
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Tue, 20 Oct 2026 19:30:29 +0000
Message-ID: <179252462905.3135.16990828336786085778@kernel.org>
In-Reply-To: <20261016174338.787135-13-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-13-maciej.fijalkowski@intel.com>
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

- [Low] parse_command_line() does not fully validate the new numeric
  options.
- [Low] In the adjust-tail cases, RX can decide to skip only after the
  traffic has run: testapp_validate_rx_endpoint() clears…

--

selftests: xsk: prepare xskxceiver for endpoints on two hosts

This prepares xskxceiver to run a case with its two endpoints on two
hosts. It adds --queue, --max-frags and --timeout options, a SKIP message
on the control channel, and a wait for the link to come up once the
endpoints are in sync. It also changes the default case MTU to
ETH_DATA_LEN and restores the original MTU in cleanup_iface().

> diff --git a/tools/testing/selftests/net/lib/xsk/xsk_peer.c b/tools/testing/selftests/net/lib/xsk/xsk_peer.c
> index e3e353d6abd95..256e63196f923 100644
> --- a/tools/testing/selftests/net/lib/xsk/xsk_peer.c
> +++ b/tools/testing/selftests/net/lib/xsk/xsk_peer.c

[ ... ]

> @@ -162,6 +179,30 @@ void xsk_peer_abort(struct xsk_peer *peer)
>  		peer_send(peer, XSK_PEER_ABORT, 0);
>  }
>  
> +/*
> + * Tell the peer that this endpoint skips the case, so that it skips too.
> + * Closing with unread data, or getting data once closed, resets the
> + * connection and drops the SKIP if the peer has yet to acknowledge it, as
> + * when a NIC reset holds the link down. So read until the peer closes.
> + */
> +void xsk_peer_skip(struct xsk_peer *peer, int timeout_ms)

[Severity: Low]
Is "so that it skips too" accurate for the adjust-tail cases?

In those cases the RX endpoint decides to skip only after the traffic has
run. testapp_validate_rx_endpoint() clears the support flag:

    if (!is_adjust_tail_supported(ifobject->xdp_progs)) {
        test->adjust_tail_support = false;
        return TEST_PASS;
    }

and then testapp_adjust_tail() returns TEST_SKIP:

    if (!test->adjust_tail_support) {
        ...
        return TEST_SKIP;
    }

By that point the TX endpoint has usually finished with TEST_PASS. It
never sees the SKIP, so it does not skip.

The final verdict still comes out right, because xsk.py later in the
series reports a pass plus a skip as a skipped case. Could the comment
say that the peer either skips or passes?

[ ... ]

> diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> index 9704702f60fc9..56ea5ac6a3c63 100644
> --- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> +++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c

[ ... ]

> @@ -328,6 +302,18 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
>  		case OPT_UDP_PORT:
>  			opt_udp_port = strtoul(optarg, NULL, 10);
>  			break;
> +		case OPT_QUEUE:
> +			opt_queue = strtoul(optarg, NULL, 10);
> +			break;
> +		case OPT_MAX_FRAGS:
> +			/* It sizes the packet array of TOO_MANY_FRAGS. */
> +			opt_max_frags = strtoul(optarg, NULL, 10);
> +			if (opt_max_frags > 0xffff)
> +				print_usage(argv);
> +			break;
> +		case OPT_TIMEOUT:
> +			opt_timeout = strtoul(optarg, NULL, 10);
> +			break;

[Severity: Low]
Should --timeout and --max-frags get a full range check here?

strtoul() returns an unsigned long, and the result is truncated to u32
before the > 0xffff check. A --max-frags value of 2^32 or more can
therefore pass the check.

--timeout accepts any u32, including 0. Later the value is multiplied by
1000 in u32 and passed on as an int:

    wait_link_up()
        err = xsk_wait_link_up(ifobj->ifname, thread_tmout * 1000);

    main()
        xsk_peer_skip(peer, opt_timeout * 1000);

A timeout of 2147484 seconds or more, or a negative string (which
strtoul() wraps), gives a negative timeout_ms. With a negative
timeout_ms, the poll() in xsk_peer_skip() blocks with no limit.

In this series, xsk.py checks --max-frags and --timeout against 1-0xffff
before passing them on. So this only happens when xskxceiver is run by
hand.

Could xskxceiver reject these out-of-range values itself, as it already
does for the --max-frags upper bound?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016174338.787135-1-maciej.fijalkowski%40intel.com
