Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F107D379C2B
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129932; cv=none; b=hCCn4A+WnVH4zHrN0H1d35ZY7briYyqvtiMl0VIcxvLwQxXICKtd+Vk5oacVe5f6BgajlARYnGw4C9YzHHK21wTSg1Cw9DCsASpKJ5UUbxPpjC82DFAQ5/aKDIp/hAewK72ifrzXBPk8+xfs/uDIlbzkE9LXEVpx70aB2qNU9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129932; c=relaxed/simple;
	bh=jq2Q7kF2niLdJHIw0DqhPfXbN3I9G2RrHLnNNIj0aVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YpR+5I9dI8uNZP9Ydp+YckFMiK8KChbauqTAPu/MyCLj6UTSs6/TC4nfbVkamVtlOMIno7iRlQarNHNnmstSKaxHL6M62Qot2DZaOzwKOQ48AEsF8UiumhBVFFmEecDtVfFFAvng58VHnbcy2vxcmgCVzWEQ/i9JEN+fEVvQn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLwhaMa1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLwhaMa1"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49258ac7294so2027865e9.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 05:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782129928; x=1782734728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmxexLRgCg6Lmd6HPPcx8J9aTH3v2szSsHJ7h8NrQDY=;
        b=VLwhaMa1OG1Gd7EZ1pGpyswFaThbgKepoqzUGiRA36PrOUgXlDp5zlgpWlzZUdCWq6
         8n3C16/sY9Nre3WKaTru4IBT7FpH8ZGFrHuODq/NhmieHoNg5ctYkevGGjXFD5kMS/3U
         Jv1M+ydmmJ9+DEB8LvdzyRWB/KDFDVRIWZ4L8i1HtpGHRSTDx0fikgLKgDYGe6jhuvy2
         leufWbwJZFlkl0KVkKr3QcVP4krNqMmWQEfp04NB47LD2sG3UGzNaNf281m0zo7GtmnO
         FBeEeOqkCOz0PxAq1DILfhR6wFFr95k7GNJV1Q36RP2lDC6O8Kx8r6RevSUL4c6ikvHs
         DSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782129928; x=1782734728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LmxexLRgCg6Lmd6HPPcx8J9aTH3v2szSsHJ7h8NrQDY=;
        b=aZe4lxsEjFJM9GhsPIHbYgca4nIwbz+klXI2Q24ZkAMHoD2leriu5kv+jpMUm22SNC
         D09hUClCdb5CmVqYSC2o/b8MJ1/sVXsxArFGNzPCwz6dk/CPeN9/I2DykiprabPvaCWz
         v+9Cd4inrJhdKLYHx7Qa0vt8QvhM5LJ5m5cazT7Zza11SgqNyxgUU+oAIrfVpGu+IgXt
         x7jijcZldEMEQ3hvnuAZkYi0gGob3Vym6pO7O6w+uIRGjVgTum7aK4ewbMNdZ1DezKc6
         8m8NPDGxIgEpocWqrzLOirs/+qUoyB/wsTf+s2XylYFEbwSS2xb+k7yrmnVEXEi0NUuX
         8KWw==
X-Gm-Message-State: AOJu0YyTiDqzLMmmXejJkR3gzZfi0MnQFPN8vRdUdGlPhOsXkt5ENkWr
	f+mcS7CFNKv3nJCjrSJWWqWbc2LcLJgOMUCuYM7e7zUXXBD+gwvz7q7W1hNlK23c
X-Gm-Gg: AfdE7cn5IJVgAwUrLcpeJlMvBdCO3QCmzq9/5zV+y9vqhdA147FPHa51NxxlRSWPfgn
	NaQmvD8Gp5t/oyE8HPYv7MuVOdpPlUoVt1CzmZ0orB0QUlvv4qZBLimXk/qasACTOlNW/+TK+e0
	/qMWpBuedW42n1l6Cpqmit3Hsd++qCi4MgUp3GnwRODR98VAqFGYSmj3mUGxINXHy/WFKj2mVCK
	in31y+cJ8awjSiCKYrSKMVpPEvdlkEKVAAfMXqBXjEDYWu24VOrqP3oEhJDYfSkGKvcoPp47e7N
	pLgJulRDxYxxatU8le1c8cWchgdrpwow6EcqDpX1suxeByq/aVskmrIHMzKyZJkhRh8NowBj7GE
	E4zqZdeCOxKH5AEYK6UFwYd4TvggP6td8nlvQws5QfPo61eUTT/Lwz4M/VDC03cg5NyPk/AsdO0
	XyKew8ShBwxXjRxOiiD5Bqb1QWX0I=
X-Received: by 2002:a05:600d:4448:20b0:490:da12:f1fa with SMTP id 5b1f17b1804b1-49240ea7f99mr191740295e9.31.1782129928229;
        Mon, 22 Jun 2026 05:05:28 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm491083105e9.0.2026.06.22.05.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:05:27 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	edumazet@google.com,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	kuba@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	pabeni@redhat.com,
	yonghong.song@linux.dev,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v8 1/7] net: move netfilter nf_reject_fill_skb_dst to core ipv4
Date: Mon, 22 Jun 2026 12:05:09 +0000
Message-Id: <20260622120515.137082-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622120515.137082-1-mahe.tardy@gmail.com>
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move and rename nf_reject_fill_skb_dst from
ipv4/netfilter/nf_reject_ipv4 to ip_route_reply_fill_dst in ipv4/route.c
so that it can be reused in the following patches by BPF kfuncs.

Netfilter uses nf_ip_route that is almost a transparent wrapper around
ip_route_output_key so this patch inlines it.

Reviewed-by: Jordan Rife <jordan@jrife.io>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 include/net/route.h                 |  1 +
 net/ipv4/netfilter/nf_reject_ipv4.c | 19 ++-----------------
 net/ipv4/route.c                    | 15 +++++++++++++++
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index f90106f383c5..300d292cd9a1 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -173,6 +173,7 @@ struct rtable *ip_route_output_flow(struct net *, struct flowi4 *flp,
 				    const struct sock *sk);
 struct dst_entry *ipv4_blackhole_route(struct net *net,
 				       struct dst_entry *dst_orig);
+int ip_route_reply_fill_dst(struct sk_buff *skb);

 static inline struct rtable *ip_route_output_key(struct net *net, struct flowi4 *flp)
 {
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index fecf6621f679..c1c0724e4d4d 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -252,21 +252,6 @@ static void nf_reject_ip_tcphdr_put(struct sk_buff *nskb, const struct sk_buff *
 	nskb->csum_offset = offsetof(struct tcphdr, check);
 }

-static int nf_reject_fill_skb_dst(struct sk_buff *skb_in)
-{
-	struct dst_entry *dst = NULL;
-	struct flowi fl;
-
-	memset(&fl, 0, sizeof(struct flowi));
-	fl.u.ip4.daddr = ip_hdr(skb_in)->saddr;
-	nf_ip_route(dev_net(skb_in->dev), &dst, &fl, false);
-	if (!dst)
-		return -1;
-
-	skb_dst_set(skb_in, dst);
-	return 0;
-}
-
 /* Send RST reply */
 void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		   int hook)
@@ -279,7 +264,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	if (!oth)
 		return;

-	if (!skb_dst(oldskb) && nf_reject_fill_skb_dst(oldskb) < 0)
+	if (!skb_dst(oldskb) && ip_route_reply_fill_dst(oldskb) < 0)
 		return;

 	if (skb_rtable(oldskb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
@@ -352,7 +337,7 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 	if (iph->frag_off & htons(IP_OFFSET))
 		return;

-	if (!skb_dst(skb_in) && nf_reject_fill_skb_dst(skb_in) < 0)
+	if (!skb_dst(skb_in) && ip_route_reply_fill_dst(skb_in) < 0)
 		return;

 	if (skb_csum_unnecessary(skb_in) ||
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3f3de5164d6e..f24609933fbe 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2942,6 +2942,21 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
 }
 EXPORT_SYMBOL_GPL(ip_route_output_flow);

+int ip_route_reply_fill_dst(struct sk_buff *skb)
+{
+	struct rtable *rt;
+	struct flowi4 fl4 = {
+		.daddr = ip_hdr(skb)->saddr
+	};
+
+	rt = ip_route_output_key(dev_net(skb->dev), &fl4);
+	if (IS_ERR(rt))
+		return PTR_ERR(rt);
+	skb_dst_set(skb, &rt->dst);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ip_route_reply_fill_dst);
+
 /* called with rcu_read_lock held */
 static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
 			struct rtable *rt, u32 table_id, dscp_t dscp,
--
2.34.1

