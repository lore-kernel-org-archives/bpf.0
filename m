Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF35388E52
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673726; cv=none; b=AfjWeuQoRX4hUVL+j3Hh6qLQyVZs2+fc490VvPIRBjidV8HuyQAn9UkhJzxcurt9bM0X0fh5OJxVpvy76gPjFPgR/dzY4qwcUJS+fLITeh7n5S5PPglck4jEN09vzqHdiE2Tv1bPiIHLx3JKyMitW0Pr8bHPl7yuY7COTFDs3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673726; c=relaxed/simple;
	bh=wrkHdYhTf4x4809WOQkzFGwlZJzDIyxVtAhg3DDbp1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=elZzIZDLoORLvSTpodJjE+YKObB4Rwp4bSxfAUTaTsQP5V0Pq25I/tyPKC/6s6/+0doYZFygYjHjUDSultwhQjLhDHS1oBjfXB9C0euhDWTG939Jwn9tuy8JfX10sOu49wA7D5Ah8E4m24W6WvSVmafHuWtnTUMxtxEA5pRGkVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drnb0lUw; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drnb0lUw"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c76b9efc299so979913a12.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673725; x=1777278525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG4ZH/amOFQbdJ4PgfMAq4mwRwIpao5txIPTQLeOJII=;
        b=drnb0lUwS9Zn64ww9h3po7ECODnj+rrZSnY4UKtkFv4WPQc8a8g2MxxqQ1gkbk8Yo5
         X4xnOcHfJ0cQ9gn6wj3ptcAimjTXBfxmOHyzsI+EOJQLixgOv9S2cKcRgquEe/52Zdmz
         /2bJhSOYSzyFCRlAcyzvdFfb5hACH7o7g2kCd6ZK5y9AoamxzePVnh7DNaSTTE8DZwGV
         oknfDUEBVHmCgL6+grkUTT/sBNqJjLCYGV5Hux/mowKQ6TmwyvuPB+ksINbbAEqJZ8OS
         MNRK3xPeu6TyPWC8iG5fcf1KCLxsv+KFAPGJOx96kqRLiQ84ZXP5jcLm9/AUr9CigscQ
         lwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673725; x=1777278525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rG4ZH/amOFQbdJ4PgfMAq4mwRwIpao5txIPTQLeOJII=;
        b=CPX5pIPWBBedh/NjcuUVtEg8SFIDDoAWS3SW0xTOyOEA1e8oBuYSjXqihThxnwAsms
         GYWiCmIbCv0OQJEcO0J2JmCpmYvQRkewphSUi/fzZOxCFJPdX2YV3+RNHpY5YrN904t/
         v+B8jfKAfnRxLWKVDpof9fEajCT12uI+EWqAAq/A0aZoDs2gYVwBBegWNNZqEC+EFU6l
         8LQnVDSV9moBrDnFxqnWz+1hOQod/QMWecryh+IHQXnPhc9xWdKqklqV7hVHYZE4dnZf
         5y7ociubz6TdrVAwG+YknKYXO2IU50obZLgm9Ucvwp9ZtOQ2DShkhOe6nh2JWOww9St3
         NvWw==
X-Gm-Message-State: AOJu0YyVJ/XnIrojPDsuY1o6LAYOpVH+TxMN4syM0fhp9iTTA5QOl+c1
	7U2q3nCQUuR04BRfxdKpHF+ohfOlSJozU/HQWBc8zRw2MxTcmXLzNj1e
X-Gm-Gg: AeBDiesl92lqgAPmPrWJMJF4Lh1RMWMOqNq/NENqaZT9vZ5V9bExABJPZ9TXIAovvIy
	a/hnEkZDSclBQTbdEVSXN/osdIvqCJUzBuv+0GFHhZsy/7zEOx4OKhUqgQ7iZHXsy7ZCGUTYbn/
	blvF7wChEFraDXy+AudWWQ5lSnq6DyRsi0hDEWZxIfyZDsBz6IZrHk5uGe/bi1LpALLtAfFT42Q
	f9Bgs0HBJasycdN7YqUYsJSAiW/D7jkW7KJEu7yL5qVf4iMeZ4JMQJuPyFOnPEY13ENVLU3FR9i
	fro/gW/w0VtZWqjNDo2VqSGkGc5vJInfD/E5gSAOKPH+sehL3AM6irVCSKS0fmmWQeCg77hBqf3
	uQaidppW4kESgRBSGVmuE3G7sU7lYgFsGfRWdG8rkfMLJMTgD6qKZ/5c29+MqpVcIE0dNIkPnyx
	3H6trz6j9l1THBlRj6NVUQGW2zg5EwObkppaAYW8ButlZv/YGHFtx4yC0pw3IzvB5HVOxAbU7sk
	qfMpa7d
X-Received: by 2002:a05:6a20:3d85:b0:39b:989e:6d39 with SMTP id adf61e73a8af0-3a08d8a947dmr14941354637.35.1776673725087;
        Mon, 20 Apr 2026 01:28:45 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:44 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 6/8] xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
Date: Mon, 20 Apr 2026 16:28:03 +0800
Message-Id: <20260420082805.14844-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260420082805.14844-1-kerneljasonxing@gmail.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Fix it by explicitly adding kfree_skb() before returning back to its
caller.

How to reproduce it in virtio_net:
1. the current skb is the first one (which means xs->skb is NULL) and
   hit the limit MAX_SKB_FRAGS.
2. xsk_build_skb_zerocopy() returns -EOVERFLOW.
3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'. This
   is why bug can be triggered.
4. there is no chance to free this skb anymore.

Note that if in this case the xs->skb is not NULL, xsk_build_skb() will
call xsk_drop_skb(xs->skb) to do the right thing.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 51f76e9d6ffd..9236ec32b54a 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -784,8 +784,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	addr = buffer - pool->addrs;
 
 	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
-		if (unlikely(i >= MAX_SKB_FRAGS))
+		if (unlikely(i >= MAX_SKB_FRAGS)) {
+			if (!xs->skb)
+				xsk_drop_untrans_skb(skb);
 			return ERR_PTR(-EOVERFLOW);
+		}
 
 		page = pool->umem->pgs[addr >> PAGE_SHIFT];
 		get_page(page);
-- 
2.41.3

