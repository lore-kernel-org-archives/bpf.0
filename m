Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D938643B
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848255; cv=none; b=XaeXlewoXzh3R5CHJIyIdKTDTlVZRjqJBmUCXao8PSR0ofUw6lG9rRFOIbp6Yqf5Le48VDqjZGxjkjFfavTMa7Ev6LGet+yq8JQGyrBpPG1SllW/+iYRarK2tB6WzP6KdMoDXtqAJwKSOFK3wWDWVEkrMRbqXmJPWHZcnEVQN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848255; c=relaxed/simple;
	bh=IQhPw3IiVr6zqqu4CRDJ4j0to08qx8xv/NfQTLHz18Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oXhSfZ4V3O2uwu6HjCYK3Qd1dIW/6dYVUVo+kNT1O7AMbl1dkyYstK3242xvrscC4asUIgHqglVazakzuyxQ+W215MqsOkrR7UNjZ4UIodKTG8TNl2wxa3fJfjm6lWyEkF5ZhsqD+MtAoUGtDV044izGdOc2hxaOyJGAXZj9Zmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmZ5oAa0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmZ5oAa0"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso90738355ad.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848252; x=1779453052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjcyuuQLuaEXuRzmmB8Nl+fj/3MjgdhxLsDyrZCPoIc=;
        b=VmZ5oAa062zttJ9lqGRpazmhleIs+UUxv+Ahb18sePzrK7ie9MsVsMqx2/yYY64FK5
         u5t9BOAhUEvL0RHdZEn4shuex1MU7j7qN0/v3R7Hx6rjyApHPUBLCIdMK/SD7KGf4PUD
         3mtyBWsXDvRAX/Ufz+2q4zErzQxY5BtSrIffcXSXPfxLTSHbVKY2RYAvOxA/ifecwzde
         O1W9jEiXFpe5uwxgDUTrOiBRUNmO7D6oEHvcvTs0xMyBPnTNLyxpIOliPxF9nl3R2Lgq
         DHudh7g3pkCrEDR7DV06IJRiGkZ5EWB7iNT0kSCWtEq176hKeNmEbM6efP8ktA8Wx5Js
         3QmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848252; x=1779453052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BjcyuuQLuaEXuRzmmB8Nl+fj/3MjgdhxLsDyrZCPoIc=;
        b=CqEeDw4vVmr/lphzup5puNq95cKvfzD0xpBJW5+XUBN3C+XG/cmJBOZ0/D0rvv5hUh
         rntvT/UVk53IuC9WErgIJo/e1U/BhYOUkwz2zfHIagqQfVmXPE5UdvY3TJu2+WlVECzh
         Ga7WV3K7ZGvxA93y5H4JeuAtS7uYQLZCOhcYJ+U+cbivlfRTJt0KTT7FMPdW7wraCv3Q
         hoHTebYWmG7ETir6eOpXDIf/WWEuoK1Tlig6O1pBdfCz+HDkkbyTUUxrefLX9zDBjauo
         VRZe3LRVDHAus+vqmr5xI40kNuciwLDe7yk/ntnbL/fj/oQfcVXajOOcNv+wND54Uxla
         sL5w==
X-Gm-Message-State: AOJu0YwaWxf0MBq3VhSE/7Lfw+2azkKKuTqE9hHCq+kDHBvflSR0aR+y
	l8swgZ83xPGmRzCLVgT/9V6hWzQKLASonYJneF+QbWvECEwFHTia9PqC
X-Gm-Gg: Acq92OFVVOChcVbgLYGxqpPIdye0Rf1RnxI4LkM3aRbKlIdc/Zco5zSDWQEriATuhkZ
	Fkh5t7GKe6VR2KLbILMSYsDXR/4CPVyzcenjt7U76svUUO0k87Hy9khUljpXNAlatYTIYeuZHhU
	wsZwq5A5bhU9aP6T7ZbvyU6T6GEHUTj10Kmp9n9OWs7JySshW4/D+rsSDKDzpQ2b72SlMYGZvfI
	5Pg50EG1faEF+9xA4FwKi9w5pnqfywJImEQNh9JqNvbBT3SB/p0z2Xet6VA18/GCFbTHQ9nECPq
	+DxH4wP+dBsdxJmE297fd3QCXkdg/FaR6YvxumoIOBAFFYhYpSnOuqepz94RHUAKsdFSg2Vxmmq
	VC8dqDaANwmZKJKesPBUkzx1EF+ugRWiq6TSuIXWHC1msCuMkkD3D1e4reZasO4uL4zlJiOk004
	TWlMRbxpn7lUN663fp/LsV2eWZOlvW+iAQiFn3j2bkv34ut9TcpAZzxRhtG5wPzXy/GZOaysapA
	M4ZYa24qS61BvJXiodDtjpKvkHuSIc=
X-Received: by 2002:a17:902:a515:b0:2bc:7eee:200a with SMTP id d9443c01a7336-2bd7e8c31admr30757915ad.22.1778848251961;
        Fri, 15 May 2026 05:30:51 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:a48a:1116:aa2d:1122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe492asm60348885ad.48.2026.05.15.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:30:51 -0700 (PDT)
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
Subject: [PATCH net v2 3/5] xsk: drain continuation descs after overflow in xsk_build_skb()
Date: Fri, 15 May 2026 20:30:16 +0800
Message-Id: <20260515123018.80147-4-kerneljasonxing@gmail.com>
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
index 1cc14cb415f3..f98a9553e536 100644
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

