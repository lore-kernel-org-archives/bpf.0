Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E052B39B4BF
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682714; cv=none; b=FI9+kdk5ojtDbiCF7Ih2l6g76eaOjUWVoDZMnWLN0FCDMJYTPtTuB28UZZAD/RTkinufAbOdtUdovKd37KEus5KpM87ibWRic5GkWf7RuvL28f2kztsgmG25IFsDmi48YJRpZA272T4LDoTNk5OHelgl1pX3045Snf+UJntp4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682714; c=relaxed/simple;
	bh=eM+kBof0ulZSr5/cYF9WFtvW3e7WM/D2dX633xCjEDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d27xnxmlcm9WEgiFCOjk/pKvsTcUKzc7Ig1AT6HJK6N5t0tt2LmGlf6QrlFKiXqwrJdfc0sjTJTNjnxXNZvwP/lDI8y1h92uO1jYk0wur044CUgfy2O//vxWIYSjfB7wFH44ORtAhgpLj+vqlbM/bJ4UM15xd12LExjdIYsctnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8N8Uv9c; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8N8Uv9c"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so44704775e9.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776682711; x=1777287511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIn4y25U9iTbZ6u0/nqOP41USOI/jaT9h/eIclbE8HQ=;
        b=b8N8Uv9ckYN9oVUXD/7//phbUkLfbtPGrLcQAtf35oj318gCD2yyiDFVEuTYq40e6d
         bUb1p5Qqji2+StrZTqqu9UvUz+31sJ7BJxt6Z5o3H0LdJA+Rtk4ZwQ7ErGFc4aBkN11Y
         TCDm3lLqeeW2AAF7F1bxT2Ik5+8Hzr4n1RzW3U2sG8Dcpnn/3T+wKPp4QmO5WZgphRSP
         gC771MiQJ2x2oEB9Y+4s+/+gk8OF2cAlJEycw3keE3MAARsih3WgtzTc2/77c0EfzJp9
         CGoFCdXrNbPZ5ufaRGA+BGq1f6p0aD/dqp3BX83s7rdth1CV9rVUbExMg3J1Sld3NDHg
         N2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776682711; x=1777287511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pIn4y25U9iTbZ6u0/nqOP41USOI/jaT9h/eIclbE8HQ=;
        b=rURsz6vKj+JCVznUmLGPSKb0sQdemNVvexyLBPeJWDwLGgvo6sh1E2Q7+LYbfzqIa2
         UoBMkZYjI1PgGkGkyCxLP5WI+TWyMmANDJ+rn1Pf9D6sb4gSllYJJZgpJzl9oEbgQDS1
         I4AUIsFLpgZo2SWXLW3oNJGQqaWNVK9RdrT9Xz7XK2/q5cdmPO3eH4aVIc7gOcbGhVml
         7Wx5DBshoZaNh+o1AnDs7TUAy0Ql+OlIvfQZeZ5Pe0mhii+atwCBKBhBK6GWVk3/syoC
         aGuxKfVh4VN5aZKrji2t6HokqMJExvxSip5URTjMt2V7WWh10FRxkqQeWHlc6S8NXXoh
         n9pw==
X-Forwarded-Encrypted: i=1; AFNElJ/MY/mSbqvn1RTRK4lzd5bcYYjQTF9ZEs/jnmRzju/3+w62v6wQr5b9dxQKyzg8LoToIf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxejOm+0YfnNneXmwU9Qtm6L19qeQqn/ON3RFIcrZcx/IznrYGx
	JeeOWqdSKfyveYBBOF3kuJbvNrzRTdjdQ6a+/DfhEcuahXKDcu7Px5Vo
X-Gm-Gg: AeBDievW5kl5OtLxRAlR+Q7JcZosfucc6f0Q9xPqKybqaqIYxjWU1yD2pBnuLFPjNcR
	G2ojoeNb39/VsHxyf9hrJcUFEDO99Fa/R12U1XozcrGW7DB9muaf5rNtiAhTEdFFY6GM30btEzU
	8MKeZaLJKCLQcxwlYtiyKVg4vHU/T/btZbf4VJ6QFxTVJLXgcsRmzsx3CpIF3IdHDoUPPRd7SjR
	qaSP8vG0uaduOC6DVc3css/8RzgW/a8x+zxCGVad3K/uCSlbkco1kfI5Xn8RaNMFGAYvYPNn1kH
	pXi8KB1c4xiKeUdWKZ89wGH5HtufeyyS057VxeXF+RlxfojrOzveH8KFA4noRh5j1hg+oMWgIKN
	POykKnm8DMql8946cFThhFGjIc5eYkMZavj42siB4m2y+0Tmp1tAdc8fvgxxftGnfPBT8q8ak9x
	JILdX3za+J8Lh8KXG9MdXKa9ikx1+XQztTukd3zA==
X-Received: by 2002:a05:600c:530e:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-488fb768db3mr193873925e9.19.1776682711203;
        Mon, 20 Apr 2026 03:58:31 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm290929495e9.15.2026.04.20.03.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:58:30 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: mahe.tardy@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	coreteam@netfilter.org,
	daniel@iogearbox.net,
	fw@strlen.de,
	john.fastabend@gmail.com,
	lkp@intel.com,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org
Subject: [PATCH bpf-next v4 2/6] net: move netfilter nf_reject6_fill_skb_dst to core ipv6
Date: Mon, 20 Apr 2026 10:58:12 +0000
Message-Id: <20260420105816.72168-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420105816.72168-1-mahe.tardy@gmail.com>
References: <aI0MkNvWlE4FXMV8@gmail.com>
 <20260420105816.72168-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move and rename nf_reject6_fill_skb_dst from
ipv6/netfilter/nf_reject_ipv6 to ip6_route_reply_fetch_dst in
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
index 09ffe0f13ce7..3652efec7081 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -100,6 +100,8 @@ static inline struct dst_entry *ip6_route_output(struct net *net,
 	return ip6_route_output_flags(net, sk, fl6, 0);
 }

+int ip6_route_reply_fetch_dst(struct sk_buff *skb);
+
 /* Only conditionally release dst if flags indicates
  * !RT6_LOOKUP_F_DST_NOREF or dst is in uncached_list.
  */
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index ef5b7e85cffa..9663d1db6d80 100644
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
+	if (!skb_dst(skb_in) && ip6_route_reply_fetch_dst(skb_in) < 0)
 		return;

 	icmpv6_send(skb_in, ICMPV6_DEST_UNREACH, code, 0);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 19eb6b702227..41871fddec4d 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2721,6 +2721,24 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
 }
 EXPORT_SYMBOL_GPL(ip6_route_output_flags);

+int ip6_route_reply_fetch_dst(struct sk_buff *skb)
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
+EXPORT_SYMBOL_GPL(ip6_route_reply_fetch_dst);
+
 struct dst_entry *ip6_blackhole_route(struct net *net, struct dst_entry *dst_orig)
 {
 	struct rt6_info *rt, *ort = dst_rt6_info(dst_orig);
--
2.34.1

