Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5638B152
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752457; cv=none; b=X6TUE/SbWmjADsDpgRy4a2WSazCFafzBi5CkzfW9+f4VV2hy7WitEQXZQmj6P5rpn3zrpdRJvjVV3rSF7Ho+JUit6s6s3GXwDwvo3TAwqRqqDbILiAwySpHNbEP6kFEJ8wvO9wVOZg4prahP+ah8BEXj4oCAkfRokZ0o48DEWXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752457; c=relaxed/simple;
	bh=+YpubXTqYL6p/LBM2xcyraCoGtvRPZckW9SCjuULUpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMbT2Vpw8ZuPPNtXD8RlGp7TkkAEGRUORzKiFBIMT+N+FFR8l5RvcgHO+MqHnrE5ctAer9/bJBfrZjKWWfWVcraPETqsUUvdsheeF82v54oIEq35L8PEpZK1+g5lg8vTgbmkNnJChnJJndukxhHy81PY4gSvlwjBw3uqOyTjtIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnFsnUXv; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnFsnUXv"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67bc8609a9bso2553181a12.0
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752454; x=1778357254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHOVkZbEluwxEdvBl/xFayOrth4UzlsG2h26MqrcyuA=;
        b=XnFsnUXv5oFgvT2Pr7iJgAyMsZ4F25tQeApAMim2+fAWGjupFY8/JIQmgb4GT9d2Z9
         h9eCVw0wBPR2UC8fGT7TFcEgSHarOnxwjkxDkhLRHCjdW9wkfCsHul1oyHx+v0ZIbux6
         7lLSJnjhVhuxYGUiVWnMvysfVTz736kCK/w82Y1Bxhjp56DCCfTgk9EiBbRawqu7pGb8
         wy+TiOd13qaIlxSGFX0WVI4nNUiFILctgYNhCmt+IdDUkvvBdgierUDmYxoAICiDZfAA
         1fUrlL3WXMn0NiYPOml4Z0BdAa5urzgb8dJRHoJI9nthU9yz8+/THOJzo7K4PUlDx2iT
         pmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752454; x=1778357254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NHOVkZbEluwxEdvBl/xFayOrth4UzlsG2h26MqrcyuA=;
        b=Qohu8xkmSqokWe6jdY2x/0vvpb8Ey0GgmBUH80SP3MCV5jRTBFFkZ18eVMzLtVHGYj
         lE+lNyz8CnvDyCf9EVwdU7WC8A6MT9ghlBWRm95IAsjTPmHivbxSIJcmzrHnwOGsZaS/
         LwfGEEbhpdIrDRPjzY4cEwX/5dvgolA+8eX9DV7Xbfnx7nRe0KNWUFswjzNneCN3e5+l
         zdJhyj0jgPhy+31+a8Ls249TXALQ/nISGJGuaR88lsV2ID6WJF6Vlj7I4dle4d9meVyO
         +aCfhtrJR5LMK89JTcUrY8lHtnBRLv+Z71X6LRkR4zqtkqG4egasmq9fMATyjoKei0PT
         wUtA==
X-Gm-Message-State: AOJu0Ywi9FYsIV4gDZ6GGOHZEQLVLPv9nwhm2cIEop8GU4qHPkyOBKMT
	nMbxehhDffqgsmwHEGulHlEBHUo7+dRfr8+SmmUiAw57WOkKGAVLtVjq
X-Gm-Gg: AeBDiesGOFi3YZOPeF1oihSXDf9mnNq/3AFfwjlj+wLeb8m72F8TTHyu9tFy9b942mP
	r9GbG6/IbDDajcTnkBwGcNgBPqWWlorkPr2mC7JS/LstHPg462D6m0HhxETSmXLyWvrU8jBJSIg
	F3KP7fbxrqm9GpqEg1l4wpnxzxSy8KjDX2Ty9nGDNVXYt56R1ULBPWOAxhP1wlUERC5/fw+m2pR
	zc05iTG+act/GBdX9363BIpBDqF6nyxRxF1+atAH0UO+nDUY9iwfEtcZxB5B+LCmfyIz6qmz/Z7
	xWXR7QK7HZiLdE9p+xdZYUfI846pmTswrR5JGl6+4vgeyysiWDwRQzM4D0azkO6sS92VyoSvLJF
	XeIVHGvyqdgcqntfX9BqVkMA1Rexfi2qnDGpbLPHWLdfGLT2GeOpfd3X1GvJ9W72pDHUZBaLGUL
	0haKUlKYo/fSmNMeC0Ms5DCuTpF4XfdG+Fix41toUcoMQz2G6MavnfvaQZbasPFU5Zmmb5OWElZ
	ix+v3SqLLrikY4sA+odWL7qqT40
X-Received: by 2002:a05:6402:a0d4:b0:670:6b0f:f77f with SMTP id 4fb4d7f45d1cf-67c1ababf30mr1346182a12.17.1777752454243;
        Sat, 02 May 2026 13:07:34 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:33 -0700 (PDT)
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
Subject: [PATCH net v5 2/8] xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
Date: Sat,  2 May 2026 23:07:16 +0300
Message-Id: <20260502200722.53960-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260502200722.53960-1-kerneljasonxing@gmail.com>
References: <20260502200722.53960-1-kerneljasonxing@gmail.com>
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
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6149f6a79897..46660943c81e 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -776,8 +776,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	addr = buffer - pool->addrs;
 
 	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
-		if (unlikely(i >= MAX_SKB_FRAGS))
+		if (unlikely(i >= MAX_SKB_FRAGS)) {
+			if (!xs->skb)
+				kfree_skb(skb);
 			return ERR_PTR(-EOVERFLOW);
+		}
 
 		page = pool->umem->pgs[addr >> PAGE_SHIFT];
 		get_page(page);
-- 
2.41.3

