Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3BE364925
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478923; cv=none; b=m5SUBUKj4go4iLjSvxSh1ZjpZP+L78gxtm3fUkyL+0ng9nUSdKCeT1cDEWgJaJKcqdItgXQpspVM4b47bHa+fyFHhqZuZQCHMqQZ9EkI7MxFy5JFamYWE4LPtoQuL7WtDbP2tzlnQ+8/GTBrD+ZfXNUIil52XAOOlv/5eKL+Nhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478923; c=relaxed/simple;
	bh=nPKboyd59q6zKuiDUV4Q6HkuhovxWt2tkPrXASBc8+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5jtpmwF+ZPVyAMRW6WAwIGKb0M0YjVkFzcgDXb0SgkpGWvC2AiFQdK5d15AYKaxR7RQLGNj8+OVPPgf2v6OM4arAlGroCav88T847IYfudkgsr7lwlNER/rAOp9In08aXXnGcwMO0Z98twA8DBSiYysNYk7mL+iMU0nNTYrNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=J2txtWpl; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="J2txtWpl"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ccb0e85312so3435385ad.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 23:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785478921; x=1786083721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aA/LiyJzEP6luazmq5MF2VDFG+Y6mIgTBGcPWqORlJE=;
        b=J2txtWpl3zpCAq9i20RY53UUX5tUqrNeOIehZe96D4djdhXETX3XI99tB/qOmu/pTQ
         zzXtf7+muwRS5DYt4j7XKUTrcEQoBFwSd93mZEXab3sBfMnQueiVnl7na7dEvd7uWnv/
         R2y+qOWegrt1TKGh8d7XIwbuDTbhSxHnuRx3Rq+vKxA6QmOua1aMDJwjKms4+HY7lF2p
         o534jEMNc8PWn0bGyqqXWx81C3WZ55SpTa7AS5UGlzm1Rz+MiSwOW4BzHyxSNX7/UlA1
         Hv9g2WJmryhy5cvewkAHWL+6MdnKWPKIBnBgzQ0lwOjwkjrV+6hcl76YN72Q1+8KTpEH
         Jh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785478921; x=1786083721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aA/LiyJzEP6luazmq5MF2VDFG+Y6mIgTBGcPWqORlJE=;
        b=XNwx+JoAcEyYrsOp7yoVO4i/Kk6USmNXLGtOiRrbM0H2iS8kcaVQdsZ4S8bKmVhg0m
         KwwSdN58x0mMQ9XHc9tsvtUFwbgjJJpKSIEWosXv5WlmSm3GacdlgaRMEgkTt+K8gLGt
         6rU4PA/DcuVgJFSWOvQ6Kj4LjcP1AKBRP1ypf4xNusDb/2Il4QnS1BVMpoj1rZLnTdEl
         YZl+H9Y8tqVN3KTtp13IzetMV51eTUw5JLtLfFP8dLxEWTcUyu7P95W8jIHJH0MmnNXh
         lsbN18EL5kCtCxuUrs24k9Ji2Bi/ce3SkOzJjFOEAYp4ecfGWEX0CB3foqLrWwj555L+
         wJYQ==
X-Forwarded-Encrypted: i=1; AHgh+RqaSJ1T2XFAOxhHj8zSSV40fKrm9r0RORNYDWIlD61J9Og3gueKfCYXybOw8fxMxRN+wis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEOvB2UXTwAjLE00Cygfebmn+nkZ2NZRA6YF/ZsQy4f3g9s+Jq
	D06SDSytP4MTxKi1TWfyX7KrOk7rEywgnk3MKU8iShk60HN9xLJLpn1lOgtKJ1wNVaaq
X-Gm-Gg: AR+sD1140S94aiq54rDU0QmwvEvYa5zHV+NdEqLLA8Wnb8Cs9cZxHm7GVp54Obr6/n2
	lERI4OtS0fS8cspZxSD42zTqdgAcpR7xhzVTcsWo6bD3RVBYR9ah79VHaui/vAv5S9x4L99MXMq
	eTF9piBv0DLKQXYEd44TpyAL70ftRYx7iJSfUBR6Z+05jBAljhuPOx+qxBiUCwPO77w3a1QYksw
	1LH/UF4Tsi6wlBRAqSpu6/jupVphLgA2kdRXQr+hoVW2ntr8GmUu8xgIHPtqOUFubreDsBgFLtv
	cR42GCeOfu1cVbd3yQm4uE6pIOmB6KBkYIRTmy3txfZfu87WcVYllFHYcq+G+OlnUx4XvEFilVD
	W0HNy5vX8bBXo1BjMlaqn5Tfm/Hpt6qsvd+GzlSDcIjA0HSmYfZ55Fjma60TwCzHtP2YiQniQrZ
	gPkExoebMbeOu9f84ThaG8t3iN9gsDf4vZgQIE6hk24KzduVos+bdwr4vBTfipcjeB+SffPBJ6b
	ixv
X-Received: by 2002:a17:902:d4ca:b0:2cf:bf32:ba6c with SMTP id d9443c01a7336-2d046e8699emr9077365ad.26.1785478920646;
        Thu, 30 Jul 2026 23:22:00 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b165e99sm827565ad.83.2026.07.30.23.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 23:21:59 -0700 (PDT)
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
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v2 1/1] net: cap advertised device headroom
Date: Fri, 31 Jul 2026 14:21:43 +0800
Message-ID: <0ae4aa29223b89049727aec4d36f144bad41537e.1785476387.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IP tunnel and netkit devices can publish headroom values that are derived
from user-created stacked devices or directly supplied netlink attributes.
These values are later used by IP output paths when reserving link-layer
space before storing skb header offsets, which are 16-bit fields.

The dynamic tunnel transmit path already caps growing needed_headroom at
512. Apply the same limit when tunnel link configuration publishes
needed_headroom or hard_header_len from an underlying route, and reject
netkit devices created with IFLA_NETKIT_HEADROOM above that value.

Keep bogus device headroom out of the control path instead of checking
every affected IP send path.

Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
- Move the fix from IP send paths to tunnel and netkit device control paths.
- Cap advertised IP tunnel headroom at 512 and reject netkit headroom
  values above that limit at device creation.
- v1 Link: https://lore.kernel.org/all/0c6c64e9bbd71a0decc8504a384061e0e631be13.1785054561.git.zhilinz@nebusec.ai/

 drivers/net/netkit.c     |  5 ++++-
 include/net/ip_tunnels.h | 11 +++++++++--
 net/ipv4/ip_tunnel.c     |  2 +-
 net/ipv6/ip6_gre.c       |  6 ++++--
 net/ipv6/ip6_tunnel.c    |  5 +++--
 net/ipv6/sit.c           |  2 +-
 6 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index a3931cd821321..d8e9ce1c659d0 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -25,6 +25,8 @@
 #define NETKIT_NUM_RX_QUEUES_REAL 1
 #define NETKIT_NUM_TX_QUEUES_REAL 1
 
+#define NETKIT_HEADROOM_MAX 512
+
 struct netkit {
 	__cacheline_group_begin(netkit_fastpath);
 	struct net_device __rcu *peer;
@@ -1244,7 +1246,8 @@ static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
 	[IFLA_NETKIT_MODE]		= NLA_POLICY_MAX(NLA_U32, NETKIT_L3),
 	[IFLA_NETKIT_POLICY]		= { .type = NLA_U32 },
 	[IFLA_NETKIT_PEER_POLICY]	= { .type = NLA_U32 },
-	[IFLA_NETKIT_HEADROOM]		= { .type = NLA_U16 },
+	[IFLA_NETKIT_HEADROOM]		= NLA_POLICY_MAX(NLA_U16,
+							 NETKIT_HEADROOM_MAX),
 	[IFLA_NETKIT_TAILROOM]		= { .type = NLA_U16 },
 	[IFLA_NETKIT_SCRUB]		= NLA_POLICY_MAX(NLA_U32, NETKIT_SCRUB_DEFAULT),
 	[IFLA_NETKIT_PEER_SCRUB]	= NLA_POLICY_MAX(NLA_U32, NETKIT_SCRUB_DEFAULT),
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
index b843116e9b703..04ac007ebcc87 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1137,8 +1137,10 @@ static void ip6gre_tnl_link_config_route(struct ip6_tnl *t, int set_mtu,
 			return;
 
 		if (rt->dst.dev) {
-			unsigned short dst_len = rt->dst.dev->hard_header_len +
-						 t_hlen;
+			unsigned int dst_len;
+
+			dst_len = ip_tunnel_limit_headroom(rt->dst.dev->hard_header_len +
+							   t_hlen);
 
 			if (t->dev->header_ops)
 				dev->hard_header_len = dst_len;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index bf8e40af60b08..403995273cbae 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1522,8 +1522,9 @@ static void ip6_tnl_link_config(struct ip6_tnl *t)
 			tdev = __dev_get_by_index(t->net, p->link);
 
 		if (tdev) {
-			dev->needed_headroom = tdev->hard_header_len +
-				tdev->needed_headroom + t_hlen;
+			dev->needed_headroom = ip_tunnel_limit_headroom(tdev->hard_header_len +
+									tdev->needed_headroom +
+									t_hlen);
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
