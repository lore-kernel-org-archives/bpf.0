Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C47A391E73;
	Wed, 19 Aug 2026 02:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107651; cv=none; b=fjMdepfe1Rwsfw1HvBPE9lPFXyyZGeBY2pHHn4RItWi2VYJZrBb/uY34FgqmtP8IMdaHu+tdXT1lvTJ1rGwLmXMNoq8FSerC29hgkB5HKpHgsv7+4+N55mbS/IyymizJ1LXmA1ERFTdcp1gZj6YBK/2Cm4tr4g9xuvWtKIb6JQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107651; c=relaxed/simple;
	bh=GloTkwWcX5hNWmPyWCYyfv5X26FNcpBDcx0RtHzuEZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYo6W/ZPUxAp4chBV6Q8V+KPKd6JKssC+DtU9iXlK0W06rZG8iMCW3HixzYPhS226joqT9u9/rgDclk/5gF41vrLGaXnwGEwIzUSEZpr/6nm7UN9tg0P6LzqkcdToC6BORXZHHzNMaSMu3bXGWeQITNOnwVCUGbylrTn3G2opV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FR4nD9Mz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FR4nD9Mz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787107649; x=1818643649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GloTkwWcX5hNWmPyWCYyfv5X26FNcpBDcx0RtHzuEZM=;
  b=FR4nD9Mzbi4NDfZY1+QKOZ3w/IQm7YCQxfFwwFXyhBov5fKdOnT4olUQ
   LHl5jdgu+r2jxoo7tyEWeEDG46sS3eyXY9Rak0dcaIfheP8ul6Feygj1l
   R3+/97Q63wJMZseNNNAuer8/VvMQ58Di5B+rVWZbei+Mx/65E7XT/dgjQ
   3+5fciejmRDWVM/J9/M37SaPbqjUTB/YrhpA5GthXPOVkvvU2B0HlJKZz
   K6joHauOP4CdKQvcc+z62JSSjvWrvl4CVxAKghaWJAFmckUCKV17QhMPc
   47m3+BRDFtXiHaRpvhy1Zok8VPHnA73fiUtFrc7u+IBECcXgrk3yQidVt
   g==;
X-CSE-ConnectionGUID: 59BKaxQ3Tg6c/hxPhoEv4A==
X-CSE-MsgGUID: mf50z5zlTT21KzAPjsmxoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87465295"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87465295"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 19:47:28 -0700
X-CSE-ConnectionGUID: RjIQd0dRRAm7xWZ+T36CRA==
X-CSE-MsgGUID: FwfSQJYBRw6vmcmufQ5+6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="264974419"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 19:47:25 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	stfomichev@gmail.com,
	kernelxing@tencent.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com,
	andrii@kernel.org
Cc: bpf@vger.kernel.org
Subject: [PATCH net-next v3 3/4] selftests/xsk: expand XSKMAP capacity and add length-based XDP program
Date: Wed, 19 Aug 2026 02:44:42 +0000
Message-ID: <20260819024443.781764-4-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819024443.781764-1-tushar.vyavahare@intel.com>
References: <20260819024443.781764-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Raise MAX_SOCKETS from 2 to 4 so the XSKMAP and test arrays can
accommodate the upcoming 4-socket shared-UMEM test. Update the XSKMAP
max_entries to use MAX_SOCKETS so the BPF and C sides stay in sync.

Add xsk_xdp_shared_umem_length_based() XDP program that routes packets
by total XDP-visible packet length (data_end - data): socket 0 for
packets <= SHARED_UMEM_LEN_SPLIT bytes and socket 1 for packets >
SHARED_UMEM_LEN_SPLIT bytes. Define SHARED_UMEM_LEN_SPLIT as 64 to avoid
hardcoded length thresholds in the classifier.

Co-developed-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/progs/xsk_xdp_progs.c | 15 ++++++++++++++-
 tools/testing/selftests/bpf/xsk_xdp_common.h      |  3 ++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
index 023d8befd4ca..8bab2bcf52ab 100644
--- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
+++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
@@ -10,7 +10,7 @@
 
 struct {
 	__uint(type, BPF_MAP_TYPE_XSKMAP);
-	__uint(max_entries, 2);
+	__uint(max_entries, MAX_SOCKETS);
 	__uint(key_size, sizeof(int));
 	__uint(value_size, sizeof(int));
 } xsk SEC(".maps");
@@ -75,6 +75,19 @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
 	return bpf_redirect_map(&xsk, idx, XDP_DROP);
 }
 
+SEC("xdp") int xsk_xdp_shared_umem_length_based(struct xdp_md *xdp)
+{
+	void *data = (void *)(long)xdp->data;
+	void *data_end = (void *)(long)xdp->data_end;
+	__u32 pkt_len = data_end - data;
+
+	/* Route packets by total XDP-visible packet length. */
+	if (pkt_len <= SHARED_UMEM_LEN_SPLIT)
+		return bpf_redirect_map(&xsk, 0, XDP_DROP);
+	else
+		return bpf_redirect_map(&xsk, 1, XDP_DROP);
+}
+
 SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp)
 {
 	__u32 buff_len, curr_buff_len;
diff --git a/tools/testing/selftests/bpf/xsk_xdp_common.h b/tools/testing/selftests/bpf/xsk_xdp_common.h
index 45810ff552da..bd9b5dcf8c8e 100644
--- a/tools/testing/selftests/bpf/xsk_xdp_common.h
+++ b/tools/testing/selftests/bpf/xsk_xdp_common.h
@@ -3,7 +3,8 @@
 #ifndef XSK_XDP_COMMON_H_
 #define XSK_XDP_COMMON_H_
 
-#define MAX_SOCKETS 2
+#define MAX_SOCKETS 4
+#define SHARED_UMEM_LEN_SPLIT 64
 #define PKT_HDR_ALIGN (sizeof(struct ethhdr) + 2) /* Just to align the data in the packet */
 
 struct xdp_info {
-- 
2.43.0

