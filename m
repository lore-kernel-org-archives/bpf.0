Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889243;
	b=LD+gj80xVoflNvDN0IkIpH2DSxdwPKP2lzWLEpfHaSJIqhqcFHld9Ot6smykmhAE0hqk
	 Y7B2kKAthKKfVCGglmvewTak004ssHjqXwiL3b5l69PyRN4JsHyOBOgmQJImMR4brSB/y
	 JV28BHkN/y7UcyOldAGtzbZMzOImoUvHYFqJOxriz4thgzzWLvttr3c3f3lpzYubr1wiF
	 ylQhkIgOV4S4PtHzpyaGkgQdNJ7DbgdqkM2WkF7WSZx9kf+uZ1ZGEBRTEPMpHV0QKJW7s
	 17sPOxcff9y8OzDmMyXLAdqhEgfP0u/p78kngxIiNfdCPnx4w+nZ2red4gi/DKjbBAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wz/ix5Uo89HO73J7bY7HZ3fOfadWMH/9uupcr6IydS8=;
	b=N/ZCfsuH7YrsYL8YXL64olpzyjjisSFwMzf47nYwNRLmZsihlX/v1+wzDVwAgeI/zlTE
	 KPrGwU55oLN4J/Y5Qo0ZnwhoHN1ch88ZZdz9s2RD1qgdIGFTJV9ltnzcSjrh61sJTIk9v
	 UiLQp27V6Rb8s1XqNU+8loDYk/J2MaL7rn3rycPZRdV2X291YuzLB/zaURMdnRZ+uzwG2
	 cw/7anQ3lCgPAbwBx6OvAPq4+BhvjvzYegS44WGqnJN1hu73ehDT8iRvyTjTBHrLTATAh
	 rfAABJxUlHjc14zqs9068cXTS3+IkAVC+66mCz0yMOipOMLvHXvDtOBFh22Umf1O1Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=VXGLCUVz;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E2D606A333
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 14:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4E2D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=VXGLCUVz
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c445c95d553so278717966b.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 06:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793889241; x=1794494041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wz/ix5Uo89HO73J7bY7HZ3fOfadWMH/9uupcr6IydS8=;
        b=VXGLCUVztGjNQNZD3dHhjtoymGsahDN8W+I3zABl21E8xfdttWMFQZIabkTnfAKmgp
         q+xPoLMrDfyouxts3DNeJyXdC0DClGNQp3t+8BD/ShuoRPxVupFzJ24SNT23U3zx4PJZ
         erWhPI9VF5f+i07c2MMEImwRo/TAeAJ2gmZry4oT/S9aM4BEhXHzhHFmEYzhnLXCof4N
         dbRfw+W8Wsno7Scar8il00nUmlrS7g6AYW1eBHUCgjaKqUhBlF/zzxz0IizvWxtWU9EN
         H+/IusFona6FRgKMCmEfuGzfPXos0dwopXk9qZry6WY1egPspcUEil/3uL3BsqN8kSFx
         ZG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889241; x=1794494041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wz/ix5Uo89HO73J7bY7HZ3fOfadWMH/9uupcr6IydS8=;
        b=gUYGOYWbAHsL+Emz14aBzRfVYAUf4/7D0xKnMd1DHqfQglya02kBBE4AtbfYwVGLRX
         xcwJZUTLKrsep/OSb6fXbRg4C6YxOsBHdi4k12pFSxJvnRzAsxI1C5q26qxX/AXzg5ac
         g0pkZ+4R3xpYtjlXYM4tUywjEfxSHQURzVr5YjuzbMmdK8UEamTI5XBbJ7nK8/H+Av/e
         UAKKONvOCwqbM0TyTk3PzM8wUdPyr2AXqepsic3gh6TiKgGPdUkIjb83r5qfoihwOHWB
         kCmabJ20Q9DRxU4g1k90i7/4//OcmJhDq34dsVLbAL2umjK9RprsgmYHwFCnR73BB+R7
         W+gQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfZpmBAX+XVvECzbwAvTplIyqPtD34zRT1+IgIwB42usXkjQHjHGvv3ySGKU8PMBOCvnI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cJ+GOEgBvuwPod3w1dez7aBOCpxpBCStPNr8jdPJzmWD6LBzp
	LDD3dXkOpBZQT8ogzgDZTSWNTASew0PqP2Yzt6/YY3C4MdGBFdwIflY6C12nwBsOJvn/W7NTQlr
	d3HuXG3gPFg==
X-Gm-Gg: AYBFou3iT/fSF+PXkakJsbkGSz0maFqOtFcBY+yLdErLH205jUehhgsZTLR8v11FhvA
	r3dPi1vKf61d5F7btJvvQlnWXzAsTKE5M3iw/Ui/hGAaYvIjG02DHtsSYJL2H2+lkUKQtUB4d9g
	4DHrx7KUoYUe9fwvpll7DacA217FyL4IBMzW93r/0K2pmlZdYRT6+7nnjQm4Q0IlIUFTnZgqeLF
	TMnVW1+gpkkvF8vvSL1igiKbBfC3OjEb7ANLxGNp4q4cfhHrMdEmwiV42AJsfQIWMnVaajMEU+T
	9byk460o2fxuAza2iUK1CsK2NkdLM3J7Hp9lggAvVlACg/1zfT16LE2iqarFU7B1JNMV8y8XTs2
	C657fuZDQSBVgamadv6g2axYVcHQHSb8MHDX5EPBQqXASKom3KOSMjNoS7aDyoJHjtpuZtL+2lv
	NmyWJN2S6nn9zwmKAUT+9Xq896UN0qNL10RNbKM0W1KAkG7Grl9jDLnuWBYEs8xbZWah3F1FYcP
	Bcz6+bLcKpI2D9FvMI5SCh7tJeOMRhtydEtIdwENuboVaTVSKihNdBxA9KHNqPbwKeVJbReVOfL
	4T+7zFHgzZhX3l84mt6HsFxNJ3CUbEGCvDG4TdnmzVvvpKk=
X-Received: by 2002:a17:907:1c9e:b0:c48:a838:c16d with SMTP id a640c23a62f3a-c4cebc73337mr856063866b.30.1793889241197;
        Thu, 05 Nov 2026 06:34:01 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e466be0sm178671066b.54.2026.11.05.06.34.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 06:34:00 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	lorenzo@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	jiayuan.chen@linux.dev,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next 1/3] veth: refactor NAPI enable paths
Date: Thu,  5 Nov 2026 14:33:54 +0000
Message-ID: <20261105143356.17062-2-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105143356.17062-1-tianyi@cloudflare.com>
References: <20261105143356.17062-1-tianyi@cloudflare.com>
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

veth_enable_xdp_range() adds the NAPI instances itself, only to pass
rq->xdp_napi.napi_id as the napi_id argument of xdp_rxq_info_reg(). That
argument is unused in __xdp_rxq_info_reg() since commit 5ef44b3cb43b
("xsk: Bring back busy polling support"). Pass 0 instead, as ena, bnxt
and fec already do.

veth_enable_xdp_range() then no longer needs the NAPI instances. Move
netif_napi_add() from it and from veth_napi_enable_range() into
__veth_napi_enable_range(). Add each instance in the loop that enables
it, after the allocations that can fail. Drop the napi_already_on and
delete_napi arguments.

veth_napi_enable_range() and veth_napi_enable() are then trivial
wrappers. Remove them, and rename __veth_napi_enable_range() and
__veth_napi_enable() to veth_napi_enable_range() and veth_napi_enable().

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 drivers/net/veth.c | 80 +++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 62 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 3eca92d3dc60..a3570547ee99 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1037,7 +1037,7 @@ static int veth_create_page_pool(struct veth_rq *rq)
 	return 0;
 }
 
-static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
+static int veth_napi_enable_range(struct net_device *dev, int start, int end)
 {
 	struct veth_priv *priv = netdev_priv(dev);
 	int err, i;
@@ -1059,6 +1059,7 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
 	for (i = start; i < end; i++) {
 		struct veth_rq *rq = &priv->rq[i];
 
+		netif_napi_add(dev, &rq->xdp_napi, veth_poll);
 		rcu_assign_pointer(rq->xdp_prog, priv->_xdp_prog);
 		napi_enable(&rq->xdp_napi);
 		rcu_assign_pointer(priv->rq[i].napi, &priv->rq[i].xdp_napi);
@@ -1079,9 +1080,9 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
 	return err;
 }
 
-static int __veth_napi_enable(struct net_device *dev)
+static int veth_napi_enable(struct net_device *dev)
 {
-	return __veth_napi_enable_range(dev, 0, dev->real_num_rx_queues);
+	return veth_napi_enable_range(dev, 0, dev->real_num_rx_queues);
 }
 
 static void veth_napi_del_range(struct net_device *dev, int start, int end)
@@ -1122,8 +1123,7 @@ static bool veth_gro_requested(const struct net_device *dev)
 	return !!(dev->wanted_features & NETIF_F_GRO);
 }
 
-static int veth_enable_xdp_range(struct net_device *dev, int start, int end,
-				 bool napi_already_on)
+static int veth_enable_xdp_range(struct net_device *dev, int start, int end)
 {
 	struct veth_priv *priv = netdev_priv(dev);
 	int err, i;
@@ -1131,9 +1131,7 @@ static int veth_enable_xdp_range(struct net_device *dev, int start, int end,
 	for (i = start; i < end; i++) {
 		struct veth_rq *rq = &priv->rq[i];
 
-		if (!napi_already_on)
-			netif_napi_add(dev, &rq->xdp_napi, veth_poll);
-		err = xdp_rxq_info_reg(&rq->xdp_rxq, dev, i, rq->xdp_napi.napi_id);
+		err = xdp_rxq_info_reg(&rq->xdp_rxq, dev, i, 0);
 		if (err < 0)
 			goto err_rxq_reg;
 
@@ -1151,21 +1149,13 @@ static int veth_enable_xdp_range(struct net_device *dev, int start, int end,
 err_reg_mem:
 	xdp_rxq_info_unreg(&priv->rq[i].xdp_rxq);
 err_rxq_reg:
-	if (!napi_already_on)
-		netif_napi_del(&priv->rq[i].xdp_napi);
-	for (i--; i >= start; i--) {
-		struct veth_rq *rq = &priv->rq[i];
-
-		xdp_rxq_info_unreg(&rq->xdp_rxq);
-		if (!napi_already_on)
-			netif_napi_del(&rq->xdp_napi);
-	}
+	for (i--; i >= start; i--)
+		xdp_rxq_info_unreg(&priv->rq[i].xdp_rxq);
 
 	return err;
 }
 
-static void veth_disable_xdp_range(struct net_device *dev, int start, int end,
-				   bool delete_napi)
+static void veth_disable_xdp_range(struct net_device *dev, int start, int end)
 {
 	struct veth_priv *priv = netdev_priv(dev);
 	int i;
@@ -1175,9 +1165,6 @@ static void veth_disable_xdp_range(struct net_device *dev, int start, int end,
 
 		rq->xdp_rxq.mem = rq->xdp_mem;
 		xdp_rxq_info_unreg(&rq->xdp_rxq);
-
-		if (delete_napi)
-			netif_napi_del(&rq->xdp_napi);
 	}
 }
 
@@ -1188,14 +1175,15 @@ static int veth_enable_xdp(struct net_device *dev)
 	int err, i;
 
 	if (!xdp_rxq_info_is_reg(&priv->rq[0].xdp_rxq)) {
-		err = veth_enable_xdp_range(dev, 0, dev->real_num_rx_queues, napi_already_on);
+		err = veth_enable_xdp_range(dev, 0, dev->real_num_rx_queues);
 		if (err)
 			return err;
 
 		if (!napi_already_on) {
-			err = __veth_napi_enable(dev);
+			err = veth_napi_enable(dev);
 			if (err) {
-				veth_disable_xdp_range(dev, 0, dev->real_num_rx_queues, true);
+				veth_disable_xdp_range(dev, 0,
+						       dev->real_num_rx_queues);
 				return err;
 			}
 		}
@@ -1220,35 +1208,7 @@ static void veth_disable_xdp(struct net_device *dev)
 	if (!netif_running(dev) || !veth_gro_requested(dev))
 		veth_napi_del(dev);
 
-	veth_disable_xdp_range(dev, 0, dev->real_num_rx_queues, false);
-}
-
-static int veth_napi_enable_range(struct net_device *dev, int start, int end)
-{
-	struct veth_priv *priv = netdev_priv(dev);
-	int err, i;
-
-	for (i = start; i < end; i++) {
-		struct veth_rq *rq = &priv->rq[i];
-
-		netif_napi_add(dev, &rq->xdp_napi, veth_poll);
-	}
-
-	err = __veth_napi_enable_range(dev, start, end);
-	if (err) {
-		for (i = start; i < end; i++) {
-			struct veth_rq *rq = &priv->rq[i];
-
-			netif_napi_del(&rq->xdp_napi);
-		}
-		return err;
-	}
-	return err;
-}
-
-static int veth_napi_enable(struct net_device *dev)
-{
-	return veth_napi_enable_range(dev, 0, dev->real_num_rx_queues);
+	veth_disable_xdp_range(dev, 0, dev->real_num_rx_queues);
 }
 
 static void veth_disable_range_safe(struct net_device *dev, int start, int end)
@@ -1260,7 +1220,7 @@ static void veth_disable_range_safe(struct net_device *dev, int start, int end)
 
 	if (priv->_xdp_prog) {
 		veth_napi_del_range(dev, start, end);
-		veth_disable_xdp_range(dev, start, end, false);
+		veth_disable_xdp_range(dev, start, end);
 	} else if (veth_gro_requested(dev)) {
 		veth_napi_del_range(dev, start, end);
 	}
@@ -1275,17 +1235,13 @@ static int veth_enable_range_safe(struct net_device *dev, int start, int end)
 		return 0;
 
 	if (priv->_xdp_prog) {
-		/* these channels are freshly initialized, napi is not on there even
-		 * when GRO is requeste
-		 */
-		err = veth_enable_xdp_range(dev, start, end, false);
+		err = veth_enable_xdp_range(dev, start, end);
 		if (err)
 			return err;
 
-		err = __veth_napi_enable_range(dev, start, end);
+		err = veth_napi_enable_range(dev, start, end);
 		if (err) {
-			/* on error always delete the newly added napis */
-			veth_disable_xdp_range(dev, start, end, true);
+			veth_disable_xdp_range(dev, start, end);
 			return err;
 		}
 	} else if (veth_gro_requested(dev)) {
-- 
2.56.0

