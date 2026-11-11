Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362372;
	b=TrRwCoTkzIrjWgz94owFAol+0W1kwTsCuO2poVB+4Wu3tGhRNlyXGY1ifyTDuTBB0wsZ
	 wPrI/1O0k2Lluce4sD0QkXrQ2DhhFdpwCsayQYDUuZmUG/HYMdcE2aJ87sdApWU42tal7
	 OeH3qqUo+4WeB2qRpBIfMNZWk6eCAiggLBrGQCRjUPMLfFOcH9hUgO4+3M2zcFaWCvSJ0
	 qmgXJHR6yiA2Br41p0BLKqXr2yoT4d21es2R99lMuq8/rHLqur+oSOl3r3+OHV0Ma1amt
	 dGj9qeG5SWBOaFev5AHLWBzPAHvoB0hiYaJfpEE5l+AhYqqS/AVG+4EjqsL9GKpGYeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HhUr6++cEdzdu7aXmazmu5lx8Sa5k32R+7mO7JewGbg=;
	b=RXW1JOfSFVza3Em9CbuDcfUWwfMj2JnYh59R8lQTDhhsLidBz166w7yxoKMTUOS5IL+S
	 cnz3ODTo/t/op85dh/2FQTb5xr5ide5WVH4nUrusb3Kuweo0QZqSMAexESxDKOJIErDbe
	 lt1a9G/c2uFARz7ulZi1hBP4i8jy9s3Q5//zadxcgC5zYJRkSg51nfI0b+Lh336zOvU/g
	 VxK/amxPUt+9LOXxiTBeRiFt38adZY9r1GQENHQC/Lgm1VIdSuluTgr3ORrpmkm0E78dy
	 KQ9Y0wmc0W517ypCaHUbF0YyxBfgNM5siIUcHf18YMWnIzzb1Tif9VTurgDO1+vLpvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=aOdGraAv;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7249606A320
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 01:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7249606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=aOdGraAv
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c505186727fso184061166b.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 17:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794362370; x=1794967170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HhUr6++cEdzdu7aXmazmu5lx8Sa5k32R+7mO7JewGbg=;
        b=aOdGraAvbilQamH/nwGdpN9DOpt0IvJwwUYwfP2vG0lFw2A4pCCfPdRRBIhH888i/6
         VknDBNGoqF5+zY+BDQfEY7HjWvblNOzeCZaqjaGF71YSNZKbWC1afWOCBL/pSzObD7/A
         EK8ll88LQwHE4597BFtvLckQs1U42IrRMvrSBupC6A96xw2MCBn9X5kjVOq6odZ0EvlH
         3jx1jIOx76ktQcvZO3fccMWavFXKW6BmOe5Zo07JSo1hwbHjtqrcES7GflQvFuL9vS9g
         /AB6OTtlyO5J0Via92/g2/KBs5VFRb7D5mF60eYRt9YL1NKuCi0Nksf0F59kAOMpHNEH
         TmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362370; x=1794967170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HhUr6++cEdzdu7aXmazmu5lx8Sa5k32R+7mO7JewGbg=;
        b=VbF3cDNyXDLYTL1i2uLdDbm0jYIYvYudjACatWVCsTR2xkHnAFDURB8KrcGLTv68D8
         eAWHN96C+Z37zQvEhHm3Bxh2DeJsly4TLaHtLGtYceE3c5mX+Uk+Pne97i1/gmgi+Sp5
         5QOmBCUxONQoAJgPjkonSJF5+PfBnqhIDevVkqoE+5zX/1DfFUelVZViHJZT6s7yHZkG
         lWfICiRjSx6De2xrT0D26ePBywykhnRQ+yI7l0WX4FOzk9X+Np1ZQftonkzo2tZRgc5W
         9EmSMScPUA5HzZxizyg8noD7CiULrxMyXPasWh6Q03u+nblbCKIt89SJKFek9d2/Psq4
         gQrg==
X-Forwarded-Encrypted: i=1; AL+hErGY+sSCJ5GvzlVd7ONniGccxRA4hYaPQlcW2vdMIcpeonXKXlVavs06fZgjjOXm+FeWjcE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4hjicjLn6AysYF0i0VaEXr/HPEb8zvfl4mvrYq4PAHHEKGZF2
	bDJFcX58+sorrduIIHLYU8Vwbg7GidXLP5x5Z09ypNUsuk5r7RQnd4Zd8zTaMhycYa+wEXZHZtU
	/AftOaDQ=
X-Gm-Gg: AYBFou2KfclA+Nb6pEMOAOaT1atM/3kaJ2QnN0N2Os+gYUYCk1Gyl8piOWSZ6CfpmAF
	KMiyCCaKj2gVo2Rm0zn8SfFQhKeDVzKccS5tlRB9xx8IxgMYDYQ7q/AprOCOGHGDy4mRwS0VRNE
	WM6eo0mzG54g1kOLBfGkklW5IKsnmjAqzi+gVNK8VHphwBsE4WU7b7QKdDkqix6h01MHaxAsvzS
	0nvy8oaJW4SrHP5JFtkzb+EibInvb0E2+fd68I1TQrjOtdHHprPizyMTiQwa7Kosed7w7ajXs3h
	+BY/Wx4KOLw8NlitZco5x8LEhs+IK6KUvH/Emw/dr0OMqGHfxwG8DlIxyu25asCuYgVqgY3LVad
	yjeDfFEvYXFtJioa7avGGL7Ma+pea/nXtIDlwr/r3IPpSP001NbqWKVMHUBRhSuDtdc3ccnLyb5
	lccW6sPz1KSH5yCWrFw8EXQqZZUiYT55YzARgOoHGnwtxuLw47ym9elUqBsXfMiLilVMeUDWZg7
	2Ikr5MJ09qC3NLwqvggpB/c6JU1ixEdCYqCfskAGd+t3ZF3Hj+gDXI4quGJECJ0PB2r+1OCyiq8
	uZcsNp4VKKSjE/L5Muo5tJd6O7Ap2hgeQwVZnY3o5nEQ3s+HUft+xWFHiQ==
X-Received: by 2002:a17:906:9c86:b0:c50:5996:5b89 with SMTP id a640c23a62f3a-c5066b3aa67mr65463266b.23.1794362370268;
        Tue, 10 Nov 2026 17:59:30 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.58])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7834cdc23sm147498a12.12.2026.11.10.17.59.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 17:59:28 -0800 (PST)
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
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v2 1/3] veth: refactor NAPI enable paths
Date: Wed, 11 Nov 2026 01:59:20 +0000
Message-ID: <20261111015922.67745-2-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111015922.67745-1-tianyi@cloudflare.com>
References: <20261111015922.67745-1-tianyi@cloudflare.com>
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
index 0539b3661793..f5097696df15 100644
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

