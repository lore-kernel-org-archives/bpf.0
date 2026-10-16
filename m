Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A399258E2C7;
	Fri, 16 Oct 2026 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172672; cv=none; b=GCFDa1lCwk6GFQPiVx4RnwhGZBWbP6UMCCRGXFN6iiyIC2BY0lHBsWze6NaMTiI93rfmn1iBZzluy5cbS4TxTVWxtgwC/JxR3jO/bjTgqvKU29g5LbGUXuOdz9YeDG9xjOchJ6aQxPSDsIOJGTdnHh3Zy6Yk88259K3FkVqzOso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172672; c=relaxed/simple;
	bh=CJHnnh9d8dTceIhYaNHooQh8LVovv3XmeN6DMoB2+7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sIp2//TsE4Pa5XfmyjzR/KR6vB3uHYH7AUVDjuI8Pyb1zdlCQ8xZwpnIuzdf595Uwe66fBVUNUeR/aCaUmUEirWcJ9d2wmBacGg4TWM1T7OIaLUZeWKw3/G6leMkhp/N+zyxvh1cwXTMrtbjwvniB5p1446MigEPDayqFK6AO+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVnObl32; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVnObl32"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792172668; x=1823708668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CJHnnh9d8dTceIhYaNHooQh8LVovv3XmeN6DMoB2+7Q=;
  b=QVnObl329SkRtkAFIC4cIjEjfp+0YbV/W7o3ZH40DYQQxJN6ghgikSmd
   wJFQlsR8dhW7pkIDeii83ui1sHdNp7iHdySoFqtTlsxyFXclNjEVk0z/u
   MnxdDVsDyHYT3ARw/7rKUnyuKCZ5szFSIlag6eseYdkPXIwCSLA/GLqGR
   yEZbfiZIZntBO6mfxvY00VFkTTu/LceSw6VYD0Zwys9ItsKY+hnYg/fKr
   59MXbFBe+T4BEPNvSu911l8p8q04PMNUZgNzIMzX3zL8ovZvDjzcP7NIW
   kNbHxiFJA8KSg2mBTtmlpNSz2VGitpLfIaF3C8qkxmnLK1Bqg7MPqn2vX
   A==;
X-CSE-ConnectionGUID: 9hoYGFUsRCuVbT1XIUScpg==
X-CSE-MsgGUID: N8xi+nijRf2XFDNj02+arQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="972412"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="972412"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 10:44:25 -0700
X-CSE-ConnectionGUID: +lZyx1AwSiadFQXJJKkIvw==
X-CSE-MsgGUID: q4gwZL+eSgC8NYW1RrkLHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2425279"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2026 10:44:23 -0700
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
Subject: [PATCH v4 net-next 14/15] selftests: drv-net: test AF_XDP zero-copy with an SKB peer
Date: Fri, 16 Oct 2026 19:43:37 +0200
Message-Id: <20261016174338.787135-15-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run the AF_XDP cases that a physical link can carry as pairs of
xskxceiver processes: a zero-copy endpoint on the DUT and an SKB-mode
endpoint on the remote, which needs no zero-copy support. xsk.py runs
the cases that xskxceiver -L lists, in the DUT directions listed with
them, as KTAP variants named <rx|tx>_<CASE>. test_xsk runs them with
the DUT socket driven by interrupts and test_xsk_busy_poll with it busy
polling, after xsk_setup_busy_poll() sets napi_defer_hard_irqs and
gro_flush_timeout on the DUT so that SO_PREFER_BUSY_POLL keeps its IRQs
masked, as on veth.

The endpoints send UDP over IPv6 if LOCAL_V6 and REMOTE_V6 are set, and
over IPv4 otherwise, each to the MAC address of its next hop to the
other: the peer's if the peer's address is on link, else the gateway's.

main() sets up what the cases share once, as defer() works only within
a case, and an ExitStack undoes it however the run ends, -l and -h
included, with each step registered as soon as it is done:

- the DUT endpoint binds the last queue with both an RX and a TX ring,
  which is taken out of RSS with ethtool -X equal; a TX endpoint fills
  no RX buffers, so in zero-copy mode its queue drops what it receives
  and TX cases need the queue out of RSS as much as RX cases do. A DUT
  with fewer than two such queues, or that cannot take one out of RSS,
  skips. ethtool -X default then hands the indirection table back to
  the driver, and the saved table is written back if it was not the
  default
- an ntuple rule on each host steers the test UDP flow to the receiving
  endpoint: the DUT queue in RX cases and queue 0 of the remote, where
  its endpoint binds, in TX cases. A host without ntuple support, or
  that rejects the rule, skips. Setting the rules once spares each TX
  case the ssh round trips of a remote rule and toggles ntuple-filters,
  which resets some NICs, once per run rather than per case
- huge pages are reserved on both hosts or on neither, and the UNALIGNED
  cases are left out without them
- both endpoints get the DUT's xdp-zc-max-segs for TOO_MANY_FRAGS,
  which is left out without multi-buffer zero-copy

A DUT that does not advertise AF_XDP zero-copy skips the run.

The remote endpoint listens on the remote address, and the DUT endpoint
connects once the remote says on stderr that it listens. The control
connection shares the tested link, where the XDP programs pass it to
the stack. Killing an ssh client does not stop the command it runs, so
timeout(1) bounds the remote endpoint, and the runner waits for it to
exit before the case ends. xskxceiver takes its numeric options as
given, so the runner checks their values before it puts them on the
command lines. The endpoints are waited for with the test_xsk.py
helpers, so the output of one that does not pass is logged, timeouts
included, and the DUT endpoint is killed if the wait for it is
interrupted. They get a traffic and link timeout of 20s, as a NIC can
take seconds to bring its link back after an MTU or XDP change.

The endpoints detach their XDP programs and restore the MTU when they
exit; the runner detaches the programs and restores the MTU only after
one fails or is killed. An endpoint that skips a case tells its peer,
which skips it too, and the case is reported as skipped unless an
endpoint fails.

The runner sizes the rings for HW_SW_MIN_RING_SIZE, a TX ring of 64
descriptors on the sender, and for HW_SW_MAX_RING_SIZE, the largest TX
ring on the sender and RX ring on the receiver, with ethtool -G, and
restores them after the case however the endpoints end. It retries
while the driver returns EBUSY, as ice does until the buffer pool of a
closed XSK socket is released, which happens in a work item. A case
skips when ethtool cannot read the rings that it sizes.

xsk.py runs the xskxceiver that net/lib builds, which drv-net already
installs, and copies it to the remote with cfg.remote.deploy(). Add
xsk.py to TEST_PROGS and to the AF_XDP entry in MAINTAINERS,
CONFIG_XDP_SOCKETS to the drivers/net/hw config, and the xskxceiver
helpers to the drivers/net/hw library exports.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 MAINTAINERS                                   |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/config |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   5 +
 tools/testing/selftests/drivers/net/hw/xsk.py | 368 ++++++++++++++++++
 tools/testing/selftests/net/lib/Makefile      |   2 +-
 .../selftests/net/lib/xsk/xskxceiver.c        |   3 +
 7 files changed, 380 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 6985a42bc09c..69c158d42877 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29783,6 +29783,7 @@ F:	include/net/xsk_buff_pool.h
 F:	include/uapi/linux/if_xdp.h
 F:	include/uapi/linux/xdp_diag.h
 F:	net/xdp/
+F:	tools/testing/selftests/drivers/net/hw/xsk.py
 F:	tools/testing/selftests/net/*xsk*
 F:	tools/testing/selftests/net/lib/py/xsk.py
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
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 4077f5f1a1be..aee6cdb4575b 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -26,6 +26,8 @@ try:
         fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, \
         wait_file, ctl_file_write, tool
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
+    from net.lib.py import xsk_reserve_hugepages, xsk_release_hugepages, \
+        xsk_setup_busy_poll, xsk_wait_endpoint_exit, xsk_wait_listen
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup, ksft_variants, KsftNamedVariant
@@ -43,6 +45,9 @@ try:
                "fd_read_timeout", "ip", "rand_port", "rand_ports",
                "wait_port_listen", "wait_file", "ctl_file_write", "tool",
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
+               "xsk_reserve_hugepages", "xsk_release_hugepages",
+               "xsk_setup_busy_poll", "xsk_wait_endpoint_exit",
+               "xsk_wait_listen",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
                "ksft_setup", "ksft_variants", "KsftNamedVariant",
diff --git a/tools/testing/selftests/drivers/net/hw/xsk.py b/tools/testing/selftests/drivers/net/hw/xsk.py
new file mode 100755
index 000000000000..dbcd687fea3d
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/xsk.py
@@ -0,0 +1,368 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+AF_XDP zero-copy tests against an SKB-mode peer.
+
+Each case runs a zero-copy xskxceiver endpoint on NETIF and an SKB-mode one
+on the remote interface. The endpoints send UDP over IPv6 if LOCAL_V6 and
+REMOTE_V6 are set, else over IPv4, each to the MAC address of its next hop
+to the other. The remote endpoint listens on a TCP control port on the
+remote address, and the DUT endpoint connects to it once the remote says on
+stderr that it listens. The control connection shares the tested link, and
+the XDP programs of both endpoints pass it to the stack.
+
+The DUT endpoint binds to the last queue and the remote endpoint to queue
+0. Before the cases run, main() takes the DUT queue out of RSS and adds an
+ntuple filter on each host that steers the test UDP flow to the queue of
+the receiving endpoint, and it undoes that however the run ends.
+
+test_xsk runs each case that "xskxceiver -L" lists, in each DUT direction
+listed with it, with the DUT endpoint driven by interrupts, and
+test_xsk_busy_poll runs them again with the DUT endpoint busy polling. The
+variant name starts with the direction of the DUT endpoint. UNALIGNED cases
+are left out without huge pages on both hosts, and TOO_MANY_FRAGS without
+multi-buffer zero-copy on the DUT.
+
+HW_SW_MIN_RING_SIZE and HW_SW_MAX_RING_SIZE expect the TX ring of the
+sending interface, and the latter also the RX ring of the receiving one, at
+given sizes. These cases set them with ethtool -G before the endpoints
+start, and restore them once the endpoints exit or get killed.
+"""
+
+import re
+import shlex
+import sys
+import time
+from contextlib import ExitStack
+
+from lib.py import (CmdExitFailure, EthtoolFamily, KsftFailEx,
+                    KsftNamedVariant, KsftSkipEx, NetdevFamily, NetDrvEpEnv,
+                    NlError, cmd, defer, ethtool, ip, ksft_eq, ksft_exit,
+                    ksft_run, ksft_variants, rand_port, xsk_release_hugepages,
+                    xsk_reserve_hugepages, xsk_setup_busy_poll,
+                    xsk_wait_endpoint_exit, xsk_wait_listen)
+
+CASE_TIMEOUT = 120
+# xskxceiver waits as long for its peer to connect.
+LISTEN_TIMEOUT = 30
+# Killing ssh leaves the remote endpoint running, so timeout(1) bounds it.
+REMOTE_TIMEOUT = LISTEN_TIMEOUT + CASE_TIMEOUT
+SKIP_CODE = 4
+# Traffic and link timeout of the endpoints, as a NIC can take seconds to
+# bring its link back after an MTU or XDP change.
+XSK_TIMEOUT = 20
+# The TX ring of the sender and the RX ring of the receiver that a case
+# needs at a given size, 64 being the default batch size of xskxceiver.
+RING_SIZES = {
+    "HW_SW_MIN_RING_SIZE": {"tx": 64},
+    "HW_SW_MAX_RING_SIZE": {"tx": "max", "rx": "max"},
+}
+RING_BUSY_TIMEOUT = 5
+
+
+def _get_cases(cfg):
+    """
+    each test case from xskxceiver -L comes out in a form below:
+    0: SEND_RECEIVE rx
+    0: SEND_RECEIVE tx
+    """
+    ret = []
+    out = cmd([str(cfg.bin_local), "-L"]).stdout
+    cases = re.findall(r"^(\d+): (\w+) (rx|tx)$", out, re.MULTILINE)
+    for test_id, name, direction in cases:
+        if "UNALIGNED" in name and not cfg.hugepages:
+            continue
+        if "TOO_MANY_FRAGS" in name and cfg.max_frags <= 1:
+            continue
+        ret.append(KsftNamedVariant(f"{direction}_{name}", direction,
+                                    int(test_id), name))
+    return ret
+
+
+def _restore_rss(cfg, indir):
+    """Restore the RSS indirection table of the DUT. Reset it to the default
+    first, which leaves it to the driver again, and write indir back only if
+    it was not the default."""
+    ethtool(f"-X {cfg.ifname} default")
+    req = {"header": {"dev-index": cfg.ifindex}}
+    if cfg.ethnl.rss_get(req).get("indir") != indir:
+        cfg.ethnl.rss_set({**req, "indir": indir})
+
+
+def _reserve_queue(cfg, undo):
+    """Take the last queue with both an RX and a TX ring out of RSS until
+    undo, return None if the DUT cannot. A TX endpoint fills no RX buffers,
+    so in zero-copy mode its queue drops what it receives, the control
+    connection included."""
+    req = {"header": {"dev-index": cfg.ifindex}}
+    try:
+        ch = cfg.ethnl.channels_get(req)
+        rss = cfg.ethnl.rss_get(req)
+    except NlError:
+        print(f"1..0 # SKIP cannot get the channels or RSS of {cfg.ifname}")
+        return None
+    count = ch.get("combined-count", 0) + min(ch.get("rx-count", 0),
+                                              ch.get("tx-count", 0))
+    if count < 2:
+        print("1..0 # SKIP Test requires NETIF with at least 2 channels")
+        return None
+    queue = count - 1
+    if cmd(f"ethtool -X {cfg.ifname} equal {queue}", fail=False).ret:
+        print(f"1..0 # SKIP {cfg.ifname} cannot take queue {queue} out of RSS")
+        return None
+    undo.callback(_restore_rss, cfg, rss.get("indir"))
+    return queue
+
+
+def _steer_udp(cfg, undo, ifname, queue, host=None):
+    """Steer the test flow to queue until undo, return False if ifname
+    cannot."""
+    ntuple = ethtool(f"-k {ifname}", json=True, host=host)[0]["ntuple-filters"]
+    if not ntuple["active"]:
+        if ntuple["fixed"]:
+            print(f"1..0 # SKIP {ifname} does not support ntuple-filters")
+            return False
+
+        ethtool(f"-K {ifname} ntuple-filters on", host=host)
+        undo.callback(ethtool, f"-K {ifname} ntuple-filters off", host=host)
+
+    res = cmd(f"ethtool -N {ifname} flow-type udp{cfg.addr_ipver} "
+              f"dst-port {cfg.udp_port} action {queue}", host=host, fail=False)
+    if res.ret:
+        print(f"1..0 # SKIP {ifname} rejects the ntuple rule")
+        return False
+    rule = re.search(r"ID (\d+)", res.stdout).group(1)
+    undo.callback(ethtool, f"-N {ifname} delete {rule}", host=host)
+    return True
+
+
+def _next_hop_mac(cfg, addr, peer_mac, ifname, host=None):
+    """Return the MAC address that host sends packets for addr to: peer_mac
+    if addr is on link, else the MAC address of the gateway."""
+    route = ip(f"-{cfg.addr_ipver} route get {addr}", json=True,
+               host=host)[0]
+    gw = route.get("gateway")
+    if not gw:
+        return peer_mac
+
+    # Resolve the gateway, from ifname as an IPv6 one is likely link-local.
+    # The ping only triggers ARP or ND, so the gateway may ignore it.
+    cmd(f"ping -c1 -W1 -I{ifname} {gw}", host=host, fail=False)
+    # Unlike "neigh get", "neigh show" has JSON output in older iproute2.
+    neigh = ip(f"neigh show {gw} dev {ifname}", json=True, host=host)
+    if not neigh or "lladdr" not in neigh[0]:
+        raise KsftFailEx(f"cannot resolve the MAC address of gateway {gw}")
+    return neigh[0]["lladdr"]
+
+
+def _set_ring(ifname, ring, size, host=None):
+    """Set a ring of ifname with ethtool -G. A driver can refuse that while
+    an XSK socket that just closed still holds a queue, as ice does until a
+    work item releases the buffer pool of the socket, so retry for a while."""
+    deadline = time.monotonic() + RING_BUSY_TIMEOUT
+    while True:
+        res = cmd(f"ethtool -G {ifname} {ring} {size}", host=host, fail=False)
+        if res.ret == 0:
+            return
+        if "Device or resource busy" not in res.stderr or \
+           time.monotonic() > deadline:
+            raise CmdExitFailure("Command failed", res)
+        time.sleep(0.1)
+
+
+def _size_rings(cfg, name, direction):
+    """Set the rings that case name needs, and restore them after it."""
+    for ring, size in RING_SIZES[name].items():
+        # The DUT endpoint sends for tx, and receives for rx.
+        if ring == direction:
+            host, ifname = None, cfg.ifname
+        else:
+            host, ifname = cfg.remote, cfg.remote_ifname
+        try:
+            cur = ethtool(f"-g {ifname}", json=True, host=host)[0]
+        except CmdExitFailure:
+            cur = {}
+        if ring not in cur:
+            raise KsftSkipEx(f"cannot read the {ring} ring size of {ifname}")
+        if size == "max":
+            size = cur[f"{ring}-max"]
+        if cur[ring] == size:
+            continue
+        _set_ring(ifname, ring, size, host)
+        defer(_set_ring, ifname, ring, cur[ring], host)
+
+
+def _setup(cfg, name, direction, busy_poll):
+    for link in (cfg.dev, cfg.remote_dev):
+        if "xdp" in link:
+            raise KsftSkipEx(f"{link['ifname']} already has an XDP program")
+    if busy_poll:
+        xsk_setup_busy_poll(cfg.ifname)
+    if "RING_SIZE" in name:
+        _size_rings(cfg, name, direction)
+
+    # Defers run in reverse, so the XDP programs, which can cap the MTU, go
+    # first.
+    fallbacks = [
+        defer(ip, f"link set dev {cfg.ifname} mtu {cfg.dev['mtu']}"),
+        defer(ip, f"link set dev {cfg.remote_ifname} "
+                  f"mtu {cfg.remote_dev['mtu']}", host=cfg.remote),
+        defer(ip, f"link set dev {cfg.ifname} xdpdrv off"),
+        defer(ip, f"link set dev {cfg.remote_ifname} xdpgeneric off",
+              host=cfg.remote),
+    ]
+    return fallbacks
+
+
+def _check_opt(opt, val, low, high):
+    """xskxceiver takes its numeric options as given, so check that val, the
+    value of opt, is in low-high before it is passed on."""
+    if not low <= val <= high:
+        raise ValueError(f"xskxceiver {opt} {val} is not in {low}-{high}")
+
+
+def _fixup_args(cfg, test_id, ctrl_port):
+    cfg.args[cfg.args.index("-t") + 1] = str(test_id)
+    cfg.args[cfg.args.index("-P") + 1] = str(ctrl_port)
+
+
+def _run(cfg, local_args, remote_args, ctrl_port):
+    """Start the remote endpoint, and the DUT one once the remote listens.
+    Return their exit codes, None for a DUT endpoint that did not start."""
+    remote = cmd(shlex.join(remote_args), host=cfg.remote, background=True,
+                 fail=False)
+    head = ""
+    dut_ret = None
+    try:
+        head, listening = xsk_wait_listen(remote, ctrl_port, LISTEN_TIMEOUT)
+        if listening:
+            local = cmd(local_args, background=True, fail=False)
+            dut_ret = xsk_wait_endpoint_exit(local, "dut", CASE_TIMEOUT)
+    finally:
+        # Even if the DUT endpoint did not run, so that the remote one is
+        # gone before the next case starts.
+        remote_ret = xsk_wait_endpoint_exit(remote, "remote", REMOTE_TIMEOUT,
+                                            head)
+    return dut_ret, remote_ret
+
+
+def _test(cfg, direction, test_id, name, busy_poll):
+    ctrl_port = rand_port()
+    _check_opt("-P", ctrl_port, 1, 0xffff)
+
+    fallbacks = _setup(cfg, name, direction, busy_poll)
+    _fixup_args(cfg, test_id, ctrl_port)
+
+    remote = [*cfg.remote_args,
+              "-e", "tx" if direction == "rx" else "rx",
+              *cfg.args]
+    local = [*cfg.local_args,
+             "-e", direction,
+             *(["-b"] if busy_poll else []),
+             *cfg.args]
+
+    dut_ret, remote_ret = _run(cfg, local, remote, ctrl_port)
+    if dut_ret is None:
+        raise KsftFailEx(f"remote endpoint did not listen on port {ctrl_port}")
+    rets = {dut_ret, remote_ret}
+    if rets <= {0, SKIP_CODE}:
+        # Both endpoints detached their XDP programs and restored the MTU.
+        for fallback in fallbacks:
+            fallback.cancel()
+    # An endpoint that skips the case tells its peer, which skips it too.
+    if SKIP_CODE in rets and rets <= {0, SKIP_CODE}:
+        raise KsftSkipEx("xskxceiver skipped the case")
+    ksft_eq(dut_ret, 0, "DUT endpoint exit code")
+    ksft_eq(remote_ret, 0, "remote endpoint exit code")
+
+
+def test_xsk(cfg, direction, test_id, name):
+    _test(cfg, direction, test_id, name, busy_poll=False)
+
+
+def test_xsk_busy_poll(cfg, direction, test_id, name):
+    _test(cfg, direction, test_id, name, busy_poll=True)
+
+
+def main():
+    # defer() works only within a case, so undo restores what main() sets up
+    # for all of them, however the run ends.
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg, ExitStack() as undo:
+        cfg.bin_local = cfg.net_lib_dir / "xskxceiver"
+        if not cfg.bin_local.exists():
+            print(f"1..0 # SKIP {cfg.bin_local} was not built")
+            sys.exit(SKIP_CODE)
+
+        cfg.ethnl = EthtoolFamily()
+        cfg.netnl = NetdevFamily()
+
+        dev = cfg.netnl.dev_get({"ifindex": cfg.ifindex})
+        if "xsk-zerocopy" not in dev["xdp-features"]:
+            print("1..0 # SKIP NIC does not advertise AF_XDP zero-copy")
+            sys.exit(SKIP_CODE)
+
+        cfg.max_frags = dev.get("xdp-zc-max-segs", 1)
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+
+        local_dmac = _next_hop_mac(cfg, cfg.remote_addr,
+                                   cfg.remote_dev["address"], cfg.ifname)
+        remote_dmac = _next_hop_mac(cfg, cfg.addr, cfg.dev["address"],
+                                    cfg.remote_ifname, cfg.remote)
+
+        cfg.queue = _reserve_queue(cfg, undo)
+        if cfg.queue is None:
+            sys.exit(SKIP_CODE)
+
+        cfg.udp_port = rand_port()
+        steered = (_steer_udp(cfg, undo, cfg.ifname, cfg.queue) and
+                   _steer_udp(cfg, undo, cfg.remote_ifname, 0, cfg.remote))
+        if not steered:
+            sys.exit(SKIP_CODE)
+
+        saved_hugepages = []
+        undo.callback(xsk_release_hugepages, saved_hugepages)
+        cfg.hugepages = (xsk_reserve_hugepages(saved_hugepages) and
+                         xsk_reserve_hugepages(saved_hugepages, cfg.remote))
+        if not cfg.hugepages:
+            xsk_release_hugepages(saved_hugepages)
+            saved_hugepages.clear()
+
+        cases = _get_cases(cfg)
+
+        _check_opt("--max-frags", cfg.max_frags, 1, 0xffff)
+        _check_opt("--udp-port", cfg.udp_port, 1, 0xffff)
+        _check_opt("--timeout", XSK_TIMEOUT, 1, 0xffff)
+        _check_opt("--queue", cfg.queue, 0, 0xffffffff)
+
+        # _fixup_args() sets the options that differ between the cases.
+        cfg.args = ["-p", cfg.remote_addr,
+                    "--max-frags", str(cfg.max_frags),
+                    "--udp-port", str(cfg.udp_port),
+                    "--timeout", str(XSK_TIMEOUT),
+                    "-t", "0",
+                    "-P", "0"]
+        cfg.remote_args = ["timeout", str(REMOTE_TIMEOUT),
+                           str(cfg.bin_remote),
+                           "-i", cfg.remote_ifname,
+                           "-m", "skb",
+                           "--listen",
+                           "--queue", "0",
+                           "--src-ip", cfg.remote_addr,
+                           "--dst-ip", cfg.addr,
+                           "--dst-mac", remote_dmac]
+        cfg.local_args = [str(cfg.bin_local),
+                          "-i", cfg.ifname,
+                          "-m", "zc",
+                          "--queue", str(cfg.queue),
+                          "--src-ip", cfg.addr,
+                          "--dst-ip", cfg.remote_addr,
+                          "--dst-mac", local_dmac]
+
+        ksft_run([ksft_variants(cases)(test_xsk),
+                  ksft_variants(cases)(test_xsk_busy_poll)], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index 49dac776202b..c2524cacffd3 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -34,7 +34,7 @@ include ../../lib.mk
 
 include ../bpf.mk
 
-# AF_XDP test engine used by net/test_xsk.py.
+# AF_XDP test engine shared by net/test_xsk.py and drivers/net/hw/xsk.py.
 XSK_DIR := xsk
 XSK_BPF_OBJ := $(OUTPUT)/xsk_xdp_progs.bpf.o
 XSK_SKEL := $(OUTPUT)/xsk_xdp_progs.skel.h
diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
index c52e3e376bc5..a4a66c9ebde2 100644
--- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
+++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
@@ -55,6 +55,9 @@
  *    l. If multi-buffer is supported, try various nasty combinations of descriptors to
  *       check if they pass the validation or not
  *
+ * drivers/net/hw/xsk.py runs the hardware cases on a physical device in
+ * zero-copy mode, with an SKB-mode peer on a remote host.
+ *
  * Flow:
  * -----
  * - test_xsk.py starts two processes: Tx and Rx
-- 
2.43.0

