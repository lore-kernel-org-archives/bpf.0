Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125813E6DF5;
	Fri,  2 Oct 2026 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967675; cv=none; b=dPaSbGyRS/IzQNV5ZBH1Q/YRgGoYcAC8oqwp3cRqNSS87DY5A+8jCm9XhtPKD25i5bi/tI2nO2NG5YceYfHxeKn5gfsCQ1uvkrJO0my1aOblbVfy65D8M7oKoXzI4zDiO7UCjDycLIFiddrUYG/qzcwH0Rs3DWYpmZ6r1BwQQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967675; c=relaxed/simple;
	bh=SzL33TGwlflVcblCic2T9ehfarJO86vXhfUJcAVUfxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCH1r8y+voz9kaZ2y0OhMTfiNJx0d2TsYGPuDWH148XNM2SKm66rf5je+aZfodc6yrseKojSLJAswvi+ilbxD9VaCZY05EO3/smwXD6fVh6XObHY/LGkxlfCoGTFYIqtFEp/0KB9UY3UBAQlbKMJYlB4PabrPL85jzKW1Hhse80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F55qbZZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F55qbZZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319E21F0089A;
	Fri,  2 Oct 2026 19:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967664;
	bh=8jyvL4A1/W2TsjCcY99GbAlKcwz5+sDMSGmpziqbmwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F55qbZZ1KVzGZdtRzh4Gcoc8OmpnQgR0JfKhJbYmyeDhjn7RbGWRunE3scB+ZhArW
	 2QsP3CI9ip5k4xFV8CsEaINq5T/cZaJgS2ekXVie1yewkPonSz5FPwawS63aeIXzHQ
	 RZO0cBmZQ+NbhlG49dUszrVUGDUbOtaLnQbK+w6LwnQrWv3+E5zbfT3lyGWzMBFafK
	 AweRc5qH1lmkArc3BbH2VXkUNHg0eTPT+xib8eS1Z0b8ZesTX7TCP8dwNvpPt/sjwP
	 Y5uqOY9AGYUcIn3LVzLsyEzGqoYYgJ6kdOvW85qlhTJG2fvSqZY9k11AYu5rupNZhp
	 Dkg+QNgMOOkLw==
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
	io-uring@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: [RFC net-next 04/15] net: Let memory providers set RX buffer headroom
Date: Fri,  2 Oct 2026 21:00:05 +0200
Message-ID: <20261002190018.696925-5-bjorn@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002190018.696925-1-bjorn@kernel.org>
References: <20261002190018.696925-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

AF_XDP lets userspace choose a headroom in front of the packet data
in each UMEM chunk, and the kernel adds XDP_PACKET_HEADROOM to it. A
driver whose buffers come from an AF_XDP memory provider must put
packets after this headroom. The driver sees only the page pool, so
it has no generic way to learn the value, and nothing checks that
the driver supports it.

Add rx_headroom to the provider parameters and to the queue
configuration. It is the full headroom, including
XDP_PACKET_HEADROOM; zero means the driver default. Add
QCFG_RX_HEADROOM. A provider that sets a headroom can only be
installed on a queue that supports it; otherwise the install fails
with -EOPNOTSUPP. The driver checks the value with the rest of the
queue configuration.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/net/netdev_queues.h   | 6 ++++++
 include/net/page_pool/types.h | 1 +
 net/core/netdev_config.c      | 2 ++
 net/core/netdev_rx_queue.c    | 4 ++++
 4 files changed, 13 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index c5335e935b7d..f9eba63a5d78 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -45,12 +45,16 @@ struct netdev_config {
 /**
  * struct netdev_queue_config - rendered configuration for an RX queue
  * @rx_page_size:	Size of one RX page-pool allocation.
+ * @rx_headroom:	Headroom before packet data in the first buffer,
+ *			including XDP_PACKET_HEADROOM. Zero selects the
+ *			driver default.
  * @rx_ring_size:	Configured size of the regular RX ring.
  * @rx_mini_ring_size:	Configured size of the RX mini ring.
  * @rx_jumbo_ring_size:	Configured size of the RX jumbo ring.
  */
 struct netdev_queue_config {
 	u32	rx_page_size;
+	u32	rx_headroom;
 	u32	rx_ring_size;
 	u32	rx_mini_ring_size;
 	u32	rx_jumbo_ring_size;
@@ -156,6 +160,8 @@ void netdev_stat_queue_sum(struct net_device *netdev,
 enum {
 	/* The queue checks and honours the page size qcfg parameter */
 	QCFG_RX_PAGE_SIZE	= 0x1,
+	/* The queue checks and honours the headroom qcfg parameter */
+	QCFG_RX_HEADROOM	= 0x2,
 };
 
 /**
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index a96376613dda..a673fa35febb 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -172,6 +172,7 @@ struct pp_memory_provider_params {
 	void *mp_priv;
 	const struct memory_provider_ops *mp_ops;
 	u32 rx_page_size;
+	u32 rx_headroom;
 };
 
 struct page_pool {
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index 1975de42a60d..97e33764737b 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -88,6 +88,8 @@ static int __netdev_queue_config(struct net_device *dev, int rxq_idx,
 	mpp = &__netif_get_rx_queue(dev, rxq_idx)->mp_params;
 	if (mpp->rx_page_size)
 		qcfg->rx_page_size = mpp->rx_page_size;
+	if (mpp->rx_headroom)
+		qcfg->rx_headroom = mpp->rx_headroom;
 	err = validate_cb(dev, qcfg, extack);
 	if (err)
 		return err;
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 610e31d1a717..476289000e78 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -248,6 +248,10 @@ static int __netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		NL_SET_ERR_MSG(extack, "device does not support: rx_page_size");
 		return -EOPNOTSUPP;
 	}
+	if (p->rx_headroom && !(qops->supported_params & QCFG_RX_HEADROOM)) {
+		NL_SET_ERR_MSG(extack, "device does not support: rx_headroom");
+		return -EOPNOTSUPP;
+	}
 
 	rxq = __netif_get_rx_queue(dev, rxq_idx);
 	if (rxq->mp_params.mp_ops) {
-- 
2.55.0

