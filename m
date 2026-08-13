Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7AC416842;
	Thu, 13 Aug 2026 06:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602637; cv=none; b=fa01Akmmi5KYICj9/tkPwUzpXpHxjFcnY/ZTJzpkbCCRWMwmX/uyudrHIH7OzZ5RCiplF6U6Oblp8dZ3kt15L+42s3xHYXYNNjd4kAcRrDwkpUtzU5JMrQg3Mfvg4sBTLinzu3TSE+pGtG8zjBk58U9aPisrnam5LG9i31aFDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602637; c=relaxed/simple;
	bh=bbnk4FdY/GIXx22l1jsv+t0jlBYwLws5bAaHSPe1vtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ab0ItUt+TnIOeVDJvp6G8zY/UY/L62Eu/LR6iT1RGAgA/YpX+z8FyIIX79uFGM94zexbhGir2bdFq1v1lZyuNK9VQjoIDz1evPK0mjX4636KGiIpJge1b1h9H0xi3qdsofrbADDr32aieXPmuTm3yEtzYZS5Gj4Ei33e0jf6xIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wjq4/4O4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wjq4/4O4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786602636; x=1818138636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bbnk4FdY/GIXx22l1jsv+t0jlBYwLws5bAaHSPe1vtU=;
  b=Wjq4/4O4XvChXQ3TrUxlsGDZmqnT3PpH+gs05sWp/zqq7weA2a0LGIKk
   kyHjhkOM7w2ZDNH4DwzY3AoO5R0CIZVkZIInWRZAFdOyrNRbBHZWnLOMj
   tkzxo68yMBH95ykQib0o15rqS9DuZjiEm/qRZ4w/vbQL/NpQpsKtFB1f8
   G+NgpOzDTe+ZMDF3GOJi2gjqAc+k/VV48XfUzdfrIJiXSRRjGklkx1KPD
   IYn1Hfc1tqElE2xZwvJjF6SGRSltgczwkGtuKZnjM8IBsumWC4kYEDSf0
   D+Frqb5L/p7CGt0BbrTEqmwE787eUZpx9KO7Pprzp0gJvvO5FuJrE2LAU
   A==;
X-CSE-ConnectionGUID: ERdoQlZjQPGfix6Horon0w==
X-CSE-MsgGUID: 3Oi+1rM/RJeTKWMp1N9k+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="86933896"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="86933896"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:30:36 -0700
X-CSE-ConnectionGUID: t77xHSGESNu7oY70k7hkWw==
X-CSE-MsgGUID: a/oRaOy0RmuE3APLQyybvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="260033496"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:30:31 -0700
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
Subject: [PATCH net-next v2 3/5] selftests/xsk: expand XSKMAP capacity and add length-based XDP program
Date: Thu, 13 Aug 2026 06:27:52 +0000
Message-ID: <20260813062754.360131-4-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813062754.360131-1-tushar.vyavahare@intel.com>
References: <20260813062754.360131-1-tushar.vyavahare@intel.com>
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

