Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208263D9043
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546436; cv=none; b=EzctcIZ3W+SEICxHMbmF1zcvWbFyI2H+xiceg9q3juFJ4u4OxeFnAnj7eByveCaUjNOhvYI9a1ncGb0lwdKupXME8ubgx4/DnEEPRoUyaCHqw3onUIn2ecmiYxcdRzKoUEZLyj0z+x4blEoaP+++X7NBD6hZ1QaJEFtl3Tfz5P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546436; c=relaxed/simple;
	bh=gZXSjVV+EhPzqrz1y5g+JcyjmC0K8V1222JL7roYnrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FyNMf7PqhCRA9nognaZBQCGrPUvIjyK6YQpPFAIm5AAVNYe66R2GxtC5U5TOBrY9p5XD08ht+OfoEv/2jL//850GjhdrgHJtVvOZFZd3acsIiZPj3OUC3aEIRkNQxJM+frHtPJZSvqdocCYAmt2rB93zLVwhuJp+T+T1YJ43Xmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqMfPNBq; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqMfPNBq"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6d817a94747so321868eaf.3
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 15:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546429; x=1791151229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5SnaOI9os24/FlLLZlHcaQE+bseaAXy0CLUFqMKAceU=;
        b=FqMfPNBq073VACiUvfrNVkKFkocppAqRligcs5SSqEAE7op2S3EEMtbGK0lvXQI0bS
         MmvGhO+46XaKlJ96DwUHxvb7aUvKb+wQonGh7NaYKLoJ1TWp+Tr0GW4rICJM/YLX3TtY
         mNl4tkyBjLY2sCakZuUM9HCfPGjJ1w+zMuK3Q8iqQSJR7X9HU990zXBeMs88/BayujM/
         s8LW9GQIiXk7ZoesVghdP+YL7S6pVPQ11GEY+UZE08TZ0934xbD5d0S+lfpwP4H9kK1t
         dNiuMG6Gu0eJo/QAX/+VA5G6CW/wGjUz3wC09WJ/pezqMy8sSPgCQsQZiTxHpFrb4+/2
         eYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546429; x=1791151229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SnaOI9os24/FlLLZlHcaQE+bseaAXy0CLUFqMKAceU=;
        b=w9vM19RJhl/rwK54XNdXAvE+HRr+5JdHQD8aXFCc8Zdnm3Rh1b7yRQbjQRWVCwkpG3
         5FqUzaCCH+6uZomGziedzKC7GHiHM2CADs+ZD44lhXdGn5TOKu/VaUS2KMms9+gPItPb
         PhPxPNF6ryM4F/M16xn26QAKr41HGHs7ODLJRiRzM0+1tG9h+xKdU1fpAITs94IsFp5R
         J9Wrelge2gWWRUJwfQE+mVJsUVj1oMWM1T73oTGx0ky3DZ+72OEweQc5fIRWv3xIuGBS
         sT06Lh4RPIH/8yUDF1fIQX6W+q1lSk8vZJrb+fodxlupy48WXg4kg8NTVUZprvRRBk9A
         0nZg==
X-Forwarded-Encrypted: i=1; AKwUvBzInPGuyytqPAT7txSenaTqelYRqgSsHy6cG5eXVjhjeRcO7WZsEUkmwWJ8LdNID23ewQU=@vger.kernel.org
X-Gm-Message-State: AFuF++kDXDBLPp6XwJ/A9FKZhRTt0zfJLmER3GTkQ06Bqn46A0IGCNRz
	74y3fCejTbxuFNql9Vx08WFsxtwryoxGBJp5vYMBZpjaMGXf/kOs9RGY
X-Gm-Gg: AYBFou1UIuvm3CP/23QVi39TSJUynIK6TRWhV+peKlYqdS3TNGFNNjjh16ufw/aWLsM
	kzo3k743rJyRDd9qEelGnVDR2Lo0obf/w0Xocw8YUcG49TtB5TJ4YTX7eC9uDPSHBmpMOpWsA9q
	8MWi5qNuhgh7egijY9ZtSG2psB4HTLx2UHaecwKgpaHBhHXgkuZCfrjhJTpxHux7In0SyXWhETX
	h15lXnfLZGq6FlsngdkfqB6soDDGfnn3v8hA/ydim5hgpFCGPavqHfiMdfq2OwF+tFzaMjroF9k
	xDarWtKK9FFZQTzTE0uYs+V41zB80pZW5jLZPis4qMFjUToAOXedAGiZ3vIL/3qGmS3h15/W6VB
	DbXuZMJhYVvgCmONrNr+ou6VojkVVzOD1uWrJmOHKSfFed57WCzb/XjNfd/QNwsqCgKZy984QXd
	IfjQ6EWyt+PisCer/dKi93jmZGSDZkEZDKQqn0LwnJYpRghkqVM//u7MVd8L78roIe5eZbrsxNo
	VDoqE6yhSpgvkCbRkoouRueDvyjVjg5uf3ah0Z7pQEtW7YMJm0EaIld7ieIYyd+vixcIRuVpeoQ
	KUoje2tDzkSh6cVcW3ZLkS6ZM9k2pqUjYi/dm/yqOzu3obHGnGS0ma6QPmsYhDFFjuIxJfsySWf
	SIXETHWbfU2DgNiqmQ9s7
X-Received: by 2002:a4a:e90c:0:b0:6c7:7668:a2a5 with SMTP id 006d021491bc7-6d43f4bd3d0mr10312715eaf.25.1790546429037;
        Sun, 27 Sep 2026 15:00:29 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81b3de6f7e1sm4874147a34.22.2026.09.27.15.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:00:28 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 15:59:51 -0600
Subject: [PATCH net-next v5 16/19] xsk: allow drivers to retain DMA
 mappings independently of pools
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-submit-stmmac-reset-fixes-v1-v5-16-feec6c14dd06@gmail.com>
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jose Abreu <Jose.Abreu@synopsys.com>, 
 Yao Zi <me@ziyao.cc>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, Linkui Xiao <xiaolinkui@kylinos.cn>, 
 Linkui Xiao <xiaolinkui@126.com>, linux-tegra@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

An unsuccessful device shutdown does not make its DMA memory safe to
unmap. AF_XDP pool removal must nevertheless complete: the last socket
release invokes the driver detach callback and then destroys the pool,
regardless of the callback's return value.

Provide an independent reference to the existing DMA mapping and its
UMEM pages. A driver can take it while installing rings and release it
after DMA has actually stopped. Retain the pool and buffer-head storage
separately from the pool users reference which triggers teardown. This
lets a driver keep DMA-owned frames out of the reusable free list even
after socket teardown has released its fill and completion rings.

Return retained buffers only after DMA shutdown, before dropping the DMA
reference. Keeping pages pinned alone does not prevent an active pool
from recycling a frame still reachable by hardware. The retained metadata
does not permit other pool operations after detach.

Keep the DMA device and the mapping's netdev lookup key allocated,
without taking a netdev usage reference that would prevent unregister.
Save the mapping attributes and unmap before dropping the last retained
UMEM reference. Mapping reference operations are serialized by RTNL,
like the existing mapping list operations.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v5:
- Retain pool/head storage independently of socket users so DMA-owned
  frames need not be returned to the free list during pool removal.
- Keep the saved mapping in a separate reference object, since detach
  clears the pool's device and DMA lookup state.
---
 include/net/xdp_sock_drv.h  | 25 +++++++++++++++++
 include/net/xsk_buff_pool.h |  7 +++++
 net/xdp/xsk_buff_pool.c     | 67 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index d94aeb506379..a39768b1c00f 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -95,6 +95,22 @@ static inline void xsk_pool_dma_unmap(struct xsk_buff_pool *pool,
 	xp_dma_unmap(pool, attrs);
 }
 
+/* RTNL must be held. Retain mappings, pages and buffer metadata without
+ * postponing the socket's detach callback. Do not return DMA-owned buffers
+ * with xsk_buff_free() until hardware has stopped, even after pool removal.
+ * Afterwards, free those buffers before putting the reference. This does not
+ * retain the FILL/COMPLETION rings or allow other pool operations after detach.
+ */
+static inline struct xsk_dma_ref *xsk_pool_dma_get(struct xsk_buff_pool *pool)
+{
+	return xp_dma_get(pool);
+}
+
+static inline void xsk_pool_dma_put(struct xsk_dma_ref *ref)
+{
+	xp_dma_put(ref);
+}
+
 static inline int xsk_pool_dma_map(struct xsk_buff_pool *pool,
 				   struct device *dev, unsigned long attrs)
 {
@@ -432,6 +448,15 @@ static inline void xsk_pool_dma_unmap(struct xsk_buff_pool *pool,
 {
 }
 
+static inline struct xsk_dma_ref *xsk_pool_dma_get(struct xsk_buff_pool *pool)
+{
+	return NULL;
+}
+
+static inline void xsk_pool_dma_put(struct xsk_dma_ref *ref)
+{
+}
+
 static inline int xsk_pool_dma_map(struct xsk_buff_pool *pool,
 				   struct device *dev, unsigned long attrs)
 {
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index a7df573784fd..df7e20fe5ae3 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -11,6 +11,7 @@
 #include <net/xdp.h>
 
 struct xsk_buff_pool;
+struct xsk_dma_ref;
 struct xdp_rxq_info;
 struct xsk_cb_desc;
 struct xsk_queue;
@@ -38,6 +39,8 @@ struct xsk_dma_map {
 	dma_addr_t *dma_pages;
 	struct device *dev;
 	struct net_device *netdev;
+	struct xdp_umem *umem;
+	unsigned long attrs;
 	refcount_t users;
 	struct list_head list; /* Protected by the RTNL_LOCK */
 	u32 dma_pages_cnt;
@@ -52,6 +55,8 @@ struct xsk_buff_pool {
 	spinlock_t xsk_tx_list_lock;
 	refcount_t users;
 	struct xdp_umem *umem;
+	/* Pool/head storage; DMA references must not postpone socket teardown. */
+	refcount_t refs;
 	struct work_struct work;
 	/* Protects generic receive in shared and non-shared umem mode. */
 	spinlock_t rx_lock;
@@ -143,6 +148,8 @@ void xp_fill_cb(struct xsk_buff_pool *pool, struct xsk_cb_desc *desc);
 int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 	       unsigned long attrs, struct page **pages, u32 nr_pages);
 void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs);
+struct xsk_dma_ref *xp_dma_get(struct xsk_buff_pool *pool);
+void xp_dma_put(struct xsk_dma_ref *ref);
 struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool);
 u32 xp_alloc_batch(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u32 max);
 bool xp_can_alloc(struct xsk_buff_pool *pool, u32 count);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index c58f56f24a9c..8c71974494c9 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -12,6 +12,11 @@
 
 #define ETH_PAD_LEN (ETH_HLEN + 2 * VLAN_HLEN  + ETH_FCS_LEN)
 
+struct xsk_dma_ref {
+	struct xsk_dma_map *dma_map;
+	struct xsk_buff_pool *pool;
+};
+
 void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 {
 	if (!xs->tx)
@@ -34,7 +39,7 @@ void xp_del_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 
 void xp_destroy(struct xsk_buff_pool *pool)
 {
-	if (!pool)
+	if (!pool || !refcount_dec_and_test(&pool->refs))
 		return;
 
 	kvfree(pool->tx_descs);
@@ -68,6 +73,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 	pool = kvzalloc_flex(*pool, free_heads, entries);
 	if (!pool)
 		goto out;
+	refcount_set(&pool->refs, 1);
 
 	pool->heads = kvzalloc_objs(*pool->heads, umem->chunks);
 	if (!pool->heads)
@@ -360,7 +366,8 @@ static struct xsk_dma_map *xp_find_dma_map(struct xsk_buff_pool *pool)
 }
 
 static struct xsk_dma_map *xp_create_dma_map(struct device *dev, struct net_device *netdev,
-					     u32 nr_pages, struct xdp_umem *umem)
+					     u32 nr_pages, struct xdp_umem *umem,
+					     unsigned long attrs)
 {
 	struct xsk_dma_map *dma_map;
 
@@ -376,6 +383,8 @@ static struct xsk_dma_map *xp_create_dma_map(struct device *dev, struct net_devi
 
 	dma_map->netdev = netdev;
 	dma_map->dev = dev;
+	dma_map->umem = umem;
+	dma_map->attrs = attrs;
 	dma_map->dma_pages_cnt = nr_pages;
 	refcount_set(&dma_map->users, 1);
 	list_add(&dma_map->list, &umem->xsk_dma_list);
@@ -430,6 +439,58 @@ void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs)
 }
 EXPORT_SYMBOL(xp_dma_unmap);
 
+struct xsk_dma_ref *xp_dma_get(struct xsk_buff_pool *pool)
+{
+	struct xsk_dma_map *dma_map;
+	struct xsk_dma_ref *ref;
+
+	ASSERT_RTNL();
+	if (!pool->dma_pages)
+		return NULL;
+	dma_map = xp_find_dma_map(pool);
+	if (WARN_ON_ONCE(!dma_map))
+		return NULL;
+
+	ref = kmalloc_obj(*ref);
+	if (!ref)
+		return NULL;
+	ref->dma_map = dma_map;
+	ref->pool = pool;
+	refcount_inc(&pool->refs);
+	refcount_inc(&dma_map->users);
+	xdp_get_umem(dma_map->umem);
+	get_device(dma_map->dev);
+	/* Keep the mapping's lookup key alive without preventing unregister. */
+	get_device(&dma_map->netdev->dev);
+	return ref;
+}
+EXPORT_SYMBOL_GPL(xp_dma_get);
+
+void xp_dma_put(struct xsk_dma_ref *ref)
+{
+	struct xsk_dma_map *dma_map;
+	struct net_device *netdev;
+	struct xdp_umem *umem;
+	struct device *dev;
+
+	ASSERT_RTNL();
+	if (!ref)
+		return;
+	dma_map = ref->dma_map;
+	dev = dma_map->dev;
+	netdev = dma_map->netdev;
+	umem = dma_map->umem;
+	if (refcount_dec_and_test(&dma_map->users))
+		__xp_dma_unmap(dma_map, dma_map->attrs);
+	/* Unmap before the final reference can unpin the UMEM pages. */
+	xdp_put_umem(umem, false);
+	put_device(&netdev->dev);
+	put_device(dev);
+	xp_destroy(ref->pool);
+	kfree(ref);
+}
+EXPORT_SYMBOL_GPL(xp_dma_put);
+
 static void xp_check_dma_contiguity(struct xsk_dma_map *dma_map)
 {
 	u32 i;
@@ -487,7 +548,7 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 		return 0;
 	}
 
-	dma_map = xp_create_dma_map(dev, pool->netdev, nr_pages, pool->umem);
+	dma_map = xp_create_dma_map(dev, pool->netdev, nr_pages, pool->umem, attrs);
 	if (!dma_map)
 		return -ENOMEM;
 

-- 
2.53.0

