Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E673371D1E
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022532; cv=none; b=p2vVK1QRJQUC/Mvmo7W7EvmiHW9eWflqSeVtAKxcZurThwJr+XaLv4bCG6b8x8S4PgSo61Gs/PeAnk8qQKl8KSJQaz3kaP5CeZMi9zft//Y0QISh/CQFHRnNv5UWZbnJI8sdPz8nHPCauG8v0M5DbUvXBTD8Zzam2AHcxoDJ8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022532; c=relaxed/simple;
	bh=dud2YNBYvUom0KH/Y60Uh9zFQp26TWYO0xIVlKi8Sv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HdlbIh5ybqUjTiHv/vcfhMqM+uZ0bKTdxX/kZPFFmkHE0YAaP7zxB6ImWuQTfclEMUNPo9DVQHIAqIpMPO8U/kP+Jy0QmdxN+2gfIeDRzsm8JKElP+7qXezvMINZ14IP6mTJYPTkdFQGgtM/h4xRunQeIATIZL+ENQPIuwKa6jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=HtqNbHXD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="HtqNbHXD"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2165599a91.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786022529; x=1786627329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q3b+EkF9QMrR80LpGhytFeACOBOjNmUOozsMI5C98ss=;
        b=HtqNbHXDMJIw3jCgj+ZxL8Jio0kzwU49ixSjX3zw8v/jlyhYuwyEpLROW/dlSAtgEb
         w2s4Uf21OgNOlTaj8J+9Fc24LPYqRcx/qVJ/MEidWs0NaRgBEazXf/q/rND5uDH076yl
         qvy1F+xS9hN4pzNvyPfGJGnJuoeGyxdwO8ugnoQNoafstKx68fSk+MBJJSVz6u6ftlFg
         +GSkC2ikH0yzr3G+uioSemvXMGMnbD3lwuoWhpgDKKA4+YcrVjaxuM/sL5DAd9/h6yI0
         jk1A7rj87Jf0lg5vj/nRLdLu7T6CdCURb8h8KcF0txzTq9ZXOMMvM98eS2pk3FxC0Km8
         AIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786022529; x=1786627329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q3b+EkF9QMrR80LpGhytFeACOBOjNmUOozsMI5C98ss=;
        b=KMd7S9ErM1a1mHruRWDIzVOr6JqdKnHJpB6lUlJDd6R5rEPgskcOoGJefZFvu99nSQ
         v+VMeiQH9MT9UOh8IVgGBJ5MSQkcYXIJbPwEpENFKLUvYOLeqWEh9W02FFsV9/rUVsCy
         nkiVF2aiP9W44AvIElr8hJ/W67ktgvY/ls596+l8fwSauFJcds4rjQ04w90Nt1dsx4N4
         4VBYMczYSh+pNZ/PNsERv3NprrvPQLJlbfVXlE4uMnULPPTmrLi20F8CWcYyR809t2nr
         dtyponqTZ7uO5lQcW+ojlnYf8bwdHubLVqPZIDLZhfxI2hfv5/gpizkvP28WdO6I+KHh
         nFuA==
X-Forwarded-Encrypted: i=1; AHgh+RqYabzdk4h3k5EsGwneBoQUhDqrCGlPkgtDieB6TmyjBnT92E7abgbJmWeKhfsULKD/xxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26gzFt/GtfnVNXBDN+m/G/IQzitELdAJIztmqztxQZjq4PRS5
	vwILgQUAtvl/bCsOcfDng8l2Ys1BSqVq5CakcdHyA8B7/uBGqjtPGrSJZC6ZG+sQ4MzP
X-Gm-Gg: AR+sD13hJ9m0dnjawjV7Gks6rNbSdookUS9plBVOn+EBczePtv/vHQc2supj39NU+Hw
	dy9kcbSgWrEqlUWxTB6Zypl2gv0MwAKqXOz1LAQaqAcIFO/pa+KhTbyqCq2P3H5arhGczFQB0W0
	F+qjinRIuw00Y7X82G9c18X5xiykKfbyKcELHnH+lZxyUU8uEI/9BvTZoSa/6AOTYkR1Db7v+I8
	oK2WGdIl1M0jIwCEZF97bEeSmPn1Y4mTbni7DeqM/tHJCKlFYAC9P3VtC8Mp2P37oZ1huMznFvc
	isVn/RPQMoRkX/wgEirWWjLLc6sYHpDqXjpyTWngyKNvTl7RPI8Ls1at8YLpHrnb1TYs0CboU28
	fNdb7LxTfOdNWTS5JU5eEDb+oJb13zwRbZZAPpW6omGZg/4INvPZOQdT2sHzlUkUHx6fJb//Y/e
	GWwdGdxtZE+ym5NaXxiS/DzEKQ61ivYgDfRWs8tiF37LBP+cOM2wm379WvzZ7k2iGzASgWWhV70
	rESgKk5aHgJJ6I=
X-Received: by 2002:a17:90b:4e8d:b0:38d:ec31:4840 with SMTP id 98e67ed59e1d1-3903c5932femr15718603a91.13.1786022528938;
        Thu, 06 Aug 2026 06:22:08 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085e4b01esm1542955a91.16.2026.08.06.06.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:22:07 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	razor@blackwall.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	yuehaibing@huawei.com,
	kuniyu@google.com,
	aleksander.lobakin@intel.com,
	maoyixie.tju@gmail.com,
	thorsten.blum@linux.dev,
	kees@kernel.org,
	kylebot@openai.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v3 1/1] net: cap advertised IP tunnel headroom
Date: Thu,  6 Aug 2026 21:21:52 +0800
Message-ID: <0ac01576f92412e8fa35cc3eb44336797a9d11d0.1786021595.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IP tunnel devices derive their advertised needed_headroom and, for IP6GRE
devices with header_ops, hard_header_len from lower output devices. A stack
of user-created devices can make the derived value larger than the 16-bit
skb header offsets can represent. Once IP output reserves it, skb head
expansion can wrap those offsets.

The runtime transmit path already caps a growing needed_headroom at 512.
Apply the cap when configuration publishes headroom or header lengths
derived from a lower output device.

Capping the advertised value is safe: IP tunnel transmit still expands the
skb when the packet needs more headroom. A nonsensical stacked configuration
can therefore incur an extra reallocation, but it cannot publish an unbounded
reservation to upper layers.

Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v3:
- Split netkit handling into a separate follow-up.
- Explain why capping advertised headroom is safe.
- Use local variables for derived headroom.
- v2 Link: https://lore.kernel.org/all/0ae4aa29223b89049727aec4d36f144bad41537e.1785476387.git.zhilinz@nebusec.ai/

changes in v2:
- Move the fix from IP send paths to tunnel and netkit device control paths.
- Cap advertised IP tunnel headroom at 512 and reject netkit headroom
  values above that limit at device creation.
- v1 Link: https://lore.kernel.org/all/0c6c64e9bbd71a0decc8504a384061e0e631be13.1785054561.git.zhilinz@nebusec.ai/

 include/net/ip_tunnels.h | 11 +++++++++--
 net/ipv4/ip_tunnel.c     |  2 +-
 net/ipv6/ip6_gre.c       | 10 ++++++----
 net/ipv6/ip6_tunnel.c    |  7 +++++--
 net/ipv6/sit.c           |  2 +-
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index d708b66e55cda..85e3455cea259 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -629,8 +629,7 @@ struct metadata_dst *iptunnel_metadata_reply(struct metadata_dst *md,
 int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_dst,
 			  int headroom, bool reply);
 
-static inline void ip_tunnel_adj_headroom(struct net_device *dev,
-					  unsigned int headroom)
+static inline unsigned int ip_tunnel_limit_headroom(unsigned int headroom)
 {
 	/* we must cap headroom to some upperlimit, else pskb_expand_head
 	 * will overflow header offsets in skb_headers_offset_update().
@@ -640,6 +639,14 @@ static inline void ip_tunnel_adj_headroom(struct net_device *dev,
 	if (headroom > max_allowed)
 		headroom = max_allowed;
 
+	return headroom;
+}
+
+static inline void ip_tunnel_adj_headroom(struct net_device *dev,
+					  unsigned int headroom)
+{
+	headroom = ip_tunnel_limit_headroom(headroom);
+
 	if (headroom > READ_ONCE(dev->needed_headroom))
 		WRITE_ONCE(dev->needed_headroom, headroom);
 }
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 9d114bd575f92..5b1f180485d42 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -317,7 +317,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 		mtu = min(tdev->mtu, IP_MAX_MTU);
 	}
 
-	dev->needed_headroom = t_hlen + hlen;
+	dev->needed_headroom = ip_tunnel_limit_headroom(t_hlen + hlen);
 	mtu -= t_hlen + (dev->type == ARPHRD_ETHER ? dev->hard_header_len : 0);
 
 	if (mtu < IPV4_MIN_MTU)
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b843116e9b703..cc757586be90a 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1137,13 +1137,15 @@ static void ip6gre_tnl_link_config_route(struct ip6_tnl *t, int set_mtu,
 			return;
 
 		if (rt->dst.dev) {
-			unsigned short dst_len = rt->dst.dev->hard_header_len +
-						 t_hlen;
+			unsigned int headroom;
+
+			headroom = rt->dst.dev->hard_header_len + t_hlen;
+			headroom = ip_tunnel_limit_headroom(headroom);
 
 			if (t->dev->header_ops)
-				dev->hard_header_len = dst_len;
+				dev->hard_header_len = headroom;
 			else
-				dev->needed_headroom = dst_len;
+				dev->needed_headroom = headroom;
 
 			if (set_mtu) {
 				int mtu = rt->dst.dev->mtu - t_hlen;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index bf8e40af60b08..2c941acb081fa 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1522,8 +1522,11 @@ static void ip6_tnl_link_config(struct ip6_tnl *t)
 			tdev = __dev_get_by_index(t->net, p->link);
 
 		if (tdev) {
-			dev->needed_headroom = tdev->hard_header_len +
-				tdev->needed_headroom + t_hlen;
+			unsigned int headroom;
+
+			headroom = tdev->hard_header_len + tdev->needed_headroom;
+			headroom += t_hlen;
+			dev->needed_headroom = ip_tunnel_limit_headroom(headroom);
 			mtu = min_t(unsigned int, tdev->mtu, IP6_MAX_MTU);
 
 			mtu = mtu - t_hlen;
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index a38b24fb83842..19b7fa8d1a2a0 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1131,7 +1131,7 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 		WRITE_ONCE(dev->mtu, mtu);
 		hlen = tdev->hard_header_len + tdev->needed_headroom;
 	}
-	dev->needed_headroom = t_hlen + hlen;
+	dev->needed_headroom = ip_tunnel_limit_headroom(t_hlen + hlen);
 }
 
 static void ipip6_tunnel_update(struct ip_tunnel *t,
-- 
2.43.0
