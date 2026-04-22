Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26C53A451E
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829052; cv=none; b=mbe0GY73p9B6Ebpi5BCrNGF94eObvrwLzl/LeZnBf+J3p7v1tOyqudLsrkP4bSjIibyvOF7htMxArYLSiyBFfEk4Dy1yJIO0OikBYi6LOZ1ZMsUmEdZ6qX4TinsROps604x59rKsuHSOiUwNsGRQ6nt9t/rSGwMCqfzsTyYU1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829052; c=relaxed/simple;
	bh=qJ7NePAuIUwSLIZNZpWGMB5Cq1VU+wbzlMIu4vvi22w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKvaNbd0c5M4PFDwgj1tJICuIc10GhtIY9E2pRFOvvAslgocb49SMUhGeqzqVjwTK8HHttV8wJ1rNDqOJE57b10Sm4flZhb5CFbEZEVG/+1nPVi7H1j0hfbdExdJlqxHaH2vvC/zESYDRbzXOofgOXlqq8ulWgb1HWqjZmGdBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXzL8be8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXzL8be8"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-827270d50d4so4589317b3a.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829050; x=1777433850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ioBSLv9hdXd5czi0wkoeJKm7t22FgolQo5/iE0ARes=;
        b=oXzL8be8wJdt3qqBlDe/E0XfJ5xOAa8HE8pfaWA30gbEwEZUqa/UbrW5Ii5vAmmpm3
         jKATStlBJfEUC1FcggYNUD04/OLCcwZxDhV4k48ZOgMs8jFKeUUYoQuIyU8zc72MsqPM
         7FuswiiDxHsdoePshJAXavRNUzppnoFtxLJrM6LkEDtBV4xqI0TTGWktdUPc1jSXbvIH
         3zvSCePyCABbw2JT4CDqdRybwsSPu2SB/FfRafam0IgZws6XgAT+ep7PgNGXojQ9BMn/
         uw5oQe6PorGxtZz32xjQ9Uzbe6z7imE5WrPdCJV8zb+/oT7qRstVGEJUVSJwJpcJJ+zY
         QZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829050; x=1777433850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ioBSLv9hdXd5czi0wkoeJKm7t22FgolQo5/iE0ARes=;
        b=odRmyEdWvzGnPvxEaCtWqTMKJzDQqbfbkS8ACK+K90SlT2XYHGK9nfzPSArAPSmHMv
         k7p17cdlwwroHbDaaKvdg2hIcAuyp/MFtNGQzI+FbtK8GBAndLKMEPThvEXi5T1zRRDA
         phfqkXIl8H2X1KMl120e0n/eEhjuKzddJY7JyxTSWiMsSNmyOPj3+uNX2TjO2nkwYzDD
         Zb9e7/6uNBjr0nsR3Ntw29z0LHrsxnq6v2NvUnN7LUcWOtR6XlFrPoHsls22IrIP8fID
         y6Zk9MGAYn2pYJSuWZyqGJjx73fcVFNqyuTfINVJa11/yFisDySUd0JG3BSJOMDhG7tk
         HWvQ==
X-Gm-Message-State: AOJu0YzihWAc4JkB58+3aYkD61N2KYcA0LsTZ4+BItbUc6xYJv2dcpfM
	rwO6q3lDFJHisGNsMthrReskJH3rUE0ArQBxDCvn1Z30VMNi0ZRbBQCs
X-Gm-Gg: AeBDieuSY7ej27blVOUdUmVWEAwSf9025aJeqSMgfpPGRnWEN+T1AcMgLT0adGpFF/n
	FO2PW+9LbkCuGI+0mMr3K3C6gwcHiHs9IP/WrHQ9uHTWwOnJEe2yErV6HV5IwpuL61Q4R8wJqk2
	47PZszSHq3xv440r29Tne33vgUPlcuwa3dKCh+VkO3aNNuUPKQIuHqcLhNWfgh0Ax1Dx+0ERptR
	LJb7e59wZOp57vwfq2XTqcB8CmioKO/VTmzIFWm6JwTXN2xTcGv0SG2z9xatbpyZDJbh001vamD
	xEgKMbqeHyA4r8i1UuLL3blbqBWZsQjdsPxZ9xshRPLFAfcO08YjRcHQdB4pCxk/VvyStbRLwp9
	jrSDMEJKXs90cFzIEZjeg4wlTqKD2phzkW+0ybVLOnEgIaB3WMER+8oKxpPHCnCmDiLV/nk1zVp
	YNsvUDqk3ef9V0jB7uFlMJHwaOpdx3LpRg7mVlm273yEI2EwHG8fIuXK8Vs9uBVV8PlYYMOnX5G
	JCaIrwX
X-Received: by 2002:a05:6a00:2e15:b0:82f:f4d:23c1 with SMTP id d2e1a72fcca58-82f8c943269mr20693707b3a.44.1776829050199;
        Tue, 21 Apr 2026 20:37:30 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:29 -0700 (PDT)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v3 7/8] xsk: fix xsk_addrs slab leak on multi-buffer error path
Date: Wed, 22 Apr 2026 11:36:49 +0800
Message-Id: <20260422033650.68457-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260422033650.68457-1-kerneljasonxing@gmail.com>
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
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

