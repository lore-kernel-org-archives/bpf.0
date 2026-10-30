Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327588;
	b=W6Kjv6EwhdOKSHyFfF/yAu9LcGsyt36Iu3K4/8mMWfs6DixL3mo+nC9aY1cfNd9M771D
	 mRyjNJU0rWhze6x+NnqcWTCiwR+TUO8w0Y2456/jimmUgSV96A82vzkuNBB8nNJZlNy79
	 6xz6Zf9b4k/LqByAPktsq4HA1CLhfVUXn08BA7zJGb3jjRrLmHRnuRAUtTcuL6T0UcAss
	 vbRg8CleOpp0OByKtkYuRunlWnGegld9H4mPpbfK8e87LEF06GCCbDbQKqCIFJ+QGt4ct
	 iPORAlZIMLRZ4GUynHVKfvywa0DMNAY6XjiTxThHYvJYD8p+t8Ie0d5K0eJFey1VPKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
	b=m/5SlGhYjJwHYIWuCTyEw5/25/HYIq5XEUafexMUoZOrkj5eGmsOrfZTbyrAoBvCMFFv
	 63lHgTPdNq1fLyNVTe1d+8FkWDrPdBv2Rp9cJaaKgMMbLAHKVcAc5+k1pkJSAAZGHF4cw
	 9zBi60hRic6r7QJ2ia3xG8JzvLTzfSwqUzyC9vvnnb5/KTYa6Bz+XCVQ3ZIP3I4kba3Cm
	 8yx6hcqGKWcw6/o0m8oJX+Y2dPrK+yfV4VbwwOktmO2kv2Tye4E3L21R+1Hhbd/kGkFHu
	 8BJa+LiOVKdYLRzM933p3fkLAnyD8Vu9YWyone6u0nuft3T/10risGPMP4ATauiaYyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QyXdKLmK;
	arc=none smtp.remote-ip=74.125.228.6
Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557C606A31F
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 02:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D557C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QyXdKLmK
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cd61053473aso2924a12.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 19:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793327587; x=1793932387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
        b=QyXdKLmKaR0WHK0cJTyFaUEpfibyyQ5fW3kfeppI+vJOMhX/FDqjeS5UvEkcfOh/Uo
         1Wshvu8W9MHdPi+8huvuLQyvCeClepU067PEo9L6qJSpL3CLideAGORYNP+htWkiex35
         cuuJAzAs60zHbt9J/E0/3obXUk5lF8JFwiBzv/wsVpJ1WGdxrVyuTWIJjTIDNVs2eKAo
         x8+ehuhDeYWrDvVihQjj1onRG9tt+RHuw9H+aoVnYhPozwBhthzYcwLwFNEn889tbE78
         qia9oIKxu6TAi7PmpnL4ocyoXPtmVJtBOpTsYLyaFb6R2iZyosdbH9WnJkpghCJWGGoc
         Mc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793327587; x=1793932387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
        b=PMHBs730NLnIVSkh9er14hg4u7Jehp5EoZZ4rajN/lGd41b1PvDkA2p+Cp5yMe99jJ
         MTrjoYCAVYdBu7tV9b39oed9UsDVx4lvzC0GiOW8Cg+s8cgikyioEFL/gY4kYHX9sEDv
         VTxzLyvhQL64nPZS9j/qDYvUR8LhAwbdwghPt5c8/uMBNDehQDQ3w7k+fUv/6yE6cvVr
         8c95N2rStS4Rmbq54oLTGVqMFm7PXvSK06WO24lVSMx7rkzzsjgw+nR48Pd3nxEqPYyX
         63lLrp5Hivenp99EduRoNjPGGGiqbiaF3q/5BslTfjfVT4FzEPbF3uPeP1H06E9UuvuI
         VO7A==
X-Forwarded-Encrypted: i=1; AKwUvByySCUAtV38HRZxEn5GHW+JFgXgliRBguEmPuBAjYa6rSZzZTdTDXd/bukVc5icXx8lXsI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtLfGC7aPQgrMmAAYDCE3LHviXIU7/IpoOuI4WQILlz7VYhq+S
	55rpj+hYFQHxGzY4Hc2l4PrWfREkA9LmDcFDlWYroKXfMR9wBXqwI6mk
X-Gm-Gg: AYBFou06OKqvB3KLGk8oL/o+HYvPXhlTrUxgEOPrd981ZIIz63OhicpGu+ZMZE3IOH5
	UZbAER8o/IqdxX0yjQ+Gii0N7jVykoa3xKDXyb2KIk2JcgXscNfaiYyPy76OTtuC5BwSV7MXfOI
	BOlJxlSQn2712iRxc0Rhbq073JP6vFQ6sKF9j03zC7pXXihvp3ePzTSw9quzjX/4LfJUljwlTcg
	mAsTzW3k/nGy/XglsttSfcO+oJysesXJtuetKV7Im+DKOCOoFzepBptF1DXau0T9hXHkpCiaIfQ
	ZBhNVr/dX4bpwE3rkSYjlEQ/iqwOYwJmKSViwcG46FcwyPlz3vQkuxR54llV7aCPeonr9RMZx4+
	RBDGGVI1yiP5VlBH7+YYd/JnlKJz+t9+WdURjQ6C+q/nO0YegYCdCb3zz0dYkeB3xHRZtK528he
	vxgqcoqUcAOQdZrpxgdxZffUHmkwOYORWFjrAJmq9mS3u3V+XbqHasPHJAOKDyKqFO7D/FLMFp0
	Y36tMIB1vEOl819KifwR4h03L82OFhOuiJSSzFqoijkVQ66BaA5x6x5w1HYUAIqWLpAIhK+mrmw
	oo0edrppfy6005QQtcMjtwxyTSwn79MQuoqPtVGAKzRi4U8kOyo6L5M=
X-Received: by 2002:a05:6a00:a256:b0:882:2195:5a73 with SMTP id d2e1a72fcca58-8a9bfde0494mr516804b3a.29.1793327587137;
        Thu, 29 Oct 2026 19:33:07 -0700 (PDT)
Received: from localhost.localdomain ([58.247.233.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eef95f2dsm152216b3a.10.2026.10.29.19.33.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 19:33:06 -0700 (PDT)
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
Subject: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
Date: Fri, 30 Oct 2026 10:32:47 +0800
Message-Id: <20261030023248.78802-2-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261030023248.78802-1-testwrzwrz@gmail.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com>
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

