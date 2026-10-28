Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793155843;
	b=lgzXT6dCo0xeu6kFzNfTgErHh2wJMq+r1TLUJbguUK43UKMYA5Xgkh/f1Qo91tRlIipg
	 EhFp0ZsiUt97JZqIcxSDeiMClxky9TWk3vkkS53d3YwAyr201OqPXE/xHeV+j9fc1J4mk
	 xMQ+BI/6vYN4Ga1jBvQmfbqvrmKisXAxNTySYHeSDTgf+xFvNl9d3tNDT93VQ14n0Uvjs
	 3UhRK4B4XskDV033blD3NvfCx/WISyNIjOi5z82s9fXJ3OpCPUSJUUWKrzfTEPzt2JrLX
	 bA8L032hHeoAVH5y2D9BadAyKbgZ9OXi1UspxrSJSxpX2W/sEtqzoCnRMbvZFg+6axw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
	b=mECJSpf2AGIn4BseAHsSBiIRN6+iVh5XXFngmq+j3L7MbadRxbvCWf2qv3kLr3EtFH0e
	 jf86B2wzsBo7co6Fem1Kp0oFm70gXbSqltnynbNe8okznx+0oZ4gXObO8YGEOa4wDhDI2
	 PiNci/PhAIyAXhG2jXwTFgSo6NgwDf42qcyquj9rexfRJxadcof2tw2151Q5Ezg/Vvq9+
	 Vpr55tdzdbkgz26YmW3csApAAZBr7D6WqmLp+78G1taN7cf2PZWuTFiuXtkYahYEZD3cc
	 ZoP164zmZsVIHpzOHs8EIeIcKvS3QMjP6MRYvwH6Qgr86htFAKms1QUx+axR2XOev0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sIxGQVuC;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F2606A31E
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C80F2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sIxGQVuC
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e651c30dcbso1282235ad.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793155842; x=1793760642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
        b=sIxGQVuCcRBJM4Y9dM+uPj1MqVYGHELdrlvbHCe9zroN36ORPXLLIpUOw1Y6USdWW6
         7ef1iCd9EeBB9i4GBNCqUBO7kig/5+eAom4R2U2fo1nCFMDbzDqNlVamlytn9yhKL1GU
         RuSCEC78ZTuhxP0oIx1itKjzAX43wQXc4JJ2uFJUXQBy/kNfGdzUPitJ3+XEamRRz39h
         VElrB6cmCShWH9Ye/+8+MSZ1V5L/dOAjvzwjyMmk0TUqbDEsTAEobny4s4FEoWzyZZc/
         RLFqY/AlU62Pu+5gGGZv0DS5CwCRjKulSHKlzlLuts/4LH0iMOUeyGZ8+8jAxm2hsAbC
         ExLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793155842; x=1793760642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
        b=TYkRwQqlG62zNgLE8obJFzfCczbclazJItJRyTQjtpex6fHiV0DGDguvNs+yvpn+Lb
         GtGfSkjmGOAOFPWbf8VNtCnz6XMyNhkAjhP2dxUiL5O6lbntKa8a2fyIMadrJE1NpMPZ
         rZU4B6qgP0kPRFmwO24oG6IhAget+2S7b9K43bOqPGgHUMLzgn9vHcoFm3RlKJbPELl4
         2ClsvGo6+g7HKf53MmgGjMFcBuvZSlGOg6TMRR4OfucO13PGo76G+w+XPtI6oEnLWovc
         Z6hGHcoLv9JyfLxCYjBvqLYIKgbLsLADHrUUF+9Tzc8pecsegtsF0sVuT2Jcgzf3TcnW
         eFQw==
X-Forwarded-Encrypted: i=1; AKwUvBzULEGEptzE/ZFeSArpI7WmhLhN9xyKqXYGwaqRTFDvYpqMfYxofivEbb8RJvw1rTCo6Ac=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9R6uJG1QOh0d7Wc6kS2PmzIJlWrI20Mq6fkD18BCismRZQ9En
	gE8RlU0onOO0r/PqkABQi4qCsINQURNqBJXkW7oCYxM41d6wfwOd2jmR
X-Gm-Gg: AYBFou2Bo6xQZbLHbhB4tmCi2WbrRlQOyQwuVIhoZsRj+54/qJsw7niwiO1uGjafRGy
	wAAqva1jD4ueCA19JLMwtw8Axdf9iEl7L9Z2GHa4Ki7NQnIOQX6umEVSWq6UsllLyAqY9iEAQ38
	iNgHOo8hB2FeGIWckpQHbK31Qz0ibdY+x26qOS9FwL1tLhYU9DMOZd6/ngoQaGs5zZYOJhC8YkP
	4C9GxXNJf1F9BcojELH7GKOEzGMHmv+mrkIjiFlLOAPT5qMk+g+Pdcqoo0oorVYRTGdA/7RlpYK
	OpnDXFx10wJgzAtJVLuYyJtzWkxgGpe0wDewSZtII1TzsR3uZdUOq3pmfv8va1ai+WjheKP7O3S
	QceCclH5vVTAK3j3vDZv0GgmwkKWMLQ/ePR6WOqqmT3HfJV+uo0hLnUjnPbpjBYgiLWs+klk1Ng
	N81NOymnLHWfDuc7WcOZeQ+F1LLkS+czkrV0HqwxI0brXhLGKr4Fuqhzgm5lYVr6nUpIQgyr5xP
	g09i/V4XzjouB9W+GvjXckOX+LYKtqKJxM8kKoRZRKJvilck0AXff9+VIXDPZGdSN6S/WcI/VjY
	yrSgJaNpSpjTieG3SSIUHopcBiBOUp8qSpgFLjSR+scMZO+QrP0A9xDk3Mq0OKQ=
X-Received: by 2002:a17:90b:280b:b0:3ac:7c52:faeb with SMTP id 98e67ed59e1d1-3ae580df868mr793396a91.41.1793155842143;
        Tue, 27 Oct 2026 19:50:42 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:1d00:2b84:48c6:402f:d1c5:644a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d64c0bsm812447a91.1.2026.10.27.19.50.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:50:41 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v3 1/2] xsk: defer software checksum until the skb is complete
Date: Wed, 28 Oct 2026 10:50:25 +0800
Message-Id: <20261028025026.11401-2-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261028025026.11401-1-testwrzwrz@gmail.com>
References: <20261028025026.11401-1-testwrzwrz@gmail.com>
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
Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
---
 net/xdp/xsk.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..aa6b010192ad 100644
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
@@ -1275,6 +1276,12 @@ static int __xsk_generic_xmit(struct sock *sk)
 		if (xp_mb_desc(&desc)) {
 			xs->skb = skb;
 			continue;
+		} else {
+			err = xsk_skb_sw_csum(skb, xs->pool);
+			if (unlikely(err)) {
+				xsk_drop_skb(skb);
+				goto out;
+			}
 		}
 
 		err = __dev_direct_xmit(skb, xs->queue_id);
-- 
2.39.5 (Apple Git-154)

