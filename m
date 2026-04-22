Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511C3A5442
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 03:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829029; cv=none; b=Zd/G2lPiSAeZdv9l8U0OPUdcWVp8r1A+R1D53ihkVwE2cdrigcXSMUIJ0+/QzdOYbAg+ZlIQN5joKuE8CzB8onhMSjdoVIer7mmThceO1vW5rj1APZrs9lNthN2EBCFt3Vle65c/oXh+L/eXHD+2zqZZB0mzBzieuEwN07Upo1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829029; c=relaxed/simple;
	bh=TlmfMj0oSjpUNpbiocpFSZqid0mqlfXPvbNwh7NE30k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X0O4F7+jQcuRRT2MR08XBrigEjnubQ6YenHl7fvN3k1A420G3tcxh7nTnckbrTAv5Ci1x3l/XCbR0pDWw1S9nc8tYb8+PwAJ/cKE8lUvFYn0bT/bmC9HATdugnT6QkTT+QJgZbgASf1hbt9JoZc4Ku9WHHlcC5OttZrvQ10fSKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKlrXjeF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKlrXjeF"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso3012537b3a.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829028; x=1777433828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUXScEQ9v1TBc9CvHH+nPgE6m6kMqTjtcGXW0lXDNGM=;
        b=pKlrXjeF5ey5zWVUWiZfOVG/O+T9l8WBMvV0wzLiSfYRrpxeL9P7AcSxRNdzcf5fAq
         0WNGnLxwVN95gVPFKbQGIX1kEXwEIQ21LvhMxrkXRyRGXuCnFFlq++F2Tm83vY7nmLZA
         vQGTUh0yBa+BA5NPeg37iYVZcCaoGaFuuT1MpLq1wm6JbefCIDBuQEAiv2KSuUEtl55v
         lcomm1YjYv1BzCb2/3gcquRzn5douJs7RGmPtOxp2gEej+lUrOhW3gOibfnZCvmZpIpP
         0okmhAMug8Vo552oZR9hzs2W6HfgvHoDf9Sb2h1QAyk9IEu96lsRBCUNsOpJ+3I8UwnP
         fxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829028; x=1777433828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WUXScEQ9v1TBc9CvHH+nPgE6m6kMqTjtcGXW0lXDNGM=;
        b=PBlSXTE4OZZQ38L4a4kcKf3wx4f9pkeaychOi1N1H9Y3Zf60vDjKBJj/7h20DMFsE+
         ee59wDSY3jiHTXijW0qeyisU0FBlotqfwLZ4T0j8/fobfcc38i4SX8TwJ9NVlt4ErPLS
         28GWCJfT900WfQ5bdygZG1h0YxnOvc+ci0wJonmNNBFeGvUtKArvHGKhyLUddbCL9bxq
         XDcPSlvaK8GSAtXzxPMepIwGf6p1RAnq+Pk0UgiCEqCca/QWiUSrZjjYWB0anC+xitPS
         lH39FJyWTdCUDCn1KAqxQMHR8gt0Uq/e1kQFYXToMdAANCfMKbBwQAyXt6IXHMDiBIvI
         mVAA==
X-Gm-Message-State: AOJu0YzL0YzIt5PIkuZcjLy3XbbO/pLDa/5oOFrpfu6Hox7GjYrzz3UZ
	cyrfNwT7/bCJlWJJz0FrYiOtJiSoLo1YBiQsH43G+H982UZ/hfIovL0Y
X-Gm-Gg: AeBDiev9oJZ3ZKdykcirpXWP5T2YWVCkcWVdgLHwxh8PwPO09c3CbUsycrqf1h8P/BA
	z1bs0/o1HDQebLWz+Tvc8O6EnLvg/2CQumSos3yGKAMBSSANfmYBMW2KCgQs4K+FZhegNXviKg+
	RIJcTIUrrsQ4Fw3ElXzVpVrig1sDnJMfj6IKZgAkedaLCHg+Y4ryBaGIzDzikEfJx05RUHzNcra
	KDFSi6ZJBiImES+N5JAhmzOs9QVZ2tjP6q/zjTxXWc8+bAUgtb0JPxZbIb5r8b6hGe+Vmt0K7P0
	m8Bt0AVrVxj0+cDrhJWPrYEFQ8iGyEqZjzyFsRULr8aaxu2FzQAU8/y0rf+pz/xPhzgSp4ZsyUy
	hvk8GFYBHqaIRjZcR83XDxnLi9wKCqxVhHxXY/+f8ioeSFZhswzwVEJlGq3s/0F0fBADxGZZ/eF
	jy8X+x7EbDbTQPmE0b9RGeD1fNyIkjyJucGXBR00xgoVTWI/SqkXqExsYaGYbKQCSmD5EHnc6+X
	iGopbek
X-Received: by 2002:a05:6a00:3cce:b0:82f:6b70:5a71 with SMTP id d2e1a72fcca58-82f8b507fbfmr16996956b3a.21.1776829027662;
        Tue, 21 Apr 2026 20:37:07 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:07 -0700 (PDT)
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
Subject: [PATCH net v3 2/8] xsk: handle NULL dereference of the skb without frags issue
Date: Wed, 22 Apr 2026 11:36:44 +0800
Message-Id: <20260422033650.68457-3-kerneljasonxing@gmail.com>
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

When a first descriptor (xs->skb == NULL) triggers -EOVERFLOW in
xsk_build_skb_zerocopy (e.g., MAX_SKB_FRAGS exceeded), the free_err
EOVERFLOW handler unconditionally dereferences xs->skb via
xsk_inc_num_desc(xs->skb) and xsk_drop_skb(xs->skb), causing a NULL
pointer dereference.

In this series, the skb is already freed by kfree_skb() inside
xsk_build_skb_zerocopy for the first-descriptor case, so we only need
to do the bookkeeping: cancel the one reserved CQ slot and account for
the single invalid descriptor.

Guard the existing xsk_inc_num_desc/xsk_drop_skb calls with an
xs->skb check (for the continuation case), and add an else branch
for the first-descriptor case that manually cancels the CQ slot and
increments invalid_descs by one.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6149f6a79897..6521604f8d42 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -893,9 +893,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
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

