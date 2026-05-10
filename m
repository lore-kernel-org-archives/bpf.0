Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D365A1EDA0F
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778376223; cv=none; b=Z0jcBa2dYVKhLQds8dBhrw5IK41gINGrEc2BlTA03FJsPui+GcOKtZJR38MHtwbnEaWjBNlF7dkvcsAtoMZr0LlNXgat8broblG+iyV6ckV6S3dwyzkK3Jco2tHWd1lHZJIs6068tAd0Pz09HtNMiQs1WuIWdsga4stq5J9oAcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778376223; c=relaxed/simple;
	bh=iODLSWvYErewxkSJ4DWoizA7FGAtrQRwNwqk/ehR3nU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kmQs6a3a0aFgA86NrnIuLp/+3ry5drDAVYcrjPRtSi6/d7uJpXZbKbnNOqxy2EXKRDUkFzQfiiGI17NdnwWea9Oc9w6AHSuECxYByi4I8J6DwBvv8jCccCR0Y/Nb6ykeq3ZA0KheNj7mE8sGDhtCaXgmsbYstkRYquZHXRwJpf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bgl8A6lS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bgl8A6lS"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b941cd869cso18893745ad.1
        for <bpf@vger.kernel.org>; Sat, 09 May 2026 18:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778376221; x=1778981021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKyBJPKDix5Ds6v+uMzeJx1wbcB1pTmVkewQYBnHqcM=;
        b=Bgl8A6lSTdu44sMGAV/a5m3XzfvWaBaupwgCsN3hcwXxs0xg3jqBC78rBFkCy5Bf9B
         AtWbrHoCB+ifbduXvlM6uEJUJknSEfKTZi5RocuD8Dxc8hGvrNliJScsqYU9BQsbsJSK
         zif/SpBRyGFRrJTkbYErmx5DNDxgZbsYQRQ5T1J6IQAbBq8yzxUj7iK0sezL9ooOIb+d
         31M/JMoMYiZ7WGKCy0NHoywIFl/QF6qCT/5v5talfsLY7JwTcSt245FDahO2Dk44/jW8
         kz0M1BCXUeaUBzAltqtt6LCmFlRy03/ToIAUbcXDIDDzTpdTxdLJpI24IfFRP1YzWatO
         foeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778376221; x=1778981021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GKyBJPKDix5Ds6v+uMzeJx1wbcB1pTmVkewQYBnHqcM=;
        b=BBng5CgXXHLoqow8BKeWZFh1PiasL/AGSYYgQWBEJwut/yKoOiFMz4XfJNk85s7Q68
         +Wb6pWDjsRVmvnCOlGxrN96cRkgqZeWU3L6SQhCfALIhYlv7WzYuG2E8nDvesm7EyVKw
         ZOxyWBH/selC5vTIPs/y++g9rgLAXkvfen/Mt5SQ2xwP8FGsW4pMMwzTeEYRkifSNxfM
         XHHRodEjXM7lqhR36Q3K17K8g3re6bN5k2ni1kvctqBqaYoDX4rSBfT0n2zdWX1H5rBP
         drzA5zoKYHTF96AOrlULtxeHuPsmqHC0mJfPjBjeQtH+rgKrulfFngVlfGq6E07k65Nf
         Neyw==
X-Gm-Message-State: AOJu0Yw2S1RnRury/HvMVPns8vvphAwNqFDAFR6nfcZg6ATTcbF8+U9A
	0TeaC8Dw1AdKWqtSvr+IjA+Bo5JwHkUPG3eUTSWHZEMVbzhXXrjkqe6y
X-Gm-Gg: Acq92OHExjUTOcP02br+gRHb1fM4TseX2HKIlMDcqKQD9fT5XswvhVZDPGty7u19go/
	eM13CrDCz+UAZH/VQTcRR9r2iDME8J+aUdenXFHi8OKLGJTMW1281jBitBnTs/2k/BHsl2TdWpb
	Q2dTifeLsXqHx5mQSyx9Ahy5cFQVLWYkqXd9nZ3QVJwrhcirWcyQjhFtLEmn9lkem/29JMLTgva
	lU3UedV37X3HTUGoNzwmUkZ0nJ5i5COo9XM368Jp1aPsbhH1WEsYktOflGjwA9PuYftr/NYXP+R
	2yGEzOC9kDsCK0WJvc35hzb6ysJD3JvpG99Vn4GOaXxqFM84rNqGf9JncsIof3UGi7+dMENzQHj
	zDWhIAenEnsV0rlNNmwtKx6cWENc4sq2wcmDQQosoqjHKtg7M4DBBH0dY31WXliy1aQ3//hlbYm
	FYOzQN+0eyvihMfRbSbVAwieYSN8qDY5vAKx/i5VPWMHixC+yyd2cit8aRWFT67rPx1KY1hXbZB
	UR0ulH9h9F7kyrpbtcu960wT6zB/w8=
X-Received: by 2002:a17:902:ef87:b0:2ba:30fb:d777 with SMTP id d9443c01a7336-2ba78b3fce3mr129072165ad.6.1778376221049;
        Sat, 09 May 2026 18:23:41 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:1949:c5e0:289c:ab19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d269fcsm64648875ad.15.2026.05.09.18.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 18:23:40 -0700 (PDT)
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
Subject: [PATCH net 3/4] xsk: drain continuation descs after overflow in xsk_build_skb()
Date: Sun, 10 May 2026 09:23:09 +0800
Message-Id: <20260510012310.88570-4-kerneljasonxing@gmail.com>
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

When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
only the current descriptor is released from the TX ring. The remaining
continuation descriptors of the same packet stay in the ring. Since
xs->skb is set to NULL after the drop, the TX loop picks up these
leftover frags and misinterprets each one as the beginning of a new
packet, corrupting the packet stream.

Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised.
The main TX loop in __xsk_generic_xmit() then handles continuation
descriptors one at a time: each gets a normal CQ reservation (with
backpressure), its address is submitted to the completion queue, and
the descriptor is released from the TX ring. When the last fragment
(without XDP_PKT_CONTD) is processed, the flag is cleared and the
function returns -EOVERFLOW so the next call starts with a fresh
budget for normal packets.

This reuses the existing CQ backpressure and budget mechanisms, so if
the CQ is full the function returns -EAGAIN and userspace drains the
CQ before retrying. Zero buffer leakage, zero packet stream corruption.

Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  1 +
 net/xdp/xsk.c          | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 23e8861e8b25..1958d19d9925 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -80,6 +80,7 @@ struct xdp_sock {
 	 * call of __xsk_generic_xmit().
 	 */
 	struct sk_buff *skb;
+	bool drain_cont;
 
 	struct list_head map_list;
 	/* Protects map_list */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 3f1e590c855d..232dd7126905 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			xs->tx->invalid_descs++;
 		}
 		xskq_cons_release(xs->tx);
+		if (xp_mb_desc(desc))
+			xs->drain_cont = true;
 	} else {
 		/* Let application retry */
 		xsk_cq_cancel_locked(xs->pool, 1);
@@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock *sk)
 			goto out;
 		}
 
+		if (unlikely(xs->drain_cont)) {
+			unsigned long flags;
+			u32 idx;
+
+			spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
+			idx = xskq_get_prod(xs->pool->cq);
+			xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
+			xskq_prod_submit_n(xs->pool->cq, 1);
+			spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);
+
+			xs->tx->invalid_descs++;
+			xskq_cons_release(xs->tx);
+			if (!xp_mb_desc(&desc)) {
+				xs->drain_cont = false;
+				err = -EOVERFLOW;
+				goto out;
+			}
+			continue;
+		}
+
 		skb = xsk_build_skb(xs, &desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
-- 
2.41.3

