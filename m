Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2A840F8D1
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107342; cv=none; b=HPkVvT2YFE3VIeX52lMpUEXedTLJ7VOEhtSlohDBonhkfGZrAj3a6GiMKy99fmzw+nGcNGNRkMdeWHknChbELdubGBNGKzJUjsGWVinLIormzpn3LXE2AVeUO4BtNvHkz9LOaXm2Tkwv9J1QFGMX7gs4M3aHqrs2UdxksMOD6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107342; c=relaxed/simple;
	bh=ov6+gI2FLpcVjn6o4KEEVsXvNT4PPkAZoGWX5AxLtwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7XV10+VdDmcH/RCFcGea5BE73lp/NJrAlXZMYAsbR9BA10c+4HY0Y7GhpS2TXCeARV4q892jB4YlNjpIopJIi5bMN7Ukep66u4UX+qPU1d+0KaTl5ZVteyIgSCzotY0TKFBiJ5viTA1UpPXjY8N/Y5F6gB5ggBku8PY/dlz5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5oCQSnQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5oCQSnQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48909558b3aso23958845e9.0
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107339; x=1779712139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuw5xtr2C0czpVUWTefIMp0AVKJYHgH7hJ3FkPC09qM=;
        b=l5oCQSnQQU5CAP7YG/rjcAmg1toy3Dlc7pgUlkmA+IANzbFM2/ZLich0GAPJVMFXFU
         F92mM67vT6MnLxDlJYmTe9gDxVXeM32LnPh+xOFSXQUz7EFINSUZsRCROKW4euFSFpkB
         a9D6Emnnjvy51CAdQ6cR5r08hE6A0wko6hvEOQQVKJKf1n1ZiotIegsS9D26JFNURBq6
         0wR0gwC1/XVyj9lS24emdEi+Bt8wOzEOh59r712qjFne+7XVoVsE7asG82gaoYn5mrgP
         TQrJaxYmUG9wymPvIsfLwQfFxZKS38CYrYFkL5luWLAp+XvROe4Ttzx/V7Vwd/Ue/t33
         vu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107339; x=1779712139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yuw5xtr2C0czpVUWTefIMp0AVKJYHgH7hJ3FkPC09qM=;
        b=j6yEDIt82ZHj1Q+E7U8Vo2MYWCdEjMQxDj5ROBuCBgOSAyv9wt+rK/4PuytEwzPG+J
         rsO50cvHPT2E9gu3oVcZgR0H5VMnTIbWtqsDL6ypk+6yId7YuCC6Xbwb6wZKwf3YDW2i
         NZ6oRhzu8jmLTY8HQrA2qv9ND1Ke/6YYExq/OzyPM3F6pU2GKy/wby5van10JUEYiGrX
         wseElB4X9YZHP8kt1EVWtLOcJmKh+SATqZE5Fx9xATLUeBe1KtHJBTm/c6NjUFi1K9IX
         uwDriKb+OuPB+6Zf5QkSiNvIf20C3rSKVH/2SxXowL3qVFuskZdohQ9+0v4AGgjoYGJM
         9I2g==
X-Gm-Message-State: AOJu0Yx7PklCtOfvpetUH9CuhG/CqR6p2YI3Y8MZJjWOsJPxTOTgSw5t
	L6zAdAeKpFv9vE7lXC/fKypdxG1k1xpo0b+d2SWmKghTzdnIY573I9IUq0OSpOAu
X-Gm-Gg: Acq92OGeQZnbyoFrDbpJ7gJ52unt26/lcHire9tgcG+ve/7vatZWWteYlS/aud+Dus+
	Z52B6I/Q8D+X12ZH5Ifp1LKJ5gLdpTI5lfbFRoKMBjHcYNURuw/HNLil/8zPfjYUv8tUeUKV1Fg
	pS2++8edXT22NMe1qWcTcNMf3F6p8OIYIedURLpd9y0oYNczcSpHs9CkGRHfuunDKwk9KJMnbCU
	EqLPwdRFiv9o8k2i87Q7zDWETFJ+4+Ko5lqNsVDOVgwhEtPboEn+y5K7WEd00gkRGAadEBJgM1M
	YzrKvK4RPmiWYV6ILIaev59Qa6qcpCf/jpKpe46v9KqJaSJUpA8dAbiIDWd4BaDPyMlw6N+Cnxc
	U2VCyUNHFEk5EwMzLWLXTDyfS5pAR5E3KBHXuyRGwR4Wm4mmDWPcvns7Y1L6iyy1wgg1bPF9sUW
	G5FmmO+yHcFVxuMd0Bh+R1yUorZhbQL9OX+llv8w==
X-Received: by 2002:a05:600c:6383:b0:488:c014:34da with SMTP id 5b1f17b1804b1-48fe651690fmr232880725e9.26.1779107338783;
        Mon, 18 May 2026 05:28:58 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48ff2cb4ae0sm104304315e9.0.2026.05.18.05.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:28:58 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jordan@jrife.io,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v6 2/6] net: move netfilter nf_reject6_fill_skb_dst to core ipv6
Date: Mon, 18 May 2026 12:28:38 +0000
Message-Id: <20260518122842.218522-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518122842.218522-1-mahe.tardy@gmail.com>
References: <20260518122842.218522-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move and rename nf_reject6_fill_skb_dst from
ipv6/netfilter/nf_reject_ipv6 to ip6_route_reply_fill_dst in
ipv6/route.c so that it can be reused in the following patches by BPF
kfuncs.

Netfilter uses nf_ip6_route that is almost a transparent wrapper around
ip6_route_output so this patch inlines it.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 include/net/ip6_route.h             |  2 ++
 net/ipv6/netfilter/nf_reject_ipv6.c | 17 +----------------
 net/ipv6/route.c                    | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 09ffe0f13ce7..eb5a60d3babe 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -100,6 +100,8 @@ static inline struct dst_entry *ip6_route_output(struct net *net,
 	return ip6_route_output_flags(net, sk, fl6, 0);
 }

+int ip6_route_reply_fill_dst(struct sk_buff *skb);
+
 /* Only conditionally release dst if flags indicates
  * !RT6_LOOKUP_F_DST_NOREF or dst is in uncached_list.
  */
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index ef5b7e85cffa..7d2f577e72b8 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -293,21 +293,6 @@ nf_reject_ip6_tcphdr_put(struct sk_buff *nskb,
 						   sizeof(struct tcphdr), 0));
 }

-static int nf_reject6_fill_skb_dst(struct sk_buff *skb_in)
-{
-	struct dst_entry *dst = NULL;
-	struct flowi fl;
-
-	memset(&fl, 0, sizeof(struct flowi));
-	fl.u.ip6.daddr = ipv6_hdr(skb_in)->saddr;
-	nf_ip6_route(dev_net(skb_in->dev), &dst, &fl, false);
-	if (!dst)
-		return -1;
-
-	skb_dst_set(skb_in, dst);
-	return 0;
-}
-
 void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		    int hook)
 {
@@ -440,7 +425,7 @@ void nf_send_unreach6(struct net *net, struct sk_buff *skb_in,
 	if (hooknum == NF_INET_LOCAL_OUT && skb_in->dev == NULL)
 		skb_in->dev = net->loopback_dev;

-	if (!skb_dst(skb_in) && nf_reject6_fill_skb_dst(skb_in) < 0)
+	if (!skb_dst(skb_in) && ip6_route_reply_fill_dst(skb_in) < 0)
 		return;

 	icmpv6_send(skb_in, ICMPV6_DEST_UNREACH, code, 0);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index e3d355d1fbd6..37a7627a94de 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2725,6 +2725,24 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
 }
 EXPORT_SYMBOL_GPL(ip6_route_output_flags);

+int ip6_route_reply_fill_dst(struct sk_buff *skb)
+{
+	struct dst_entry *result;
+	struct flowi6 fl = {
+		.daddr = ipv6_hdr(skb)->saddr
+	};
+	int err;
+
+	result = ip6_route_output(dev_net(skb->dev), NULL, &fl);
+	err = result->error;
+	if (err)
+		dst_release(result);
+	else
+		skb_dst_set(skb, result);
+	return err;
+}
+EXPORT_SYMBOL_GPL(ip6_route_reply_fill_dst);
+
 struct dst_entry *ip6_blackhole_route(struct net *net, struct dst_entry *dst_orig)
 {
 	struct rt6_info *rt, *ort = dst_rt6_info(dst_orig);
--
2.34.1

