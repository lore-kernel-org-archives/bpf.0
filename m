Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911547ECFE
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848260; cv=none; b=d/TQO72cqCGIuOt01kmb5ENBGGpyGuTNT1LdBoMJ8sXTpvCxASNUzJXnxzHXg2YQcGp+O1Ld5KGnxlVGiKf8YFJY07/ri6QC34EdUYaXZehuVOGOCc8JbVjVJJY8afw2wWltUjEu6PFeurwO+0H4rMfB/4ax9m+m9h0blKKwddE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848260; c=relaxed/simple;
	bh=9SqdKDQGx21ETaJhqKRTVsLbBcKWXoFJC0PyhaYrgCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NmKSGsifT8L5g385F7wabK2LL3PWhymzQEPWNQZvAaPbEKEG1CM9fdc4UJAwAqqeL6pJaBuF5gp+/ipNLjjugEZ32WIPEDh3ZymGysv4t4jZVjrCSQO7mDNxyRw7Sz8ye1AjjFplY0dVbDYVBsG2vke/XRmSqGVRuWD0d/7CSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQH49pwU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQH49pwU"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b9ec9443c2so5010895ad.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 05:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848258; x=1779453058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QkSwi0tog8aJVBoGokTiFwWgsOPVBliCydrrha64Rk=;
        b=VQH49pwUEdDm5Ra7yh2TZNVFgFuhrfYUMewAmp6KgIjTm3Wkz492cgFNC4HKtNMY9u
         6pzjIrE+KRObvDqO8L7qPlzSYswBl/mZl8drhaaNGq9fcOn2DLD95Qb0zoajJjsrrelr
         2uRzpmjClmIk6A7EtMgXd/0oVO5FRpyNRAcdNAxUs6UNNsgBVTvxg2S7THMJnLQFAPqd
         hZmUoxBvofFOHM84ADigAgmjRP9c3tmy2dWDDYh8njZBybyS7NHA83wezOmmqTO2Mv4C
         MhD+lEA1W2o+fhu/nIfgUbZhcahnpyOQcHWxDZgJCkdYJ88L31PbsJL6opgkiw/jkRZw
         KdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848258; x=1779453058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1QkSwi0tog8aJVBoGokTiFwWgsOPVBliCydrrha64Rk=;
        b=Dg0gefB66BYV4MrjFX6pJ2sTXb8XCwKwGRwOVsnb+9rvmHMt8Zt8u3bTvzvz+7wqM0
         3qQOS1YZnPyqweAHmibtzqno6kR4R8i39uYrt2BIWYd/smMV5dLWZSrW0fi6LfYwW5Sr
         PKBzUanMEPRXffGdyWedRWGyL1vckHoDjp/jEKISf+OFgy2GoTEqgJNIQde1XGFhYP+x
         4T/pIMK1oSmvWpc49rcaUMCqeEVirQT/p495UoUICPbpSfu+ST9gVK/IAYxQO+5gGEGs
         9m4DsPHblq4a6Wu6vNyvMSzHYZCufxid8K2Qr/zWGUhsDjG9shpstA6ngtmtBEWgoK3W
         E1IQ==
X-Gm-Message-State: AOJu0YwKudEc0WNCqrb1VPI1/Dm9fsckMEOrx70LxjWo2gwLxypFH0pL
	a4NvRRzGXriEQNciwj8j8nipc3f2lplR/urdNQQZpOQ8grbtpHaunNMS
X-Gm-Gg: Acq92OGFO226qc0yxdb+wxRPYlWcnSm4Ezh00dPNIyL1960OLchDNw9YwGYLvprfGyD
	hRpVc6Rx9Ba57/VZYw4qRV3caKPnLfRZerbpYG6k8oBSR/CJySUXxwa4naRbvWKWRQ7iQVfjinx
	4im1lHCfEBcLpRkDqEwVWEHiXOYsYMSLk9F02hHR0LSSemnafketnA5QKYrNXiGomhCgf5akYxB
	X2UilNrXqUTNZHkVHjh4FC9sjO0uh6S1D4cpB/TiXbVQfcGSlcBJDwsgC/ne4g3j1GiuNxPrpdV
	3SezcZhTyzcaJvp8Um/7yu71GFND0r8hPav1d+QcDs3Ng27GGda1sUfmHsyy/kr9ar10vh/YNus
	TP3SkADavA5ZBxywhl/nYYUgoMBJx85xgswU7eJRMJnmfD6bWZ2PA90ebH7pdyFwugS+mRbw/Nw
	ZsO2YuN48+plZwsXmZmFKONf7K603dW2Mc0dq5gBZaybTkhbz09KcCq4Lt54BErG2ydh4wDNZCB
	e1jx+UjNIREoFsSzhLVx+aIh2CxKYv/rDzAh/Hrxg==
X-Received: by 2002:a17:903:943:b0:2ba:5e99:93e8 with SMTP id d9443c01a7336-2bd52b6d778mr74236205ad.29.1778848257915;
        Fri, 15 May 2026 05:30:57 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:a48a:1116:aa2d:1122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe492asm60348885ad.48.2026.05.15.05.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:30:57 -0700 (PDT)
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
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 4/5] xsk: drain continuation descs on invalid descriptor in __xsk_generic_xmit()
Date: Fri, 15 May 2026 20:30:17 +0800
Message-Id: <20260515123018.80147-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260515123018.80147-1-kerneljasonxing@gmail.com>
References: <20260515123018.80147-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When the TX loop in __xsk_generic_xmit() encounters an invalid
descriptor mid-packet (e.g. an out-of-bounds address), the partial
skb is dropped and the offending descriptor is released. However,
remaining continuation descriptors belonging to the same multi-buffer
packet still sit in the TX ring. Since xs->skb becomes NULL after the
drop, the next iteration treats the leftover continuation fragment as
a brand-new packet, corrupting the packet stream.

Fix this by setting the drain_cont flag when the released descriptor
has XDP_PKT_CONTD set. On the next call to __xsk_generic_xmit(), the
drain logic introduced in the previous patch handles the remaining
fragments with normal CQ backpressure.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f98a9553e536..3b604776f09f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1045,6 +1045,8 @@ static int __xsk_generic_xmit(struct sock *sk)
 		if (xs->skb)
 			xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
+		if (xp_mb_desc(&desc))
+			xs->drain_cont = true;
 	}
 
 out:
-- 
2.41.3

