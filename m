Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABC497B9C;
	Thu,  8 Oct 2026 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460200; cv=none; b=HLerb2NhIAQIFqd5Z+eIdSaph/jxhXc67rMq4R4ryY6qFt27O11ob/0NpYKhZrOoY5e045TrfdtkZArynjNJwdpamFp1D173yYGJOZMXqK/QXkvqqgukJMGjoZvuXIGaGrtmV4150xcrgnMuQPiZCVR4yGgOWd4+L5ZMJS/KUYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460200; c=relaxed/simple;
	bh=H7bNyL0va2wCATyZvvTa8GjB7pDXZRPuGjnFDuDfalg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DMLnZzwL7YtfdeF1P0KSQzGVQIZToeDu3LycqaotfTp43qB2mk2qn1IsJkEE0u8CAs/XxjJFIe4PCj82zt0bo63p3oItiue/8MZJ2wRJUQUAeXieFF96bRcVj8T18RlStM8p6t3+ZbZmsPntMbt/RpUFuewp6YzHhWd7797pQO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQwtTxY1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQwtTxY1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791460196; x=1822996196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H7bNyL0va2wCATyZvvTa8GjB7pDXZRPuGjnFDuDfalg=;
  b=BQwtTxY1QDYlXYDN+W9/BYZTTpsgdNiHrfAzkpceZQ7LNs4qq50W6nlK
   zPyPjxe3/A4H1WZxWbkkm4icacf6J063lYS1xgXPXhc01WTqaGy0lGyfC
   XhcUa5ln6oTbYFZwZa971MRYO328NlzyPSvHdPdI20vwPByNPuuwaseVB
   x4b2TZO62TTmVhTOz0j/I9ZUCVQLb3Ai1TotUPL7cpqNrojs3VcHn7fOJ
   YIt3pjtfbBnrclNhc809ZNolwnvNRT03FoCQ5C3PHfFB7Bi2YIxqslleI
   PWERS+id22xEANPl9I3cErv0WsvKGezVReSoDy3nY34SA/sCCdNaQACbK
   Q==;
X-CSE-ConnectionGUID: uC03/XPSQLKQmU5fkNsHmA==
X-CSE-MsgGUID: brLitjKeTl6fCVNSv5NVGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="124994"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="124994"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 04:49:55 -0700
X-CSE-ConnectionGUID: PEsEAi1rRpeC/40JCEvZ5w==
X-CSE-MsgGUID: 8f4/pnUuTQmhyfj3JsdCNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="467213"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 08 Oct 2026 04:49:53 -0700
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
Subject: [PATCH v2 net-next 13/14] selftests: drv-net: test AF_XDP zero-copy with an SKB peer
Date: Thu,  8 Oct 2026 13:49:08 +0200
Message-Id: <20261008114909.734364-14-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
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
of the test flow.

The remote is either another host over SSH or the peer port of the DUT
host in a network namespace, as on the drv-net setups that loop two
ports of one NIC back to back. With SSH, the control channel connects to
the SSH host. A namespace is reached only over the tested link, so the
control channel connects to REMOTE_V4 there and relies on the XDP
programs passing non-test traffic to the stack. The DUT TX socket fills
no RX buffers, so its zero-copy queue drops what it receives; with a
namespace remote, DUT TX cases therefore also take that queue out of RSS
so the control connection does not land on it.

Add xsk.py to TEST_PROGS and to the AF_XDP entry in MAINTAINERS, and
CONFIG_XDP_SOCKETS to the drv-net config.

Assisted-by: LLM
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 MAINTAINERS                                   |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/config |   1 +
 tools/testing/selftests/drivers/net/hw/xsk.py | 417 ++++++++++++++++++
 tools/testing/selftests/net/lib/Makefile      |   2 +-
 5 files changed, 421 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 0baa0d037c73..c170ea3267c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29778,6 +29778,7 @@ F:	include/net/xsk_buff_pool.h
 F:	include/uapi/linux/if_xdp.h
 F:	include/uapi/linux/xdp_diag.h
 F:	net/xdp/
+F:	tools/testing/selftests/drivers/net/hw/xsk.py
 F:	tools/testing/selftests/net/*xsk*
 F:	tools/testing/selftests/net/lib/xsk/
 
diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 18ce235a77f8..02e48e74f6c6 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -52,6 +52,7 @@ TEST_PROGS = \
 	uso.py \
 	vlan.py \
 	xdp_metadata.py \
+	xsk.py \
 	xsk_reconfig.py \
 	#
 
diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index c6c2b64bb712..f28335170d6b 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -26,4 +26,5 @@ CONFIG_UDMABUF=y
 CONFIG_USER_NS=y
 CONFIG_VLAN_8021Q=m
 CONFIG_VXLAN=y
+CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_USER=y
diff --git a/tools/testing/selftests/drivers/net/hw/xsk.py b/tools/testing/selftests/drivers/net/hw/xsk.py
new file mode 100755
index 000000000000..a33d4af869c7
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/xsk.py
@@ -0,0 +1,417 @@
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
+def _netns_remote(cfg):
+    return cfg.env.get("REMOTE_TYPE") == "netns"
+
+
+def _control_addr(cfg):
+    """An SSH remote is reached over its management link. A netns remote is
+    reached only over the tested link, where the XDP programs pass the
+    control connection to the stack."""
+    if _netns_remote(cfg):
+        return cfg.remote_addr_v["4"]
+    return cfg.remote.name.rpartition("@")[2]
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
+def _reserve_queue(cfg):
+    """Move the last RX queue out of default RSS and return it."""
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
+    return queue
+
+
+def _reserve_rx_queue(cfg, port):
+    """Reserve an RX queue outside RSS and steer the test UDP flow to it."""
+    queue = _reserve_queue(cfg)
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
+        # The DUT TX socket fills no RX buffers, so its zero-copy queue drops
+        # what it receives. The control connection of a netns remote shares
+        # the link, so keep that queue out of RSS.
+        queue = _reserve_queue(cfg) if _netns_remote(cfg) else 0
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
+    sync_addr = _control_addr(cfg)
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
index 15353021cecf..8e65327b8831 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -34,7 +34,7 @@ include ../../lib.mk
 
 include ../bpf.mk
 
-# AF_XDP test engine used by net/test_xsk.sh.
+# AF_XDP test engine shared by net/test_xsk.sh and drivers/net/hw/xsk.py.
 XSK_DIR := xsk
 XSK_BPF_OBJ := $(OUTPUT)/xsk_xdp_progs.bpf.o
 XSK_SKEL := $(OUTPUT)/xsk_xdp_progs.skel.h
-- 
2.43.0

