Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE21433557B
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 04:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776488247; cv=none; b=qsiuviap9ti3uUexAqYU23JgzRUEAJT1TbQMgnGuCW9WWspiEDnxwew3HtM+BwxBzCz/6l2XZ/OEcZN1ZJ7lrblcguu0Q7v5pBf3qKeOoj9g90EKCq+hcMmhsFoUjiF3V9T0srxXrk+X2S19YjjzXrFa7OxR35YTvpnMwYW9S8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776488247; c=relaxed/simple;
	bh=noCuVUbIZS87iKo2soZQK++66nTPA97Hb0ZZSl1yh4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lLqF0jsDekIOF9f8hAMYGyUjH0lDfdeodimROAivqVD+ZojE56M2CmbCD1JlbeA/XyubJhnjerbvV5P6PDrzVZnDlCB0/pI6Zv0qNFBBaYQebbbUj9X0Vso6STy1ZrIm8zyoip7ZZ7Qq+W9bGUtLX+Onzs9668KITiQ3Ja10g08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HV+oVsiS; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV+oVsiS"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-356337f058aso891076a91.2
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 21:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776488245; x=1777093045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7fYuN5x2Np/CFxQoQV61Iy8WpLzu2WAC3PFJmjW8IU=;
        b=HV+oVsiSFw0VpyRxOcDe5TSVvWFCqV3+uGtt1fJi0vFJUOuSgiWRl+7jpG/yIA9dtY
         CPkfycJpaaD7Uh3z9X6x9durrJszTxyObZeETNPAt5OMpcynZlHk+w02qbdrVNn93UH+
         yKwHnfuXOpK2cElsTG1s58RJe/I3sAczToB9jEsDY2vUTXcG5g3dCdKiS2HjSdYORpPc
         e9hjpE68MIKKILL7bPSKywwiU6Bz9c/r+CpsifsJlVNu95WJr8LZ9/Cy/D5nnSe2MrkY
         4uHvy422SduGbVJaQzERV5HbhguKa6unCOKuLTPk0qLsEXw/RrRIJaVQ8RwXKwvMzOsZ
         GDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776488245; x=1777093045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7fYuN5x2Np/CFxQoQV61Iy8WpLzu2WAC3PFJmjW8IU=;
        b=O5qetoFTCkymdRMUxotCA0SECs1+QTDB6+nN282da4aF0GPI/8cdaAwe6bHfXWkmKq
         EkSNmni9w8ZCOBJIFGCtvty2vDDfkKV59ZM5l7CgBjiFFOBmRmuijfbml215uz0/keOO
         /3CLmBcx1KOcm2Axe/sZj0y3o1MwfW/XP9+RpgTpRKCTCYI4pcEmUmO2e0bBcT4XMLfO
         xRRGUFFKQyr+hQ/sy1SYcaoEm+h2o6byDnDkw0F9r732AvKLnLOapCAeD14P3CSw1KRV
         N7DhiS5RstiGdk/i5peuvc5A9MomM2ZwdTD4sFyNqV4xJZE3f5chzKa2/RqEvZ+00jAY
         ulTw==
X-Gm-Message-State: AOJu0YzEsYU2i7ZAaL7AQz42/W85lwDP7mN/2vQrjduAMXidZa94FmQS
	31nOMX8eR0wNl8GPWDJNNxAewF9bmvYCdmCFcZ8RKAwfZ/dwd/GiocVh
X-Gm-Gg: AeBDieu6NQwgHDnJVAJzGQdxUHJsTvSeryjH+MnCV+QwEjQ2Wevcol053cyGlpzjaGt
	cHiS+08vMfQnPzynOE43TslzKg8jXHoZBJ9+oZfHu7qhXgu5lkNLUitQfZFD/3Yd/AY8gIumIyH
	pQJmhotcVBcCPeRB4eP9hQdiTHit4zXQtxMkbFvbyL937qQjdxIpnu3FfaDAxvhZhAK495xVeNa
	NDIqe7fPHUjY3gCcbO2GXmsefznw9enPojg6EBzkQ1A9ZdW6IQsF3Qe3IzbEPTcseXNJqBu9pMa
	VLOAS/CYx1p+uY44xNWICttWj/GSXLiVWUI1smKeft8tCSCbsKqjAtBjPTN2AkRQR+tuR07BhNz
	wZiJKD1CYe7ilgc7BqeQZYNk1biKKl8zw2PLQJdMZktTIpj+yqxH+ZvejZ4zPo4jmbQcEAlIV06
	bJtf3zoIhr7E9fW3ridnxLBThCqQf2QgOMS9riNPy1CMVJKzWRAe7pf+t88LDmXofc+a1e/KnEW
	XYD52g8FQ==
X-Received: by 2002:a17:90b:4c52:b0:35f:b647:d98a with SMTP id 98e67ed59e1d1-361403c3412mr6182207a91.5.1776488245131;
        Fri, 17 Apr 2026 21:57:25 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1924:8520:35f1:286f:2ada:eed0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a92asm3502377a91.10.2026.04.17.21.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:57:24 -0700 (PDT)
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
Subject: [PATCH net 3/4] xsk: handle NULL dereference of the skb without frags issue
Date: Sat, 18 Apr 2026 12:56:43 +0800
Message-Id: <20260418045644.28612-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260418045644.28612-1-kerneljasonxing@gmail.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When a first descriptor (xs->skb == NULL) triggers -EOVERFLOW in
xsk_build_skb_zerocopy (e.g., MAX_SKB_FRAGS exceeded), the free_err
EOVERFLOW handler unconditionally dereferences xs->skb via
xsk_inc_num_desc(xs->skb) and xsk_drop_skb(xs->skb), causing a NULL
pointer dereference.

In the patch 2/4, the skb is already freed by kfree_skb() inside
xsk_build_skb_zerocopy for the first-descriptor case, so we only need
to do the bookkeeping: cancel the one reserved CQ slot and account for
the single invalid descriptor.

Guard the existing xsk_inc_num_desc/xsk_drop_skb calls with an
xs->skb check (for the continuation case), and add an else branch
for the first-descriptor case that manually cancels the CQ slot and
increments invalid_descs by one.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5d3dbb118730..2918b773aa84 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -898,9 +898,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-		/* Drop the packet */
-		xsk_inc_num_desc(xs->skb);
-		xsk_drop_skb(xs->skb);
+		if (xs->skb) {
+			/* Drop the packet */
+			xsk_inc_num_desc(xs->skb);
+			xsk_drop_skb(xs->skb);
+		} else {
+			xsk_cq_cancel_locked(xs->pool, 1);
+			xs->tx->invalid_descs++;
+		}
 		xskq_cons_release(xs->tx);
 	} else {
 		/* Let application retry */
-- 
2.41.3

