Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9CF3A5E8E
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426636; cv=none; b=Gk9mcNwobrNOKtdEjXAR+Uw3sJ0GEpchiGmG830F9ENYqTxGHVypIyRnfso4sqgvJtH0hH5FG/DYX7x2MswEqbQzBE28Tx6ZzJVR9s2e0QtHJX5IDWFY/niogGLC9fj0ldb9HFqeJ4+prkHrO7a2sRX0D1c8ZPIYCl2umMupFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426636; c=relaxed/simple;
	bh=a26N9QychM8fZMjejQg/slCeuzTZkM3D0/ezQuo5Jfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qzrtHct92IY56l+Ut7bt/DJav7NEjtP46HgnnD+Gd7LJSw0fqEpcZ2EFDGAGUzT17lcRcfkcCTAOUeGYgxcJ6uVTa4i6kfaJ/Anvvh6sx1ZsxuPo34pNQeH8sdD5q27LQUaNUieVRZHFu+srhWrctS9Y3bveDUsPZf79cKs9UCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mubX7EAS; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mubX7EAS"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30f1b904861so6260035eec.0
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 19:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791426633; x=1792031433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TDsS32wB16lvEQn+E3CNe6P8DRVmJGdHzyocmK7NvN0=;
        b=mubX7EAShizQEbSfhWyxXjRSRRjxcr9bYKyorbN776VfACf/uoKKff/QNhmVK5WXXw
         /5REk5wqHkzmkpxlgeoYIEz4CJdFiqIzB2WYR4P879sWw36rEHc9RKnadI9Z/Ranu6t5
         8kYd3re6nzNdbj2nPUkHQOYtN48c9YwrSmcLK94L/aN98mQykJyAEaXrF5uDeCxP8l24
         4Ve267rf0cIPEjV2dHJlUe3lQzgUc+5votF9sDSxXVPbBB3vCpfcNPA7qEfoRoCxSlHP
         SETFlN1fCYKKchSAWTEn+ZGvXUU+x+Yx9hY0q3hUMv7crGViWlEIHKeG8X+4wD0rGdPq
         +FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791426633; x=1792031433;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TDsS32wB16lvEQn+E3CNe6P8DRVmJGdHzyocmK7NvN0=;
        b=veS1G64L51w1kCzCWTQ9v/1DzOH8k4KXTos4zJCdX9avGoSSBMNGP1hmNlW044KHBV
         UqyCBJu497R5vgo+gByHP01Gx1yYrkQC2mXd9a+ALg/8rLuCFe3w77jpA1GkCefDB8i3
         Mnhm3HUoUGFRQ6FwE19e7/QzE6khkn9x3/oWhYpSP5I1DyncGElS1SHt6K+UlWkgsHtF
         fvMLypyFe3IDeLhkhrtVlMSxz/J24nkOMp5ktdnPQX7Z0sh6dXGjlTBR5UXNeizyjYAk
         v+WikEsq8qyO16GflkQXLlEoKWIlNymGsW0BZmrkGiyKJ7CwlhYigtteRFkG38ZJQtzs
         oxlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQvdLHMvVlyD93ZP/J1tJpTZqxQJxc1QJtXcL3ARNBUjbbrqvaMC4qiXEeXBvHVfJVFKg=@vger.kernel.org
X-Gm-Message-State: AFuF++npevx5F9Yt155tgCnsydO3PWzBYeuk8pxSr8LTWjyED83FN9Yh
	kt2dp5L3FVoUo00A9C9LsM06IiZ4SugIBPvhF9Lw3pVvWfY/OSEGVpQG4w9Zee3PGEZ6gEO1Ns/
	6k1DYwZWG+jPliDCwd/jVGeWnTQ==
X-Received: from dyctz4.prod.google.com ([2002:a05:7301:9f04:b0:34c:9108:3e2f])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:43a5:b0:14c:c947:6afb with SMTP id a92af1059eb24-1620374e1bfmr6425351c88.15.1791426632291;
 Wed, 07 Oct 2026 19:30:32 -0700 (PDT)
Date: Thu,  8 Oct 2026 02:30:17 +0000
In-Reply-To: <20261008023030.1089616-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008023030.1089616-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008023030.1089616-2-almasrymina@google.com>
Subject: [PATCH net-next v2 1/2] net: netmem: document netmem and memory
 provider design in comments
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Luigi Rizzo <lrizzo@google.com>, "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Clarify the netmem, memory provider, page_pool, and skb fragment design
principles in header and code comments:

- Memory providers allocate struct net_iov or struct page, cast them to
  netmem_ref, and pass them to page_pool; page_pool, drivers, and the
  core stack operate on netmem_ref and must not downcast to page or
  net_iov outside dedicated netmem helpers.
- While current memory providers supply struct net_iov, they are not
  architecturally restricted to net_iov and may supply page-backed
  netmems.
- While current net_iov types are CPU-unreadable, net_iov has no
  inherent restrictions and may be readable or unreadable.
- New code should generalize existing limitations as much as possible to
  match these design principles.
- Per-provider logic belongs in memory_provider_ops, and per-netmem-type
  logic belongs in netmem helpers.
- All frags in an skb must share the same backing netmem memory type,
  and skbs with different frag memory types must not be coalesced.

Cc: Luigi Rizzo <lrizzo@google.com>
Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
v2:
- Add Jesper's Acked-by tag.
- Note current implementation status (memory providers currently supply
  net_iov, and net_iov is currently unreadable) alongside target design
  principles and expectation for new code to generalize existing
  limitations (Stanislav Fomichev).
- Link to v1: https://lore.kernel.org/netdev/20261005004958.3603059-1-almas=
rymina@google.com/
---
 include/linux/skbuff.h                  |  4 ++++
 include/net/netmem.h                    | 30 ++++++++++++++++---------
 include/net/page_pool/helpers.h         | 18 ++++++++++-----
 include/net/page_pool/memory_provider.h | 10 +++++++++
 include/net/page_pool/types.h           |  6 ++---
 net/core/skbuff.c                       |  3 +++
 6 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 27ec1e38c8283..c022e5fd3124f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -358,6 +358,10 @@ struct sk_buff;
  */
 #define GSO_BY_FRAGS	0xFFFF
=20
+/* All fragments in an skb (skb_shinfo(skb)->frags[]) must be backed by
+ * netmems of the same memory type. Mixing fragments of different memory t=
ypes
+ * within a single skb (including via skb coalescing) is not allowed.
+ */
 typedef struct skb_frag {
 	netmem_ref netmem;
 	unsigned int len;
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 0cc8572f62caf..c4beb6fbc1306 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -70,16 +70,18 @@ enum net_iov_type {
 	NET_IOV_IOURING,
 };
=20
-/* A memory descriptor representing abstract networking I/O vectors,
- * generally for non-pages memory that doesn't have its corresponding
- * struct page and needs to be explicitly allocated through slab.
+/* A memory descriptor representing abstract networking I/O vectors.
  *
  * net_iovs are allocated and used by networking code, and the size of
  * the chunk is PAGE_SIZE.
  *
- * This memory can be any form of non-struct paged memory.  Examples
- * include imported dmabuf memory and imported io_uring memory.  See
- * net_iov_type for all the supported types.
+ * Examples include imported dmabuf memory and imported io_uring memory. S=
ee
+ * net_iov_type for all the supported types. While current net_iov types a=
re
+ * unreadable by the CPU, net_iov has no inherent restrictions and may be
+ * CPU-readable or unreadable. New code must not assume net_iov implies
+ * unreadable memory (check readability via netmem_address() or
+ * skb_frags_readable() instead) and should, as much as possible, generali=
ze
+ * existing limitations to match the design principles.
  *
  * @pp_magic:	pp field, similar to the one in struct page/struct
  *		netmem_desc.
@@ -131,8 +133,17 @@ static inline void net_iov_init(struct net_iov *niov,
  * network memory.
  *
  * A netmem_ref can be a struct page* or a struct net_iov* underneath.
+ * Memory providers (or the default page_pool allocator) allocate struct
+ * net_iov or struct page, cast them to netmem_ref, and hand them to
+ * page_pool.
  *
- * Use the supplied helpers to obtain the underlying memory pointer and fi=
elds.
+ * The page_pool, drivers, and core networking stack should operate on
+ * netmem_ref rather than struct page or struct net_iov. Downcasting
+ * netmem_ref via netmem_to_page() or netmem_to_net_iov() in callers is
+ * not allowed unless a code path strictly requires a specific backing
+ * type (e.g., kmap_local_page()). In such cases, add a netmem helper here
+ * that handles both page and net_iov cases and returns an error if the
+ * underlying type cannot support the operation.
  */
 typedef unsigned long __bitwise netmem_ref;
=20
@@ -297,9 +308,8 @@ static inline atomic_long_t *netmem_get_pp_ref_count_re=
f(netmem_ref netmem)
=20
 static inline bool netmem_is_pref_nid(netmem_ref netmem, int pref_nid)
 {
-	/* NUMA node preference only makes sense if we're allocating
-	 * system memory. Memory providers (which give us net_iovs)
-	 * choose for us.
+	/* NUMA node preference only applies to struct page; net_iovs are
+	 * managed by their memory provider.
 	 */
 	if (netmem_is_net_iov(netmem))
 		return true;
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helper=
s.h
index cd021832c3fa3..28635ce9454e8 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -8,12 +8,20 @@
 /**
  * DOC: page_pool allocator
  *
- * The page_pool allocator is optimized for recycling page or page fragmen=
t used
- * by skb packet and xdp frame.
+ * The page_pool allocator is optimized for recycling network memory
+ * (netmem_ref) or fragments used by skb packets and xdp frames.
  *
- * Basic use involves replacing any alloc_pages() calls with page_pool_all=
oc(),
- * which allocate memory with or without page splitting depending on the
- * requested memory size.
+ * page_pool natively operates on netmem_ref, which abstracts the underlyi=
ng
+ * memory type (struct page or struct net_iov) supplied by the page alloca=
tor
+ * or a memory provider. Drivers and core networking code should use the
+ * netmem-based APIs (e.g. page_pool_alloc_netmem(), page_pool_put_netmem(=
)).
+ * The struct page-based APIs (e.g. page_pool_alloc(), page_pool_alloc_pag=
es(),
+ * page_pool_put_page()) are legacy compatibility wrappers for drivers not=
 yet
+ * converted to netmem.
+ *
+ * Basic use involves replacing any alloc_pages() calls with
+ * page_pool_alloc_netmem() (or legacy page_pool_alloc()), which allocate =
memory
+ * with or without splitting depending on the requested memory size.
  *
  * If the driver knows that it always requires full pages or its allocatio=
ns are
  * always smaller than half a page, it can use one of the more specific AP=
I
diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_poo=
l/memory_provider.h
index 255ce4cfd9755..137cfc50833ac 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -9,6 +9,16 @@ struct netdev_rx_queue;
 struct netlink_ext_ack;
 struct sk_buff;
=20
+/* Memory providers allocate underlying memory (struct net_iov or struct p=
age),
+ * cast it to netmem_ref, and supply it to page_pool. While current memory
+ * providers only return struct net_iov, they are not architecturally limi=
ted to
+ * net_iov; a provider returning page-backed netmems is allowed. New code =
must
+ * not assume a memory provider implies net_iov and should, as much as pos=
sible,
+ * generalize existing limitations to match the design principles.
+ *
+ * Per-provider custom logic must be delegated to memory_provider_ops rath=
er
+ * than handled directly in page_pool core code.
+ */
 struct memory_provider_ops {
 	netmem_ref (*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
 	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 03da138722f58..6d543076a0c0b 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -22,9 +22,9 @@
 					*/
 #define PP_FLAG_SYSTEM_POOL	BIT(2) /* Global system page_pool */
=20
-/* Allow unreadable (net_iov backed) netmem in this page_pool. Drivers set=
ting
- * this must be able to support unreadable netmem, where netmem_address() =
would
- * return NULL. This flag should not be set for header page_pools.
+/* Allow unreadable netmem in this page_pool. Drivers setting this must be=
 able
+ * to support unreadable netmem, where netmem_address() returns NULL. This=
 flag
+ * should not be set for header page_pools.
  *
  * If the driver sets PP_FLAG_ALLOW_UNREADABLE_NETMEM, it should also set
  * page_pool_params.slow.queue_idx.
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 43ebe61c7fc48..2c42a218dcc00 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6206,6 +6206,9 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_b=
uff *from,
 	if (to->pp_recycle !=3D from->pp_recycle)
 		return false;
=20
+	/* All frags in an skb must have the same backing netmem memory type;
+	 * do not coalesce skbs with different frag memory types.
+	 */
 	if (skb_frags_readable(from) !=3D skb_frags_readable(to))
 		return false;
=20
--=20
2.56.0.385.gd3acb90ef8-goog

