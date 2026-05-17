Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDEF2DA75A
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999621; cv=none; b=WVlrnCdWFgf4GA2QXKWO7SphugruzXhFEjYvnxP8p/8hjENCjj9hce7vQswf6qYjk6R6/LQ99vN5pftpl4BJdwh9FHzU3/EseFQh/gGZWzXFqn4acDnK1Ly7oIy2szPE5XPcj7xzEIEuBt/NP6jV74wprT67CGIFnf8Oz8Rig4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999621; c=relaxed/simple;
	bh=k3b0394omT1f4PYEbg4WW4u48Wo/a0iKcderA707Y4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qWMwytVMIlm6QG+gGo+6k5t30BcOwh7zYv0oV1rBTcQekIxl7Rp1A3RP4bVbMdKFqpKVsblhmdLxUE46+Oi5Tn3s3ohwcHESim1Vhv0d3whYHMeZvyr8HEwBvHe89rNKZXKk/zqrLYlE4qGixlTR1T2YEthSkjfWOJPBLWZ2ZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxVlCBBE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxVlCBBE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba0714574fso6303445ad.2
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 23:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999619; x=1779604419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qIcIDsR7wUPxzefQaUFwMlxlmc48CLmCnqZRB7TdDo=;
        b=JxVlCBBEUSmgD6oJ5EERoXmIl/AnwtvxXYbse1baoApsiIgMd3ybStMMe1sqo/g3D3
         PxlKrbe1mCGmsEjnK7b0/QTHRmMGF+kLhq7wzZ17av/bMMkqbdWQ1sDwQxdm7ba4Jbd3
         +P1yJ8kT9uwDBKYIT+h8CgXaBE1NxvVLJ8mw8OLBa9LugnD4eRTc2fmPa2sVDeCS369G
         ZvqxLLcQ447YEq0lb/x+P6aPttU5m2ZHwTxtBjxqjAH73Tgo67FmLOuTdwxkXLTsClAs
         QkIXcLHHMZDiJCMZgL+ZVd14t4m8bDBMQyB4Y1Uxz8PgzqCy9ESqI6mGcCvubP2W2JGF
         hI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999619; x=1779604419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qIcIDsR7wUPxzefQaUFwMlxlmc48CLmCnqZRB7TdDo=;
        b=bx0D/d2XiRu2h0lbKNoxmFXYx1LCwx/Eqjk9aG3jPgnd6yx1QhTMtAWTlDgD5oY0Hc
         OefW7NMzZB/P2GqLLlLcJEXAj4xvqKGDjfoGpQXZh/naN13bJJteTDggXrk3tSJO1zve
         2rdP2uBVdZ+pFydgohe3/ohhnfStFLj7zM6+J5XJR7ulvTb2CeoE8b2Br6Q1+JefyAqc
         G/YT5s+NWHM7EP9mzNdkrld/0RTV8SFfHHyu4CAY1edELLIcn0dclEWNDdHkZVif0uF7
         7XDADCujdIY1xhUuKjAeu5lLU9nnF58j/rpxZzklDgIWkDokK1FJzgMKJTa20fQJyjr8
         J0yA==
X-Gm-Message-State: AOJu0YzJ4a8EEOjpXEJqsulhN/cc9TBv5vJOIYzYtXcL/iIGN8x+XOT2
	Dy1syTMV4/75zKiXoZMUF4CFBGqu9Pg1qu60aOjXlwvAL1YQVvgy/gWkrE8e4/f4kxIZVw==
X-Gm-Gg: Acq92OEH6l+B2+kbCMwji0QJ9zbRJBlr5URemt4S6aFhr0w7ExP+YqGJ0QONM5euqra
	MTcBYI1np8467aLRcQhx/MUWU93kdJCMI4POOpYFkK/4c1m4FIKw+Xk8dKD4FfIUDIXs10DIdWR
	O1DEfZPzgDsukftremf5lIq1o7Dz7YyV2LdreCQTTAy+NzwEjsxWJ/9QEKdSn7IEd2fXc908/kv
	eNl9WCCj8xzU2+NfKP3zDwqZ7EmlZHL+yEdS+HaydbOwGAN2MF1AbsaGwfx8But0GNMSVbBX9cz
	ZU5/UQCG0l6EsXfFd/oU3vMhi4hcVMbevjbigD6r8zxotxNRcnzNg7w+4MnSQp5LW4fEGoDm1OS
	fcAxxzxspBTdhvXeLBnQbHEGrRiFRS4YmBv/n0YSXkaEJSDI1uzTkifkemzBZ//7qC+E0Pe1ndv
	ZiEK5bT+FZI3OppCnFhR/alDWeeYZsAk4xdLm6F2y9ED78GkFIzt0RwnS5tG73xbWxNGP2czoIH
	UDDvtBovrzNjAKTT2cUKkZDXzTgzu2N7x8kzcfIMw==
X-Received: by 2002:a17:903:13c6:b0:2bc:7d5d:e2b7 with SMTP id d9443c01a7336-2bd7e9a7de2mr121343695ad.36.1778999619168;
        Sat, 16 May 2026 23:33:39 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:78ef:13e7:10c0:51d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm111625115ad.14.2026.05.16.23.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:33:38 -0700 (PDT)
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
Subject: [PATCH net v3 3/5] xsk: drain continuation descs after overflow in xsk_build_skb()
Date: Sun, 17 May 2026 14:33:09 +0800
Message-Id: <20260517063311.28921-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260517063311.28921-1-kerneljasonxing@gmail.com>
References: <20260517063311.28921-1-kerneljasonxing@gmail.com>
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
budget for normal packets. This behavior roughly follows how xmit path
treats overflow packets previously: stop sending packets when detecting
the desc has problems. Here, it is stopped only when this group of descs
from the same skb are completed.

This reuses the existing CQ backpressure and budget mechanisms, so if
the CQ is full the function returns -EAGAIN and userspace drains the
CQ before retrying. Zero buffer leakage, zero packet stream corruption.

Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  1 +
 net/xdp/xsk.c          | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index ebac60a3d8a1..8b51876efbed 100644
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
index 0a6203c42576..298194b7335e 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1016,6 +1016,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			xs->tx->invalid_descs++;
 		}
 		xskq_cons_release(xs->tx);
+		if (xp_mb_desc(desc))
+			xs->drain_cont = true;
 	} else {
 		/* Let application retry */
 		xsk_cq_cancel_locked(xs->pool, 1);
@@ -1062,6 +1064,23 @@ static int __xsk_generic_xmit(struct sock *sk)
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
+			if (!xp_mb_desc(&desc))
+				xs->drain_cont = false;
+			continue;
+		}
+
 		skb = xsk_build_skb(xs, &desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
-- 
2.43.7

