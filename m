Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26F56C654;
	Wed, 14 Oct 2026 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003582; cv=none; b=dwqxsv1zIBBD3OgcUDRvmwKCJSfxDibUey+0j0D/Iswfe4e1X1fy7hz7pSsoloIv8GeQnI2Oy3u3j4HIh/jfMKJGqLMd+MspyntaE8nWj0+F5D5I02U9afYoonGNwZqlA4VSO0hI6IAUe8Fkt8gNCngZsUPaHTJlNHEOxmgWBOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003582; c=relaxed/simple;
	bh=freynhT4vQyIUmxLc1f6goeJAooDBW3T9tkCsXCU+KM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YqUYlQUDvip/HF6gF3NZWZQWNk5dkRI9FOSIh3lY8Ko1CdcjAd3x83VJ2h8XegenIp2eXcOBiq1Q5bpCY/UdEGN6OF+Nh7FqRg6NVaHITDBFbJ3x+tDgYQWLEQen06bDHM1Cc+N5gEIP9ZYEMGUNAwQE+kY64ptuiCNhPmmQgu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKazYuAA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKazYuAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792003580; x=1823539580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=freynhT4vQyIUmxLc1f6goeJAooDBW3T9tkCsXCU+KM=;
  b=WKazYuAAIAjSrZFcRC8H4f40WRS9evD2QybE+O1tFDxt23nSq7UNRzjV
   1/V8OxRawDyrdtJVQbJ6eBRi1jtmlKsARA5yZF2/Xr/9TphBnjd86Cn77
   SHL4XwUHYckhOVKgac40MvG+TmCjbtyfWKqECRNAz1ZoNaGX9bltes8dt
   OWc3qpLt53rYJwK+PL2p6XuseuvoZ0IRLIkaPpJZdj6xiwibzcun8O4T5
   wp6K3VYeEse642/wo2OSsJbFTT0xtKwXcF/9AtVYjcqKyIBUzWXW7qa/R
   ysB9bA2vjDhKAaWOo1rkxZ8dRPW1DYZV4ORMx3MVW6UpjtjFSo+4aACHw
   A==;
X-CSE-ConnectionGUID: 7xjhGBscSjaDnK1a2Ki4OQ==
X-CSE-MsgGUID: UCzt18GwQRuOkL3JaUT23w==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="767336"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="767336"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 11:46:20 -0700
X-CSE-ConnectionGUID: BiYBHUTxQkO72p/1SAbKJA==
X-CSE-MsgGUID: vCZXD8WDRqSkmRuTX1sg0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1420799"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:46:17 -0700
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
Subject: [PATCH v3 net-next 10/15] selftests: xsk: run the RX and TX endpoints in separate processes
Date: Wed, 14 Oct 2026 20:45:34 +0200
Message-Id: <20261014184539.774708-11-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run the two endpoints of a test case as separate xskxceiver processes,
so that a later patch can run them on two hosts. A process binds only
the interface given with -i, takes its role from -e rx|tx and meets the
other endpoint over a small TCP control channel (-p HOST -P PORT). The
other side is represented by a shadow ifobject that mirrors the local
capabilities and holds a loaded copy of the XDP skeleton, so the shared
test code keeps addressing both sides while only the local interface is
programmed. Once BIDIRECTIONAL swaps the directions, the local
interface runs the shadow's programs.

The pthreads, the barrier, test->fail and -lpthread go away. Each
process runs the worker of its local ifobject, and the endpoints
exchange three fixed-size messages:

- READY, exchanged before each step, works as a barrier; TCP ordering
  puts all progress of the previous step before it
- PROGRESS carries the number of packets RX consumed, which TX
  subtracts from its in-flight count so as not to overrun the RX UMEM
- ABORT tells the other endpoint to stop waiting after a failure

TX listens and RX connects. The listener says on stderr when it
listens, so the launcher starts the connector then rather than polling
for the port, which could also find a foreign listener. The listener
waits 30s for the connector, and -P takes a port number. As with the
control channels of other selftests, the hosts are trusted and the
channel is not authenticated. Test selection, interface capabilities
and verdicts stay with the launcher.

test_xsk.py starts TX on a random control port on 127.0.0.1 and RX
once TX listens, and kills TX and fails the case when it does not
listen within 30s. The case passes when both endpoints pass, and is
skipped when one skips and neither fails. Only the output of an
endpoint that does not pass is logged, prefixed with its role.
xsk_wait_listen(), which reads the TX stderr up to the listen line,
joins the library helpers, and xsk_wait_endpoint_exit() logs that
output along with the rest.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/net/lib/Makefile      |   3 +-
 .../testing/selftests/net/lib/py/__init__.py  |   4 +-
 tools/testing/selftests/net/lib/py/xsk.py     |  35 ++-
 .../testing/selftests/net/lib/xsk/test_xsk.c  | 205 +++++++-----
 .../testing/selftests/net/lib/xsk/test_xsk.h  |  23 +-
 .../testing/selftests/net/lib/xsk/xsk_peer.c  | 293 ++++++++++++++++++
 .../testing/selftests/net/lib/xsk/xsk_peer.h  |  19 ++
 .../selftests/net/lib/xsk/xskxceiver.c        | 136 ++++++--
 tools/testing/selftests/net/test_xsk.py       |  68 ++--
 9 files changed, 633 insertions(+), 153 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib/xsk/xsk_peer.c
 create mode 100644 tools/testing/selftests/net/lib/xsk/xsk_peer.h

diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index 5c1612315062..49dac776202b 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -38,13 +38,12 @@ include ../bpf.mk
 XSK_DIR := xsk
 XSK_BPF_OBJ := $(OUTPUT)/xsk_xdp_progs.bpf.o
 XSK_SKEL := $(OUTPUT)/xsk_xdp_progs.skel.h
-XSK_SOURCES := $(addprefix $(XSK_DIR)/,xskxceiver.c xsk.c test_xsk.c) \
+XSK_SOURCES := $(addprefix $(XSK_DIR)/,xskxceiver.c xsk.c test_xsk.c xsk_peer.c) \
 	$(top_srcdir)/tools/lib/find_bit.c
 XSK_HEADERS := $(wildcard $(XSK_DIR)/*.h)
 
 PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
 XSK_LDLIBS := $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf) -lz
-XSK_LDLIBS += -lpthread
 
 $(XSK_BPF_OBJ): $(XSK_DIR)/xsk_xdp_progs.bpf.c $(XSK_DIR)/xsk_xdp_common.h $(BPFOBJ)
 	$(call msg,BPF_PROG,,$@)
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 1a93ab8b1e60..a82bac8a6b47 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -17,7 +17,7 @@ from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     ctl_file_write, wait_file, tool, tc
 from .bpf import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
 from .xsk import xsk_reserve_hugepages, xsk_release_hugepages, \
-    xsk_setup_busy_poll, xsk_wait_endpoint_exit
+    xsk_setup_busy_poll, xsk_wait_endpoint_exit, xsk_wait_listen
 from .ynl import NlError, NlctrlFamily, YnlFamily, \
     EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily, RtnlRouteFamily
 from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
@@ -34,7 +34,7 @@ __all__ = ["KSRC",
            "wait_port_listen", "ctl_file_write", "wait_file", "tool", "tc",
            "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
            "xsk_reserve_hugepages", "xsk_release_hugepages",
-           "xsk_setup_busy_poll", "xsk_wait_endpoint_exit",
+           "xsk_setup_busy_poll", "xsk_wait_endpoint_exit", "xsk_wait_listen",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
diff --git a/tools/testing/selftests/net/lib/py/xsk.py b/tools/testing/selftests/net/lib/py/xsk.py
index 50985bcb5b80..6f4ffc4786d2 100644
--- a/tools/testing/selftests/net/lib/py/xsk.py
+++ b/tools/testing/selftests/net/lib/py/xsk.py
@@ -5,9 +5,10 @@ Helpers to run xskxceiver, the AF_XDP test program in net/lib/xsk.
 """
 
 import subprocess
+import time
 
 from .ksft import ksft_pr
-from .utils import cmd, ctl_file_write
+from .utils import cmd, ctl_file_write, fd_read_timeout
 
 NR_HUGEPAGES = 32
 
@@ -41,10 +42,32 @@ def xsk_setup_busy_poll(ifname):
     ctl_file_write(f"{sysfs}/gro_flush_timeout", 200000)
 
 
-def xsk_wait_endpoint_exit(endpoint, label, timeout):
-    """Wait up to timeout seconds for xskxceiver to exit, kill it if it does
-    not, and return its exit code. Log its output, a KTAP stream of its own,
-    prefixed with label, only if it did not pass."""
+def xsk_wait_listen(endpoint, port, timeout):
+    """Wait up to timeout seconds for an xskxceiver endpoint to print on
+    stderr that it listens on the control port. Unlike polling for the port,
+    this never takes a foreign listener for it and costs no SSH login per
+    try on a remote host. Return the stderr read so far and whether that
+    line came."""
+    line = f"Listening for XSK peer on port {port}\n".encode()
+    fd = endpoint.proc.stderr.fileno()
+    head = b""
+    deadline = time.monotonic() + timeout
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
+def xsk_wait_endpoint_exit(endpoint, label, timeout, head=""):
+    """Wait up to timeout seconds for an xskxceiver endpoint to exit, kill it
+    if it does not, and return its exit code. Log its output, a KTAP stream
+    of its own, prefixed with label, only if it did not pass. head is the
+    start of its stderr, if xsk_wait_listen() took it off the pipe."""
     try:
         endpoint.process(terminate=False, fail=False, timeout=timeout)
     except subprocess.TimeoutExpired:
@@ -52,7 +75,7 @@ def xsk_wait_endpoint_exit(endpoint, label, timeout):
         endpoint.process(terminate=False, fail=False)
         ksft_pr(f"killed after {timeout}s", line_pfx=f"{label}|")
     if endpoint.ret:
-        for out in (endpoint.stdout, endpoint.stderr):
+        for out in (endpoint.stdout, head + endpoint.stderr):
             if out:
                 ksft_pr(out.rstrip(), line_pfx=f"{label}|")
     return endpoint.ret
diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
index e4e0d4dfab5a..f67a32c0260a 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
@@ -7,7 +7,6 @@
 #include <linux/mman.h>
 #include <linux/netdev.h>
 #include <poll.h>
-#include <pthread.h>
 #include <string.h>
 #include <sys/mman.h>
 #include <sys/socket.h>
@@ -15,6 +14,7 @@
 #include <unistd.h>
 
 #include "test_xsk.h"
+#include "xsk_peer.h"
 #include "xsk_xdp_common.h"
 #include "xsk_xdp_progs.skel.h"
 
@@ -38,10 +38,37 @@
 static const u8 g_mac[ETH_ALEN] = {0x55, 0x44, 0x33, 0x22, 0x11, 0x00};
 
 bool opt_verbose;
-pthread_barrier_t barr;
-pthread_mutex_t pacing_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 int pkts_in_flight;
+static struct xsk_peer *ctrl_peer;
+
+void xsk_set_endpoint(struct xsk_peer *peer)
+{
+	ctrl_peer = peer;
+}
+
+static int pacing_rx_progress(u32 pkts)
+{
+	int err = xsk_peer_rx_progress(ctrl_peer, pkts);
+
+	if (err)
+		ksft_print_msg("RX control channel failed: %d (%s)\n", err,
+			       strerror(-err));
+	return err;
+}
+
+static int pacing_tx_sync(void)
+{
+	int acked = xsk_peer_tx_sync(ctrl_peer);
+
+	if (acked < 0) {
+		ksft_print_msg("TX control channel failed: %d (%s)\n", acked,
+			       strerror(-acked));
+		return acked;
+	}
+	pkts_in_flight -= acked;
+	return 0;
+}
 
 /* The payload is a word consisting of a packet sequence number in the upper
  * 16-bits and a intra packet data sequence number in the lower 16 bits. So the 3rd packet's
@@ -256,7 +283,8 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 		ifobj->xsk->umem->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
 	}
 
-	if (ifobj_has_cap(ifobj_tx, XSK_CAP_HW_RING))
+	if (ifobj_has_cap(ifobj_tx, XSK_CAP_HW_RING) &&
+	    ifobj_is_local(ifobj_tx))
 		hw_ring_size_reset(ifobj_tx);
 
 	test->ifobj_tx = ifobj_tx;
@@ -264,7 +292,6 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 	test->current_step = 0;
 	test->total_steps = 1;
 	test->nb_sockets = 1;
-	test->fail = false;
 	test->set_ring = false;
 	test->adjust_tail = false;
 	test->adjust_tail_support = false;
@@ -332,26 +359,31 @@ static void test_spec_set_xdp_prog(struct test_spec *test, struct bpf_program *x
 	test->xskmap_tx = xskmap_tx;
 }
 
-static int test_spec_set_mtu(struct test_spec *test, int mtu)
+static int test_spec_set_mtu_ifobj(struct ifobject *ifobj, int mtu)
 {
 	int err;
 
-	if (test->ifobj_rx->mtu != mtu) {
-		err = xsk_set_mtu(test->ifobj_rx->ifindex, mtu);
+	if (ifobj_is_local(ifobj) && ifobj->mtu != mtu) {
+		err = xsk_set_mtu(ifobj->ifindex, mtu);
 		if (err)
 			return err;
-		test->ifobj_rx->mtu = mtu;
-	}
-	if (test->ifobj_tx->mtu != mtu) {
-		err = xsk_set_mtu(test->ifobj_tx->ifindex, mtu);
-		if (err)
-			return err;
-		test->ifobj_tx->mtu = mtu;
 	}
 
+	ifobj->mtu = mtu;
 	return 0;
 }
 
+static int test_spec_set_mtu(struct test_spec *test, int mtu)
+{
+	int err;
+
+	err = test_spec_set_mtu_ifobj(test->ifobj_rx, mtu);
+	if (err)
+		return err;
+
+	return test_spec_set_mtu_ifobj(test->ifobj_tx, mtu);
+}
+
 void pkt_stream_reset(struct pkt_stream *pkt_stream)
 {
 	if (pkt_stream) {
@@ -1001,6 +1033,9 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 	fds.fd = xsk_socket__fd(xsk->xsk);
 	fds.events = POLLIN;
 
+	if (pacing_rx_progress(0))
+		return TEST_FAILURE;
+
 	ret = kick_rx(xsk);
 	if (ret)
 		return TEST_FAILURE;
@@ -1100,9 +1135,8 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 	if (ifobj->release_rx)
 		xsk_ring_cons__release(&xsk->rx, frags_processed);
 
-	pthread_mutex_lock(&pacing_mutex);
-	pkts_in_flight -= pkts_sent;
-	pthread_mutex_unlock(&pacing_mutex);
+	if (pacing_rx_progress(pkts_sent))
+		return TEST_FAILURE;
 	pkts_sent = 0;
 
 	return TEST_CONTINUE;
@@ -1178,9 +1212,18 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 	int ret;
 
 	buffer_len = pkt_get_buffer_len(umem, pkt_stream->max_pkt_len);
+	if (pacing_tx_sync())
+		return TEST_FAILURE;
+
 	/* pkts_in_flight might be negative if many invalid packets are sent */
 	if (pkts_in_flight >= (int)((umem_size(umem) - xsk->batch_size * buffer_len) /
 	    buffer_len) && !test_timeout) {
+		/* Only RX progress reports can lower pkts_in_flight. */
+		if (xsk_peer_closed(ctrl_peer)) {
+			ksft_print_msg("ERROR: [%s] RX exited with %d packets in flight\n",
+				       __func__, pkts_in_flight);
+			return TEST_FAILURE;
+		}
 		ret = kick_tx(xsk);
 		if (ret)
 			return TEST_FAILURE;
@@ -1262,9 +1305,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 		valid_frags += nb_frags;
 	}
 
-	pthread_mutex_lock(&pacing_mutex);
 	pkts_in_flight += valid_pkts;
-	pthread_mutex_unlock(&pacing_mutex);
 
 	xsk_ring_prod__submit(&xsk->tx, i);
 	xsk->outstanding_tx += valid_frags;
@@ -1341,9 +1382,6 @@ static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 			if (ret != TEST_CONTINUE)
 				return ret;
 
-			if (test->fail)
-				return TEST_FAILURE;
-
 			if (!test->poll_tmout) {
 				ret = wait_for_tx_completion(&ifobject->xsk_arr[i]);
 				if (ret)
@@ -1665,36 +1703,57 @@ static int testapp_validate_rx_endpoint(struct test_spec *test,
 	return err;
 }
 
-void *worker_testapp_validate_tx(void *arg)
+static int sync_endpoints(struct test_spec *test)
+{
+	int err = xsk_peer_ready(ctrl_peer);
+
+	if (err)
+		ksft_print_msg("Endpoint synchronization failed at step %u: %d (%s)\n",
+			       test->current_step, err, strerror(-err));
+	return err;
+}
+
+int worker_testapp_validate_tx(struct test_spec *test)
 {
-	struct test_spec *test = (struct test_spec *)arg;
 	int err;
 
-	err = testapp_validate_tx_endpoint(test, test->ifobj_tx);
+	err = sync_endpoints(test);
 	if (err)
-		test->fail = true;
+		return err;
 
-	pthread_exit(NULL);
+	err = testapp_validate_tx_endpoint(test, test->ifobj_tx);
+	if (err) {
+		ksft_print_msg("TX endpoint traffic failed at step %u: %d\n",
+			       test->current_step, err);
+		xsk_peer_abort(ctrl_peer);
+	}
+	return err;
 }
 
-void *worker_testapp_validate_rx(void *arg)
+int worker_testapp_validate_rx(struct test_spec *test)
 {
-	struct test_spec *test = (struct test_spec *)arg;
 	struct ifobject *ifobject = test->ifobj_rx;
 	int err;
 
 	err = testapp_prepare_rx_endpoint(test, ifobject);
+	if (err) {
+		ksft_print_msg("RX endpoint setup failed at step %u: %d\n",
+			       test->current_step, err);
+		xsk_peer_abort(ctrl_peer);
+		return err;
+	}
 
-	if (test->use_barrier)
-		pthread_barrier_wait(&barr);
-
-	/* We leave only now in case of error to avoid getting stuck in the barrier */
-	if (!err)
-		err = testapp_validate_rx_endpoint(test, ifobject);
+	err = sync_endpoints(test);
 	if (err)
-		test->fail = true;
+		return err;
 
-	pthread_exit(NULL);
+	err = testapp_validate_rx_endpoint(test, ifobject);
+	if (err) {
+		ksft_print_msg("RX endpoint traffic failed at step %u: %d\n",
+			       test->current_step, err);
+		xsk_peer_abort(ctrl_peer);
+	}
+	return err;
 }
 
 static void testapp_clean_xsk_umem(struct ifobject *ifobj)
@@ -1749,13 +1808,13 @@ static int xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_r
 {
 	int err = 0;
 
-	if (xdp_prog_changed_rx(test)) {
+	if (ifobj_is_local(ifobj_rx) && xdp_prog_changed_rx(test)) {
 		err = xsk_reattach_xdp(ifobj_rx, test->xdp_prog_rx, test->xskmap_rx, test->mode);
 		if (err)
 			return err;
 	}
 
-	if (!ifobj_tx)
+	if (!ifobj_tx || !ifobj_is_local(ifobj_tx))
 		return 0;
 
 	if (xdp_prog_changed_tx(test))
@@ -1768,7 +1827,7 @@ static void clean_sockets(struct test_spec *test, struct ifobject *ifobj)
 {
 	u32 i;
 
-	if (!ifobj || !test)
+	if (!ifobj || !test || !ifobj_is_local(ifobj))
 		return;
 
 	for (i = 0; i < test->nb_sockets; i++)
@@ -1780,15 +1839,15 @@ static void clean_umem(struct test_spec *test, struct ifobject *ifobj1, struct i
 	if (!ifobj1)
 		return;
 
-	testapp_clean_xsk_umem(ifobj1);
-	if (ifobj2)
+	if (ifobj_is_local(ifobj1))
+		testapp_clean_xsk_umem(ifobj1);
+	if (ifobj2 && ifobj_is_local(ifobj2))
 		testapp_clean_xsk_umem(ifobj2);
 }
 
 static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *ifobj1,
 				      struct ifobject *ifobj2)
 {
-	pthread_t t0, t1;
 	u32 mbuf_cap;
 	int err;
 
@@ -1819,51 +1878,27 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 			       err, strerror(-err));
 		return TEST_FAILURE;
 	}
-	test->use_barrier = !!ifobj2;
-
-	if (test->use_barrier) {
-		if (pthread_barrier_init(&barr, NULL, 2))
-			return TEST_FAILURE;
 
+	if (ifobj2)
 		pkt_stream_reset(ifobj2->xsk->pkt_stream);
-	}
-
 	test->current_step++;
 	pkt_stream_reset(ifobj1->xsk->pkt_stream);
 	pkts_in_flight = 0;
 
-	/*Spawn RX thread */
-	pthread_create(&t0, NULL, ifobj1->func_ptr, test);
-
-	if (test->use_barrier) {
-		pthread_barrier_wait(&barr);
-		if (pthread_barrier_destroy(&barr)) {
-			test->use_barrier = false;
-			pthread_join(t0, NULL);
-			clean_sockets(test, ifobj1);
-			clean_umem(test, ifobj1, NULL);
-			return TEST_FAILURE;
-		}
-	}
-
-	if (ifobj2) {
-		/*Spawn TX thread */
-		pthread_create(&t1, NULL, ifobj2->func_ptr, test);
-		pthread_join(t1, NULL);
-	}
-
-	pthread_join(t0, NULL);
-
-	if (test->total_steps == test->current_step || test->fail) {
+	/* In a one-sided step, the idle endpoint only keeps in step. */
+	if (ifobj_is_local(ifobj1))
+		err = ifobj1->func_ptr(test);
+	else if (ifobj2 && ifobj_is_local(ifobj2))
+		err = ifobj2->func_ptr(test);
+	else
+		err = sync_endpoints(test);
+	if (test->total_steps == test->current_step || err) {
 		clean_sockets(test, ifobj1);
 		clean_sockets(test, ifobj2);
 		clean_umem(test, ifobj1, ifobj2);
 	}
 
-	if (test->fail)
-		return TEST_FAILURE;
-
-	return TEST_PASS;
+	return err ? TEST_FAILURE : TEST_PASS;
 }
 
 static int testapp_validate_traffic(struct test_spec *test)
@@ -1879,7 +1914,8 @@ static int testapp_validate_traffic(struct test_spec *test)
 
 	if (test->set_ring) {
 		if (ifobj_has_cap(ifobj_tx, XSK_CAP_HW_RING)) {
-			if (set_ring_size(ifobj_tx)) {
+			if (ifobj_is_local(ifobj_tx) &&
+			    set_ring_size(ifobj_tx)) {
 				ksft_print_msg("Failed to change HW ring size.\n");
 				return TEST_FAILURE;
 			}
@@ -1912,7 +1948,7 @@ int testapp_teardown(struct test_spec *test)
 
 static void swap_directions(struct ifobject **ifobj1, struct ifobject **ifobj2)
 {
-	thread_func_t tmp_func_ptr = (*ifobj1)->func_ptr;
+	test_func_t tmp_func_ptr = (*ifobj1)->func_ptr;
 	struct ifobject *tmp_ifobj = (*ifobj1);
 
 	(*ifobj1)->func_ptr = (*ifobj2)->func_ptr;
@@ -1951,6 +1987,9 @@ static int swap_xsk_resources(struct test_spec *test)
 	test->ifobj_tx->xsk = &test->ifobj_tx->xsk_arr[1];
 	test->ifobj_rx->xsk = &test->ifobj_rx->xsk_arr[1];
 
+	if (!ifobj_is_local(test->ifobj_rx))
+		return TEST_PASS;
+
 	ret = xsk_update_xskmap(test->ifobj_rx->xskmap, test->ifobj_rx->xsk->xsk, 0);
 	if (ret)
 		return TEST_FAILURE;
@@ -2299,7 +2338,7 @@ int testapp_too_many_frags(struct test_spec *test)
 	return ret;
 }
 
-static int xsk_load_xdp_programs(struct ifobject *ifobj)
+int xsk_load_xdp_programs(struct ifobject *ifobj)
 {
 	ifobj->xdp_progs = xsk_xdp_progs__open_and_load();
 	if (libbpf_get_error(ifobj->xdp_progs))
@@ -2357,12 +2396,10 @@ static int detect_ifobj_caps(struct ifobject *ifobj)
 	return 0;
 }
 
-int init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
+int init_iface(struct ifobject *ifobj)
 {
 	int err;
 
-	ifobj->func_ptr = func_ptr;
-
 	err = xsk_load_xdp_programs(ifobj);
 	if (err) {
 		ksft_print_msg("Error loading XDP program\n");
diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.h b/tools/testing/selftests/net/lib/xsk/test_xsk.h
index 861a2ee3b8e1..53e5032510a0 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
@@ -77,9 +77,13 @@ enum test_mode {
 struct ifobject;
 struct test_spec;
 typedef int (*validation_func_t)(struct ifobject *ifobj);
-typedef void *(*thread_func_t)(void *arg);
 typedef int (*test_func_t)(struct test_spec *test);
 
+struct xsk_peer;
+
+/* The control channel to the other endpoint. */
+void xsk_set_endpoint(struct xsk_peer *peer);
+
 struct xsk_socket_info {
 	struct xsk_ring_cons rx;
 	struct xsk_ring_prod tx;
@@ -139,7 +143,7 @@ struct ifobject {
 	struct xsk_caps caps;
 	struct xsk_socket_info *xsk;
 	struct xsk_socket_info *xsk_arr;
-	thread_func_t func_ptr;
+	test_func_t func_ptr;
 	validation_func_t validation_func;
 	struct xsk_xdp_progs *xdp_progs;
 	struct bpf_map *xskmap;
@@ -169,11 +173,18 @@ static inline void ifobj_set_cap(struct ifobject *ifobj, u32 cap)
 	ifobj->caps.flags |= cap;
 }
 
+/* The shadow of the peer's ifobject is never bound to an interface. */
+static inline bool ifobj_is_local(const struct ifobject *ifobj)
+{
+	return ifobj->ifindex;
+}
+
 #define xsk_get_cap(test, cap) ((test)->ifobj_tx->caps.cap)
 
 struct ifobject *ifobject_create(void);
 void ifobject_delete(struct ifobject *ifobj);
-int init_iface(struct ifobject *ifobj, thread_func_t func_ptr);
+int init_iface(struct ifobject *ifobj);
+int xsk_load_xdp_programs(struct ifobject *ifobj);
 
 int xsk_configure_umem(struct ifobject *ifobj, struct xsk_umem_info *umem, void *buffer, u64 size);
 int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem,
@@ -222,12 +233,10 @@ struct test_spec {
 	u16 total_steps;
 	u16 current_step;
 	u16 nb_sockets;
-	bool fail;
 	bool set_ring;
 	bool adjust_tail;
 	bool adjust_tail_support;
 	bool poll_tmout;
-	bool use_barrier;
 	enum test_mode mode;
 	char name[MAX_TEST_NAME_SIZE];
 };
@@ -288,8 +297,8 @@ int testapp_xdp_metadata_mb(struct test_spec *test);
 int testapp_xdp_prog_cleanup(struct test_spec *test);
 int testapp_xdp_shared_umem(struct test_spec *test);
 
-void *worker_testapp_validate_rx(void *arg);
-void *worker_testapp_validate_tx(void *arg);
+int worker_testapp_validate_rx(struct test_spec *test);
+int worker_testapp_validate_tx(struct test_spec *test);
 
 static const struct test_spec tests[] = {
 	{.name = "SEND_RECEIVE", .test_func = testapp_send_receive},
diff --git a/tools/testing/selftests/net/lib/xsk/xsk_peer.c b/tools/testing/selftests/net/lib/xsk/xsk_peer.c
new file mode 100644
index 000000000000..e3e353d6abd9
--- /dev/null
+++ b/tools/testing/selftests/net/lib/xsk/xsk_peer.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <arpa/inet.h>
+#include <errno.h>
+#include <limits.h>
+#include <netdb.h>
+#include <netinet/tcp.h>
+#include <poll.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/socket.h>
+#include <unistd.h>
+
+#include "xsk_peer.h"
+
+#define XSK_PEER_MAGIC			0x58534b50
+#define XSK_PEER_ACCEPT_TMOUT_MS	30000
+
+/*
+ * One case per connection; the launcher owns the verdict. As with the control
+ * channels of other selftests, the test hosts are trusted: nothing
+ * authenticates the peer.
+ */
+enum xsk_peer_msg_type {
+	XSK_PEER_READY = 1,
+	XSK_PEER_PROGRESS,
+	XSK_PEER_ABORT,
+};
+
+struct xsk_peer_msg {
+	u32 magic;
+	u32 type;
+	u32 pkts;
+};
+
+struct xsk_peer {
+	int fd;
+	u32 acked;
+	bool ready_seen;
+	bool closed;
+};
+
+static int io_full(int fd, void *buf, size_t len, bool write_op)
+{
+	size_t done = 0;
+	ssize_t ret;
+
+	while (done < len) {
+		if (write_op)
+			ret = send(fd, (char *)buf + done, len - done, MSG_NOSIGNAL);
+		else
+			ret = read(fd, (char *)buf + done, len - done);
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret < 0)
+			return -errno;
+		if (!ret)
+			return -EPIPE;
+		done += ret;
+	}
+	return 0;
+}
+
+/*
+ * Past its last barrier the peer may exit at any time, and it resets the
+ * connection if our progress reports are still unread.
+ */
+static bool peer_gone(int err)
+{
+	return err == -EPIPE || err == -ECONNRESET;
+}
+
+static int peer_send(struct xsk_peer *peer, u32 type, u32 pkts)
+{
+	struct xsk_peer_msg msg = {
+		.magic = htonl(XSK_PEER_MAGIC),
+		.type = htonl(type),
+		.pkts = htonl(pkts),
+	};
+
+	return io_full(peer->fd, &msg, sizeof(msg), true);
+}
+
+static int peer_recv_one(struct xsk_peer *peer)
+{
+	struct xsk_peer_msg msg;
+	u32 pkts;
+	int err;
+
+	err = io_full(peer->fd, &msg, sizeof(msg), false);
+	if (peer_gone(err))
+		peer->closed = true;
+	if (err)
+		return err;
+	if (ntohl(msg.magic) != XSK_PEER_MAGIC)
+		return -EPROTO;
+
+	switch (ntohl(msg.type)) {
+	case XSK_PEER_READY:
+		/* The peer waits for our READY, so it is at most one step ahead. */
+		if (peer->ready_seen)
+			return -EPROTO;
+		peer->ready_seen = true;
+		return 0;
+	case XSK_PEER_PROGRESS:
+		/* xsk_peer_tx_sync() returns the sum as an int. */
+		pkts = ntohl(msg.pkts);
+		if (pkts > INT_MAX - peer->acked)
+			return -EPROTO;
+		peer->acked += pkts;
+		return 0;
+	case XSK_PEER_ABORT:
+		return -ECANCELED;
+	default:
+		return -EPROTO;
+	}
+}
+
+/*
+ * Consume what the peer has sent so far without blocking. A closed connection
+ * is not an error here, see peer_gone(); xsk_peer_closed() reports it.
+ */
+static int peer_drain(struct xsk_peer *peer)
+{
+	struct pollfd pfd = { .fd = peer->fd, .events = POLLIN };
+	int ret;
+
+	while (!peer->closed) {
+		ret = poll(&pfd, 1, 0);
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret < 0)
+			return -errno;
+		if (!ret)
+			break;
+		ret = peer_recv_one(peer);
+		if (ret && !peer->closed)
+			return ret;
+	}
+	return 0;
+}
+
+/* Return once both endpoints are set up for the next step. */
+int xsk_peer_ready(struct xsk_peer *peer)
+{
+	int err;
+
+	err = peer_send(peer, XSK_PEER_READY, 0);
+	while (!err && !peer->ready_seen)
+		err = peer_recv_one(peer);
+	if (err)
+		return err;
+
+	/* TCP ordering puts all progress of the previous step before READY. */
+	peer->ready_seen = false;
+	peer->acked = 0;
+	return 0;
+}
+
+void xsk_peer_abort(struct xsk_peer *peer)
+{
+	if (peer && !peer->closed)
+		peer_send(peer, XSK_PEER_ABORT, 0);
+}
+
+int xsk_peer_rx_progress(struct xsk_peer *peer, u32 pkts)
+{
+	int err;
+
+	if (pkts && !peer->closed) {
+		err = peer_send(peer, XSK_PEER_PROGRESS, pkts);
+		/*
+		 * Leave closed to peer_drain(), which first reads what the
+		 * peer sent before it went away, such as an ABORT.
+		 */
+		if (err && !peer_gone(err))
+			return err;
+	}
+	return peer_drain(peer);
+}
+
+/* Return the packets RX reported consumed since the last call, or -errno. */
+int xsk_peer_tx_sync(struct xsk_peer *peer)
+{
+	int err = peer_drain(peer);
+	u32 acked = peer->acked;
+
+	if (err)
+		return err;
+	peer->acked = 0;
+	return acked;
+}
+
+bool xsk_peer_closed(struct xsk_peer *peer)
+{
+	return peer->closed;
+}
+
+static int accept_tmout(int lfd)
+{
+	struct pollfd pfd = { .fd = lfd, .events = POLLIN };
+	int ret;
+
+	do {
+		ret = poll(&pfd, 1, XSK_PEER_ACCEPT_TMOUT_MS);
+	} while (ret < 0 && errno == EINTR);
+	if (!ret)
+		errno = ETIMEDOUT;
+	return ret > 0 ? accept(lfd, NULL, NULL) : -1;
+}
+
+/*
+ * The listener says on stderr when it listens, and the launcher waits for
+ * that line before it starts the connector, so connect() needs no retry.
+ * accept() is bounded in case the connector exits before it gets that far.
+ */
+static int peer_open_tcp(const char *host, const char *port, bool listen_side)
+{
+	struct addrinfo hints = {
+		.ai_family = AF_UNSPEC,
+		.ai_socktype = SOCK_STREAM,
+		.ai_flags = AI_NUMERICSERV,
+	};
+	int fd = -1, lfd, saved = ECONNREFUSED, one = 1, err;
+	struct addrinfo *res, *ai;
+
+	err = getaddrinfo(host, port, &hints, &res);
+	if (err)
+		return -EINVAL;
+
+	if (!listen_side)
+		goto conn;
+
+	for (ai = res; ai; ai = ai->ai_next) {
+		lfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
+		if (lfd < 0)
+			continue;
+		setsockopt(lfd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
+		if (!bind(lfd, ai->ai_addr, ai->ai_addrlen) && !listen(lfd, 1)) {
+			fprintf(stderr, "Listening for XSK peer on port %s\n", port);
+			fd = accept_tmout(lfd);
+			saved = errno;
+			close(lfd);
+			break;
+		}
+		saved = errno;
+		close(lfd);
+	}
+	freeaddrinfo(res);
+	return fd >= 0 ? fd : -saved;
+
+conn:
+	for (ai = res; ai; ai = ai->ai_next) {
+		fd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
+		if (fd < 0)
+			continue;
+		if (!connect(fd, ai->ai_addr, ai->ai_addrlen))
+			break;
+		saved = errno;
+		close(fd);
+		fd = -1;
+	}
+	freeaddrinfo(res);
+	return fd >= 0 ? fd : -saved;
+}
+
+struct xsk_peer *xsk_peer_open(const char *host, const char *port,
+			       bool listen_side)
+{
+	int fd = peer_open_tcp(host, port, listen_side);
+	struct xsk_peer *peer;
+	int one = 1;
+
+	if (fd < 0) {
+		errno = -fd;
+		return NULL;
+	}
+	peer = calloc(1, sizeof(*peer));
+	if (!peer) {
+		close(fd);
+		return NULL;
+	}
+	peer->fd = fd;
+	setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &one, sizeof(one));
+	return peer;
+}
+
+void xsk_peer_close(struct xsk_peer *peer)
+{
+	if (peer) {
+		close(peer->fd);
+		free(peer);
+	}
+}
diff --git a/tools/testing/selftests/net/lib/xsk/xsk_peer.h b/tools/testing/selftests/net/lib/xsk/xsk_peer.h
new file mode 100644
index 000000000000..da4462192994
--- /dev/null
+++ b/tools/testing/selftests/net/lib/xsk/xsk_peer.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef XSK_PEER_H_
+#define XSK_PEER_H_
+
+#include <linux/types.h>
+
+struct xsk_peer;
+
+struct xsk_peer *xsk_peer_open(const char *host, const char *port,
+			       bool listen_side);
+void xsk_peer_close(struct xsk_peer *peer);
+
+int xsk_peer_ready(struct xsk_peer *peer);
+void xsk_peer_abort(struct xsk_peer *peer);
+int xsk_peer_rx_progress(struct xsk_peer *peer, u32 pkts);
+int xsk_peer_tx_sync(struct xsk_peer *peer);
+bool xsk_peer_closed(struct xsk_peer *peer);
+
+#endif /* XSK_PEER_H_ */
diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
index 09ad623333be..769718cad8cd 100644
--- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
+++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
@@ -9,9 +9,9 @@
  * See test_xsk.py for detailed information on test topology
  * and prerequisite network setup.
  *
- * This test program contains two threads, each thread is single socket with
- * a unique UMEM. It validates in-order packet delivery and packet content
- * by sending packets to each other.
+ * Each instance of this test program runs one endpoint, Tx or Rx, with a
+ * single socket and a unique UMEM. Two instances validate in-order packet
+ * delivery and packet content by sending packets to each other.
  *
  * Tests Information:
  * ------------------
@@ -57,12 +57,14 @@
  *
  * Flow:
  * -----
- * - Single process spawns two threads: Tx and Rx
- * - Each of these two threads attach to a veth interface
- * - Each thread creates one AF_XDP socket connected to a unique umem for each
+ * - test_xsk.py starts two processes: Tx and Rx
+ * - Each of these two processes attach to a veth interface
+ * - Each process creates one AF_XDP socket connected to a unique umem for each
  *   veth interface
- * - Tx thread Transmits a number of packets from veth<xxxx> to veth<yyyy>
- * - Rx thread verifies if all packets were received and delivered in-order,
+ * - Tx process listens on a TCP control port, Rx process connects to it and
+ *   the two synchronize each test step over that connection
+ * - Tx process Transmits a number of packets from veth<xxxx> to veth<yyyy>
+ * - Rx process verifies if all packets were received and delivered in-order,
  *   and have the right content
  */
 
@@ -87,6 +89,7 @@
 #include <sys/types.h>
 
 #include "test_xsk.h"
+#include "xsk_peer.h"
 #include "xsk_xdp_progs.skel.h"
 #include "xsk.h"
 #include "xskxceiver.h"
@@ -95,8 +98,18 @@
 #include "kselftest.h"
 #include "xsk_xdp_common.h"
 
+enum xsk_endpoint_role {
+	XSK_ENDPOINT_NONE,
+	XSK_ENDPOINT_RX,
+	XSK_ENDPOINT_TX,
+};
+
 static enum test_mode opt_mode = TEST_MODE_ALL;
 static u32 opt_run_test = RUN_ALL_TESTS;
+static enum xsk_endpoint_role opt_endpoint_role = XSK_ENDPOINT_NONE;
+static const char *opt_peer_host;
+static const char *opt_peer_port;
+static const char *opt_ifname;
 
 static void __exit_with_error(int error, const char *file, const char *func, int line)
 {
@@ -157,6 +170,9 @@ static struct option long_options[] = {
 	{"mode", required_argument, 0, 'm'},
 	{"list", no_argument, 0, 'l'},
 	{"test", required_argument, 0, 't'},
+	{"endpoint", required_argument, 0, 'e'},
+	{"peer", required_argument, 0, 'p'},
+	{"peer-port", required_argument, 0, 'P'},
 	{"help", no_argument, 0, 'h'},
 	{0, 0, 0, 0}
 };
@@ -164,7 +180,7 @@ static struct option long_options[] = {
 static void print_usage(char **argv)
 {
 	const char *str =
-		"  Usage: xskxceiver -i TX_IFACE -i RX_IFACE -m MODE -t TEST [OPTIONS]\n"
+		"  Usage: xskxceiver -i IFACE -e rx|tx -m MODE -t TEST -p HOST -P PORT [OPTIONS]\n"
 		"  Options:\n"
 		"  -i, --interface      Use interface\n"
 		"  -v, --verbose        Verbose output\n"
@@ -172,16 +188,18 @@ static void print_usage(char **argv)
 		"  -m, --mode           Mode to run: skb, drv or zc\n"
 		"  -l, --list           List all available tests\n"
 		"  -t, --test           Test case to run, a number from -l\n"
+		"  -e, --endpoint       Role of this endpoint: rx or tx\n"
+		"  -p, --peer           Control host: IPv4/IPv6 address or hostname\n"
+		"  -P, --peer-port      Control TCP port (1-65535)\n"
 		"  -h, --help           Display this help and exit\n";
 
 	ksft_print_msg(str, basename(argv[0]));
 	ksft_exit_xfail();
 }
 
-static void bind_iface(struct ifobject *ifobj, const char *ifname, thread_func_t func,
-		       char **argv)
+static void bind_iface(struct ifobject *ifobj, const char *ifname, char **argv)
 {
-	size_t len = ifname ? strlen(ifname) : 0;
+	size_t len = strlen(ifname);
 
 	if (!len || len >= sizeof(ifobj->ifname))
 		print_usage(argv);
@@ -193,7 +211,7 @@ static void bind_iface(struct ifobject *ifobj, const char *ifname, thread_func_t
 		ksft_exit_fail();
 	}
 
-	if (init_iface(ifobj, func)) {
+	if (init_iface(ifobj)) {
 		ksft_print_msg("Error: cannot initialize interface %s\n", ifobj->ifname);
 		ksft_exit_fail();
 	}
@@ -208,26 +226,33 @@ static void print_tests(void)
 		printf("%u: %s\n", i, tests[i].name);
 }
 
+static u32 parse_u32(const char *arg, u32 min, u32 max, char **argv)
+{
+	unsigned long val;
+	char *end;
+
+	errno = 0;
+	val = strtoul(arg, &end, 10);
+	if (arg[0] < '0' || arg[0] > '9' || errno || *end || val < min || val > max)
+		print_usage(argv);
+	return val;
+}
+
 static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj_rx, int argc,
 			       char **argv)
 {
-	const char *ifname[2] = {};
-	u32 interface_nb = 0;
 	int option_index, c;
 
 	opterr = 0;
 
 	for (;;) {
-		c = getopt_long(argc, argv, "i:vbm:lt:", long_options, &option_index);
+		c = getopt_long(argc, argv, "i:vbm:lt:e:p:P:", long_options, &option_index);
 		if (c == -1)
 			break;
 
 		switch (c) {
 		case 'i':
-			if (interface_nb >= ARRAY_SIZE(ifname))
-				break;
-
-			ifname[interface_nb++] = optarg;
+			opt_ifname = optarg;
 			break;
 		case 'v':
 			opt_verbose = true;
@@ -256,17 +281,31 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 			if (errno)
 				print_usage(argv);
 			break;
+		case 'e':
+			if (!strcmp(optarg, "rx"))
+				opt_endpoint_role = XSK_ENDPOINT_RX;
+			else if (!strcmp(optarg, "tx"))
+				opt_endpoint_role = XSK_ENDPOINT_TX;
+			else
+				print_usage(argv);
+			break;
+		case 'p':
+			opt_peer_host = optarg;
+			break;
+		case 'P':
+			parse_u32(optarg, 1, UINT16_MAX, argv);
+			opt_peer_port = optarg;
+			break;
 		case 'h':
 		default:
 			print_usage(argv);
 		}
 	}
 
-	if (opt_run_test == RUN_ALL_TESTS || opt_mode == TEST_MODE_ALL)
+	if (!opt_ifname || opt_endpoint_role == XSK_ENDPOINT_NONE || !opt_peer_host ||
+	    !*opt_peer_host || !opt_peer_port || opt_run_test == RUN_ALL_TESTS ||
+	    opt_mode == TEST_MODE_ALL)
 		print_usage(argv);
-
-	bind_iface(ifobj_tx, ifname[0], worker_testapp_validate_tx, argv);
-	bind_iface(ifobj_rx, ifname[1], worker_testapp_validate_rx, argv);
 }
 
 static void xsk_unload_xdp_programs(struct ifobject *ifobj)
@@ -352,20 +391,51 @@ static bool mode_supported(enum test_mode mode, u32 caps)
 
 static void cleanup_iface(struct ifobject *ifobj)
 {
+	/* A peer shadow has a skeleton but no bound interface. */
+	if (!ifobj_is_local(ifobj))
+		goto unload;
+
 	if (ifobj_has_cap(ifobj, XSK_CAP_HW_RING))
 		hw_ring_size_reset(ifobj);
 	if (ifobj->xdp_prog)
 		xsk_detach_xdp_program(ifobj->ifindex,
 				       ifobj->mode == TEST_MODE_SKB ?
 				       XDP_FLAGS_SKB_MODE : XDP_FLAGS_DRV_MODE);
+unload:
 	xsk_unload_xdp_programs(ifobj);
 }
 
+/* Connect the two endpoints without negotiating the remote NIC's capabilities. */
+static int setup_peer(struct ifobject *local, struct ifobject *shadow,
+		      struct xsk_peer **peer)
+{
+	/* Once BIDIRECTIONAL swaps the directions, the local side attaches the
+	 * shadow's programs, so the shadow needs a skeleton of its own.
+	 */
+	if (xsk_load_xdp_programs(shadow))
+		return TEST_FAILURE;
+
+	/* TX listens and RX connects. */
+	*peer = xsk_peer_open(opt_peer_host, opt_peer_port,
+			      opt_endpoint_role == XSK_ENDPOINT_TX);
+	if (!*peer) {
+		ksft_print_msg("Failed to connect XSK peer: %s\n", strerror(errno));
+		return TEST_FAILURE;
+	}
+
+	shadow->caps = local->caps;
+	xsk_set_endpoint(*peer);
+	return TEST_PASS;
+}
+
 int main(int argc, char **argv)
 {
 	u32 cache_line_size, max_frags, umem_tailroom;
 	const size_t total_tests = ARRAY_SIZE(tests);
 	struct ifobject *ifobj_tx, *ifobj_rx;
+	struct ifobject *shadow_ifobj;
+	struct ifobject *local_ifobj;
+	struct xsk_peer *peer = NULL;
 	struct test_spec test = {};
 	int ret = TEST_FAILURE;
 	u32 caps;
@@ -412,12 +482,26 @@ int main(int argc, char **argv)
 		ksft_exit_xfail();
 	}
 
+	/* swap_directions() swaps the workers, so the shadow needs one too. */
+	ifobj_tx->func_ptr = worker_testapp_validate_tx;
+	ifobj_rx->func_ptr = worker_testapp_validate_rx;
+	if (opt_endpoint_role == XSK_ENDPOINT_TX) {
+		local_ifobj = ifobj_tx;
+		shadow_ifobj = ifobj_rx;
+	} else {
+		local_ifobj = ifobj_rx;
+		shadow_ifobj = ifobj_tx;
+	}
+	bind_iface(local_ifobj, opt_ifname, argv);
+	caps = detect_mode_caps(local_ifobj);
+
 	test.tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
 	test.rx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
 	if (!test.tx_pkt_stream_default || !test.rx_pkt_stream_default)
 		goto out;
 
-	caps = detect_mode_caps(ifobj_tx);
+	if (setup_peer(local_ifobj, shadow_ifobj, &peer))
+		goto out;
 
 	if (!mode_supported(opt_mode, caps)) {
 		if (opt_mode == TEST_MODE_DRV)
@@ -433,8 +517,10 @@ int main(int argc, char **argv)
 	ret = run_pkt_test(&test);
 
 out:
+	xsk_set_endpoint(NULL);
 	cleanup_iface(ifobj_tx);
 	cleanup_iface(ifobj_rx);
+	xsk_peer_close(peer);
 	pkt_stream_delete(test.tx_pkt_stream_default);
 	pkt_stream_delete(test.rx_pkt_stream_default);
 	ifobject_delete(ifobj_tx);
diff --git a/tools/testing/selftests/net/test_xsk.py b/tools/testing/selftests/net/test_xsk.py
index acfdba55fbae..8bf18b913c93 100755
--- a/tools/testing/selftests/net/test_xsk.py
+++ b/tools/testing/selftests/net/test_xsk.py
@@ -6,25 +6,22 @@ AF_XDP tests over veth.
 
 Topology:
 
-                 -----------
-               _ | Process | _
-              /  -----------  \
-             /        |        \
-            /         |         \
-      -----------     |     -----------
-      | Thread1 |     |     | Thread2 |
-      -----------     |     -----------
-           |          |          |
-      -----------     |     -----------
-      |  xskX   |     |     |  xskY   |
-      -----------     |     -----------
-           |          |          |
-      -----------     |     ----------
-      |  vethX  | --------- |  vethY |
-      -----------   peer    ----------
-
-Each case runs an xskxceiver process of its own on a veth pair that the case
-creates in the current network namespace and deletes when it ends.
+      -----------   control    -----------
+      | TX proc | ------------ | RX proc |
+      -----------  (TCP, lo)   -----------
+           |                        |
+      -----------              -----------
+      |  xskX   |              |  xskY   |
+      -----------              -----------
+           |                        |
+      -----------              ----------
+      |  vethX  | ------------ |  vethY |
+      -----------     peer     ----------
+
+Each case runs a TX and an RX xskxceiver process on a veth pair that the case
+creates in the current network namespace and deletes when it ends. The TX
+process listens on a TCP control port on 127.0.0.1, and the RX process
+connects to it once TX says on stderr that it listens.
 
 test_xsk runs every case that "xskxceiver -l" lists but EXCLUDED_CASES in SKB
 and DRV mode, and test_xsk_busy_poll runs them again with busy polling.
@@ -38,13 +35,16 @@ import re
 import sys
 from pathlib import Path
 
-from lib.py import (KsftNamedVariant, KsftSkipEx, cmd, defer, ip, ksft_eq,
-                    ksft_exit, ksft_run, ksft_variants, xsk_release_hugepages,
-                    xsk_reserve_hugepages, xsk_setup_busy_poll,
-                    xsk_wait_endpoint_exit)
+from lib.py import (KsftFailEx, KsftNamedVariant, KsftSkipEx, cmd, defer, ip,
+                    ksft_exit, ksft_in, ksft_run, ksft_variants, rand_port,
+                    xsk_release_hugepages, xsk_reserve_hugepages,
+                    xsk_setup_busy_poll, xsk_wait_endpoint_exit,
+                    xsk_wait_listen)
 
 XSK_BIN = Path(__file__).parent / "lib/xskxceiver"
 CASE_TIMEOUT = 120
+# xskxceiver waits as long for its peer to connect.
+LISTEN_TIMEOUT = 30
 SKIP_CODE = 4
 EXCLUDED_CASES = {
     # bpf_xdp_adjust_tail() frees a frag that it trims off as the memory type
@@ -102,14 +102,28 @@ def _start(args):
 
 def _test(mode, test_id, busy_poll):
     tx_if, rx_if = _veth_pair(busy_poll)
+    port = rand_port()
     args = ["-m", mode,
             "-t", str(test_id),
+            "-p", "127.0.0.1",
+            "-P", str(port),
             *(["-b"] if busy_poll else [])]
-    ret = xsk_wait_endpoint_exit(_start(["-i", tx_if, "-i", rx_if, *args]),
-                                 "xsk", CASE_TIMEOUT)
-    if ret == SKIP_CODE:
+    tx = _start(["-i", tx_if, "-e", "tx", *args])
+    head = ""
+    try:
+        head, listening = xsk_wait_listen(tx, port, LISTEN_TIMEOUT)
+        if not listening:
+            tx.proc.kill()
+            raise KsftFailEx(f"TX endpoint did not listen on port {port}")
+        rx = _start(["-i", rx_if, "-e", "rx", *args])
+        rx_ret = xsk_wait_endpoint_exit(rx, "rx", CASE_TIMEOUT)
+    finally:
+        tx_ret = xsk_wait_endpoint_exit(tx, "tx", CASE_TIMEOUT, head)
+    rets = {tx_ret, rx_ret}
+    if SKIP_CODE in rets and rets <= {0, SKIP_CODE}:
         raise KsftSkipEx("xskxceiver skipped the case")
-    ksft_eq(ret, 0, "xskxceiver exit code")
+    ksft_in(tx_ret, (0, SKIP_CODE), "TX endpoint exit code")
+    ksft_in(rx_ret, (0, SKIP_CODE), "RX endpoint exit code")
 
 
 def test_xsk(mode, test_id):
-- 
2.43.0

