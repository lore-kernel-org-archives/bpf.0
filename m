Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF7221FD4
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237799; cv=none; b=epTlHRoRPnrf6QgLULxtVvCI/jGK3faeq9niTWYYT6Ujbiac2Cu+xrLB7gMxbtLL0Ve0eti8HDMehzfbE+x70TkVjn4E2qsmjmFKOmk2hUsdmKYBWI7KSIp2KC9s+aCGs/RBTw6ygCgZEg7Eo3JTf4nyNvQ8/sXbNHZj6k4PErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237799; c=relaxed/simple;
	bh=NxEVIpSzrsCjjOaUYlNJutV/qVP8mBLX2IwUIwCVW7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nPKw6p9zf9wz9DV7GnL970zIe+OuYIFUUWbIDHPHGGvbRIBlrSpXwjUZneHy6yCsMfS/4y+FfTpVq96MfdAkSR84B8z4TN0JIg/94ZM+x1ANPi5zyHkSuL9rvLwpXmpxQsmPyfe+TQtpIR5qbuEzs7iBXXfRTWwxdug9Oem3GEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PK4n8pyd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK4n8pyd"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3660daea6a5so2222762a91.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 17:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779237797; x=1779842597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOCZGSYbF98R5+l9WqXa5XZWzMcFwOwCXLgcRS0V2nc=;
        b=PK4n8pyd2w7eYfImqvq4xpHkeiVbpLvBemZi+C5ejDUCKGKfBLCZ+LT7oRvpWLaVky
         SbjMgocrk3KUmPfppU+n9f6Fdxjm75ecViN2X9/C9KAyE/S+e1wAwhywWDY+/xhMqD5W
         qud5C1snBOhruLVM1jAeQuQobQxjfestGtpjwR1WhgjaKZVTFOTBB5hssNOfvuVaO4S+
         uvBLDtKWdtDdVenT+VEI207voEv+VD8HORAUH/lem/ylAuVj+iLA/VqKarDigm24qP0Z
         b4cEF5XLkjwnKY+a+tTBa5g7KaGj/lC9xGYJjsVNDIMeS7NOUU4A5GbYzPQO5uk0w9N1
         KLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779237797; x=1779842597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oOCZGSYbF98R5+l9WqXa5XZWzMcFwOwCXLgcRS0V2nc=;
        b=aWlb2fLsAQWmwpzr7kL4BpYSRfWJucnG7jQJU3dPTdx11SHzHI2G/pcOdFZIgX6GWa
         3sqFUG4Il7dxPoEWvaXZySyurSIHCmWcSm/Cgl20iw6wq4IvHzwO+9j2VMxuioBdd7OL
         ML5+n/9SADlAhqGUgOTmiSaV6W2LFDKTgHZTycIrcG/aENv6/Rv8LFLf9owE7wFp27AH
         fPX65Gl210kTluNHr0pLM+HHWmh03dZoEPMB/0o4U1nZAvm7PoTv5nfWx2YzIF+HoQ1O
         ekKfP4i6xae3Daw01IWAej5XmncMBAEoISdk/A597hCzX5T30X1GqsLjzAU8/6UEAL7V
         eY6Q==
X-Gm-Message-State: AOJu0Yyji1d2eqFcAlVPFEnQHM3nt4vzjtYdAiIzsntpIV2Om3mLOIhA
	OH9Y/rxxB9EvzRLCBur/5dU6zazUPpot5VuxgjB/N7uJv3CxGy8wKX12
X-Gm-Gg: Acq92OFzy6eBhDcp57Wep+CjEISAK0HBm1KIFIh/mSd16zsifWJ0yH5bP36ue9BgOsH
	jJr3AnKWF8TQy2k+T4+QW5ljlisJUm99WTup7t08WbuwVrJB9LmtfICdgpU2mPxYHpslpIAzL+h
	LtsunB+8nKNr/tz0FTn43G3/k1mpGB0HD+O8l674owOnXqV+h8kzhGthYxnXpGGOXFjEQA2vNQm
	lHQZi9Scl4wNeoOkrF82Udf2o1eWEP59JMzHoEF1CCL7LopYKLx60oj4AJLCKP8WTgapijiKWvO
	vXI5g5pPkqyLlVyUTjzIDjKFlVy6rRqrtl4b6scdEAU62ESD7DR1nYvVtyLd/d6Vsb7X+M96A+b
	DtIJ3YnAXFIscDDsgRcSpLw/RDxk6yPtgWpNFZG1KbJchlDBVCI+tLiHihxN9JyTsdf8Oxk7Ykt
	NzQnVcn4ypL+E4fRtvGfJeTC8WpllWAr/sHakdWV8olNuiqM8vUjSEAYun2R1XfzGt7cdLZ/FVp
	3a5/6aDsn1V/+D3yItiyH/Fv10WMrwFlxF7E5U58w==
X-Received: by 2002:a17:90b:1b05:b0:366:132:fda3 with SMTP id 98e67ed59e1d1-369519c4b9cmr18824676a91.11.1779237797304;
        Tue, 19 May 2026 17:43:17 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:f1df:d520:8103:19c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951059f4dsm14746277a91.0.2026.05.19.17.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:43:16 -0700 (PDT)
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
Subject: [PATCH net v4 3/5] xsk: drain continuation descs after overflow in xsk_build_skb()
Date: Wed, 20 May 2026 08:42:42 +0800
Message-Id: <20260520004244.55663-4-kerneljasonxing@gmail.com>
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

When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
only the current descriptor is released from the TX ring. The remaining
continuation descriptors of the same packet stay in the ring. Since
xs->skb is set to NULL after the drop, the TX loop picks up these
leftover frags and misinterprets each one as the beginning of a new
packet, corrupting the packet stream.

Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised,
so we have a chance to examine and handle the potential remaining descs
of this big overflow'ed skb.

When the last fragment (without XDP_PKT_CONTD) is processed, the flag
is cleared and the loop continues to process subsequent descriptors
with the remaining budget. This behavior follows how previous xmit path
treats overflow packets.

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
index 0a6203c42576..f4add7be8c93 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1062,11 +1062,30 @@ static int __xsk_generic_xmit(struct sock *sk)
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
 			if (err != -EOVERFLOW)
 				goto out;
+			if (xp_mb_desc(&desc))
+				xs->drain_cont = true;
 			err = 0;
 			continue;
 		}
-- 
2.43.7

