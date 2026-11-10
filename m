Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306062;
	b=VbDTDEH2XspTFv/gwCqGJ5ctqefOn2CYcDSytK3cUKkL1NTTQnlw6yJyySGm5FJ1xqMf
	 DnC+Wja2r62iEybYmevhThO1xL+gY97DxJGgdvX289UFBhD3wUoAEaHMoM2t8kl3Y12Oc
	 sdbIQDKMeagYvtzpTRMvIQDUDEPkxdAOx4g+xAao9f3h0HdroLbF6uq+kTM4MuQH5H7GK
	 lHa4GAAdU8pCMRqunIsj2CoKV4A4iyui2FfqoZQ0rA7rSvY0S15WDaeyxPbdBF4mbvxcs
	 UMKBbQ5+aalCdVkyR1gmLb/Z41xVPX1HmyCq+KIZRKbNW6cQhZ4zdVzT2n2HuMLha6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306062;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dO8C4ggxuopS/+6zAbnax7EkePGJAuvyfP9itW1DLkc=;
	b=4kFzj4QxVGfRCgLq3nNUNwGb/Zjmv61U8JDfd53mDtBn+aegpE+lf69uCw6CjKhPyLz2
	 sPVv7nv046D99Ks9u+djFCoj66zbCVMegGGVf0yb1oEn8Dlr3I/VHbWMs3f/kP9tKVuHb
	 SFdJYJprbbzpH901wVziKcxajhNOYIuUBRP3+3oiHIpX3zCKgNQI3fYPmaRgacz2paYj1
	 OgB9NE0GRtuOkeYv1DS+uvN/8NmtP4USeZq4MQKYDoe6UBh8bnQwrk7Tyms/ra9ELuklF
	 dQU1JzYfqFskwuPYz9R9NC0SSJIgDdP33o1odvR0N/EjkGvWp3dLltJzM4r7tblNTfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtDjioK9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301A1606A33C;
	Tue, 10 Nov 2026 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtDjioK9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9951F008A2;
	Tue, 10 Nov 2026 10:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306061;
	bh=dO8C4ggxuopS/+6zAbnax7EkePGJAuvyfP9itW1DLkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dtDjioK9wVMfRqljj6xCHH58w9Nv6IhPylKB2jvocyzRxrwGz8gXMmFAUi2xm2xtC
	 LVm3aMYDyINLDnS+Q9+1ygatUGX/Q8IUTk/6lGHTX5WpEoOeieUpqDzZ9rC6KsaVQc
	 wPP1OSCU+gREvCirtdit0aPB4ADQ8rV2BM0qk4x/kI4Dy/FfySpW4e8hZmh1eY3CKT
	 bLSu2EvZftBrYuKKtULg9pTCeHIst3W8fj5BnYN5EEihvgSBh9gGIzgJXboBR4xU1F
	 PZOHzqM5zb0PTsdlyBQKtxoy65NCl+0Inv+74VlFG0JXierGeZQdxu28Ch1dL6pQAL
	 7fs4Z0HQ34TyQ==
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
Subject: [PATCH net-next v1 01/11] net: Get skb fragment addresses through netmem
Date: Tue, 10 Nov 2026 11:20:22 +0100
Message-ID: <20261110102039.1002605-2-bjorn@kernel.org>
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

skb_frag_address() goes through struct page, so a net_iov never has an
address. Only unreadable memory should lack one: XDP and BPF read
fragments through this helper, and AF_XDP UMEM will back readable
net_iovs. netmem_address() also returns NULL, not a bogus pointer, for
an unmapped highmem page.

Generic code needs the size of a net_iov to find its address, so keep
it in struct net_iov_area instead of the devmem binding.

Suggested-by: Mina Almasry <almasrymina@google.com>
Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/skbuff.h | 21 +++++++++------------
 include/net/netmem.h   |  6 ++++--
 io_uring/zcrx.c        |  1 +
 net/core/devmem.c      |  8 ++++----
 net/core/devmem.h      |  4 +---
 5 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 73365c5de6f9..8b0039d49905 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3759,33 +3759,30 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
  * skb_frag_address - gets the address of the data contained in a paged fragment
  * @frag: the paged fragment buffer
  *
- * Returns: the address of the data within @frag. The page must already
- * be mapped.
+ * Returns: the address of the data within @frag, or %NULL if the CPU cannot
+ * read it.
  */
 static inline void *skb_frag_address(const skb_frag_t *frag)
 {
-	if (!skb_frag_page(frag))
+	void *ptr = netmem_address(skb_frag_netmem(frag));
+
+	if (!ptr)
 		return NULL;
 
-	return page_address(skb_frag_page(frag)) + skb_frag_off(frag);
+	return ptr + skb_frag_off(frag);
 }
 
 /**
  * skb_frag_address_safe - gets the address of the data contained in a paged fragment
  * @frag: the paged fragment buffer
  *
- * Returns: the address of the data within @frag. Checks that the page
- * is mapped and returns %NULL otherwise.
+ * Returns: the address of the data within @frag. Checks that the memory
+ * is mapped and readable and returns %NULL otherwise.
  */
 static inline void *skb_frag_address_safe(const skb_frag_t *frag)
 {
-	struct page *page = skb_frag_page(frag);
-	void *ptr;
+	void *ptr = netmem_address(skb_frag_netmem(frag));
 
-	if (!page)
-		return NULL;
-
-	ptr = page_address(page);
 	if (unlikely(!ptr))
 		return NULL;
 
diff --git a/include/net/netmem.h b/include/net/netmem.h
index fb693bc1702a..f196b014184c 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -72,8 +72,8 @@ enum net_iov_type {
 
 /* A memory descriptor representing abstract networking I/O vectors.
  *
- * net_iovs are allocated and used by networking code, and the size of
- * the chunk is PAGE_SIZE.
+ * net_iovs are allocated and used by networking code. Their area sets the
+ * size of a chunk, see net_iov_area.niov_shift.
  *
  * Examples include imported dmabuf memory and imported io_uring memory. See
  * net_iov_type for all the supported types. While current net_iov types are
@@ -104,6 +104,8 @@ struct net_iov_area {
 	/* Array of net_iovs for this area. */
 	struct net_iov *niovs;
 	size_t num_niovs;
+	/* Each net_iov covers 1 << niov_shift bytes. */
+	unsigned int niov_shift;
 };
 
 static inline struct net_iov_area *net_iov_owner(const struct net_iov *niov)
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 6d7abb1636e7..555f27e6c1ba 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -542,6 +542,7 @@ static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 	ifq->niov_shift = buf_size_shift;
 	nr_iovs = area->mem.size >> ifq->niov_shift;
 	area->nia.num_niovs = nr_iovs;
+	area->nia.niov_shift = buf_size_shift;
 
 	ret = -ENOMEM;
 	area->nia.niovs = kvmalloc_objs(area->nia.niovs[0], nr_iovs,
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 5c7d9640e9d1..b9146b1f294a 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -287,8 +287,8 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	u32 xa_idx;
 	int err;
 
-	if (binding->niov_shift != PAGE_SHIFT)
-		mp_params.rx_page_size = 1U << binding->niov_shift;
+	if (binding->area.niov_shift != PAGE_SHIFT)
+		mp_params.rx_page_size = 1U << binding->area.niov_shift;
 
 	rxq = __netif_get_rx_queue(dev, rxq_idx);
 	err = xa_alloc(&binding->bound_rxqs, &xa_idx, rxq, xa_limit_32b,
@@ -342,7 +342,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 	binding->vdev = vdev;
 	write_pnet(&binding->net, sock_net(nl_sk));
 	binding->uid = sk_uid(nl_sk);
-	binding->niov_shift = niov_shift;
+	binding->area.niov_shift = niov_shift;
 	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
 
 	err = percpu_ref_init(&binding->ref,
@@ -605,7 +605,7 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
 	pool->dma_sync = false;
 	pool->dma_sync_for_cpu = false;
 
-	if (pool->p.order != binding->niov_shift - PAGE_SHIFT)
+	if (pool->p.order != binding->area.niov_shift - PAGE_SHIFT)
 		return -E2BIG;
 
 	net_devmem_dmabuf_binding_get(binding);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index c4f476947dfa..448521990ad7 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -83,8 +83,6 @@ struct net_devmem_dmabuf_binding {
 	 */
 	struct net_iov **tx_vec;
 
-	unsigned int niov_shift;
-
 	struct work_struct unbind_w;
 };
 
@@ -127,7 +125,7 @@ static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
 	struct net_devmem_dmabuf_binding *binding =
 		net_devmem_iov_binding(niov);
 
-	return (unsigned long)net_iov_idx(niov) << binding->niov_shift;
+	return (unsigned long)net_iov_idx(niov) << binding->area.niov_shift;
 }
 
 static inline bool
-- 
2.56.0

