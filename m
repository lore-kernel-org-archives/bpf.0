Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3975E2DB7BA
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 05:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009117; cv=none; b=IyD4X+qUpQQWF2eROmHPRvgz3YaI0nmdET9agXpceC52yIzq8y6mpQnz74p3x0NarDsIYTTsr4TNGNSwfYrTWuIZTgBCrB9AX+EMvDduouu9VKJlm4JSeqXMCkdhy8PE6JTwkbqhdqeej1XIxEAbklj7GOZ698kKAxu9NIEWyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009117; c=relaxed/simple;
	bh=TlmfMj0oSjpUNpbiocpFSZqid0mqlfXPvbNwh7NE30k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MXnVB2J9AQ9aW5NjQV+3UCrq24xsPLckYXLKflmXpbRZnra/dYtJrAyDGImPGFzD6uXMdAKNQ23TYf/EUDTNFzSoVqOPc8hazjTyd2wopgIpBpWRko7fBOVDbyXxdutu5ZcGot3nv61vHfPF+HQoI+np4qGrp9xuYRIiUKTg5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJIHtcw3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJIHtcw3"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so8428800a91.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009115; x=1777613915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUXScEQ9v1TBc9CvHH+nPgE6m6kMqTjtcGXW0lXDNGM=;
        b=fJIHtcw37zv9dIHr0VcJ44WP/PkSykznNZ93V7Z1bZgz9ueSzNW5BrbyDbOMt4bIwx
         qLGA4Aa47sNgWjIISe0euyXExFu9v+JD5qs9wQ6erpycNvPzUmCXjRwPeD2FITQHDptO
         FR+mmuXCakiH+4ZtGHIqFmNsIaei+Qn3oSlqXO3pYhD9kzPtNT/Ov9CAtyrlZCjr7YRH
         jaQnydqBwTfcPQs3t8C124x7XHUC3owEkRKVqJabLvAwFZCb031Qq6is9XmSBtRC9mrG
         5GpcMAzl6Ipx1uIZbMGHfGuKHWi6cgF/9+ywN0NQBwnxQp5qBNPFbUFqjx0yPv0i2MCX
         dQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009115; x=1777613915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WUXScEQ9v1TBc9CvHH+nPgE6m6kMqTjtcGXW0lXDNGM=;
        b=IWXdDKsfR07/T5vO5imIH0aqtxM/xiOh3b/FH1DkjsXyYe8v3fBjoSGAwJx5VEOZs/
         NOFMgJv/8IZ6QD+7YeHjwQwEncq5SXG/BRlm2UkQcuuhaMQhohPy1qFngfFa+qfIzkAk
         BvPMAummyooaaymHZQAP/ynGYb03gxTQJm/5pL3WST65LaDIaqJ8lHg1x+TB9wPhVswt
         WR5CL/OJu3Y8x+bVDVla4eRQTbRzItGVtRdX2I/2AY+RvPGpQBkKHBQrHmoOzKzqfjDy
         7HMEEAvgBGbkUqrv4Y8Q58OHdLHzteYxGDeChe4xfuPBj05fhR9bfnh3Rkh6McfEPZrp
         VCdw==
X-Gm-Message-State: AOJu0YwjXWMfjbB9JVo9hmHoUIesSs7UAK2iKRKmK0ieK2xl6ISDhE2J
	+RFVx0/RKi9YlpBsfBOwDcyztjBhsm7iCaH1kikEOLPfmRbCXTeU9Vrc
X-Gm-Gg: AeBDiev3Cr18zEmq5Fv1ZhSKfxsxvp4zwTTeoovuLcNp84p5MtMa+Qxfv5piNAwznY2
	Tc+xO1LNa0V3992xFDqSDYguo9FeSjN/em9eefGFTW3zruZg6R/DJT8TVqIb/4t0BGDSkqioOAI
	5lQgT/SLL5KAL9NVC1C6NG7RoEgDhB3uCsW5aHH4cKPVl1G+WS1svQRZuNQn66Insw7NSc7DACs
	rRc9NghWHf6CbAcqgbx5dboIDY6syz60v01cUtsCmniEzWIBbLGIiCCxqLbNFUuwlYcwKQ5Sx8k
	vhmddycdvTEzunlZZ95OVjAEOKNEhpPZF4F3gsxPyQ8ddMeHI/TswGpSWudFG2S77063rHR/XLe
	XWeYJxVzLPgfbajJA1cgeO7bH8ge08XrZvpP9uG3Ga+aYLc4tjEGvwqCX2ylKvd15C+qzrlo/qT
	cYWkLB2hwnSnvnJ9ShJoRmJEqdXeGr+9SGfvhNv4cf2v5dvsI9u00BrfC/eE53/cBfkvjt72sOy
	OcVBqv6M5WOhOcU9TLbILMtkdWXFTzL0KPAA9YkEoUQQ0Gz8x4=
X-Received: by 2002:a17:903:28cb:b0:2b4:59d4:9a with SMTP id d9443c01a7336-2b5f9e77d80mr229281675ad.2.1777009115600;
        Thu, 23 Apr 2026 22:38:35 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:34 -0700 (PDT)
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
Subject: [PATCH net v4 2/8] xsk: handle NULL dereference of the skb without frags issue
Date: Fri, 24 Apr 2026 13:38:10 +0800
Message-Id: <20260424053816.27965-3-kerneljasonxing@gmail.com>
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

