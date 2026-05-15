Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C654947ECF8
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848266; cv=none; b=HEglhEei+HYdvIkrsVi+uw1cM6oNG+H73eZpIpx1jAB/SxR92R+IX6+GJvbWp53HdFkIljz/r55Q8/jqeebqF4GFTWjCBpT2mLKhx68/a/etWXDH0cIeHpUsiyDzm+XQ7w0pw+s7s3ovpXc8zcLS3LwbvkKo6uBNnLtSlLhgcsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848266; c=relaxed/simple;
	bh=hs2LmSIgH01STiKcSK/9r7IMxHjaUYifUvfsId0jjzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ia5+A7mSLoszT2WViM3QnIWhFfNPU63srpBkhYZzjH6dR75dybjBkkMTfkO6eluySgR7Q/On0DybvdNijHmA3FJ5IEK7lH3LHpTmP6E7REPctk0S7n9QKr1uMyFNrb6MsG2GcGjQp6d7nYfwqdLgsg9Jxd2Zni6ksdZp+UC/o/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0aJSVAe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0aJSVAe"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b9e9a6802aso37523355ad.3
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848264; x=1779453064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Q3NoUKNJRcKRULVuQjFHc0i+Q4I9vYzom+1zY7kmT0=;
        b=L0aJSVAeiFPPVpYVdcEHPf1wQV6ZahjQreY8P4A3juXOZ5Sthe4/LA19T3b6qOCm6k
         F/vSMDe9pde1PXZ8FdNt028vnpzahd/k2FV4UDP37/2636mBRpCob/1SV7mr7V+Jsn0L
         ZwyH57iec9omXVNaOxyFKocbtSBVXc06bidfIfP/SjwuUzCpwqzSiJ38l9izoyEaf21B
         S9QOB5CalNPN282uXHktwRMo7pyVjYDzRIQDNY0iGKgzKT9VbhyKHPGK89mbrLLr6dis
         rT8bCW0H0zyV7Qi5R2wQb8H3LyGpsuAGkomkMtFv1Pfjz9h1WmDT6ZYnWnY85F/ti1Ed
         W/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848264; x=1779453064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Q3NoUKNJRcKRULVuQjFHc0i+Q4I9vYzom+1zY7kmT0=;
        b=FfdJeckuz6z3gFU686vbBFmoiIhYx5BsXE7Z03rDfLCIQukwwoOabNYiIRoL7dxHmu
         DJg+to8EMgiP+xxZFnKMk3DpwHEoFiu0ajuKTNa9f0VRSa5PFpr1m+k03OfeX5ssIGaL
         2lfno9IvmTGWfxvifD7QmAVsH36J3go/U/bYd/hXS2RaVhS5iy/BvFRWGA47WwA/Jerc
         tLdovL7U0TROCvIz5uvl0lk6ImlS2HpxLAbKlRiEIPnCWvte+Ghr1Vpeec8RtnymEDDg
         KGLPaAtyRl8Cn6MEDTFyQiWUcoAxnt9WPuizUJb+9Q4dmtbItBbn0FG536Dv+Gyubmb7
         ILgA==
X-Gm-Message-State: AOJu0YxKFKTLzpkWXRKZh5Hg8v8U0vhfzqO3cMJRzEK7cxJJxk6PdiQS
	CgF4TIJRPYg+5C4c+zUHboEMsrGKdKV+RJagJSTs7mAgrJ3eYbaq9J6O
X-Gm-Gg: Acq92OF30l5TspuTyaYHNWGRu9OlCcbRXA9NjFZ7R/jB0TO+dYlluzWUWppEcO6BNuw
	6P3gKSMbYWJpdUnH1rvzM+EGWv3n1KdI0YweUmLsepXumRzZPQ2gKKovodhZrlSAwSNACZ9eafR
	ytgTG2gKkeq+j4sEafIAola17lKVWcgLhcrPxhiuDrSmNwUGsu2cmN6Tt4n5SQ8/tWisNTsQi0f
	y3e3SB0QZPmGf+GJU96hQEOJc02qXkGByl6EN+QGztEXlhBsX4UJ5SXcxAWpgFwkQhHequIbP8S
	hMr0rI/ISHSsfetAuipsH3+aYt/DpR8or8x69WEwpjvsejy80aEqUhfsn+eT62SIvW0tG7PDuPk
	obD8vQZAmDPapMlPXas9DWG8mA+J5afEwSyaME0+VUHsk1Ei0gvAIvvffNpiUi3Mb8DiP0NTuFS
	1gVGiEeFeUIGEM/tg8u7QLwPlkeq4Rx+fGSSvjPsfeJQvee0JGePSzn6tAT/2KPDNX82PpsZV5z
	BV2LFrqlK+NHKPrEq7GsQ4Vj8N4kvU=
X-Received: by 2002:a17:903:1b45:b0:2bd:93b0:2c1c with SMTP id d9443c01a7336-2bd93b02ea0mr13453935ad.3.1778848263992;
        Fri, 15 May 2026 05:31:03 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:a48a:1116:aa2d:1122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe492asm60348885ad.48.2026.05.15.05.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:31:03 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 5/5] selftests/xsk: fix multi-buffer invalid desc tests for drain_cont
Date: Fri, 15 May 2026 20:30:18 +0800
Message-Id: <20260515123018.80147-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260515123018.80147-1-kerneljasonxing@gmail.com>
References: <20260515123018.80147-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

After the kernel xsk drain_cont patches, dropped and drained
multi-buffer descriptors have their buffer addresses published to the
completion queue (CQ) rather than being cancelled. This is the crucial
and correct way, but it leads to the selftests failure.

In the existing selftest, we need to take care of all the sub-tests
with those two things in mind:
1) Invalid packets whose last descriptor has XDP_PKT_CONTD set
   cause drain_cont to leak past the packet boundary, consuming
   subsequent valid packets from the TX ring.
2) The extra CQ entries from dropped descriptors cause outstanding_tx
   to reach zero before the kernel finishes processing all TX ring
   descriptors, so wait_for_tx_completion() exits early and valid
   packets after invalid ones are never transmitted.

This patch makes the following changes to follow the right fixes.
- XSK_DESC__INVALID_OPTION: change the value from 0xffff to 0xfffe,
  so it no longer sets the XDP_PKT_CONTD bit (bit 0).
- complete_pkts: tolerate extra CQ completions by clamping
  outstanding_tx to zero instead of failing.
- wait_for_tx_completion: add a drain loop that consumes CQ entries
  after outstanding_tx reaches zero. Ensure remaining valid packets
  are transmitted. This change is made because of patch 3 in the
  series adds a logic in __xsk_generic_xmit(): return -EOVERFLOW
  after detecting and handling the remaining part of the skb.
- testapp_invalid_desc_mb: clearing XDP_PKT_CONTD on the last
  descriptor of each invalid test packet, so drain stops at the
  packet boundary.
- testapp_too_many_frags: add one new/extra terminating descriptor
  to the invalid packet, so drain_cont stops before the trailing
  sync packet.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 45 ++++++++++---------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 7e38ec6e656b..e23131ef7f18 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -31,7 +31,7 @@
 #define POLL_TMOUT			1000
 #define THREAD_TMOUT			3
 #define UMEM_HEADROOM_TEST_SIZE		128
-#define XSK_DESC__INVALID_OPTION	(0xffff)
+#define XSK_DESC__INVALID_OPTION	(0xfffe)
 #define XSK_UMEM__INVALID_FRAME_SIZE	(MAX_ETH_JUMBO_SIZE + 1)
 #define XSK_UMEM__LARGE_FRAME_SIZE	(3 * 1024)
 #define XSK_UMEM__MAX_FRAME_SIZE	(4 * 1024)
@@ -969,17 +969,11 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 
 	rcvd = xsk_ring_cons__peek(&xsk->umem->cq, batch_size, &idx);
 	if (rcvd) {
-		if (rcvd > xsk->outstanding_tx) {
-			u64 addr = *xsk_ring_cons__comp_addr(&xsk->umem->cq, idx + rcvd - 1);
-
-			ksft_print_msg("[%s] Too many packets completed\n", __func__);
-			ksft_print_msg("Last completion address: %llx\n",
-				       (unsigned long long)addr);
-			return TEST_FAILURE;
-		}
-
 		xsk_ring_cons__release(&xsk->umem->cq, rcvd);
-		xsk->outstanding_tx -= rcvd;
+		if (rcvd > xsk->outstanding_tx)
+			xsk->outstanding_tx = 0;
+		else
+			xsk->outstanding_tx -= rcvd;
 	}
 
 	return TEST_PASS;
@@ -1293,6 +1287,8 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 {
 	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
+	unsigned int rcvd;
+	u32 idx;
 	int ret;
 
 	ret = gettimeofday(&tv_now, NULL);
@@ -1312,6 +1308,14 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 		complete_pkts(xsk, xsk->batch_size);
 	}
 
+	do {
+		if (xsk_ring_prod__needs_wakeup(&xsk->tx))
+			kick_tx(xsk);
+		rcvd = xsk_ring_cons__peek(&xsk->umem->cq, xsk->batch_size, &idx);
+		if (rcvd)
+			xsk_ring_cons__release(&xsk->umem->cq, rcvd);
+	} while (rcvd);
+
 	return TEST_PASS;
 }
 
@@ -2092,10 +2096,10 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 		{0, 0, 0, false, 0},
 		/* Invalid address in the second frame */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
-		{umem_size, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{umem_size, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, 0},
 		/* Invalid len in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
-		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false, 0},
 		/* Invalid options in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XSK_DESC__INVALID_OPTION},
@@ -2250,7 +2254,7 @@ int testapp_too_many_frags(struct test_spec *test)
 		max_frags += 1;
 	}
 
-	pkts = calloc(2 * max_frags + 2, sizeof(struct pkt));
+	pkts = calloc(2 * max_frags + 3, sizeof(struct pkt));
 	if (!pkts)
 		return TEST_FAILURE;
 
@@ -2268,20 +2272,19 @@ int testapp_too_many_frags(struct test_spec *test)
 	}
 	pkts[max_frags].options = 0;
 
-	/* An invalid packet with the max amount of frags but signals packet
-	 * continues on the last frag
-	 */
-	for (i = max_frags + 1; i < 2 * max_frags + 1; i++) {
+	/* An invalid packet with too many frags */
+	for (i = max_frags + 1; i < 2 * max_frags + 2; i++) {
 		pkts[i].len = MIN_PKT_SIZE;
 		pkts[i].options = XDP_PKT_CONTD;
 		pkts[i].valid = false;
 	}
+	pkts[2 * max_frags + 1].options = 0;
 
 	/* Valid packet for synch */
-	pkts[2 * max_frags + 1].len = MIN_PKT_SIZE;
-	pkts[2 * max_frags + 1].valid = true;
+	pkts[2 * max_frags + 2].len = MIN_PKT_SIZE;
+	pkts[2 * max_frags + 2].valid = true;
 
-	if (pkt_stream_generate_custom(test, pkts, 2 * max_frags + 2)) {
+	if (pkt_stream_generate_custom(test, pkts, 2 * max_frags + 3)) {
 		free(pkts);
 		return TEST_FAILURE;
 	}
-- 
2.41.3

