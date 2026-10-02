Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D253E835F;
	Fri,  2 Oct 2026 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967688; cv=none; b=eI2hwaIGDHZ0Hxc4hzOKWHtq6GsLvwmXGFQIIu9nLsDrQV6N6plqnSiCBDkPfJepwLnNcnjk+5w2XypeGCFpzIQUv8mEIJrXG8OqP4IW/7WZx9lsv7nd6Kyq1El4M3pdo63q6cY74DcN2BTZj6jD1CsdEHOXxpVlXcddaTQfcKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967688; c=relaxed/simple;
	bh=sMK4HDc3Js74/ZJgUi161coOiBDj1k+OTm3we60aoV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HT/YcTXW/zYyZKSBvnyIjkXvnt3Ah5AlBUBshN+PUF+g1mmQ/fger4kLmY428aTpFsjrar4SjFTwv+jiTg1N+L7tE71/Gw65Phn/RjJPBhjFNfOlFW/DAGsdFw3qbvSpXgjrOrmqCEDH33oT8ewojsF82knz7w/F2cQ2pQHcHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqpbn1WV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqpbn1WV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFEE1F0089E;
	Fri,  2 Oct 2026 19:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967680;
	bh=Lx/O7p/a9bYJmB+5cEpZKxi+w5Lfd7SQrTj+574HrmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zqpbn1WV3FTnhxahUX2F08hgb4K+Q/iQndzSYcq0T7IFo8iv0gqKWVxusmUjXaH/H
	 nQJ9rfMqi/JOIjOPRh6CvNjGNqvEZrxz/49JFP7mQ6VvwxdDuayaXEhiR3/KUgZrsq
	 rEr7qj6n01ujzrzC2VqGHxEYZ7iCZ1R9xfat4IeEoIwDUTLrJRL+Sr36a/y3ZLMvMk
	 HF/o3Us2OLu3U+EVfmyt/TfvhWQ7llQuwt0bg/ivCKhSPHRtlHHfXpj5u/2Ksmpiyi
	 P8j8hiAqW6gRmkM5A8AETu/uxUQZK/asbwklmFwneDl/RbO8oQLESi+4dwQBfXXjwW
	 G2KIaZEtj9yxw==
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
Subject: [RFC net-next 06/15] xdp: Track non-page netmem in receive buffers
Date: Fri,  2 Oct 2026 21:00:07 +0200
Message-ID: <20261002190018.696925-7-bjorn@kernel.org>
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

A page-pool memory provider can give net_iov buffers, and
virt_to_page() does not work for them. An xdp_buff holds only the
data pointer, so code that returns or converts a buffer cannot find
its net_iov.

Add NET_IOV_XSK, the net_iov type for AF_XDP. Add the internal flag
XDP_FLAGS_HAS_NETMEM. When it is set, the xdp_buff holds a netmem
reference in the union with the devmap TX queue, which only devmap
egress uses. The flag is cleared when flags are copied to an skb or
an xdp_frame. xdp_convert_buff_to_frame() sends such a buffer to the
zero-copy copy path.

A fragment from a readable net_iov area no longer marks the buffer's
fragments as unreadable. The skb layer still treats every net_iov as
unreadable, so such a buffer must be copied before it becomes an
skb. Later patches in this series do that.

skb_shared_info holds kernel pointers, so it cannot be in UMEM,
which userspace can write. A netmem xdp_buff points to a
skb_shared_info that the RX queue keeps in kernel memory instead.
xdp_init_buff_from_netmem() sets this up. Page-backed buffers still
use their tailroom.

On 64-bit, struct xdp_buff grows from 56 to 64 bytes. struct
xdp_buff_xsk stays at 128 bytes on x86-64. Where the largest
alignment is 8 bytes, as on s390, it grows from 120 to 128 bytes, so
a pool needs 8 more bytes per UMEM chunk. Only helpers that need the
netmem or the fragment info test the new flag. Page-backed receive
and return paths do not.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/net/netmem.h |  1 +
 include/net/xdp.h    | 56 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index e6dff0b01581..76e4fe878863 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -68,6 +68,7 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
 enum net_iov_type {
 	NET_IOV_DMABUF,
 	NET_IOV_IOURING,
+	NET_IOV_XSK,
 };
 
 /* A memory descriptor representing abstract networking I/O vectors,
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231adfb5f8..80931490ca3a 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h> /* skb_shared_info */
 
+#include <net/netmem.h>
 #include <net/page_pool/types.h>
 
 /**
@@ -81,6 +82,8 @@ enum xdp_buff_flags {
 	 * XDP program is not attached.
 	 */
 	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
+	/* The txq/netmem union contains a receive netmem reference. */
+	XDP_FLAGS_HAS_NETMEM		= BIT(3),
 };
 
 struct xdp_buff {
@@ -89,7 +92,12 @@ struct xdp_buff {
 	void *data_meta;
 	void *data_hard_start;
 	struct xdp_rxq_info *rxq;
-	struct xdp_txq_info *txq;
+	union {
+		/* Valid for DEVMAP egress programs. */
+		struct xdp_txq_info *txq;
+		/* Valid for receive buffers backed by non-page netmem. */
+		netmem_ref netmem;
+	};
 
 	union {
 		struct {
@@ -104,6 +112,8 @@ struct xdp_buff {
 		u64 frame_sz_flags_init;
 #endif
 	};
+	/* Kernel-owned fragment metadata for non-page netmem. */
+	struct skb_shared_info *sinfo;
 };
 
 static __always_inline void xdp_reinit_buff(struct xdp_buff *xdp)
@@ -138,7 +148,7 @@ static __always_inline void xdp_buff_set_frag_unreadable(struct xdp_buff *xdp)
 
 static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff *xdp)
 {
-	return xdp->flags;
+	return xdp->flags & ~XDP_FLAGS_HAS_NETMEM;
 }
 
 static __always_inline void xdp_buff_clear_frag_pfmemalloc(struct xdp_buff *xdp)
@@ -150,6 +160,10 @@ static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
 	xdp->rxq = rxq;
+	/* Do not initialize the txq/netmem union here. DEVMAP generic XDP
+	 * sets txq before this helper is called; receive drivers set netmem
+	 * explicitly.
+	 */
 
 #ifdef __LITTLE_ENDIAN
 	/*
@@ -176,6 +190,33 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
 	xdp->data_meta = meta_valid ? data : data + 1;
 }
 
+static __always_inline bool xdp_buff_has_netmem(const struct xdp_buff *xdp)
+{
+	return !!(xdp->flags & XDP_FLAGS_HAS_NETMEM);
+}
+
+static __always_inline netmem_ref
+xdp_buff_get_netmem(const struct xdp_buff *xdp)
+{
+	if (xdp_buff_has_netmem(xdp))
+		return xdp->netmem;
+
+	return virt_to_netmem(xdp->data);
+}
+
+static __always_inline void
+xdp_init_buff_from_netmem(struct xdp_buff *xdp, u32 frame_sz,
+			  struct xdp_rxq_info *rxq, netmem_ref netmem,
+			  struct skb_shared_info *sinfo)
+{
+	xdp_init_buff(xdp, frame_sz, rxq);
+	if (netmem_is_net_iov(netmem)) {
+		xdp->netmem = netmem;
+		xdp->flags |= XDP_FLAGS_HAS_NETMEM;
+		xdp->sinfo = sinfo;
+	}
+}
+
 /* Reserve memory area at end-of data area.
  *
  * This macro reserves tailroom in the XDP buffer by limiting the
@@ -189,6 +230,9 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
 static inline struct skb_shared_info *
 xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
 {
+	if (xdp_buff_has_netmem(xdp))
+		return xdp->sinfo;
+
 	return (struct skb_shared_info *)xdp_data_hard_end(xdp);
 }
 
@@ -290,7 +334,8 @@ static inline bool xdp_buff_add_frag(struct xdp_buff *xdp, netmem_ref netmem,
 
 	if (unlikely(netmem_is_pfmemalloc(netmem)))
 		xdp_buff_set_frag_pfmemalloc(xdp);
-	if (unlikely(netmem_is_net_iov(netmem)))
+	if (unlikely(netmem_is_net_iov(netmem) &&
+		     !net_iov_is_readable(netmem_to_net_iov(netmem))))
 		xdp_buff_set_frag_unreadable(xdp);
 
 	return true;
@@ -425,7 +470,7 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
 	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
 	xdp_frame->metasize = metasize;
 	xdp_frame->frame_sz = xdp->frame_sz;
-	xdp_frame->flags = xdp->flags;
+	xdp_frame->flags = xdp_buff_get_skb_flags(xdp);
 
 	return 0;
 }
@@ -436,7 +481,8 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
 {
 	struct xdp_frame *xdp_frame;
 
-	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL ||
+	    xdp_buff_has_netmem(xdp))
 		return xdp_convert_zc_to_xdp_frame(xdp);
 
 	/* Store info in top of packet */
-- 
2.55.0

