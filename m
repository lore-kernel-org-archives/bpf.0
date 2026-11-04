Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764111;
	b=XZg5gXevitoIwdSDqMq6Eby5Pa6q5DjcE30uBwh8Ba/2ogFvE3G1h+ZZZCauTM4jT2Ah
	 A6kIrURLu0aksE5VFfQG5BY1PGY1PaPx4Q3n3/Qh5UxztlentXJSOAMOFmy1ikqdldafF
	 tzx+qLFji7bMG2SlXKOOXlY2k9x+jGYi2i1gjPfIEDKatdlMHnCGZMl2cQX2QbPfGbbCO
	 L7oRCuNzgE9nC5ctr/kClVVUYoXFQqs/On0Xt/pL02JGheKrJMx1miAWZuVzl7cEktUUR
	 B1jDeHQoiqkFr1ndZagoMFvpS6xu1PlbHVcEkrNr0W67GNmoGWCJxC00LTaNzhvmlVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aUeirx3i31936fQIuPQmzE4OuL+xRIGfpGiZkYr9/q4=;
	b=jZj4VcI2p+VFkAGAbcJrC35Y/kpOhZG9jrUQ/ngdH+WjFNbbMwtueiVQOwa7+OzHxGcE
	 yUxl00bI7XQ8hnTWUaxGZ19uVihCLgIl8tUHj6KTvR/5026BQpaNQ2GFuv2u4tsouFXS1
	 jcQFlZ8jccnwrvTUWh1JRW1egi8wgMEBfMkKKvxgbX9rASPg791GWvPAUhBM1zeK752QC
	 vCbE1rtna5JJvO5qGhJ0VbqZrOoGpmo+Tyy1Gtq0LZsIpg9kpPLbTXVVYKNfBm/XEQq7y
	 hzhfKnqfh7zIXjcOFFiQGcctfeNvfoFcwvwrA1rb0kg0s4K5fb5+pv9iG+R9WhYiOKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nk5k7LmW;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2591606A328
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 03:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2591606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nk5k7LmW
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ae93e7727aso126219a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 19:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793764110; x=1794368910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aUeirx3i31936fQIuPQmzE4OuL+xRIGfpGiZkYr9/q4=;
        b=nk5k7LmWzDwaBnhbGoTmgRM0iFvyEupNwgAGriyG/o0TunbdbFZbJwKFJOVFnJny8e
         Yn1RbuV3xKUsMfZy+zHWF/Oh07amD9eATAnRu+OVJakSIkxtJZhtSdz+4JorFvBiRIky
         fAzxvJ8+4SL1K/zh2b9i6xGRhCi863sr0825+luUyDjqE7ekP4Xxme1ytvNnkf+BJrCM
         U++IKulCpBXCo29TbxkK0XqgBysw5c8cIaC6RBPVA0fHk0JOSOzNd33yjVx6U1/fA56q
         UKzRgO2WT1zxusZVTfM7w+Zii4BhfJMqH+2CwTsP351OuqKJ2eOyVHHGu7kgfOLajBgk
         6hTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793764110; x=1794368910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aUeirx3i31936fQIuPQmzE4OuL+xRIGfpGiZkYr9/q4=;
        b=axeYnObu+yGp1HnbXlqDJE62Ab+W/2U610yw2Hym1oo6ZyhqR3RG334f7bl+4wj5p3
         EJ59YnvNW8Nm6viDFllDRzx7EIGkbSnoSTN59cHNEjfOVELszccnH5JspN8JIaOnQzWg
         IHKrMW+O1yPegY1TKhEPCJuLeUPC1f8Gxd47QdCn6jSC5cWF2zEXLKTq9diDLNsKbrZq
         5fP+q4XFWpmbr25H1VQHgqSt7o2TmOPjmlqQcfejQSq1Lz1ELhxDnflmvFmdihaeRP3w
         HE7aTU42ztmTNkiK7/CyEWbHhZlmfdNDSvh7Dj7oI8oTsErdrrEFTTvK1iQId22s8+C0
         PM3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzPqRSWfV/qQ7cWavwK8bIx93u+NdOIH84lWYewHQLFP4UELw4uyK8a6nvjIulZJP0Yvp4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Y5535HqqNckRKtrG6ysebzSz3/GecZqmBmCGTm441dyeUmuo+
	2oEROpIwfo6djdWhEqwKmWdQmgXqGYgwaHdEG2ZKiW4ieukiQX0cHthA
X-Gm-Gg: AYBFou1XlLWXAG/+/WJPu6hsWO1Rp2k5jVDk6/j4dwnQD6wW8SF/wZSY4mDM3iRYkkj
	M4wK+jVF4MDXBZoOjc9Hu1oCp3+zNNrGhRCSQxNY68/K16aVFPiOSxUt2QY/HalCt7Rxdolcouq
	2jLLHr237RlBItwYRD5vkDMtP4lAKVKzeSP21xYC8U7M0Y07jMb68zT6kIbMoDBfk0RqaThxiZV
	mcuK57HF0Uf2Y0sblSsBVAMtXtLyF2bPXM4E74HpthYs96iW9lJsRE72vEMqm+9fo9zxFOToDTg
	bdaiLjC2zld+fdQ0ZhITz0C0xV6JJwQ4ZLeOOv0d/iveN9er08qUTZRugvf49PWOqqdrNzYUY1Q
	HSKscZD//M7cn9xSo1FIqTQeroSoCcQMSah0jRcvd13/Mws0K9ZG+m40NIQblu0RNt4L2W5SlnN
	/QNyn3Nhyue+nfC2pJbsDmxfrwSrlUVK7tS1vFEff1NM6EOl/N6vx3awPNpm9hcKJBmGsAvriK3
	WSggbJyQCoJC+//P3nLrT+4qQBha9pMvt4hYBS/0ErHW3GONkxG2FGJryTMvqd42l07pvIR1fN3
	Rp7e6WpIQGi7qJcrtwv74Lu6uPzio5Plt5Y4W981U4Tc5O/LM4xSwtzkWmW5ma+KMGXS
X-Received: by 2002:a17:90b:588d:b0:3ab:9c73:147 with SMTP id 98e67ed59e1d1-3ae8970ef58mr12252667a91.14.1793764110336;
        Tue, 03 Nov 2026 19:48:30 -0800 (PST)
Received: from localhost.localdomain ([240e:46e:1a00:3fd3:e1be:ed6b:40ce:8dab])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944a0ff7sm1705472a91.10.2026.11.03.19.48.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 19:48:30 -0800 (PST)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v5 1/2] xsk: defer software checksum until the skb is complete
Date: Wed,  4 Nov 2026 11:48:08 +0800
Message-Id: <20261104034809.24545-2-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261104034809.24545-1-testwrzwrz@gmail.com>
References: <20261104034809.24545-1-testwrzwrz@gmail.com>
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

When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
calls skb_checksum_help() while only the first descriptor has been added to
the skb. The checksum therefore covers just the first fragment, and
skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
fragments are never included in the checksum.

Move the software checksum calculation to the point where the last
descriptor has been added to the skb.

On a checksum failure the packet is now dropped instead of being returned
to the application for a retry. This path is not reachable with the
existing metadata validation, but the behavior change is intentional.

Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
Cc: stable@vger.kernel.org
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
---
 net/xdp/xsk.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..27ec1d931fe8 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		skb->csum_start = hr + csum_start;
 		skb->csum_offset = csum_offset;
 		skb->ip_summed = CHECKSUM_PARTIAL;
-
-		if (unlikely(pool->tx_sw_csum)) {
-			int err;
-
-			err = skb_checksum_help(skb);
-			if (err)
-				return err;
-		}
 	}
 
 	if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
@@ -1030,6 +1022,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 	return 0;
 }
 
+static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
+{
+	if (unlikely(pool->tx_sw_csum &&
+		     skb->ip_summed == CHECKSUM_PARTIAL))
+		return skb_checksum_help(skb);
+
+	return 0;
+}
+
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 					      struct xdp_desc *desc)
 {
@@ -1277,6 +1278,12 @@ static int __xsk_generic_xmit(struct sock *sk)
 			continue;
 		}
 
+		err = xsk_skb_sw_csum(skb, xs->pool);
+		if (unlikely(err)) {
+			xsk_drop_skb(skb);
+			goto out;
+		}
+
 		err = __dev_direct_xmit(skb, xs->queue_id);
 		if  (err == NETDEV_TX_BUSY) {
 			/* Tell user-space to retry the send */
-- 
2.39.5 (Apple Git-154)

