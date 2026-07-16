Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2633343D80
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196374; cv=none; b=TOUTc5l2wKGc/PlwTS/3YILwdb5FVLpzWHCrGD6RyujUQFwcP7NrGNAXg/GCbACt8r/KQPLFz7Pa53f0g1tR7YUdoz1pjWfsDzSHdVT/L+T5JLC6zdEdKDYa9YG9gZ1ArHrXcYg8IrZejSXSiy9n5+nAXMgmJ6IFt23AAvaYHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196374; c=relaxed/simple;
	bh=+ammkv9WmlsXieg1M/BdCjHugEumXiLSHhThR842jLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FTq6otQXFd/Sb0D5Wrtu7GCQei+cx90XNxIqI+h6NYV2//ypDEQMvPnIErAfhowVyEQ+RDrm0i4Y+SFdrPfVZXyn9B4aSkjrhCkLjSvBzzj7BjTaXW+LF0O8wJ9aSoDkE0aoe1zHWw9WRS3DcI+sCEEzMUF0nuPzVQEbJ8hPyWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=xVvLpbvZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="xVvLpbvZ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b966dd74so26057865e9.3
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 03:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1784196371; x=1784801171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4zobRwr1il7Vi209UdGxxH04APhzDHoeOJcQfGK80zc=;
        b=xVvLpbvZjS0j2PNK/QyhcNZgHnw4TrJzIDpIDChWZMxYmj5VHp0eN3L7mNrdmTEBho
         Gg9P+v92+pBSZtWGnPANDjWx5BInUa8EpexLHDtjueN1pxo1aqh95uzCQ0azuOiE9mJ5
         QJlu4KqY55RO5/Hw4NONkBphcR+2/fWaqqWJkRD1b6dWGyuHI8Hm0eOKLCYbA6MIu2AW
         7KT0Ddovk4UWzkFqeQp8xo3x9KCKAGg+ZW9B6GHFNZ7AmFZjMfLVJy/6NkyAhj02WCGG
         gyQeck8wzfLnY3Dk99IDq2r5dhBIYdL5k4qvZ0L8Yr8Jerd//umwLQLPAQmgNUJxT0vo
         4Tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784196371; x=1784801171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zobRwr1il7Vi209UdGxxH04APhzDHoeOJcQfGK80zc=;
        b=jOOITt+pFAFZc9ABHR24NI+RftDp5YqeABVSVNrH2oLWyT036tpKan2Df6AmKpoSe6
         v23ubTcR5e3qNMfgWXrkiQTz787QcqikWxW9KqDtXfdnnuSdP2SnkUEDOLBBd96nnvyj
         l+8cIfXM8IhUNYCzrRTiR9g7Hmc9Qt7MssyuRzg/6FxQFbogzZOs3zNkvGIiHrp0F3UB
         OtJ+Kqpy3beLHdlc4pL6i/PUneEDhrsFKQncbk1zCXRDPqAJEQ/PiNdcbTyARbxpjgrr
         Ec4g0cnw3gwcFPKziftfbBANKccelNnIg6LkjYQgyy6X9EurbMbP7el43iTxzLo+r/Uh
         nT3w==
X-Forwarded-Encrypted: i=1; AHgh+RoOHjKe+cNhyxJ1nRwVuw69a/yFfjX9Y43aiVt8HniJU2bVXx1ebCCPkH4/LZx4ETeDPrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywc7tz2fk9FoH6HRCHYIT2g+JNLSUt8EhGsxi3BOPFrEvY1aGJ
	kUaIr4kEbcFrbUZUumXmbkuYOvHqpOeEn0a65FqvxLg1U2fqL5XbF1PHFEaEywgiXjZ9z438PsG
	LpDTBet8=
X-Gm-Gg: AfdE7cmpoWoA5YreX4Urni57UwHm4TRnnXhDLuuGohIkBCZTDy8NJx5xtDAkhb4z4Ey
	M8ILqVvrkbDY0pPvk8iFOV3yy56bLcJUSdSjbgopcuo/lOXCO9r77Zc1HZbuKoTjOsXvnccc3pi
	4CawbrQvXwut1Xv0GKzzEZLN6QNLjKKM0Wtc87mVmmIjGxexWMF9e4ekBWSfMTKRJ9kmfYxnAoM
	0Nq93lSCOIPox12cI4ByrjareGZJ7zS4NHGfRAG0Ejh82Go6jNJXy6bIupwgQS08ZV2TJD530B5
	H9CA/lnjReg3u+cjBRtERtws4DfQArLy7aDStScLUN959jdsQ/7zQEydcGVo4kK7FJD1aCTNPT0
	IVlhxNwyrI0x1MXweSF8P5QNsokaOaVjpwLXINmqndmnXWtIOcy952o+RD7BIG58sNXjqjKvFsc
	o+1NJo
X-Received: by 2002:a05:600c:c83:b0:493:c84c:2b57 with SMTP id 5b1f17b1804b1-4953c28b1a6mr63914085e9.29.1784196370491;
        Thu, 16 Jul 2026 03:06:10 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:2696::3d8:30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9a7bbsm46976365e9.13.2026.07.16.03.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:06:09 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH bpf] veth: convert frag_list skbs before running XDP
Date: Thu, 16 Jul 2026 11:06:05 +0100
Message-ID: <20260716100605.939654-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

A frag_list skb can reach veth with data_len set but nr_frags zero.
veth_convert_skb_to_xdp_buff() only converts skbs that are shared,
locked, have frags[], or do not have enough headroom. It later uses
skb_is_nonlinear() to decide whether to set XDP_FLAGS_HAS_FRAGS and
xdp_frags_size.

That exposes frag_list data to XDP as if it were stored in frags[], but
frags[] is empty. AF_XDP copy mode can then trust the bogus XDP fragment
metadata, walk an empty fragment entry, and crash in memcpy() from
__xsk_rcv().

Route frag_list skbs through skb_pp_cow_data() before exposing them to
XDP, and only advertise XDP frags when the resulting skb has frags[].
skb_copy_bits() already handles frag_list input, and skb_pp_cow_data()
builds frags[] output with skb_add_rx_frag(), which is the representation
XDP multi-buffer expects.

Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 drivers/net/veth.c | 4 ++--
 net/core/skbuff.c  | 9 ++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 1c5142149175..efb24aae1f26 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -756,7 +756,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	u32 frame_sz;
 
 	if (skb_shared(skb) || skb_head_is_locked(skb) ||
-	    skb_shinfo(skb)->nr_frags ||
+	    skb_shinfo(skb)->nr_frags || skb_has_frag_list(skb) ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
 		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
 			goto drop;
@@ -771,7 +771,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
 			 skb_headlen(skb), true);
 
-	if (skb_is_nonlinear(skb)) {
+	if (skb_shinfo(skb)->nr_frags) {
 		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
 		xdp_buff_set_frags_flag(xdp);
 	} else {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 18dabb4e9cfa..1e837d01a908 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -936,12 +936,11 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 	int err, i, head_off;
 	void *data;
 
-	/* XDP does not support fraglist so we need to linearize
-	 * the skb.
+	/*
+	 * skb_copy_bits() handles both frags[] and frag_list input. If the
+	 * copied skb remains non-linear, it uses frags[], which is the
+	 * representation used by XDP multi-buffer.
 	 */
-	if (skb_has_frag_list(skb))
-		return -EOPNOTSUPP;
-
 	max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE - headroom);
 	if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
 		return -ENOMEM;
-- 
2.43.0

