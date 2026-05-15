Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B8C47DF84
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848242; cv=none; b=Olr/ksKvoXsp0KYbeqw6S/7fak3vUqfJ/TNlbvi+EfpscQuqw9/lojyIOpxvh7UDjhE5RFwazCa7lVEi5xvCtf4JQJgZfX8uWRKgRZv2QrRYcmwmX9F44IadpwTGPySIfTyoEI31OCx9wz9myi8bP1nGO5xHYYEoEFzapwSzDGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848242; c=relaxed/simple;
	bh=lNhmRx2RUJ7H07Ci0KctaR42KIjvgj533CKUPRrvdhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uf7zNT0ckD7nECIiaeb2z+Eg91wCjMkKON06xGaIwt3G+/+0XEM0JT4vdwhwbWvSNIckc7BmaFL9B+0ZZ8f9pOhEWDeybbP5IaOjqceA/SmkawKTAcDFFv7jPR8xZPj5fsC4OAelOni6aZRozvCHOwPYnyFhAPZSgeu/NoDQNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbLagwll; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbLagwll"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bc85eda6b6so32994295ad.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 05:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848240; x=1779453040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j89QRPmeBr72gJxV2lEqSzN0fu5h/G1MZUN/zKxj7Wo=;
        b=SbLagwllU4MDIBPzzEwZXWJss8mFoP/4RdcpTi0UNMET0LOcHNr2EpXEg8+6C75CEx
         hhr2ZMuSLBIMd8mVDpc6dph5azAk1bldjJljTBMf3waUBdF3pv+LqpdRcEcF1JxSRV7n
         3y1PCYH/kWzMQo1UewhMtP8E649ADrPiUgrPoa6dKmybCMfskzPj41oCfz0Cd/N6slzJ
         keD1oyCD/ac6fDBCMueudC1/mFOskbD9Ak9grfhCWZGofydWCwegEGL55mZ7PFHOrij+
         doEdz94MG29SpksxJeJkVGcEyY9jmT1dRcMPMiRI1jWDySi/vJTibjacFQdJMRcVwdPk
         78dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848240; x=1779453040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j89QRPmeBr72gJxV2lEqSzN0fu5h/G1MZUN/zKxj7Wo=;
        b=eg/pd532kXSGVp0hj0kT/cPJloYtI4SEawyZq932Rhaevnkoobf1AHOAHqbdAyFFNT
         4V7Z35d6FymCiLYYoWrT+VGlsSNUQ7n4hixPEhvfMRSX57UdeZoCnnr3eoE51h+aBh5V
         pmzwbeo7YG7eOZUP5J2KcVOA7nRr8tpzCsHHd+aDEZR6m1nJVRhmVSWQK3mBgj0fgiLy
         wtRgNH5DIP8NP/cTnjCRUU2BJXGQAxU1S+qG2KQAnaQCLmw3XLLjDN8+mQUUWGjQl5/L
         j0VVc/EFHseQ8BeB0YPJ4adWSUO9DL/s2acrYrrVftYCMMQNm9bSaGs12BCue9Dz/2TE
         8U1Q==
X-Gm-Message-State: AOJu0YzJKZgsd0n0ZpgNW+Nx7BLOU1ZjptVLrCfYASmFZ9pDQLTwgPF5
	YvyG1/VezbeFuEuunv06YjFRP53R109DimETy+YK+ImaD/e/u182Zt6C
X-Gm-Gg: Acq92OGe/pKM9UiCJICXndAQzcX6esi1Kvvkdp7EuXhLzhNKxqHXLcMJ1EHO3ShoArC
	LU0UzTTWutTuET8MSQz2J6sK7axKA32uRTROm6m1y08neH3vYOe/SMDOsC0ao5C0/tvnXypwpg1
	Fow8U1OEuImGV4jVzgHlq0PE4yywR1nJO/gc//z5lVlGKsPV2wD5eTPknyHEEJyPzqTyKPlqVIn
	cBboBWaYi9FBVb+4h+MI9QdtfFZiYgIW/Q+DxYNC8JQA54XmMQwlW3KDTg5x/WMNJoH433J9pZl
	7ARjCGOuOzjkEK0X/lPaoWOcjXETFWp6qTXPpfF1nfO1CcDqmVJrgjPUSR27A19gVWXZnBqs8Dh
	/+dWFPb+UxO/UC2EMMj7TYT/OaC72w6S2kJbY22woNnKPTKzqhsZW/Wp8QwQZ7rEUdY84LqH4/4
	qX83g30JcIet1ol33q30IrLw0jOcOY1cN3hUACJrVTOCcEqVALSVlj7+E6Q7ANfAOMYVE+m+BDE
	Yc+/mOBsA1iq7daVqxPzGduN3d7T1U=
X-Received: by 2002:a17:902:b693:b0:2ba:881f:6192 with SMTP id d9443c01a7336-2bd7e8f10eemr31784485ad.22.1778848240163;
        Fri, 15 May 2026 05:30:40 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:a48a:1116:aa2d:1122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe492asm60348885ad.48.2026.05.15.05.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:30:39 -0700 (PDT)
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
Subject: [PATCH net v2 1/5] xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
Date: Fri, 15 May 2026 20:30:14 +0800
Message-Id: <20260515123018.80147-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260515123018.80147-1-kerneljasonxing@gmail.com>
References: <20260515123018.80147-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The TX metadata area resides in the UMEM buffer which is memory-mapped
and concurrently writable by userspace. In xsk_skb_metadata(),
csum_start and csum_offset are read from shared memory for bounds
validation, then read again for skb assignment. A malicious userspace
application can race to overwrite these values between the two reads,
bypassing the bounds check and causing out-of-bounds memory access
during checksum computation in the transmit path.

Fix this by reading csum_start and csum_offset into local variables
once, then using the local copies for both validation and assignment.

Note that other metadata fields (flags, launch_time) and the cached
csum fields may be mutually inconsistent due to concurrent userspace
writes, but this is benign: the only security-critical invariant is
that each field's validated value is the same one used, which local
caching guarantees.

Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6bcd77068e52..adcec1d22e8b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 			    u32 hr)
 {
 	struct xsk_tx_metadata *meta = NULL;
+	u16 csum_start, csum_offset;
 
 	if (unlikely(pool->tx_metadata_len == 0))
 		return -EINVAL;
@@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		return -EINVAL;
 
 	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
-		if (unlikely(meta->request.csum_start +
-			     meta->request.csum_offset +
+		csum_start = READ_ONCE(meta->request.csum_start);
+		csum_offset = READ_ONCE(meta->request.csum_offset);
+
+		if (unlikely(csum_start + csum_offset +
 			     sizeof(__sum16) > desc->len))
 			return -EINVAL;
 
-		skb->csum_start = hr + meta->request.csum_start;
-		skb->csum_offset = meta->request.csum_offset;
+		skb->csum_start = hr + csum_start;
+		skb->csum_offset = csum_offset;
 		skb->ip_summed = CHECKSUM_PARTIAL;
 
 		if (unlikely(pool->tx_sw_csum)) {
-- 
2.41.3

