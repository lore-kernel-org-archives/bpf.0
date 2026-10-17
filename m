Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C5D3C73F6;
	Sat, 17 Oct 2026 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206374; cv=none; b=pGrN+Flclu6nTQu5xjYv7xzUXG4ysNZICnOx2xqzjjRl5HDU8yUhaeupR2h0mgo43s6Itf1pJRluy0Gt63NtQQ6OoO1zeksoSbfV9zoQxUV9YjW5iBnnZ9Q3jOXiqo4epVrrZx7KXuGQjRY85432CW8EUtY5unokMRKcOcFA5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206374; c=relaxed/simple;
	bh=uGiayxNoVjmuwXEqQO1wg+K9xwlJ54USBfVYQY5IzLI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LO3yWlnvSwEkN709zDIiunMXdGHHT2G619NHRlQ+2MJzfUg4Gq0aaT/n+vLhrN3YMVr+eeU7euLeUIYR7t3eyutZtXiwTkcGteyPgZdUNKoA+VAk5E9hVlgJeh16SLMqTSQoIxjUX/bckSZqYEsMSs8ZAjXZGr/w/duvLTFKFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcpwiTuW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcpwiTuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2751C1F000C6;
	Sat, 17 Oct 2026 03:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206372;
	bh=A+ip/afhmqYgVYHe7sUMBSapGxtTo4NvDSiDyitmhi0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BcpwiTuWrTW+BafrqYK20ALaPiEURzynlDxh60kuue1KNcn6aibXI5BvaXmreVxgc
	 qfdfoBKwXmFaJ4Qk5u2GdF1VnLUe/m44fr4ypt4MGdLDXcr+8cu067UoVSBF25OrxY
	 wh6oTwuFcWcGeZ7wwfcm4yaVKcZBoHFDT/SA4ZAge+YNjx+yW/8Bcis6XKWAWzi61c
	 zh/wiiHCXkcQMKBVqQ4Acf9D5UXF/xPuxMQXk3UtAyr3mgMOkKRRS7PRyAyFGP5FDH
	 p2zhv03/qVGsJYRmW1OwQexNEbJ2BnHY3+R3+r627gtCCuM+pXxlrT14fOGz7AqdYB
	 NFXjkuZ6K9lmw==
Subject: Re: [PATCH v3 net-next 14/15] selftests: drv-net: test AF_XDP
 zero-copy with an SKB peer
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Sat, 17 Oct 2026 03:06:11 +0000
Message-ID: <179220637173.434549.12610717858136223745@kernel.org>
In-Reply-To: <20261014184539.774708-15-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-15-maciej.fijalkowski@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 6 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tools/testing/selftests/drivers/net/hw/xsk.py, main()
  changes state on both hosts and has no try/finally to undo it.
- [Medium] In xsk.py, _run() starts the DUT zero-copy endpoint with
  `local = cmd(local_args, background=True, fail=False)` at line 142 and…
- [Medium] main() in xsk.py calls `xsk_reserve_hugepages(saved_hugepages,
  cfg.remote)` (line 227), and xsk_reserve_hugepages()…
- [Medium] If an endpoint is killed, the NIC's TX/RX descriptor ring
  sizes are never restored.
- [Medium] Taking the zero-copy queue out of RSS (_reserve_queue(),
  xsk.py line 74) is the only thing keeping non-test traffic off it.
- [Medium] _reserve_queue() in xsk.py assumes every reported channel can
  be addressed by RSS.
- [Low] The commit message says 'A host without ntuple support skips' and
  'A DUT with fewer than two such queues skips'.
- [Low] In xsk.py, _steer_udp() runs `ethtool -K <if> ntuple-filters on`
  (line 86) when the feature is inactive and not fixed.

--

selftests: drv-net: test AF_XDP zero-copy with an SKB peer

This adds drivers/net/hw/xsk.py. It runs the xskxceiver cases as pairs of
processes: a zero-copy endpoint on the DUT and an SKB-mode endpoint on the
remote. main() sets up the shared state once (an RSS-excluded queue, ntuple
rules on both hosts, huge pages) and undoes it after ksft_run().

> diff --git a/tools/testing/selftests/drivers/net/hw/xsk.py b/tools/testing/selftests/drivers/net/hw/xsk.py
> new file mode 100755
> index 000000000000..fd708bb3420d
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/xsk.py
> @@ -0,0 +1,263 @@

[ ... ]

> +def _reserve_queue(cfg):
> +    """Take the last queue with both an RX and a TX ring out of RSS. A TX
> +    endpoint fills no RX buffers, so in zero-copy mode its queue drops what
> +    it receives, the control connection included."""
> +    ch = cfg.ethnl.channels_get({"header": {"dev-index": cfg.ifindex}})
> +    count = ch.get("combined-count", 0) + min(ch.get("rx-count", 0),
> +                                              ch.get("tx-count", 0))

[Severity: Medium]
Does this assume that the RSS indirection table can address every reported
channel?

On pre-X550 ixgbe (82599/X540) with ATR enabled, which is the default,
ixgbe_get_channels() reports the Flow Director queue count:

drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:ixgbe_get_channels() {
    ...
	/* report flow director queues as maximum channels */
	ch->combined_count = adapter->ring_feature[RING_F_FDIR].indices;
    ...
}

That count can be as high as 64. The RSS table on those parts can only
address 16 queues:

ixgbe_rss_indir_tbl_max() {
	if (adapter->hw.mac.type < ixgbe_mac_X550)
		return 16;
    ...
}

ixgbe_set_rxfh() rejects entries beyond that limit:

	for (i = 0; i < reta_entries; i++)
		if (rxfh->indir[i] >= max_queues)
			return -EINVAL;

On a host with more than 17 CPUs, would "ethtool -X <netif> equal 63" fail
and raise CmdExitFailure during setup? That would abort the suite on a NIC
that advertises AF_XDP zero-copy. In this configuration the chosen queue is
already outside RSS, so the table doesn't need to change.

> +    if count < 2:
> +        return None
> +    queue = count - 1
> +    ethtool(f"-X {cfg.ifname} equal {queue}")

[Severity: Medium]
On NICs that steer flows based on TX, is taking the queue out of RSS
enough to keep the TCP control connection off it?

Flow Director ATR is on by default on i40e. i40e_atr() samples TCP TX
packets, including the SYN. It then programs an FD filter that steers the
flow's RX to the queue of the TX ring:

drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_atr() {
    ...
	flex_ptype = FIELD_PREP(I40E_TXD_FLTR_QW0_QINDEX_MASK,
				tx_ring->queue_index);
    ...
}

FD filters take priority over RSS. Suppose XPS picks the last TX queue for
the CPU that the DUT xskxceiver runs on. The remote's replies on the
control connection would then land on the zero-copy queue.

In TX cases that queue has no fill buffers. Wouldn't the control
connection stall, so the case fails or times out depending on CPU
placement?

Only a udp4 ntuple rule is installed. Unlike a TCP4 sideband rule, it
doesn't disable ATR automatically, and the flow-director-atr private flag
is not cleared.

Some drivers gate aRFS on NETIF_F_NTUPLE, which _steer_udp() may turn on.
When RFS is configured, aRFS could steer flows the same way.

> +    return queue
> +
> +
> +def _steer_udp(cfg, ifname, port, queue, host=None):
> +    """Steer the test flow to queue, return False if ifname cannot."""
> +    ntuple = ethtool(f"-k {ifname}", json=True, host=host)[0]["ntuple-filters"]
> +    if not ntuple["active"]:
> +        if ntuple["fixed"]:
> +            print(f"1..0 # SKIP {ifname} does not support ntuple-filters")
> +            return False
> +
> +        ethtool(f"-K {ifname} ntuple-filters on", host=host)
> +
> +    out = ethtool(f"-N {ifname} flow-type udp4 dst-port {port} action {queue}",
> +                  host=host).stdout
> +    rule = re.search(r"ID (\d+)", out).group(1)

[Severity: Low]
The commit message says:

    A host without ntuple support skips.

and:

    A DUT with fewer than two such queues skips

Here a skip happens only when ntuple-filters is fixed off. There are two
other failure cases:

- The feature can be toggled but the NIC rejects the udp4 dst-port rule.
  ethtool -N then raises CmdExitFailure.
- The output has no "ID N". The re.search(...).group(1) then raises
  AttributeError.

Would either of these bypass the skip branch in main()? The run would then
error out instead of skipping, and the _unsteer_udp() and "ethtool -X
default" calls in that branch would never run. If only the remote rule
fails, the DUT rule that was already added would also be left behind.

Similarly, _reserve_queue() runs "ethtool -X equal" with fail=True. A DUT
that rejects the RSS table update, such as the pre-X550 ixgbe case above,
would crash during setup instead of skipping.

> +    cfg.rules.append((host, ifname, rule, ntuple["active"]))

[Severity: Low]
When ntuple-filters was inactive, "ethtool -K ... ntuple-filters on" turns
it on before the rule is added. The toggle is recorded only here, after
both ethtool -N and the ID parse succeed.

If either of those raises, the toggle is never recorded. _unsteer_udp()
turns the feature off only for entries in cfg.rules.

Could ntuple-filters be left enabled on that host after a failed run?
Recording the undo right after the toggle would avoid that.

> +    return True

[ ... ]

> +def _setup(cfg, busy_poll):

[ ... ]

> +    fallbacks = [
> +        defer(ip, f"link set dev {cfg.ifname} mtu {cfg.dev['mtu']}"),
> +        defer(ip, f"link set dev {cfg.remote_ifname} "
> +                  f"mtu {cfg.remote_dev['mtu']}", host=cfg.remote),
> +        defer(ip, f"link set dev {cfg.ifname} xdpdrv off"),
> +        defer(ip, f"link set dev {cfg.remote_ifname} xdpgeneric off",
> +              host=cfg.remote),
> +    ]

[Severity: Medium]
What restores the NIC ring sizes when an endpoint is killed?

xskxceiver changes ring sizes with set_hw_ring_size(). The only restore
happens in cleanup_iface(), on normal exit:

tools/testing/selftests/net/lib/xsk/xskxceiver.c:cleanup_iface() {
    ...
	if (ifobj_has_cap(ifobj, XSK_CAP_HW_RING))
		hw_ring_size_reset(ifobj);
    ...
}

xskxceiver has no signal handling, so this restore is skipped in two
cases:

- xsk_wait_endpoint_exit() sends SIGKILL to the DUT endpoint after
  CASE_TIMEOUT.
- timeout(1) sends SIGTERM to the remote endpoint.

These fallbacks cover only the MTU and the XDP detach.

The next endpoint's capability probe in test_xsk.c then adopts the
leftover size as its default:

	if (!get_hw_ring_size(ifobj->ifname, &ifobj->ring)) {
		ifobj_set_cap(ifobj, XSK_CAP_HW_RING);
		...
		ifobj->set_ring.default_tx = ifobj->ring.tx_pending;
		ifobj->set_ring.default_rx = ifobj->ring.rx_pending;

Would a hung ring size case then leave the NIC with a min or max
descriptor ring size for the rest of the run, and after it?

> +    return fallbacks

[ ... ]

> +def _run(cfg, local_args, remote_args, ctrl_port):

[ ... ]

> +    try:
> +        head, listening = xsk_wait_listen(remote, ctrl_port, LISTEN_TIMEOUT)
> +        if listening:
> +            local = cmd(local_args, background=True, fail=False)
> +            dut_ret = xsk_wait_endpoint_exit(local, "dut", CASE_TIMEOUT)
> +    finally:
> +        # Even if the DUT endpoint did not run, so that the remote one is
> +        # gone before the next case starts.
> +        remote_ret = xsk_wait_endpoint_exit(remote, "remote", REMOTE_TIMEOUT,
> +                                            head)

[Severity: Medium]
Can the DUT endpoint be orphaned here? The finally reaps only the remote
endpoint, and xsk_wait_endpoint_exit() kills the process only on a
timeout:

tools/testing/selftests/net/lib/py/xsk.py:xsk_wait_endpoint_exit() {
    try:
        endpoint.process(terminate=False, fail=False, timeout=timeout)
    except subprocess.TimeoutExpired:
        endpoint.proc.kill()
    ...
}

When the kselftest runner times out, it sends SIGTERM to the Python
process only. _ksft_intr then raises KsftTerminate inside the wait on
local, and the exception propagates while local.proc is still running.

ksft_run() catches the exception and runs ksft_flush_defer(). That
detaches the XDP program and restores the MTU while the AF_XDP socket is
still bound. main() then deletes the ntuple rules and resets RSS.

xskxceiver would keep running after Python exits. It would later run its
own cleanup_iface() against state that the runner has already changed.

Should local also be killed in the finally?

> +    return dut_ret, remote_ret

[ ... ]

> +def main():
> +    # ksft_run() exits on -l and -h before main() can undo the setup.
> +    if "-l" in sys.argv or "-h" in sys.argv:
> +        sys.exit(f"{sys.argv[0]}: -l and -h are not supported")

[ ... ]

> +        saved_hugepages = []
> +        cfg.hugepages = (xsk_reserve_hugepages(saved_hugepages) and
> +                         xsk_reserve_hugepages(saved_hugepages, cfg.remote))

[Severity: Medium]
What happens when the remote kernel is built without CONFIG_HUGETLBFS?
xsk_reserve_hugepages() starts with:

    have = int(cmd("sysctl -n vm.nr_hugepages", host=host).stdout)

vm.nr_hugepages exists only with CONFIG_HUGETLBFS (mm/hugetlb_sysctl.c).
Without it the sysctl fails, and cmd() raises CmdExitFailure instead of
the helper returning False.

The commit message says the UNALIGNED cases are "left out without them".
Wouldn't the whole suite abort before ksft_run() instead, leaving the RSS
change and ntuple rules in place?

The drivers/net/hw config covers the DUT, but nothing constrains the
remote kernel.

> +
> +        cases = _get_cases(cfg)

[ ... ]

> +        ksft_run([ksft_variants(cases)(test_xsk),
> +                  ksft_variants(cases)(test_xsk_busy_poll)], args=(cfg,))
> +
> +        xsk_release_hugepages(saved_hugepages)
> +        _unsteer_udp(cfg)
> +        ethtool(f"-X {cfg.ifname} default")

[Severity: Medium]
If main() leaves early, does anything undo the RSS change, the ntuple
rules and the huge page reservation? These three calls run only when
ksft_run() returns normally, and the setup has no try/finally around it.
NetDrvEpEnv.__exit__ doesn't know about cfg.rules or saved_hugepages, and
defer() only works inside a case.

Any exception after _reserve_queue() skips all three calls. Some examples:

- a CmdExitFailure from ethtool -N on either host
- the AttributeError from the rule ID parse
- a failing remote sysctl
- a failing "xskxceiver -L" in _get_cases()

The "-l"/"-h" guard at the top of main() matches only those exact tokens.
ksft_run() parses arguments with:

    opts, _ = getopt.getopt(sys.argv[1:], 'hlt:T:')

This accepts clustered options like "-lt NAME" or "-hl". It also calls
sys.exit(1) on a GetoptError, such as an unknown option, --help, or -t
with no value. All of these exit from inside ksft_run(), after the setup
has already run.

The commit message gives the reason for the guard as:

    so xsk.py rejects -l and -h, on which ksft_run() exits without
    returning

sys.exit() raises SystemExit. Would a try/finally around the setup and
ksft_run() cover these paths and the -l/-h case as well?

There are two smaller points about the teardown itself:

- "ethtool -X default" installs the driver's default indirection table,
  not the one that was in place before the run. A custom table set by
  the admin is lost.
- If xsk_release_hugepages() fails, for example over ssh, the rule
  deletes and the RSS reset after it are skipped.

> +    ksft_exit()

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014184539.774708-1-maciej.fijalkowski%40intel.com
