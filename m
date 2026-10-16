Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5D58B6BD;
	Fri, 16 Oct 2026 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172658; cv=none; b=SIBSI/aRDl4dvjodIQ4y7T6wcX8120s/rHoCb8o/4gWyxmV6OQzfXZLWbnpCD0uuuvj8ZSGTgj32FUaGRw+OyAlMQNQLuevFyDsoqXWuVSH+JZ2ZCMuF+WqZZo/MxY6WhPE4Jj5wG1+e8Lc5f74Q+nDbTiS74OH/wB4RE8uN+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172658; c=relaxed/simple;
	bh=YntjSzI/OW2XGeRyIFzIM9oBNlyn1DkhVlMeWVyYIMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRRLCPIFciQIlEV7a7r4cqlWO7n8GCLK23p4+h0K/q0tUewtYvw1NhpTUNK0ABAd+JrWyIQcqAUfUKmoN5AhZDMLOT7+P7gthu2OoLemO0+y5jUN3O9es7PuTnHmS5R8udzA20whc1/1GBbZ88v80o1wyWkS5FgzGgKzhl1KHrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwhxpD1u; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwhxpD1u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792172652; x=1823708652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YntjSzI/OW2XGeRyIFzIM9oBNlyn1DkhVlMeWVyYIMo=;
  b=LwhxpD1uVlbgM/1+NSNDBlB3kRCu2+T9ONn35dJiQgbtkLjIwrUcQi4A
   oCf0e2Za8KNe3d6jxoBeGrEOFIrLj7a4LyfiQOuLcD0tbc5HEz3Cc1KHW
   SMEJUDuBML7eG5VJfCbVj+uzSeqitpWk1ZdS6n8Lhimpnyh3H40Gcglo2
   gBt0/1+cGkoKySUz3bLKXhG6or/M5NkE+75GMqMhQ8bPWkjA9TjlTPwSi
   wpvXZcLiH9eqWocQO0ws+Vp1cL4MMMX+XOpQNzkXzhEWCcuo8L6lb8pcu
   5vp3bxk6v8SJPQBpJs3W01rIinF898IwdhirU7lXDfRSeNZC7WE0GEylw
   g==;
X-CSE-ConnectionGUID: yd/ej9uUQnOemnhojB7dCg==
X-CSE-MsgGUID: HsMM3HI1Rx6KRrjiXXy0rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="972377"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="972377"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 10:44:11 -0700
X-CSE-ConnectionGUID: JKm4wfCKRB6QmRBYoThS3Q==
X-CSE-MsgGUID: oxScu+5vRduJRIJk3mz9ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2425212"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2026 10:44:09 -0700
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
Subject: [PATCH v4 net-next 09/15] selftests: xsk: run one test case per xskxceiver invocation
Date: Fri, 16 Oct 2026 19:43:32 +0200
Message-Id: <20261016174338.787135-10-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace test_xsk.sh and xsk_prereqs.sh with test_xsk.py, which runs
xskxceiver once per mode and case, so that every case starts from a
fresh process and a crash fails only its own case. A single case is
also the unit that the next patch splits into RX and TX processes.

xskxceiver now requires -m and -t, runs exactly that case, reports one
KTAP result and exits with its verdict. An unsupported mode skips the
case instead of exiting with XFAIL.

test_xsk.py uses the networking selftests Python library, as does the
hardware test added later, so every case is a KTAP case of its own:
test_xsk runs each case that xskxceiver -l lists in skb and drv mode,
e.g. test_xsk.drv_SEND_RECEIVE, and test_xsk_busy_poll runs them again
with busy polling. The usual -t and -T options select cases in place of
the script's -l, -m and -t, and -v and -d go away, as the output of a
run that does not pass is logged. Each case runs on a veth pair of its
own, so an MTU or an XDP program that a crashed case leaves behind
cannot reach the next one. The pair stays in the current network
namespace, as only the initial one has the net.core.max_skb_frags
sysctl that xskxceiver reads. A case is killed and fails after 20s, so
that the run ends within the net timeout even if all cases hang.
xskxceiver is also killed if the wait for it is interrupted, and the
test skips when xskxceiver was not built.

test_xsk.py reserves 32 huge pages of 2 MiB, the size that xskxceiver
maps the UNALIGNED UMEMs with, and restores the count however the run
ends, -l and -h included. When it cannot, as without hugetlb or root,
it restores the count at once and leaves the UNALIGNED cases out. The
huge page, busy-poll and endpoint wait helpers, which the hardware
test shares, go to net/lib/py/xsk.py, which joins the AF_XDP entry in
MAINTAINERS.

test_xsk.py leaves out two cases that test_progs skipped as flaky:

- XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF: bpf_xdp_adjust_tail() frees the
  trimmed fragment as the memory type of the XDP RX queue, which veth
  and generic XDP leave at MEM_TYPE_PAGE_SHARED for frames that they
  copy into page_pool pages, so the page leaks from its pool and the
  pool's shutdown stalls
- XDP_ADJUST_TAIL_GROW: it skips in skb mode, and in drv mode veth
  copies each frame into a page_pool fragment that leaves no room to
  grow the 128-byte frames of the case unless it is the last one of its
  page, so the XDP program drops most frames

Drop the xskxceiver.c note on enabling packet dumps with -D in
test_xsk.sh; xskxceiver has no such option and dumps packets on
validation errors.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/net/Makefile          |   3 +-
 tools/testing/selftests/net/lib/Makefile      |   2 +-
 .../testing/selftests/net/lib/py/__init__.py  |   4 +
 tools/testing/selftests/net/lib/py/xsk.py     |  73 ++++++
 .../selftests/net/lib/xsk/xskxceiver.c        |  63 ++---
 tools/testing/selftests/net/test_xsk.py       | 139 +++++++++++
 tools/testing/selftests/net/test_xsk.sh       | 230 ------------------
 tools/testing/selftests/net/xsk_prereqs.sh    |  86 -------
 9 files changed, 241 insertions(+), 360 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib/py/xsk.py
 create mode 100755 tools/testing/selftests/net/test_xsk.py
 delete mode 100755 tools/testing/selftests/net/test_xsk.sh
 delete mode 100755 tools/testing/selftests/net/xsk_prereqs.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fc9eaedd744..6985a42bc09c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29784,6 +29784,7 @@ F:	include/uapi/linux/if_xdp.h
 F:	include/uapi/linux/xdp_diag.h
 F:	net/xdp/
 F:	tools/testing/selftests/net/*xsk*
+F:	tools/testing/selftests/net/lib/py/xsk.py
 F:	tools/testing/selftests/net/lib/xsk/
 
 XEN BLOCK SUBSYSTEM
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index aa31b6216dd1..8c8219703bd7 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -118,7 +118,7 @@ TEST_PROGS := \
 	test_vxlan_under_vrf.sh \
 	test_vxlan_vnifilter_notify.sh \
 	test_vxlan_vnifiltering.sh \
-	test_xsk.sh \
+	test_xsk.py \
 	tfo_passive.sh \
 	traceroute.sh \
 	txtimestamp.sh \
@@ -210,7 +210,6 @@ TEST_FILES := \
 	in_netns.sh \
 	lib.sh \
 	settings \
-	xsk_prereqs.sh \
 # end of TEST_FILES
 
 # YNL files, must be before "include ..lib.mk"
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index c26088da0489..5c1612315062 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -34,7 +34,7 @@ include ../../lib.mk
 
 include ../bpf.mk
 
-# AF_XDP test engine used by net/test_xsk.sh.
+# AF_XDP test engine used by net/test_xsk.py.
 XSK_DIR := xsk
 XSK_BPF_OBJ := $(OUTPUT)/xsk_xdp_progs.bpf.o
 XSK_SKEL := $(OUTPUT)/xsk_xdp_progs.skel.h
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 71df5880b356..1a93ab8b1e60 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -16,6 +16,8 @@ from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, rand_ports, wait_port_listen, \
     ctl_file_write, wait_file, tool, tc
 from .bpf import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
+from .xsk import xsk_reserve_hugepages, xsk_release_hugepages, \
+    xsk_setup_busy_poll, xsk_wait_endpoint_exit
 from .ynl import NlError, NlctrlFamily, YnlFamily, \
     EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily, RtnlRouteFamily
 from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
@@ -31,6 +33,8 @@ __all__ = ["KSRC",
            "bpftool", "ip", "ethtool", "bpftrace", "rand_port", "rand_ports",
            "wait_port_listen", "ctl_file_write", "wait_file", "tool", "tc",
            "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
+           "xsk_reserve_hugepages", "xsk_release_hugepages",
+           "xsk_setup_busy_poll", "xsk_wait_endpoint_exit",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
diff --git a/tools/testing/selftests/net/lib/py/xsk.py b/tools/testing/selftests/net/lib/py/xsk.py
new file mode 100644
index 000000000000..ffaf4b2d35b9
--- /dev/null
+++ b/tools/testing/selftests/net/lib/py/xsk.py
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Helpers to run xskxceiver, the AF_XDP test program in net/lib/xsk.
+"""
+
+import subprocess
+
+from .ksft import ksft_pr
+from .utils import cmd, ctl_file_write
+
+NR_HUGEPAGES = 32
+# xskxceiver maps the UMEMs of the UNALIGNED cases with MAP_HUGE_2MB.
+HUGEPAGES = "/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages"
+
+
+def xsk_reserve_hugepages(saved, host=None):
+    """Raise the count of 2 MiB huge pages on host to what the UNALIGNED
+    cases need, and return whether it has that many. Add the count to
+    restore to saved, a list for xsk_release_hugepages(), or restore it
+    right away if the host falls short. A host without the pool or the
+    rights to resize it has no huge pages for the cases."""
+    have = cmd(f"cat {HUGEPAGES}", fail=False, host=host)
+    if have.ret:
+        return False
+    have = int(have.stdout)
+    if have >= NR_HUGEPAGES:
+        return True
+    saved.append((host, have))
+    cmd(f"echo {NR_HUGEPAGES} > {HUGEPAGES}", shell=True, fail=False,
+        host=host)
+    if int(cmd(f"cat {HUGEPAGES}", host=host).stdout) >= NR_HUGEPAGES:
+        return True
+    xsk_release_hugepages([saved.pop()])
+    return False
+
+
+def xsk_release_hugepages(saved):
+    """Restore the counts that xsk_reserve_hugepages() added to saved, the
+    last one first, as two hosts can share the pool."""
+    for host, have in reversed(saved):
+        cmd(f"echo {have} > {HUGEPAGES}", shell=True, fail=False, host=host)
+
+
+def xsk_setup_busy_poll(ifname):
+    """Set napi_defer_hard_irqs and gro_flush_timeout of ifname until the
+    case ends, so that SO_PREFER_BUSY_POLL of xskxceiver -b keeps the IRQs
+    masked."""
+    sysfs = f"/sys/class/net/{ifname}"
+    ctl_file_write(f"{sysfs}/napi_defer_hard_irqs", 2)
+    ctl_file_write(f"{sysfs}/gro_flush_timeout", 200000)
+
+
+def xsk_wait_endpoint_exit(endpoint, label, timeout):
+    """Wait up to timeout seconds for xskxceiver to exit, kill it if it does
+    not or if the wait is interrupted, and return its exit code. Log its
+    output, a KTAP stream of its own, prefixed with label, only if it did
+    not pass."""
+    try:
+        endpoint.process(terminate=False, fail=False, timeout=timeout)
+    except subprocess.TimeoutExpired:
+        endpoint.proc.kill()
+        endpoint.process(terminate=False, fail=False)
+        ksft_pr(f"killed after {timeout}s", line_pfx=f"{label}|")
+    except BaseException:
+        endpoint.proc.kill()
+        endpoint.proc.wait()
+        raise
+    if endpoint.ret:
+        for out in (endpoint.stdout, endpoint.stderr):
+            if out:
+                ksft_pr(out.rstrip(), line_pfx=f"{label}|")
+    return endpoint.ret
diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
index 97eece4c57f8..b4f9cd371503 100644
--- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
+++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
@@ -6,7 +6,7 @@
  * Linux kernel samples/bpf/xdpsock* and modified
  * for use.
  *
- * See test_xsk.sh for detailed information on test topology
+ * See test_xsk.py for detailed information on test topology
  * and prerequisite network setup.
  *
  * This test program contains two threads, each thread is single socket with
@@ -64,11 +64,6 @@
  * - Tx thread Transmits a number of packets from veth<xxxx> to veth<yyyy>
  * - Rx thread verifies if all packets were received and delivered in-order,
  *   and have the right content
- *
- * Enable/disable packet dump mode:
- * --------------------------
- * To enable L2 - L4 headers and payload dump of each packet on STDOUT, add
- * parameter -D to params array in test_xsk.sh, i.e. params=("-S" "-D")
  */
 
 #define _GNU_SOURCE
@@ -169,14 +164,14 @@ static struct option long_options[] = {
 static void print_usage(char **argv)
 {
 	const char *str =
-		"  Usage: xskxceiver [OPTIONS]\n"
+		"  Usage: %s -i TX_IFACE -i RX_IFACE -m MODE -t TEST [OPTIONS]\n"
 		"  Options:\n"
 		"  -i, --interface      Use interface\n"
 		"  -v, --verbose        Verbose output\n"
 		"  -b, --busy-poll      Enable busy poll\n"
-		"  -m, --mode           Run only mode skb, drv, or zc\n"
+		"  -m, --mode           Mode to run: skb, drv or zc\n"
 		"  -l, --list           List all available tests\n"
-		"  -t, --test           Run a specific test. Enter number from -l option.\n"
+		"  -t, --test           Test case to run, a number from -l\n"
 		"  -h, --help           Display this help and exit\n";
 
 	ksft_print_msg(str, basename(argv[0]));
@@ -267,6 +262,9 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 		}
 	}
 
+	if (opt_run_test == RUN_ALL_TESTS || opt_mode == TEST_MODE_ALL)
+		print_usage(argv);
+
 	bind_iface(ifobj_tx, ifname[0], worker_testapp_validate_tx, argv);
 	bind_iface(ifobj_rx, ifname[1], worker_testapp_validate_rx, argv);
 }
@@ -365,10 +363,9 @@ int main(int argc, char **argv)
 	u32 cache_line_size, max_frags, umem_tailroom;
 	const size_t total_tests = ARRAY_SIZE(tests);
 	struct ifobject *ifobj_tx, *ifobj_rx;
-	u32 i, j, failed_tests = 0, nb_tests;
 	struct test_spec test = {};
 	int ret = TEST_FAILURE;
-	u32 caps, modes = 0;
+	u32 caps;
 
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
@@ -419,40 +416,18 @@ int main(int argc, char **argv)
 
 	caps = detect_mode_caps(ifobj_tx);
 
-	if (opt_mode != TEST_MODE_ALL && !mode_supported(opt_mode, caps)) {
+	if (!mode_supported(opt_mode, caps)) {
 		if (opt_mode == TEST_MODE_DRV)
-			ksft_print_msg("Error: XDP_DRV mode not supported.\n");
+			ksft_print_msg("XDP_DRV mode not supported.\n");
 		else
-			ksft_print_msg("Error: zero-copy mode not supported.\n");
-		ksft_exit_xfail();
+			ksft_print_msg("zero-copy mode not supported.\n");
+		ret = TEST_SKIP;
+		goto out;
 	}
 
-	for (i = TEST_MODE_SKB; i <= TEST_MODE_ZC; i++)
-		if ((opt_mode == TEST_MODE_ALL || i == opt_mode) && mode_supported(i, caps))
-			modes++;
-	if (opt_run_test == RUN_ALL_TESTS)
-		nb_tests = total_tests;
-	else
-		nb_tests = 1;
-	ksft_set_plan(modes * nb_tests);
-
-	for (i = TEST_MODE_SKB; i <= TEST_MODE_ZC; i++) {
-		if (opt_mode != TEST_MODE_ALL && i != opt_mode)
-			continue;
-		if (!mode_supported(i, caps))
-			continue;
-
-		for (j = 0; j < total_tests; j++) {
-			if (opt_run_test != RUN_ALL_TESTS && j != opt_run_test)
-				continue;
-
-			test_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
-			if (run_pkt_test(&test) == TEST_FAILURE)
-				failed_tests++;
-			usleep(USLEEP_MAX);
-		}
-	}
-	ret = failed_tests ? TEST_FAILURE : TEST_PASS;
+	ksft_set_plan(1);
+	test_init(&test, ifobj_tx, ifobj_rx, opt_mode, &tests[opt_run_test]);
+	ret = run_pkt_test(&test);
 
 out:
 	cleanup_iface(ifobj_tx);
@@ -462,6 +437,12 @@ int main(int argc, char **argv)
 	ifobject_delete(ifobj_tx);
 	ifobject_delete(ifobj_rx);
 
+	if (ret == TEST_SKIP && ksft_test_num()) {
+		ksft_print_cnts();
+		return KSFT_SKIP;
+	}
+	if (ret == TEST_SKIP)
+		ksft_exit_skip("mode not supported\n");
 	if (ret)
 		ksft_exit_fail();
 	else
diff --git a/tools/testing/selftests/net/test_xsk.py b/tools/testing/selftests/net/test_xsk.py
new file mode 100755
index 000000000000..80ac67cdebb6
--- /dev/null
+++ b/tools/testing/selftests/net/test_xsk.py
@@ -0,0 +1,139 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+r"""
+AF_XDP tests over veth.
+
+Topology:
+
+                 -----------
+               _ | Process | _
+              /  -----------  \
+             /        |        \
+            /         |         \
+      -----------     |     -----------
+      | Thread1 |     |     | Thread2 |
+      -----------     |     -----------
+           |          |          |
+      -----------     |     -----------
+      |  xskX   |     |     |  xskY   |
+      -----------     |     -----------
+           |          |          |
+      -----------     |     ----------
+      |  vethX  | --------- |  vethY |
+      -----------   peer    ----------
+
+Each case runs an xskxceiver process of its own on a veth pair that the case
+creates in the current network namespace and deletes when it ends.
+
+test_xsk runs every case that "xskxceiver -l" lists but EXCLUDED_CASES in SKB
+and DRV mode, and test_xsk_busy_poll runs them again with busy polling.
+UNALIGNED cases are left out without huge pages. Use -t or -T to select
+cases, e.g. -t 'test_xsk.drv_*'. See lib/xsk/xskxceiver.c for what each case
+tests.
+"""
+
+import random
+import re
+import sys
+from pathlib import Path
+
+from lib.py import (KsftNamedVariant, KsftSkipEx, cmd, defer, ip, ksft_eq,
+                    ksft_exit, ksft_run, ksft_variants, xsk_release_hugepages,
+                    xsk_reserve_hugepages, xsk_setup_busy_poll,
+                    xsk_wait_endpoint_exit)
+
+XSK_BIN = Path(__file__).parent / "lib/xskxceiver"
+CASE_TIMEOUT = 20
+SKIP_CODE = 4
+EXCLUDED_CASES = {
+    # bpf_xdp_adjust_tail() frees a frag that it trims off as the memory type
+    # of the XDP RX queue, which veth and generic XDP leave at
+    # MEM_TYPE_PAGE_SHARED for frames they copy into page_pool pages, so the
+    # page leaks from its pool.
+    "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF",
+    # The case skips in SKB mode. In DRV mode, veth copies each frame into a
+    # page_pool fragment that leaves no room to grow the 128-byte frames of
+    # the case unless it is the last one of its page, so the XDP program
+    # drops most frames.
+    "XDP_ADJUST_TAIL_GROW",
+}
+
+
+def _get_cases(hugepages):
+    """
+    each test case from xskxceiver -l comes out in a form below:
+    0: SEND_RECEIVE
+    """
+    ret = []
+    out = cmd([str(XSK_BIN), "-l"]).stdout
+    cases = re.findall(r"^(\d+): (\w+)$", out, re.MULTILINE)
+    for mode in ("skb", "drv"):
+        for test_id, name in cases:
+            if name in EXCLUDED_CASES:
+                continue
+            if "UNALIGNED" in name and not hugepages:
+                continue
+            ret.append(KsftNamedVariant(f"{mode}_{name}", mode, int(test_id)))
+    return ret
+
+
+def _veth_pair(busy_poll):
+    pfx = f"xsk{random.randrange(1 << 20):05x}"
+    veths = (pfx + "a", pfx + "b")
+    ip(f"link add {veths[0]} numtxqueues 4 numrxqueues 4 type veth "
+       f"peer name {veths[1]} numtxqueues 4 numrxqueues 4")
+    defer(ip, f"link del {veths[0]}")
+    for dev in veths:
+        # The XDP program redirects all traffic, keep IPv6 off the link.
+        ipv6 = Path("/proc/sys/net/ipv6/conf", dev, "disable_ipv6")
+        if ipv6.exists():
+            ipv6.write_text("1", encoding="utf-8")
+        if busy_poll:
+            xsk_setup_busy_poll(dev)
+    for dev in veths:
+        ip(f"link set {dev} up")
+    return veths
+
+
+def _start(args):
+    return cmd([str(XSK_BIN), *args], background=True, fail=False)
+
+
+def _test(mode, test_id, busy_poll):
+    tx_if, rx_if = _veth_pair(busy_poll)
+    args = ["-m", mode,
+            "-t", str(test_id),
+            *(["-b"] if busy_poll else [])]
+    ret = xsk_wait_endpoint_exit(_start(["-i", tx_if, "-i", rx_if, *args]),
+                                 "xsk", CASE_TIMEOUT)
+    if ret == SKIP_CODE:
+        raise KsftSkipEx("xskxceiver skipped the case")
+    ksft_eq(ret, 0, "xskxceiver exit code")
+
+
+def test_xsk(mode, test_id):
+    _test(mode, test_id, busy_poll=False)
+
+
+def test_xsk_busy_poll(mode, test_id):
+    _test(mode, test_id, busy_poll=True)
+
+
+def main():
+    if not XSK_BIN.exists():
+        print(f"1..0 # SKIP {XSK_BIN} was not built")
+        sys.exit(SKIP_CODE)
+    saved_hugepages = []
+    try:
+        hugepages = xsk_reserve_hugepages(saved_hugepages)
+        cases = _get_cases(hugepages)
+        ksft_run([ksft_variants(cases)(test_xsk),
+                  ksft_variants(cases)(test_xsk_busy_poll)])
+    finally:
+        xsk_release_hugepages(saved_hugepages)
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/test_xsk.sh b/tools/testing/selftests/net/test_xsk.sh
deleted file mode 100755
index fbf4551d596a..000000000000
--- a/tools/testing/selftests/net/test_xsk.sh
+++ /dev/null
@@ -1,230 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright(c) 2020 Intel Corporation, Weqaar Janjua <weqaar.a.janjua@intel.com>
-
-# AF_XDP selftests based on veth
-#
-# End-to-end AF_XDP over Veth test
-#
-# Topology:
-# ---------
-#                 -----------
-#               _ | Process | _
-#              /  -----------  \
-#             /        |        \
-#            /         |         \
-#      -----------     |     -----------
-#      | Thread1 |     |     | Thread2 |
-#      -----------     |     -----------
-#           |          |          |
-#      -----------     |     -----------
-#      |  xskX   |     |     |  xskY   |
-#      -----------     |     -----------
-#           |          |          |
-#      -----------     |     ----------
-#      |  vethX  | --------- |  vethY |
-#      -----------   peer    ----------
-#
-# AF_XDP is an address family optimized for high performance packet processing,
-# it is XDP’s user-space interface.
-#
-# An AF_XDP socket is linked to a single UMEM which is a region of virtual
-# contiguous memory, divided into equal-sized frames.
-#
-# Refer to AF_XDP Kernel Documentation for detailed information:
-# https://www.kernel.org/doc/html/latest/networking/af_xdp.html
-#
-# Prerequisites setup by script:
-#
-#   Set up veth interfaces as per the topology shown ^^:
-#   * setup two veth interfaces
-#   ** veth<xxxx>
-#   ** veth<yyyy>
-#   *** xxxx and yyyy are randomly generated 4 digit numbers used to avoid
-#       conflict with any existing interface
-#   * tests the veth and xsk layers of the topology
-#
-# See the source xskxceiver.c for information on each test
-#
-# Kernel configuration:
-# ---------------------
-# See "config" file for recommended kernel config options.
-#
-# Turn on XDP sockets and veth support when compiling i.e.
-# 	Networking support -->
-# 		Networking options -->
-# 			[ * ] XDP sockets
-#
-# Executing Tests:
-# ----------------
-# Must run with CAP_NET_ADMIN capability.
-#
-# Run:
-#   sudo ./test_xsk.sh
-#
-# If running from kselftests:
-#   sudo make run_tests
-#
-# Run with verbose output:
-#   sudo ./test_xsk.sh -v
-#
-# Set up veth interfaces and leave them up so xskxceiver can be launched in a debugger:
-#   sudo ./test_xsk.sh -d
-#
-# Run test suite in a specific mode only [skb,drv,zc]
-#   sudo ./test_xsk.sh -m MODE
-#
-# List available tests
-#   ./test_xsk.sh -l
-#
-# Run a specific test from the test suite
-#   sudo ./test_xsk.sh -t TEST_NAME
-#
-# Display the available command line options
-#   ./test_xsk.sh -h
-
-. xsk_prereqs.sh
-
-while getopts "vdm:lt:h" flag
-do
-	case "${flag}" in
-		v) verbose=1;;
-		d) debug=1;;
-		m) MODE=${OPTARG};;
-		l) list=1;;
-		t) TEST=${OPTARG};;
-		h) help=1;;
-	esac
-done
-
-if [ ! -x "./${XSKOBJ}" ]; then
-	echo "xskxceiver was not built; skipping"
-	exit $ksft_skip
-fi
-
-TEST_NAME="PREREQUISITES"
-
-URANDOM=/dev/urandom
-[ ! -e "${URANDOM}" ] && { echo "${URANDOM} not found. Skipping tests."; test_exit $ksft_fail; }
-
-VETH0_POSTFIX=$(cat ${URANDOM} | tr -dc '0-9' | fold -w 256 | head -n 1 | head --bytes 4)
-VETH0=ve${VETH0_POSTFIX}
-VETH1_POSTFIX=$(cat ${URANDOM} | tr -dc '0-9' | fold -w 256 | head -n 1 | head --bytes 4)
-VETH1=ve${VETH1_POSTFIX}
-MTU=1500
-
-trap ctrl_c INT
-
-function ctrl_c() {
-        cleanup_exit ${VETH0} ${VETH1}
-	exit 1
-}
-
-setup_vethPairs() {
-	if [[ $verbose -eq 1 ]]; then
-	        echo "setting up ${VETH0}"
-	fi
-	ip link add ${VETH0} numtxqueues 4 numrxqueues 4 type veth peer name ${VETH1} numtxqueues 4 numrxqueues 4
-	if [ -f /proc/net/if_inet6 ]; then
-		echo 1 > /proc/sys/net/ipv6/conf/${VETH0}/disable_ipv6
-		echo 1 > /proc/sys/net/ipv6/conf/${VETH1}/disable_ipv6
-	fi
-	if [[ $verbose -eq 1 ]]; then
-	        echo "setting up ${VETH1}"
-	fi
-
-	if [[ $busy_poll -eq 1 ]]; then
-	        echo 2 > /sys/class/net/${VETH0}/napi_defer_hard_irqs
-		echo 200000 > /sys/class/net/${VETH0}/gro_flush_timeout
-		echo 2 > /sys/class/net/${VETH1}/napi_defer_hard_irqs
-		echo 200000 > /sys/class/net/${VETH1}/gro_flush_timeout
-	fi
-
-	ip link set ${VETH1} mtu ${MTU}
-	ip link set ${VETH0} mtu ${MTU}
-	ip link set ${VETH1} up
-	ip link set ${VETH0} up
-}
-
-if [[ $list -eq 1 ]]; then
-        ./${XSKOBJ} -l
-        exit
-fi
-
-if [[ $help -eq 1 ]]; then
-	./${XSKOBJ}
-        exit
-fi
-
-validate_root_exec
-validate_veth_support ${VETH0}
-validate_ip_utility
-setup_vethPairs
-
-retval=$?
-if [ $retval -ne 0 ]; then
-	test_status $retval "${TEST_NAME}"
-	cleanup_exit ${VETH0} ${VETH1}
-	exit $retval
-fi
-
-
-if [[ $verbose -eq 1 ]]; then
-	ARGS+="-v "
-fi
-
-if [ -n "$MODE" ]; then
-	ARGS+="-m ${MODE} "
-fi
-
-if [ -n "$TEST" ]; then
-	ARGS+="-t ${TEST} "
-fi
-
-retval=$?
-test_status $retval "${TEST_NAME}"
-
-## START TESTS
-
-statusList=()
-
-TEST_NAME="XSK_SELFTESTS_${VETH0}_SOFTIRQ"
-
-if [[ $debug -eq 1 ]]; then
-    echo "-i" ${VETH0} "-i" ${VETH1}
-    exit
-fi
-
-exec_xskxceiver
-
-cleanup_exit ${VETH0} ${VETH1}
-
-if [[ $list -eq 1 ]]; then
-    exit
-fi
-
-TEST_NAME="XSK_SELFTESTS_${VETH0}_BUSY_POLL"
-busy_poll=1
-
-setup_vethPairs
-exec_xskxceiver
-
-## END TESTS
-
-cleanup_exit ${VETH0} ${VETH1}
-
-failures=0
-echo -e "\nSummary:"
-for i in "${!statusList[@]}"
-do
-	if [ ${statusList[$i]} -ne 0 ]; then
-	        test_status ${statusList[$i]} ${nameList[$i]}
-		failures=1
-	fi
-done
-
-if [ $failures -eq 0 ]; then
-        echo "All tests successful!"
-else
-	exit 1
-fi
diff --git a/tools/testing/selftests/net/xsk_prereqs.sh b/tools/testing/selftests/net/xsk_prereqs.sh
deleted file mode 100755
index 5e5c8ef3fff2..000000000000
--- a/tools/testing/selftests/net/xsk_prereqs.sh
+++ /dev/null
@@ -1,86 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright(c) 2020 Intel Corporation.
-
-ksft_pass=0
-ksft_fail=1
-ksft_xfail=2
-ksft_xpass=3
-ksft_skip=4
-
-XSKOBJ=lib/xskxceiver
-
-validate_root_exec()
-{
-	msg="skip all tests:"
-	if [ $UID != 0 ]; then
-		echo $msg must be run as root >&2
-		test_exit $ksft_fail
-	else
-		return $ksft_pass
-	fi
-}
-
-validate_veth_support()
-{
-	msg="skip all tests:"
-	if [ $(ip link add $1 type veth 2>/dev/null; echo $?;) != 0 ]; then
-		echo $msg veth kernel support not available >&2
-		test_exit $ksft_skip
-	else
-		ip link del $1
-		return $ksft_pass
-	fi
-}
-
-test_status()
-{
-	statusval=$1
-	if [ $statusval -eq $ksft_fail ]; then
-		echo "$2: [ FAIL ]"
-	elif [ $statusval -eq $ksft_skip ]; then
-		echo "$2: [ SKIPPED ]"
-	elif [ $statusval -eq $ksft_pass ]; then
-		echo "$2: [ PASS ]"
-	fi
-}
-
-test_exit()
-{
-	if [ $1 -ne 0 ]; then
-		test_status $1 $(basename $0)
-	fi
-	exit 1
-}
-
-clear_configs()
-{
-	[ $(ip link show $1 &>/dev/null; echo $?;) == 0 ] &&
-		{ ip link del $1; }
-}
-
-cleanup_exit()
-{
-	clear_configs $1 $2
-}
-
-validate_ip_utility()
-{
-	[ ! $(type -P ip) ] && { echo "'ip' not found. Skipping tests."; test_exit $ksft_skip; }
-}
-
-exec_xskxceiver()
-{
-        if [[ $busy_poll -eq 1 ]]; then
-	        ARGS+="-b "
-	fi
-
-	./${XSKOBJ} -i ${VETH0} -i ${VETH1} ${ARGS}
-	retval=$?
-
-	if [[ $list -ne 1 ]]; then
-	    test_status $retval "${TEST_NAME}"
-	    statusList+=($retval)
-	    nameList+=(${TEST_NAME})
-	fi
-}
-- 
2.43.0

