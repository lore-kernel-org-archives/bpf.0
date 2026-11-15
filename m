Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794737961;
	b=WyO0dUDsVVHNwhMlmBevHV5XXsTBNDB7pxXzUHr148WVZmVVYjVwuR9XKNjq4ixkKCvB
	 uVG/HQs8jw2thvVYcF+DvQwXO3cdIa3YEqBqaZHLt7d65Mx0hLZsZRdUTktkSNu9Dp5M6
	 DNv47Ty5f0aov686KTcQhj//A9F5QnY3pj9322E7xTtJGPYACN+5aBIQZY/iQr07EZP/R
	 wxB5aLtbKSx/PFBznEUENWBWrJkFXPm7NJBY47N7MqCyH4gC9Wo3eAZ2+RPN9a45EPehw
	 KN2pXf2qS3IEYp1Wjne15j5AgIj+Ql4iIMrRWHhrbE/2xohHCje6FcgUljEhN2OaG3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794737961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qUywjH1mXMA5ZdVLI5mxTaeNIn4AcR8Pm32/OR31sAQ=;
	b=sy8qTbcj1YtzYHtyq4jx/p6/9XdfmSiZ3NwN1e2gqqfeNordsDALnLyVo3YDRaG0UfXl
	 Wj0v5ilMo+qhzy/L77u8JyOjqvzNQpkTrNl4rAZiJoIeD4ZmnTk/YLrQfhKm+8XPRA0D9
	 E8Xp8lLwFKFh1LVKrC6YBtbTZRWX953McT1ADGYjX23KvebxJOcu8NWPV+dDpSn079Kl7
	 q5qoyBmM1xsZJQ275m1jda64Oed9LJryL2jaRHEXKldIr+zGp1yne8RYDur2eclKpCxs/
	 2mum1inVp0DYuWMnQ3tLBjWEcqRcz2OudwqHqjkxOpO0WohQhS5mnT9RJ3HtuuuuYNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=wpleSygf;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F7606A32C
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 10:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C0F7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=wpleSygf
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9495e8ae239so242143785a.2
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 02:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794737960; x=1795342760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qUywjH1mXMA5ZdVLI5mxTaeNIn4AcR8Pm32/OR31sAQ=;
        b=wpleSygfirmdrkvBklDi3OhjJQ6nlsbgxjcBqeiYeodHcTTqanWc2odN9Zq2wP66rh
         QCir5pjHaqIaK6J7ZQtSZNicwxH3DINYH/l5YjrZ9xQ3ISaEvacW5BeJLdxzOkMKsSKu
         V/Z0eiEJf4fxOCFYhTJTuvix624F8OGbXIUlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794737960; x=1795342760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qUywjH1mXMA5ZdVLI5mxTaeNIn4AcR8Pm32/OR31sAQ=;
        b=EPH7iY6Nt+qG1IVDQpbNBk/O8ofN50kNzycbfKiIbk4+4JUIFbp7rySVGDhooh4FJm
         +yzj3dAANgUhQpq9hVgRpwGVNDCtBxGS5d6UgDVIPhusbk1uFK/w3vAXvvaNLjolxEA1
         8QOg7/Q3tJ1tpR0HdQiHOwZtnEM9qXlYHzyF8wyLf2nf33wOs3+ByL0bp7oBUjBXqL/6
         Ch6mBz/XxD1vyMP90vpFhdSE2RaORWIfC9Ibm6LLgaculvKYYojO2Xqd0CB04KcC/0IH
         iL85+18Ng+Jv0Ahs0O0Wu+yOHcYgsv5mgQwT5LAYm0SDaKsN2K+r8oyZ+ctCb1KVE+jo
         ol6Q==
X-Forwarded-Encrypted: i=1; AL+hErHuTyIlZBEZaF+JowgbjGGwc/Hu1tiFFsm6/SoI9FM5OSuWwBJG3Y7bcjRDFt05unocnuA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bsRdbW6lrazPmQ6+ArAVfIkYpS7PCWqYMxhWZI9z0Ab0n1hM+
	qN5jbjLNF0KLLeNfR84ff4Wp7bSraHy1PsjkFjFwvpy6jM7oxA517SVahPKpCnTN4g==
X-Gm-Gg: AYBFou09ksUoGbwxlJUsiN5QBZxCsEsdiVUYzH1ekBHrI087NxAd9SpcEearC0Wnhpf
	VuqTuZBZh5Plclj1Urlqq8MAm7L3R3nD1euL5Pml+fZWsFQx56AQF3DKH7bt7jOlhNZ7s5San86
	3+MDlq/JYylG564cabr30TAoJiJBLVy4ReBpLar1GNxYWDBjcHSh5aXHff+oXO9gG7f9ro4uMfU
	dYjdT3hOC/eycf3EAPjcJPys8lQfXe+hzcg+1FSAGYXK98oCeeQQnszsL4HiOJshzH7uHNArxLh
	XFb5VFeNaOaHLarc8C6kvRc742yKYm9rgGOq0oBRfSS66Rv1wdZU566jl4tFqH3nwbacHtWUb6Z
	6CTMBT2zIQT0FHo6i27zGGktddRSN7WnYO4MdSOTZnT3uoDSBCjG8S+/TpFdEc38uUfPEf+EYTt
	luMrAHa8GremhSgaIddS93PtF2TFUwMzxnG23GGSmAeydQFFQ0xCOmpW++CVi5bzUjCZxCSnBgg
	mYwmq68ClFA7JYMiIqRczfmrPvZW9c8yWVMPybgwwumOequq4Le6M1YBkRO1x/W+PvVxiixeiwl
	gyXoKtnoyB0K05iwUZwkY2lgC5zWpNTPuB/O0+k55UYjjFeeOGy+dhuiii9AXNHRB6nRcK0sKZq
	r
X-Received: by 2002:a05:620a:880a:b0:939:f49c:1b30 with SMTP id af79cd13be357-9494bb77a5amr1224675585a.13.1794737960471;
        Sun, 15 Nov 2026 02:19:20 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c6025f5sm592337085a.5.2026.11.15.02.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 02:19:19 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net-next v3 2/4] net: dst: keep the LWT metadata of a dropped route
Date: Sun, 15 Nov 2026 05:19:09 -0500
Message-Id: <CORE-9NOG.v3.r0.20261115050625-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CORE-9NOG.v3.r0.20261115050625@mojatatu.com>
References: <CORE-9NOG.v3.r0.20261115050625@mojatatu.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found while working on the two producers that steer a packet to another
device's neighbour, fixed later in this series. Both release the route
dst on the way, and a route installed with an encapsulation carries the
parameters a device downstream needs: an ip or ip6 encapsulation holds an
ip_tunnel_info, where skb_tunnel_info() reads it, and an xfrm encapsulation
holds an xfrm_md_info, where skb_xfrm_md_info() reads it. The release
discards them, so a tunnel or an xfrm interface downstream has nothing left
to build the outer header with, or to select its if_id.

The Fix:
Add skb_dst_drop_keep_metadata(), which moves those parameters onto a
metadata dst of its own before the route is released. The ip and ip6
payload is copied field by field; the route's dst cache belongs to its
lwtstate and is shared by every packet that uses the route, so it is not
duplicated: the copy starts with an empty cache, which costs the tunnel one
route lookup. The xfrm payload keeps the route itself, because the xfrm
lookup reads its family; the counted reference the skb already holds moves
into the metadata dst, which releases it once it has been consumed.

The helper owns the whole operation: a dst that is not a route is not
dropped, because a metadata dst is the encapsulation itself. Its callers
must not transmit with the stale route, so a failed copy is reported and
the skb is left untouched for its owner to drop.

Conditions to recreate the bug:
Install a route with an encapsulation (ip route add ... encap ip id <id>
dst <remote>, or encap xfrm if_id <id>), steer a packet to another
device's neighbour with a netdev egress fwd rule or
bpf_redirect_neigh(), and release the route dst before neigh_xmit() hands
the packet on. A tunnel or xfrm device in the path then finds no
parameters in skb_tunnel_info() or skb_xfrm_md_info() and drops the packet
instead of using them.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v2 -> v3:
- Document the `Return:` value of skb_dst_drop_keep_metadata() in its
  kernel-doc comment. Caught by NIPA CI.

 include/net/dst_metadata.h |  1 +
 net/core/dst.c             | 76 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index 02fffbb85099..a7808d42f779 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -138,6 +138,7 @@ struct metadata_dst *metadata_dst_alloc(u8 optslen, enum metadata_type type,
 void metadata_dst_free_percpu(struct metadata_dst __percpu *md_dst);
 struct metadata_dst __percpu *
 metadata_dst_alloc_percpu(u8 optslen, enum metadata_type type, gfp_t flags);
+bool skb_dst_drop_keep_metadata(struct sk_buff *skb);
 
 static inline struct metadata_dst *tun_rx_dst(int md_size)
 {
diff --git a/net/core/dst.c b/net/core/dst.c
index 092861133023..9c80c225cbfd 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -353,3 +353,79 @@ void metadata_dst_free_percpu(struct metadata_dst __percpu *md_dst)
 	free_percpu(md_dst);
 }
 EXPORT_SYMBOL_GPL(metadata_dst_free_percpu);
+
+/**
+ * skb_dst_drop_keep_metadata - release a route dst, keeping its LWT metadata
+ * @skb: buffer whose dst is to be released
+ *
+ * A route installed with an encapsulation carries the parameters a downstream
+ * device needs in dst->lwtstate, where skb_tunnel_info() and skb_xfrm_md_info()
+ * find them. Releasing such a route would discard them, so move them onto a
+ * metadata dst of their own first. The route is not duplicated: the copy
+ * starts with an empty cache, and for xfrm the route is kept because the
+ * lookup needs its family.
+ *
+ * A dst that is metadata is left in place.
+ *
+ * Return: true if the skb is left free to be sent, either because its dst is
+ * metadata already or because the LWT metadata was moved onto a new dst;
+ * false if no copy could be allocated, in which case the caller must drop the
+ * skb.
+ */
+bool skb_dst_drop_keep_metadata(struct sk_buff *skb)
+{
+	struct dst_entry *old = skb_dst(skb);
+	struct metadata_dst *md_dst = NULL;
+
+	if (!skb_valid_dst(skb))
+		return true;
+
+	if (old->lwtstate && old->lwtstate->type == LWTUNNEL_ENCAP_XFRM) {
+		struct xfrm_md_info *src = lwt_xfrm_info(old->lwtstate);
+
+		md_dst = metadata_dst_alloc(0, METADATA_XFRM, GFP_ATOMIC);
+		if (!md_dst)
+			return false;
+
+		/* Count the route so it outlives the skb, then move the
+		 * reference into the metadata dst.
+		 */
+		if (!skb_dst_force(skb)) {
+			metadata_dst_free(md_dst);
+			return false;
+		}
+
+		md_dst->u.xfrm_info.if_id = src->if_id;
+		md_dst->u.xfrm_info.link = src->link;
+		md_dst->u.xfrm_info.dst_orig = old;
+		skb_dstref_steal(skb);
+		skb_dst_set(skb, &md_dst->dst);
+		return true;
+	}
+
+	if (old->lwtstate &&
+	    (old->lwtstate->type == LWTUNNEL_ENCAP_IP ||
+	     old->lwtstate->type == LWTUNNEL_ENCAP_IP6)) {
+		struct ip_tunnel_info *src = lwt_tun_info(old->lwtstate);
+		struct ip_tunnel_info *dst;
+
+		md_dst = metadata_dst_alloc(src->options_len,
+					    METADATA_IP_TUNNEL, GFP_ATOMIC);
+		if (!md_dst)
+			return false;
+
+		dst = &md_dst->u.tun_info;
+		dst->key = src->key;
+		dst->encap = src->encap;
+		dst->options_len = src->options_len;
+		dst->mode = src->mode;
+		memcpy(ip_tunnel_info_opts(dst), ip_tunnel_info_opts(src),
+		       src->options_len);
+	}
+
+	skb_dst_drop(skb);
+	if (md_dst)
+		skb_dst_set(skb, &md_dst->dst);
+	return true;
+}
+EXPORT_SYMBOL_GPL(skb_dst_drop_keep_metadata);
-- 
2.43.0

