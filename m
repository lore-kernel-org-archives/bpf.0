Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB718387566
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129932; cv=none; b=pXlLbbachs58j7Wz/8uwMEdsDmFJ+zx78nw8rgvuSSM5cYvqZHfPkQXZWWKxle9E7/zZKi7PRr34gFTpmmk652T/diI4XroFknRTtNkicmbjM6y7rOKyDzl4MrKAL4NCJAj+LFyXr7t2jl2vrXM32MuKoHexfH64bcXSWkK1csU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129932; c=relaxed/simple;
	bh=Me0JkBhhzXdHG3A+0nI7/cjpzA+euLipBe1aJ57r19E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyi+31FAW1cM+vovtu20XaD3yAQc1+1sQcpJs9M2VIxLrU+3Bv1LOfQU4jkRpCdVtgjgUsdY139YLBpgGLPD0ipB+eRcQvW6EpvGZrX1XgoYiSMMqUCgF2NoTWqw+VQtUgb7IKju6CnLK67Z9jsjvGkru5ilCy37ml2y9uiGUuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbI2v0ck; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbI2v0ck"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45fd464d51fso2547535f8f.3
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 05:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782129929; x=1782734729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qY+jLSzUjV0iGelsgIOTUb0ZtH9fV1LBMjTKS1AiLeU=;
        b=LbI2v0ckwpQF3z0TsK12SeN5OuNVmP4ZL4LR0yNV8in1eeJXiPlaSgHJoxW2FclnwD
         cW/8LBD9/M4+aAmuEaiUPYmrAEFNzwPgX1RNst0/gGrZ+VEFVMriAt2YIXdeII7ZaqVo
         paNnRSbZJl8kszeG2ICir5wzu05UYJVNLU1qW/ZrlgF8LZBjzZFZid8aumlynUx+yJ/L
         R+oAgAlYijeC/079EYdWP0siXlBm23RgvnyI0ZaBvLcjuZK9UvLEhATpTtSq0VFnm3jg
         N7/htmgqg3uQ3h/CMqtpAPem5BWLYBgNOZzJWEN2nv98O/cB+fgz0VfIBCyVqXiOKPvw
         eiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782129929; x=1782734729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qY+jLSzUjV0iGelsgIOTUb0ZtH9fV1LBMjTKS1AiLeU=;
        b=BanbjFAYAWe0DaNn9Ba4N8hGHItbRsFbce+rqNVE7NHnx3ZhCof8IQmuhiMuUlwR/b
         oASB9zavOc8DyHJaELQ93Qa+JOcLOAHXuSD4iTQcmqAqk11jgB0JcMcVDl7IbuoivKgY
         /SrxDHaeP7UK1/wFaYnsWtCB9NojnKCwvsqR0ESOReJ6wZis/jJIGd0ahciG/Udkgs5n
         ltndEHbF3DAINDBBKGkFrKXwqIOu6E9YJOBsyfTNhcTPB7/qRCmncYTUW+ILGMkccm3n
         ZfMN2NRhAtBqrpo58LuFrJGH4jGpNv0/Ngf+qa6xcP5QvI8A6CQ3eJyDcrO9CFNR50de
         AN0Q==
X-Gm-Message-State: AOJu0YzozsxSHk0QdSXa/joCG6lvfpA2i2JT14tLYYgQrr3d5CA+n0xW
	mp7He5N/6xpR6ciILrMRgqfI7m9IQXgJTAeZE/P9nK+uJqfYiIJB6wBL0wVUT5C6
X-Gm-Gg: AfdE7cmABihToo9hwQtG6ddL+cs+QTxydykwu/ZffYI2rtmZZa8I7Wsh6ZmzSc1NnuS
	y46FvzoH5rLi5ydE/lwWuK617YacaA1RS/qxlcN+b/kDNcfWTLM/FcD+V9PUWfir57Z83IBCyEC
	qg88J4xFMj+1ihbLpqRpvHMMs8inDfz1Fp1F5JmBCijlmuljgWuaWhXIiY7BE2BnJEyTknVjJqQ
	kF5fC8whdsuSH5c5WGffuTwCoISaon7npw9Wy6n9lHL0fRM8f4hcBQWblA/zTrScbnBJ/Xrbflx
	6w1f8HiGGQy7jDnYF481dyn8a3Z/s5R+cqqBI124e8Nzs7SEm7cAncYWoQ4JxCixe5B5Z7OvAN8
	csWsTQWV/Pegw055djprbhn/EGaOJwZs649Dw0CuPz0kgyX1X/RY2UFmYhM5z6qfKhgJkf255F0
	FdWxcF1YvtlwEytHbE
X-Received: by 2002:a05:600c:468c:b0:492:3c7e:57aa with SMTP id 5b1f17b1804b1-4923eeb494emr232891585e9.0.1782129928900;
        Mon, 22 Jun 2026 05:05:28 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm491083105e9.0.2026.06.22.05.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:05:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 2/7] net: move netfilter nf_reject6_fill_skb_dst to core ipv6
Date: Mon, 22 Jun 2026 12:05:10 +0000
Message-Id: <20260622120515.137082-3-mahe.tardy@gmail.com>
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

Move and rename nf_reject6_fill_skb_dst from
ipv6/netfilter/nf_reject_ipv6 to ip6_route_reply_fill_dst in
ipv6/route.c so that it can be reused in the following patches by BPF
kfuncs.

Netfilter uses nf_ip6_route that is almost a transparent wrapper around
ip6_route_output so this patch inlines it.

Reviewed-by: Jordan Rife <jordan@jrife.io>
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
index 6361ad2fcf77..0fa56c801178 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2732,6 +2732,24 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
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

