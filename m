Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82885242D6B
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791161403; cv=none; b=c7QA+V5SQ2xJjaFGt5WUu2b/e5lKxCa3csIXAj6VrNt6WpNB7+2o7SFbvBDZXd47BWNjoX/08LYPFPSIgJ9gQsyslZYxDK4Vt+Ud0Z0AEwUQcoe6bu66MwXpvmPRqDbhrGxUQZamfzDMNNql5Vyo7kkoOasSGRcsIWc2a/CFL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791161403; c=relaxed/simple;
	bh=4uh+DGeQwR7qro/7NjEQpWrakCO18kYghMkKtMkiP2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s0piFc7KX36jn1YzcGqgDyPvs6ug9BftlRVAEszBnCCr8/p0O8ZpDAi6IOFHoNf0yl79Q87jFAGU6wSoSB0GyUIo84v4g7lsJlEML54FUHLmb4Xl9zpRAcCDbMI3S3f+O15wSYnTcrt8fzxcEMZaoHhUedBaiZbflTqwxxYss/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DabJN9Ah; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DabJN9Ah"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1384427c3efso1523012c88.0
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 17:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791161401; x=1791766201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1/h++TSxOIG+JLH36J2O7/RkluW576W+vWgfrUHLIWQ=;
        b=DabJN9AhLIIqbKqI0CqcuHad0n95clIjJEeK6fvaf9kcyOsuArRPenmPsrtIkmX4Y+
         AexZfAvD2G3kq42QuTFBpjBcCF4YmrOFLBnlfGBATAPTtWg5+JJjKUp6O3pml4V3kaUL
         G9TB29QQCSAoxk0/m7Hwt+vEJy9C/CN672scNDrV9Pd9s1aYkhkFBB69WExeRYcC6fPD
         g7AHBr5MWCh1T4cdio+aDxy5TIR9JQaPvXo0u71zXYddxKi0Q/2TfFGq/a1Ju/YwHYw6
         HMmsb2GovVWotcl/g7f9aFAqGBcu2gwfCo5nmzvI4NXIlB/bsYT3VzpTG0Oen9KVdPfn
         MS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791161401; x=1791766201;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/h++TSxOIG+JLH36J2O7/RkluW576W+vWgfrUHLIWQ=;
        b=vantrQ1SPJmeJkfNAWznGoN/LN5BGX924ptVoiMmV6kdWH9qIydMGRBj1b25UfGSeM
         3f0cNZESFHQIFEhPCfY5hoN8oU/N6VUStg22NZ9jcxn7a1iUdGA4RkO5ZOc9XUs8SCRX
         jCpiB94vv/89yM5saC2jNMhnlzD7ud5w3gM98Rzg+tHji/uMDoqrCdMJTmWtYc1imeBB
         DvDHbCASYCfYTkKpSwUSRZpOhUgbqM0qZSdcWNqpS9u4N1YqNzzNrf5tq0XmIZyuWNrA
         jSwVkoc93oex6Z4XQD6FLw1+pxgxpaqWDcbhOBlaGGCCGnvL11pyohMj95w7apvhBIXD
         OB5w==
X-Forwarded-Encrypted: i=1; AKwUvByNwbYpsdNqgsfhpOSjPAKyNUCwFz86d6r/cB5NBs+OW3gsX6xIqiAgGNKapsiYvmyjfA8=@vger.kernel.org
X-Gm-Message-State: AFuF++m6vw6xvpCcNykLcUvA6nhCuaT8HyBrUcDSQJtuS0+h+M0g0CPG
	+fcjA1byp+sZltaegILzsZJ6UrJeVVnpPRAHQL76btBpnwnWntZYWLl5RzKHAvPCHWaRFLf5Uz6
	A/tOvPDIXQRsFZ1Gv2qrWrMmnEg==
X-Received: from dlx25.prod.google.com ([2002:a05:7022:99:b0:157:c092:a7ad])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:4289:20b0:14b:2397:d8f1 with SMTP id a92af1059eb24-14f5bff48a1mr12083890c88.9.1791161399973;
 Sun, 04 Oct 2026 17:49:59 -0700 (PDT)
Date: Mon,  5 Oct 2026 00:49:05 +0000
In-Reply-To: <20261005004958.3603059-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005004958.3603059-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005004958.3603059-2-almasrymina@google.com>
Subject: [PATCH net-next v1 1/2] net: netmem: document netmem and memory
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
- Memory providers are not restricted to net_iov and may supply
  page-backed netmems.
- net_iov is not inherently unreadable; future readable net_iov types
  are allowed.
- Per-provider logic belongs in memory_provider_ops, and per-netmem-type
  logic belongs in netmem helpers.
- All frags in an skb must share the same backing netmem memory type,
  and skbs with different frag memory types must not be coalesced.

Cc: Luigi Rizzo <lrizzo@google.com>
Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/skbuff.h                  |  4 ++++
 include/net/netmem.h                    | 29 ++++++++++++++++---------
 include/net/page_pool/helpers.h         | 18 ++++++++++-----
 include/net/page_pool/memory_provider.h |  8 +++++++
 include/net/page_pool/types.h           |  6 ++---
 net/core/skbuff.c                       |  3 +++
 6 files changed, 50 insertions(+), 18 deletions(-)

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
index cc97611632dc8..8fcf455664781 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -70,16 +70,17 @@ enum net_iov_type {
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
+ * unreadable by the CPU, net_iov has no inherent restrictions and future
+ * net_iov implementations may be CPU-readable. Code must not assume net_i=
ov
+ * implies unreadable memory; check readability via netmem_address() or
+ * skb_frags_readable() instead.
  *
  * @pp_magic:	pp field, similar to the one in struct page/struct
  *		netmem_desc.
@@ -134,8 +135,17 @@ static inline void net_iov_init(struct net_iov *niov,
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
@@ -300,9 +310,8 @@ static inline atomic_long_t *netmem_get_pp_ref_count_re=
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
index 255ce4cfd9755..6eaca6725d904 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -9,6 +9,14 @@ struct netdev_rx_queue;
 struct netlink_ext_ack;
 struct sk_buff;
=20
+/* Memory providers allocate underlying memory (struct net_iov or struct p=
age),
+ * cast it to netmem_ref, and supply it to page_pool. Memory providers are=
 not
+ * limited to net_iov; a provider returning page-backed netmems is allowed=
, so
+ * callers must not assume a memory provider implies net_iov.
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
index 5c4024a03e105..9395e0ad0a13b 100644
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
2.56.0.rc1.315.gc6ed9934b7-goog

