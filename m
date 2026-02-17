Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729B36B07A
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338781; cv=none; b=dXNWzCEXY3ECbTFH/AE7feh3iD5+XOxUnZUguqO73yLJmyqpazGkPW4huvSDC7jtUvm2fVr3VcwMb+kdplkIu+GAl5olsYf/pTcP9GiJ9qAIrfmPwCojjps+JmlDTn0JPYEiD21WdCpZw00iSkuizmAJ7BFYu6fn8deJvcskDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338781; c=relaxed/simple;
	bh=jdxK9qyg4GvQ0M9+yUqbCMfjEqTvkNj/Dh3EXuDWEUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oM0UGWO/tkEuFiSB1bzCOT0Go466pQPPSKmvfx7ywtz1je9OwEG2qHUmp3xxJNeH3lEGKgMaxjVakzIzqus5f8cSM7sQSmiEa99QEY/kM362/Mni5OX4YDaVLCLpg50MzVry683GH3OHMWEeADigNoUG5hISKN5ld7nONKQPih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZavVQTUz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZavVQTUz"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-824a6f2d816so2030699b3a.3
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 06:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771338779; x=1771943579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gebaghse5OySHou5H1mHGqUHtgCt8QeUT/JMZWe+7bg=;
        b=ZavVQTUzNYv/Lq4WG7b/Y4vixEMZnPswVVRGpqBnoSJplQC0q4an1ZuOrLPLnh98wB
         o69mxQWEZUjwPLBMql1qzw5MyyEjGcXySIIxQdiGh0HSmjIlJ9hIgtHKDHL5Hdvb792A
         4Q+6fBjgrsMvuD1F13FgeuwP+3VmmwB1kFlXNChqtUIxCyJHc1jcGwwLXb0DrkXFA8fe
         XYPXuEI7nT0qOAR2uXP5qhxPMVCQGd1yoHJL8LD4fvTYT4l0oO6wJoQzLBDL3LvLgD//
         /rxwRXgA7U6g1xFpXs2dfoThBg0M9T4KhS5thq4f2mwVnsgOCe2g8CfWZxOa5dYQPCpc
         JEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771338779; x=1771943579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gebaghse5OySHou5H1mHGqUHtgCt8QeUT/JMZWe+7bg=;
        b=hHOyLWFJRPF1Si+cDPm4bnzibFkMswvz9FCDfbtys/76t0fjQq9VidYMJVQIAJKQHt
         4AQ0FwreiSWYNf6PDi8eNwvaU9r2tBcB5e9F0y7b+0dICRjgUbvt3PAtrRPRd3+H3JpF
         4BlEsCEeNPDLWLk0FrZWouFbzVW0AWmuq3Oacwn1jg6edqNbZ0pIN3XwzYQmeOfZDBOQ
         Hb4bBrBztjiQponu1IXbF3cP2JJzpZdxR9wmuMMjgzRldiVjZC9qBriVOIRe4XJYSYOe
         CS5mOuLnWbT88VJuzeRgshHsALeRrAF2fNYH7jCN84D4i4rvrkJg5WkJRC440tlsUTwA
         SI4Q==
X-Gm-Message-State: AOJu0YwkLd6FGCHmN0ZS9HQUw8gWOMhtL1l65pY3iFDmPa0IiWN+S86+
	Jci49zF2ynz6/4kDtEyKoBGPN4rk62NfBlE2eMDGrZCtsEUZYOvl5Kr7Z3PJbPSs
X-Gm-Gg: AZuq6aJp78waMtdWC74rfOEEiW+UyDYX9j4A33mugy/tEowSzD9iDzjOFZvTQZqCgRl
	3w8QObwxCdQDm9ZfTKyiokbC9+y/pdd0DEmp/aREsAGWl1OWqOHiLOiVkreevBL8RL7HsYpiQEl
	QV6M19Kihkp/O9RydFUV6rKJ+ib6HjaH4sXCHeetEVFaOF4yN8TU6SFBQ9u6sYNc3IEfK6qGKup
	aZG9qYJRWlDTSvbQRUt10+neuXLllIfD2msrnjr+5O8+9Bdy2ODnbf5cEWyVIfJGvM3IxMlDIln
	2UKFntNrgvQ17TjdgeYjZyG6Qk3BEKP5ryAkk9WDDaglBEmGi+yNolFPxm7xpsz0xosYYm/G2Of
	rTSFixvJVFIu/CNBuAgH9Dx2LHUHlXzkjPyDYYBdUmHOVOTjIpN0qTYx3LNa8VZD8pDha/Tv4X1
	KvVeCvWdDqRPaIvz022Y41XWhZ3FAMExVbp2j2OLb9y66XMLIYNRLyXYydUGnmH8rfau7IXTzZc
	R1jafmXjCrBzvQEp1qJQ2egUTfyED8=
X-Received: by 2002:a05:6a00:4f89:b0:824:9edb:46f with SMTP id d2e1a72fcca58-824c95c2a2fmr12746663b3a.45.1771338779401;
        Tue, 17 Feb 2026 06:32:59 -0800 (PST)
Received: from localhost.localdomain ([49.207.200.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b935c6sm14770821b3a.47.2026.02.17.06.32.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Feb 2026 06:32:59 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	sdf@fomichev.me,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Subject: [PATCH 1/2] xdp: propagate queue_index through xdp_frame
Date: Tue, 17 Feb 2026 20:02:41 +0530
Message-Id: <f8b3cada5542fb63172711d8e0efc983680972cb.1771338602.git.anandkumarshaw@users.noreply.github.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1771338602.git.anandkumarshaw@users.noreply.github.com>
References: <cover.1771338602.git.anandkumarshaw@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an XDP frame is redirected via cpumap or devmap, the original RX
queue index from xdp_rxq_info is lost during the xdp_buff to xdp_frame
conversion. This causes BPF programs running on the remote CPU to always
see rx_queue_index as 0, and SKBs built from xdp_frame to lack proper
RX queue metadata.

Add a queue_index field to struct xdp_frame and populate it from
xdp->rxq->queue_index in both the normal conversion path
(xdp_convert_buff_to_frame) and the zero-copy path
(xdp_convert_zc_to_xdp_frame).

Additionally, call skb_record_rx_queue() in __xdp_build_skb_from_frame()
to set the RX queue on SKBs built from xdp_frame, resolving a
documented gap in the function.

Signed-off-by: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
---
 include/net/xdp.h | 2 ++
 net/core/xdp.c    | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..4912e132ff84 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -303,6 +303,7 @@ struct xdp_frame {
 	struct net_device *dev_rx; /* used by cpumap */
 	u32 frame_sz;
 	u32 flags; /* supported values defined in xdp_buff_flags */
+	u32 queue_index;
 };
 
 static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
@@ -441,6 +442,7 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
 
 	/* rxq only valid until napi_schedule ends, convert to xdp_mem_type */
 	xdp_frame->mem_type = xdp->rxq->mem.type;
+	xdp_frame->queue_index = xdp->rxq->queue_index;
 
 	return xdp_frame;
 }
diff --git a/net/core/xdp.c b/net/core/xdp.c
index fee6d080ee85..2d6a3f2c9584 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -606,6 +606,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 	xdpf->metasize = metasize;
 	xdpf->frame_sz = PAGE_SIZE;
 	xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
+	xdpf->queue_index = xdp->rxq->queue_index;
 
 	xsk_buff_free(xdp);
 	return xdpf;
@@ -833,8 +834,8 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 	/* Optional SKB info, currently missing:
 	 * - HW checksum info		(skb->ip_summed)
 	 * - HW RX hash			(skb_set_hash)
-	 * - RX ring dev queue index	(skb_record_rx_queue)
 	 */
+	skb_record_rx_queue(skb, xdpf->queue_index);
 
 	if (xdpf->mem_type == MEM_TYPE_PAGE_POOL)
 		skb_mark_for_recycle(skb);
-- 
2.39.5 (Apple Git-154)

