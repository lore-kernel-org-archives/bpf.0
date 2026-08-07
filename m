Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4BF418372;
	Fri,  7 Aug 2026 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110259; cv=none; b=ZaeT6EjwK/jJXg7fMW0frbBASjhV7suWR4DFtTD/6HTf0ZonDOkQ6QlE4HvKPxCD6nC1V5CDHZ6ZF5tGIY8z9FUx/1eMwitNTGKmfujuQ3TJRXate+1gk48VuPGWEophUK4FbifW7ymF/oZsHoCfJHTV7zYZYd0edpW3CWhsAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110259; c=relaxed/simple;
	bh=h/cZlYYjndmxEK6dGgFw8l2YYcxd1NzgZqljwz6Bcl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPbGbT/XDQiFFycICwBdwnoOe8xXBRXfuEPlDawFvhW/qjQ3FanIFmk8iiRekof1nHqmon1a27WTbjDcL25v73vY42PDk9hTsxhO5802fCDIZxNgbp4ylKRSfuUS1O/Tq6wA5wWwXSZucxdZW2m+Aph9zFDev/OY8xHUkwjAa1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yhg3zbd4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yhg3zbd4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786110256; x=1817646256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h/cZlYYjndmxEK6dGgFw8l2YYcxd1NzgZqljwz6Bcl0=;
  b=Yhg3zbd4hJTqgBXoxt8EpJoHsTBGkAqe2/awVtqynAM6AadrfvFsjd21
   4rMzgHM6YnPLfI6JEAPKAYWn8sdaVgK6XwbFQsOhheGZYAlt4XUL9oawl
   bOiOsUMMd1O1emEFpbQzpuzoVUzm3BP5kqoSx1/ryQ4qI8VzvybnhIf6N
   xbHrPbhbApJ1YmymjcCSzsRHKlBmoVmuCkv746o+Vzx+8RQ/Ys7GzD5Ol
   FNfwdWGManYJpeFDCgjNq4bpuKHDN+C48lt57xvVOplxezJnVEnFZbZ/5
   D9hjDwwfsiqG/hWTAG1Cop1LK0XKw20FernQ6oh8s7rrI8QthkgjeepXA
   w==;
X-CSE-ConnectionGUID: vA5dj10/SaG84ix7+dgbUQ==
X-CSE-MsgGUID: IWczT8IXQ2CkwnR2o+F8pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="98079947"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="98079947"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 06:44:13 -0700
X-CSE-ConnectionGUID: riB1BGlPSWu+a9ucxehEJA==
X-CSE-MsgGUID: JRviGcLeQ5KZ6+SWjXo6jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="287080060"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 06:44:09 -0700
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
Subject: [PATCH net-next 3/5] selftests/xsk: expand XSKMAP capacity and add length-based XDP program
Date: Fri,  7 Aug 2026 13:42:07 +0000
Message-ID: <20260807134209.3794735-4-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807134209.3794735-1-tushar.vyavahare@intel.com>
References: <20260807134209.3794735-1-tushar.vyavahare@intel.com>
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
 .../selftests/bpf/progs/xsk_xdp_progs.c       | 19 ++++++++++++++++++-
 tools/testing/selftests/bpf/xsk_xdp_common.h  |  3 ++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
index 023d8befd4ca..543b61df3a2b 100644
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
@@ -75,6 +75,23 @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
 	return bpf_redirect_map(&xsk, idx, XDP_DROP);
 }
 
+SEC("xdp") int xsk_xdp_shared_umem_length_based(struct xdp_md *xdp)
+{
+	void *data = (void *)(long)xdp->data;
+	void *data_end = (void *)(long)xdp->data_end;
+	__u32 pkt_len = data_end - data;
+
+	/* 
+	 * Route packets by total XDP-visible packet length (data_end - data):
+	 * - Socket 0: packets <= SHARED_UMEM_LEN_SPLIT bytes
+	 * - Socket 1: packets > SHARED_UMEM_LEN_SPLIT bytes
+	 */
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

