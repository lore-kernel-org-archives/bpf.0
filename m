Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298E618DB35
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 05:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009141; cv=none; b=NnqdCfO5ToYYNKnr+8tcwZQgynJ7OxwJEXJqTJzyMZDxDfGg2r6fqVSo71yMY1nkbUZWeKsFa+RVZzWFwlBy1Ypp80n9AgwQutE3bbKnrPyz82Qfm10pwEihkPU6v4TB28caaAm1YFaIYGJlvcGajYoLY86VHtujj7pSD855zCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009141; c=relaxed/simple;
	bh=qJ7NePAuIUwSLIZNZpWGMB5Cq1VU+wbzlMIu4vvi22w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SDF6xQ2JYus9kfWx2awiypsOtHaBRpkCdA6rvXddzw4fpMIjoRbJIctDIcDsoN3eQ54ttSteVP21bh3AtkVID510zWnRQGng9H1qqtllRorux39JyrCbUOgK9hWiFYcVzUTAsQ8ZXYAV5En43GLUCKYw3l0cN2JlISto5y5A9HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewDtDVMH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewDtDVMH"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b2503753efso76035105ad.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009139; x=1777613939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ioBSLv9hdXd5czi0wkoeJKm7t22FgolQo5/iE0ARes=;
        b=ewDtDVMH2ZSm9q5JBNBIa6Ve5p6AbrGIFPofU38mdIqoOwOWfCakg02LyG+QvSi22u
         XxrvB49tZvja5kq22yFTJNdAAqa4AeycKgp7CyqRN9u8a1LZleiv4imfEoHoOGlWh57P
         B6ldvFI3BpmjB19R2iFNVmWrjX5pDjABD/zgvdGFq2XkL97EnwMEdbXmz+yDvGnd8CVw
         lN2XZ5EuJ8hqHEWbUlEqS31y+q0/12kRK4s2xpE1w545gU1QriwK56e22fPv5/q/yCGA
         xvUeaCqPx1CJvgIXarkTLmKro5BckpMdB3IO6r36WknpRaRrhnuzl/Z/wnkx1dFVObJh
         EB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009139; x=1777613939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ioBSLv9hdXd5czi0wkoeJKm7t22FgolQo5/iE0ARes=;
        b=e8z2LCZVKbl9Zi7RSrpaSxBZVNkYL01sME5kT32mE3sKNuMQaEVemgv3ItO17HzBWB
         4VrT9ChpIP3KSl896KPTwdT92WVFx0eHXxguufljDGsw1784UWQPFmMPgMjGD4TMEyEm
         DQ3n2EQ4aT/WDI+wGomGAbxW8gczggQ165pYKxv0c822ZIrN64eQAd3HlLkvPc7M9CCs
         EH3GXvOU3Zkt66IzpMi32ZnUhK5Bzse3CXM2KaaBLUOM3jQgCxsQWqG2r4+BQtUWrM3v
         95ixng44+TVW2djWsMVUl1GWeXyPcQWQounDFYc9WlDPL6au0R9L+pOIc9n81rzvYTj4
         YTjQ==
X-Gm-Message-State: AOJu0YxsmKwKIJx5jUOmRK2knIeMU/GqaXFSs/dNnoJvivQOkpZx+qtW
	oLNSuXQL0nuSAwvH9azqYeK36UPTM3gpKA/F7/JBVRhebI2gmxjUxfFm
X-Gm-Gg: AeBDiesAYuvwclRd/yv4XXhNerDxWBUDhkspscXmXegcMLEskVuayjfY4LFXDlTTFM5
	cKw1/Zf/I69/R80JfuLG+0Tcn4SN1dX8nE3kw9FqMid1B/W4jaqH1W4keGHOJ8sKy5Gzlo3pIdt
	M7qYWSjwmx9P39LKyYg3EpIxrtQ4HcRvYppWlA7RJBz2r1nAC2rVV3p34eHdcBoHBXQDGm8OCwQ
	f3KEmdYCW9g6Y/Tfo5X4IUygnbMNlTYvVXnJGhHjRxvghgcfJGn6fM/465FX1ChIclglHxP2HxO
	OjGTFBDhgNW+K8O7649oFNF9Bdcq0sj1ceeNmiT/lzqzveNNrW5V4M4kL78W54nLY5jSNp50s9x
	pBLZwftc0+pjm/zX9TFHBJa4rV0QO0NzJa3BmIf2cdfiSTSNpE19/8eOpWTuWqJJ+1EVFqNDxXt
	P9cHTBwb7yI/pWv3x/N9/n8kKUOsYzNVTbbXdHF56FfxO7zkYR9Azj1d2Gqc5W2QwbjtRs8fBWF
	JVllqyd8gH25kJzAx6s8AwEauA5ledLF+APcz84
X-Received: by 2002:a17:903:32c8:b0:2b2:42da:25cb with SMTP id d9443c01a7336-2b5f9f4df97mr315912315ad.19.1777009139479;
        Thu, 23 Apr 2026 22:38:59 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:58 -0700 (PDT)
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
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 7/8] xsk: fix xsk_addrs slab leak on multi-buffer error path
Date: Fri, 24 Apr 2026 13:38:15 +0800
Message-Id: <20260424053816.27965-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260424053816.27965-1-kerneljasonxing@gmail.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When xsk_build_skb() / xsk_build_skb_zerocopy() sees the first
continuation descriptor, it promotes destructor_arg from an inlined
address to a freshly allocated xsk_addrs (num_descs = 1). The counter
is bumped to >= 2 only at the very end of a successful build (by calling
xsk_inc_num_desc()).

If the build fails in between (e.g. alloc_page() returns NULL with
-EAGAIN, or the MAX_SKB_FRAGS overflow hits), we jump to free_err, skip
calling xsk_inc_num_desc() to increment num_descs and leave the half-built
skb attached to xs->skb for the app to retry. The skb now has
1) destructor_arg = a real xsk_addrs pointer,
2) num_descs = 1

If the app never retries and just close()s the socket, xsk_release()
calls xsk_drop_skb() -> xsk_consume_skb(), which decides whether to
free xsk_addrs by testing num_descs > 1:

    if (unlikely(num_descs > 1))
        kmem_cache_free(xsk_tx_generic_cache, destructor_arg);

Because num_descs is exactly 1 the branch is skipped and the
xsk_addrs object is leaked to the xsk_tx_generic_cache slab.

Fix it by directly testing if destructor_arg is still addr. Or else it
is modified and used to store the newly allocated memory from
xsk_tx_generic_cache regardless of increment of num_desc, which we
need to handle.

Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5e6326e076ab..ed96f6ec8ff2 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -605,7 +605,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 	spin_lock_irqsave(&pool->cq_prod_lock, flags);
 	idx = xskq_get_prod(pool->cq);
 
-	if (unlikely(num_descs > 1)) {
+	if (unlikely(!xsk_skb_destructor_is_addr(skb))) {
 		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
 
 		for (i = 0; i < num_descs; i++) {
@@ -660,7 +660,7 @@ static void xsk_consume_skb(struct sk_buff *skb)
 	u32 num_descs = xsk_get_num_desc(skb);
 	struct xsk_addrs *xsk_addr;
 
-	if (unlikely(num_descs > 1)) {
+	if (unlikely(!xsk_skb_destructor_is_addr(skb))) {
 		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
 		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
 	}
-- 
2.41.3

