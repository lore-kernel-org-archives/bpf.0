Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334711;
	b=dMwskS74edtGgQssbBVQkaNtCskmPFsq7ShzjQjr34g5hDvTcuZ0jcaiZn6mV62u84kv
	 dmu4VoECTqzbdiHy2ejktQ/vEhurg2KBSEPTHGV+oFCtpkkeYv3h5/0k8YAu4E8uZ0QAS
	 ONxb/RHRU5RDrX4gqL6RVD3STRt1stWEHxeuIgpfkm/0fsw8zmMSl5n3eB1TjzMnBV57M
	 IZEBUFtWsbU8Xg7uMMl1ntEoMn/XCb/yvMXqbTcdiEbRvdsnRb8BsjLwU9INCHprXUxD0
	 6KIzKliepPygRVEYVw+ilXxtUIkHWs3uko2IvIMg1egKYvATesgnZjPplZQGq4JJLYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ZziXw8Mhu/MliXEzo41WRhscDvJYaH0eawGMV1Y+J3k=;
	b=Wu/Neyj8DKkoQom0LFQLO++i1pHq3fupNDxKslZKIUFC2FNZX5DNVidKLo3gQbeIrJ4A
	 +0fXTJv5vMtL6lb7EHeUjTdvLTdb9lZgYmglCgPbO88d+/Nfu2mckFafgZ4oGwm7ISyux
	 7pN6Zsy8s2DoiCQYp+7PLToBtWy2bc48aoORTALV2TdmpR0Cs0vBakAQIU/NhxG9PaWfk
	 IQTDjpHOdn8ecPuQlSU6o/vFgtbWhGyFwxzBtFXY7F7jUBVV8Vod3C5DMiOTOmgqGO1k9
	 0eIKDAmk5UlhySxTNLpp4tjUvUmoSjRDt/mvDHE1ioHep3BLgYE7mmiRFHSBjqqexbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bn+lZmgA;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DF606A325
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 520DF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bn+lZmgA
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a05b68f851so1392768b3a.1
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793334711; x=1793939511; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZziXw8Mhu/MliXEzo41WRhscDvJYaH0eawGMV1Y+J3k=;
        b=bn+lZmgA+J+K0XjBuCBZNUoxB3sifXpY12KNQK8KWDfMsytY/wKL2pHp1dJSeGaE7D
         ZEQazoGfio2Txj+JSTcIdJp8Go/uOHd/z/DwJda2mi+om3+f7rBQoCQjudXJzEtzSRbU
         cWGw8il0bjvGIaTWl3bxtswJiBGYmiT2RsV5EssKW18Rx9648jrtMBg8BMZ4bLo3ZqwP
         sB6MXxj2q/+KqtpYAfNKggECAH7Wdd82b7Sl5NZls6i2eWJ1WMouWQnM+ptnw/hfiHit
         ObpC5AdyslPLqOAFvuWsvcN74r/8beARAhhFgy8UE1fkPiglm5jiYEv5RQgilBA4E9sx
         PfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334711; x=1793939511;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZziXw8Mhu/MliXEzo41WRhscDvJYaH0eawGMV1Y+J3k=;
        b=Xm7/4WEUyLTteTeFqRQ2tfoYbz1IcrTm2WYX2QRPmlV/MeFmtvwJlqv3wj1T0T0TEp
         3GgBDQKrnuoCHZ/O/3bCcLEQLmM5ylUC6Vz6rN+sqg6x/YpYNNyFfjY4ujSxXGlPy/yd
         emVCiTw7d1PjmmMTHUO0DlLCoI687TMKn5KgT3MnfhFe6Y1BR0IHVtci9SIcTGFaHPHL
         5G5mkP6e0AxYtTfboZdcrUsPCR6JCdnE+qN3ilyk+xMf0JSqBo1PFHP8YNU2WHrf8hPB
         1cRdTbYyRP3MBdyjANnfLLBJDDToXsKhhq/zT8GOzgtC36VIl5S9slwGLsNh+BwnXqdt
         venA==
X-Forwarded-Encrypted: i=1; AKwUvBzw/RcVe1FLKPQzFCWH19ISFyktYJgMlTYoJ6O53rv9BZdiPeMehtds6f5N7uu3vv2FDZg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZBBFk+IQQAmwRcCmmvUSCY0tnsR+2OpkcbVmhnC6ElK4FHes5
	dgOMIwbMmqlfn83Rl4MATOSAM1wz/OIWDSME44YU7qkqo/4xmQABG0kYhjprOgOVx7Y07iL1MCv
	mPrTRVg==
X-Received: from pfbgi11.prod.google.com ([2002:a05:6a00:63cb:b0:8a0:4085:d831])
 (user=weiwan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a94:b0:3e1:8a37:bf1e
 with SMTP id adf61e73a8af0-3e928a78297mr835173637.42.1793334710498; Thu, 29
 Oct 2026 21:31:50 -0700 (PDT)
Date: Fri, 30 Oct 2026 04:31:44 +0000
In-Reply-To: <20261030043145.2185700-1-weiwan@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030043145.2185700-1-weiwan@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030043145.2185700-2-weiwan@google.com>
Subject: [PATCH net v2 1/2] net: Make PSP skb extension survive packet scrubbing
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
etc.) and virtual device forwarding/redirection (dev_forward_skb,
netkit_xmit, skb_do_redirect).

When a virtual device such as netkit is associated with a PSP device in
another network namespace via PSP_CMD_DEV_ASSOC, incoming PSP packets
decapsulated by psp_dev_rcv() lose their SKB_EXT_PSP extension when
scrubbed during redirection into the peer netns. Without SKB_EXT_PSP,
__psp_sk_rx_policy_check() rejects incoming TCP data segments at the
socket layer with SKB_DROP_REASON_PSP_INPUT.

Introduce a static skb_ext_scrub() helper in net/core/skbuff.c to
preserve SKB_EXT_PSP across skb_scrub_packet() while dropping all other
extensions. If SKB_EXT_PSP is not active, skb_ext_scrub() simply calls
skb_ext_reset(). If SKB_EXT_PSP is the only extension in the skb_ext
buffer, nothing needs to be scrubbed. Otherwise, save the PSP metadata,
reset the extension block, and re-add a fresh SKB_EXT_PSP extension (or
clear skb->decrypted if the allocation fails).

Fixes: 06c2dce2d0f6 ("psp: add new netlink cmd for dev-assoc and dev-disassoc")
Link: https://lore.kernel.org/r/20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com
Reported-by: Daniel Zahka <daniel.zahka@gmail.com>
Closes: https://lore.kernel.org/netdev/DLODSKPY6ON6.1G6SP3CFFLCPJ@gmail.com/
Co-developed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Wei Wang <weiwan@google.com>
---
 net/core/skbuff.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 93c2f440b9ec..5c4a2e982ebc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6369,6 +6369,32 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 }
 EXPORT_SYMBOL(skb_try_coalesce);
 
+static void skb_ext_scrub(struct sk_buff *skb)
+{
+#if IS_ENABLED(CONFIG_INET_PSP)
+	struct psp_skb_ext *pse = skb_ext_find(skb, SKB_EXT_PSP);
+
+	if (pse) {
+		struct skb_ext *ext = skb->extensions;
+		struct psp_skb_ext tmp = *pse;
+
+		/* Nothing else to scrub if PSP is the only extension in ext. */
+		if (ext->chunks == SKB_EXT_CHUNKSIZEOF(*ext) +
+				   skb_ext_type_len[SKB_EXT_PSP])
+			return;
+
+		skb_ext_reset(skb);
+		pse = skb_ext_add(skb, SKB_EXT_PSP);
+		if (pse)
+			memcpy(pse, &tmp, sizeof(*pse));
+		else
+			skb->decrypted = 0;
+		return;
+	}
+#endif
+	skb_ext_reset(skb);
+}
+
 /**
  * skb_scrub_packet - scrub an skb
  *
@@ -6380,7 +6406,8 @@ EXPORT_SYMBOL(skb_try_coalesce);
  * operations.
  * skb_scrub_packet can also be used to clean a skb before injecting it in
  * another namespace (@xnet == true). We have to clear all information in the
- * skb that could impact namespace isolation.
+ * skb that could impact namespace isolation. Note that PSP skb extension is
+ * preserved across packet scrubbing by design.
  */
 void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 {
@@ -6388,7 +6415,7 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->skb_iif = 0;
 	skb->ignore_df = 0;
 	skb_dst_drop(skb);
-	skb_ext_reset(skb);
+	skb_ext_scrub(skb);
 	nf_reset_ct(skb);
 	nf_reset_trace(skb);
 
-- 
2.56.0.317.g454f8302e1-goog

