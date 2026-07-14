Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E3417BCD
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051326; cv=none; b=t/WPEpHwfne9IX67v1uXK5GSExTmBPOSBumlWNGjEL/8krnB5HwcvsvKQHGToK+deZq9MDVnmb/FPNbnrWkM/tjlfxju+tSAcXWTK3I2+vo2VTKtzLINa19CRrNfKbx5i9L/3Tr+b5nURJH4tWBr60Yw6QOdnvtjVVaMpyu2JW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051326; c=relaxed/simple;
	bh=EidGszEb5KrmtYB1G0qzSsZ4bqHfDmFP4nRsmdDsygU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OAxEH4rlqgAnqc1dlY0rYJzD7tXNP0kiQcPCbrIe43XZxRvCyZr75qp4+OKiNFATFxxuETIOTjnKzf1tG9ippc2ITD5PFxqrTu2kchGIzyBG8r2hAHXQT6ei/85mntsyNhAYLMqXGH9x9lc+Vq5XjTVLvKMWm9IZLO6fYacUKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aXJ6bmMS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aXJ6bmMS"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so10220495e9.2
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784051312; x=1784656112; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WkHqkJyNEGXFCJ4NqDAcW25mglITzMJgSa1PEerCSMI=;
        b=aXJ6bmMSTl0gC5E3Dv5yuLIjCVkvma33dkZysmTIFZO50fhcOwllRMb8prOOB/J/eF
         /6avSNWjVHsWySBDVbWs3nQuFyWYm21yPdz/iiEg+vh5RaemgB6ikKvcGto9/drttPWj
         5w/IzLb040P/BD6HZxSTa+dUV8uodbu3cja3gKSPQ/rsI7sp8ZNKdm4s1bDm8BtV78vH
         LeB4m3TVu9cK0662JP/YO8XamNuNB5R3SU2xQ48Kb/TgTMm3aasC60Gtl95s3rDXcy9z
         dAtDPzycVqtKIkawfjjaE7879S3LaM0tpm2lTEhi3IFH/EfojkNROrPaONJXtJDy7Uu5
         4M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051312; x=1784656112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WkHqkJyNEGXFCJ4NqDAcW25mglITzMJgSa1PEerCSMI=;
        b=O/5iAOHKSyOjLgTfaCSfR1JU42yzPmZi0DG6milkHChhrzqoBH4M7Pdtp7XxD80JP0
         KflN+Ewh7aFLtllcdXBg0Yp1wAMBS+jwy/0fTiNveQ5t1pFg8VUqAJ9m9frWM8qQ8MJo
         06yrx6LaD1pIEQKyggK1/b8+WU6anr1GXGQVrpy4JHMVNihfVIUAWznbScZJx70dBYG2
         w6cBcPyhIlvfGKgMiBU0+N23ECaRk7uIqv953MYWzymsoUOW1GQmn3xY3dDqe1vFhoBf
         +qk+e/Kjifm558E4rih3KAIUb2+yQCX1pQws3Jwmxw2c4PJMX3kVJgrDTZvZeOFOcC0I
         FGOQ==
X-Gm-Message-State: AOJu0Yzum3LSbLc4BEirsoGTNj/MlrEMxc4CbEpPTAp2Mt0F8MLO6Doj
	sHOMSZ3psMP5aMvT0UubbfonQMymLnYAlU59i4TmuB8McFp/tBz8tSuujkgy2N4edV4=
X-Gm-Gg: AfdE7cmqPTa8+zqNgN7IfB+8d/CTFIsN6kKnYj1S4KIq7P9YKGhlRuyUStkoXRY+K9M
	J82xpnh/8CRG0wYvsXd/txTVeE8lGrHA8eO4Jh080WPfGwMO5EXoy3ijtCwcI4PzgQK/HQV8giH
	ua/Ai/E7O8Ps7TFPIB2SalEZE/HwT7mB+S0MzpjB1g5AxC06QrtID8ZMThsnjK00Tv2FMiIVivF
	bTWKajuLh2uLnehTjeSlAgJdJCq1B47uL2La6uYVwL0x2DkLnoKaD6vv30XO617Jqo2JUcdQqrp
	OFIChu6q52I5+omK6nSoMWORBtVzn0xTEHnPdUHIjin9ciWnYVl6PMdLelTW2nqNlxpKjrE/pU8
	ZO3hd8R0M+9vYs4XNUGPXBA8/kOOX+5Nnr9rm5riAYxbMX5hSY3L4j117QtVuaOpGBWrSxGHkWG
	4WJLMfs1TdKE59Gwovl1DFtECqbIXalOzhy6fDRk+Ubsv2ZJA=
X-Received: by 2002:a05:600c:8b52:b0:493:fa66:4839 with SMTP id 5b1f17b1804b1-493fa6649e4mr135216555e9.3.1784051311571;
        Tue, 14 Jul 2026 10:48:31 -0700 (PDT)
Received: from cloudflare.com (93-57-92-86.ip163.fastwebnet.it. [93.57.92.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950871d1bdsm90598065e9.1.2026.07.14.10.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:48:30 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 14 Jul 2026 19:48:22 +0200
Subject: [PATCH RFC net-next 3/6] bpf: Allow skb extensions to survive
 packet scrubbing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-bpf-meta-inside-skb-ext-v1-3-5871c07a8dd6@cloudflare.com>
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
In-Reply-To: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15.2

skb_scrub_packet() drops all skb extensions unconditionally via
skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv,
vxlan_rcv, etc.) and cross-netns forwarding (dev_forward_skb).

This makes it impossible for a BPF program to pass metadata via
bpf_skb_ext through a tunnel or across a netns boundary. The extension
is always lost at the scrub point.

Introduce skb_ext_scrub() which consults each active extension before
discarding it. Extensions that request preservation are kept while the
rest are torn down. When the extension slab is shared with clones, COW
ensures isolation. Replace the skb_ext_reset() call in
skb_scrub_packet() with skb_ext_scrub().

Expose the opt-in mechanism to BPF via the BPF_SKB_EXT_F_NO_SCRUB flag
for bpf_dynptr_from_skb_ext(). A program that sets this flag when
creating the extension signals that its metadata should survive
scrubbing.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf.h      |  1 +
 include/linux/skbuff.h   |  2 ++
 include/uapi/linux/bpf.h |  3 +-
 net/core/filter.c        | 11 +++++--
 net/core/skbuff.c        | 82 ++++++++++++++++++++++++++++++++++++++++++------
 net/ipv4/udp.c           |  2 +-
 6 files changed, 86 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6b918a5b61bf..a46ca53c5b27 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4214,6 +4214,7 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 #ifdef CONFIG_BPF_SKB_EXT
 
 struct bpf_skb_ext {
+	u64 flags;
 	u8 buf[CONFIG_BPF_SKB_EXT_SIZE] __aligned(8);
 };
 
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 584d8440d352..66afa5489007 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5063,6 +5063,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
 void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_put(struct skb_ext *ext);
+void skb_ext_scrub(struct sk_buff *skb);
 
 static inline void skb_ext_put(struct sk_buff *skb)
 {
@@ -5132,6 +5133,7 @@ static inline bool skb_has_extensions(struct sk_buff *skb)
 static inline void __skb_ext_put(struct skb_ext *ext) {}
 static inline void skb_ext_put(struct sk_buff *skb) {}
 static inline void skb_ext_reset(struct sk_buff *skb) {}
+static inline void skb_ext_scrub(struct sk_buff *skb) {}
 static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
 static inline void __skb_ext_copy(struct sk_buff *d, const struct sk_buff *s) {}
 static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_buff *s) {}
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3eee4467422d..02da170205de 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7734,7 +7734,8 @@ struct bpf_insn_array_value {
 
 /* Flags to control bpf_dynptr_from_skb_ext() behavior. */
 enum {
-	BPF_SKB_EXT_F_CREATE = (1ULL << 0),
+	BPF_SKB_EXT_F_CREATE	= (1ULL << 0),
+	BPF_SKB_EXT_F_NO_SCRUB	= (1ULL << 1),
 };
 
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/net/core/filter.c b/net/core/filter.c
index b0b039c64b02..eca07976ab1c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12319,6 +12319,7 @@ __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
  * @skb_: socket buffer to attach the extension to
  * @size: dynptr size in bytes, 0 for maximum (BPF_SKB_EXT_SIZE_MAX)
  * @flags: BPF_SKB_EXT_F_CREATE to create/COW (read-write), 0 to find (read-only)
+ *	   BPF_SKB_EXT_F_NO_SCRUB to keep the extension across skb_scrub_packet()
  * @ptr__uninit: dynptr to initialize
  *
  * Return:
@@ -12335,14 +12336,16 @@ __bpf_kfunc int bpf_dynptr_from_skb_ext(struct __sk_buff *skb_, u32 size,
 	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)ptr__uninit;
 	struct sk_buff *skb = (struct sk_buff *)skb_;
 	bool create = flags & BPF_SKB_EXT_F_CREATE;
+	bool no_scrub = flags & BPF_SKB_EXT_F_NO_SCRUB;
 	struct bpf_skb_ext *ext;
 	bool exists;
 	int err;
 
-	if (flags & ~BPF_SKB_EXT_F_CREATE) {
-		err = -EINVAL;
+	err = -EINVAL;
+	if (flags & ~(BPF_SKB_EXT_F_CREATE | BPF_SKB_EXT_F_NO_SCRUB))
+		goto error;
+	if (!create && no_scrub)
 		goto error;
-	}
 
 	if (size > ARRAY_SIZE(ext->buf)) {
 		err = -E2BIG;
@@ -12367,6 +12370,8 @@ __bpf_kfunc int bpf_dynptr_from_skb_ext(struct __sk_buff *skb_, u32 size,
 	}
 	if (!exists)
 		memset(ext, 0, sizeof(*ext));
+	if (no_scrub)
+		ext->flags |= BPF_SKB_EXT_F_NO_SCRUB;
 out:
 	bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB_EXT, 0, size);
 	if (!create)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4efc06c426b2..46b5bd49a110 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -83,6 +83,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/psp/types.h>
 #include <net/dropreason.h>
+#include <linux/bpf.h>
 #include <net/xdp_sock.h>
 
 #include <linux/uaccess.h>
@@ -6278,7 +6279,7 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->skb_iif = 0;
 	skb->ignore_df = 0;
 	skb_dst_drop(skb);
-	skb_ext_reset(skb);
+	skb_ext_scrub(skb);
 	nf_reset_ct(skb);
 	nf_reset_trace(skb);
 
@@ -7252,6 +7253,20 @@ void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id)
 }
 EXPORT_SYMBOL(__skb_ext_del);
 
+static void skb_ext_put_each(struct skb_ext *ext, unsigned int skip)
+{
+#ifdef CONFIG_XFRM
+	if (!(skip & (1 << SKB_EXT_SEC_PATH)) &&
+	    __skb_ext_exist(ext, SKB_EXT_SEC_PATH))
+		skb_ext_put_sp(skb_ext_get_ptr(ext, SKB_EXT_SEC_PATH));
+#endif
+#ifdef CONFIG_MCTP_FLOWS
+	if (!(skip & (1 << SKB_EXT_MCTP)) &&
+	    __skb_ext_exist(ext, SKB_EXT_MCTP))
+		skb_ext_put_mctp(skb_ext_get_ptr(ext, SKB_EXT_MCTP));
+#endif
+}
+
 void __skb_ext_put(struct skb_ext *ext)
 {
 	/* If this is last clone, nothing can increment
@@ -7263,18 +7278,65 @@ void __skb_ext_put(struct skb_ext *ext)
 	if (!refcount_dec_and_test(&ext->refcnt))
 		return;
 free_now:
-#ifdef CONFIG_XFRM
-	if (__skb_ext_exist(ext, SKB_EXT_SEC_PATH))
-		skb_ext_put_sp(skb_ext_get_ptr(ext, SKB_EXT_SEC_PATH));
-#endif
-#ifdef CONFIG_MCTP_FLOWS
-	if (__skb_ext_exist(ext, SKB_EXT_MCTP))
-		skb_ext_put_mctp(skb_ext_get_ptr(ext, SKB_EXT_MCTP));
-#endif
-
+	skb_ext_put_each(ext, 0);
 	kmem_cache_free(skbuff_ext_cache, ext);
 }
 EXPORT_SYMBOL(__skb_ext_put);
+
+static unsigned int skb_ext_no_scrub(struct skb_ext *ext)
+{
+	unsigned int keep = 0;
+
+#if IS_ENABLED(CONFIG_BPF_SKB_EXT)
+	if (__skb_ext_exist(ext, SKB_EXT_BPF)) {
+		struct bpf_skb_ext *bpf = skb_ext_get_ptr(ext, SKB_EXT_BPF);
+
+		if (bpf->flags & BPF_SKB_EXT_F_NO_SCRUB)
+			keep |= (1 << SKB_EXT_BPF);
+	}
+#endif
+	return keep;
+}
+
+static int __skb_ext_scrub(struct sk_buff *skb, unsigned int keep)
+{
+	struct skb_ext *old = skb->extensions;
+	struct skb_ext *ext;
+	int i;
+
+	if (refcount_read(&old->refcnt) == 1) {
+		skb_ext_put_each(old, keep);
+		ext = old;
+	} else {
+		ext = skb_ext_maybe_cow(old, keep);
+		if (!ext)
+			return -ENOMEM;
+		skb->extensions = ext;
+	}
+
+	for (i = 0; i < SKB_EXT_NUM; i++) {
+		if (!(keep & (1 << i)))
+			ext->offset[i] = 0;
+	}
+	skb->active_extensions = keep;
+	return 0;
+}
+
+void skb_ext_scrub(struct sk_buff *skb)
+{
+	unsigned int keep;
+
+	if (likely(!skb->active_extensions))
+		return;
+
+	keep = skb_ext_no_scrub(skb->extensions);
+	if (keep && !__skb_ext_scrub(skb, keep))
+		return;
+
+	skb_ext_reset(skb);
+}
+EXPORT_SYMBOL(skb_ext_scrub);
+
 #endif /* CONFIG_SKB_EXTENSIONS */
 
 static void kfree_skb_napi_cache(struct sk_buff *skb)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 70f6cbd4ef73..08357f2621da 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1536,7 +1536,7 @@ static bool udp_try_make_stateless(struct sk_buff *skb)
 		return true;
 
 	if (!secpath_exists(skb)) {
-		skb_ext_reset(skb);
+		skb_ext_scrub(skb);
 		return true;
 	}
 

-- 
2.43.0

