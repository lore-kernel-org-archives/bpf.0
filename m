Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516062;
	b=3jFs0l/hD3HeNOgTJbrYfJX9RbJXFDb+koJ1MG9WjSTLFfCBxbPVMuuWlV28sg16gIOC
	 XqVJKh3phIt3/HOrFpqrWndCu54foavEp0WpruzBhPZVbD5cx57hwXvwDB+uNCdcY9OJ5
	 Hj4TsvsUVyOkZQBOPboRmPxwekwybhZh3lDmz62/3sqAGfmHLiGlseMLW0B7NmfiWPt1K
	 l63lxfSKzuoet/BwpG3RFsO55eCuFD6jTNEQLIwaU4BQfxOgoRbaxcYM1zKst7UOcOuqA
	 PG4WLKq6zBRj3LtP4+0/amMSVobdZ2rRCOIM15sdRS7sJO5px6zBvgJfTTx2SbzQqjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Byn2HhOPb19dBjcx3Tbrg9Im7VPacdPGrEuEzofnAl8=;
	b=zqj9VTGxrl93konW+N6mu69XeMIX6z/XnMxJJNmm0j7J3QPELyFWRC2mbtUC8HnCkJd7
	 G3HkLSKdIyMbhzA+OsF3l1hwLiw7TMh7U/W6rFd4WJrw73jX8F+uF9XWgvYhuECltEm2E
	 jDWDmGUVjzB6WsLWpofA/2uG8dXCcFohM+YsqorLVrAEdiHGvWmwt3lw0J0q11toJB4IB
	 b3ahW7ea7yW9hg9thpQgq5wnreD6/DqnXFXJ5lQxACqUfbuNMQQG1zmr8lBwHP6OcJwIh
	 m6VQQr4x3iEYiKq9S2b0z2WKSUEjpB7hdoVcWFMehR2BndUrIbjoVSqLh6jz5lEX4Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=yHrt5zki;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCA606A89B
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 20:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40DCA606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=yHrt5zki
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53665358476so1950971cf.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 12:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794516061; x=1795120861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Byn2HhOPb19dBjcx3Tbrg9Im7VPacdPGrEuEzofnAl8=;
        b=yHrt5zkiYxyh/0WxMr6yVueyeQv5MaHKHfPsU+myfUx6yZPMSV8Fu8W4BCVojnXbEc
         BiAwRt8JqQEJNG0dqY+n8VMyQOYvY4hv+YZDpW1H4Sq/Bawe4wtnfUgd5v4krZ+tA5tR
         eqkzOw+dTmpCr55DFj9+ZJHZDI7HgkIyeymR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516061; x=1795120861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Byn2HhOPb19dBjcx3Tbrg9Im7VPacdPGrEuEzofnAl8=;
        b=qCfGWp/rn7lUpB8oi/tx0GjFM8JHCaO+5/LCB9Q1yy6QzJq0BTrecI5rOXfbBLT/OL
         kZsZChM6mXtmfr3hUlxp2nLUbpSrtV1OuU+B1EUIB9tOxYnz3dIp0fAql8MfMvQoA4JZ
         B+8TUtsjU+eGncIPLr7THjA7e2yf7m6eZ4H6Jg04Lfg+e1EdnFpsyeUtFtlZf+dtOVac
         YmqgU4HkY6ZmzMPLMlsOILnlmPCtFQOR8h4Gnhdb6Lwf5HvZiAifRDg1pfT0cyephwsg
         o0nSAlCGl2uxBjWn144HpQPv3H8CrxNqSE9XQJRS09yU6qp/2Mi9xIjnmouO0i6LP8jX
         f2NQ==
X-Forwarded-Encrypted: i=1; AL+hErFvO2Zdy21u74l9lmGVr8AjCqK2nXMHWUc4C+IkpHDyF/haEFreQE+ydU4xJRixqDFuPnw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kmaKPFJvwDPPklhJmEOLWdZshTR9LaAJQuu58qOi/suhDDHMW
	RyH6zposrek2RrLX5nA2MqrVFcuoRu0NSN/3ihLotwitRUrak9RfpUNA7dww0R4+GQ==
X-Gm-Gg: AYBFou1J5vj/HwWsLmTOQYlz+ZAU+8C5IHtxTdHYzUrpgWwwU+xUcrYTvOzT3XmO2sB
	b2TSUgbZ/Oey2/qpEj8bobW2/nvjuNbhqQOJJI5L4MJgddWnXsGEf6wfb7pv9maPdc/7hFleMvl
	zElChdJNW0MWSEErFzfZAlFHZ/6cUHRvzG1dpB2OskM/HDnGPXYda+SRe+o4enbbF7lwgPq4ndj
	z86wBBnYEu1XJKq6DCtda1zFBWRI3h7jrVhbSSxy+cH2PqxfGuiqyg2Y1RrL6uG7Ukru3T+sW5s
	J/QvE4rawSL3RjHTaeImOAbmXtuY76jSnQkIG9omS3vhJtqbD9yGTZbzthLpSZlbLMr2dKbgr6w
	izgpjGd8m2vdm4njkxg3p2w31JhuXEQ74wV8Hsf+Aep7Hhq7As0dNMXdA9SeEqhuIG3LW321lIA
	OSL4JmjIDwiwlIVbvR+piUOqmr7EJKKxPgNo1EZ1iGET3J3FEFhEofzXtHzADIKCx2wUjG2RueC
	NukCMojvw9qxx86MN49j7tTOEGHZtvV3yBvFTRTijio1MsbKuSXU+x6rxnmgJNa8XhmeeqaeV5s
	+clhvEzwh6ayEtr3Pe+O5z9MqQvl8OtYrkoLtO493foKgROfPEAc5A8tzLzgsqAhL1KfDlZ/v7k
	=
X-Received: by 2002:a05:622a:1214:b0:535:1b50:48a6 with SMTP id d75a77b69052e-55ac366a4e1mr10884361cf.6.1794516061226;
        Thu, 12 Nov 2026 12:41:01 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d61888sm4452116d6.20.2026.11.12.12.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:41:00 -0800 (PST)
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
Subject: [PATCH net-next v2 2/4] net: dst: keep the LWT metadata of a dropped route
Date: Thu, 12 Nov 2026 15:40:47 -0500
Message-Id: <CORE-9NOG.v2.r0.20261112151659-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CORE-9NOG.v2.r0.20261112151659@mojatatu.com>
References: <CORE-9NOG.v2.r0.20261112151659@mojatatu.com>
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
 include/net/dst_metadata.h |  1 +
 net/core/dst.c             | 72 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index f45d1e3163f0..32d74b4f009f 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -136,6 +136,7 @@ struct metadata_dst *metadata_dst_alloc(u8 optslen, enum metadata_type type,
 void metadata_dst_free_percpu(struct metadata_dst __percpu *md_dst);
 struct metadata_dst __percpu *
 metadata_dst_alloc_percpu(u8 optslen, enum metadata_type type, gfp_t flags);
+bool skb_dst_drop_keep_metadata(struct sk_buff *skb);
 
 static inline struct metadata_dst *tun_rx_dst(int md_size)
 {
diff --git a/net/core/dst.c b/net/core/dst.c
index 092861133023..daa003979d59 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -353,3 +353,75 @@ void metadata_dst_free_percpu(struct metadata_dst __percpu *md_dst)
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
+ * A dst that is metadata is left in place. False means no copy could be
+ * allocated and the caller must drop the skb.
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

