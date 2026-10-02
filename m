Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F513A16AC;
	Fri,  2 Oct 2026 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967721; cv=none; b=BSKNcWJAhGJxhFeeUAoTJNb3UqmBjRl9mwifhrNYZrjrlGsMKln31OHTzBRWTs2F8nxpTl2cCuw0hLKUgEYuS4Attuk7UMaeSBXDV5EiOQ627H76ylHxlM4YhgF4N9QPy5Om2iBlo721hWlYQCuOSJQPTLVLYfQ4lyRhXaZ4o7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967721; c=relaxed/simple;
	bh=a905JX6Zy8zdyeDS/+PeoxkYA6QpwbxeN1y82eQqdJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTh1Art5gUTdNsLNpF5HwqyPWs7hwwjsz0NsO4McHackKbXcCMawbTTm29xH3gat9enujc97xp3EgimU+a6ieinPfS/VO5RsrgFe8jKzlixEFbP6j+9IqLVEcRlBGc4mvTO7310QMQCDZUw0Vq3d3qE81G+zDFOhTpVSl0aPo+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6LviN4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6LviN4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922EA1F00898;
	Fri,  2 Oct 2026 19:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967720;
	bh=w1tk3U4Ob4+eGozh6kR9OqonmOqzomJQNVCBVUS2Bow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c6LviN4Ga8miCKf55RDCizMAnQBLtrVLponnwt4UDJfmMzaRue6lTU7ld8FUrFmG5
	 Ga+6+zJPmdF1VYNYcrCEY9mISSVMLT9sIGtRU4I1pLZ9HLAubSze+jKA2KIMFxDJs5
	 qRClcOPNuuMB8SQz4Jbs0HZcSGdaSwbi0F+PMcmR5IRQb7AQTHvJUS6Cy1uGkXesIZ
	 /CVqJkW0ya1fu6Oe5S3h2sLGilLAQylu4wRrAe3Iyasa2cXP4y5S7krVjJ6BjOK2iY
	 Omd5lkZTijIQAqCCiIYErQScuMFTGFgny38mZyHRAux5WDyjtw1XXAxBEwsruNTw4Y
	 VyES2HxM3Y20Q==
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
Subject: [RFC net-next 11/15] xdp: Copy provider buffers on pass and redirect
Date: Fri,  2 Oct 2026 21:00:12 +0200
Message-ID: <20261002190018.696925-12-bjorn@kernel.org>
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

A provider buffer must go back to its page pool from the NAPI poll
that allocated it. Userspace gets UMEM ownership back through the
FILL ring, without a reference count. An skb or xdp_frame can
outlive the poll, so it cannot hold a provider buffer.

Copy the packet, fragments included, into kernel pages on XDP_PASS and
on redirects to targets other than XSKMAP. On redirect, split the copy
from the release: return the provider buffer only after the target
accepts the copy. The classic zero-copy redirect path is unchanged.

The copy and the BPF fragment helpers get a fragment's address from
the new xdp_frag_address(). It works for pages and for provider
net_iovs; skb_frag_address() works only for pages. The next patch
handles delivery to an XSKMAP socket.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/net/xdp.h |  8 +++-
 net/core/dev.h    |  5 +++
 net/core/filter.c | 28 +++++++++++---
 net/core/xdp.c    | 98 ++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 126 insertions(+), 13 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 80931490ca3a..4d7040debcca 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -420,11 +420,17 @@ xdp_update_skb_frags_info(struct sk_buff *skb, u8 nr_frags,
 	skb->unreadable |= !!(xdp_flags & XDP_FLAGS_FRAGS_UNREADABLE);
 }
 
+/* Page and readable provider fragments alike resolve through their netmem. */
+static inline void *xdp_frag_address(const skb_frag_t *frag)
+{
+	return netmem_address(skb_frag_netmem(frag)) + skb_frag_off(frag);
+}
+
 /* Avoids inlining WARN macro in fast-path */
 void xdp_warn(const char *msg, const char *func, const int line);
 #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
 
-struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
+struct sk_buff *xdp_build_skb_from_buff(struct xdp_buff *xdp);
 struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp);
 struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
diff --git a/net/core/dev.h b/net/core/dev.h
index 4793a994f7f1..6598a4c5cfec 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -13,6 +13,11 @@ struct netlink_ext_ack;
 struct netdev_queue_config;
 struct cpumask;
 struct pp_memory_provider_params;
+struct xdp_buff;
+struct xdp_frame;
+
+struct xdp_frame *xdp_copy_zc_to_xdp_frame(struct xdp_buff *xdp);
+void xdp_release_zc_buff(struct xdp_buff *xdp);
 
 /* Random bits of netdevice that don't need to be exposed */
 #define FLOW_LIMIT_HISTORY	(1 << 7)  /* must be ^2 and !overflow buckets */
diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2..23b3923c0869 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4221,7 +4221,7 @@ void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 			break;
 
 		ptr_off += ptr_len;
-		ptr_buf = skb_frag_address(next_frag);
+		ptr_buf = xdp_frag_address(next_frag);
 		ptr_len = skb_frag_size(next_frag);
 		next_frag++;
 	}
@@ -4249,7 +4249,7 @@ void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len)
 		u32 frag_size = skb_frag_size(&sinfo->frags[i]);
 
 		if  (offset < frag_size) {
-			addr = skb_frag_address(&sinfo->frags[i]);
+			addr = xdp_frag_address(&sinfo->frags[i]);
 			size = frag_size;
 			break;
 		}
@@ -4339,7 +4339,7 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	if (unlikely(offset > tailroom))
 		return -EINVAL;
 
-	memset(skb_frag_address(frag) + skb_frag_size(frag), 0, offset);
+	memset(xdp_frag_address(frag) + skb_frag_size(frag), 0, offset);
 	skb_frag_size_add(frag, offset);
 	sinfo->xdp_frags_size += offset;
 	if (rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
@@ -4684,12 +4684,28 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 {
 	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
+	struct xdp_frame *xdpf;
+	int err;
 
 	if (map_type == BPF_MAP_TYPE_XSKMAP)
 		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
 
-	return __xdp_do_redirect_frame(ri, dev, xdp_convert_buff_to_frame(xdp),
-				       xdp_prog);
+	if (!xdp_buff_has_netmem(xdp))
+		return __xdp_do_redirect_frame(ri, dev,
+					       xdp_convert_buff_to_frame(xdp),
+					       xdp_prog);
+
+	/* Return provider buffers only after the target accepts the copy. */
+	xdpf = xdp_copy_zc_to_xdp_frame(xdp);
+	err = __xdp_do_redirect_frame(ri, dev, xdpf, xdp_prog);
+	if (err) {
+		if (xdpf)
+			xdp_return_frame_rx_napi(xdpf);
+		return err;
+	}
+
+	xdp_release_zc_buff(xdp);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(xdp_do_redirect);
 
@@ -12677,7 +12693,7 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 		skb_frag_t *frag = &sinfo->frags[i];
 		u32 shrink = min_t(u32, delta, skb_frag_size(frag));
 
-		memcpy(xdp->data_end, skb_frag_address(frag), shrink);
+		memcpy(xdp->data_end, xdp_frag_address(frag), shrink);
 
 		xdp->data_end += shrink;
 		sinfo->xdp_frags_size -= shrink;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 386240bd24c9..b7f16f44dac2 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -23,6 +23,8 @@
 #include <trace/events/xdp.h>
 #include <net/xdp_sock_drv.h>
 
+#include "dev.h"
+
 #define REG_STATE_NEW		0x0
 #define REG_STATE_REGISTERED	0x1
 #define REG_STATE_UNREGISTERED	0x2
@@ -559,7 +561,8 @@ void xdp_return_buff(struct xdp_buff *xdp)
 			     xdp->rxq->mem.type, true, xdp);
 
 out:
-	__xdp_return(virt_to_netmem(xdp->data), xdp->rxq->mem.type, true, xdp);
+	__xdp_return(xdp_buff_get_netmem(xdp), xdp->rxq->mem.type, true,
+		     xdp);
 }
 EXPORT_SYMBOL_GPL(xdp_return_buff);
 
@@ -573,7 +576,56 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 }
 EXPORT_SYMBOL_GPL(xdp_attachment_setup);
 
-struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
+static bool xdp_copy_frags_to_frame(struct xdp_frame *xdpf,
+				    const struct xdp_buff *xdp)
+{
+	const struct skb_shared_info *xinfo;
+	struct skb_shared_info *sinfo;
+	u32 i, nr_frags;
+
+	xinfo = xdp_get_shared_info_from_buff(xdp);
+	nr_frags = xinfo->nr_frags;
+
+	sinfo = xdp_get_shared_info_from_frame(xdpf);
+	memset(sinfo, 0, sizeof(*sinfo));
+
+	for (i = 0; i < nr_frags; i++) {
+		const skb_frag_t *frag = &xinfo->frags[i];
+		u32 len = skb_frag_size(frag);
+		struct page *page;
+
+		page = dev_alloc_page();
+		if (!page)
+			goto err;
+
+		memcpy(page_address(page), xdp_frag_address(frag), len);
+		__skb_fill_page_desc_noacc(sinfo, i, page, 0, len);
+		if (page_is_pfmemalloc(page))
+			xdpf->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
+	}
+
+	sinfo->nr_frags = nr_frags;
+	sinfo->xdp_frags_size = xinfo->xdp_frags_size;
+	sinfo->xdp_frags_truesize = nr_frags * PAGE_SIZE;
+	return true;
+
+err:
+	while (i--)
+		put_page(skb_frag_page(&sinfo->frags[i]));
+
+	return false;
+}
+
+/**
+ * xdp_copy_zc_to_xdp_frame - copy a zero-copy buff into a page-backed frame
+ * @xdp: zero-copy &xdp_buff to copy
+ *
+ * The source keeps its buffers, so a caller that cannot hand the frame on
+ * must free the frame and may still return the source to its owner.
+ *
+ * Return: new frame on success, %NULL on failure.
+ */
+struct xdp_frame *xdp_copy_zc_to_xdp_frame(struct xdp_buff *xdp)
 {
 	unsigned int metasize, totsize;
 	void *addr, *data_to_copy;
@@ -607,7 +659,34 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 	xdpf->frame_sz = PAGE_SIZE;
 	xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
 
-	xsk_buff_free(xdp);
+	/* Classic zero-copy frames keep only the linear part. */
+	if (xdp_buff_has_netmem(xdp) && xdp_buff_has_frags(xdp)) {
+		xdpf->flags = XDP_FLAGS_HAS_FRAGS;
+		if (!xdp_copy_frags_to_frame(xdpf, xdp)) {
+			put_page(page);
+			return NULL;
+		}
+	}
+
+	return xdpf;
+}
+
+void xdp_release_zc_buff(struct xdp_buff *xdp)
+{
+	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+		xsk_buff_free(xdp);
+	else
+		xdp_return_buff(xdp);
+}
+
+struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
+{
+	struct xdp_frame *xdpf;
+
+	xdpf = xdp_copy_zc_to_xdp_frame(xdp);
+	if (xdpf)
+		xdp_release_zc_buff(xdp);
+
 	return xdpf;
 }
 EXPORT_SYMBOL_GPL(xdp_convert_zc_to_xdp_frame);
@@ -627,10 +706,11 @@ EXPORT_SYMBOL_GPL(xdp_warn);
  * &xdp_buff: allocate an skb head from the NAPI percpu cache, initialize
  * skb data pointers and offsets, set the recycle bit if the buff is
  * PP-backed, Rx queue index, protocol and update frags info.
+ * Provider-backed netmem is copied into kernel memory and released.
  *
  * Return: new &sk_buff on success, %NULL on error.
  */
-struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
+struct sk_buff *xdp_build_skb_from_buff(struct xdp_buff *xdp)
 {
 	const struct xdp_rxq_info *rxq = xdp->rxq;
 	const struct skb_shared_info *sinfo;
@@ -638,6 +718,9 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 	u32 nr_frags = 0;
 	int metalen;
 
+	if (xdp_buff_has_netmem(xdp))
+		return xdp_build_skb_from_zc(xdp);
+
 	if (unlikely(xdp_buff_has_frags(xdp))) {
 		sinfo = xdp_get_shared_info_from_buff(xdp);
 		nr_frags = sinfo->nr_frags;
@@ -708,7 +791,7 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 			return false;
 		}
 
-		memcpy(page_address(page) + offset, skb_frag_address(frag),
+		memcpy(page_address(page) + offset, xdp_frag_address(frag),
 		       len);
 		__skb_fill_page_desc_noacc(sinfo, i, page, offset, len);
 
@@ -787,7 +870,10 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 		goto out;
 	}
 
-	xsk_buff_free(xdp);
+	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+		xsk_buff_free(xdp);
+	else
+		xdp_return_buff(xdp);
 
 	skb->protocol = eth_type_trans(skb, rxq->dev);
 
-- 
2.55.0

