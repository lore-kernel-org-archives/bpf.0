Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD8B2C08AD
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775929912; cv=none; b=Ivj4kwfdcX2Z0662vO2DOfbDtDkzSuJoAM5lzXXoh2ED6Xrc0ucpQkTuNySTJEBv662QOeOBhWNKApHaDqlpCinmDAhelzVYHzPVDqlz9ZG949RU22hhdepGrQpER86nceKNVI4Bl30FouchrkJ+5od+niqmOIuG7yVQ3VnVWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775929912; c=relaxed/simple;
	bh=hQyRgPipyQyaQJPCyX6Kz2rmAcO4Jcqde/NTAArq8Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfSq88Hn+s2p84rzFUZxdmHAvXW7RHOqaV0rOUYSRvvNscDARTe+UCx/FfXetvons7eEfDeuAY7ABNG5KOPOpL82DD/MQtq1roQzF7HeqHZaCZqDj2KoutXZqJZHN06pJELlIqaa7K6LvbK/TrjtG5zZECmIypQY1zNeByzICoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFNilsEW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFNilsEW"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66c24b42efbso4701495a12.2
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775929910; x=1776534710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7XzMVajH34DAZUEcGEEJc3FIbW91DMktp4naXjzHPjg=;
        b=kFNilsEWc5iW37K+e5inK4if4pf2xMtyTnqZCdOywBTmnp0/MQVb0VyF0NBj5pC2Qt
         DsjwmuOLT9X5wlr9b3D2Eiwj5uLtskZ00IQYpsp3knG3ERG2B9OvUqarzacObAx7vEwK
         gtQKpUOOrx9ci0ORK5agJiey83KfAoBpt0fWg+CLwqAz0XqDXnA8e8R4M1rCTnKqBo8I
         Z/TpVxe3Mi7x3Vpwc0iE9AVYcC+kED9ogBmiPudt0aXI3sKrshvMlf7Bjm0BnM6Niwxn
         quVlbqJ0UCOC8zT8AJs6uhYDy6YFhWOLU8IsSN5zMY4ae9TP0V43On2+lfxTVAW1G3BL
         Xc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775929910; x=1776534710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XzMVajH34DAZUEcGEEJc3FIbW91DMktp4naXjzHPjg=;
        b=qrBr0FlyhvD+NaGW09P2aYxXZVauCA6AMek/jsVpdzKjNU1Gqu7XDzUkqiRYcR0d3u
         XCkUy62jNVJMLLpO3ZzD3sDLu5hyWojeCAABZqKPW9V++0OCtvXdymnfeN+o3IdGSHjo
         LkV/XSCAT4ALDcSb6ms5qahIlC4dpsgBayzj+D5heqLlez6E9Mek9Qiqnnu4r6n2ueA/
         MHimctpBDBd/w8emzdI8elzFdfcdKMFfUkzgqlD7jWpnkmWcsCFHzWuBO1vycOxiKOvQ
         VhRgFkgTNYhO6A5x4zHr9zDxhsUnxdWSyJsKrYcf+R+u1dfGYCXbV1xCJMcTI+VO4hBH
         zSHg==
X-Gm-Message-State: AOJu0YyLDZQVvT3ikvTmyEfWUpRhoAWsLZF/va7gidyIAN1mmbPvh0e7
	yxRhl0vdjcV31Ac8NfRHA7Lh67lM7jBd3aWxWDtY94oDbVfgfv5P5gNKpsHQwgrE
X-Gm-Gg: AeBDiet3+sruPm5QVB8xEdbpNW1M3bpXy1j8j5sz9PLSkKz2dJr1eNjxsPmOBTFKHRS
	/1Su3SxBWdjWiIGOF7aH9DS+fNifsSG5W5HPFO9Lwu9JuYCrmEZCrqITOa0DnwbXL6oSegQHLvo
	gEJHD0gd3B9TqDkDf8WY27Gwic4DPovPTk92V74NkNdmRXfbbt0CJVGNkpn0r7jslobg331w6zu
	RKzSjQOBQY9CyiZCrwNzxfC5jxC/M4cWGsob6tEFDdm1y+3HMBTzRKsmBEl6SPI1aWAlYBUwZ0X
	c5/kWas7/YMWhXu0Daec+FoEVVRVA3LjmYtY0q81JwJfcbgy8cFQ0e3KyC1TNsfYGQzjZDcCfU0
	euUAVH/0Ty9IjR7aAZlxxopSQtNScpw9XVTba4UpuK2yLEKNR/qo7jmzB15CLPaG4NrWXmccoXr
	P4sCXaDtFPQzG+Nf3yH1zgpVMAZddz9uWN7oXjPgwg9GulKet0CSAZxDM2
X-Received: by 2002:a05:6402:a54d:20b0:670:8d90:e861 with SMTP id 4fb4d7f45d1cf-6708d90f131mr2408155a12.6.1775929909414;
        Sat, 11 Apr 2026 10:51:49 -0700 (PDT)
Received: from localhost.localdomain ([2a00:f41:1c39:2cef:2a0c:50ff:fe2f:36f4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67070816a8esm1486622a12.25.2026.04.11.10.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 10:51:48 -0700 (PDT)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: bpf@vger.kernel.org
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] bpf: cpumap: report queue_index to xdp_rxq_info
Date: Sat, 11 Apr 2026 19:51:23 +0200
Message-ID: <20260411175134.771552-1-azpijr@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a packet is redirected to a CPU map entry,
cpu_map_bpf_prog_run_xdp() reconstructs a minimal xdp_rxq_info from
xdp_frame fields (dev_rx and mem_type) before re-running the BPF program
on the target CPU. However, queue_index was never preserved across the
CPU boundary, so BPF programs running in cpumap context always observe
ctx->rx_queue_index == 0, regardless of which hardware queue originally
received the packet.

Fix this by storing the originating queue_index in struct xdp_frame,
following the same pattern already established for dev_rx and mem_type.
The field is populated from rxq->queue_index in
xdp_convert_buff_to_frame() during NAPI context, when the rxq_info is
still valid, and restored into the reconstructed rxq_info in
cpu_map_bpf_prog_run_xdp().

Also use xdpf->queue_index in __xdp_build_skb_from_frame() to call
skb_record_rx_queue(), which was previously listed as missing
information in that function's comment.

Also propagate queue_index in dpaa_a050385_wa_xdpf(), which manually
constructs a new xdp_frame from an uninitialized page. Without this,
queue_index would contain stale data from the page allocator.

Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
Note: this patch was only compiled, not tested.

 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 1 +
 include/net/xdp.h                              | 4 +++-
 kernel/bpf/cpumap.c                            | 2 +-
 net/core/xdp.c                                 | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 3edc8d142dd5..00e36b0ac74d 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2281,6 +2281,7 @@ static int dpaa_a050385_wa_xdpf(struct dpaa_priv *priv,
 	new_xdpf->headroom = priv->tx_headroom;
 	new_xdpf->frame_sz = DPAA_BP_RAW_SIZE;
 	new_xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
+	new_xdpf->queue_index = xdpf->queue_index;

 	/* Release the initial buffer */
 	xdp_return_frame_rx_napi(xdpf);
diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..6db10e6a8864 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -297,10 +297,11 @@ struct xdp_frame {
 	u32 headroom;
 	u32 metasize; /* uses lower 8-bits */
 	/* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
-	 * while mem_type is valid on remote CPU.
+	 * while mem_type and queue_index are valid on remote CPU.
 	 */
 	enum xdp_mem_type mem_type:32;
 	struct net_device *dev_rx; /* used by cpumap */
+	u32 queue_index; /* used by cpumap */
 	u32 frame_sz;
 	u32 flags; /* supported values defined in xdp_buff_flags */
 };
@@ -441,6 +442,7 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)

 	/* rxq only valid until napi_schedule ends, convert to xdp_mem_type */
 	xdp_frame->mem_type = xdp->rxq->mem.type;
+	xdp_frame->queue_index = xdp->rxq->queue_index;

 	return xdp_frame;
 }
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 5e59ab896f05..448da572de9a 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,

 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
+		rxq.queue_index = xdpf->queue_index;

 		xdp_convert_frame_to_buff(xdpf, &xdp);

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..326e3057ed7f 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -829,11 +829,11 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,

 	/* Essential SKB info: protocol and skb->dev */
 	skb->protocol = eth_type_trans(skb, dev);
+	skb_record_rx_queue(skb, xdpf->queue_index);

 	/* Optional SKB info, currently missing:
 	 * - HW checksum info		(skb->ip_summed)
 	 * - HW RX hash			(skb_set_hash)
-	 * - RX ring dev queue index	(skb_record_rx_queue)
 	 */

 	if (xdpf->mem_type == MEM_TYPE_PAGE_POOL)
--
2.53.0

