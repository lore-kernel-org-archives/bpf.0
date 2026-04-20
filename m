Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55335388364
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673731; cv=none; b=KW9yqqo0e2i0iHMm4/q/ZcGP0qgooWXZ/B0w/rdkohM1ahEi6S5jUldnvhlCOGg1tJz3NnnAOffuX04CoBwiJRQahme9f2ZBPVivKHx4XQUrXviFUdnCBX8hpIKlyKsJ43SeK6C/MlwB+/LZGzQnj/tK3ii/C8Tx8Nzaj9FswOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673731; c=relaxed/simple;
	bh=hJPzdZOuMsoyrJKQrdHDjL0cVhaVCo6hPwt7Cfu3dJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2w1lPqzXY/1HGSx4yaG82Mxz0TJCoNcJN9xBgFREYh/ifmPdqWfJkY+ShCGgYNPCOTHWF1OGjpTbNylRW73WMll/uF018UkdjcLnS1QNlHALFV4ulaWeOvwdAturxMcf0IKRpp8HWiQCw4BWeTiP9owhw1urDk/sxGq/d//AjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llCMoSkS; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llCMoSkS"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso92754a12.3
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673730; x=1777278530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkG8E1zHoS9yZo95EX95fxtMt7Mzto22+gCUnK2C29A=;
        b=llCMoSkSuBZ3ckhkYakv/padf1dBph3eLQD7Lr9u0lBGzpVk3YFOytkPJjr658AReC
         +NV03XdoWkmMvJ04mnXUQckVdYaNpBkz18L8l+b/0KUm12xn6pMlCMY6YD5cbGXkMzs3
         At+NQQvGva+SjG67IEfVkH6WWcddC0gy0KqZuR3L1P8MsFKootdDqDUW6YzCtayMtMJ5
         RwswlGbAsb2bU3LkehsPFuesC6H8TiUkGNYgPt9X7d5skjtbIvSVqBFJ+eZ+Len7SlSm
         B/ifbCZkbg943O9k28rPw9TSJzq4V1ayKE064KcUtYPUaE9TnujSstU9eNncGG+ROQ+s
         NirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673730; x=1777278530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkG8E1zHoS9yZo95EX95fxtMt7Mzto22+gCUnK2C29A=;
        b=bN72HisLx8Bl3Zptt3DcNaZ+zqKh/Gnyw8xL+/tw7rzSX3db5SzqlplMLPZ39MbpzN
         8Ge4RmOk2/iIU/5oL98j8Oqs1QHSrRrxVd29BCRSsnlxWCv6Nf5dR9K55coHJ73ep+iv
         1CRQSZsTJryuUx8NJ9VATndvKpoFyBbZNluEHCSbj/Rm4IaG0enP8kSJqt1RoDZJahXg
         le4UX3ER2/7lp8Mz+GmjFqCAYnkopsQHSd9WyMHK9I1uv96KcPCrMsw18WzzLC9qefSH
         n5UG9/6MWDew3h7rdy29fMCmOaGNVEaDZkMg4+HdZdBJdi9dLZX6OSzqUD1BQtV8d4hp
         mqXw==
X-Gm-Message-State: AOJu0Yy5C+WdMAAxrQNZSTwg1Bm9Nr3FlnDZXj7+vadsNBdlj5yW6w+p
	xaLu1VMWEFMUevOGvu7T98cW6bpz3MleStz8FMHbZBaU0sFnbmSH6nj3
X-Gm-Gg: AeBDievoQG7MM+GrnArnc8wo5VQVj3YcIjr/2DhpWUIuAt8wW/g9kkwcH0z7H6+IazF
	6xK6QBPB3T2tCsWt1JzbURbXf2j2Y5Z9txWiZjlaRAWAZsku4RXaXfDLbeFCc3z4ucHm9cwVPcG
	wq+NQEOcsGq+KVB4h21/8ND/eK2ENMxJG92x5wFXWBXc5ez66Pk2MoDlSaV0oOBK92KBan5Xz7L
	eAyk4a6yEZ/c62/rsZMp8mm4dr6Bd4+f7BnU/bVmogH/hAikPFME2e9ADQ9jrJoBFv+Ve6pRHBl
	+tU+Nk3EQQOm76P0OutKnPim6nB5urKpBU9Otdi/ggWLLRkf1fQgZb29JlMerryqH4piiB6GLt1
	3fZqIDWCzczswlLCKb0vAOGK684neL6GTca6L/SiQ2wv8k6pQX0eXmUFbAqag3PY9hyMTtOvMlT
	al1KhvEVjOq3v0QWLHvAwiaoEK6FiLv2WcCUKipyG5OWrwImdhym9Cx/eDroKL7oUsm/DD5f5lZ
	i4rP7RXI5Wg/8jxlVI=
X-Received: by 2002:a05:6300:218a:b0:39f:94cb:1bc with SMTP id adf61e73a8af0-3a08d687dbamr13637730637.1.1776673729610;
        Mon, 20 Apr 2026 01:28:49 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:48 -0700 (PDT)
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
Subject: [PATCH net v2 7/8] xsk: fix xsk_addrs slab leak on multi-buffer error path
Date: Mon, 20 Apr 2026 16:28:04 +0800
Message-Id: <20260420082805.14844-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260420082805.14844-1-kerneljasonxing@gmail.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
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
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 9236ec32b54a..6b17974ca825 100644
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

