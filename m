Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727DB4908C2;
	Thu,  8 Oct 2026 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460192; cv=none; b=hiQx+cs6PYULgK29mHfjviBUWoQsfjjcUo2PoAemqdhR0UVBcmsnOy2Qh2tgsyt5yGoTRgcwjvR3X3/eZbwGyvUtDUK8i3vk6bVqs9yRzjnkE/WbNWolh+unGWrDVC4aR8i72UHvOuoGzf5PcJIl0/oNn0U7TGRfH6bKn6I1Qx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460192; c=relaxed/simple;
	bh=/wAGmz+MMRG4UWjE08M8bqtBvOmx20Z2TZjLw9U6RaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQ1dy+jDy8KUmVxUGRTl59J3RYbxqlbKYaYi2LxFoUEmGadNMJrpE74ilEUr+DqpnA/MdJkZvGD6pm+AK7ArLG+dr/P1RQKDexJ1ESd7nE1bvC+HJPAHlbgbPK/PxWh8hcVknyCzeei6YNIe/AHreBJch4sZTSGx+9XvdDBbQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0jwaxV5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0jwaxV5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791460190; x=1822996190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/wAGmz+MMRG4UWjE08M8bqtBvOmx20Z2TZjLw9U6RaY=;
  b=E0jwaxV54iXAZk3gmt1nSXBG5nfpZ94ckB1lW1vR+4shHsOpNf+LPG+M
   gUc9Mqgu82bvkyAetYpE0LpxeT6GBSKq0c9PuUaZ8rGoKSlkWKRH2tIeG
   ujqnnG+RDc/+RvXJfwcyoy1t7ovVvKDSZK8JK29v0RGsG6mPI7t/ApkKO
   /dy4LHtNRstenwJnz7mbETccoKTzzQO5mAqZrOL50fCBKSLxYE+sj4yxy
   fIISlYwGjc1AU0MZoF8+8FbVMJHuEB2lwGXFuNC5aY5ZotTioHzMS/wTf
   oz5jLSD1wY4hITjTpJRVSEXJk2M1+kotH/Fv0vV+ktOl/qwcEm3mvAkZx
   g==;
X-CSE-ConnectionGUID: WZmkaNaGSuiKZv4mUtfM1Q==
X-CSE-MsgGUID: T74MAGjrTJKQq5Zsj7AaMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="124985"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="124985"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 04:49:50 -0700
X-CSE-ConnectionGUID: VaKeqmmDTQayaAQ6Zjn2Aw==
X-CSE-MsgGUID: 6gyzrrOYRES/rgNlZNedNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="467199"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 08 Oct 2026 04:49:48 -0700
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
Subject: [PATCH v2 net-next 11/14] selftests: xsk: pass non-test traffic to the stack in hardware mode
Date: Thu,  8 Oct 2026 13:49:06 +0200
Message-Id: <20261008114909.734364-12-maciej.fijalkowski@intel.com>
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

The XDP programs of xskxceiver redirect every packet to the XSKMAP and
drop what no socket takes, so a hardware run needs a link that carries
nothing but the test flow. While a program is attached, neighbour
discovery, LLDP or SSH on the tested link are dropped, and on the
remote receiver, whose socket shares queue 0 with RSS, such a packet
reaches the socket and fails the case.

In hardware mode, redirect only the UDP/IPv4 packets sent to the test
port (--udp-port) and pass everything else to the stack. The veth mode
keeps redirecting every packet, as its frames carry no IP header.

I think that xdpsock used to do matching based on rx queue index, but
here it would not be enough: to need no more than ntuple support from
the remote, the runner leaves its RSS table alone, so the remote's
socket shares queue 0 with whatever RSS hashes there. The port also
keeps the drop, tail-adjust and metadata programs from acting on
unrelated frames.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../testing/selftests/net/lib/xsk/test_xsk.c  |  2 +
 .../selftests/net/lib/xsk/xsk_xdp_progs.bpf.c | 39 +++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
index 542c0579062a..1033a5430697 100644
--- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
@@ -2454,6 +2454,8 @@ int xsk_load_xdp_programs(struct ifobject *ifobj)
 	if (libbpf_get_error(ifobj->xdp_progs))
 		return libbpf_get_error(ifobj->xdp_progs);
 
+	/* The shadow's copy too, swapped directions attach its programs. */
+	ifobj->xdp_progs->bss->hw_port = udp_port;
 	return 0;
 }
 
diff --git a/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
index 023d8befd4ca..716360d023a7 100644
--- a/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
+++ b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
@@ -5,7 +5,11 @@
 #include <bpf/bpf_helpers.h>
 #include <linux/if_ether.h>
 #include <linux/ip.h>
+#include <linux/udp.h>
+#include <linux/in.h>
 #include <linux/errno.h>
+#include <bpf/bpf_endian.h>
+#include <stdbool.h>
 #include "xsk_xdp_common.h"
 
 struct {
@@ -18,9 +22,34 @@ struct {
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
+	if ((void *)(ip + 1) > data_end || ip->ihl != 5 ||
+	    ip->protocol != IPPROTO_UDP)
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
 
@@ -28,6 +57,8 @@ SEC("xdp.frags") int xsk_xdp_drop(struct xdp_md *xdp)
 {
 	static unsigned int drop_idx;
 
+	if (!is_test_packet(xdp))
+		return XDP_PASS;
 	/* Drop every other packet */
 	if (drop_idx++ % 2)
 		return XDP_DROP;
@@ -41,6 +72,9 @@ SEC("xdp.frags") int xsk_xdp_populate_metadata(struct xdp_md *xdp)
 	struct xdp_info *meta;
 	int err;
 
+	if (!is_test_packet(xdp))
+		return XDP_PASS;
+
 	/* Reserve enough for all custom metadata. */
 	err = bpf_xdp_adjust_meta(xdp, -(int)sizeof(struct xdp_info));
 	if (err)
@@ -64,6 +98,8 @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
 	void *data_end = (void *)(long)xdp->data_end;
 	struct ethhdr *eth = data;
 
+	if (!is_test_packet(xdp))
+		return XDP_PASS;
 	if (eth + 1 > data_end)
 		return XDP_DROP;
 
@@ -80,6 +116,9 @@ SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp)
 	__u32 buff_len, curr_buff_len;
 	int ret;
 
+	if (!is_test_packet(xdp))
+		return XDP_PASS;
+
 	buff_len = bpf_xdp_get_buff_len(xdp);
 	if (buff_len == 0)
 		return XDP_DROP;
-- 
2.43.0

