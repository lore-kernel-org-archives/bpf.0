Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A393AC00
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778376228; cv=none; b=rACK4tlQl5u3FSEbh9gk8AzzF7lvNAoedv0DiSWCRo9LFyKpjLY4Ckd9zQv1xU8oZevF0CCBP5ARXOnu5wzjmigpFJONNSZlaS7Q1CQBE233aWQ2NFOHsLDYZMy1VIlbNVfr4hIzt6YpyKwTq4MsjPNYnoo8K8jP1Gj+rfYBkpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778376228; c=relaxed/simple;
	bh=4iX6eJkexz53dxVsq9AYaEzTNy8W+QRRol5UMw9qdiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VFLzaQbhHXGGnsE5e46hTvCPtcK2qRZmavkK7s9399SSJb3825xiRiTRMRqw04iFD2SKQ75KozNAkcn6wfpk+Ahx90ne7X0OJMBFaxOS1/3etkLAtGG+L/3Ca6pI40boJQKLcDNaPIrqU72VL76o1A28X0y3KiG/s7poGpM4sBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+/UGRyP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+/UGRyP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba928852a5so21161065ad.1
        for <bpf@vger.kernel.org>; Sat, 09 May 2026 18:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778376226; x=1778981026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k83FvsWSelsobvUl25t3vFW44Bj//lrGN1EzdGDWel4=;
        b=d+/UGRyPLgXnShSLPMfl2NoZdUCnty1AtzGW6ZS0sUYUi3yeamfusnUGi5Jc4DsGNA
         UiRRCA4fq3x+I9Ie9kjfTjYwJb6wnITu3s7W0sxaw46voEtdh+s6z1iGdeEzK+KZsNVy
         aPCdoDqDsk3qh+njwYPya2RcZSU+soLsvE0jGArEVRg3i6hPtkREnJGLWjwFuiF1Xg15
         xQ7FHURxm+nWLRcwOp0+WQg9aG72rAvdqcrn6HZseS1EfPP678/gPVSXrvME/Sy78cOk
         bLbfhwzCRrif48F11Nyjyoc6EHmvIowQ6TaYH+o8w1UXkIu2PsEBDzMoY6OGMPrdg8Jx
         /80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778376226; x=1778981026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k83FvsWSelsobvUl25t3vFW44Bj//lrGN1EzdGDWel4=;
        b=rh7fNUQomwnEJQyXYqT0cbyq3ex0r/FL6ydmljwzjkIGVhHkiylcMuDZHKb8wz2CC9
         Xo8aEg3TVcMk9OCbf5YUs47koVcr1NZMbs2y7a+1ghFpjC5h+9jwAlB5hCXz6ug84MQl
         4iOHi+tCF0/b9wMwJqx2h+eE8AlTm5ccNAOHnuO4nXKSsGA4XfXf+ejzbBEUaV1HYh6S
         ucQ6Gq60yHHU0SlU1QmvPB9nuuffbVo9YZyJwdM4Aeob6vp1dcDaW5J3Ivsls/UF+kYK
         mD9npXPgEUdDXe7lQcTAzPhppQrsypta2YMLbvO8PcbYpU2PdGA9DdXBZCwDN4I8sZbL
         +NIw==
X-Gm-Message-State: AOJu0YxjKRgJdq/c43qyJWpYh7YqCMkYKm1yr3nsm7p9nSueMeVtdtzv
	r9kVamHoCDIGm/iq9sGovBIvmamNTGVpypR/lYiAKoMkFxXoAKlGXNNH
X-Gm-Gg: Acq92OHlBZ39hQGKyOwU83acPGEUxWCuM/nysZhH3gxALuxkOSlO8bap5OF90rnmoB3
	S/vIvPYFC7aQvGMI7eD9wGjELOkZFJSpbiE+RRIg5wYYUTm3PKSeQlHQjD960LCVLITeiNZ4+Jj
	xHna3sswXR4BYAQTnR1iORuk2EA/dBsfOgx072YLY5AI5WlMMzHM3n4eNzJRAl3EibDzDygQ0XJ
	NwHb1L42VPdoAomfsXfjMd9KK4Har48NJm/LpYH3RH9WaKi2vtgwxsNY4jg2IV9Bq/ZEK/1JW+C
	KrH8YgdCDz4fs9pDnbQfqngC/Lz+EcAmwl8ytWpR79NzHh7eriRjlu+6aQ6c4H2DtkLiywvENZN
	pCccN3NzaOJbIRTbw0JWfv9zcS0GaN7+QF4lSlMB6dElVqdjOxxfIMQ77yKHdyO9xLTZvjf4Zt4
	r+Z+zRL0VQE6BMOTDn95TVntGlTW1eE/UNBUvww5wj2M9tBOE/6RFmUjRz4lw3DZXwXKjB2aDMg
	n3pbu+mEKHZwDLXwc5UIwCyXbRvlOM=
X-Received: by 2002:a17:903:1a28:b0:2b9:f8e9:70e2 with SMTP id d9443c01a7336-2bc7a990b6emr41452625ad.8.1778376226401;
        Sat, 09 May 2026 18:23:46 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:1949:c5e0:289c:ab19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d269fcsm64648875ad.15.2026.05.09.18.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 18:23:45 -0700 (PDT)
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
Subject: [PATCH net 4/4] xsk: drain continuation descs on invalid descriptor in __xsk_generic_xmit()
Date: Sun, 10 May 2026 09:23:10 +0800
Message-Id: <20260510012310.88570-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260510012310.88570-1-kerneljasonxing@gmail.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
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
index 232dd7126905..b41ed44e3192 100644
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

