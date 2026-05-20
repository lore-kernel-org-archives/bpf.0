Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60911227BB9
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237810; cv=none; b=D/suC0Nd8njE9QO/fMsb0tL5DeCgVRyF2SPdMDmFkiEbGzJJPNfgx6lV3aUB7ECUi9TNBEWWt6CXszyQO4/rUNcwwFF+Evp8ED7n1Hehgl5X2/XQZ6anfxMqpwqpFWbTQfpHVj3VfFW7LGqcTRwy3cPRkMNIUaiW39TADRoYWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237810; c=relaxed/simple;
	bh=SfJL8LPr6GDe/OJHPFWr3tFTOY3oYhXDoBP3xAEQFZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fdvoBcetk9UTGQtNAyXXdbWHezem0cGGKuo/wCt5sAI8HrVGiVVKxw1dUjszlx8738+GnpLf6BFfFnYGLHeBJGTN//uFoVFESakyOW+jPUobo37DYcHZ7SPOts01D3QOtr3xrHNlbB37fB+UTFT6DNoDiqVc3oxp9QgZt69xfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG42ZrdZ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG42ZrdZ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-366375c4076so1529812a91.3
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 17:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779237808; x=1779842608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIm5luJhGoab49QPoC2ghLiKrO+q0wci/8m1qO+0CIs=;
        b=kG42ZrdZfsuIxYwfGIAIbW3Ey3bsdgUl6/tBGaCLyDEbrdX6pvGreHuKjktN/XpzO1
         lS+9XVwoTp4AJEvgrT/yx65r/w055Y8d5MCWWjFW1Za91qSmB7BIxH/zLaD3wfYDffvn
         s9SJ1PrS2f95/hBPZbL1m8ujiiWqU95+EEs6zOePDSSEAbzXlO6UeF986M9tSINlZYu1
         y7zMuWicwC6FTSVSNvGPBPwW4JHZvJ1xddA1Y4uwHO0fzFATHIdQjZQGdwhKl7/Rbgu4
         gIjfTCDjzOXfUwzbR5hFg7E8JvSZ4aTHGq0zLsqLY9ozoy+VFdrme2lA/l08Jk2fa7Lh
         O7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779237808; x=1779842608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hIm5luJhGoab49QPoC2ghLiKrO+q0wci/8m1qO+0CIs=;
        b=UuPFve4NMGa79swUllo259iwrOGEqzb2Em6dz/Qm49qFf3aQcS7GrRczli9QFkwZRm
         ddTmU0iicUYwoOpq2bCUkq88T95tRUPvFz7qpc2CwlJVg1effS19U1rrTQxKG1i3iLFf
         WzucPHZfYKtmOQRvViXDrzvo3jPChhV2DBDVaefImog9VpwauX2HWvYBrRTATA/hUnrj
         gLnIPBpvsLdhISdpqEvSeAAU4gkaCufQtYlZhLrMcwRROmccNqPawb3yCcBrld0Kdxbj
         p/O24uyqVjWTaCb+rZZ0u1nYg1J6d5ORTSmd7h1GkxS/ndRWO2qP3SxdocfDLQXuW/lR
         9lhg==
X-Gm-Message-State: AOJu0YzVQ3ptkgpBJjUlhG8oW/hqj6BYO4i5Y9g02yIuImevppdmcQuT
	Ykj4ojX0DZV/ZiLnOXBvOObK7Yrsg8+Sn9Ih9w9JDSpv0vh3MdKYOpe+
X-Gm-Gg: Acq92OH/FvDPm3HFljl1wGAn0sSsXQahWRDZ/Vv9/RHXs4fv1B6Bd9HNRE92iK0/HDP
	GDt34BTnfla3O/nQ5FQDvYYLYjtjw2Mhxqrm/I4xfKKz0zxJBuVq48XN9iY4So00ETXHqefcZIb
	b+1WHWTbdqxNXoijLIo8VPwLx6wBQ9ZhILhMCKNj5ZL6yNbNMBYXoFKxqBhiM+0ZRHee++skv1J
	9KM5sqkzrM9+/4HVDlSslctq+CNybi/eRvthFB+8wxOYYQhqQflWrG23ueBCGM0p1HhiP+XIOmX
	+TEuiO0KNquLc7xhlJMxItE//OxfgE2A1/d6xSClGH69dK5cP23DQQeeTgEgF/tkcOxl+t/mwpY
	10QdYqxbqdoh913XojFheAZj0Co1Q4OgK6TNKAs/QTUdE+BcIe7VFfIvXcuxK6aksMg3Hdm355P
	nOgE3rJ6eG7wolgCM1KK3a11ExcaE1kap4QLOfxLlQCfoUJp7PAhL7r+hfUX/aQdC0LhOjLoFlV
	X3WKv8DKw6TCyn5bS65yzAckPSlhp7JkNyFVhJe+g==
X-Received: by 2002:a17:90b:38cf:b0:35f:b647:d98a with SMTP id 98e67ed59e1d1-369519c6bcfmr20468519a91.5.1779237807712;
        Tue, 19 May 2026 17:43:27 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:f1df:d520:8103:19c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951059f4dsm14746277a91.0.2026.05.19.17.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:43:27 -0700 (PDT)
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
Subject: [PATCH net v4 5/5] selftests/xsk: drain CQ to wait for TX completion
Date: Wed, 20 May 2026 08:42:44 +0800
Message-Id: <20260520004244.55663-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260520004244.55663-1-kerneljasonxing@gmail.com>
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

After the kernel xsk drain_cont patches, dropped multi-buffer
descriptors get their buffer addresses published to the completion
queue (CQ) via the skb destructor instead of being cancelled. As a
result, the CQ entries observed by user space no longer match the
software-side accounting based on valid_frags only:
__send_pkts() bumps xsk->outstanding_tx by valid_frags, while
complete_pkts() decrements it by every CQ entry it consumes,
including those produced by drops/drains. This makes
outstanding_tx underflow and causes wait_for_tx_completion() to
exit while valid descriptors are still sitting in the TX ring,
which in turn makes receive_pkts() time out for the
ALIGNED_INV_DESC_MULTI_BUFF, UNALIGNED_INV_DESC_MULTI_BUFF and
TOO_MANY_FRAGS subtests.

Fix this with two changes to the TX completion path:
- complete_pkts(): tolerate extra CQ completions by clamping
  outstanding_tx to zero instead of failing.
- wait_for_tx_completion(): after the outstanding_tx loop finishes,
  add a drain loop that kicks TX and consumes remaining CQ entries.
  After the drain loop exits, do a short usleep and one final
  complete_pkts() call so that real hardware (e.g. ice) has enough
  time to post late CQ entries before we conclude the ring is
  fully drained.

Adjust the multi-buffer invalid-desc tests so that the last
descriptor of every invalid packet has XDP_PKT_CONTD cleared.
Without this, the kernel drain_cont logic would consume
descriptors past the packet boundary and eat into the next valid
packet, breaking pkt_nb validation. Concretely:
- XSK_DESC__INVALID_OPTION is changed from 0xffff to 0xfffe so it
  no longer asserts the XDP_PKT_CONTD bit (bit 0).
- testapp_invalid_desc_mb() clears XDP_PKT_CONTD on the trailing
  descriptor of the invalid-address and invalid-length packets.
- testapp_too_many_frags() appends one extra terminating
  descriptor so the over-sized invalid packet ends with
  XDP_PKT_CONTD cleared, preventing the drain from spilling into
  the trailing sync packet.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++--------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 7950c504ed28..1f196c8ebc73 100644
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
@@ -950,17 +950,11 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 
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
@@ -1274,6 +1268,8 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 {
 	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
+	unsigned int rcvd;
+	u32 idx;
 	int ret;
 
 	ret = gettimeofday(&tv_now, NULL);
@@ -1293,6 +1289,17 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
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
+	usleep(100);
+	complete_pkts(xsk, xsk->batch_size);
+
 	return TEST_PASS;
 }
 
@@ -2075,10 +2082,10 @@ int testapp_invalid_desc_mb(struct test_spec *test)
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
@@ -2229,7 +2236,7 @@ int testapp_too_many_frags(struct test_spec *test)
 		max_frags += 1;
 	}
 
-	pkts = calloc(2 * max_frags + 2, sizeof(struct pkt));
+	pkts = calloc(2 * max_frags + 3, sizeof(struct pkt));
 	if (!pkts)
 		return TEST_FAILURE;
 
@@ -2247,20 +2254,19 @@ int testapp_too_many_frags(struct test_spec *test)
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
2.43.7

