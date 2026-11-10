Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306127;
	b=K0WvqsWvUpOsdbXUGAyyPSVGzabM8zhyOLL269zOaHDEPvm81Gs01loMpQ1LUrGpxrpW
	 oAHC0L7cd2jrWpwDmW3CXJw9Py4LhD+aTxuiARhfFQ5N+FAXiB6I3oF0VMufEhLeuwRor
	 4+xOdBzXAH/nvKhmSHGeIeylLXLkIK780CFf2MwqE6+NMzMtVgJah+ozVphjC/lhwjhuF
	 i76I0a6JLB4Ho0ns5Z7JwuCaEqWnW0PskSPp9onSAoUdE8CZUTxn+Z+eK+qfZ74QU9FWB
	 oPQPsD2UY/Y2sBt0YHB0YZJidl8hBTZnlGIpjzOCu2GS566ri7DFYlykkbfk0PKpwAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306127;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TE03zKRtakXMbpZgUaVDgEAOjhpiZZnJlNozRnhu2Ag=;
	b=q0sdyCeN1+GQ2cJhxRz1lpXOOnnNdRU2F7cp+cxmtEH2HIL4tu9Uqds1aNJSe+QICzOr
	 7MlO1gPG4BnRLjZnPd5dm3aot8iNMGd7fACsKliarvAgbdP/nezWQW1tSGx+oWTN+Zex3
	 i3o7Uv4TslWlnDjlgU+4L7s4YBwoBywOJBSS3srvAeYrI1NT67ar2w8pqRjCpYBKxy8r7
	 fbc2bGHcu0cp7a95twXwhF6uq+3c2062lLR534J2fNlKltYhg6YQAJiYOzQheZjPrUpNM
	 1v9+1WcdKZ6ghuzyFoHBtYmfBJLcq75jEMPhsQfbVOBgGhZhmDRSnorrJEku2ne7Ieg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwlzkjVM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BA660A3821;
	Tue, 10 Nov 2026 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwlzkjVM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A6B1F008A2;
	Tue, 10 Nov 2026 10:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306126;
	bh=TE03zKRtakXMbpZgUaVDgEAOjhpiZZnJlNozRnhu2Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XwlzkjVM9DPNyOWJiufGORgnrPBP7dcv/l47AwkiiBGSo990PjMXKZCTIobZhnIF4
	 nySXU7ZH46huN3fr3OveaNNizj5rotAeulijmMaCJnXbUzfdLyS6toyVOo7Pdlq4Sp
	 jzvwQGLpbEOehKls86rH3TWMwmCf16tDFCgokwK6DY1jIzjxkql6dbQ+OTASfoEYAl
	 WaAVsV6eTnmGyppFHwBhQodipQuGA8Sc+Mhz3nyNWbiov+3osge6AzfvHEDtxvSosz
	 bLA/PSmQN9qHDq9A7g7eIGgrUpnE/JJxRZpHgaH4vgyvuMwdfd1Z3EnUo/CpgTssd5
	 Uyw3iFMUvTDgA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	io-uring@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stuart Clark <stuclar@meta.com>
Subject: [PATCH net-next v1 08/11] eth: fbnic: Support XDP redirect
Date: Tue, 10 Nov 2026 11:20:29 +0100
Message-ID: <20261110102039.1002605-9-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110102039.1002605-1-bjorn@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fbnic treats XDP_REDIRECT as an invalid action and drops the packet,
so AF_XDP, devmap and cpumap do not work. A failed redirect counts as
received, as XDP_DROP does, and as dropped.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  4 +++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 8a6703afca38..ae2585508690 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -822,7 +822,9 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->hw_enc_features |= netdev->features;
 	netdev->features |= NETIF_F_NTUPLE;
 
-	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_RX_SG;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC |
+			       NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_RX_SG;
 
 	netdev->min_mtu = IPV6_MIN_MTU;
 	netdev->max_mtu = FBNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 0bcee152d47c..51d573c9c5b8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -22,6 +22,8 @@ enum {
 	FBNIC_XDP_PASS = 0,
 	FBNIC_XDP_CONSUME,
 	FBNIC_XDP_TX,
+	FBNIC_XDP_REDIRECT,
+	FBNIC_XDP_REDIRECT_ERR,
 	FBNIC_XDP_LEN_ERR,
 };
 
@@ -1211,6 +1213,10 @@ static struct sk_buff *fbnic_run_xdp(struct fbnic_napi_vector *nv,
 		return fbnic_build_skb(nv, pkt);
 	case XDP_TX:
 		return ERR_PTR(fbnic_pkt_tx(nv, pkt));
+	case XDP_REDIRECT:
+		if (xdp_do_redirect(nv->napi.dev, &pkt->buff, xdp_prog))
+			return ERR_PTR(-FBNIC_XDP_REDIRECT_ERR);
+		return ERR_PTR(-FBNIC_XDP_REDIRECT);
 	default:
 		bpf_warn_invalid_xdp_action(nv->napi.dev, xdp_prog, act);
 		fallthrough;
@@ -1280,6 +1286,7 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 	struct fbnic_ring *rcq = &qt->cmpl;
 	struct fbnic_pkt_buff *pkt;
 	__le64 *raw_rcd, done;
+	bool redirect = false;
 	u32 head = rcq->head;
 
 	done = (head & (rcq->size_mask + 1)) ? cpu_to_le64(FBNIC_RCD_DONE) : 0;
@@ -1336,6 +1343,16 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 				pkt_tail = nv->qt[0].sub1.tail;
 			} else if (PTR_ERR(skb) == -FBNIC_XDP_CONSUME) {
 				fbnic_put_pkt_buff(qt, pkt, 1);
+			} else if (skb == ERR_PTR(-FBNIC_XDP_REDIRECT)) {
+				redirect = true;
+			} else if (skb == ERR_PTR(-FBNIC_XDP_REDIRECT_ERR)) {
+				/* A broadcast may queue frames, then fail. XDP
+				 * consumed the packet, so it also counts as
+				 * received.
+				 */
+				redirect = true;
+				dropped++;
+				fbnic_put_pkt_buff(qt, pkt, 1);
 			} else {
 				if (!skb)
 					alloc_failed++;
@@ -1377,6 +1394,8 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 
 	if (pkt_tail >= 0)
 		fbnic_pkt_commit_tail(nv, pkt_tail);
+	if (redirect)
+		xdp_do_flush();
 
 	/* Unmap and free processed buffers */
 	if (head0 >= 0)
-- 
2.56.0

