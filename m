Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B2639DBE0;
	Mon, 12 Oct 2026 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795035; cv=none; b=oiWV2s+5g31VIN6pjfRhIMEq0yKTU/BBEA4xVzaHnwSHT0XcFPpXPdRG2M070le7jTuQi9oDyzfOlJLMM+LX7yxoaZeuSyP7LuyqNb/Gtm50DltMkimSf2xKfebzk6Ct8zzB4E/U97rUzl0ILsc3EBmIMTiPESm5dk65U1mpZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795035; c=relaxed/simple;
	bh=BAKMcckFlI7TxvtR4znSt2PgSIcVCRjNGS93+Y41rbc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mkjzUfH+LMjZS5y9978JjX97xti4VWA3Zu5BMKrj1mB/XXuDPFnhIHCEdOStXwOqxnimIAFkaXpMCqF9xPRcttBLHDQSx0wcatxEbcBvY6lGX0ce46eG3KRd9WRmAMQUgsshwrHl3GzkK4WWUg/E+PfavIVIAEC0Q1mC2wauzrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvVTUHIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvVTUHIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC671F0089C;
	Mon, 12 Oct 2026 08:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795030;
	bh=7RyVqRela9m9bHic5LAjSwURyhK8VUM0W3UvT6kj/wQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lvVTUHILnDXaEeOqQrjqTLIrcCnF/5hAiuQyn2fOuF0SSSXgP3Hm0JCNgtODQXmdK
	 HezVPoq+qphqZdNc0/x+5jcen66CwXoamGv6rXbDJj8kSpIGd11LzR4V0qJKiPUztO
	 8nAtndt1Gzd+HMna+LPJPz9yaD92OxpDymtwM/78E0/+CkFm+AXnVtlzcMA00MrBrZ
	 DBV6d2+w4+ZB0zGYRQt382MbylGG8lutXaEP0MuSTXHaUEHMcibvlzf7CEr3Fq8X75
	 x3BPcZY45sGcqVIEws9avFY/f4Wk/ev79w6hS62JsALihnZvF3i3w2hHbEcrfGVfqc
	 B5RwvIEYQSrNA==
Subject: Re: [PATCH v2 net-next 13/14] selftests: drv-net: test AF_XDP
 zero-copy with an SKB peer
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Mon, 12 Oct 2026 08:50:29 +0000
Message-ID: <179179502942.434549.17262682837433343981@kernel.org>
In-Reply-To: <20261008114909.734364-14-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-14-maciej.fijalkowski@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In DUT TX cases with an SSH remote, _setup_case() binds the
  DUT zero-copy XSK socket to queue 0 (`queue = _reserve_queue(cfg) if…
- [Medium] For SSH remotes, _control_addr() takes the control-channel
  address from the SSH destination…
- [Medium] _reserve_queue() undoes its RSS change with
  `defer(cfg.ethnl.rss_set, {"header": header, "indir": saved})`, which…
- [Medium] With the SSH backend, the finally block in _run_endpoints()
  (`if remote.ret is None: remote.process(terminate=True, fail=False)`)…
- [Low] The commit message is inaccurate about skip coverage and
  configuration knobs.
- [Low] Two timeout paths in _run_endpoints() skip _case_result(), so the
  endpoint output is never printed.
- [Low] Concern: _steer_udp() registers the deferred `ethtool -N <dev>
  delete <id>` only after it parses 'ID (\d+)' from stdout.
- [Low] _reserve_queue() always picks `combined-count + rx-count - 1`,
  i.e. the last RX queue, as the DUT queue.
- [Low] selftests: drv-net: xsk.py crashes due to missing
  test_xsk_case_defs.h dependency

--

selftests: drv-net: test AF_XDP zero-copy with an SKB peer

This commit adds drivers/net/hw/xsk.py. The script runs each hardware
AF_XDP case from test_xsk_case_defs.h as a pair of xskxceiver processes:
a zero-copy DUT endpoint and a remote SKB-mode endpoint, where the remote
is reached over SSH or lives in a netns. Each case sets up RSS and ntuple
steering, hugepages and busy-poll knobs as needed, and undoes them with
defer().

> A setup failure therefore skips only the cases
> that need that setup: a one-channel DUT still runs the TX cases and a
> remote without ntuple filters still runs the RX ones.

[Severity: Low]
Is the one-channel statement accurate for a netns remote? In that topology
the TX cases also call _reserve_queue() from _setup_case(), and that
function skips when there are fewer than two channels:

    if count < 2:
        raise KsftSkipEx("RX queue isolation needs at least two channels")

With REMOTE_TYPE=netns, a one-channel DUT therefore skips the TX cases too.

A later patch in the series ("selftests: xsk: document generic and
hardware endpoint runs") corrects this in the README for netns. The
message for this commit still says otherwise.

> XSK_REMOTE_BIN names a remote path to copy it to instead, or, with
> XSK_REMOTE_DEPLOY=0, an already installed binary.

These knobs read as if they work with any backend, but _remote_binary()
skips for anything other than SSH:

    if cfg.env.get("REMOTE_TYPE") != "ssh":
        raise KsftSkipEx("XSK_REMOTE_BIN requires the SSH remote backend")

Nothing is cached on that path, so every case hits the skip again. Could
the commit message say that XSK_REMOTE_BIN only works with SSH?

> diff --git a/tools/testing/selftests/drivers/net/hw/xsk.py b/tools/testing/selftests/drivers/net/hw/xsk.py
> new file mode 100755
> index 0000000000000..a33d4af869c7a
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/xsk.py
> @@ -0,0 +1,417 @@

[ ... ]

> +def _control_addr(cfg):
> +    """An SSH remote is reached over its management link. A netns remote is
> +    reached only over the tested link, where the XDP programs pass the
> +    control connection to the stack."""
> +    if _netns_remote(cfg):
> +        return cfg.remote_addr_v["4"]
> +    return cfg.remote.name.rpartition("@")[2]

[Severity: Medium]
Can this give the DUT xskxceiver an address it cannot connect to?

cfg.remote.name is the ssh destination from REMOTE_ARGS.
remote_ssh.Remote.cmd() passes it straight to ssh, so ssh_config is what
resolves it. The DUT endpoint gets the same string as -p, but
peer_open_tcp() in xsk_peer.c resolves it with getaddrinfo() and returns
-EINVAL on failure:

    err = getaddrinfo(host, port, &hints, &res);
    if (err)
        return -EINVAL;

This looks like it fails in several valid SSH setups:

- an ssh_config Host alias, which is common with the ControlMaster setup
  the series' README recommends, does not resolve
- an IPv6 literal or IPv6-only management host resolves to AF_INET6, but
  test_xsk() starts the remote listener with "-p", "0.0.0.0", so it only
  listens on IPv4
- an ssh:// URI still leaves "host:port" after the rpartition()

In each of these cases the DUT endpoint exits with an error, and every case
is reported as a failure, not a skip. cfg.require_ipver("4") only checks
the tested link, not the management address.

Should the control address come from something that is known to be a
resolvable IPv4 address? Alternatively, could a resolution failure be
reported as a skip?

[ ... ]

> +def _steer_udp(ifname, port, queue, host=None, sudo=False):

[ ... ]

> +    match = re.search(r"ID (\d+)", added.stdout)
> +    if not match:
> +        raise KsftFailEx(f"cannot identify new ntuple rule: {added.stdout}")
> +    defer(_root_cmd, f"ethtool -N {dev} delete {match[1]}", host=host,
> +          sudo=sudo)

[Severity: Low]
This isn't a bug, but the deferred delete is only registered after the ID
has been parsed. If ethtool ever added the rule without printing "Added
rule with ID N", the KsftFailEx here would leave the rule installed.

Current ethtool always prints the ID when no location is given. Other
drv-net tests (devmem_lib.py, iou-zcrx.py, nk_qlease.py) depend on the same
output, so this only matters for cleanup ordering.

> +def _reserve_queue(cfg):
> +    """Move the last RX queue out of default RSS and return it."""
> +    header = {"dev-index": cfg.ifindex}
> +    channels = cfg.ethnl.channels_get({"header": header})
> +    count = (channels.get("combined-count") or 0) + (channels.get("rx-count") or 0)
> +    if count < 2:
> +        raise KsftSkipEx("RX queue isolation needs at least two channels")
> +    queue = count - 1

[Severity: Low]
Can this pick a queue that has no matching TX queue? If a driver has
RX-only channels next to combined ones, count - 1 is an RX-only queue.

For example, ice_set_channels() accepts 2 combined + 2 RX-only channels,
which gives num_rxq = 4 and num_txq = 2. This code picks queue 3, and
ice_xsk_pool_setup() rejects that queue even for an RX-only socket:

    if (qid >= vsi->num_rxq || qid >= vsi->num_txq) {
        ...

The zero-copy bind then fails, so every RX case (and every netns TX case)
fails, even though combined queue 1 would have worked. Would it be safer
to pick the last combined queue when there are combined channels?

> +
> +    try:
> +        rss = cfg.ethnl.rss_get({"header": header})
> +        saved = list(rss["indir"])
> +    except Exception as exc:
> +        raise KsftSkipEx(f"cannot read RSS indirection table: {exc}") from exc
> +    if queue in saved:
> +        updated = [0 if entry == queue else entry for entry in saved]
> +        try:
> +            cfg.ethnl.rss_set({"header": header, "indir": updated})
> +        except Exception as exc:
> +            raise KsftSkipEx(f"cannot reserve RX queue in RSS: {exc}") from exc
> +        defer(cfg.ethnl.rss_set, {"header": header, "indir": saved})

[Severity: Medium]
Does this restore leave the indirection table marked as user configured?

Writing back an explicit copy of the table goes through ethnl_rss_set().
That function records a user size for any non-empty indir and clears it
only on a reset:

net/ethtool/rss.c:ethnl_rss_set() {
    ...
    } else if (indir_reset) {
        dev->ethtool->rss_indir_user_size = 0;
    } else if (indir_mod) {
        dev->ethtool->rss_indir_user_size = indir_user_size;
    }
    ...
}

So if a device had the driver default table before the test,
netif_is_rxfh_configured() returns true after every RX case and every
netns TX case. From then on, ethtool_get_max_rxfh_channel() checks channel
reductions against the table, so later ethtool -L reductions are refused.
Drivers such as ice, bnxt, mlx5, gve and fbnic also stop regenerating the
default spread when the channel count changes.

Other drv-net tests (rss_ctx.py, rss_api.py, rss_drv.py, ntuple.py,
devmem_lib.py, gro_stats.py and others) restore with ethtool -X <if>
default. Should this reset the table the same way instead?

[ ... ]

> +def _setup_case(cfg, name, direction, port, busy_poll):

[ ... ]

> +    if direction == "rx":
> +        queue = _reserve_rx_queue(cfg, port)
> +    else:
> +        # The DUT TX socket fills no RX buffers, so its zero-copy queue drops
> +        # what it receives. The control connection of a netns remote shares
> +        # the link, so keep that queue out of RSS.
> +        queue = _reserve_queue(cfg) if _netns_remote(cfg) else 0
> +        _steer_udp(cfg.remote_ifname, port, 0, cfg.remote, sudo)

[Severity: Medium]
What happens here when the SSH remote is reached over the tested link?

With SSH, the DUT TX socket is bound to queue 0, and queue 0 stays in the
default RSS spread. The DUT endpoint runs with -e tx, and in that mode
test_xsk.c never fills the fill ring:

    if (!ifobject->rx_on)
        return 0;

On drivers where the zero-copy pool supplies the queue's RX buffers (ice,
i40e), queue 0 then drops everything it receives, as the comment above
says.

_control_addr() assumes the SSH host is on a separate management link.
The example in drivers/net/README.rst uses the REMOTE_V4 address as the
SSH host:

    LOCAL_V4=192.168.1.1
    REMOTE_V4=192.168.1.2
    REMOTE_ARGS=root@192.168.1.2

In that setup, three kinds of traffic arrive on the DUT's tested NIC:

- the SSH session that carries the remote's "Listening" line and exit
  status
- the per-case TCP control connection
- non-hashed traffic such as ARP

Whichever of these lands on queue 0 loses all RX for that case, so TX
cases can hit LISTEN_TIMEOUT or CASE_TIMEOUT. If a persistent ControlMaster
connection hashes to queue 0, every TX case would break.

Should TX cases also take the queue out of RSS for SSH remotes, or at
least when the SSH host is REMOTE_V4?

[ ... ]

> +def _run_local(args):
> +    local = cmd(args, background=True, shell=False, fail=False)
> +    try:
> +        local.process(terminate=False, fail=False, timeout=CASE_TIMEOUT)
> +    except subprocess.TimeoutExpired as exc:
> +        local.proc.kill()
> +        local.process(terminate=False, fail=False)
> +        raise KsftFailEx(f"DUT case timed out after {CASE_TIMEOUT}s") from exc
> +    return local
> +
> +
> +def _run_endpoints(cfg, local_args, remote_args, control_port, fallbacks):
> +    local = None
> +    remote = bkg(shlex.join(remote_args), host=cfg.remote, exit_wait=True,
> +                 fail=False)
> +    try:
> +        head, listening = _wait_remote_listen(remote, control_port)
> +        if listening:
> +            local = _run_local(local_args)
> +            remote.process(terminate=False, fail=False, timeout=10)

[Severity: Low]
Is the endpoint output lost on these timeout paths?

If the remote has not exited within 10 seconds after the DUT finishes,
remote.process() raises subprocess.TimeoutExpired, and nothing catches it.
The finally block terminates the ssh client and the exception propagates.
As a result, neither the stderr merge below nor _case_result() runs. The
DUT's stdout and stderr, and the remote stderr already read into head, are
never printed, and ksft_run() reports a raw TimeoutExpired traceback.

The same happens when the DUT exceeds CASE_TIMEOUT: _run_local() collects
the DUT output after killing it, then raises KsftFailEx without printing
that output.

> +    finally:
> +        if remote.ret is None:
> +            remote.process(terminate=True, fail=False)

[Severity: Medium]
With the SSH backend, does this actually stop the remote xskxceiver?

remote_ssh.Remote.cmd() runs "ssh -q host cmd" without -t, so terminating
here only signals the local ssh client. The remote command has no
controlling tty, gets no SIGHUP, and can keep running. This path runs on
the listen timeout, after CASE_TIMEOUT, and when the 10 second remote wait
times out.

The fallbacks are not cancelled on these paths. The deferred
_detach_xdp(..., "xdpgeneric", ...) and _restore_mtu() calls for the remote
therefore run while the old endpoint may still hold its XDP program and an
XSK socket on queue 0.

The next case then starts a new remote endpoint on the same interface and
queue 0. The link is not checked again because _remote_idle_mtu() is
cached, and the new bind can fail with EBUSY while the old socket holds
the queue.

When the orphaned endpoint does exit, its cleanup in xskxceiver.c calls
xsk_detach_xdp_program(), which does:

    bpf_xdp_detach(ifindex, xdp_flags, NULL);

It then calls xsk_set_mtu(ifobj->ifindex, ifobj->orig_mtu). Both act on
whatever is on the link at that point, so they can remove the next case's
XDP program or reset its MTU in the middle of the test.

Can one failed or timed-out case cause the following cases to fail this
way? The netns backend is not affected.

[ ... ]

> @@ -0,0 +1,417 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""AF_XDP zero-copy hardware tests with an SKB-mode XSK peer."""
> +
> +import re
> +import shlex
> +import subprocess
> +import sys
> +import time
> +from pathlib import Path
> +
> +from lib.py import (EthtoolFamily, KsftFailEx, KsftNamedVariant, KsftSkipEx,
> +                    NetdevFamily, NetDrvEpEnv, bkg, cmd, defer, ethtool,
> +                    fd_read_timeout, ip, ksft_exit, ksft_pr, ksft_run,
> +                    ksft_variants, rand_port)
> +
> +CASE_TIMEOUT = 120
> +LISTEN_TIMEOUT = 30
> +NR_HUGEPAGES = 32
> +SKIP_CODE = 4
> +XSK_BIN = (Path(__file__).parent / "../../../net/lib/xskxceiver").resolve()
> +XSK_CASES = XSK_BIN.parent / "xsk/test_xsk_case_defs.h"
> +
> +
> +def _hardware_cases():
> +    defs = XSK_CASES.read_text()
> +    entries = re.findall(r"(?m)^XSK_TEST_CASE\((\w+),\s*\w+,\s*([^)]+)\)", defs)
> +    if not entries or len(entries) != defs.count("XSK_TEST_CASE("):
> +        raise KsftFailEx(f"cannot parse {XSK_CASES}")
> +    variants = []
> +    for test_id, (name, hw) in enumerate(entries):
> +        flags = {flag.strip() for flag in hw.split("|")}
> +        if not flags <= {"0", "XSK_HW_RX", "XSK_HW_TX"}:
> +            raise KsftFailEx(f"invalid hardware directions for {name}: {hw}")
> +        variants += [KsftNamedVariant(f"{d}_{name.lower()}", name, d, test_id)
> +                     for d in ("rx", "tx") if f"XSK_HW_{d.upper()}" in flags]
> +    return variants
> +
> +
> +def _netns_remote(cfg):
> +    return cfg.env.get("REMOTE_TYPE") == "netns"
> +
> +
> +def _control_addr(cfg):
> +    """An SSH remote is reached over its management link. A netns remote is
> +    reached only over the tested link, where the XDP programs pass the
> +    control connection to the stack."""
> +    if _netns_remote(cfg):
> +        return cfg.remote_addr_v["4"]
> +    return cfg.remote.name.rpartition("@")[2]
> +
> +
> +def _root_cmd(command, host=None, sudo=False, **kwargs):
> +    if sudo:
> +        command = "sudo -n " + command
> +    return cmd(command, host=host, **kwargs)
> +
> +
> +def _remote_binary(cfg, local_binary):
> +    binary = cfg.env.get("XSK_REMOTE_BIN")
> +    if not binary:
> +        return cfg.remote.deploy(local_binary)
> +    if cfg.env.get("REMOTE_TYPE") != "ssh":
> +        raise KsftSkipEx("XSK_REMOTE_BIN requires the SSH remote backend")
> +    if cfg.env.get("XSK_REMOTE_DEPLOY", "1") == "0":
> +        result = cmd(f"test -x {shlex.quote(binary)}", host=cfg.remote,
> +                     fail=False)
> +        if result.ret:
> +            raise KsftSkipEx(f"remote xskxceiver is not executable: {binary}")
> +        return binary
> +    upload = binary + ".upload"
> +    cmd(["scp", "-q", str(local_binary), f"{cfg.remote.name}:{upload}"],
> +        shell=False)
> +    cmd(f"mv -f {shlex.quote(upload)} {shlex.quote(binary)}",
> +        host=cfg.remote)
> +    return binary
> +
> +
> +def _remote_sudo(cfg):
> +    return cfg.env.get("XSK_REMOTE_SUDO", "").lower() not in ("", "0", "false")
> +
> +
> +def _restore_mtu(ifname, mtu, host=None, sudo=False):
> +    actual = ip(f"link show dev {shlex.quote(ifname)}", json=True,
> +                host=host)[0]["mtu"]
> +    if actual == mtu:
> +        return
> +    _root_cmd(f"ip link set dev {shlex.quote(ifname)} mtu {mtu}",
> +              host=host, sudo=sudo)
> +
> +
> +def _reserve_hugepages(host=None, sudo=False):
> +    have = int(cmd("sysctl -n vm.nr_hugepages", host=host).stdout)
> +    if have >= NR_HUGEPAGES:
> +        return
> +    _root_cmd(f"sysctl -qw vm.nr_hugepages={NR_HUGEPAGES}", host=host,
> +              sudo=sudo, fail=False)
> +    got = int(cmd("sysctl -n vm.nr_hugepages", host=host).stdout)
> +    if got != have:
> +        defer(_root_cmd, f"sysctl -qw vm.nr_hugepages={have}", host=host,
> +              sudo=sudo)
> +    if got < NR_HUGEPAGES:
> +        raise KsftSkipEx(f"only {got}/{NR_HUGEPAGES} hugepages available")
> +
> +
> +def _prefer_busy_poll(ifname):
> +    """SO_PREFER_BUSY_POLL keeps the device IRQs masked between busy polls
> +    only while napi_defer_hard_irqs and gro_flush_timeout are set. Use the
> +    values that test_xsk.sh sets on veth."""
> +    for knob, value in (("napi_defer_hard_irqs", "2"),
> +                        ("gro_flush_timeout", "200000")):
> +        path = Path("/sys/class/net", ifname, knob)
> +        orig = path.read_text(encoding="utf-8").strip()
> +        if orig != value:
> +            path.write_text(value, encoding="utf-8")
> +            defer(path.write_text, orig, encoding="utf-8")
> +
> +
> +def _feature_state(ifname, feature, host=None):
> +    """Read an ethtool -k feature. Parse the text output, as older ethtool
> +    versions can't print -k as JSON."""
> +    output = ethtool(f"-k {shlex.quote(ifname)}", host=host).stdout
> +    match = re.search(rf"^{re.escape(feature)}:\s+(on|off)(.*)$", output,
> +                      re.MULTILINE)
> +    if not match:
> +        raise KsftSkipEx(f"ethtool does not report {feature} on {ifname}")
> +    return {"active": match[1] == "on", "fixed": "[fixed]" in match[2]}
> +
> +
> +def _steer_udp(ifname, port, queue, host=None, sudo=False):
> +    dev = shlex.quote(ifname)
> +    rule = f"ethtool -N {dev} flow-type udp4 dst-port {port} action {queue}"
> +    # Look at ntuple-filters only once the rule is refused, as every command
> +    # on the remote costs a round trip.
> +    added = _root_cmd(rule, host=host, sudo=sudo, fail=False)
> +    if added.ret:
> +        ntuple = _feature_state(ifname, "ntuple-filters", host)
> +        if not ntuple["active"]:
> +            if ntuple["fixed"]:
> +                raise KsftSkipEx("NIC does not support ntuple filters")
> +            _root_cmd(f"ethtool -K {dev} ntuple-filters on", host=host,
> +                      sudo=sudo)
> +            defer(_root_cmd, f"ethtool -K {dev} ntuple-filters off",
> +                  host=host, sudo=sudo)
> +            added = _root_cmd(rule, host=host, sudo=sudo, fail=False)
> +    if added.ret:
> +        ksft_pr(repr(added))
> +        raise KsftSkipEx(f"cannot steer UDP flow to queue {queue} on {ifname}")
> +    match = re.search(r"ID (\d+)", added.stdout)
> +    if not match:
> +        raise KsftFailEx(f"cannot identify new ntuple rule: {added.stdout}")
> +    defer(_root_cmd, f"ethtool -N {dev} delete {match[1]}", host=host,
> +          sudo=sudo)
> +
> +
> +def _reserve_queue(cfg):
> +    """Move the last RX queue out of default RSS and return it."""
> +    header = {"dev-index": cfg.ifindex}
> +    channels = cfg.ethnl.channels_get({"header": header})
> +    count = (channels.get("combined-count") or 0) + (channels.get("rx-count") or 0)
> +    if count < 2:
> +        raise KsftSkipEx("RX queue isolation needs at least two channels")
> +    queue = count - 1
> +
> +    try:
> +        rss = cfg.ethnl.rss_get({"header": header})
> +        saved = list(rss["indir"])
> +    except Exception as exc:
> +        raise KsftSkipEx(f"cannot read RSS indirection table: {exc}") from exc
> +    if queue in saved:
> +        updated = [0 if entry == queue else entry for entry in saved]
> +        try:
> +            cfg.ethnl.rss_set({"header": header, "indir": updated})
> +        except Exception as exc:
> +            raise KsftSkipEx(f"cannot reserve RX queue in RSS: {exc}") from exc
> +        defer(cfg.ethnl.rss_set, {"header": header, "indir": saved})
> +        actual = cfg.ethnl.rss_get({"header": header}).get("indir")
> +        if actual != updated:
> +            raise KsftSkipEx("NIC did not remove the reserved queue from RSS")
> +    return queue
> +
> +
> +def _reserve_rx_queue(cfg, port):
> +    """Reserve an RX queue outside RSS and steer the test UDP flow to it."""
> +    queue = _reserve_queue(cfg)
> +    _steer_udp(cfg.ifname, port, queue)
> +    return queue
> +
> +
> +def _case_args(cfg, name):
> +    if name != "TOO_MANY_FRAGS":
> +        return []
> +    try:
> +        info = cfg.netnl.dev_get({"ifindex": cfg.ifindex})
> +    except Exception as exc:
> +        raise KsftSkipEx(f"cannot query DUT fragment limit: {exc}") from exc
> +    max_frags = info.get("xdp-zc-max-segs", 0)
> +    if max_frags <= 1:
> +        raise KsftSkipEx("DUT does not advertise multi-buffer zero-copy")
> +    return ["--max-frags", str(max_frags)]
> +
> +
> +def _idle_mtu(ifname, host=None):
> +    """Return the MTU of a link that has no XDP program attached."""
> +    info = ip(f"link show dev {shlex.quote(ifname)}", json=True, host=host)[0]
> +    if "xdp" in info:
> +        raise KsftSkipEx(f"{ifname} already has an XDP program")
> +    return info["mtu"]
> +
> +
> +def _remote_idle_mtu(cfg):
> +    """Look at the remote link once. Every case leaves its MTU as it found
> +    it and an endpoint replaces a program left behind by an earlier case,
> +    so looking again would only add a round trip to each case."""
> +    if not hasattr(cfg, "xsk_remote_mtu"):
> +        cfg.xsk_remote_mtu = _idle_mtu(cfg.remote_ifname, cfg.remote)
> +    return cfg.xsk_remote_mtu
> +
> +
> +def _detach_xdp(ifname, mode, host=None, sudo=False):
> +    """A killed endpoint leaves its XDP program behind; name the mode, as a
> +    bare "xdp off" only detaches driver mode on a native-XDP NIC."""
> +    info = ip(f"link show dev {shlex.quote(ifname)}", json=True, host=host)[0]
> +    if "xdp" not in info:
> +        return
> +    _root_cmd(f"ip link set dev {shlex.quote(ifname)} {mode} off", host=host,
> +              sudo=sudo)
> +
> +
> +def _wait_remote_listen(remote, port):
> +    """Read the remote endpoint's stderr up to the line it prints once it
> +    listens, as polling its sockets would cost a round trip per try. Return
> +    what was read and whether that line came."""
> +    line = f"Listening for XSK peer on port {port}\n".encode()
> +    fd = remote.proc.stderr.fileno()
> +    head = b""
> +    deadline = time.monotonic() + LISTEN_TIMEOUT
> +    while line not in head:
> +        try:
> +            data = fd_read_timeout(fd, max(deadline - time.monotonic(), 0))
> +        except TimeoutError:
> +            break
> +        if not data:
> +            break
> +        head += data
> +    return head.decode(), line in head
> +
> +
> +def _require_zc(cfg):
> +    if not hasattr(cfg, "xsk_zc"):
> +        xdp_features = cfg.netnl.dev_get({"ifindex": cfg.ifindex})["xdp-features"]
> +        cfg.xsk_zc = "xsk-zerocopy" in xdp_features
> +    if not cfg.xsk_zc:
> +        raise KsftSkipEx("NIC does not advertise AF_XDP zero-copy")
> +
> +
> +def _remote_test_binary(cfg):
> +    if not hasattr(cfg, "xsk_remote_bin"):
> +        cfg.xsk_remote_bin = _remote_binary(cfg, XSK_BIN)
> +    return cfg.xsk_remote_bin
> +
> +
> +def _udp_port(cfg):
> +    port = int(cfg.env.get("XSK_UDP_PORT", "42567"))
> +    if not 1 <= port <= 65535:
> +        raise KsftFailEx("XSK_UDP_PORT must be from 1 to 65535")
> +    return port
> +
> +
> +def _setup_case(cfg, name, direction, port, busy_poll):
> +    """Set up what this case alone needs; defer() undoes it when it ends.
> +    Return the DUT queue and the fallbacks for what the endpoints undo."""
> +    sudo = _remote_sudo(cfg)
> +    local_mtu = _idle_mtu(cfg.ifname)
> +    remote_mtu = _remote_idle_mtu(cfg)
> +    if "UNALIGNED" in name:
> +        _reserve_hugepages()
> +        _reserve_hugepages(cfg.remote, sudo)
> +    if busy_poll:
> +        _prefer_busy_poll(cfg.ifname)
> +
> +    if direction == "rx":
> +        queue = _reserve_rx_queue(cfg, port)
> +    else:
> +        # The DUT TX socket fills no RX buffers, so its zero-copy queue drops
> +        # what it receives. The control connection of a netns remote shares
> +        # the link, so keep that queue out of RSS.
> +        queue = _reserve_queue(cfg) if _netns_remote(cfg) else 0
> +        _steer_udp(cfg.remote_ifname, port, 0, cfg.remote, sudo)
> +
> +    # Undo what a failed or killed endpoint may leave behind. Defers run in
> +    # reverse, so the XDP programs, which can cap the MTU, are detached first.
> +    fallbacks = [
> +        defer(_restore_mtu, cfg.ifname, local_mtu),
> +        defer(_restore_mtu, cfg.remote_ifname, remote_mtu, cfg.remote, sudo),
> +        defer(_detach_xdp, cfg.ifname, "xdpdrv"),
> +        defer(_detach_xdp, cfg.remote_ifname, "xdpgeneric", cfg.remote, sudo),
> +    ]
> +    return queue, fallbacks
> +
> +
> +def _udp_args(cfg, direction, port):
> +    if direction == "rx":
> +        src, dst = cfg.remote_addr_v["4"], cfg.addr_v["4"]
> +    else:
> +        src, dst = cfg.addr_v["4"], cfg.remote_addr_v["4"]
> +    return ["--udp-src", src, "--udp-dst", dst, "--udp-port", str(port)]
> +
> +
> +def _case_result(local, remote):
> +    if local and local.stdout:
> +        ksft_pr(local.stdout, line_pfx="dut|")
> +    if local and local.stderr:
> +        ksft_pr(local.stderr, line_pfx="dut|")
> +    if remote.stdout:
> +        ksft_pr(remote.stdout, line_pfx="remote|")
> +    if remote.stderr:
> +        ksft_pr(remote.stderr, line_pfx="remote|")
> +    if local is None:
> +        raise KsftFailEx("remote XSK endpoint did not listen on the control "
> +                         f"port, exit {remote.ret}")
> +    if local.ret == SKIP_CODE or remote.ret == SKIP_CODE:
> +        raise KsftSkipEx("AF_XDP case unsupported by one endpoint")
> +    if local.ret or remote.ret:
> +        raise KsftFailEx(f"DUT exit {local.ret}, remote exit {remote.ret}")
> +
> +
> +def _run_local(args):
> +    local = cmd(args, background=True, shell=False, fail=False)
> +    try:
> +        local.process(terminate=False, fail=False, timeout=CASE_TIMEOUT)
> +    except subprocess.TimeoutExpired as exc:
> +        local.proc.kill()
> +        local.process(terminate=False, fail=False)
> +        raise KsftFailEx(f"DUT case timed out after {CASE_TIMEOUT}s") from exc
> +    return local
> +
> +
> +def _run_endpoints(cfg, local_args, remote_args, control_port, fallbacks):
> +    local = None
> +    remote = bkg(shlex.join(remote_args), host=cfg.remote, exit_wait=True,
> +                 fail=False)
> +    try:
> +        head, listening = _wait_remote_listen(remote, control_port)
> +        if listening:
> +            local = _run_local(local_args)
> +            remote.process(terminate=False, fail=False, timeout=10)
> +    finally:
> +        if remote.ret is None:
> +            remote.process(terminate=True, fail=False)
> +    # _wait_remote_listen() took the start of stderr off the pipe.
> +    remote.stderr = head + remote.stderr
> +    if local and {local.ret, remote.ret} <= {0, SKIP_CODE}:
> +        # Both endpoints detached XDP and restored the MTU when they exited.
> +        for fallback in fallbacks:
> +            fallback.cancel()
> +    _case_result(local, remote)
> +
> +
> +def test_xsk(cfg, name, direction, test_id, busy_poll=False):
> +    cfg.require_ipver("4")
> +    sync_addr = _control_addr(cfg)
> +    udp_port = _udp_port(cfg)
> +    _require_zc(cfg)
> +    remote_bin = _remote_test_binary(cfg)
> +    case_args = _case_args(cfg, name)
> +    queue, fallbacks = _setup_case(cfg, name, direction, udp_port, busy_poll)
> +
> +    udp_args = _udp_args(cfg, direction, udp_port)
> +    control_port = rand_port()
> +    remote_args = [str(remote_bin), "-i", cfg.remote_ifname,
> +                   "--hw", "--listen", "-m", "skb",
> +                   "-t", str(test_id),
> +                   "-e", "tx" if direction == "rx" else "rx",
> +                   "-p", "0.0.0.0", "-P", str(control_port), *udp_args,
> +                   "--peer-mac", cfg.dev["address"], "--queue", "0", *case_args]
> +    if _remote_sudo(cfg):
> +        remote_args = ["sudo", "-n"] + remote_args
> +    local_args = [str(XSK_BIN), "-i", cfg.ifname, "--hw", "-m", "zc",
> +                  "-t", str(test_id), "-e", direction,
> +                  "-p", sync_addr, "-P", str(control_port), *udp_args,
> +                  "--peer-mac", cfg.remote_dev["address"],
> +                  "--queue", str(queue), *case_args]
> +    if busy_poll:
> +        local_args.append("-b")
> +    _run_endpoints(cfg, local_args, remote_args, control_port, fallbacks)
> +
> +
> +def test_xsk_busy_poll(cfg, name, direction, test_id):
> +    """Run a case with the DUT endpoint busy polling."""
> +    test_xsk(cfg, name, direction, test_id, busy_poll=True)
> +
> +
> +def main():
> +    # ksft_run() rejects options it does not know, so take -b out first.
> +    busy_poll = "-b" in sys.argv[1:]
> +    if busy_poll:
> +        sys.argv.remove("-b")
> +    test = test_xsk_busy_poll if busy_poll else test_xsk
> +    variants = ksft_variants(_hardware_cases())(test)
> +
> +    if any(arg in ("-h", "-l") for arg in sys.argv[1:]):
> +        ksft_run(cases=[variants])
> +        return
> +    if not XSK_BIN.exists():
> +        print(f"1..0 # SKIP {XSK_BIN} was not built")
> +        sys.exit(SKIP_CODE)
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> +        cfg.ethnl = EthtoolFamily()
> +        cfg.netnl = NetdevFamily()
> +        ksft_run(cases=[variants], args=(cfg,))
> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()

[Severity: Low]
main() calls _hardware_cases() to build the variants before it gets to
the XSK_BIN.exists() check. That check is what turns a missing
xskxceiver into a skip.

If test_xsk_case_defs.h is not at XSK_CASES, read_text() raises
FileNotFoundError. This happens outside ksft_run(), so the script dies
with a Python traceback instead of printing a KTAP skip line. The -h and
-l paths go through _hardware_cases() too, so even listing the cases
crashes.

How is the header expected to get there? drivers/net/hw/Makefile does
not list ../../../net/lib/xsk/test_xsk_case_defs.h in TEST_INCLUDES. The
commit message relies on net/lib being an install dependency of drv-net.
An out-of-tree run such as:

    make O=build TARGETS=drivers/net/hw run_tests

only rsyncs TEST_PROGS, TEST_FILES and TEST_INCLUDES into the output
directory. It does not install INSTALL_DEP_TARGETS. As far as I can
tell, the header then never lands under build/net/lib/xsk/, and xsk.py
crashes before it can skip.

Should the header be added to TEST_INCLUDES? Separately, could main()
check XSK_CASES (and XSK_BIN) before _hardware_cases() runs? That way a
missing net/lib build would be reported as a skip rather than a
traceback.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008114909.734364-1-maciej.fijalkowski%40intel.com
