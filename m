Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C70382387
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 03:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791603395; cv=none; b=J72rtvkyNaNMpqbl2rddnqzSQ1D1rtYndKUh7+sWHkPMwJ3Oj71YTlqmVS9GRyyFtg0l0Fehp5FqbxwoebRl0YiKti7LbCCypjeWN/12WWEOGlnSv0RV1Jz6LCskSUJ3hya199jQ/ZARk2HsPEvnTSfgsse3X0HQT1XxcsnSUjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791603395; c=relaxed/simple;
	bh=IOF7eaG/olLYObLtJxwO6rrwHjLL8fVMYqs6nFWBb34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vDE8cOECrPGd1I/2ZQa2FTSADf7L9fUzyXsJsiZxCBW9Ax9cl9ZHlQOrZcCtv1dPqq0YURZf9i9dcl5hXGn3nd+/XVPpcvAadFwqJgBMfSIuUBUyolPIJxHiRJ61BaUIqmdjA8zJbmkOcOjGXFd7/Bt2xv1t9m5mZ8iWgofRbAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSu3dvYV; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSu3dvYV"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-351788121cfso1676377eec.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 20:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791603393; x=1792208193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=woacYuG0xz8CaoIm3rAgvR40HPJJlH/YZ3rvE69Oh/c=;
        b=aSu3dvYVOqMgN8cLoF7Uk1Kwm35wHMucdqCWEG1/3NzIVjJ7FZrKAte0afsx8QpxaR
         UwdyBA2M7E2hO+RVu5EQmHrduIwVGFUCx63Y1yxzCVi/IsjV3fnO+cMRSoucadIT9ENS
         mCQODdg/S1X36XY+V9TzZ27en96E9SSD37/bEu3kv7ePORhlbbA/HFMhnBPD6xIpR/A8
         tFumtfCRGHKpPhtprMTPmhzxGAQevzJqLVhjYaGdGcosniCR55+eWeSP2tXQWWb2mFuQ
         APscjklVUOQueM1HTvCyPsryyeR3iDnEqQAlt04jsn+urWKUQhq4UTURIOdhDH2mIyW2
         qk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791603393; x=1792208193;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=woacYuG0xz8CaoIm3rAgvR40HPJJlH/YZ3rvE69Oh/c=;
        b=dbrmH9RLCpASwyF7Qc1Tznuc8X19HpCb3ZY3eBWwqrNv/jiQsHS9GLi6h7/Q6uuDjf
         lhlOTXCx3/1RdwwLAKM0TwR+7vkYr5luiFOh1HcRa2hy4/oJjN5AXmYHdH7cmluSbiCF
         HCDX4n5p0sbemt/tx6qrvzq3Uzi8at8sqVAsJK53b8ZEF9NrXJ6ev7YEIwuwehi6G0UA
         tjXXX/0A1CBCeeXoHPWDO/h2VBrTTA2ySl7UPfDpji3SolYBmf0NhbKXOiz/QfrBKAun
         eS6uzvDtZn2yLIK+YGMGFjSxHhJE9gaO3m5QbypGd20OLCOp7mGgcgEQJnpBl9izP/ef
         jsgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzP4wp08irLwcsFj6DJQ0FnH+gT3Qt3u+CN8v3aeqaGo5tk07PMm6oAVMdnaxCN2sL50Mk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6VKTx2YnDMr4GGYhwu5kN3f1A3hNsO2u4NGzjOCExK2AM5OfA
	KfGatXJM8p0IsnmIOfpnHN5uAXP/4V/bhaCOPTi1KnT05RyDWuCKSz/ER8x6qFPzAeTpFRuwGwU
	qLDGWoa3UPAfPJKBusJgzekamOw==
X-Received: from dyz18.prod.google.com ([2002:a05:693c:4092:b0:34d:46b2:7513])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:7fa3:b0:352:2e10:10c3 with SMTP id 5a478bee46e88-3537e0858edmr7462976eec.36.1791603392171;
 Fri, 09 Oct 2026 20:36:32 -0700 (PDT)
Date: Sat, 10 Oct 2026 03:36:08 +0000
In-Reply-To: <20261010033630.1171692-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261010033630.1171692-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261010033630.1171692-2-almasrymina@google.com>
Subject: [PATCH net-next v3 1/2] net: netmem: document netmem and memory
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
- All frags in an skb must either all be struct page-backed or all
  belong to the same memory provider instance; mixing them (including
  via coalescing) is not allowed.

Cc: Luigi Rizzo <lrizzo@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
v3:
- Collect Bj=C3=B6rn's Reviewed-by and Stanislav's Acked-by tags.
- Clarify skb fragment comments: all frags must be struct page-backed or
  belong to the same memory provider instance (Pavel Begunkov).
- Link to v2: https://lore.kernel.org/netdev/20261008023030.1089616-1-almas=
rymina@google.com/
v2:
- Add Jesper's Acked-by tag.
- Note current implementation status (memory providers currently supply
  net_iov, and net_iov is currently unreadable) alongside target design
  principles and expectation for new code to generalize existing
  limitations (Stanislav Fomichev).
- Link to v1: https://lore.kernel.org/netdev/20261005004958.3603059-1-almas=
rymina@google.com/
---
 include/linux/skbuff.h                  |  6 +++++
 include/net/netmem.h                    | 30 ++++++++++++++++---------
 include/net/page_pool/helpers.h         | 18 ++++++++++-----
 include/net/page_pool/memory_provider.h | 10 +++++++++
 include/net/page_pool/types.h           |  6 ++---
 net/core/skbuff.c                       |  4 ++++
 6 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 27ec1e38c8283..af1cbc2799b77 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -358,6 +358,12 @@ struct sk_buff;
  */
 #define GSO_BY_FRAGS	0xFFFF
=20
+/* All frags in an skb must either all be struct page-backed or all belong=
 to
+ * the same memory provider instance (e.g. the same devmem binding or io_u=
ring
+ * area). Mixing page and memory-provider frags, or mixing frags from diff=
erent
+ * memory providers within a single skb (including via coalescing), is not
+ * allowed.
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
index d56f4f0102f75..69d3d27e29d97 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6210,6 +6210,10 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_=
buff *from,
 	if (to->pp_recycle !=3D from->pp_recycle)
 		return false;
=20
+	/* All frags in an skb must either all be struct page-backed or all
+	 * belong to the same memory provider instance; do not coalesce skbs
+	 * that would mix them.
+	 */
 	if (skb_frags_readable(from) !=3D skb_frags_readable(to))
 		return false;
=20
--=20
2.56.0.385.gd3acb90ef8-goog

