Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3514A60F
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237788; cv=none; b=J4m/AzSiN2NqKn1LDL0pyiayCh3iMVEYH167ziBTLVUym+ExN+2ji1pWp6lqckI1NbxZUAwrCcHNWtV3zroMPwcbc0fvVlPs5mvYC03Yk3vfW7YrsExHE/5qQiNOSDVALSXvd0DdiAuXF5xsQjzEBrXX5sumnDlaZosdVcLyZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237788; c=relaxed/simple;
	bh=b69IeRzK/gkXviBHF52sHbmYpsdUOWt7Bk6X3kz8qps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sWNu6IH6IYhwqgAvSJBlfxabEFMhgqNeIcJLWxfD4nUt2zZHRd+xTtElNCv2v45TFspGvPMYe5dTuo7utF40d+X5oGr0x0umU7mfRbdOAe5eQ+tSK1wRMUaa8TKto3cdpRMTvSFJV07qnrfm1FxDijAZB4kl3Vaq+qM1tykvofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxy8Ztrh; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxy8Ztrh"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso2966408a91.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 17:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779237787; x=1779842587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEWjwKmS1o82G8iZfnk1MYvRFND8ZVdz4Bvvebda+3Q=;
        b=jxy8ZtrhOyX338BpkvNYQe50gkXrm873hDA7cQpB48lwi9rnndG+DAlwqQPOyZJkir
         F13atJLsmFyY+oFjparmkL9ApHzz3yb1uU/p5nZ64I7r346Dj0CDr0kj8Cq2q/l3TS95
         VLIMuvaoMeZXbeHcVmzROKE4wqp9259sAgCC0iohNO1b8wS/R5A1jhwS6F/F8nYn65dQ
         7qS1EIXHCvUb/52k6Us60xwpBzO6pO9I+8GQbltQTXW9nxZY+GrhNFDrFHm6cDrsFz2o
         KzIv04r6jlzLgAoZIndt0FJQE0ppUZ2+tMpWLT3EFzJobNOxWPeyc2jiEFk8bAyJiOW+
         O/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779237787; x=1779842587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pEWjwKmS1o82G8iZfnk1MYvRFND8ZVdz4Bvvebda+3Q=;
        b=Tjr280c3azdMWC9nMwalRsPhALmKfNdkKjC6FPJSaHCIDGQrVFRUQDBfL8Fxlcj0m7
         BcCRWlpidV9N45+7P1n9yb+BFQa2VwoWW/JON39OOa4fipFdmd7B/eIeDJIejjGJEV0j
         TNwOrd3CZ/pqROzNTSrCsh3C8jnLzbRLZe3fYOZnXyV2edwwzF1/VmIW+snlFVNGWSxl
         33zgsjmylzFFvQtYTVdySGMGbBZ2PDIJkamhF11ZMIQh0zVzIE7BzuIRov5iSQRpGkgA
         btz7tNH9wwbhhlqDaPeeff7Y2gXOKHlrTdjo0+TQJtN8LWjaBvm6TX5R+dTIW3pE7xFk
         t2cg==
X-Gm-Message-State: AOJu0Yy8d/4lX54PhltFJkUmAHWTH2SVFcg2oZAYtHO1pA/54ceNxo0E
	T810/Gs8H7We4ZHH/xeMbTtcVU02jnDTZXJ4ts8N/y8TGLjL0b1d7/4I
X-Gm-Gg: Acq92OGk2uPhQyS/lwYXG0/GRX4p9IZmnIZTkRyOEp7o9YCvrCkLgkmYGQIHtR930Ip
	RMiCMpJevwb9IPuxytHmUCXoDG29+n8IQwyLJPyx/cTpb3Q9Lz8YqMAOqM5A+TrhtHjr91nYeFi
	DRE3HUbxMNloLZddqtr2ALAnuvvaH5nMF5l8cExdHru7GUnNGi4pLYFhHi18ESYnhPx/ZjyvqnB
	4LmXw8bMcwWRQ3bq6s6QNXbd+U0Gen6Wt+rAq76rLngCAi6T4ai8UI7gizd7obdsKCIWelpjlXj
	JMFQSj60lAOZ/WIy58bRUfNrv1IKDN+v0jhdhd9B6GH+cbl2ThWJPF82Q4Ju9Yp9AvF72O1G7bA
	Qme+JQtDElwyzEjYwuFoU66AuA61mYI4DGdyrYh3DnFWZsJyy/DHhDIXsI5AxEdAy/xXE12/BQ3
	pFF9QOWWIAfmu1r22Mz93mBWXLFt3+cUr+dbpzRRAwt5Sr28YC9534iaU5Yk8vY75N45kPbagRJ
	O5UXVw8uylbv+hI02myPVHU9qj4AJs=
X-Received: by 2002:a17:90b:53cb:b0:36a:1de6:6c2d with SMTP id 98e67ed59e1d1-36a1de66e59mr829773a91.10.1779237786921;
        Tue, 19 May 2026 17:43:06 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:f1df:d520:8103:19c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951059f4dsm14746277a91.0.2026.05.19.17.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:43:06 -0700 (PDT)
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
Subject: [PATCH net v4 1/5] xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
Date: Wed, 20 May 2026 08:42:40 +0800
Message-Id: <20260520004244.55663-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260520004244.55663-1-kerneljasonxing@gmail.com>
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
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
index 5e5786cd9af5..f8c8a8c9dfba 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -802,6 +802,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 			    u32 hr)
 {
 	struct xsk_tx_metadata *meta = NULL;
+	u16 csum_start, csum_offset;
 
 	if (unlikely(pool->tx_metadata_len == 0))
 		return -EINVAL;
@@ -811,13 +812,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
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
2.43.7

