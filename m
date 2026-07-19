Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1932B110;
	Sun, 19 Jul 2026 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784469400; cv=none; b=ZuS0YlKfK2eD0wp7WNakl/3Mg3nfkgDynyy+V3Y/BlCGei+spD1uTZwCoshPNcGXlRl1U3ZqsCqPND6kXwTDLcKmsYShzVnoGAngc5VrmiCVmpxWXtrOnbSXFRtZouIWw9nN77XPhKQsr94ioFlcBNnEoGKOIzJDb35SZAX6SOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784469400; c=relaxed/simple;
	bh=In56bMwFN80CRMg2e5ZCkmhsJL//NrBd6lLxy1wKdo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPS8DdulEkKMW+Y/4pTLG8QQVAJlFGtNPR11BDe9/tsT5x89FDiG6S/6cW2xnrLag8TDm9g/OW6KJnidIQBIiZOuvZXktKNhFFuLX0tykbIU5in8surQ/3JIwpH1LUpIMq8n91eAG1CmNgGOMhxPAtNjjMhvIA1AU6FWx3xXweQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNJpIpqR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNJpIpqR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784469399; x=1816005399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=In56bMwFN80CRMg2e5ZCkmhsJL//NrBd6lLxy1wKdo8=;
  b=SNJpIpqRpUxjhd6iPNpZTEm/DNX7l+R1EEwmwE6niXyOsQip+pvrYgxD
   xjQcmXRE19hLnJfW8s5bt0Js/9vH97Rz79NYOY4YF8rlJoXhN7HIeVoFI
   1eVOKVPBeDpTUSirilnbyibi5/DULyPlplmJpd7evltURRfNK30/n+OR2
   BUAQIADs/Ae2ip8oGnOREsOttXtrV121X3MDta6npoWH9nOwaqIVvGEyo
   zoEUPanTjo6CW1CNzc1xnN0Nu5F/e1dMpyF5BxnzAwDASrw6hUxQ6NCpB
   gK8KthYpJcajs6+41WHrWR3qTHNQt5pc9puThk3annnOmsZ+PkKmKmpbG
   Q==;
X-CSE-ConnectionGUID: RxAi2IOhQIiTcgeZkQohuA==
X-CSE-MsgGUID: nsty33AHQKKEdrIBlNmVCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="88894196"
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="88894196"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 06:56:38 -0700
X-CSE-ConnectionGUID: VaTJLKmUQGWu8t3Guig11w==
X-CSE-MsgGUID: /4+kYBBbQrSmfMQFJvt3yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="260791962"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 19 Jul 2026 06:56:35 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v4 net 6/6] selftests/xsk: account reclaimed invalid Tx descriptors
Date: Sun, 19 Jul 2026 15:56:09 +0200
Message-Id: <20260719135609.147823-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
References: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invalid Tx descriptors are now returned through the completion ring,
regardless of whether they form a standalone packet or belong to an
invalid multi-buffer packet.

The selftests previously counted only descriptors belonging to valid
packets, with a special exception for some invalid multi-buffer packets
in verbatim streams. This undercounts completion entries when a
standalone invalid descriptor or another invalid packet is reclaimed by
the kernel.

Keep valid_pkts as the number of packets expected on the Rx side, but
count every descriptor submitted to the Tx ring in valid_frags, as every
such descriptor is now expected to be returned through the completion
ring.

Make fragment counting in verbatim mode follow the packet boundary
instead of stopping at the first invalid fragment. Update custom stream
generation so an invalid middle fragment terminates the generated Rx
packet while Tx completion accounting still covers the complete invalid
packet.

Also add explicit end fragments after invalid middle descriptors. This
exercises the kernel drain logic and verifies that subsequent valid
packets are not interpreted as continuations of the invalid packet.

Reviewed-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index f0e0f3c4f7a3..4549358cc8c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -427,14 +427,14 @@ static u32 pkt_nb_frags(u32 frame_size, struct pkt_stream *pkt_stream, struct pk
 	}
 
 	/* Search for the end of the packet in verbatim mode */
-	if (!pkt_continues(pkt->options) || !pkt->valid)
+	if (!pkt_continues(pkt->options))
 		return nb_frags;
 
 	next_frag = pkt_stream->current_pkt_nb;
 	pkt++;
 	while (next_frag++ < pkt_stream->nb_pkts) {
 		nb_frags++;
-		if (!pkt_continues(pkt->options) || !pkt->valid)
+		if (!pkt_continues(pkt->options))
 			break;
 		pkt++;
 	}
@@ -665,11 +665,11 @@ static struct pkt_stream *__pkt_stream_generate_custom(struct ifobject *ifobj, s
 			if (!frame->valid || !pkt_continues(frame->options))
 				payload++;
 		} else {
-			if (frame->valid)
+			if (frame->valid) {
 				len += frame->len;
-			if (frame->valid && pkt_continues(frame->options))
-				continue;
-
+				if (pkt_continues(frame->options))
+					continue;
+			}
 			pkt->pkt_nb = pkt_nb;
 			pkt->len = len;
 			pkt->valid = frame->valid;
@@ -1250,10 +1250,9 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 			}
 		}
 
-		if (pkt && pkt->valid) {
+		if (pkt && pkt->valid)
 			valid_pkts++;
-			valid_frags += nb_frags;
-		}
+		valid_frags += nb_frags;
 	}
 
 	pthread_mutex_lock(&pacing_mutex);
@@ -2099,13 +2098,16 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 		{0, 0, 0, false, 0},
 		/* Invalid address in the second frame */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
-		{umem_sz, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{umem_sz * 2, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{0, MIN_PKT_SIZE, 0, false, 0},
 		/* Invalid len in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{0, MIN_PKT_SIZE, 0, false, 0},
 		/* Invalid options in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XSK_DESC__INVALID_OPTION},
+		{0, MIN_PKT_SIZE, 0, false, 0},
 		/* Transmit 2 frags, receive 3 */
 		{0, XSK_UMEM__MAX_FRAME_SIZE, 0, true, XDP_PKT_CONTD},
 		{0, XSK_UMEM__MAX_FRAME_SIZE, 0, true, 0},
@@ -2117,8 +2119,8 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 
 	if (umem->unaligned_mode) {
 		/* Crossing a chunk boundary allowed */
-		pkts[12].valid = true;
-		pkts[13].valid = true;
+		pkts[15].valid = true;
+		pkts[16].valid = true;
 	}
 
 	test->mtu = MAX_ETH_JUMBO_SIZE;
-- 
2.43.0

