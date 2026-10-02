Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08D3EC81C;
	Fri,  2 Oct 2026 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967714; cv=none; b=F22tn3VFxfmVgVzLjfIDVE3kP2HhQfq993a9FTooMrOjDbUM8tl0VoovlkDhXFsc2tPSkfEJlLbk0WT12DxXKUvXpTPFMaoimYKO9b4T55H9IM2Zk1/OwHRCFiHbLRervFo525RKRA2j6t5JnqbXC1jwVLhvnm3PhFfI3N2jBmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967714; c=relaxed/simple;
	bh=b0c+g7qNdCuX+J+2/JhzXfdar1yscywjBEcA8Nj5TGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLyElZuNU1cyaA1vUqfckCJZEwpeXWy0YMXKMTfkHPoHvA3iZhqHzFdJsMsir5WAyK9PfOssZQmUJFQPK6/0hXQEVjQeoFW2BYwldkrbmwa7ETEjafkkpF00La2uhqEHIT/PNakDYJDKnsfG4U6f3BQcUFMYGk3Pn3qyF+5Wce8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMoMo5rR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMoMo5rR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2F11F00893;
	Fri,  2 Oct 2026 19:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967712;
	bh=tKCEbS41m+1mc3fxCn57PU4F5LNfBGsvulLTLPP06xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AMoMo5rRKJDmijulvVoM5xrbviY+4kNcSnr6SXpOpFp12MgFyFQSO4QJR9/rXAhUt
	 EVVxUOJK5NqT5VXSZ9fNisbFbjzzn9o/naE+383KvuHc6BKaZxT9mnzR2GzJkcEnRx
	 htbpRoB3LogHVSj2V6kpBD7ds67wOV06Ml/NY2aXh6XbsAOeAPeMLjrd+OepMEmYVm
	 /xoZM3FeBm7uT0AuRmVYs0jx3si/jZIOWYzC/LhU66gufTnVkDHrcoqr6m9H3kK29O
	 kosE0alJLg9LrFbduct1pAm2MQ0g0q0pO146olYiNkqP5UvAq7ackhW14vk9WQN3KB
	 oBgkVMqMHuaoQ==
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
Subject: [RFC net-next 10/15] xsk: Add RX helpers for page-pool drivers
Date: Fri,  2 Oct 2026 21:00:11 +0200
Message-ID: <20261002190018.696925-11-bjorn@kernel.org>
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

A driver that uses an XSK pool as its page-pool provider must know
whether the pool on a queue is the installed provider, or only
registered on the queue. It also needs the scatter-gather setting of
the pool.

Add xsk_get_pool_from_rxq(), which returns the pool only while it is
the queue's installed provider, and xsk_pool_uses_sg(). Name the
128-byte RX frame alignment XSK_RX_FRAME_SIZE_ALIGN. Add
!CONFIG_XDP_SOCKETS stubs for the new helpers and for two frame-size
helpers that had none, so drivers need no #ifdefs.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/net/xdp_sock_drv.h | 46 +++++++++++++++++++++++++++++++++++++-
 net/xdp/xsk_buff_pool.c    |  2 +-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index b9288f5dd48b..28461e675b8e 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -6,6 +6,7 @@
 #ifndef _LINUX_XDP_SOCK_DRV_H
 #define _LINUX_XDP_SOCK_DRV_H
 
+#include <net/netdev_rx_queue.h>
 #include <net/xdp_sock.h>
 #include <net/xsk_buff_pool.h>
 
@@ -13,6 +14,7 @@ struct netlink_ext_ack;
 
 #define XDP_UMEM_MIN_CHUNK_SHIFT 11
 #define XDP_UMEM_MIN_CHUNK_SIZE (1 << XDP_UMEM_MIN_CHUNK_SHIFT)
+#define XSK_RX_FRAME_SIZE_ALIGN	128
 
 #define NETDEV_XDP_ACT_XSK	(NETDEV_XDP_ACT_BASIC |		\
 				 NETDEV_XDP_ACT_REDIRECT |	\
@@ -34,12 +36,33 @@ int xsk_pool_setup_page_pool(struct net_device *dev, struct xsk_buff_pool *pool,
 			     u16 queue_id, struct netlink_ext_ack *extack);
 struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
 					    u16 queue_id);
+
+/* Return the XSK pool only while it is the installed RX memory provider. */
+static inline struct xsk_buff_pool *
+xsk_get_pool_from_rxq(struct net_device *dev, u16 queue_id)
+{
+	struct netdev_rx_queue *rxq;
+	struct xsk_buff_pool *pool;
+
+	if (queue_id >= dev->real_num_rx_queues)
+		return NULL;
+
+	rxq = __netif_get_rx_queue(dev, queue_id);
+	pool = rxq->pool;
+	return pool == rxq->mp_params.mp_priv ? pool : NULL;
+}
+
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool);
 void xsk_set_tx_need_wakeup(struct xsk_buff_pool *pool);
 void xsk_clear_rx_need_wakeup(struct xsk_buff_pool *pool);
 void xsk_clear_tx_need_wakeup(struct xsk_buff_pool *pool);
 bool xsk_uses_need_wakeup(struct xsk_buff_pool *pool);
 
+static inline bool xsk_pool_uses_sg(struct xsk_buff_pool *pool)
+{
+	return pool->umem->flags & XDP_UMEM_SG_FLAG;
+}
+
 static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
 {
 	return XDP_PACKET_HEADROOM + pool->headroom;
@@ -73,7 +96,7 @@ static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
 	mbuf = pool->dev && (umem->flags & XDP_UMEM_SG_FLAG);
 	frame_size -= xsk_pool_get_tailroom(mbuf);
 
-	return ALIGN_DOWN(frame_size, 128);
+	return ALIGN_DOWN(frame_size, XSK_RX_FRAME_SIZE_ALIGN);
 }
 
 static inline u32 xsk_pool_get_rx_frag_step(struct xsk_buff_pool *pool)
@@ -388,6 +411,12 @@ xsk_get_pool_from_qid(struct net_device *dev, u16 queue_id)
 	return NULL;
 }
 
+static inline struct xsk_buff_pool *
+xsk_get_pool_from_rxq(struct net_device *dev, u16 queue_id)
+{
+	return NULL;
+}
+
 static inline void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 }
@@ -409,16 +438,31 @@ static inline bool xsk_uses_need_wakeup(struct xsk_buff_pool *pool)
 	return false;
 }
 
+static inline bool xsk_pool_uses_sg(struct xsk_buff_pool *pool)
+{
+	return false;
+}
+
 static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
 {
 	return 0;
 }
 
+static inline u32 xsk_pool_get_tailroom(bool mbuf)
+{
+	return 0;
+}
+
 static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
 {
 	return 0;
 }
 
+static inline u32 __xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
+{
+	return 0;
+}
+
 static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
 {
 	return 0;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index e25347f8c208..9c32fb165533 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -261,7 +261,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	 */
 	frame_size = __xsk_pool_get_rx_frame_size(pool) -
 		     xsk_pool_get_tailroom(mbuf);
-	frame_size = ALIGN_DOWN(frame_size, 128);
+	frame_size = ALIGN_DOWN(frame_size, XSK_RX_FRAME_SIZE_ALIGN);
 
 	if (needed > frame_size * segs) {
 		err = -EINVAL;
-- 
2.55.0

