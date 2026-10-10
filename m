Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA62D3451CE
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621581; cv=none; b=iQPqs8r/qs58ykN0P5boc934352Z+A++keO8wne3TT2+F09ug2CldfFkmGx8Ig7/mKR4GCCFPSzWKwkeCHSFWWkXTXMdLhVpBiJLgrCUuOOnAYrsAT9MvJtOJufGOOOUhUjwOLhBZWXtcvvzVEen2mZfzJNRDfvW8oeCDSpap2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621581; c=relaxed/simple;
	bh=/LLvU+5AnYzTjy57lN2tpyIzvmdHROTfxW0jkjFEfuA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kBfDJIDW7fTaYe+ncl8kKgK88ZOSgBoCncp9MvXXuKIa1g2HDUTglA4Dh1hL/Dt95BJVxE1n57DTzgm2NZe3leELw6D2BEhq1tGkXkycOzFuVc4GDkEu/NqF/NRi3g6T9qt8Z9NifxivLPbcWnUO5dpJnBpp9q2WWj39Ij+VuKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WkpQltvA; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WkpQltvA"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35158d674e1so2141583eec.1
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 01:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791621578; x=1792226378; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oMs6zujZVOhihfnpjH1h+iJn7PnD9P9Ohm7NiW91TsM=;
        b=WkpQltvAgvFBjLXXQ3NHIPW4Zu+RAvQLs+DwHiJKJ8x8GcBLq1RM6smhbmDSm3vYvM
         MW3pIj2Wa17I1BYTkgkSOPXLrkxIC40pcu4WCe1fQMNa72VWjUgtzs6lkt5Gg/DK/63x
         pyThSbGXj+KxGnb9Ai1LtUK8lZXtcrT6KLCUb7pQxGuUWdUh09nNXhtLVXq0UAdxo4ze
         stLUcKzueAjLOOq7LeV1O4D1SFj48bWlmX/nx9O5caRYVtH3upzM5doICrxfYq+T6g9A
         SmKl06t3myjyImFDmso/sFA1v8H5ZXqCTu0u6lPhjOdh7I/A9a2bQI9ZIY29e9PGTq+z
         gBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791621578; x=1792226378;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oMs6zujZVOhihfnpjH1h+iJn7PnD9P9Ohm7NiW91TsM=;
        b=kNxiPFM2MCj4yvbBfGvLK8UvVFdBySBkszhoxo1K1tHKSC6b6MaxFhaHlT+Ym2z5xH
         zDgo1CxEeUstjclKT0asa3ysj+nXf54/UqSkxu9DyoRoFneno2UEY2xnOWY05ShLmFTB
         8xciGJt2N4hJWiAQ5F1Wbf+9c1fxviQO887t5kfCfg0VL3mzwgFHk4Hn4OYbKew9enzE
         UGT0OJEruGGruAyC/ZXqYBpmQLgzpJDTzlDWKP90fz7ejxvziKeC4oSp3RyXCfXe3VbJ
         /sKOnv3WXhPGqQVPb2ZhoeaCJSC1A2GtpWIEP9ucZdxAnSg0ZN1/U1+HHxk/DnBceqjM
         K7xw==
X-Forwarded-Encrypted: i=1; AKwUvBzps0NloZXkgm7ASVzpnOsIDm89AKmF9mGmr1kywo4bA2k81IA59wMpwqufOco9NWhWlgI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2l3vC5YkFUg/NwIskZww2rcirUBTrp7RQdVODRVbGfgA9EFV4
	uZtLgHfdYYo4/AzBLnEWZziBCrVqAJ2Mjmlnt6ZE8IX+dRho7M1i4U0Z0zbX0XIEIcb1cwxtQ+x
	exWfmG/Rh4l4tTO8voyBYM6D5vQ==
X-Received: from dycc9.prod.google.com ([2002:a05:693c:60c9:b0:351:4a84:2505])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1a05:b0:358:eccb:af7c with SMTP id 5a478bee46e88-358eccbc89dmr38890eec.33.1791621577801;
 Sat, 10 Oct 2026 01:39:37 -0700 (PDT)
Date: Sat, 10 Oct 2026 08:38:43 +0000
In-Reply-To: <20261010083935.3274178-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261010083935.3274178-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261010083935.3274178-3-almasrymina@google.com>
Subject: [PATCH net-next v1 2/6] net: skbuff: add napi_pp_get_page() and use
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
	Michael Grzeschik <mgr@kernel.org>, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=" <u.kleine-koenig@baylibre.com>, Petr Machata <petrm@nvidia.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Jakub Raczynski <j.raczynski@samsung.com>
Content-Type: text/plain; charset="UTF-8"

While napi_pp_put_page() releases a page_pool pp_ref_count reference on
a netmem, no symmetric helper existed to acquire one, forcing callers
like tcp_recvmsg_dmabuf() to open-code atomic_long_inc() on
niov->desc.pp_ref_count.

Add napi_pp_get_page() to pair symmetrically with napi_pp_put_page(),
and use WARN_ON_ONCE(!napi_pp_get_page(netmem)) in tcp_recvmsg_dmabuf()
to match WARN_ON_ONCE(!napi_pp_put_page(netmem)) in
tcp_release_user_frags().

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

