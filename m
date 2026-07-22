Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFB6470E8A
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784747974; cv=none; b=FwJOunX1qtp6ueIDLvLWqZZnt9P4rPUb2A5xpzB9lPizqnxFr7yWPjBedcvmLgGy4CHSrWycNmBmF2wyT/RODccQk3O8qqTzB0mLi5q1C5jyYYgHeU/nBlNoctuiLpOtMsAQsuYg5oSSGX5QWsOHOcDhMuctMIvR7rYU1bNCgOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784747974; c=relaxed/simple;
	bh=Jb9J5bSOSje9FMdG7C+lQp/nEJBkbTNQ6Tu3vF6YLm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITSgrI1aSa7rvwlXpcmr7VbEkv4RdErm1n8WLtDSE2EvENVpyaNL/+GEFtlasPWD01JR30/Rk7V1uXSSqsMmFGkJBzbcl7XGI3GgY9hMWv2tQ+bkboePba8Nofc8PoNHWiF0TKlBiuVjwyKNOlQn7WJ9zziUjmleGpkp1RfWzK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=KWnoGLja; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="KWnoGLja"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47db714766aso3884786f8f.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1784747969; x=1785352769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pnInvCDAwEksrdCAmMtd6TY5IpoNHnNiOOgeViffG5c=;
        b=KWnoGLjaztBwfvaNzv3hM8DLIpDdS0MGN/bpFMCS1lIM0PYf7kzJqsX+d3kMWptqx5
         hLRpjsTf0oAnwAdEBRiBpMMc1lbIYRv5diN4U4M/vhYcbiQxWwqajKEvzttN3xsP4hRe
         sRYh1ngrIyxB+MnZP9/yqnDzzqHs0XjYMlhAJ04MbHikJ6X/wGNmHmsmt3QuJ4wyUWAB
         phk0hH873T4tdw8Kr6aoFHL6us7YTvrlzIvYBLLWUg41ZYpqW1WkHuVDyjrrELXGfBEI
         3kNWiRGjJMAtluPcKd/Aa+2pZhg6NUC0+u9IscRiRmRRReF1nuQ5bMtrqtGBbTQTSfD2
         efBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784747969; x=1785352769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pnInvCDAwEksrdCAmMtd6TY5IpoNHnNiOOgeViffG5c=;
        b=XkQ5Kj4Dkc+a/YCBl9UqQXqHGOfmuAL8PzW7dfGDPg5Xqr/L5nHlMRYYCEImyy4T2P
         XxcXLwIXH1r64B6LZQf1M5FcPhOK/e2uBrbzlwH/UPTWtVpeuSqAsJpO/g3SuV1xwZPI
         H0ogvaa109xA3P00ZVOdM7dDaVb1eHuWAO0wpCEXFnW6fFUqffvxfUAt4G1Q9KSNFhAg
         vfi+e+O0w6LBqubA9/12Uac3dzfGXto6psCoqoMPuaFV041+OCYIbJ3npcFl27CUihLF
         UsmLIUKOdNX45PlGZ4ZwQCgoAb0hRP9Ql8HDSWUwFnCp4a+8nkeAhvdhihv8X/4Xf1d9
         3YTA==
X-Forwarded-Encrypted: i=1; AHgh+RpTc84VxjYs0BRD4FsnvxHv6GnfoGq/wnDqMLPM1EA/hT0JcYrE9/lUN6sWQyP37hg20fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ggcaZT8OFz2epPmMWvW8uPK+psq9c8EyxSZ/9uIbcDZ06JR0
	XLgagU3cGnWK7IzuAvQIpf8P6naImDq23VqJ8IkGT3VtiO9q71orRfT2urhbZtlJgn4=
X-Gm-Gg: AR+sD10JMHCUM/iHEqqgOWDH6P5hD9kS9x4RTbGD4S8JcZsE6lnOINTiDJEfZJn0Td5
	WseEAYFNCSodsEGRVoResTIqPpcgH2vnzS+Ztfvwgf8Ypm+FX1tyYhOZoXgqnKnDX+2Aj1yH7RS
	hdt5Zji+rKUFk5YKo2wJcHhuZ+xiPGBcXExSXrp57SsIrCRuIT4rZv5wBC6+weWGb/uP1xJwX3K
	QDeiYkoCw0FbsMPaQ5IdnNxk2OYlrK3WRh2F06fZjOaNM3lJisAd5/nuuwOWh5bwokRMbJwwfmm
	3BAZWmVB0puJ+A3CeC2eU1f/U075hcRHij5JdrwMLMuGZEMdiiApHAG9caDKz+GimqTs7zwHN7i
	H9nQtHGrPgQbnVo84adjfFTT3ofkz80kpAszQsShgRkfhp4cQFzfdr8kAClDC/XGMTWV1ssU7Gp
	pT5JMN
X-Received: by 2002:a05:6000:25e2:b0:47f:537b:d5d0 with SMTP id ffacd0b85a97d-47f840c95admr7850328f8f.28.1784747969382;
        Wed, 22 Jul 2026 12:19:29 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:26dc::3df:4d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c67339sm8862982f8f.31.2026.07.22.12.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 12:19:28 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
Subject: [PATCH net v3] veth: convert frag_list skbs before running XDP
Date: Wed, 22 Jul 2026 20:19:25 +0100
Message-ID: <20260722191925.2192070-1-matt@readmodwrite.com>
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

Route non-linear skbs through skb_pp_cow_data() before exposing them to
XDP, and only advertise XDP frags when the resulting skb has frags[].
skb_copy_bits() already handles frag_list input, and skb_pp_cow_data()
builds frags[] output with skb_add_rx_frag(), which is the
representation XDP multi-buffer expects.

Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
Changes in v3:
- Target net instead of bpf.
- Add Return: to the skb_pp_cow_data() kerneldoc.

Changes in v2:
- Use skb_is_nonlinear() in veth_convert_skb_to_xdp_buff().
- Move the skb_pp_cow_data() comment into kerneldoc.

 drivers/net/veth.c |  4 ++--
 net/core/skbuff.c  | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 1c5142149175..00e34afd858e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -756,7 +756,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	u32 frame_sz;
 
 	if (skb_shared(skb) || skb_head_is_locked(skb) ||
-	    skb_shinfo(skb)->nr_frags ||
+	    skb_is_nonlinear(skb) ||
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
index 18dabb4e9cfa..ba3dbac80fb4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -927,6 +927,18 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
+/**
+ * skb_pp_cow_data() - copy skb data into page-pool backed storage
+ * @pool: page pool to allocate from
+ * @pskb: pointer to skb pointer, replaced with the copied skb on success
+ * @headroom: headroom to reserve in the copied skb
+ *
+ * skb_copy_bits() handles both frags[] and frag_list input. If the copied
+ * skb remains non-linear, it uses frags[], which is the representation used
+ * by XDP multi-buffer.
+ *
+ * Return: 0 on success or a negative errno on failure.
+ */
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom)
 {
@@ -936,12 +948,6 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 	int err, i, head_off;
 	void *data;
 
-	/* XDP does not support fraglist so we need to linearize
-	 * the skb.
-	 */
-	if (skb_has_frag_list(skb))
-		return -EOPNOTSUPP;
-
 	max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE - headroom);
 	if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
 		return -ENOMEM;
-- 
2.43.0

