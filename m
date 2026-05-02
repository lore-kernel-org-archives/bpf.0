Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE93838F236
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752471; cv=none; b=Mci/6BZa6wa4DlkD+q1yOXbqyspuEJIeUusneJSRqQDV5mHSOqoZAO25iYYcV3eOEcvfELxd6ocpGJd9/QWR9B9Me3x3GzMTG+pmXkWfzDZFt1LEjSArYzcLzAzcjwUGK74qu4ilGz2QrNknFnISFHtpWkLFrKxeOIO5yXVPuTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752471; c=relaxed/simple;
	bh=qJ7NePAuIUwSLIZNZpWGMB5Cq1VU+wbzlMIu4vvi22w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a2mzLalLrtbTxqw93U6d+szA90/dfrFvJQy2+Zwbl1LfcJ8WCTIT1wrRuGV7r/2KODEcV0i0nVB5F4UvYc6B1Irvc4AC489Ln6O1tn7ZaRTRU2IEBeToGU/AX9q//Ql5fJ9UxIkq3niopHZIDyK2nirsk0EhKZ//uCd6Lrl95Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTee5mb2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTee5mb2"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67bb5ad91bfso2898376a12.0
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 13:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752468; x=1778357268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ioBSLv9hdXd5czi0wkoeJKm7t22FgolQo5/iE0ARes=;
        b=UTee5mb2eycMtO71qZNKfJLQTDpKsJjZkmWIP9pOYrFCuHpeGBS9qOYIkoG94l5eyj
         s1qAX2jxBzgubm97u9IexsE2sfBfDJc0A5R6LHDVyla0X2eAAHLPW3LiRBVNuf9vGkS1
         4I8ji34TSzllE6StlNb4Eq5PpA+hmLN5twlfs3KW3OBacEc/8wVKoZDEYkxagf8x9qH9
         I/g8PTfKkewJx9uvroTppO+7+LIz2jsgl2NgL1TZPHHert7P9L1kLPHkPyz8/56xpoHC
         FPPnxPItt4Q1onFdkjR5jPOkQd+SWwvJii46XDS8L/HvmfihqfW63riz53okX0k+Pawv
         YAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752468; x=1778357268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ioBSLv9hdXd5czi0wkoeJKm7t22FgolQo5/iE0ARes=;
        b=oVj2nEG4pfkeccOqDcY/hIyW5ngGjNb6wf6UKrW4y2e+iGP5SKoZRGZjCKR3bKnc2v
         0sNDA0nqWezCDZTT8MiWuuo6A4BImM0ZiARqtgw83E2ZIyDk2pgAB/lHMUUDn1+QXeBr
         qIbF+oxCepB7UGx3brkjkWceEG1pXJ2ybZlf3jcJmDR6UlTFDETVqvAYb6doAH/whGZW
         R0pe9DpIUs6dVIV85P+Q8IpTfTPqBnsoZI2UUFDFnr1NrTZZz6ZxueDfqLJtGo/uOvE3
         glDnwySmq2NjXpQS8Dp6Yiv0/HTYuKusxMTuDKV3tWC2AdWeTZ9EMuQ6XuHd4Zgri8U5
         I5vA==
X-Gm-Message-State: AOJu0YziqTshEpSpAa+SzZyB2jcJJR/Z/tUL2kcEZ8mFxfyAxfhoCG05
	Mm7M3Sdc+efpa2RvL++YjGSPCHL1tzW1J06AKnl1B5pG/q4njeKFZ8k4
X-Gm-Gg: AeBDies3ZdJZG7MOkJH+DaF480fdXW0mA2V7EXUvKMQPZwpTmLch5jWgUwIc3fBa473
	F4ADsUvRo86VFjNW23S13M1LUCEZpKN5CedXjDeLdbeGn0iDC1OJkXVXBmdYU/1Np6P9z6r3ATh
	kbKEu9yiKFd4SZYHrmsJXCmIuxTue84Vsr88hR2IsPr19C5SXuz0K2K+HLA9pkRnyy12JYJPBbp
	oil7OpcQyT5cs9WCDmI9HcyZ0LVvGfwN8mLanjrtmGGffetFQeRQRpDY+cHMCKljnocQjXAI6nS
	HRspuAwn8JmjsxTygZtPRnJZHWI3na1RuT6Cx/B/HtmsdXgdo/FXwW3I+ZWn6rW9mtuEQo0Gdb1
	1HiOMThGC50tzbGPejZ50lpvhPDu9tjBOJEps6hEngxSgz2DSs538pHXIZBWaoaUoJg0Rbty4eB
	ye3L3LVx6Sk8feZXCIQg2aMu9Eq5dd/R6u6KdGR5thrJYIn/ZhwKOKkZEMn5yqqw7CZ+94U7Ekp
	Y72TeSxbrIenSDzV0tzZzo6mbvG
X-Received: by 2002:a05:6402:5043:b0:66e:6ac4:2c01 with SMTP id 4fb4d7f45d1cf-67c18120146mr1397015a12.2.1777752468302;
        Sat, 02 May 2026 13:07:48 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:47 -0700 (PDT)
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
Subject: [PATCH net v5 7/8] xsk: fix xsk_addrs slab leak on multi-buffer error path
Date: Sat,  2 May 2026 23:07:21 +0300
Message-Id: <20260502200722.53960-8-kerneljasonxing@gmail.com>
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

