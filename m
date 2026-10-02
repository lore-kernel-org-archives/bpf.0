Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557683E92B7;
	Fri,  2 Oct 2026 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967729; cv=none; b=pf4FpIalS66tAJQboYF6dIuyFK+Ye6TQQGlQsSTYYnTn7vY3az7SWgAdhcOuI3H6j9F8CYuKCvNkBjkT6jOvdh0Teu1uBuOu3Gzs3DTCYpdd+EV/MeJ+uuFXUuIQh1GZHz7dF2VpHd+m1rqZIJvYuR8g6IFDBrFHiF+1VFhZZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967729; c=relaxed/simple;
	bh=BvaNiVyOdvaJ9lcASEKoAyouybA+BprY7ntNy364lnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USXWMEesW+Wvubm87eSHoBuehDnhnbsoFs+BqFLZWyE4FjK/g1LZpvQE8yThM2C8yLpGtajD3bWgCLVRa6Uh1ez5vOJYSC0XOPBHSVz0aJxDo6cZuTIFSZNurQd//R4ol5T1brQp4FrDYvAO5s0so11s70pHAocqrsV9FUibeUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPJZe1KQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPJZe1KQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C731F0089D;
	Fri,  2 Oct 2026 19:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967727;
	bh=DJBZri6RwI1zh+rg8vyUOSH5xDQ/G73I5fqAWKm7xis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NPJZe1KQwC236yQGxWyegiTTBG3NWqyqzbUWRGm2WsJB0uaBufAOozBps3P3lQoZN
	 9C1B1HzMGtRT/ei2gRJIEXgLfaJGAXoE2/zryVtrHG0fEJYYPKbTOJfdf4lxhX3Q0g
	 OhPgU3PSaD6YYRC0X94QLrOsRo8KBfgciOLRJ8qtre8tuO5WS1atf2nD780bVbMXe2
	 Us1AviMaEVaGDyEL6CRt0jN1+tQrcvckLjVHb9fNPlEuwV8p7dZ3FxIxm6HtEpQkkg
	 ejmEiADm3HTnmGLPQSgYFUzKOfdFn853vX/riZC9olKA2e0367XnCW49XPdX2xoDaf
	 BQb8t7mPJQX9w==
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
Subject: [RFC net-next 12/15] xsk: Receive provider UMEM without copying
Date: Fri,  2 Oct 2026 21:00:13 +0200
Message-ID: <20261002190018.696925-13-bjorn@kernel.org>
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

When all buffers of a packet come from the provider of the target
socket, put their UMEM addresses straight on the socket's RX ring.
For a single-buffer packet, xsk_rcv() checks the head buffer. For a
multi-buffer packet, every fragment is checked. A socket without
XDP_USE_SG drops multi-buffer packets and counts them in rx_dropped.
If any fragment comes from elsewhere, the packet is copied as
before. Fragment descriptors carry the offset that the device used.

The buffers leave page_pool ownership in batches when the socket is
flushed. A batch is split where a queue restart changed the page
pool.

The copy path now reads fragments with xdp_frag_address().

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/net/xdp_sock.h |  10 +++
 net/xdp/xsk.c          | 191 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 198 insertions(+), 3 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 6e70b320b399..92a7cf49f5e3 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -12,10 +12,18 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
+#include <net/netmem.h>
 #include <net/sock.h>
 
 #define XDP_UMEM_SG_FLAG BIT(3)
 
+/* Bound both one maximum-SG packet and single-buffer release batching. */
+#if MAX_SKB_FRAGS < 31
+#define XSK_PP_RELEASE_BATCH 32
+#else
+#define XSK_PP_RELEASE_BATCH (MAX_SKB_FRAGS + 1)
+#endif
+
 struct net_device;
 struct xsk_queue;
 struct xdp_buff;
@@ -61,6 +69,8 @@ struct xdp_sock {
 		XSK_BOUND,
 		XSK_UNBOUND,
 	} state;
+	u32 pp_release_cnt;
+	netmem_ref pp_release[XSK_PP_RELEASE_BATCH];
 
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
 	struct list_head tx_list;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 90c98b42a18a..99bd2bc79467 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -30,6 +30,7 @@
 #include <net/busy_poll.h>
 #include <net/netdev_lock.h>
 #include <net/netdev_rx_queue.h>
+#include <net/page_pool/memory_provider.h>
 #include <net/xdp.h>
 
 #include "../core/dev.h"
@@ -267,6 +268,157 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	return err;
 }
 
+static bool xsk_pp_can_xfer(struct xsk_buff_pool *pool, netmem_ref *netmems,
+			    u32 count)
+{
+	u32 i;
+
+	if (WARN_ON_ONCE(!count || count > MAX_SKB_FRAGS + 1))
+		return false;
+
+	for (i = 0; i < count; i++)
+		if (!xp_netmem_is_from_pool(netmems[i], pool))
+			return false;
+
+	return true;
+}
+
+static void xsk_pp_release_to_user_bulk(netmem_ref *netmems, u32 count)
+{
+	struct page_pool *pp, *next;
+	u32 first = 0, i;
+
+	if (WARN_ON_ONCE(!count || count > XSK_PP_RELEASE_BATCH))
+		return;
+
+	/* One poll of one queue fills the batch, so it normally shares a
+	 * page pool. Split it where a queue replacement changed the pool.
+	 */
+	pp = netmem_get_pp(netmems[0]);
+	for (i = 1; i < count; i++) {
+		next = netmem_get_pp(netmems[i]);
+		if (next == pp)
+			continue;
+
+		net_mp_release_page_pool_bulk(pp, netmems + first, i - first);
+		pp = next;
+		first = i;
+	}
+	net_mp_release_page_pool_bulk(pp, netmems + first, count - first);
+}
+
+static void xsk_pp_flush(struct xdp_sock *xs)
+{
+	u32 count = xs->pp_release_cnt;
+
+	if (!count)
+		return;
+
+	/* Provider descriptors are the tail of the unpublished RX entries. */
+	xsk_pp_release_to_user_bulk(xs->pp_release, count);
+	xs->pp_release_cnt = 0;
+}
+
+static void xsk_pp_release(struct xdp_sock *xs, netmem_ref netmem)
+{
+	xs->pp_release[xs->pp_release_cnt++] = netmem;
+}
+
+static void xsk_rcv_pp_zc_desc(struct xdp_sock *xs, netmem_ref netmem,
+			       void *data, u32 len, u32 flags)
+{
+	__xskq_prod_reserve_desc(xs->rx, data - xs->pool->addrs, len, flags);
+	xsk_pp_release(xs, netmem);
+}
+
+static __always_inline int xsk_rcv_pp_zc_one(struct xdp_sock *xs,
+					     struct xdp_buff *xdp, u32 len)
+{
+	netmem_ref netmem = xdp_buff_get_netmem(xdp);
+
+	if (xskq_prod_nb_free(xs->rx, 1) < 1) {
+		xs->rx_queue_full++;
+		return -ENOBUFS;
+	}
+	if (unlikely(xs->pp_release_cnt == XSK_PP_RELEASE_BATCH)) {
+		xsk_pp_flush(xs);
+		xskq_prod_submit(xs->rx);
+	}
+
+	__xskq_prod_reserve_desc(xs->rx, xdp->data - xs->pool->addrs, len, 0);
+	xsk_pp_release(xs, netmem);
+	return 0;
+}
+
+static noinline int xsk_rcv_pp_zc_sg(struct xdp_sock *xs,
+				     struct xdp_buff *xdp, u32 nr_frags)
+{
+	netmem_ref netmems[MAX_SKB_FRAGS + 1];
+	struct skb_shared_info *sinfo;
+	u32 num_desc;
+	u32 flags;
+	u32 len;
+	u32 i;
+
+	BUILD_BUG_ON(MAX_SKB_FRAGS + 1 > XSK_PP_RELEASE_BATCH);
+
+	if (xs->pp_release_cnt) {
+		xsk_pp_flush(xs);
+		xskq_prod_submit(xs->rx);
+	}
+
+	sinfo = xdp_get_shared_info_from_buff(xdp);
+	num_desc = nr_frags + 1;
+	netmems[0] = xdp_buff_get_netmem(xdp);
+	for (i = 0; i < nr_frags; i++)
+		netmems[i + 1] = skb_frag_netmem(&sinfo->frags[i]);
+
+	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
+		xs->rx_queue_full++;
+		return -ENOBUFS;
+	}
+	if (!xsk_pp_can_xfer(xs->pool, netmems, num_desc))
+		return -EXDEV;
+
+	len = xdp->data_end - xdp->data;
+	flags = XDP_PKT_CONTD;
+	xsk_rcv_pp_zc_desc(xs, netmems[0], xdp->data, len, flags);
+
+	for (i = 0; i < nr_frags; i++) {
+		const skb_frag_t *frag = &sinfo->frags[i];
+		void *data = xdp_frag_address(frag);
+
+		if (i == nr_frags - 1)
+			flags = 0;
+
+		xsk_rcv_pp_zc_desc(xs, netmems[i + 1], data,
+				   skb_frag_size(frag),
+				   flags);
+	}
+	xsk_pp_flush(xs);
+	xskq_prod_submit(xs->rx);
+
+	return 0;
+}
+
+static int xsk_rcv_pp_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
+{
+	u32 nr_frags;
+
+	if (likely(!xdp_buff_has_frags(xdp)))
+		return xsk_rcv_pp_zc_one(xs, xdp, len);
+	if (unlikely(!xs->sg)) {
+		xs->rx_dropped++;
+		return -ENOSPC;
+	}
+
+	nr_frags = READ_ONCE(xdp_get_shared_info_from_buff(xdp)->nr_frags);
+	if (unlikely(!nr_frags || nr_frags > MAX_SKB_FRAGS))
+		return -EINVAL;
+
+	return xsk_rcv_pp_zc_sg(xs, xdp, nr_frags);
+}
+
 static void *xsk_copy_xdp_start(struct xdp_buff *from)
 {
 	if (unlikely(xdp_data_meta_unsupported(from)))
@@ -289,7 +441,7 @@ static u32 xsk_copy_xdp(void *to, void **from, u32 to_len,
 			return copied;
 
 		if (*from_len == copy_len) {
-			*from = skb_frag_address(*frag);
+			*from = xdp_frag_address(*frag);
 			*from_len = skb_frag_size((*frag)++);
 		} else {
 			*from += copy_len;
@@ -461,12 +613,18 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	return 0;
 }
 
-static void xsk_flush(struct xdp_sock *xs)
+static void __xsk_flush(struct xdp_sock *xs)
 {
+	xsk_pp_flush(xs);
 	xskq_prod_submit(xs->rx);
 	/* Provider pools publish FILL consumption under the provider lock. */
 	if (!READ_ONCE(xs->pool->pp))
 		__xskq_cons_release(xs->pool->fq);
+}
+
+static void xsk_flush(struct xdp_sock *xs)
+{
+	__xsk_flush(xs);
 	sock_def_readable(&xs->sk);
 }
 
@@ -485,8 +643,9 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 		return -EOPNOTSUPP;
 	}
 	err = __xsk_rcv(xs, xdp, len);
-	xsk_flush(xs);
+	__xsk_flush(xs);
 	spin_unlock_bh(&xs->pool->rx_lock);
+	sock_def_readable(&xs->sk);
 
 	return err;
 }
@@ -520,9 +679,31 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 		return err;
 
 	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL) {
+		if (unlikely(xs->pp_release_cnt)) {
+			xsk_pp_flush(xs);
+			xskq_prod_submit(xs->rx);
+		}
 		len = xdp->data_end - xdp->data;
 		return xsk_rcv_zc(xs, xdp, len);
 	}
+	if (xdp->rxq->mem.type == MEM_TYPE_PAGE_POOL &&
+	    xdp_buff_has_netmem(xdp) &&
+	    xp_netmem_is_from_pool(xdp_buff_get_netmem(xdp), xs->pool)) {
+		err = xsk_rcv_pp_zc(xs, xdp, len);
+		if (err != -EXDEV)
+			return err;
+
+		/* The redirect originates from this pool's registered RXQ, so
+		 * the copy fallback produces into the socket RX ring from the
+		 * same poll context as zero-copy delivery.
+		 */
+		xsk_pp_flush(xs);
+		xskq_prod_submit(xs->rx);
+		err = xsk_rcv_copy(xs, xdp, len);
+		if (!err)
+			xdp_return_buff(xdp);
+		return err;
+	}
 
 	/* The socket RX ring has a single producer, the queue's poll context.
 	 * Reject synthetic RX queues before their remote context produces
@@ -532,6 +713,10 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 		     !xdp_rxq_info_is_reg(xdp->rxq)))
 		return -EINVAL;
 
+	if (unlikely(xs->pp_release_cnt)) {
+		xsk_pp_flush(xs);
+		xskq_prod_submit(xs->rx);
+	}
 	err = xsk_rcv_copy(xs, xdp, len);
 	if (!err)
 		xdp_return_buff(xdp);
-- 
2.55.0

