Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE3918DB35
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009136; cv=none; b=KHe3ViZVaY1Vz2TySksn7j+0v4HJwiy/mYl4m9TJKq6J1l4SSCXaxdiOVansxzIedClc6+j4UeJvA5jSzjAN4tPzC830D3Zn9OwdrcvwaW+fzJ02R6MUKZMiZGc2Lb/jTlah1r3RgQjclfFjJpb/nrUjYpqpbjZdobisIgUuuBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009136; c=relaxed/simple;
	bh=hQTOTAcAM7dSAaT0JT96AMlFkrzDUi5FN0X7qA2AwNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhRyA7xyWnWaGQBubxPedcG74NBpT2U2Q9Y/G2X33JWLv1d/DfVY+62WX6/7BXrH+NmvQjxNOrFjCNGqGc8G2ewXNJ7v3tkmWTUbQ/6Cw2LvHlYePz3ahmvdhjY1j/jqMNnTajlz66A+n8MERDbxTC4qIQVurbkQXIxYAWWPwG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6aRxtxz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6aRxtxz"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b24fede2acso49423085ad.3
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009134; x=1777613934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlECDRyT4eHN/C8Ao43eaYpseh2z5fQuz0y+K5GaXwk=;
        b=q6aRxtxzj1OSp7X6Zpa8b908z7V3Go8QKnkJ+HfIhQU/I8jNa3ZQJIIgIsy2DQmoJG
         ynqwYmmUkz0jCZVL6wB+sL3fXI4+KF4QOPds6AJLW+BJgthFIrlHHhjtUWS1IqEaOJM5
         Jt7n7TII96/oz2Lj5gE4fg1bMbTPQS/OkKobt10jOOBLTCN9P5c7ISv6gQTPwm4Sr1nT
         dpTae+Ph1f7nsqzzhMFDX8cBJ8aD2H5SxSfqUhYrA1fsEjhbFaZGpUH7RjFgkev8B2qI
         JOc+iNoK/k2s5ZCT8i4JWPYja9TM2G50GSgg/5gKn0xWj4vshDM37dJpWCt8ryijwPHN
         TRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009134; x=1777613934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hlECDRyT4eHN/C8Ao43eaYpseh2z5fQuz0y+K5GaXwk=;
        b=TmoHKGpatpJcdxJUUMxUjYoVE2UQHqN0yU4/GBNn+rHXdfWi1eJJpTXGmKddvDwLdt
         Wjg/2nu+bsN26BbrKEZyerza4jC37AB/uiD1x0zi/GZTB8zJNzYkflZI+NpNhycEYVYg
         u5TMtkMPKY/7w4C93L4n7WnSdZq/SOXJkdHpWB7d39H5G16sTjkiV11kT27b/i6SHvPQ
         X3c3vFDY3n9w7/rt185PoSawShAS/E8Ue5xgW6OohY1vV/FHO8vWKPQQTjeoG9Cy3nxB
         awNTpGCwCxEa+IkrNnez88PTolOzadxvAIo8hS3gTsW1Bqr7/nfEgolNb5g5WGzYbxCc
         9SAQ==
X-Gm-Message-State: AOJu0Yy6I41a7gMyCbvVJzXIJz51hFoVgUzrmpRR3Wv4MxXsDbCcYujl
	4YArwFaAs98EYmg5iXFEZf3D5/O3jBVNM8kF2OBYP35mIGRjec/pBO2H
X-Gm-Gg: AeBDiesSbyJyHeWSry3n1MNQgRz+yu2lzo6/BXi6+aD1JcmPpM5yk5uuz12gnNjgLCm
	9mbRztx+XbKgWiMfjzk3RZzjnoUK/DPwDYOivwqghuzKyeaX4W+m/6hcvRg9wVdkPww9XyYzLz5
	4cILEKHi9oxR3vg88/lw+LMadj8topxn86Xvr8KCU12Kr7S0QZWuevFZ4xXmBoEG12mZaI1xVwg
	iBPauZnu42HqZWLx9oacv1+DvKywteNTO+gc5Xmab+ikEN37CyssgQCfqUcjKhY2NM9gnxAfj2w
	3FlbSEPiSlB7csV3cK1SVzfqFkesnmlfPWBh1q9xpOZUwu+PkwZ86hB2FMFeMWdcOLOHjG85uaB
	ejLDrjOWnRBkr71dNAtd8nPVp5C0ibvA79cWGlI+JkMTpSAV1IT3brVrbWr8wb27gZaOaTwofP6
	kHx6YvhJ8EWvH4kPUY5fcb/drnBN/b+ex7j5ZqNn7HVHuUs9QL03LHRb49CNwc+S9pfu+9rs2Gd
	p+eKfULmmKJ7VYcBTRe5IiI86vVhYvREomj3xoP
X-Received: by 2002:a17:903:2983:b0:2b2:57ee:c04e with SMTP id d9443c01a7336-2b5f9ee2d5cmr303296495ad.18.1777009134654;
        Thu, 23 Apr 2026 22:38:54 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:54 -0700 (PDT)
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
Subject: [PATCH net v4 6/8] xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
Date: Fri, 24 Apr 2026 13:38:14 +0800
Message-Id: <20260424053816.27965-7-kerneljasonxing@gmail.com>
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

Fix it by explicitly adding kfree_skb() before returning back to its
caller.

How to reproduce it in virtio_net:
1. the current skb is the first one (which means xs->skb is NULL) and
   hit the limit MAX_SKB_FRAGS.
2. xsk_build_skb_zerocopy() returns -EOVERFLOW.
3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'. This
   is why bug can be triggered.
4. there is no chance to free this skb anymore.

Note that if in this case the xs->skb is not NULL, xsk_build_skb() will
call xsk_drop_skb(xs->skb) to do the right thing.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index c49b58199d2f..5e6326e076ab 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -776,8 +776,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	addr = buffer - pool->addrs;
 
 	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
-		if (unlikely(i >= MAX_SKB_FRAGS))
+		if (unlikely(i >= MAX_SKB_FRAGS)) {
+			if (!xs->skb)
+				kfree_skb(skb);
 			return ERR_PTR(-EOVERFLOW);
+		}
 
 		page = pool->umem->pgs[addr >> PAGE_SHIFT];
 		get_page(page);
-- 
2.41.3

