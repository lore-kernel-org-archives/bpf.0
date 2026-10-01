Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E7492E48;
	Thu,  1 Oct 2026 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886190; cv=none; b=POsr7CzquBNyicK1Y2exKSVYGlaA/BjBUQqulldhPhB3hsKE/Jotq9nUFEHP4iSVO28k31pKXfD6iubk/iV57FjHAkgx+z0GSl78OZzH+NCK9aSBjD+Xbjwlm4vtH9oa7TuVy8jKDf5ucQeusBj2USh924H/IbAlq/eH5/QhyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886190; c=relaxed/simple;
	bh=iP/rbSUpJz59lINsJFBVfNjfgUZto7VKEuXRC84lMvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=stoMqbPHa6X5MJ3Xy/dqGqWexOorWzvhOSkxvve3GOrhtS2KnzsVYAWF/hWbrMR+mCKh8hBoqedCeoDD37azNgtKvSlnHUu6utt1vQUCg4FMwfag3Jj11Q/bXpLzsOgurDp8E7FxfRSoolOoHB6X5RDeLsA1JI0KxEYXnoHy7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsOMbtEP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsOMbtEP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886183; x=1822422183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iP/rbSUpJz59lINsJFBVfNjfgUZto7VKEuXRC84lMvY=;
  b=gsOMbtEP8uodJ7iwy55Z9yTEuqjEwoppe2fXKA74MWvHFM3kE2bhYiDC
   Q9ieroqe5JhoJRAQPJ19M65tj1kqDggZSTskeWWFhicet+DLtgHjh50yi
   866LUJMLcEjy8rmPPk6hzDjv+OhswghMaAMpklqjKZuAD2289DcUPLk5T
   LoQ9QhsUWdoHRH2ItHCzSzCZ4NIlJdBfmQbqzT/dq+0ieAd4u3FPUdauT
   9XFAhfyODLvrp1o4m+KFFLX97aaSLmVIhL49Rc0BxIGFA4eVwrWR3yT84
   0IFgp5yQ5JavWxSfKuMxbT/cgrKZUBGke9Htom5VG127StjgAABGo/dCi
   w==;
X-CSE-ConnectionGUID: KgGWclqRS4qzbzelcw35Ww==
X-CSE-MsgGUID: dl8FLVdPQfOsnkYICg+U4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="95466849"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="95466849"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:22:54 -0700
X-CSE-ConnectionGUID: jCgHvLN7RaCBxZveE5LC7w==
X-CSE-MsgGUID: h0WsjxByRu+7Skl11MimbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="275636740"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa007.jf.intel.com with ESMTP; 01 Oct 2026 13:22:52 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net-next 12/13] selftests: drv-net: test AF_XDP zero-copy with an SKB peer
Date: Thu,  1 Oct 2026 22:21:23 +0200
Message-Id: <20261001202124.692591-13-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run each hardware AF_XDP case as a separate DUT and remote xskxceiver
pair. The DUT endpoint uses zero-copy mode and the remote endpoint uses
SKB mode, without negotiating remote capabilities. The cases, and the
DUT direction each of them covers, come from test_xsk_case_defs.h and
become KTAP variants named <rx|tx>_<case>, so -t and -T select them as
for any other ksft_variants() test.

Use the networking selftest Python helpers for remote execution, process
lifetime, deferred restoration, TAP variants and random control ports.
Each case sets up only what its DUT direction needs and undoes it with
defer() when it ends: RX cases take the last DUT queue out of RSS and
steer the test UDP flow to it, TX cases steer the flow to queue 0 on the
remote, where its SKB-mode socket is bound, and UNALIGNED cases reserve
hugepages on both hosts. A setup failure therefore skips only the cases
that need that setup: a one-channel DUT still runs the TX cases and a
remote without ntuple filters still runs the RX ones.

xsk.py -b runs the cases as test_xsk_busy_poll instead, like the
busy-poll pass of test_xsk.sh. The DUT endpoint then busy polls, and
each case sets napi_defer_hard_irqs and gro_flush_timeout on the DUT to
the values test_xsk.sh uses on veth, so that SO_PREFER_BUSY_POLL keeps
the device IRQs masked, and restores them when it ends. The remote
endpoint does not busy poll.

Each remote command costs an SSH login, so the runner keeps them few. It
adds a steering rule first and checks ntuple-filters only if the NIC
refuses the rule, and it starts the DUT endpoint once the remote
endpoint prints on stderr that it listens, instead of polling the remote
for the port. The endpoints detach their XDP programs and restore the
MTU when they exit, and the runner does so for them only after one fails
or is killed. Only the deployed remote binary, the DUT zero-copy check
and the idle MTU of the remote link are shared between cases. The remote
link is not checked again, as a remote endpoint replaces an XDP program
that an earlier one left behind.

xsk.py runs the xskxceiver built by net/lib, which drv-net already pulls
in as an install dependency, and deploys it to the remote.
XSK_REMOTE_BIN names a remote path to copy it to instead, or, with
XSK_REMOTE_DEPLOY=0, an already installed binary. XSK_REMOTE_SUDO runs
the remote commands through sudo -n, and XSK_UDP_PORT overrides the port
of the test flow. The control channel connects to the SSH host. As the
remote may have an older libc, net/lib now links xskxceiver statically
when the static libelf archives are available; XSK_STATIC=0/1 overrides
the probe.

Add xsk.py to TEST_PROGS and to the AF_XDP entry in MAINTAINERS, and
CONFIG_XDP_SOCKETS to the drv-net config.

Assisted-by: LLM
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 MAINTAINERS                                   |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/config |   1 +
 tools/testing/selftests/drivers/net/hw/xsk.py | 402 ++++++++++++++++++
 tools/testing/selftests/net/lib/Makefile      |  13 +-
 5 files changed, 417 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a3f097ba9ff1..e653f1009219 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29726,6 +29726,7 @@ F:	include/net/xsk_buff_pool.h
 F:	include/uapi/linux/if_xdp.h
 F:	include/uapi/linux/xdp_diag.h
 F:	net/xdp/
+F:	tools/testing/selftests/drivers/net/hw/xsk.py
 F:	tools/testing/selftests/net/*xsk*
 F:	tools/testing/selftests/net/lib/xsk/
 
diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 6105be8e590f..5734cd7a4bdc 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -50,6 +50,7 @@ TEST_PROGS = \
 	userns_devmem.py \
 	uso.py \
 	xdp_metadata.py \
+	xsk.py \
 	xsk_reconfig.py \
 	#
 
diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index d89a9ba17655..fbf048d1d732 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -25,4 +25,5 @@ CONFIG_SYNC_FILE=y
 CONFIG_UDMABUF=y
 CONFIG_USER_NS=y
 CONFIG_VXLAN=y
+CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_USER=y
diff --git a/tools/testing/selftests/drivers/net/hw/xsk.py b/tools/testing/selftests/drivers/net/hw/xsk.py
new file mode 100755
index 000000000000..dd6bdbb1abea
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/xsk.py
@@ -0,0 +1,402 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""AF_XDP zero-copy hardware tests with an SKB-mode XSK peer."""
+
+import re
+import shlex
+import subprocess
+import sys
+import time
+from pathlib import Path
+
+from lib.py import (EthtoolFamily, KsftFailEx, KsftNamedVariant, KsftSkipEx,
+                    NetdevFamily, NetDrvEpEnv, bkg, cmd, defer, ethtool,
+                    fd_read_timeout, ip, ksft_exit, ksft_pr, ksft_run,
+                    ksft_variants, rand_port)
+
+CASE_TIMEOUT = 120
+LISTEN_TIMEOUT = 30
+NR_HUGEPAGES = 32
+SKIP_CODE = 4
+XSK_BIN = (Path(__file__).parent / "../../../net/lib/xskxceiver").resolve()
+XSK_CASES = XSK_BIN.parent / "xsk/test_xsk_case_defs.h"
+
+
+def _hardware_cases():
+    defs = XSK_CASES.read_text()
+    entries = re.findall(r"(?m)^XSK_TEST_CASE\((\w+),\s*\w+,\s*([^)]+)\)", defs)
+    if not entries or len(entries) != defs.count("XSK_TEST_CASE("):
+        raise KsftFailEx(f"cannot parse {XSK_CASES}")
+    variants = []
+    for test_id, (name, hw) in enumerate(entries):
+        flags = {flag.strip() for flag in hw.split("|")}
+        if not flags <= {"0", "XSK_HW_RX", "XSK_HW_TX"}:
+            raise KsftFailEx(f"invalid hardware directions for {name}: {hw}")
+        variants += [KsftNamedVariant(f"{d}_{name.lower()}", name, d, test_id)
+                     for d in ("rx", "tx") if f"XSK_HW_{d.upper()}" in flags]
+    return variants
+
+
+def _management_addr(cfg):
+    if cfg.env.get("REMOTE_TYPE") == "ssh":
+        return cfg.remote.name.rpartition("@")[2]
+    raise KsftSkipEx("AF_XDP hardware tests require an SSH remote")
+
+
+def _root_cmd(command, host=None, sudo=False, **kwargs):
+    if sudo:
+        command = "sudo -n " + command
+    return cmd(command, host=host, **kwargs)
+
+
+def _remote_binary(cfg, local_binary):
+    binary = cfg.env.get("XSK_REMOTE_BIN")
+    if not binary:
+        return cfg.remote.deploy(local_binary)
+    if cfg.env.get("REMOTE_TYPE") != "ssh":
+        raise KsftSkipEx("XSK_REMOTE_BIN requires the SSH remote backend")
+    if cfg.env.get("XSK_REMOTE_DEPLOY", "1") == "0":
+        result = cmd(f"test -x {shlex.quote(binary)}", host=cfg.remote,
+                     fail=False)
+        if result.ret:
+            raise KsftSkipEx(f"remote xskxceiver is not executable: {binary}")
+        return binary
+    upload = binary + ".upload"
+    cmd(["scp", "-q", str(local_binary), f"{cfg.remote.name}:{upload}"],
+        shell=False)
+    cmd(f"mv -f {shlex.quote(upload)} {shlex.quote(binary)}",
+        host=cfg.remote)
+    return binary
+
+
+def _remote_sudo(cfg):
+    return cfg.env.get("XSK_REMOTE_SUDO", "").lower() not in ("", "0", "false")
+
+
+def _restore_mtu(ifname, mtu, host=None, sudo=False):
+    actual = ip(f"link show dev {shlex.quote(ifname)}", json=True,
+                host=host)[0]["mtu"]
+    if actual == mtu:
+        return
+    _root_cmd(f"ip link set dev {shlex.quote(ifname)} mtu {mtu}",
+              host=host, sudo=sudo)
+
+
+def _reserve_hugepages(host=None, sudo=False):
+    have = int(cmd("sysctl -n vm.nr_hugepages", host=host).stdout)
+    if have >= NR_HUGEPAGES:
+        return
+    _root_cmd(f"sysctl -qw vm.nr_hugepages={NR_HUGEPAGES}", host=host,
+              sudo=sudo, fail=False)
+    got = int(cmd("sysctl -n vm.nr_hugepages", host=host).stdout)
+    if got != have:
+        defer(_root_cmd, f"sysctl -qw vm.nr_hugepages={have}", host=host,
+              sudo=sudo)
+    if got < NR_HUGEPAGES:
+        raise KsftSkipEx(f"only {got}/{NR_HUGEPAGES} hugepages available")
+
+
+def _prefer_busy_poll(ifname):
+    """SO_PREFER_BUSY_POLL keeps the device IRQs masked between busy polls
+    only while napi_defer_hard_irqs and gro_flush_timeout are set. Use the
+    values that test_xsk.sh sets on veth."""
+    for knob, value in (("napi_defer_hard_irqs", "2"),
+                        ("gro_flush_timeout", "200000")):
+        path = Path("/sys/class/net", ifname, knob)
+        orig = path.read_text(encoding="utf-8").strip()
+        if orig != value:
+            path.write_text(value, encoding="utf-8")
+            defer(path.write_text, orig, encoding="utf-8")
+
+
+def _feature_state(ifname, feature, host=None):
+    """Read an ethtool -k feature. Parse the text output, as older ethtool
+    versions can't print -k as JSON."""
+    output = ethtool(f"-k {shlex.quote(ifname)}", host=host).stdout
+    match = re.search(rf"^{re.escape(feature)}:\s+(on|off)(.*)$", output,
+                      re.MULTILINE)
+    if not match:
+        raise KsftSkipEx(f"ethtool does not report {feature} on {ifname}")
+    return {"active": match[1] == "on", "fixed": "[fixed]" in match[2]}
+
+
+def _steer_udp(ifname, port, queue, host=None, sudo=False):
+    dev = shlex.quote(ifname)
+    rule = f"ethtool -N {dev} flow-type udp4 dst-port {port} action {queue}"
+    # Look at ntuple-filters only once the rule is refused, as every command
+    # on the remote costs a round trip.
+    added = _root_cmd(rule, host=host, sudo=sudo, fail=False)
+    if added.ret:
+        ntuple = _feature_state(ifname, "ntuple-filters", host)
+        if not ntuple["active"]:
+            if ntuple["fixed"]:
+                raise KsftSkipEx("NIC does not support ntuple filters")
+            _root_cmd(f"ethtool -K {dev} ntuple-filters on", host=host,
+                      sudo=sudo)
+            defer(_root_cmd, f"ethtool -K {dev} ntuple-filters off",
+                  host=host, sudo=sudo)
+            added = _root_cmd(rule, host=host, sudo=sudo, fail=False)
+    if added.ret:
+        ksft_pr(repr(added))
+        raise KsftSkipEx(f"cannot steer UDP flow to queue {queue} on {ifname}")
+    match = re.search(r"ID (\d+)", added.stdout)
+    if not match:
+        raise KsftFailEx(f"cannot identify new ntuple rule: {added.stdout}")
+    defer(_root_cmd, f"ethtool -N {dev} delete {match[1]}", host=host,
+          sudo=sudo)
+
+
+def _reserve_rx_queue(cfg, port):
+    """Move one RX queue out of default RSS and steer the test UDP flow."""
+    header = {"dev-index": cfg.ifindex}
+    channels = cfg.ethnl.channels_get({"header": header})
+    count = (channels.get("combined-count") or 0) + (channels.get("rx-count") or 0)
+    if count < 2:
+        raise KsftSkipEx("RX queue isolation needs at least two channels")
+    queue = count - 1
+
+    try:
+        rss = cfg.ethnl.rss_get({"header": header})
+        saved = list(rss["indir"])
+    except Exception as exc:
+        raise KsftSkipEx(f"cannot read RSS indirection table: {exc}") from exc
+    if queue in saved:
+        updated = [0 if entry == queue else entry for entry in saved]
+        try:
+            cfg.ethnl.rss_set({"header": header, "indir": updated})
+        except Exception as exc:
+            raise KsftSkipEx(f"cannot reserve RX queue in RSS: {exc}") from exc
+        defer(cfg.ethnl.rss_set, {"header": header, "indir": saved})
+        actual = cfg.ethnl.rss_get({"header": header}).get("indir")
+        if actual != updated:
+            raise KsftSkipEx("NIC did not remove the reserved queue from RSS")
+
+    _steer_udp(cfg.ifname, port, queue)
+    return queue
+
+
+def _case_args(cfg, name):
+    if name != "TOO_MANY_FRAGS":
+        return []
+    try:
+        info = cfg.netnl.dev_get({"ifindex": cfg.ifindex})
+    except Exception as exc:
+        raise KsftSkipEx(f"cannot query DUT fragment limit: {exc}") from exc
+    max_frags = info.get("xdp-zc-max-segs", 0)
+    if max_frags <= 1:
+        raise KsftSkipEx("DUT does not advertise multi-buffer zero-copy")
+    return ["--max-frags", str(max_frags)]
+
+
+def _idle_mtu(ifname, host=None):
+    """Return the MTU of a link that has no XDP program attached."""
+    info = ip(f"link show dev {shlex.quote(ifname)}", json=True, host=host)[0]
+    if "xdp" in info:
+        raise KsftSkipEx(f"{ifname} already has an XDP program")
+    return info["mtu"]
+
+
+def _remote_idle_mtu(cfg):
+    """Look at the remote link once. Every case leaves its MTU as it found
+    it and an endpoint replaces a program left behind by an earlier case,
+    so looking again would only add a round trip to each case."""
+    if not hasattr(cfg, "xsk_remote_mtu"):
+        cfg.xsk_remote_mtu = _idle_mtu(cfg.remote_ifname, cfg.remote)
+    return cfg.xsk_remote_mtu
+
+
+def _detach_xdp(ifname, mode, host=None, sudo=False):
+    """A killed endpoint leaves its XDP program behind; name the mode, as a
+    bare "xdp off" only detaches driver mode on a native-XDP NIC."""
+    info = ip(f"link show dev {shlex.quote(ifname)}", json=True, host=host)[0]
+    if "xdp" not in info:
+        return
+    _root_cmd(f"ip link set dev {shlex.quote(ifname)} {mode} off", host=host,
+              sudo=sudo)
+
+
+def _wait_remote_listen(remote, port):
+    """Read the remote endpoint's stderr up to the line it prints once it
+    listens, as polling its sockets would cost a round trip per try. Return
+    what was read and whether that line came."""
+    line = f"Listening for XSK peer on port {port}\n".encode()
+    fd = remote.proc.stderr.fileno()
+    head = b""
+    deadline = time.monotonic() + LISTEN_TIMEOUT
+    while line not in head:
+        try:
+            data = fd_read_timeout(fd, max(deadline - time.monotonic(), 0))
+        except TimeoutError:
+            break
+        if not data:
+            break
+        head += data
+    return head.decode(), line in head
+
+
+def _require_zc(cfg):
+    if not hasattr(cfg, "xsk_zc"):
+        xdp_features = cfg.netnl.dev_get({"ifindex": cfg.ifindex})["xdp-features"]
+        cfg.xsk_zc = "xsk-zerocopy" in xdp_features
+    if not cfg.xsk_zc:
+        raise KsftSkipEx("NIC does not advertise AF_XDP zero-copy")
+
+
+def _remote_test_binary(cfg):
+    if not hasattr(cfg, "xsk_remote_bin"):
+        cfg.xsk_remote_bin = _remote_binary(cfg, XSK_BIN)
+    return cfg.xsk_remote_bin
+
+
+def _udp_port(cfg):
+    port = int(cfg.env.get("XSK_UDP_PORT", "42567"))
+    if not 1 <= port <= 65535:
+        raise KsftFailEx("XSK_UDP_PORT must be from 1 to 65535")
+    return port
+
+
+def _setup_case(cfg, name, direction, port, busy_poll):
+    """Set up what this case alone needs; defer() undoes it when it ends.
+    Return the DUT queue and the fallbacks for what the endpoints undo."""
+    sudo = _remote_sudo(cfg)
+    local_mtu = _idle_mtu(cfg.ifname)
+    remote_mtu = _remote_idle_mtu(cfg)
+    if "UNALIGNED" in name:
+        _reserve_hugepages()
+        _reserve_hugepages(cfg.remote, sudo)
+    if busy_poll:
+        _prefer_busy_poll(cfg.ifname)
+
+    if direction == "rx":
+        queue = _reserve_rx_queue(cfg, port)
+    else:
+        queue = 0
+        _steer_udp(cfg.remote_ifname, port, 0, cfg.remote, sudo)
+
+    # Undo what a failed or killed endpoint may leave behind. Defers run in
+    # reverse, so the XDP programs, which can cap the MTU, are detached first.
+    fallbacks = [
+        defer(_restore_mtu, cfg.ifname, local_mtu),
+        defer(_restore_mtu, cfg.remote_ifname, remote_mtu, cfg.remote, sudo),
+        defer(_detach_xdp, cfg.ifname, "xdpdrv"),
+        defer(_detach_xdp, cfg.remote_ifname, "xdpgeneric", cfg.remote, sudo),
+    ]
+    return queue, fallbacks
+
+
+def _udp_args(cfg, direction, port):
+    if direction == "rx":
+        src, dst = cfg.remote_addr_v["4"], cfg.addr_v["4"]
+    else:
+        src, dst = cfg.addr_v["4"], cfg.remote_addr_v["4"]
+    return ["--udp-src", src, "--udp-dst", dst, "--udp-port", str(port)]
+
+
+def _case_result(local, remote):
+    if local and local.stdout:
+        ksft_pr(local.stdout, line_pfx="dut|")
+    if local and local.stderr:
+        ksft_pr(local.stderr, line_pfx="dut|")
+    if remote.stdout:
+        ksft_pr(remote.stdout, line_pfx="remote|")
+    if remote.stderr:
+        ksft_pr(remote.stderr, line_pfx="remote|")
+    if local is None:
+        raise KsftFailEx("remote XSK endpoint did not listen on the control "
+                         f"port, exit {remote.ret}")
+    if local.ret == SKIP_CODE or remote.ret == SKIP_CODE:
+        raise KsftSkipEx("AF_XDP case unsupported by one endpoint")
+    if local.ret or remote.ret:
+        raise KsftFailEx(f"DUT exit {local.ret}, remote exit {remote.ret}")
+
+
+def _run_local(args):
+    local = cmd(args, background=True, shell=False, fail=False)
+    try:
+        local.process(terminate=False, fail=False, timeout=CASE_TIMEOUT)
+    except subprocess.TimeoutExpired as exc:
+        local.proc.kill()
+        local.process(terminate=False, fail=False)
+        raise KsftFailEx(f"DUT case timed out after {CASE_TIMEOUT}s") from exc
+    return local
+
+
+def _run_endpoints(cfg, local_args, remote_args, control_port, fallbacks):
+    local = None
+    remote = bkg(shlex.join(remote_args), host=cfg.remote, exit_wait=True,
+                 fail=False)
+    try:
+        head, listening = _wait_remote_listen(remote, control_port)
+        if listening:
+            local = _run_local(local_args)
+            remote.process(terminate=False, fail=False, timeout=10)
+    finally:
+        if remote.ret is None:
+            remote.process(terminate=True, fail=False)
+    # _wait_remote_listen() took the start of stderr off the pipe.
+    remote.stderr = head + remote.stderr
+    if local and {local.ret, remote.ret} <= {0, SKIP_CODE}:
+        # Both endpoints detached XDP and restored the MTU when they exited.
+        for fallback in fallbacks:
+            fallback.cancel()
+    _case_result(local, remote)
+
+
+def test_xsk(cfg, name, direction, test_id, busy_poll=False):
+    cfg.require_ipver("4")
+    sync_addr = _management_addr(cfg)
+    udp_port = _udp_port(cfg)
+    _require_zc(cfg)
+    remote_bin = _remote_test_binary(cfg)
+    case_args = _case_args(cfg, name)
+    queue, fallbacks = _setup_case(cfg, name, direction, udp_port, busy_poll)
+
+    udp_args = _udp_args(cfg, direction, udp_port)
+    control_port = rand_port()
+    remote_args = [str(remote_bin), "-i", cfg.remote_ifname,
+                   "--hw", "--listen", "-m", "skb",
+                   "-t", str(test_id),
+                   "-e", "tx" if direction == "rx" else "rx",
+                   "-p", "0.0.0.0", "-P", str(control_port), *udp_args,
+                   "--peer-mac", cfg.dev["address"], "--queue", "0", *case_args]
+    if _remote_sudo(cfg):
+        remote_args = ["sudo", "-n"] + remote_args
+    local_args = [str(XSK_BIN), "-i", cfg.ifname, "--hw", "-m", "zc",
+                  "-t", str(test_id), "-e", direction,
+                  "-p", sync_addr, "-P", str(control_port), *udp_args,
+                  "--peer-mac", cfg.remote_dev["address"],
+                  "--queue", str(queue), *case_args]
+    if busy_poll:
+        local_args.append("-b")
+    _run_endpoints(cfg, local_args, remote_args, control_port, fallbacks)
+
+
+def test_xsk_busy_poll(cfg, name, direction, test_id):
+    """Run a case with the DUT endpoint busy polling."""
+    test_xsk(cfg, name, direction, test_id, busy_poll=True)
+
+
+def main():
+    # ksft_run() rejects options it does not know, so take -b out first.
+    busy_poll = "-b" in sys.argv[1:]
+    if busy_poll:
+        sys.argv.remove("-b")
+    test = test_xsk_busy_poll if busy_poll else test_xsk
+    variants = ksft_variants(_hardware_cases())(test)
+
+    if any(arg in ("-h", "-l") for arg in sys.argv[1:]):
+        ksft_run(cases=[variants])
+        return
+    if not XSK_BIN.exists():
+        print(f"1..0 # SKIP {XSK_BIN} was not built")
+        sys.exit(SKIP_CODE)
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        cfg.ethnl = EthtoolFamily()
+        cfg.netnl = NetdevFamily()
+        ksft_run(cases=[variants], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index faac930acf1d..0757a20612ae 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -32,7 +32,7 @@ include ../../lib.mk
 
 include ../bpf.mk
 
-# AF_XDP test engine used by net/test_xsk.sh.
+# AF_XDP test engine shared by net/test_xsk.sh and drivers/net/hw/xsk.py.
 XSK_DIR := xsk
 XSK_BPF_OBJ := $(OUTPUT)/xsk_xdp_progs.bpf.o
 XSK_SKEL := $(OUTPUT)/xsk_xdp_progs.skel.h
@@ -40,8 +40,19 @@ XSK_SOURCES := $(addprefix $(XSK_DIR)/,xskxceiver.c xsk.c test_xsk.c xsk_peer.c)
 	$(top_srcdir)/tools/lib/find_bit.c
 XSK_HEADERS := $(wildcard $(XSK_DIR)/*.h)
 
+# xsk.py may copy xskxceiver to a host with an older libc.  Prefer a
+# static binary when the required archives are installed.  XSK_STATIC=0/1
+# can be used to override the probe.
 PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
+XSK_STATIC_LIBS := $(shell $(PKG_CONFIG) libelf --static --libs 2>/dev/null || \
+	echo -lelf -lz -lzstd) -lz
+XSK_STATIC ?= $(shell echo 'int main(void) { return 0; }' | \
+	$(CC) -x c - -static $(XSK_STATIC_LIBS) -o /dev/null 2>/dev/null && echo 1)
+ifeq ($(XSK_STATIC),1)
+XSK_LDLIBS := -static $(XSK_STATIC_LIBS)
+else
 XSK_LDLIBS := $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf) -lz
+endif
 
 $(XSK_BPF_OBJ): $(XSK_DIR)/xsk_xdp_progs.bpf.c $(XSK_DIR)/xsk_xdp_common.h $(BPFOBJ)
 	$(call msg,BPF_PROG,,$@)
-- 
2.43.0

