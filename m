Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA000494804
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048971; cv=none; b=Y4rGK62wmqQWi7x5OesnBvrud0B1xAKSvGa0jN0OEhoW2BzkpmnEeMdfVUR93NdiKuwyHCz+EiMCiBLjH8JP1W/biXPMrV7BjH5L/ERTPO2R1Eg37egcKiiyKy8eIQYdlkXMVRz7p1SyfGXUi1gvDjahd/7pF85qZZHrNNTGEkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048971; c=relaxed/simple;
	bh=cLyaiCj3QBYpac/QkfMsFPlSx/mFitzO1+OunaflwLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJY4XqXLdoRQH2m2EPhSE/l+VATAH2gt+kYzZd88mkp08kQHoEpzaIOieF2830krgy1Y4+nPFVd9PRc5d7fNup8UL/ChgCNq6xz/xf3o6zxHXZlpzCwni1WgHFUnNNIpNwpKQxE7VR/qDXGUmca0sN/dB+1E002305G+DyrZebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=J/x4qGim; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="J/x4qGim"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2938116fefso328144566b.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 07:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048968; x=1789653768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gbXf8585cFr9URoNTZ3Ji2Y85DOqLtjzR+C/8UskNBY=;
        b=J/x4qGimgGaz8RyECCWXfg8/CObvy4OZ1cSZw05UqM4+FuhdqvFo76d6It5cBunRMd
         vJyzm/k5m8J8r+c6ruuN3gtHA4D5c69urmq1VJJOLEXRWzh8xrypMBH6XNUUVOuzDmdt
         J6ZLDMA61iEkgTBMtIwAW0OhqyFy/tQL4eejxHoCg+iNaosNIQZVKr9zuBlEIOsD7zNo
         +yhyLpzkctt6spuu80M8Rrbxl+c7JTzLnRDjxB+a0WiS4+uh5xTfD3hwW4oBCNcgrOOk
         hUe4p8vNQna1nQD2Sfp15wMP7ynBbcwHp93LvQ8yOrQIw+J2IYgFVRNel/9Li004A526
         hE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048968; x=1789653768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gbXf8585cFr9URoNTZ3Ji2Y85DOqLtjzR+C/8UskNBY=;
        b=UPRAtSy47+FfwixPXmHm7MolyEs5V22FJhgU+ClktM5z6Uy3Vn0cRCCQ4NG0E6ZjzJ
         BzPPA3nrGkptuNKXeoKi8G+w2WJmimv9VVH8jYr6g/sX+qz1UzZ95n6p2kAmyZdKAPPs
         Yt3EHq2HlkeAejYr/PStmVmXPeq6UBTbWjKV1jg2d5gOwUCBx9SOhizpuEeADR8+l9UY
         RP0yiTFicrwmM7X24Tl5bIbd4Ast8WOLzWkN0WehpFRePKXcLQQWxy2FW1gIfvgQVgMy
         Jwm3tN5TBYi9/MjRaj8yCYqPKl2gmQtcYSxv8QZFHaHPICllZiGYec9B1LV5FRk4XOTo
         VBBw==
X-Gm-Message-State: AFuF++nIN8oxI3YKrxjVNPyoukwa9VbqjPSyo3XBSuqc0M6cxIg+2U3A
	1KLOpxd3eZmeMd8l68uh7sc/0bSVy2J6D3fBMrOMPtjtN2yX1BPLLqLWeSlxxl7kYKs=
X-Gm-Gg: AYBFou1xXHfdKhaSliMF2QTfaGF8k6N0efAdKTJ5olXuGw37uFVze/fgFV8X0ZqcvAP
	YssiU1c1x+J1ep90oyJygmgHCrrshNNS1V5wMq8cWVsUONcEq1IJA5uCEkEZrHs15ej6S7tF98Q
	xZi5Yt4XG64SDsUQGh/6lxQ+i6lakjwrYOeM0Vabgpfn95FIZqHanZOvL56QiyYN/V425FOrdR9
	rtfMFBP7iuPlCFlvr/M8xXOcdTxu5TKfTQbVNlqDK52xel6cNwxsTZxT97Epwx23h/hAO8VxecL
	A43wOr3HGSG/aWsi3x44FNzIaYK1vGr2sA7chCiyn3we4kFvo8rHgVADyo9qeo9ZqKl4jM7SY1U
	xpW4MvyGiKsCe7Kj7td9lEeNFcXsSl+IQjYjawzZAO4SuNqS8tFU3iFXEMCUTgnoRkK5ySkcVSf
	gaTN4iwUsAFlt/sTgvnqX0zial9ljUWAonL/oYcl46YPGNBAvzq5THenY6BskZVqrwKO370g0Ox
	aIo7vgdme2LGAYqMa2PBFcI2BU1Ng08wGQVPJlsbRU/rDDr
X-Received: by 2002:a17:907:9345:b0:c26:2ff1:cac2 with SMTP id a640c23a62f3a-c262ff1d066mr1340591766b.31.1789048967439;
        Thu, 10 Sep 2026 07:02:47 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5921e2sm918728566b.46.2026.09.10.07.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:46 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:38 +0200
Subject: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
In-Reply-To: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Jack Wang <163wangjack@gmail.com>
X-Mailer: b4 0.16.0

skb_scrub_packet() drops all skb extensions unconditionally via
skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv, vxlan_rcv,
etc.) and cross-netns forwarding (dev_forward_skb).

This makes it impossible for a BPF program to pass metadata via bpf_skb_ext
through a tunnel or across a netns boundary. The extension is always lost
at the scrub point.

Introduce skb_ext_scrub(), a selective variant of skb_ext_reset(). It
deletes every extension except SKB_EXT_BPF. Scrubbing is safe when the
extension slab is shared with clones: deleting an extension only clears the
per-skb active_extensions bit, and the shared slab payload is released
lazily by __skb_ext_put() once the last reference goes away.

Replace the skb_ext_reset() call in skb_scrub_packet() with skb_ext_scrub()
and also switch udp_try_make_stateless() to skb_ext_scrub() as well, so the
BPF metadata survives queueing onto a UDP socket receive queue and stays
readable there (e.g. for a sockmap verdict program). Only mark the skb
stateless when no extension survives the scrub. Otherwise skb_consume_udp()
would take the __consume_stateless_skb() fast path, which skips
skb_release_head_state(), and leak the extension slab.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skbuff.h |  2 ++
 net/core/skbuff.c      | 24 ++++++++++++++++++++++--
 net/ipv4/udp.c         |  6 ++----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0202bcb9338d..509d447179e1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5091,6 +5091,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
 void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_put(struct skb_ext *ext);
+void skb_ext_scrub(struct sk_buff *skb);
 
 static inline void skb_ext_put(struct sk_buff *skb)
 {
@@ -5167,6 +5168,7 @@ static inline bool skb_ext_shared(const struct sk_buff *skb)
 static inline void __skb_ext_put(struct skb_ext *ext) {}
 static inline void skb_ext_put(struct sk_buff *skb) {}
 static inline void skb_ext_reset(struct sk_buff *skb) {}
+static inline void skb_ext_scrub(struct sk_buff *skb) {}
 static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
 static inline void __skb_ext_copy(struct sk_buff *d, const struct sk_buff *s) {}
 static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_buff *s) {}
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9c03cd7c63af..a479e25de564 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -83,6 +83,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/psp/types.h>
 #include <net/dropreason.h>
+#include <linux/bpf.h>
 #include <net/xdp_sock.h>
 
 #include <linux/uaccess.h>
@@ -6290,7 +6291,8 @@ EXPORT_SYMBOL(skb_try_coalesce);
  * operations.
  * skb_scrub_packet can also be used to clean a skb before injecting it in
  * another namespace (@xnet == true). We have to clear all information in the
- * skb that could impact namespace isolation.
+ * skb that could impact namespace isolation. Note that BPF skb extension is
+ * meant to carry information across namespaces by design.
  */
 void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 {
@@ -6298,7 +6300,7 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->skb_iif = 0;
 	skb->ignore_df = 0;
 	skb_dst_drop(skb);
-	skb_ext_reset(skb);
+	skb_ext_scrub(skb);
 	nf_reset_ct(skb);
 	nf_reset_trace(skb);
 
@@ -7307,6 +7309,24 @@ void __skb_ext_put(struct skb_ext *ext)
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
+#if IS_ENABLED(CONFIG_BPF_SKB_EXT)
+		if (id == SKB_EXT_BPF)
+			continue;
+#endif
+		skb_ext_del(skb, id);
+	}
+}
+EXPORT_SYMBOL(skb_ext_scrub);
+
 #endif /* CONFIG_SKB_EXTENSIONS */
 
 static void kfree_skb_napi_cache(struct sk_buff *skb)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b3887c42adfd..cf093b0d66c5 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1540,8 +1540,6 @@ void udp_splice_eof(struct socket *sock)
  *
  * We need to preserve secpath, if present, to eventually process
  * IP_CMSG_PASSSEC at recvmsg() time.
- *
- * Other extensions can be cleared.
  */
 static bool udp_try_make_stateless(struct sk_buff *skb)
 {
@@ -1549,8 +1547,8 @@ static bool udp_try_make_stateless(struct sk_buff *skb)
 		return true;
 
 	if (!secpath_exists(skb)) {
-		skb_ext_reset(skb);
-		return true;
+		skb_ext_scrub(skb);
+		return !skb_has_extensions(skb);
 	}
 
 	return false;

-- 
2.43.0

