Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6966F568FBD;
	Wed, 14 Oct 2026 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003587; cv=none; b=mc+sgc7a5VKgVrpmAJCXB3yXcSz4Vd3hdohAEHkjX9coMPU/JjtpNHBZvKj6HDEX1WU7bLRq6QryoMv0kmmh5CU76jsLfvwj3dRFanAvXULZbRlzBlEKe5kw6IMeEjQ0/rQvzhyc0MLFNQWKg4NQjGFFl7l2dA0gbGtinwLnK2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003587; c=relaxed/simple;
	bh=M0GhQ7y6v5ApN+l+TI67i0MICOXrQ6UG/HlfHdcPQbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hIZD/UrGnA8YeWajbAb8HI8JDBAN2IGwj6nR2Zh+2okMjb8sxMVVXo6kmICJYQpn4ScnjqUw3PUO1j5F8N+JXvYv1Lri7v4/z5jstBvR9z3nfSJ+V6Nw/yz3fDTVmzYWdIBv52uHEa64gWq8CzQDAAlMraU5XTya3xZzKbNc5Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npkZbaFL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npkZbaFL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792003586; x=1823539586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M0GhQ7y6v5ApN+l+TI67i0MICOXrQ6UG/HlfHdcPQbg=;
  b=npkZbaFLQehuvW+S2EPWWW2xRQzxkns9EJlySl+KgOHnw3eMK/RMYT7R
   XCpmPXHG4ziv2FhtpErPUV6TunFUuWJq9M0WoXoYNsFxcJf187ICZNWdU
   QZDzS1nTejdvRONtYHsnBTDcsLKnHzakunxkFOUtSmVfEC0WVfVwoZyZ1
   oSGBlTniEAYZFEmrCUodnOvPYZNh55i8FVuGygMiSgZQoiP0ibzHLTOg5
   RB5r8QgxgnJkb17eDGZabqca6o7HLYAnxVOeeD5GD16/4Ry3auulUUuj+
   9/y6L0m/B7kwBdaLKRER5C0TGcNi8fDl1EgbJOTZSpYb3TtM4YLYB5m4E
   Q==;
X-CSE-ConnectionGUID: gZnY7hENRJKLa/jKXiBzTg==
X-CSE-MsgGUID: W0wB7zDGTqGQfSVvAT4WUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="767365"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="767365"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 11:46:25 -0700
X-CSE-ConnectionGUID: Aq6uQqPuSheli0quKoRUQQ==
X-CSE-MsgGUID: P3uV/X55TaKGH9z4q80izg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1420834"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:46:23 -0700
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
Subject: [PATCH v3 net-next 12/15] selftests: xsk: pass non-test traffic to the stack in hardware mode
Date: Wed, 14 Oct 2026 20:45:36 +0200
Message-Id: <20261014184539.774708-13-maciej.fijalkowski@intel.com>
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

The XDP programs of xskxceiver redirect every packet to the XSKMAP and
drop what no socket takes. On a hardware link, this drops neighbour
discovery, LLDP or SSH while a program is attached, and on the remote,
whose socket shares queue 0 with RSS, such a packet reaches the socket
and fails the case.

In hardware mode, redirect only the UDP/IPv4 packets sent to the test
port (--udp-port) and pass everything else to the stack, IPv4 fragments
included, as a fragment other than the first has no UDP header. The
veth mode keeps redirecting every packet, as its frames carry no IP
header. Matching the RX queue would not be enough, as the runner leaves
the remote's RSS table alone to need no more than ntuple support there.
The port also keeps the drop, tail-adjust and metadata programs off
unrelated frames. It is written when a skeleton is loaded, so it also
reaches the shadow endpoint's copy, whose programs the local side
attaches once BIDIRECTIONAL swaps the directions.

Knowing the port, xsk_xdp_adjust_tail() numbers a grown tail after the
IPv4 and UDP headers of a hardware test packet, as the RX endpoint
checks it, instead of after the Ethernet header of a veth frame, so
both XDP_ADJUST_TAIL_GROW cases run with --hw. As generic XDP leaves no
room to grow the tail, they still skip when the RX endpoint runs in SKB
mode; a hardware TX endpoint does not know its peer's mode and leaves
that skip to RX.

is_adjust_tail_supported() copied all of .bss into an int with
bpf_map_lookup_elem(), past the end of the int even before the port
grew .bss. Read adjust_value through the skeleton instead.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../testing/selftests/net/lib/xsk/test_xsk.c  | 47 +++++++------------
 .../selftests/net/lib/xsk/xsk_xdp_progs.bpf.c | 47 +++++++++++++++++++
 2 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
index a280956d53f4..b70dbefe9729 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
@@ -944,31 +944,12 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
 	return true;
 }
 
-static int is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx, bool *supported)
+static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx)
 {
-	struct bpf_map *data_map;
-	int adjust_value = 0;
-	int key = 0;
-	int ret;
-
-	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
-	if (!data_map || !bpf_map__is_internal(data_map)) {
-		ksft_print_msg("Error: could not find bss section of XDP program\n");
-		return -EINVAL;
-	}
-
-	ret = bpf_map_lookup_elem(bpf_map__fd(data_map), &key, &adjust_value);
-	if (ret) {
-		ksft_print_msg("Error: bpf_map_lookup_elem failed with error %d\n", ret);
-		return ret;
-	}
-
 	/* Set the 'adjust_value' variable to -EOPNOTSUPP in the XDP program if the adjust_tail
 	 * helper is not supported. Skip the adjust_tail test case in this scenario.
 	 */
-	*supported = adjust_value != -EOPNOTSUPP;
-
-	return 0;
+	return skel_rx->bss->adjust_value != -EOPNOTSUPP;
 }
 
 static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 expected_pkt_nb,
@@ -1806,7 +1787,6 @@ static int testapp_prepare_rx_endpoint(struct test_spec *test,
 static int testapp_validate_rx_endpoint(struct test_spec *test,
 					struct ifobject *ifobject)
 {
-	bool supported;
 	int err;
 
 	err = receive_pkts(test);
@@ -1819,9 +1799,7 @@ static int testapp_validate_rx_endpoint(struct test_spec *test,
 	if (!test->adjust_tail)
 		return err;
 
-	if (is_adjust_tail_supported(ifobject->xdp_progs, &supported))
-		return TEST_FAILURE;
-	if (!supported) {
+	if (!is_adjust_tail_supported(ifobject->xdp_progs)) {
 		test->adjust_tail_support = false;
 		return TEST_PASS;
 	}
@@ -2506,6 +2484,8 @@ int xsk_load_xdp_programs(struct ifobject *ifobj)
 	if (libbpf_get_error(ifobj->xdp_progs))
 		return libbpf_get_error(ifobj->xdp_progs);
 
+	/* The shadow's copy too, swapped directions attach its programs. */
+	ifobj->xdp_progs->bss->hw_port = udp_port;
 	return 0;
 }
 
@@ -2774,10 +2754,20 @@ int testapp_adjust_tail_shrink_mb(struct test_spec *test)
 	return testapp_adjust_tail(test, -XSK_UMEM__MAX_FRAME_SIZE, XSK_UMEM__LARGE_FRAME_SIZE * 2);
 }
 
+/* Generic XDP leaves no room to grow the tail. Only the RX endpoint runs the
+ * program on the test flow, and a hardware TX endpoint, which does not know
+ * the mode of its peer, leaves that skip to the RX endpoint.
+ */
+static bool adjust_tail_grow_skip(struct test_spec *test)
+{
+	if (hw_test && !ifobj_is_local(test->ifobj_rx))
+		return false;
+	return test->mode == TEST_MODE_SKB;
+}
+
 int testapp_adjust_tail_grow(struct test_spec *test)
 {
-	/* The XDP program numbers the grown tail after a non-UDP header. */
-	if (test->mode == TEST_MODE_SKB || hw_test)
+	if (adjust_tail_grow_skip(test))
 		return TEST_SKIP;
 
 	/* Grow by 4 bytes for testing purpose */
@@ -2788,8 +2778,7 @@ int testapp_adjust_tail_grow_mb(struct test_spec *test)
 {
 	u32 grow_size;
 
-	/* The XDP program numbers the grown tail after a non-UDP header. */
-	if (test->mode == TEST_MODE_SKB || hw_test)
+	if (adjust_tail_grow_skip(test))
 		return TEST_SKIP;
 
 	/* worst case scenario is when underlying setup will work on 3k
diff --git a/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
index 023d8befd4ca..819f850f1e77 100644
--- a/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
+++ b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
@@ -5,9 +5,16 @@
 #include <bpf/bpf_helpers.h>
 #include <linux/if_ether.h>
 #include <linux/ip.h>
+#include <linux/udp.h>
+#include <linux/in.h>
 #include <linux/errno.h>
+#include <bpf/bpf_endian.h>
+#include <stdbool.h>
 #include "xsk_xdp_common.h"
 
+#define IP_MF		0x2000
+#define IP_OFFSET	0x1fff
+
 struct {
 	__uint(type, BPF_MAP_TYPE_XSKMAP);
 	__uint(max_entries, 2);
@@ -18,9 +25,36 @@ struct {
 static unsigned int idx;
 int adjust_value = 0;
 int count = 0;
+/* UDP port of the hardware test flow, 0 redirects every packet */
+__u16 hw_port;
+
+static __always_inline bool is_test_packet(struct xdp_md *xdp)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	struct ethhdr *eth = data;
+	struct udphdr *udp;
+	struct iphdr *ip;
+
+	if (!hw_port)
+		return true;
+	if ((void *)(eth + 1) > data_end ||
+	    eth->h_proto != bpf_htons(ETH_P_IP))
+		return false;
+	ip = (void *)(eth + 1);
+	/* A fragment other than the first has no UDP header. */
+	if ((void *)(ip + 1) > data_end || ip->ihl != 5 ||
+	    ip->protocol != IPPROTO_UDP ||
+	    ip->frag_off & bpf_htons(IP_MF | IP_OFFSET))
+		return false;
+	udp = (void *)(ip + 1);
+	return (void *)(udp + 1) <= data_end && udp->dest == bpf_htons(hw_port);
+}
 
 SEC("xdp.frags") int xsk_def_prog(struct xdp_md *xdp)
 {
+	if (!is_test_packet(xdp))
+		return XDP_PASS;
 	return bpf_redirect_map(&xsk, 0, XDP_DROP);
 }
 
@@ -28,6 +62,8 @@ SEC("xdp.frags") int xsk_xdp_drop(struct xdp_md *xdp)
 {
 	static unsigned int drop_idx;
 
+	if (!is_test_packet(xdp))
+		return XDP_PASS;
 	/* Drop every other packet */
 	if (drop_idx++ % 2)
 		return XDP_DROP;
@@ -41,6 +77,9 @@ SEC("xdp.frags") int xsk_xdp_populate_metadata(struct xdp_md *xdp)
 	struct xdp_info *meta;
 	int err;
 
+	if (!is_test_packet(xdp))
+		return XDP_PASS;
+
 	/* Reserve enough for all custom metadata. */
 	err = bpf_xdp_adjust_meta(xdp, -(int)sizeof(struct xdp_info));
 	if (err)
@@ -64,6 +103,8 @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
 	void *data_end = (void *)(long)xdp->data_end;
 	struct ethhdr *eth = data;
 
+	if (!is_test_packet(xdp))
+		return XDP_PASS;
 	if (eth + 1 > data_end)
 		return XDP_DROP;
 
@@ -80,6 +121,9 @@ SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp)
 	__u32 buff_len, curr_buff_len;
 	int ret;
 
+	if (!is_test_packet(xdp))
+		return XDP_PASS;
+
 	buff_len = bpf_xdp_get_buff_len(xdp);
 	if (buff_len == 0)
 		return XDP_DROP;
@@ -107,6 +151,9 @@ SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp)
 		__u32 len, words_to_end, seq_num;
 
 		len = curr_buff_len - PKT_HDR_ALIGN;
+		/* A hardware test packet also has IPv4 and UDP headers. */
+		if (hw_port)
+			len -= sizeof(struct iphdr) + sizeof(struct udphdr);
 		words_to_end = len / sizeof(*pkt_data) - 1;
 		seq_num = words_to_end;
 
-- 
2.43.0

