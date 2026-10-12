Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD3B4582D5
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793314; cv=none; b=IbJrI6QztmJuHCvAyGxCjFe3h14XytBcPWyIJs6559XDenBIqBE++eDQtdR+TZhIYOIUYueGfPQHud8TvQJi4a6KoVvwctAcyTMLc9Dzz5LejuD0pcOnOGHVBQrODOuKo+EF/CjI6gwTse9dmJlcRJDGa9DgJESMEd7ekQsCcXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793314; c=relaxed/simple;
	bh=bc79cWL/iIehkTgnl6Tjyj58erMfGdnnWANb1fgE4FA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i700KqEUoYtHqckS9evMRCaM300dinnlDnRcL4qEj5wcmMuRgMZ8S7WUuxiOJKKi4xgaX71bWtM1IYyrDap8ELToFTqbRyqHcJ4KJvtDBibnok3p++e6xT8xgKHsA3Lv6O2sywO65hmZdFp5BCDmosFU2B0sNKHeyQQeLBUPr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ejj3KKf8; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ejj3KKf8"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-351788121cfso3803632eec.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 01:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791793312; x=1792398112; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n6PaoBpF/oU1lyDxuw5ArpSGaAVMPVuclWNjmn/THuY=;
        b=ejj3KKf8rGCET6mK8htLKEWHu4rvS5Inm1Bfr2ehrVixfGvAEd/0CHF/KlLHNDGPOu
         cAOtaSO/dJtvYEEIFUb/7k/7rrtC/lSbinMlBK9gsDu90oV3IrxT1jDB1JG/GhSrMxh+
         V7rkS7otlKGVwCnFoG5X4TJbq/b4WhAqpfmqlvIT5RTYcWvXJCAaHGMBSV3ozIhDgJbB
         9seF9+Pz72xNEVQbZgYwC0KVUu9m1C1zsvrta/+8k+fEDlJyKUdw7v3mwY0FdCXrec9e
         swsuO8YOzUQvWXEQ4gbnMt/dRRqF05kfFUdf5VIq+5tyn8eBI/aznSLJH7cEaF2rE7GB
         QY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791793312; x=1792398112;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6PaoBpF/oU1lyDxuw5ArpSGaAVMPVuclWNjmn/THuY=;
        b=tFLnKwGxqYZatQWxTsFdwtdTArjfOP3in6sBHM8Mn1I5I9jCPQ597J4aGPsGNep86C
         3w6xU14348EB+AM7f9uTWT82L/+Z9GMC6eTdXYeVDepbcFii714kQaVtwx5mAYqevTuM
         eMgemZX2UrJI6/FgemSNDS0RXTpmi/NrGt2eyqoaM/8D2AXIlSxdayx+klHxS/rLbZMx
         4l3asQ1koYhqSuiA/oF2q6ckeye648nCeozLpfR3+LmcXN+iLNKDxmiMNop2iutB8rgV
         nhF51pNV0dD90IUt+m7JTZnkrRjpWIRJP4ECchIloYkzU3V5u+jfSsWs9QNZG2Y5Mw20
         sD/w==
X-Forwarded-Encrypted: i=1; AKwUvBx6gK+cyiYJRkydKTrtKt7a92fA8R0ZSBM+9oKWvGwHU/7/pLPqA0cRCrWPkHlN6q524Ic=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRsQU+rpoev9Wk/4ojniNrUZDaNEW4YTrvIm4cHcISgOhlVxrO
	T0sQz67W9SHKzIKAFaoXIIfRczg1gdlqa7899jL1X14S0lUEpMHNuPUSqRjqxinzTzgPKPH3QJc
	Qlk3Fnd6byG+bN8FoglKtDwgIEQ==
X-Received: from dybcl20.prod.google.com ([2002:a05:7300:a994:b0:34e:b472:7322])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1929:b0:351:7ec0:daa3 with SMTP id 5a478bee46e88-3537e04eeb2mr12843933eec.31.1791793311570;
 Mon, 12 Oct 2026 01:21:51 -0700 (PDT)
Date: Mon, 12 Oct 2026 08:21:44 +0000
In-Reply-To: <20261012082148.1698596-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261012082148.1698596-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012082148.1698596-3-almasrymina@google.com>
Subject: [PATCH net-next v2 2/6] net: skbuff: add napi_pp_get_page() and use
 it in tcp_recvmsg_dmabuf()
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=" <u.kleine-koenig@baylibre.com>, Jijie Shao <shaojijie@huawei.com>, 
	Michael Grzeschik <mgr@kernel.org>, Jakub Raczynski <j.raczynski@samsung.com>
Content-Type: text/plain; charset="UTF-8"

While napi_pp_put_page() releases a page_pool pp_ref_count reference on
a netmem, no symmetric helper existed to acquire one, forcing callers
like tcp_recvmsg_dmabuf() to open-code atomic_long_inc() on
niov->desc.pp_ref_count.

Add napi_pp_get_page() to pair symmetrically with napi_pp_put_page(),
and use WARN_ON_ONCE(!napi_pp_get_page(netmem)) in tcp_recvmsg_dmabuf()
to match WARN_ON_ONCE(!napi_pp_put_page(netmem)) in
tcp_release_user_frags().

Assisted-by: LLM
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/skbuff_ref.h |  2 ++
 net/core/skbuff.c          | 31 +++++++++++++++++++++++++++++++
 net/ipv4/tcp.c             |  6 ++++--
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
index 05c8486bafac8..0441c220fdbdf 100644
--- a/include/linux/skbuff_ref.h
+++ b/include/linux/skbuff_ref.h
@@ -9,6 +9,8 @@
 
 #include <linux/skbuff.h>
 
+bool napi_pp_get_page(netmem_ref netmem);
+
 /**
  * __skb_frag_ref - take an addition reference on a paged fragment.
  * @frag: the paged fragment
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b459264ba5180..8a8be746828db 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1026,6 +1026,15 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 EXPORT_SYMBOL(skb_cow_data_for_xdp);
 
 #if IS_ENABLED(CONFIG_PAGE_POOL)
+/**
+ * napi_pp_put_page - release a page_pool reference on a netmem
+ * @netmem: netmem to unreference
+ *
+ * Drops a page_pool reference (pp_ref_count) on @netmem if it belongs to a
+ * page_pool. Counterpart to napi_pp_get_page().
+ *
+ * Return: true if @netmem belongs to a page_pool, false otherwise.
+ */
 bool napi_pp_put_page(netmem_ref netmem)
 {
 	netmem = netmem_compound_head(netmem);
@@ -1038,6 +1047,28 @@ bool napi_pp_put_page(netmem_ref netmem)
 	return true;
 }
 EXPORT_SYMBOL(napi_pp_put_page);
+
+/**
+ * napi_pp_get_page - acquire a page_pool reference on a netmem
+ * @netmem: netmem to reference
+ *
+ * Acquires a page_pool reference (pp_ref_count) on @netmem if it belongs to a
+ * page_pool. Counterpart to napi_pp_put_page().
+ *
+ * Return: true if @netmem belongs to a page_pool, false otherwise.
+ */
+bool napi_pp_get_page(netmem_ref netmem)
+{
+	netmem = netmem_compound_head(netmem);
+
+	if (unlikely(!netmem_is_pp(netmem)))
+		return false;
+
+	page_pool_ref_netmem(netmem);
+
+	return true;
+}
+EXPORT_SYMBOL(napi_pp_get_page);
 #endif
 
 static bool skb_pp_recycle(struct sk_buff *skb, void *data)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f4c9101e5996a..99d7237a623d8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -254,6 +254,7 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/skbuff.h>
+#include <linux/skbuff_ref.h>
 #include <linux/splice.h>
 #include <linux/net.h>
 #include <linux/socket.h>
@@ -2559,6 +2560,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 		 */
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+			netmem_ref netmem = skb_frag_netmem(frag);
 			struct net_iov *niov;
 			u64 frag_offset;
 			int end;
@@ -2612,8 +2614,8 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				if (err)
 					goto out;
 
-				atomic_long_inc(&niov->desc.pp_ref_count);
-				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
+				WARN_ON_ONCE(!napi_pp_get_page(netmem));
+				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = netmem;
 
 				sent += copy;
 
-- 
2.56.0.385.gd3acb90ef8-goog

