Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EFE3F0761;
	Fri,  2 Oct 2026 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967690; cv=none; b=RtgKJAzDT/ofSOldW3tZj0L4XbmArDZQIjQi7HEzeUWSwgb+Gq1a3MolEpsoffPqL/1mJ9p1lvR48G2vIRZl/Hi+UZsVrR8ctm8KqGqfeSOX3jvNK5TRznx2KHo+8OAbKN62KUW0hztX6YF7yy1EsNmzWUbcch84CZPUmL/G5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967690; c=relaxed/simple;
	bh=oY1C4t8RHxsBEgieoQf7ys8r0tpFhCz/rFXsBN/Nwvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPO2Bj0UKT0pgrO53m0LRyDWTcl42O/oL2bzIr1LltRX+HPzs7vA7LE7R8bbFfJ5AYCPKFE58sqMyMM/G6Uhwjv7gAzkunvoj94FU1jhSgBaw4SKkBpxEmX2A4kRaXSz6uy5G4Sby1dU3rfsey+UmVwsmngfaucDdb35WhCYZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFVLoJ4A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFVLoJ4A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF59B1F000FF;
	Fri,  2 Oct 2026 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967688;
	bh=baiQBkVjONtGzJZ5YM5pTpAwSD0T6agoA0NCSrRkDY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cFVLoJ4Ar8xpupS6ZWS1L2Ispyp/2M5QLAWwVet5QlZB8uyEmrc9YA5z0F4PJ+jV+
	 roE0uilmdsiy8tZDiwWMyaeCBik3mnO+c9L7TlqVPqlGw6VSR3imWYgTtjQu2EfVzj
	 AlIowII10vkx+6zvZRcNlayX0gNoPf+Hlioh6ZMMwfNhb3ZZdWHVqPZ4HtYn9X16qd
	 mr2oV1KJ1aOwdMcgCerkFd3kOFYl8BlDM/t8xzb9lKFceYSU1/GFa9n84CrD6/X3eq
	 BSK2UehKZWWOwx8CZyvMboTaXPaIEVRMBdscP+AWhuhf8uVhKsBywDj6DjaDeFxheN
	 e0AdJD1+oov6g==
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
Subject: [RFC net-next 07/15] xsk: Keep the DMA mapping in the buffer pool
Date: Fri,  2 Oct 2026 21:00:08 +0200
Message-ID: <20261002190018.696925-8-bjorn@kernel.org>
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

At unmap, an XSK buffer pool looks up its DMA mapping again. It
searches the UMEM's mapping list for the pool's netdev. A memory
provider, added later in this series, can keep the mapping after the
queue is gone. By then the netdev may be cleared, so the search is
not reliable.

Store the mapping that xp_dma_map() picked in the pool, and unmap
that mapping. Hold a reference on the DMA device while the mapping
exists, so a late final unmap does not use a freed device.

The reference counting of shared mappings does not change.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/net/xsk_buff_pool.h | 1 +
 net/xdp/xsk_buff_pool.c     | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index a7df573784fd..77264c4902c0 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -67,6 +67,7 @@ struct xsk_buff_pool {
 	 * even when they are identical.
 	 */
 	dma_addr_t *dma_pages;
+	struct xsk_dma_map *dma_map;
 	struct xdp_buff_xsk *heads;
 	struct xdp_desc *tx_descs;
 	u64 chunk_mask;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index f01e1de7360e..244776a72961 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -373,7 +373,7 @@ static struct xsk_dma_map *xp_create_dma_map(struct device *dev, struct net_devi
 	}
 
 	dma_map->netdev = netdev;
-	dma_map->dev = dev;
+	dma_map->dev = get_device(dev);
 	dma_map->dma_pages_cnt = nr_pages;
 	refcount_set(&dma_map->users, 1);
 	list_add(&dma_map->list, &umem->xsk_dma_list);
@@ -384,6 +384,7 @@ static void xp_destroy_dma_map(struct xsk_dma_map *dma_map)
 {
 	list_del(&dma_map->list);
 	kvfree(dma_map->dma_pages);
+	put_device(dma_map->dev);
 	kfree(dma_map);
 }
 
@@ -407,12 +408,11 @@ static void __xp_dma_unmap(struct xsk_dma_map *dma_map, unsigned long attrs)
 
 void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs)
 {
-	struct xsk_dma_map *dma_map;
+	struct xsk_dma_map *dma_map = pool->dma_map;
 
 	if (!pool->dma_pages)
 		return;
 
-	dma_map = xp_find_dma_map(pool);
 	if (!dma_map) {
 		WARN(1, "Could not find dma_map for device");
 		return;
@@ -424,6 +424,7 @@ void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs)
 	kvfree(pool->dma_pages);
 	pool->dma_pages = NULL;
 	pool->dma_pages_cnt = 0;
+	pool->dma_map = NULL;
 	pool->dev = NULL;
 }
 EXPORT_SYMBOL(xp_dma_unmap);
@@ -460,6 +461,7 @@ static int xp_init_dma_info(struct xsk_buff_pool *pool, struct xsk_dma_map *dma_
 		return -ENOMEM;
 
 	pool->dev = dma_map->dev;
+	pool->dma_map = dma_map;
 	pool->dma_pages_cnt = dma_map->dma_pages_cnt;
 	memcpy(pool->dma_pages, dma_map->dma_pages,
 	       pool->dma_pages_cnt * sizeof(*pool->dma_pages));
-- 
2.55.0

