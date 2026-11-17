Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934045;
	b=UCj32OSr2ep4s72HxWzg5R+yCehlQ373lLKJsdo4TwdnVVbJC7uKsRuJ6BHkmdMGZtKz
	 FM1qswpR91aCebjW0w5LDRE9NRg/hKm+5mJ4JC0hrY4AajDYyoFuHsgAR9G6iSERwKb5f
	 zJNd6dBdOJglREK5d0ZCRu59l170rgr/oLe/jnJpYSkURr535Ix+NlmFXFmCjFFlx9xFq
	 M1oObFmxSDLEI8c9/VT7+mMp4P4aBM/fApy63C4rHcC7NFuOSfJbhM1jIGEwtgaHAIPrG
	 RbANWpZX3dAf31uaOot7LoQB9mdvdjzk3YC4hm58AzcooxU4sGJupK6FKlZiXd4zepw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934045;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pCyrNNRRaMaHb57y9IHagCD7m2ry5FzLLNXfOWMlat0=;
	b=qYwKlBZ/ItglvdzvnR+LRZ0x+t0TzlR1jl0LviGzl5/KJVMy5kq+QumglBYE1WhZLtf7
	 hRhRisHJcQSmRmwvzVOczWBbYLa4s6Ewh1ht44MFiw97z+CkK1lTgvzxL6Pk/ysdCZGMx
	 ImO/Q9QJCteaKFlblCYjOeAeJkkv9rSagxef1FvCNvmOGz8EVJnbEdHMpYHpWioPYrvLc
	 476XXCPUNSwDFDKDa0cuYwxmOewSFXdAeyZXVaA5OQ1cmCOBpD1Av7x/1NFQP2qdRiuZq
	 zGM7QHfWyo2wG9Pra6VY4yi2xnuDuLaLUk0HprOdx2BLjwxbl7G/ydD2DNrNhcMg9CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVu37T6K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF7606A881;
	Tue, 17 Nov 2026 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVu37T6K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659891F000C4;
	Tue, 17 Nov 2026 16:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794934044;
	bh=pCyrNNRRaMaHb57y9IHagCD7m2ry5FzLLNXfOWMlat0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BVu37T6KP/58I/JLFMsZNfLzUs7FaJfOnQXNQlQmMxOQcwNQf+q4cVAI9Wdstgjgc
	 7pufa+9xb9irJ3NJQ3fbwCfaOJNN6YOkRnY9KIF58orx3I5fvVA+6gcp/r8TXEf6mR
	 Cs64yIwCgffhyrDHEwji/NqyabYnvNKP5oUURjKvjQ8D17BBfXec4+StMYy913U/8V
	 JqF+a+3E1zIrIee1QjGZz9u4P2QKy9Mpq+m2RKVlMhN7SiJHwhwYQdhe46IR0CW8lR
	 pxA810dVE0xl107OGZOoBVP4BT16g1VkVY8p2rZOgU4F4SWsRMt+iRxZdp0wEh22rR
	 c2ZDYYg87uLig==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	kernel-team@meta.com,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Weiming Shi <bestswngs@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 1/7] bpf: Keep XDP helpers within readable data
Date: Tue, 17 Nov 2026 17:46:52 +0100
Message-ID: <20261117164700.2157816-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117164700.2157816-1-bjorn@kernel.org>
References: <20261117164700.2157816-1-bjorn@kernel.org>
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

Devmem and io_uring zero-copy RX put payload in fragments that the
kernel cannot read. XDP helpers must not treat these fragments as
normal pages.

Reject operations that read or write these fragments. Access to the
linear part still works. Tail trimming does not read the payload;
clear the unreadable flag after it removes every fragment.

Drivers currently use these buffers to build skbs without running XDP.
These checks are needed before native XDP can run on provider queues.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/filter.h |  9 +++++----
 include/net/xdp.h      | 12 ++++++++++++
 kernel/bpf/helpers.c   |  4 +++-
 net/core/filter.c      | 37 +++++++++++++++++++++++++------------
 4 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4f0cd67caccb..5c2f57ec3940 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1994,8 +1994,8 @@ int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *from,
 int __bpf_xdp_load_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len);
 int __bpf_xdp_store_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len);
 void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len);
-void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
-		      void *buf, unsigned long len, bool flush);
+int bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
+		     void *buf, unsigned long len, bool flush);
 int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
 			       const void *from, u32 len, u64 flags);
 void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset);
@@ -2029,9 +2029,10 @@ static inline void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len)
 	return NULL;
 }
 
-static inline void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, void *buf,
-				    unsigned long len, bool flush)
+static inline int bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
+				   void *buf, unsigned long len, bool flush)
 {
+	return -EOPNOTSUPP;
 }
 
 static inline int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231adfb5f8..16693cf9653e 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -136,6 +136,18 @@ static __always_inline void xdp_buff_set_frag_unreadable(struct xdp_buff *xdp)
 	xdp->flags |= XDP_FLAGS_FRAGS_UNREADABLE;
 }
 
+static __always_inline void
+xdp_buff_clear_frag_unreadable(struct xdp_buff *xdp)
+{
+	xdp->flags &= ~XDP_FLAGS_FRAGS_UNREADABLE;
+}
+
+static __always_inline bool
+xdp_buff_is_frag_unreadable(const struct xdp_buff *xdp)
+{
+	return !!(xdp->flags & XDP_FLAGS_FRAGS_UNREADABLE);
+}
+
 static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff *xdp)
 {
 	return xdp->flags;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6788489a2608..8c9e4640bcfe 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3140,7 +3140,9 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
 
 		if (!buffer__nullable)
 			return NULL;
-		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer__nullable, len, false);
+		if (bpf_xdp_copy_buf(ptr->data, ptr->offset + offset,
+				     buffer__nullable, len, false))
+			return NULL;
 		return buffer__nullable;
 	}
 	case BPF_DYNPTR_TYPE_SKB_META:
diff --git a/net/core/filter.c b/net/core/filter.c
index f42ecfb5841f..9a55f61fbcdf 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4269,8 +4269,8 @@ static const struct bpf_func_proto bpf_xdp_adjust_head_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
-void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
-		      void *buf, unsigned long len, bool flush)
+int bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
+		     void *buf, unsigned long len, bool flush)
 {
 	unsigned long ptr_len, ptr_off = 0;
 	skb_frag_t *next_frag, *end_frag;
@@ -4282,9 +4282,12 @@ void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		src = flush ? buf : xdp->data + off;
 		dst = flush ? xdp->data + off : buf;
 		memcpy(dst, src, len);
-		return;
+		return 0;
 	}
 
+	if (unlikely(xdp_buff_is_frag_unreadable(xdp)))
+		return -EFAULT;
+
 	sinfo = xdp_get_shared_info_from_buff(xdp);
 	end_frag = &sinfo->frags[sinfo->nr_frags];
 	next_frag = &sinfo->frags[0];
@@ -4314,6 +4317,8 @@ void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		ptr_len = skb_frag_size(next_frag);
 		next_frag++;
 	}
+
+	return 0;
 }
 
 void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len)
@@ -4332,6 +4337,9 @@ void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len)
 	if (likely(offset < size)) /* linear area */
 		goto out;
 
+	if (unlikely(xdp_buff_is_frag_unreadable(xdp)))
+		return ERR_PTR(-EFAULT);
+
 	sinfo = xdp_get_shared_info_from_buff(xdp);
 	offset -= size;
 	for (i = 0; i < sinfo->nr_frags; i++) { /* paged area */
@@ -4358,10 +4366,9 @@ BPF_CALL_4(bpf_xdp_load_bytes, struct xdp_buff *, xdp, u32, offset,
 		return PTR_ERR(ptr);
 
 	if (!ptr)
-		bpf_xdp_copy_buf(xdp, offset, buf, len, false);
-	else
-		memmove(buf, ptr, len);
+		return bpf_xdp_copy_buf(xdp, offset, buf, len, false);
 
+	memmove(buf, ptr, len);
 	return 0;
 }
 
@@ -4390,11 +4397,9 @@ BPF_CALL_4(bpf_xdp_store_bytes, struct xdp_buff *, xdp, u32, offset,
 		return PTR_ERR(ptr);
 
 	if (!ptr)
-		bpf_xdp_copy_buf(xdp, offset, buf, len, true);
-	else
-		/* through a dynptr the source may be an overlapping slice */
-		memmove(ptr, buf, len);
+		return bpf_xdp_copy_buf(xdp, offset, buf, len, true);
 
+	memmove(ptr, buf, len);
 	return 0;
 }
 
@@ -4422,6 +4427,8 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 
 	if (!rxq->frag_size || rxq->frag_size > xdp->frame_sz)
 		return -EOPNOTSUPP;
+	if (unlikely(xdp_buff_is_frag_unreadable(xdp)))
+		return -EFAULT;
 
 	tailroom = rxq->frag_size - skb_frag_size(frag) -
 		   skb_frag_off(frag) % rxq->frag_size;
@@ -4503,6 +4510,7 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
 	if (unlikely(!sinfo->nr_frags)) {
 		xdp_buff_clear_frags_flag(xdp);
 		xdp_buff_clear_frag_pfmemalloc(xdp);
+		xdp_buff_clear_frag_unreadable(xdp);
 		xdp->data_end -= offset;
 	}
 
@@ -5355,8 +5363,7 @@ static unsigned long bpf_xdp_copy(void *dst, const void *ctx,
 {
 	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
 
-	bpf_xdp_copy_buf(xdp, off, dst, len, false);
-	return 0;
+	return bpf_xdp_copy_buf(xdp, off, dst, len, false) ? len : 0;
 }
 
 BPF_CALL_5(bpf_xdp_event_output, struct xdp_buff *, xdp, struct bpf_map *, map,
@@ -5369,6 +5376,9 @@ BPF_CALL_5(bpf_xdp_event_output, struct xdp_buff *, xdp, struct bpf_map *, map,
 
 	if (unlikely(!xdp || xdp_size > xdp_get_buff_len(xdp)))
 		return -EFAULT;
+	if (unlikely(xdp_size > xdp->data_end - xdp->data &&
+		     xdp_buff_is_frag_unreadable(xdp)))
+		return -EFAULT;
 
 	return bpf_event_output(map, flags, meta, meta_size, xdp,
 				xdp_size, bpf_xdp_copy);
@@ -12797,6 +12807,7 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
  * Return:
  * * %0         - success
  * * %-EINVAL   - invalid len
+ * * %-EFAULT   - the kernel cannot read the fragments
  */
 __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 {
@@ -12812,6 +12823,8 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 
 	if (unlikely(len > xdp_get_buff_len(xdp)))
 		return -EINVAL;
+	if (unlikely(xdp_buff_is_frag_unreadable(xdp)))
+		return -EFAULT;
 
 	start = xdp_data_meta_unsupported(xdp) ? xdp->data : xdp->data_meta;
 
-- 
2.56.1

