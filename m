Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185D8223DE9
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237804; cv=none; b=XhQn2mB2rro25e6QI7419lUsrXC3SOWWErE5gbnMN/VcJk4lKAmJTAPfjbcAX3owMQo9CgGap/PrF6eO+53DjocqOkIkhKusdzjjVIJvi3OOnrb6utrq7BFMK0b8FKJxxB10vOW4zJLOwc+OE06VkTXTNdOdL2cEsAl8Le4mbRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237804; c=relaxed/simple;
	bh=5Z8z7HKhwwzvGQ+DZhaWBkbpNq/wQQwAj9Cy5B2t1Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gy0HNBo+EUCy4mqjdLrEWmizTFX4gf60/qyOh8V57hR+0GehC6THgFNwVX6sSaL3Jcnthr6aHuCUpQZ5KjiEPzHceAc25Jjl7lXU1FRWHksrcJHyWBfaglkeieb2NIYuM46fshN8wYM72wxe7eMrwDlHAGWvxfEHqUBUoPQFF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNhkK6p2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNhkK6p2"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36643b96b99so3934340a91.0
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 17:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779237802; x=1779842602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5tN8/amkdsPzdOUWFuYid/fcYnfAgsm8Go1nkEmf2k=;
        b=UNhkK6p2/t7s9h8y33hYYGm9My5cDwD5m8wb34veX1CEYKbj219DDdGMwEXQq06mXo
         SYH7RK57sUEO+pTP46LHdireAxH/w6Fw1aqAtT4tC9GEUgVthq3rXJyiyHcbrvxEMg8D
         gs5F9ObI7aK2Zy4kzXt0cUOve6tqwmJ1eu1uOa0D83mrqT8Ay+eUeZdYQorn1mpFd9A0
         X8FNErYHB2qLKKFxlGfOYrymLdaaGpb6cvM6UBqb//Yd7W/A2CBkm8kTjjpyc5XzkNwp
         hON2E+WqgW5mEW9EpkixZf03u/sT2AngWDUgYcgeAmQ7TNMoi4lIz/ONf0YugXdSLJyG
         FKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779237802; x=1779842602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o5tN8/amkdsPzdOUWFuYid/fcYnfAgsm8Go1nkEmf2k=;
        b=K82adUdh1/WQU/36O0PgosIQoinu5yvXmSzBRyHNSl3M9Ikb/kj7fUFG63uLB7l0lU
         SgTYxqusyvOGiEaBspXSRTdnSPuYgtLFNbcJFzavsdud5u5Cdh7PmkcyCaRpNhdOXYgq
         7qoW5f70M0pmlP7wURHiyJRldBDjo2jkmtADTQkvjFhdQlh7VfEl9ozerlvjeprDWXXn
         giMRiOd+NkZJ6GNUVMyLhsFFRCkbNSKIFnJo5FUGfadqp5Wz0DYVkf9XWg0zLpKthAlm
         P7uKehMQyDApjmhUzS0o8WEgvjCWlERjj8CI3tyy8m9TYNHs6xMjw6cJhJWxGe9Wdfty
         Eb2Q==
X-Gm-Message-State: AOJu0YxRG5lIM8Ygcy1R9WXMj3SXryG9iSft89aiSUCt4toDD3i4JAeL
	qFEISac4FE3jKbwP2zt2lihSVLm2c+ghw6MB/vQW590LRsdSTzJzChSW
X-Gm-Gg: Acq92OGy9l+Fy3xU0wUzHGFxYnSqStjXEExOuFsisns3ghMkxHGMtQYfwVUEoLG8XCF
	I7u1/quZ5+B0FmNXmYIjm/VKK+Zox0c215tbvUPVvQfJrIczP6d/gct+6bH4yaDLk2DY2y2qzDL
	ge4TAY+NhwpKHNNm5/qjbUieRN0G1chuUHEt+t+f/YO5Dt7fUzqQ8YYYikZoApxo5F9tEKNAAZA
	k/YXfGm7Z9WOT21yHMSXDd6CjjGVYEqFJX9rGaruKSKaFuUqVJU3EfmFNtC4myUFLPXlJgH/GCm
	3/i1t08s60Gy5d/O2i28VfxMFwDIIEYG5RmKULtfmS+tqICS95O4iA0volSsNsyx1Sc3zjw7qaC
	oDkPkzJJijeSqtYu/G+IoUuRdSWKs1hYby67NSF5Krn+UtcLBWAK0eeITQkOEe3XddC/bdpfQ3s
	lfG07xTgbGWWe9mAkr7ohp6yaMbOBTK2BMfqJaOwItFFbWTIXQn5OvJF64pA91fBaiVQZMy31w3
	rgoRlKl3Nt4/1GKGf5BFqskNkuXWh4=
X-Received: by 2002:a17:90b:5904:b0:369:1dcf:4a56 with SMTP id 98e67ed59e1d1-36951ca8d1amr21589269a91.21.1779237802511;
        Tue, 19 May 2026 17:43:22 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:f1df:d520:8103:19c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951059f4dsm14746277a91.0.2026.05.19.17.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:43:21 -0700 (PDT)
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
Subject: [PATCH net v4 4/5] xsk: drain continuation descs on invalid descriptor in __xsk_generic_xmit()
Date: Wed, 20 May 2026 08:42:43 +0800
Message-Id: <20260520004244.55663-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260520004244.55663-1-kerneljasonxing@gmail.com>
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
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

There is one subtle case: if a subsequent continuation descriptor also
has an invalid address, xskq_cons_peek_desc() rejects it and the
while loop is never entered, so the in-loop drain path cannot clear
drain_cont. The post-loop code already handles this: it sees
xskq_has_descs() is true (the failed descriptor was read but not
released by peek), releases it, and checks its XDP_PKT_CONTD flag.
Add an else branch so that when the released descriptor is the
last fragment (no XDP_PKT_CONTD), drain_cont is cleared. This
prevents the next valid packet from being incorrectly drained.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f4add7be8c93..de953f38b9e2 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1122,6 +1122,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		if (xs->skb)
 			xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
+		xs->drain_cont = xp_mb_desc(&desc);
 	}
 
 out:
-- 
2.43.7

