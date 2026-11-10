Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306080;
	b=RcUjlPx49fZjanoklkWXYjCkjJ4Klhs3d9uW5klwy5L2cWsswMu37sYzlJwEvCb6pG9X
	 zomFsIflqdfkn2zLwHpsXwn/KgXMhfF3Uc5Up9ItC5kGfagkM+EKEWOZ7tjJRQe3ZRT/I
	 a9XXiC6JKpwA2voCfmeupWzvxJHTvjUfb0SFbyDB/vIAcaBBXTqsu7rckRfyyJnFXPxyg
	 zPFtU8xXX1zzFwAbyrV/H4KtYt4Nbn7wvQSxwvaRxkFDPGZnfq3dhCpqVNfvQG8tyPL+B
	 0cm8WkoelxTFaox0VTHdfNgwTOmboF8ZLDLaKuKGrN3I2H++ezxH08JIguw1UKmrK+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306080;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EaAIf8n2DBcmDMPnjlNQguK6bcLA3FkltOpZdxk7m0Q=;
	b=axeeje0x4wzzSVZheFSViE0k8ss/Ek/a3D2aNjgfOlOW+ShBSjMzpar0gpzAcolEw6+J
	 6BqvlBI64RdPM9WvkodL8ykfC3LApv/VemUHBzu1wcbv/xIagdmitlCzbpvgwdaSLybHa
	 0La4cZHgvwCZxbnRs0FvuK4sTp0LnF5wIQePm7qHmd4YyW1Ir2nOqSB0rzKXQCpGuZazc
	 eeL8DBACXwlrm5Kw3S28zt6a8KdRPae4h01+fh2Gfo8hkDo1yXkOQqgjZ+n4vyHF7B7+T
	 Z5wIzsLMdvQgWHxYxCCbU5cHmVS410X5bI3pXjXGqFr2dhTHefHaIcFl+OvwFeJk8dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+ZTS4eS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69960710E9;
	Tue, 10 Nov 2026 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+ZTS4eS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2C61F008A4;
	Tue, 10 Nov 2026 10:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306079;
	bh=EaAIf8n2DBcmDMPnjlNQguK6bcLA3FkltOpZdxk7m0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K+ZTS4eSGLUvL2Kc9T/xrqONpdzyJK9J4ur4Rb7tdF9Z73rkNMEv6GU/t+gGDyfXo
	 vvu5pHwNLGYpMTXIiXIsVz9Xqi/8B7KCLpEIkD3YUt7j6l1WQXFGGH5h1epwZ7l9wa
	 iZHkMD8vafYswymUXoFgtMowiUMvv8vqyKlKFnPH8+Vuzz0jKV4hRfRaSeqYcYnHvi
	 pgjgYPEvHkx1FqADBIQZ5/CEUHD5hcyTAWxSm2bYDr1VPJP7xmTWXcB+xRx4o4SKR0
	 oRoObaantJqNuht5h8LwoOlFJfW6BQguvGPc3lO930qstWRodUVknojhXFlL5FNQnm
	 I73uzqdZaDRRw==
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
Subject: [PATCH net-next v1 03/11] xdp: Copy buffers with restricted lifetime
Date: Tue, 10 Nov 2026 11:20:24 +0100
Message-ID: <20261110102039.1002605-4-bjorn@kernel.org>
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

UMEM stays mapped writable in userspace, and it has a fixed number of
chunks. The stack must not keep its chunks in an skb or an xdp_frame.
Mark the providers whose buffers the stack may keep with
MP_CAP_RETAIN, and copy packets of the others on XDP_PASS, on
conversion to a frame, and on redirects other than XSKMAP.

The head chunk is writable by userspace, so it cannot hold
skb_shared_info, and virt_to_netmem() cannot find a net_iov head.
Drivers pass kernel memory for both to xdp_init_buff_netmem().

A static key keeps the check off while no such page pool exists. A
frame copy is linear, so a multi-buffer packet of such a provider
cannot go to a device or CPU map.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/skbuff.h                  |  1 +
 include/net/netmem.h                    | 10 +++
 include/net/page_pool/memory_provider.h |  3 +
 include/net/xdp.h                       | 92 +++++++++++++++++++++++--
 io_uring/zcrx.c                         |  2 +-
 net/core/dev.h                          |  4 ++
 net/core/devmem.c                       |  2 +-
 net/core/filter.c                       | 20 +++++-
 net/core/page_pool.c                    | 30 ++++++++
 net/core/xdp.c                          | 78 +++++++++++++++++----
 10 files changed, 221 insertions(+), 21 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8b0039d49905..a9cc5dd0211a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2691,6 +2691,7 @@ static inline void skb_add_rx_frag_netmem(struct sk_buff *skb, int i,
 					  int size, unsigned int truesize)
 {
 	DEBUG_NET_WARN_ON_ONCE(size > truesize);
+	DEBUG_NET_WARN_ON_ONCE(!netmem_can_retain(netmem));
 
 	skb_fill_netmem_desc(skb, i, netmem, off, size);
 	skb->len += size;
diff --git a/include/net/netmem.h b/include/net/netmem.h
index f196b014184c..b986ad616334 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -59,6 +59,7 @@ static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
 /* net_iov */
 
 DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
+DECLARE_STATIC_KEY_FALSE(page_pool_restricted);
 
 /*  We overload the LSB of the struct page pointer to indicate whether it's
  *  a page or net_iov.
@@ -414,6 +415,15 @@ static inline bool net_is_devmem_iov(const struct net_iov *niov)
 void net_iov_inc_ref(struct net_iov *niov);
 void net_iov_dec_ref(struct net_iov *niov);
 
+#if IS_ENABLED(CONFIG_PAGE_POOL)
+bool netmem_can_retain(netmem_ref netmem);
+#else
+static inline bool netmem_can_retain(netmem_ref netmem)
+{
+	return true;
+}
+#endif
+
 /**
  * netmem_inc_ref - acquire a non-page_pool reference on a netmem
  * @netmem: netmem to reference
diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index 4417e54a0f81..e732b21be9a2 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -25,10 +25,13 @@ struct sk_buff;
  * @MP_CAP_READABLE: The CPU can access provider memory. It may back header
  *	page pools, and XDP programs may run on it.
  * @MP_CAP_FRAG: Page pool fragments may split provider buffers.
+ * @MP_CAP_RETAIN: The stack may keep page pool references to provider
+ *	buffers after the RX poll, for example in an skb or an xdp_frame.
  */
 enum mp_caps {
 	MP_CAP_READABLE		= BIT(0),
 	MP_CAP_FRAG		= BIT(1),
+	MP_CAP_RETAIN		= BIT(2),
 };
 
 struct memory_provider_ops {
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231adfb5f8..1105bb9e3292 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -81,6 +81,16 @@ enum xdp_buff_flags {
 	 * XDP program is not attached.
 	 */
 	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
+	/* Internal: the head netmem and the shared info are in &xdp_buff.ext.
+	 * Not copied to xdp_frames or skbs.
+	 */
+	XDP_FLAGS_EXT			= BIT(3),
+};
+
+/* For a head buffer that cannot hold kernel data, see xdp_init_buff_netmem() */
+struct xdp_buff_ext {
+	netmem_ref netmem;
+	struct skb_shared_info sinfo;
 };
 
 struct xdp_buff {
@@ -89,7 +99,12 @@ struct xdp_buff {
 	void *data_meta;
 	void *data_hard_start;
 	struct xdp_rxq_info *rxq;
-	struct xdp_txq_info *txq;
+	union {
+		/* DEVMAP egress programs only */
+		struct xdp_txq_info *txq;
+		/* RX buffers with XDP_FLAGS_EXT */
+		struct xdp_buff_ext *ext;
+	};
 
 	union {
 		struct {
@@ -138,7 +153,7 @@ static __always_inline void xdp_buff_set_frag_unreadable(struct xdp_buff *xdp)
 
 static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff *xdp)
 {
-	return xdp->flags;
+	return xdp->flags & ~XDP_FLAGS_EXT;
 }
 
 static __always_inline void xdp_buff_clear_frag_pfmemalloc(struct xdp_buff *xdp)
@@ -176,6 +191,50 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
 	xdp->data_meta = meta_valid ? data : data + 1;
 }
 
+/* See MP_CAP_RETAIN */
+static __always_inline bool xdp_netmem_restricted(netmem_ref netmem)
+{
+	return IS_ENABLED(CONFIG_PAGE_POOL) &&
+	       static_branch_unlikely(&page_pool_restricted) &&
+	       !netmem_can_retain(netmem);
+}
+
+/**
+ * xdp_init_buff_netmem - initialize an &xdp_buff for a netmem head buffer
+ * @xdp: &xdp_buff to initialize
+ * @frame_sz: frame size
+ * @rxq: RX queue info
+ * @netmem: head buffer
+ * @ext: kernel memory used if @netmem cannot hold the shared info, or the
+ *	stack must not keep it. It must live as long as @xdp.
+ *
+ * A driver that may receive into memory provider buffers uses this instead
+ * of xdp_init_buff().
+ */
+static __always_inline void
+xdp_init_buff_netmem(struct xdp_buff *xdp, u32 frame_sz,
+		     struct xdp_rxq_info *rxq, netmem_ref netmem,
+		     struct xdp_buff_ext *ext)
+{
+	xdp_init_buff(xdp, frame_sz, rxq);
+	if (likely(!netmem_is_net_iov(netmem) &&
+		   !xdp_netmem_restricted(netmem)))
+		return;
+
+	ext->netmem = netmem;
+	xdp->ext = ext;
+	xdp->flags |= XDP_FLAGS_EXT;
+}
+
+static __always_inline netmem_ref
+xdp_buff_head_netmem(const struct xdp_buff *xdp)
+{
+	if (unlikely(xdp->flags & XDP_FLAGS_EXT))
+		return xdp->ext->netmem;
+
+	return virt_to_netmem(xdp->data);
+}
+
 /* Reserve memory area at end-of data area.
  *
  * This macro reserves tailroom in the XDP buffer by limiting the
@@ -189,9 +248,28 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
 static inline struct skb_shared_info *
 xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
 {
+	if (unlikely(xdp->flags & XDP_FLAGS_EXT))
+		return &xdp->ext->sinfo;
+
 	return (struct skb_shared_info *)xdp_data_hard_end(xdp);
 }
 
+bool __xdp_buff_needs_copy(const struct xdp_buff *xdp);
+
+/* Must the stack copy a buffer of @xdp before it keeps it? XSK buffers are
+ * copied by their own conversion.
+ */
+static __always_inline bool xdp_buff_needs_copy(const struct xdp_buff *xdp)
+{
+	if (unlikely(xdp->flags & XDP_FLAGS_EXT))
+		return true;
+	if (!IS_ENABLED(CONFIG_PAGE_POOL) ||
+	    !static_branch_unlikely(&page_pool_restricted))
+		return false;
+
+	return __xdp_buff_needs_copy(xdp);
+}
+
 static __always_inline unsigned int
 xdp_get_buff_len(const struct xdp_buff *xdp)
 {
@@ -379,7 +457,7 @@ xdp_update_skb_frags_info(struct sk_buff *skb, u8 nr_frags,
 void xdp_warn(const char *msg, const char *func, const int line);
 #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
 
-struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
+struct sk_buff *xdp_build_skb_from_buff(struct xdp_buff *xdp);
 struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp);
 struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
@@ -420,12 +498,15 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
 		return -ENOSPC;
 	}
 
+	/* The stack may keep the frame, see xdp_buff_needs_copy(). */
+	DEBUG_NET_WARN_ON_ONCE(xdp_buff_needs_copy(xdp));
+
 	xdp_frame->data = xdp->data;
 	xdp_frame->len  = xdp->data_end - xdp->data;
 	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
 	xdp_frame->metasize = metasize;
 	xdp_frame->frame_sz = xdp->frame_sz;
-	xdp_frame->flags = xdp->flags;
+	xdp_frame->flags = xdp_buff_get_skb_flags(xdp);
 
 	return 0;
 }
@@ -436,7 +517,8 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
 {
 	struct xdp_frame *xdp_frame;
 
-	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL ||
+	    xdp_buff_needs_copy(xdp))
 		return xdp_convert_zc_to_xdp_frame(xdp);
 
 	/* Store info in top of packet */
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 3b5bf97aa203..98d83a8e45e4 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1478,7 +1478,7 @@ static const struct memory_provider_ops io_uring_pp_zc_ops = {
 	.destroy		= io_pp_zc_destroy,
 	.nl_fill		= io_pp_nl_fill,
 	.uninstall		= io_pp_uninstall,
-	.caps			= MP_CAP_FRAG,
+	.caps			= MP_CAP_FRAG | MP_CAP_RETAIN,
 };
 
 static unsigned zcrx_parse_rq(netmem_ref *netmem_array, unsigned nr,
diff --git a/net/core/dev.h b/net/core/dev.h
index 4e9e8cd15697..e3337013ffc8 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -13,6 +13,10 @@ struct netlink_ext_ack;
 struct netdev_queue_config;
 struct cpumask;
 struct pp_memory_provider_params;
+struct xdp_buff;
+struct xdp_frame;
+
+struct xdp_frame *xdp_copy_buff_to_frame(const struct xdp_buff *xdp);
 
 /* Random bits of netdevice that don't need to be exposed */
 #define FLOW_LIMIT_HISTORY	(1 << 7)  /* must be ^2 and !overflow buckets */
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 8f190b574beb..dea4a4a17e86 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -698,5 +698,5 @@ static const struct memory_provider_ops dmabuf_devmem_ops = {
 	.release_netmem		= mp_dmabuf_devmem_release_page,
 	.nl_fill		= mp_dmabuf_devmem_nl_fill,
 	.uninstall		= mp_dmabuf_devmem_uninstall,
-	.caps			= MP_CAP_FRAG,
+	.caps			= MP_CAP_FRAG | MP_CAP_RETAIN,
 };
diff --git a/net/core/filter.c b/net/core/filter.c
index 80380f89adf9..f93839b493b2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4774,12 +4774,28 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 {
 	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
+	struct xdp_frame *xdpf;
+	int err;
 
 	if (map_type == BPF_MAP_TYPE_XSKMAP)
 		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
 
-	return __xdp_do_redirect_frame(ri, dev, xdp_convert_buff_to_frame(xdp),
-				       xdp_prog);
+	if (likely(!xdp_buff_needs_copy(xdp)))
+		return __xdp_do_redirect_frame(ri, dev,
+					       xdp_convert_buff_to_frame(xdp),
+					       xdp_prog);
+
+	/* Release the source only after the target took the copy. */
+	xdpf = xdp_copy_buff_to_frame(xdp);
+	err = __xdp_do_redirect_frame(ri, dev, xdpf, xdp_prog);
+	if (unlikely(err)) {
+		if (xdpf)
+			xdp_return_frame(xdpf);
+		return err;
+	}
+
+	xdp_return_buff(xdp);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(xdp_do_redirect);
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index d88a3ea528d4..8237fda598ab 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -34,6 +34,10 @@
 
 DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
 
+/* Enabled while a pool of a provider without MP_CAP_RETAIN exists. */
+DEFINE_STATIC_KEY_FALSE(page_pool_restricted);
+EXPORT_SYMBOL(page_pool_restricted);
+
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
 
@@ -188,6 +192,28 @@ static void page_pool_struct_check(void)
 				    PAGE_POOL_FRAG_GROUP_ALIGN);
 }
 
+/**
+ * netmem_can_retain() - may the stack keep @netmem after the RX poll
+ * @netmem: netmem to check
+ *
+ * Context: the caller holds @netmem through its page pool. A plain page
+ * reference does not keep the page in its pool.
+ * Return: false if @netmem belongs to a memory provider without
+ * MP_CAP_RETAIN.
+ */
+bool netmem_can_retain(netmem_ref netmem)
+{
+	const struct memory_provider_ops *ops;
+
+	netmem = netmem_compound_head(netmem);
+	if (!netmem_is_pp(netmem))
+		return true;
+
+	ops = netmem_get_pp(netmem)->mp_ops;
+	return !ops || ops->caps & MP_CAP_RETAIN;
+}
+EXPORT_SYMBOL(netmem_can_retain);
+
 static int page_pool_select_mp(struct page_pool *pool,
 			       const struct pp_memory_provider_params *mpp)
 {
@@ -324,6 +350,8 @@ static int page_pool_init(struct page_pool *pool,
 		}
 
 		static_branch_inc(&page_pool_mem_providers);
+		if (!(pool->mp_ops->caps & MP_CAP_RETAIN))
+			static_branch_inc(&page_pool_restricted);
 	} else if (pool->p.order > MAX_PAGE_ORDER) {
 		err = -EINVAL;
 		goto free_ptr_ring;
@@ -352,6 +380,8 @@ static void page_pool_uninit(struct page_pool *pool)
 #endif
 
 	if (pool->mp_ops) {
+		if (!(pool->mp_ops->caps & MP_CAP_RETAIN))
+			static_branch_dec(&page_pool_restricted);
 		pool->mp_ops->destroy(pool);
 		static_branch_dec(&page_pool_mem_providers);
 	}
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 1d679e8fd649..0cf46d492d91 100644
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
@@ -559,10 +561,41 @@ void xdp_return_buff(struct xdp_buff *xdp)
 			     xdp->rxq->mem.type, true, xdp);
 
 out:
-	__xdp_return(virt_to_netmem(xdp->data), xdp->rxq->mem.type, true, xdp);
+	__xdp_return(xdp_buff_head_netmem(xdp), xdp->rxq->mem.type, true, xdp);
 }
 EXPORT_SYMBOL_GPL(xdp_return_buff);
 
+bool __xdp_buff_needs_copy(const struct xdp_buff *xdp)
+{
+	const struct skb_shared_info *sinfo;
+	u32 i;
+
+	/* Provider buffers come only from page pool queues */
+	if (xdp->rxq->mem.type != MEM_TYPE_PAGE_POOL)
+		return false;
+	if (!netmem_can_retain(xdp_buff_head_netmem(xdp)))
+		return true;
+	if (likely(!xdp_buff_has_frags(xdp)))
+		return false;
+
+	sinfo = xdp_get_shared_info_from_buff(xdp);
+	for (i = 0; i < sinfo->nr_frags; i++) {
+		if (!netmem_can_retain(skb_frag_netmem(&sinfo->frags[i])))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(__xdp_buff_needs_copy);
+
+static void xdp_release_copied(struct xdp_buff *xdp)
+{
+	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+		xsk_buff_free(xdp);
+	else
+		xdp_return_buff(xdp);
+}
+
 void xdp_attachment_setup(struct xdp_attachment_info *info,
 			  struct netdev_bpf *bpf)
 {
@@ -573,13 +606,19 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 }
 EXPORT_SYMBOL_GPL(xdp_attachment_setup);
 
-struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
+/* @xdp stays with the caller, also on success */
+struct xdp_frame *xdp_copy_buff_to_frame(const struct xdp_buff *xdp)
 {
 	unsigned int metasize, totsize;
 	void *addr, *data_to_copy;
 	struct xdp_frame *xdpf;
 	struct page *page;
 
+	/* Copies are linear. XSK frames lose their frags, as before. */
+	if (unlikely(xdp_buff_has_frags(xdp)) &&
+	    xdp->rxq->mem.type != MEM_TYPE_XSK_BUFF_POOL)
+		return NULL;
+
 	/* Clone into a MEM_TYPE_PAGE_ORDER0 xdp_frame. */
 	metasize = xdp_data_meta_unsupported(xdp) ? 0 :
 		   xdp->data - xdp->data_meta;
@@ -607,7 +646,17 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 	xdpf->frame_sz = PAGE_SIZE;
 	xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
 
-	xsk_buff_free(xdp);
+	return xdpf;
+}
+
+struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
+{
+	struct xdp_frame *xdpf;
+
+	xdpf = xdp_copy_buff_to_frame(xdp);
+	if (xdpf)
+		xdp_release_copied(xdp);
+
 	return xdpf;
 }
 EXPORT_SYMBOL_GPL(xdp_convert_zc_to_xdp_frame);
@@ -627,10 +676,12 @@ EXPORT_SYMBOL_GPL(xdp_warn);
  * &xdp_buff: allocate an skb head from the NAPI percpu cache, initialize
  * skb data pointers and offsets, set the recycle bit if the buff is
  * PP-backed, Rx queue index, protocol and update frags info.
+ * A buffer that the stack must not keep is copied and released, see
+ * xdp_buff_needs_copy(). On error, @xdp is not released.
  *
  * Return: new &sk_buff on success, %NULL on error.
  */
-struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
+struct sk_buff *xdp_build_skb_from_buff(struct xdp_buff *xdp)
 {
 	const struct xdp_rxq_info *rxq = xdp->rxq;
 	const struct skb_shared_info *sinfo;
@@ -638,6 +689,9 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 	u32 nr_frags = 0;
 	int metalen;
 
+	if (unlikely(xdp_buff_needs_copy(xdp)))
+		return xdp_build_skb_from_zc(xdp);
+
 	if (unlikely(xdp_buff_has_frags(xdp))) {
 		sinfo = xdp_get_shared_info_from_buff(xdp);
 		nr_frags = sinfo->nr_frags;
@@ -674,12 +728,12 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 EXPORT_SYMBOL_GPL(xdp_build_skb_from_buff);
 
 /**
- * xdp_copy_frags_from_zc - copy frags from XSk buff to skb
+ * xdp_copy_frags_from_zc - copy frags from an &xdp_buff to an skb
  * @skb: skb to copy frags to
- * @xdp: XSk &xdp_buff from which the frags will be copied
+ * @xdp: XSk buff, or buffer that the stack must not keep
  * @pp: &page_pool backing page allocation, if available
  *
- * Copy all frags from XSk &xdp_buff to the skb to pass it up the stack.
+ * Copy all frags from @xdp to the skb to pass it up the stack.
  * Allocate a new buffer for each frag, copy it and attach to the skb.
  *
  * Return: true on success, false on netmem allocation fail.
@@ -724,14 +778,14 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 }
 
 /**
- * xdp_build_skb_from_zc - create an skb from XSk &xdp_buff
- * @xdp: source XSk buff
+ * xdp_build_skb_from_zc - create an skb from a copy of an &xdp_buff
+ * @xdp: source XSk buff, or buffer that the stack must not keep
  *
- * Similar to xdp_build_skb_from_buff(), but for XSk frames. Allocate an skb
+ * Similar to xdp_build_skb_from_buff(), but copies @xdp. Allocate an skb
  * head, new buffer for the head, copy the data and initialize the skb fields.
  * If there are frags, allocate new buffers for them and copy.
  * Buffers are allocated from the system percpu pools to try recycling them.
- * If new skb was built successfully, @xdp is returned to XSk pool's freelist.
+ * If new skb was built successfully, @xdp is released to its owner.
  * On error, it remains untouched and the caller must take care of this.
  *
  * Return: new &sk_buff on success, %NULL on error.
@@ -781,7 +835,7 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 		goto out;
 	}
 
-	xsk_buff_free(xdp);
+	xdp_release_copied(xdp);
 
 	skb->protocol = eth_type_trans(skb, rxq->dev);
 
-- 
2.56.0

