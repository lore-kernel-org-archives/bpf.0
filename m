Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524632;
	b=c2R7VAw37ceo218K0OEuUaHOqnV0jpbG/81C+x3rFVmp3YeS6DIeActpUmQnMIPqJLzj
	 FwDL15bMPIc0FMEYrlLMR+11aScmqqyTZ/4oarusQFlEuMCvCG9FS1a1PZrrrdEwPovri
	 pI0vlWUtvYf8SqO3soc5Mv8GuNdDY9/UO8tMyh62JZaoyjVsFkQmploB5oAxEwgUPLnCJ
	 Jmz9xFODsl8n97fGOROLbx/h1GiDWV2lT1K5rZYpQnKICND4ZeUgL4tW2bu8Z2kjYdu4T
	 xX2X/GpdAhpcWkaSuWO5iTEM2TylmQUvx/Ggv60FVXDr0LIDAEzX49w5wSmXuJViLxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524632;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R0B/vC+8Yth+jfM3hC2VKAKXYKuQRAvN04jQowf6g94=;
	b=TVxPF6YafBv5eGw9eJjJw4DBJ2s+17Rzn2Xrcg5VXmQUqyE+RgqGZqAifcoIvvs35Sbk
	 rRf7azSo8+4CtjjXS+w8Y013MUMcL4Ir9uHUAubZDWLwBob1iZ0XUNHb4t6NjpDY6Ox3p
	 ddmfd1KVF7xYJ+jFRLtNpcXIuaZJxz27Fyat2/A+kwy3JPEDA74co+18x6pgCHDTQpmhm
	 p7cxrR7fHArYV3LamaXtPbz00kbaQp2NC9culq383zc3//EJzumaNex8NVkxaJCfGNZPK
	 K5avzVcVWZuUxllKLc+stvJ4fdNJeSj7zf57xZTCNGGHGW+EDimDUFM+S+jn1XWyoPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ba1F0jWe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947AD606A33A;
	Tue, 20 Oct 2026 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ba1F0jWe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78D61F000CA;
	Tue, 20 Oct 2026 19:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792524632;
	bh=R0B/vC+8Yth+jfM3hC2VKAKXYKuQRAvN04jQowf6g94=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ba1F0jWe5k81Q1arFmnz6hYEIpAvaF0KxGTJEKuAB3dqz4art6nt54HYWAlFUMHpw
	 C87dmkxSPNrCYDOERxA2COua1UU1Cly/jC8p19hCUg47FriPStvP80XgGa600KOoMt
	 yVU3GbLqInKTvuCd4CQ0ms0CqfZ9J22m8rVf4oFul1kN0YuMB5+q0b4xFkP1Cjtfcg
	 sWTFtjmstAS7ykVcaAjMCZLZBUGNFORTcuShotsTSLypuhdHJsYDswFyE/MIYvL5+d
	 +fmza5GLbSOuX4AOZ18TWCp5hcIDUlh7HUd+wBgLMJJE318xIJTBuyGz+l6S7f9Gqx
	 i2vdLPT2KkD0Q==
Subject: Re: [PATCH v4 net-next 14/15] selftests: drv-net: test AF_XDP
 zero-copy with an SKB peer
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Tue, 20 Oct 2026 19:30:31 +0000
Message-ID: <179252463139.3135.17340338517897417556@kernel.org>
In-Reply-To: <20261016174338.787135-15-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-15-maciej.fijalkowski@intel.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On ixgbe, the queue that main() takes out of RSS goes back
  into RSS before or during every case.
- [Low] Two ring-size cases check the wrong host's capabilities.
- [Low] The runner drops its XDP-detach fallback on the strength of an
  exit code that does not cover detach failures.

--

selftests: drv-net: test AF_XDP zero-copy with an SKB peer

This adds drivers/net/hw/xsk.py. It runs the xskxceiver cases as pairs of
endpoints: zero-copy on the DUT and SKB mode on the remote host. Once per
run, main() takes the last DUT queue out of RSS, adds ntuple rules on both
hosts and reserves huge pages. Each case sizes the rings for the HW_SW ring
size cases and registers XDP and MTU fallbacks, which are cancelled when
both endpoints pass or skip.

> diff --git a/tools/testing/selftests/drivers/net/hw/xsk.py b/tools/testing/selftests/drivers/net/hw/xsk.py
> new file mode 100755
> index 0000000000000..dbcd687fea3d8
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/xsk.py
> @@ -0,0 +1,368 @@

[ ... ]

> +# The TX ring of the sender and the RX ring of the receiver that a case
> +# needs at a given size, 64 being the default batch size of xskxceiver.
> +RING_SIZES = {
> +    "HW_SW_MIN_RING_SIZE": {"tx": 64},
> +    "HW_SW_MAX_RING_SIZE": {"tx": "max", "rx": "max"},
> +}

[Severity: Low]
Do these ring requirements match what the C side checks? In test_xsk.c,
testapp_hw_sw_min_ring_size() and testapp_hw_sw_max_ring_size() both skip
unless the tx ifobj has XSK_CAP_HW_RING:

tools/testing/selftests/net/lib/xsk/test_xsk.c:testapp_hw_sw_min_ring_size() {
    ...
	if (!ifobj_has_cap(test->ifobj_tx, XSK_CAP_HW_RING)) {
		ksft_print_msg("HW ring sizes not supported.\n");
    ...
}

On the receiving endpoint, ifobj_tx is the peer shadow. setup_peer() in
xskxceiver.c fills it with the local caps:

	shadow->caps = local->caps;

So the receiver ends up checking whether its own NIC can report ring
sizes.

In tx_HW_SW_MIN_RING_SIZE the remote is the SKB-mode receiver. If the
remote NIC has no get_ringparam, the remote endpoint skips and tells the
DUT to skip too. The case is then reported as skipped, even though xsk.py
never needs the remote ring and has already resized the DUT TX ring.

testapp_hw_sw_max_ring_size() has a similar issue:

	batch_size = min(xsk_get_cap(test, tx_max_pending), max_descs) - 8;

xsk_get_cap() reads test->ifobj_tx->caps, so each host takes
tx_max_pending from its own NIC. If the two NICs have different TX
maximums, can the two endpoints end up using different batch sizes?

[ ... ]

> +def _reserve_queue(cfg, undo):
> +    """Take the last queue with both an RX and a TX ring out of RSS until
> +    undo, return None if the DUT cannot. A TX endpoint fills no RX buffers,
> +    so in zero-copy mode its queue drops what it receives, the control
> +    connection included."""

[ ... ]

> +    queue = count - 1
> +    if cmd(f"ethtool -X {cfg.ifname} equal {queue}", fail=False).ret:
> +        print(f"1..0 # SKIP {cfg.ifname} cannot take queue {queue} out of RSS")
> +        return None
> +    undo.callback(_restore_rss, cfg, rss.get("indir"))
> +    return queue

[Severity: Medium]
Does the indirection table set here stay in place for the rest of the run
on every zero-copy driver? ixgbe advertises xsk-zerocopy, but
ixgbe_setup_reta() rebuilds the table on every configure. It never checks
netif_is_rxfh_configured():

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_setup_reta() {
    ...
	/* Fill out redirection table */
	memset(adapter->rss_indir_tbl, 0, sizeof(adapter->rss_indir_tbl));
    ...
}

The first rebuild happens right after _reserve_queue(), when _steer_udp()
turns ntuple-filters on:

_steer_udp() "ethtool -K <if> ntuple-filters on"
  ixgbe_set_features()     (need_reset)
    ixgbe_do_reset()
      ixgbe_up()
        ixgbe_configure()
          ixgbe_configure_rx()
            ixgbe_setup_mrqc()
              ixgbe_setup_reta()

It also happens inside every case. xskxceiver's driver-mode XDP attach and
detach go through ixgbe_xdp_setup(), which closes and reopens the device:

	err = ixgbe_setup_tc(dev, adapter->hw_tcs);

MTU and ring changes reinit the device as well.

ixgbe_fdir_filter_restore() puts the ntuple rule back, but it does not
restore the RETA, so the reserved queue gets RSS traffic again. In TX
cases the zero-copy socket on that queue fills no RX buffers. Anything
hashed to that queue is dropped, including the TCP control connection on
the random ctrl_port.

Would this show up as intermittent timeouts on ixgbe DUTs rather than as
a skip? The runner never reads the table back with rss_get to detect it.

[ ... ]

> +def _test(cfg, direction, test_id, name, busy_poll):

[ ... ]

> +    dut_ret, remote_ret = _run(cfg, local, remote, ctrl_port)
> +    if dut_ret is None:
> +        raise KsftFailEx(f"remote endpoint did not listen on port {ctrl_port}")
> +    rets = {dut_ret, remote_ret}
> +    if rets <= {0, SKIP_CODE}:
> +        # Both endpoints detached their XDP programs and restored the MTU.
> +        for fallback in fallbacks:
> +            fallback.cancel()

[Severity: Low]
Does a 0 or skip exit code actually show that the XDP programs were
detached? cleanup_iface() in xskxceiver.c does not check the result of
the detach:

	if (ifobj->xdp_prog)
		xsk_detach_xdp_program(ifobj->ifindex,
				       mode_to_xdp_flags(ifobj->mode));

xsk_detach_xdp_program() in xsk.c also throws away the return value of
bpf_xdp_detach():

void xsk_detach_xdp_program(int ifindex, u32 xdp_flags)
{
	bpf_xdp_detach(ifindex, xdp_flags, NULL);
}

Only an MTU restore error changes the endpoint's exit code.

Suppose bpf_xdp_detach() fails, for example because the driver's ndo_bpf
rejects the reconfiguration. The endpoint still exits 0, and this loop
also cancels the "xdpdrv off" and "xdpgeneric off" fallbacks. After the
last case, the program and its XSKMAP would stay attached to the
interface.

Running "xdpdrv off" when no program is attached does nothing. Could the
XDP fallbacks be kept, and only the MTU fallbacks be cancelled?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016174338.787135-1-maciej.fijalkowski%40intel.com
