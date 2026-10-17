Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2143B7757;
	Sat, 17 Oct 2026 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206372; cv=none; b=emSCkKywLAuY6YlRY3g4mgIxebAEx3OpzaLnAqmNTZzuSATBEwzBoabekHxMzaEHH1+5JmUD8PKPD3rBaL7Z1NhPQEU3Nd3WaqycBakKDIWK9c51Vlw4fhbsB/HnNUzDhEiEw4P/frcqIzRqXnGD4HZX0bSt5WTK6vOdmIjyhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206372; c=relaxed/simple;
	bh=CTQzq/tkK0XXS79LAUo/HkswB+c3kXs61hCo5IZtGnQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kp4Rkw1jHwsWiZEL+gp7PGPVNT27xO2drQyTAXuuKf/3dclqwTnLt0LJTZP0kN8bb3vzUtr0eI8ThlcINqZcLQwzJb2uAHrakqQdTUf1IK2UHaiTkainmoKB6UJV9a28Ic5H9FnlQDoIcmNZ4d5ddcxq8L+aYH0uzOFXF48ynLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPqfJcGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPqfJcGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A3F1F000C5;
	Sat, 17 Oct 2026 03:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206370;
	bh=eeCGLO3Ik5E4Qxb/7ymqiy+n1Z+grV3svHvOZnm+e64=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HPqfJcGXSwBAykQ/NkVesG+ujJFH1B0B8+GQI7IxbFjtkH7ii6tkpM+A0caD7sXS5
	 28CDsPosEQ29kaDAvluxPXhLMuKkcDJUx7v6Hu+BCMkJT1q8MEFx1NXe2uMcsb6pQN
	 C1IPR9jjROSxNV5OquIxUbrHd4enEeUB7KmMRbXgDBaFqtEcu+wHa9qRjGekN6KRS3
	 YZO8cycYcm8DggZ2gYMNckXP94IP6xVXpzpnpuQ0InPMj8ua5BSdyxax2mCRqGf3KO
	 jZ1CaRV0uP04Vua3/+WZw6jebcjossL44PWExrWg/rT/KyNZ59RFitlb4qZhj3IdaD
	 Wmtu9yu2e1eGg==
Subject: Re: [PATCH v3 net-next 11/15] selftests: xsk: add a hardware mode to
 xskxceiver
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Sat, 17 Oct 2026 03:06:09 +0000
Message-ID: <179220636945.434549.3726298644003511435@kernel.org>
In-Reply-To: <20261014184539.774708-12-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-12-maciej.fijalkowski@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] A hardware SKB-mode endpoint still gates every multi-buffer
  case on XSK_CAP_MBUF.
- [Medium] The comment in wait_link_up() says 'Each endpoint makes its
  changes before it is ready', but the TX endpoint creates its UMEM and…
- [Medium] cleanup_iface() in xskxceiver.c now fails the endpoint when
  xsk_set_mtu() cannot restore orig_mtu, but it still ignores the return…
- [Low] At this commit, hardware mode switches the test frames to
  UDP/IPv4, but the XDP programs (xsk_def_prog, xsk_xdp_drop,…
- [Low] testapp_too_many_frags() builds the stream from
  max_frags_override no matter which mode the local TX endpoint runs in.
- [Low] parse_command_line() rejects --listen and --max-frags without
  --hw, but it silently accepts --udp-src, --udp-dst, --udp-port and…
- [Low] In hardware mode, sync_endpoints() exchanges READY and then each
  endpoint calls wait_link_up() on its own interface only, once.

--

selftests: xsk: add a hardware mode to xskxceiver

This commit adds a --hw mode to xskxceiver. In this mode,
drivers/net/hw/xsk.py can run AF_XDP cases between a zero-copy DUT and an
SKB-mode remote over a physical link, using UDP/IPv4 frames between the
real MACs. It also adds --queue, --listen and --max-frags, waits for the
link after endpoint synchronization, defaults cases to ETH_DATA_LEN, and
restores the original MTU in cleanup_iface().

> diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
> index f67a32c0260a3..a280956d53f4a 100644
> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c

[ ... ]

> @@ -84,11 +97,72 @@ static void write_payload(void *dest, u32 pkt_nb, u32 start, u32 size)

[ ... ]

>  	memcpy(eth_hdr->h_dest, xsk->dst_mac, ETH_ALEN);
>  	memcpy(eth_hdr->h_source, xsk->src_mac, ETH_ALEN);
> -	eth_hdr->h_proto = htons(ETH_P_LOOPBACK);
> +	if (!udp_packets) {
> +		eth_hdr->h_proto = htons(ETH_P_LOOPBACK);
> +		return;
> +	}
> +
> +	eth_hdr->h_proto = htons(ETH_P_IP);

[Severity: Low]
At this commit hardware mode sends UDP/IPv4 test frames, but xsk_def_prog,
xsk_xdp_drop and xsk_xdp_populate_metadata in xsk_xdp_progs.bpf.c still act
on every frame received on the queue:

    return bpf_redirect_map(&xsk, 0, XDP_DROP);

On a physical link, could non-test traffic such as IPv6 ND/MLD or LLDP
reach the socket on the bound queue? Could it also shift drop_idx or the
metadata count?

This is resolved later in the series. The commit "selftests: xsk: pass
non-test traffic to the stack in hardware mode" adds is_test_packet(), and
xsk.py adds ntuple steering. drivers/net/hw/xsk.py does not exist yet at
this commit, so no runner can hit the gap here.

[ ... ]

> @@ -1703,14 +1829,36 @@ static int testapp_validate_rx_endpoint(struct test_spec *test,

[ ... ]

> +/* An MTU or XDP change can reset a NIC, which takes the link down on both
> + * hosts. Each endpoint makes its changes before it is ready, so once both are,
> + * wait for the local link before any traffic.
> + */

[Severity: Medium]
Does this hold for the TX endpoint? worker_testapp_validate_tx() runs the
barrier first, and only creates the UMEM and the XDP_ZEROCOPY socket after
it:

worker_testapp_validate_tx()
  sync_endpoints()
    xsk_peer_ready()
    wait_link_up()
  testapp_validate_tx_endpoint()
    thread_common_ops()
      xsk_configure()
        xsk_socket__create()
    send_pkts()

The RX side binds in testapp_prepare_rx_endpoint() before sync_endpoints(),
so only the TX bind happens after the barrier.

On some zero-copy drivers the pool setup restarts the interface. For
example, dpaa2_xsk_enable_pool() in dpaa2-xsk.c does:

	up = netif_running(dev);
	if (up)
		dev_close(dev);
	...
	if (up)
		dev_open(dev, NULL);

dpaa2 advertises NETDEV_XDP_ACT_XSK_ZEROCOPY. Can send_pkts() then
transmit while the carrier is still coming back? That would lose the
frames and leave RX to hit the 20s timeout in hardware TX-role cases. The
code is the same at the end of the series.

> +static int wait_link_up(struct test_spec *test)

[ ... ]

>  static int sync_endpoints(struct test_spec *test)
>  {
>  	int err = xsk_peer_ready(ctrl_peer);
>  
> -	if (err)
> +	if (err) {
>  		ksft_print_msg("Endpoint synchronization failed at step %u: %d (%s)\n",
>  			       test->current_step, err, strerror(-err));
> -	return err;
> +		return err;
> +	}
> +	return hw_test ? wait_link_up(test) : 0;

[Severity: Low]
Each endpoint checks only its own interface here, and nothing comes after
the link check. TX goes into send_pkts() as soon as its own ETHTOOL_GLINK
reads up, and pacing_tx_sync() does not block. xsk_wait_link_up() returns
on the first sample that reads up:

		if (err || edata.data)
			return err;

Suppose the RX host's driver applies an MTU, XDP or ring change through an
asynchronous reset, and the link drops only after READY was delivered.
Could TX then act on a stale up state and transmit into the reset?

At the end of the series the control connection runs over the tested link.
That covers drivers that reset synchronously, which is what ice, i40e,
mlx5, igb and ixgbe do. No mainline driver with an asynchronous reset was
identified, so this may only be theoretical.

[ ... ]

> @@ -2284,7 +2444,9 @@ int testapp_too_many_frags(struct test_spec *test)
>  	u32 max_frags, i;
>  	int ret = TEST_FAILURE;
>  
> -	if (test->mode == TEST_MODE_ZC) {
> +	if (max_frags_override) {
> +		max_frags = max_frags_override;
> +	} else if (test->mode == TEST_MODE_ZC) {

[Severity: Low]
The override replaces the limit no matter which mode the transmitting
endpoint runs in. If the SKB-mode remote were TX with the DUT's zero-copy
limit, wouldn't the copy-mode TX path send the "too many" packet anyway?

At the end of the series TOO_MANY_FRAGS is listed only in hw_tx_tests[].
xsk.py always runs it with the zero-copy DUT as TX, so the mismatch does
not appear reachable there. Would a short comment noting that assumption
next to the override help?

[ ... ]

> @@ -2378,6 +2540,7 @@ static int detect_ifobj_caps(struct ifobject *ifobj)
>  	if (query_opts.feature_flags & NETDEV_XDP_ACT_RX_SG)
>  		ifobj_set_cap(ifobj, XSK_CAP_MBUF);
>  	if (query_opts.feature_flags & NETDEV_XDP_ACT_XSK_ZEROCOPY) {
> +		ifobj_set_cap(ifobj, XSK_CAP_ZC_ADVERTISED);

[Severity: Medium]
A hardware SKB-mode endpoint still gates every multi-buffer case on
XSK_CAP_MBUF. That cap comes from the native driver NETDEV_XDP_ACT_RX_SG
flag, queried with XDP_FLAGS_DRV_MODE. In __testapp_validate_traffic():

	mbuf_cap = test->mode == TEST_MODE_ZC ? XSK_CAP_MBUF_ZC :
						XSK_CAP_MBUF;

	if (!ifobj_has_cap(ifobj1, mbuf_cap) ||
	    (ifobj2 && !ifobj_has_cap(ifobj2, mbuf_cap))) {
		...
		return TEST_SKIP;
	}

Generic XDP does not need native RX_SG for xdp.frags programs.
netif_receive_generic_xdp() handles non-linear skbs through
skb_cow_data_for_xdp().

Take a remote NIC that does not set NETDEV_XDP_ACT_RX_SG, such as igb, igc
or ixgbe. The remote then skips SEND_RECEIVE_9K_PACKETS, UNALIGNED_9K,
XDP_METADATA_COPY_MULTI_BUFF, the ADJUST_TAIL_*_MULTI_BUFF and
*_INV_DESC_MULTI_BUFF cases, and TOO_MANY_FRAGS. The zero-copy DUT checks
XSK_CAP_MBUF_ZC instead and continues.

Does the DUT then fail in sync_endpoints() once the remote closes the
control channel? At the end of the series xsk.py reports this one-sided
skip as SKIP, so multi-buffer coverage is lost whenever the remote is a
non-SG NIC.

The commit message says:

    - a hardware endpoint probes only the mode it runs in, taking zero-copy
      support from NETDEV_XDP_ACT_XSK_ZEROCOPY

Should XSK_CAP_MBUF follow the same rule for an SKB-mode endpoint?

[ ... ]

> diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> index 769718cad8cd7..7044822f23c0a 100644
> --- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> +++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c

[ ... ]

> @@ -306,6 +378,10 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
>  	    !*opt_peer_host || !opt_peer_port || opt_run_test == RUN_ALL_TESTS ||
>  	    opt_mode == TEST_MODE_ALL)
>  		print_usage(argv);
> +	if (opt_hw && (!opt_udp_src || !opt_udp_dst || !opt_udp_port || !opt_peer_mac))
> +		print_usage(argv);
> +	if ((opt_listen || opt_max_frags) && !opt_hw)
> +		print_usage(argv);
>  }

[Severity: Low]
This isn't a bug, but --udp-src, --udp-dst, --udp-port and --peer-mac are
accepted without --hw and then silently ignored. main() calls
xsk_set_udp_packet_format() only under opt_hw, and setup_peer() copies
opt_peer_mac only under opt_hw.

Should these options be rejected without --hw, like --listen and
--max-frags are? print_usage() also describes them as if they always apply.

[ ... ]

> @@ -401,8 +487,16 @@ static void cleanup_iface(struct ifobject *ifobj)
>  		xsk_detach_xdp_program(ifobj->ifindex,
>  				       ifobj->mode == TEST_MODE_SKB ?
>  				       XDP_FLAGS_SKB_MODE : XDP_FLAGS_DRV_MODE);
> +	/* After the detach, as an attached program can cap the MTU. */
> +	if (ifobj->dev_mtu != ifobj->orig_mtu) {
> +		err = xsk_set_mtu(ifobj->ifindex, ifobj->orig_mtu);
> +		if (err)
> +			ksft_print_msg("Failed to restore MTU %d on %s\n",
> +				       ifobj->orig_mtu, ifobj->ifname);
> +	}
>  unload:
>  	xsk_unload_xdp_programs(ifobj);
> +	return err;
>  }

[Severity: Medium]
A failed MTU restore now fails the endpoint. The ring restore just above
this hunk still ignores its return value:

	if (ifobj_has_cap(ifobj, XSK_CAP_HW_RING))
		hw_ring_size_reset(ifobj);

set_hw_ring_size() can fail with a non-EBUSY error, or after the EBUSY
retries run out. In that case hw_ring_size_reset() keeps the changed sizes
for a later reset. No later reset happens, because the process exits, and
the endpoint still reports PASS.

This patch makes that more likely. __test_spec_init() now resets rings on
any local ifobj, and testapp_hw_sw_max_ring_size() now sets the receiver's
rx_pending to rx_max_pending. The final xsk.py relies on the endpoints to
restore ring sizes.

Can a failed restore leave the NIC with enlarged rings? The next run's
detect_ifobj_caps() would then record those as set_ring.default_tx and
set_ring.default_rx. Should the result of hw_ring_size_reset() also feed
err here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014184539.774708-1-maciej.fijalkowski%40intel.com
