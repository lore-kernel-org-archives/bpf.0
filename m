Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D973D1CAE
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241718; cv=none; b=ayc6/PbPupc7xHW/lV9YP1CwxTFmTjFkDQt4msbWu342k+Nnn1p8QysR7v8fEkOtflwvDpFmm90d2Fd8h3REU5vHEBi84odoiQTfFrRYqau8Fmc9hitnmChGM98BPkh4FhzkyijI6ob3zFY4jgWnh8jv38uOZqgo22VAsBWTpm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241718; c=relaxed/simple;
	bh=ZUvWTrIxNz70VSezRKFX4blS66wvJCWytkqwkeJwkLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZwegsatuxwQ5lnisT0HDyFWW6z7V3gXT++V/VFlfA1mMSMslsKe1pp5xengGET/ZY90OAJwWRjErYaQmdHeGu5W2dPARYh8C8Bx/X0lifnYXpSErvX6tJ2sDoNbXBhEmUWYhivqWVEZRsG8NdWI/o6CsER9gyMN9icKPcs02po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzqOqvwh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzqOqvwh"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so43477015ad.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241717; x=1776846517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCwTbhoxO2es8i0LbayXcV+D6Aj0lOcdld/MQ+SztSQ=;
        b=FzqOqvwhWKFeSQ/ZdOfhKI6yxd1El5L/rMkbv0LmeDT18j0XT++byCJn89iVyF7IL0
         ZYp7X4RGJh9JSwM0TUe9toZlfRfHluSofQY73gdxs3ivwzCq19BOFIIVabdhYGbiIly5
         +xc2szXtnTSxNc/O2ee0ceIaPkp5fEbFtmug3fruc5cQdZsa5ybei6gk5ON2FSTglZnL
         1aZ8dtW9P9PU3GflLxL5QQm+NYX7JDSMMDn2WV09e/0xSfhpv+T9daVGqskZnMd4GzbR
         1ddGgo8HLq2tS5Cf0EZ8lo2qKP/ct0slZm+zrWaGgHsoN50NFwFYH+/pAD0HMCR/T5P6
         8StA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241717; x=1776846517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OCwTbhoxO2es8i0LbayXcV+D6Aj0lOcdld/MQ+SztSQ=;
        b=Vt8gZ62qZcaqcB9z7GvJhDduNJsWtA/UW8M3CNhEJxoF/E+vGrDObVnNQbn1HwLLLG
         XEulaKWxeySDeRHMIw7bAIdcMM1rT+BGqWdC01pb6k5Jg/ttMVGU8nVtwyeHXTl1K1/l
         VNbn4IKO4NsgHGkEAJ+58UzQd1oZf4mE/Rw52HW9tFe61yt7hobInte2FeM1i6Wp7l91
         /1ul6pxsSquErzUK0eLJHTIk1VBf6Mg03O1SV8zKGJby7sb5htFoNqxUDlG1DY+cURrs
         xzmZgJAQ6/MpXsSzPgQZxuZx8CehwQCqL3BAVosd0L4lSlcovlUCJ88hD5HcGCO03azz
         hcvw==
X-Gm-Message-State: AOJu0Yyu+f+GI1RJmuYXzJJwUQN0yjC+Oef0IGK3DBTbtljhx1gHnD60
	lJdVzFMwhrmGQq/pEU6Bvp8dRl1aoavZPlx2jZqg0cMJWuxiwTVWru7t
X-Gm-Gg: AeBDiev8QN0MPhyIzmIwL0lqgidMon5Q6tR2Z6YTqKKd5UXmvFl1QpVAL+ILMXsx/sP
	KRK/4ibNgZMTUDsYyJy6Wc6VahDsPXhUdGjbIO3LStGLr6HNwwmesDA0zNTuOEVEllua0iiROPk
	OgNW/iUJCBv7CCiXbKQDorVQTdygv6elx92+R7h27OCHCPC2FshH+TGRhcioov1QXvy1oUFGatm
	SL4XrMw3+nDpgyHKRFCMNCD60FuZ+QY+05e/plNp/xSKGnes9MxxJTl6O1v76BqYMdE3rT0GOCo
	3TekZSpez1jG7VE+oKqMsGoZmsjzcUDsx5elPS4GBr/PDOJHdXfNEmcldE+Yt0IK5KVi59J0Ji7
	89/oavWclr4ov2yXd6/nucfVRH+qW9Pk907QMf55Q3VBzYf1NCQoSI8z3MuXpYe+R/Hb+HiUzw7
	0J2MXZMhz+G6oLt1CuMYqDyxqgFbXiYnLqEmC15Hdp9nU1z4XHENb2XRd9rFU+ULLqyL5E3PmNj
	P7ioqE1
X-Received: by 2002:a17:903:3c27:b0:2b4:696b:7bb7 with SMTP id d9443c01a7336-2b4696b7c10mr77559355ad.15.1776241716629;
        Wed, 15 Apr 2026 01:28:36 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:28:35 -0700 (PDT)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v4 14/14] xsk: optimize xsk_build_skb for batch copy-mode fast path
Date: Wed, 15 Apr 2026 16:26:54 +0800
Message-Id: <20260415082654.21026-15-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Three targeted optimizations for the batch copy-mode TX hot path:

Replace skb_store_bits() with memcpy() for single-buffer first-desc
path.  After skb_reserve() + skb_put(), the SKB is freshly allocated
with all data in the linear area and no frags, so skb_store_bits()
degenerates to memcpy(skb->data, buffer, len) but carries unnecessary
function call overhead, offset validation, and frag iteration logic.

Inline UMEM address computation in Phase 3 and pass the pre-computed
buffer pointer to xsk_build_skb(), avoiding the per-packet non-inlined
xp_raw_get_data() (EXPORT_SYMBOL) call chain:
xsk_buff_raw_get_data -> xp_raw_get_data -> __xp_raw_get_addr +
__xp_raw_get_data.
In the batch loop the pool->addrs and pool->unaligned are invariant,
so we cache them once and compute each buffer address inline.

Prefetch the *next* descriptor's UMEM data buffer at the top of the
Phase 3 loop, hiding the memory latency of the upcoming memcpy.

It improves 3-4% performance stably.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  3 ++-
 net/core/skbuff.c      | 18 ++++++++++++++++--
 net/xdp/xsk.c          | 15 ++++++---------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 0609e3b04279..5e05236c7fba 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -139,7 +139,8 @@ void __xsk_map_flush(struct list_head *flush_list);
 INDIRECT_CALLABLE_DECLARE(void xsk_destruct_skb(struct sk_buff *));
 struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			      struct sk_buff *allocated_skb,
-			      struct xdp_desc *desc);
+			      struct xdp_desc *desc,
+			      void *buffer);
 int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err);
 int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5726b1566b2b..bef5270e6332 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -752,14 +752,28 @@ int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err
 	if (total_truesize)
 		refcount_add(total_truesize, &xs->sk.sk_wmem_alloc);
 
-	/* Phase 3: Build SKBs with packet data */
+	/* Phase 3: Build SKBs with packet data. */
+	struct xsk_buff_pool *pool = xs->pool;
+	void *pool_addrs = pool->addrs;
+	bool unaligned = pool->unaligned;
+
 	for (j = 0; j < alloc_descs; j++) {
+		u64 addr = descs[j].addr;
+		void *buffer;
+
+		if (unaligned)
+			addr = xp_unaligned_add_offset_to_addr(addr);
+		buffer = pool_addrs + addr;
+
+		if (j + 1 < alloc_descs)
+			prefetch(pool_addrs + descs[j + 1].addr);
+
 		if (!xs->skb) {
 			skb = skbs[skb_count - 1 - k];
 			k++;
 		}
 
-		skb = xsk_build_skb(xs, skb, &descs[j]);
+		skb = xsk_build_skb(xs, skb, &descs[j], buffer);
 		if (IS_ERR(skb)) {
 			*err = PTR_ERR(skb);
 			break;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index be341290e42c..3bf81b838075 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -811,7 +811,8 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 
 struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			      struct sk_buff *allocated_skb,
-			      struct xdp_desc *desc)
+			      struct xdp_desc *desc,
+			      void *buffer)
 {
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
@@ -825,11 +826,10 @@ struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			goto free_err;
 		}
 	} else {
-		u32 hr, tr, len;
-		void *buffer;
+		u32 hr, tr, len = desc->len;
 
-		buffer = xsk_buff_raw_get_data(xs->pool, desc->addr);
-		len = desc->len;
+		if (!buffer)
+			buffer = xsk_buff_raw_get_data(xs->pool, desc->addr);
 
 		if (!skb) {
 			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
@@ -844,10 +844,7 @@ struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			skb_reserve(skb, hr);
 			skb_put(skb, len);
-
-			err = skb_store_bits(skb, 0, buffer, len);
-			if (unlikely(err))
-				goto free_err;
+			memcpy(skb->data, buffer, len);
 
 			xsk_skb_init_misc(skb, xs, desc->addr);
 			if (desc->options & XDP_TX_METADATA) {
-- 
2.41.3

