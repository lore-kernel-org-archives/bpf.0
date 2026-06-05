Received: from smtp9.goneo.de (smtp9.goneo.de [85.220.189.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869EA4DB56C;
	Fri,  5 Jun 2026 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661697; cv=none; b=LS2anf4N0TLVs22GjqJSmIYRhpBZ3g1mKiIfpQbfdDjnP8VlH0/uXeXHNhAiIBKMGcFqChw9duRdKkly9+KZrzszyf63cZ/q7PClgX1vsBtfF/HBwQu60QNOoqaFYuypF+9rIX8HKfIbyNrUlB9L1tlPHUQe/j0u03xi+fIAuyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661697; c=relaxed/simple;
	bh=2no5ts4uR+BRFpbAeaMDuXoBtDm87qzy992Y6dadpc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIKqVOIZtHDT4OVRz2nw8bppk58HIck0mT8Jp/deWF497tBzLdrCvScfXn8HNVFS51ca4dLpSfGC/DN0gr8ZXsYb/nWnLDmFeKeWJDrtq1u3mLwmQL+xXcgbhQjwTKI1iE7fs9dyn9/kfFCzO9pqYsSUgzgsFJglKJFkY6k0ZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=ItmxyC1o; arc=none smtp.client-ip=85.220.189.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="ItmxyC1o"
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp9.goneo.de (Postfix) with ESMTPS id D44662403E9;
	Fri, 05 Jun 2026 14:14:47 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 3D946240511;
	Fri,  5 Jun 2026 14:14:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1780661686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1Ioe8uKiJIxbIqpXcCQ8i5GRjn3ORGyOB/YwWZ/fog=;
	b=ItmxyC1oPSLgLXvUw5IjRgR11LcQQJFnmDuEKng82XAxd+7v65sBc+HvcPkfMUcxxPPzA7
	LaHmMQJDXobOCNJMIErw3wECu/hY1jxhJRpNS4pwZ40wMrkegjDtvzfbycDxXt9of884IR
	o3XGJ9xS/rzezdTAVR46+DkiqASgl2A7wUzK1Wz7ACdmRchYI4WfxUgixbN9U7nuQnIDaJ
	lJT7qG2wN9exT2We5MS+H5/bOrS3rQCMag4bCAVUJjROdeN5rST51U1XmUfR26z/Zflmsk
	xIZa20FLpqD3ApszF9dpPeL6eSq4byVXKqp70dXpCmzWxGzR+OCeSaI0rxyqyQ==
Received: from Til-Notebook.meshlab (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 1B72324035A;
	Fri,  5 Jun 2026 14:14:44 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	mcroce@redhat.com,
	sven.auhagen@voleatech.de,
	lorenzo@kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net v3 2/4] net: mvpp2: limit XDP frame size to the RX buffer
Date: Fri,  5 Jun 2026 14:13:30 +0200
Message-ID: <20260605121332.147397-3-mail@tk154.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605121332.147397-1-mail@tk154.de>
References: <20260602164635.62517-1-mail@tk154.de>
 <20260605121332.147397-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: cdc45f
X-Rspamd-UID: 6158c8

mvpp2 has short and long BM pools, and short pool buffers can be smaller
than PAGE_SIZE. The XDP path nevertheless initializes every xdp_buff with
PAGE_SIZE as frame size.

XDP helpers use frame_sz to validate tail growth and to derive the hard
end of the data area. Advertising PAGE_SIZE for short buffers can let
bpf_xdp_adjust_tail() grow a packet past the real allocation, corrupting
memory or later tripping skb tailroom checks.

Initialize the XDP buffer with bm_pool->frag_size so XDP tailroom matches
the actual buffer backing the packet.

Fixes: 07dd0a7aae7f ("mvpp2: add basic XDP support")
Signed-off-by: Til Kaiser <mail@tk154.de>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 92a701f4fe3f..3372ed27cc8d 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3979,7 +3979,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			else
 				xdp_rxq = &rxq->xdp_rxq_long;
 
-			xdp_init_buff(&xdp, PAGE_SIZE, xdp_rxq);
+			xdp_init_buff(&xdp, bm_pool->frag_size, xdp_rxq);
 			xdp_prepare_buff(&xdp, data,
 					 MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM,
 					 rx_bytes, true);
-- 
2.54.0

