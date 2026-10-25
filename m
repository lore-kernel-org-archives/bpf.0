Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901131;
	b=HqNnyRBnjaz2IPoR0VE1/8M0c+bNTlbNkj7dgWw0JMkjOsfz4CW21X0oac9KFMgxYWey
	 NrteyzXACraRj77ctcHceGEuezMFHSr/KbPU+bGHEfPK39oPWKrTH1nzkgGgItCye/C1v
	 nKHtJHRgvvBYo852SuKwtMP/zfcMd0mvJxpR3i94L8vaPUczbjoNqyHz0ZCZ21VzO7k6b
	 qnRzJaxO9dVvuO7Ry1N/plRT82+KKFHBb7Rpnd7gcJ8KGby09ZiE5ltY9EQ/UvEhWPjl4
	 RKzsAoRZ7yI19LnGneumz3MLXWDTu618uleiJpevG00pPLFyfmPf7kJtAXBf/476lJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=zvCxPvVOFJIOuLk7jZ+/YMB/FJuGHwhz7cBx+wq9rrc=;
	b=NsCv5m06U0h1wESzZlR2c4gAbkBorGjvXzkO4xYjfo3Kn5CMvkZvGD5NA816u7TQV+n2
	 NXLk++5pBkX3WnH3ghmT4RgPZdiYV6e+p3P43JzRT/yi9Pxwoh/xcpzXyEwdYhwp+V7OY
	 CN3fqOVAXTtiQmTG18Vehx/yXRA4Kv/FyagUk6+miRWWIRiIN9t0dm4DtthbqFE7bO9dT
	 +0mLkodChe3NrfzG2a3HCFvpbXK0CzHXuFdG+E9LpF6z5D/4GIIqOYjoaGZzZAJxBt05t
	 bOc7b8XNWxQAtTdu9GZRhp4v5tmbdDhCuyY210Xbj1B7MTRNesTlNyjm7qrAK40WxIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="lk8Eqk/A";
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFEA606A326
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 04:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BFEA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lk8Eqk/A
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3adeba76cadso691698a91.1
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 21:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792901131; x=1793505931; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zvCxPvVOFJIOuLk7jZ+/YMB/FJuGHwhz7cBx+wq9rrc=;
        b=lk8Eqk/ANxqBoYF9wNEhF9PgvqNm6Y9fcRhO7t5ImQwmGN8F0Wo3LZnC+7EZyndme8
         6nWDV3Xzw2AYYK5ekdjIIERVB3Wp9MZMmT9HowWh8OsTXj+Z/UwCBdAWBkyQlCI1K4X/
         EncHtdyuZVmtfW4nIyMJQOnBWuL0L+vwDvTlXZ7OiG43EFy2w/YuEJ3NpmxU6DTjyyes
         rpnJDVwhnJ1lDK5Zz5bi6zioJ2W7ZM3TI5JwEuxo56Qyo7FqlHOdKE74S5TseXxXEc39
         WQx7ccXD7oaVLiBhbPuN5B+AlbBE/BgYwrrPjQN7JDwh4tzp6qqumTL/d/jVVaC9sasL
         1vXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792901131; x=1793505931;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zvCxPvVOFJIOuLk7jZ+/YMB/FJuGHwhz7cBx+wq9rrc=;
        b=pribLdoWbjyA/h7nTqC3CLz+zvVWSy1NlFDVsRMaYMmnCuOuZA/gs3OfHDiZIUbHcG
         1jTawd/P4eiuEmjPCvw0O7InEq6g5p/6twZdL7j9Wvzv5IpPOxSyZU5ol/aZzuAZP+l1
         36G27T4vkY/453zT9ygt76fKnZs+Jk05QeCYyp78RQTXlL2KT5xdgRjBcR3kKJhNugJr
         5Mx0Qtl9btRKpBgYbrb1rAaK35jh2ve5/TQ0fYFcP2vn2CXZpBNj5XRUZcDeM0RBEGlU
         MginpXz64ZEcONCkc9TRa58y9Zl1ty6I9YalMljaGSG9cyqwWZXT8CA+bCZvT1G/SVhW
         A8mw==
X-Forwarded-Encrypted: i=1; AKwUvBxFKjaDMciK9rUUVcxO5PU43Xc2zefIpCQ9ShUdOAtiTSgwwDEFjIA1Ucbf2/GgWzpxjPg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkNrKbS5fGkvdrU3lR2/xbxHtzFAl3RSNfkK/+rxICshv4uJRk
	2kgYWAuj9/gL98USZjqXhz+Nq9n+DYnrIxGrJOLwChwzunksnUMD8LYBlKAOrlO3K3NqBc/iDZ9
	j5BAQaw==
X-Received: from pjbme8.prod.google.com ([2002:a17:90b:17c8:b0:3ab:8c4:a67d])
 (user=weiwan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2cc8:b0:3aa:f2c4:12e9
 with SMTP id 98e67ed59e1d1-3adea093fdcmr3009518a91.3.1792901130531; Sat, 24
 Oct 2026 21:05:30 -0700 (PDT)
Date: Sun, 25 Oct 2026 04:05:22 +0000
In-Reply-To: <20261025040523.678027-1-weiwan@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025040523.678027-1-weiwan@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261025040523.678027-2-weiwan@google.com>
Subject: [PATCH net 1/2] net: Make PSP skb extension survive packet scrubbing
From: Wei Wang <weiwan@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"

skb_scrub_packet() drops all skb extensions unconditionally via
skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv, vxlan_rcv,
etc.) and cross-netns forwarding (dev_forward_skb, netkit_prep_forward,
skb_do_redirect).

When a virtual device such as netkit is associated with a PSP device in
another network namespace via PSP_CMD_DEV_ASSOC, incoming PSP packets
decapsulated by psp_dev_rcv() lose their SKB_EXT_PSP extension when
scrubbed during redirection into the peer netns. Without SKB_EXT_PSP,
__psp_sk_rx_policy_check() rejects incoming TCP data segments at the
socket layer with SKB_DROP_REASON_PSP_INPUT.

Introduce skb_ext_scrub(), a selective variant of skb_ext_reset() that
deletes every extension except SKB_EXT_PSP, and use it in
skb_scrub_packet(). Scrubbing is safe when the extension slab is shared
with clones: deleting an extension only clears the per-skb
active_extensions bit, and the shared slab payload is released lazily by
__skb_ext_put() once the last reference goes away.

Fixes: 06c2dce2d0f6 ("psp: add new netlink cmd for dev-assoc and dev-disassoc")
Link: https://lore.kernel.org/r/20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com
Reported-by: Daniel Zahka <daniel.zahka@gmail.com>
Closes: https://lore.kernel.org/netdev/DLODSKPY6ON6.1G6SP3CFFLCPJ@gmail.com/
Co-developed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Wei Wang <weiwan@google.com>
---
 include/linux/skbuff.h |  2 ++
 net/core/skbuff.c      | 22 ++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index af1cbc2799b7..027404d70c72 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5083,6 +5083,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
 void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_put(struct skb_ext *ext);
+void skb_ext_scrub(struct sk_buff *skb);
 
 static inline void skb_ext_put(struct sk_buff *skb)
 {
@@ -5152,6 +5153,7 @@ static inline bool skb_has_extensions(struct sk_buff *skb)
 static inline void __skb_ext_put(struct skb_ext *ext) {}
 static inline void skb_ext_put(struct sk_buff *skb) {}
 static inline void skb_ext_reset(struct sk_buff *skb) {}
+static inline void skb_ext_scrub(struct sk_buff *skb) {}
 static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
 static inline void __skb_ext_copy(struct sk_buff *d, const struct sk_buff *s) {}
 static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_buff *s) {}
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 93c2f440b9ec..3eb0159129e2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6380,7 +6380,8 @@ EXPORT_SYMBOL(skb_try_coalesce);
  * operations.
  * skb_scrub_packet can also be used to clean a skb before injecting it in
  * another namespace (@xnet == true). We have to clear all information in the
- * skb that could impact namespace isolation.
+ * skb that could impact namespace isolation. Note that PSP skb extension is
+ * meant to carry information across namespaces by design.
  */
 void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 {
@@ -6388,7 +6389,7 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->skb_iif = 0;
 	skb->ignore_df = 0;
 	skb_dst_drop(skb);
-	skb_ext_reset(skb);
+	skb_ext_scrub(skb);
 	nf_reset_ct(skb);
 	nf_reset_trace(skb);
 
@@ -7431,6 +7432,23 @@ void __skb_ext_put(struct skb_ext *ext)
 	kmem_cache_free(skbuff_ext_cache, ext);
 }
 EXPORT_SYMBOL(__skb_ext_put);
+
+void skb_ext_scrub(struct sk_buff *skb)
+{
+	unsigned int id;
+
+	if (likely(!skb->active_extensions))
+		return;
+
+	for (id = 0; id < SKB_EXT_NUM; id++) {
+#if IS_ENABLED(CONFIG_INET_PSP)
+		if (id == SKB_EXT_PSP)
+			continue;
+#endif
+		skb_ext_del(skb, id);
+	}
+}
+EXPORT_SYMBOL(skb_ext_scrub);
 #endif /* CONFIG_SKB_EXTENSIONS */
 
 static void kfree_skb_napi_cache(struct sk_buff *skb)
-- 
2.56.0.257.gf7497c7d27-goog

