Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486393A0E8E
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241705; cv=none; b=Z8NoUF0h/FHOUchSc6a/yUIadYvLBcBT5l8mgfgSW7BeVpQZ87q9szti806V6yJLCU9lCl0ludedNMFpkGKtc7kzjzePxOV7G8ucMwIk+rxgj67K9DUWPl2tQfq5BA2XK6LhcdAcoWgkH65mW9Cf8RW7uvUshF/Sezhg8vc4mqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241705; c=relaxed/simple;
	bh=9fU7EhCw/bsyzLgVuRnp1UTHLjdH4tz74eyq3t/3PUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lh/bBamrdHpbLHDc2iZuVHiXrNgKD1IGiwlsBt9Zw4gMuOxpkw3LHUYPODM234novwMhBZsmLe2ZxLrRScmxR9L7zQg8gAOiaBMJ3D87PpQfXJVOwRY0tOTF06GGarOqkyvNFgNqGxZcXdKlWS7Qh9Knu3t9QEJUwaBgbodOnHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyHXiCg7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyHXiCg7"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad9516a653so32719405ad.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241703; x=1776846503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clm0Pa1JF3el2FcpxvnKLy4LJkpIBZEl1lkmZ7vr5Y0=;
        b=YyHXiCg7hcg9NHOWv501H3Q0Pt/atqEsP9DciHxoxsK5B+Pw1nNOZoQYSzfcXSFmsy
         SAe2IiUjSNJlBoJm9t2SAqmCxA8DKozwg+zLBUNWAgbksx6EznTFu5hLGeeL21JjNIS+
         FO8+p2ZCbHPApSQTxcrIASsex+s+Y4g1gu/FduPi8YCpQnFBwXdG+meQVr2ikjAzfcp0
         UP/JcYtI6JHRaRBTb2ZTJaEk/ZDmNAp2bq0vz1kDD1iqOCQYT8GWbIeaCZV+qfk8ae1t
         EP9wBHcVcPXlt/XlN/7j1P1vlz4eQ6RFdPuf83ZMGHX1F1rFuXOUOeXc1LpuDR29cK+1
         QHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241703; x=1776846503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=clm0Pa1JF3el2FcpxvnKLy4LJkpIBZEl1lkmZ7vr5Y0=;
        b=ErECzVxZoF8LOHZZq/055CWnfry8/fP/EL08eZDtNzl967mCCX8r5xC1VMNkc9/4Ud
         i6knoNLWE7igcB5ZWjLPmAyja040DcCDsNR/misgEYN8ACqh+LIr1eYEHcn1LXnTh07L
         r+OFVPOMsijEsP5b3VpmxP4BV4Dme8gh9+z4Ok9Dqvtg3KI/coaan2IOh9Q1nEBe+otG
         7F/zLP+Is2kr/mLmFw0feLswMxO9Cq12kFrHWJn5H43IywnSQdd3gEsZ6OBZTbr4Mi55
         U84d+d8uNLex2D8/r484OzpSNlfoROLWg6dbwM/XYzuIOZ3yXkJr4RKcop1Za1qMzvxA
         Ti9g==
X-Gm-Message-State: AOJu0YxFoaSnRU0gv7mbY6Oru6qa9WMeQYtAQbSWiXTj1dUxMpcVBzBp
	Awpq8lC7bmCv/l9gyYOcpR+fjWCqNnbAeBS4RgK6trqhXT0h1A0K0ISK
X-Gm-Gg: AeBDieuseKaiyumRIfo+6/QTF9vDdfpjjd12LvY7ulvC7lEfUd8GPDRV+ISdYvW7DdR
	V5oXtp8ffWqeTa81nQCP+HtIJjmyD84jtHiYY+3USZTsSx3Eh3YxYjc0r1b/hvVwLSpwRZItWKw
	laK6cae+Co+h/SO3uF3KBZk3GeXBoLyIERXi8znGZfEKFp2CeVr3wRwulfPoswyqgQi3liHHsLK
	vSMqjMlPZ4TABFYpNiOQGymL2/aMAA/hlrcisy7KUAPBPnro61l8O7sEy+cJCzVFBc+IavjB4HZ
	JbjKYqAfTj9KqasKbIXWfIBmDrLPrPh1akGlPzl95xgJXvqoDL2b+MgjpQ0eL8GPKa/o08GPByw
	tgbEGOcxZrBCcmntrX1xOa7vScBnMJaSo1TKMglknYg0qqLTB+NlNn1uLwnVUTMeKBQWbLIUO1h
	mQIAGVTGLxfH6sl9Jnpst0GE0fUMo+N36JI5cpL2lj35bDKqLh5bfX6i1zhx0UWFBm8dfb0eJS0
	hCnpneV
X-Received: by 2002:a17:903:2f45:b0:2b2:ebed:7af8 with SMTP id d9443c01a7336-2b2ebed7ebamr135992625ad.1.1776241702626;
        Wed, 15 Apr 2026 01:28:22 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:28:21 -0700 (PDT)
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
Subject: [PATCH RFC net-next v4 12/14] xsk: separate read-mostly and write-heavy fields in xsk_buff_pool
Date: Wed, 15 Apr 2026 16:26:52 +0800
Message-Id: <20260415082654.21026-13-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

perf c2c profiling of the AF_XDP generic-copy batch TX path reveals
that ~45% of all cache-line contention (HITM) comes from a single
cacheline inside struct xsk_buff_pool.

The sendmsg CPU reads pool geometry fields (addrs, chunk_size,
headroom, tx_metadata_len, etc.) in the validate and build hot
path, while the NAPI TX-completion CPU writes cq_prod_lock (via
xsk_destruct_skb -> xsk_cq_submit_addr_locked) and
cached_need_wakeup (via xsk_set/clear_tx_need_wakeup) on the same
cacheline—classic false sharing.

This adds one extra cacheline (64 bytes) to the per-pool allocation
but eliminates cross-CPU false sharing between the TX sendmsg and
TX completion paths.

This reorganization improves overall performance by 5-6%, which can
be captured by xdpsock.

After this, the only one hotpot is 6% refcount process, which has
already been batched to minimize the impact in the series.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xsk_buff_pool.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index ccb3b350001f..b1b11e3aa273 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -73,23 +73,27 @@ struct xsk_buff_pool {
 	u64 addrs_cnt;
 	u32 free_list_cnt;
 	u32 dma_pages_cnt;
-	u32 free_heads_cnt;
+
+	/* Read-mostly fields */
 	u32 headroom;
 	u32 chunk_size;
 	u32 chunk_shift;
 	u32 frame_len;
 	u32 xdp_zc_max_segs;
 	u8 tx_metadata_len; /* inherited from umem */
-	u8 cached_need_wakeup;
 	bool uses_need_wakeup;
 	bool unaligned;
 	bool tx_sw_csum;
 	void *addrs;
+
+	/* Write-heavy fields */
 	/* Mutual exclusion of the completion ring in the SKB mode.
 	 * Protect: NAPI TX thread and sendmsg error paths in the SKB
 	 * destructor callback.
 	 */
-	spinlock_t cq_prod_lock;
+	spinlock_t cq_prod_lock ____cacheline_aligned_in_smp;
+	u8 cached_need_wakeup;
+	u32 free_heads_cnt;
 	struct xdp_buff_xsk *free_heads[];
 };
 
-- 
2.41.3

