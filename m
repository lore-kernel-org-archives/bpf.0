Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2042F3CE4A0
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241676; cv=none; b=Tf3Zo1g4KeVSbJeNnDpoE70GGS8bHjw1/EBJeDgo1qFtIT5cgqq53t8qoI0EHreLyx7Cf+yXawNZQmxDJSGCzQ4LH2JmyLne4eEvevrjKChsCE0pccMAubJCddY/yITJF2o9u0xnSVVS+F1I/WzXnae3Q75907GmpGZkmyoqghQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241676; c=relaxed/simple;
	bh=XT1aDQ8E1jsPO/lJtAap49jcFvVVpTa13m0am3SqON0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nTd/4bqFhYHKZoDxEXs+Lq9QBeFk0AEkMadRae+1NpG1g/K8XfxCihEi1KfjBF3Gc80rjbym6NEWHK9allkjLpabuSPkHCPvyst/80iKXORa2SFhpzW8lk9UXaJkF6L9yrHaLco8jtrT6wxqNKQ9RS3bYc+wNb3LCNk8trIA87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDOJRhdu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDOJRhdu"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so3819047a91.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241673; x=1776846473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm8KZlIM2w+S8TkBYrHwgqIY+7B0rxKP/eXM2R8Qlds=;
        b=aDOJRhduRVlVL+Q+L2CdEILQdGGCzXXlYeaZbk490b0hlbV/SphVGXoLkRkA/klY7l
         QyS3QFLyzy2f72Q79LFSAZ722fLzqQn46m/0wIckhyjn8hZvZ+MPbKv2GvnfuqVYlglo
         smN990DwD7n/EzmvXvZvjaDsG6894+l6WlXyKipuMH21BawsHMYLAT7rGu5t7L1aHgmL
         +1+1v1liy2MxkgE6x+RQmzE45rvylRPIvvIxh5jlJwd6cgwBdQeF1ebITnAO140qf2LW
         MEByrj3WM6bldkX6OPywdDkMLSpLSaa4QCcOJHr4UycLPHXUSbfwDhZ8xcOYKtNFFKYc
         3CYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241673; x=1776846473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qm8KZlIM2w+S8TkBYrHwgqIY+7B0rxKP/eXM2R8Qlds=;
        b=oxGbV5HQv2XysFnZEsR3n0pCgAVRMEEzd6cW7gRqSNz8edcbovk2KEY4PEhqdrMB7b
         nb8s7s1iFIXJwdydMb3cqYofewpsP1YhOtVmtLIubze7yYeF8lxe2RlfSqKvpKGwSNoI
         SM2z2wis+vOhC7LQu+g/ZDr9fOtk6UlvX+Za9kKqq22r55iD4fREqFKwbFrdOCsVQlop
         nHymhmyt3pH14Y1l53IZNEnIJ86ra9GbqqQYYuDxUZlGpSo++pPUoXjgy5OdBRkk1jWm
         VnKS0Oa7p6/9UKiWK5hdwfFagstPk62RiVuR72R63mgWpSplmz6Nq4px/gyFTU82HHI/
         2VOQ==
X-Gm-Message-State: AOJu0Yydd4CCa1aaaaGB4J84pEWcvd7kqID0UXrE13XrpQBUM6vuhYLp
	28wy+cCfek8ilFtOuy7dvT/yhigMfMugZpFwOlDvosuwBiAG7XcYFYhC
X-Gm-Gg: AeBDiesu0orgJtKaD/wJM8HUqrvhjXcIZxW3IPncHlMC8aWqpDvOp4GFl6UWwiauDvT
	mxU195mxxoHXmolZOut3rM26pWT2nNVooVa0dXwTEgQStDTSCIEU/zIsWVwbX9Sb2ZPMG+Ejdle
	/a4EyBLVMe5j6cIlNvO0SFg/yJqs9BtDXKgTNn86PbbVV2QgTxVreO5Ph/ljMNli6r3qWuMXTga
	ZuBeddbF5qnHHIWSSubHXRy2m4M7zGuRtXbzwEB4k7pIxh2UMxSW5woU4JEjrksNstsR9wJPbRI
	Dot6nYV32YWG7DKO8uy7DT11V842HkpxYmBekkUasNQXGvdyisUv70QkTOxLwVEzkDNu8iMSrLB
	pSrrPNVZht3vdRu2ht4gPrNhPhNQaO2Q5ROf+wWaSmn8obCeFT0E2yxETfJucyuCKaTRN0HVDLJ
	9izrkUEU5OmDulBETRsSIOD9U+rU9jhFmltW59cCfV35UOa/lvGdgp3I3TvkeOqasQCwz++GnO/
	qPveabs
X-Received: by 2002:a17:902:b409:b0:2b0:62dd:3a93 with SMTP id d9443c01a7336-2b2d591d1fbmr152805355ad.7.1776241673435;
        Wed, 15 Apr 2026 01:27:53 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:52 -0700 (PDT)
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
Subject: [PATCH RFC net-next v4 08/14] xsk: rename nb_pkts to nb_descs in xsk_tx_peek_release_desc_batch
Date: Wed, 15 Apr 2026 16:26:48 +0800
Message-Id: <20260415082654.21026-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Rename the last parameter to nb_descs for more accurate naming. Next
patch will add a real nb_pkts parameter to help copy mode count how
many pakcets are needed.

No functional change here.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7a6991bc19a8..6cd2e58e170c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -485,16 +485,16 @@ EXPORT_SYMBOL(xsk_tx_peek_desc);
 static u32 xsk_tx_peek_release_fallback(struct xsk_buff_pool *pool, u32 max_entries)
 {
 	struct xdp_desc *descs = pool->tx_descs;
-	u32 nb_pkts = 0;
+	u32 nb_descs = 0;
 
-	while (nb_pkts < max_entries && xsk_tx_peek_desc(pool, &descs[nb_pkts]))
-		nb_pkts++;
+	while (nb_descs < max_entries && xsk_tx_peek_desc(pool, &descs[nb_descs]))
+		nb_descs++;
 
 	xsk_tx_release(pool);
-	return nb_pkts;
+	return nb_descs;
 }
 
-u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
+u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_descs)
 {
 	struct xdp_sock *xs;
 
@@ -502,16 +502,16 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
 	if (!list_is_singular(&pool->xsk_tx_list)) {
 		/* Fallback to the non-batched version */
 		rcu_read_unlock();
-		return xsk_tx_peek_release_fallback(pool, nb_pkts);
+		return xsk_tx_peek_release_fallback(pool, nb_descs);
 	}
 
 	xs = list_first_or_null_rcu(&pool->xsk_tx_list, struct xdp_sock, tx_list);
 	if (!xs) {
-		nb_pkts = 0;
+		nb_descs = 0;
 		goto out;
 	}
 
-	nb_pkts = xskq_cons_nb_entries(xs->tx, nb_pkts);
+	nb_descs = xskq_cons_nb_entries(xs->tx, nb_descs);
 
 	/* This is the backpressure mechanism for the Tx path. Try to
 	 * reserve space in the completion queue for all packets, but
@@ -519,23 +519,23 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
 	 * packets. This avoids having to implement any buffering in
 	 * the Tx path.
 	 */
-	nb_pkts = xskq_prod_nb_free(pool->cq, nb_pkts);
-	if (!nb_pkts)
+	nb_descs = xskq_prod_nb_free(pool->cq, nb_descs);
+	if (!nb_descs)
 		goto out;
 
-	nb_pkts = xskq_cons_read_desc_batch(xs->tx, pool, nb_pkts);
-	if (!nb_pkts) {
+	nb_descs = xskq_cons_read_desc_batch(xs->tx, pool, nb_descs);
+	if (!nb_descs) {
 		xs->tx->queue_empty_descs++;
 		goto out;
 	}
 
 	__xskq_cons_release(xs->tx);
-	xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_pkts);
+	xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_descs);
 	xs->sk.sk_write_space(&xs->sk);
 
 out:
 	rcu_read_unlock();
-	return nb_pkts;
+	return nb_descs;
 }
 EXPORT_SYMBOL(xsk_tx_peek_release_desc_batch);
 
-- 
2.41.3

