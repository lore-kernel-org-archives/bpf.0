Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7701A724C
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999630; cv=none; b=pNQbe2+logtTTZddCrfR+PFilhDf+rPsY68UvMAfCkwG8/qwQlR7RplIvKKHGn5dc+E+boBiShjHEhhIT4fARFcE/jrLwYP4naKXguUKNdJFS+JXjRPln+owZwzSeOE284WnanmRG2wqZv+Ta1TYaAjDZBsJRlpqxZmJFVC2tik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999630; c=relaxed/simple;
	bh=SfJL8LPr6GDe/OJHPFWr3tFTOY3oYhXDoBP3xAEQFZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OvYGt39XNQes17CElsRoCDJa7YGhsMbtHDRupL+B0wek8vm/uTtVQUqHA8taTjFxBtT0zywGI9AFQRMRWf6OMeF2wIgXt018frJjMnDUg6E0x9vTClhYzgXejWGek9+ZKDhAL35kXpLd+980jCozkkIFQxoa0NgzgzeQvxMqi+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFPVz0CT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFPVz0CT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba928852a5so8651805ad.1
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 23:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999629; x=1779604429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIm5luJhGoab49QPoC2ghLiKrO+q0wci/8m1qO+0CIs=;
        b=LFPVz0CTnabNV70QkHAtoy44q6rQUs49dTNMFBysffpLfi2vOyf1eOp3jbwx0kCYx+
         G5lfjak2NYhbubdCBczPUfh0UWdLyee8PWNVtGjn7x6PaElKoLcYzTlBZG8kfw1XCzNt
         vwmXjOYzbcBa5bzxxNkcG6E1mQQHW0Oe79xigVIH5l9NpICRSBf9y7ToHlOcUJ6J/7dK
         gcUCNGz8teQUy2P2loek+IKezPOB9snEKEuvMWlnhQfaYxyg0B3tuMOvWs+alkJUrCco
         9hOexUpwnuMMuW3LPPldSZr1+LRyNq1sKktZo1AdCPMxL1knTKIfyqiRt4Kl0zdOE8vO
         OKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999629; x=1779604429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hIm5luJhGoab49QPoC2ghLiKrO+q0wci/8m1qO+0CIs=;
        b=S0Sul0paWfQvxcgess1z7dspfYqSYbg1Evt8OGb/bIb/sWZcCj32F+GtZPeiWBPkHe
         mNgekgttigDkCWfIKv/nmHEFgLRa2rYNTKeLgWLelfy5NDc13s47UDhYcIR7EZvRKRR/
         bBRnU9bW5sRX6kxlz0YAaTAEKgTZk6jbgtooaMDWCvw32qHQr8MGMXZYyqneQwk7Bv64
         w/CBXtA2cfww8VqUE9h2HBiihM7tl2KFrJ52BSOP5ohjOA9LLaFm0tTsh2DzNLNz7Dtg
         PPH1UwDYX9tD/CIt1l0g9G0fAUxMipxF3lUxQtjxphXdC+HixOV64cYviJJdp2fPBz+P
         iUJg==
X-Gm-Message-State: AOJu0Yz/K2L+InSASLGrPAJY20eAAct5Q27aO3VbwnN0DdVjFJtnbCP6
	+rh+Ral6+ZWs2aUfasjkrWHKJ+9dxBVo/YHuTZpSdn08PCEXQ5iaJJgm
X-Gm-Gg: Acq92OHSmbGNBSX1950uEN5IeIFR4caf/BtUp/oYtjrKccY2MhEliMpd9chAZzL5oUA
	IpVUQ1NVapFRDFTxBgx62rdyB6esyfT5C/JbQhhsRzzKAbQnz83fiYqb1JCgzcehggyZG0wf2Zm
	z5QVWYP+WYSofMncgTErM4dlgTIAhuRVIRU1zRCP1jBruYqkt8ZR2/EPutWt3fTz1VVjhFC5Pp6
	k8eWcs0UVoLITXQ7WYG17ArUMI9Otdebg5f4ooFXeQD4Ea3DG/310gUBH1IGcO93rsX/yTEo531
	OIHIjp8fkrZDGxw6KgKf+po0WF3Ebr5XFsMxl/0uToQ3Eic0nsB27HJS87HT7Vk2/xby1i4KkSJ
	fGc1ELdu7oIkVPalTJ1WdBLredZc2nvT8cACj9XN7S8S7JggWsP9IQKTjYFl19mqbzEB4NJ8cEp
	0I6A+x0Kzg6x3i6/XfyYSDuVRFs71RvQC3ErzBmZKHFO7kk9bzdgVFO10ueT4APkiSUIeVHtnl8
	zWiCnIvl+vVVygH+Br5UhaPo+CG7N8=
X-Received: by 2002:a17:903:950:b0:2bd:a3c5:6d96 with SMTP id d9443c01a7336-2bda3c56ef9mr55165785ad.14.1778999628794;
        Sat, 16 May 2026 23:33:48 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:78ef:13e7:10c0:51d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm111625115ad.14.2026.05.16.23.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:33:48 -0700 (PDT)
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
Subject: [PATCH net v3 5/5] selftests/xsk: drain CQ to wait for TX completion
Date: Sun, 17 May 2026 14:33:11 +0800
Message-Id: <20260517063311.28921-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260517063311.28921-1-kerneljasonxing@gmail.com>
References: <20260517063311.28921-1-kerneljasonxing@gmail.com>
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

