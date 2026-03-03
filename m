Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2159A38911E
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567763; cv=none; b=JpSJoHiI8rHu844ig2exfcitXgZv3I6Td9bipJEklLiwybgwQKPpEX2xhqiBOcD8jtPEps6kl8b+ZF6+WXrNRVRlpCPdrRP85oua6pkI/lF7/C/u78o86w1dA0p8+dCiYkux7V/VQtu9Gwa5YixEAUJWMMR8KrxTpIKU7U8xNN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567763; c=relaxed/simple;
	bh=Fz+xOWFU7AOGBur392VvmH8RfVHXuXIbgMX+VtQzmUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I+HFmr7cu9ODAwnx/GwPh8TWn66ULQKGTSqjrKop3+xp87Rum1yCP/tvf9hKT9wXywVR950q9anJFYSFtPpo1P/iH0xUXew9YKPlAW6D1p26OVLi1bPDhHoGozfg+1apYbjEMp30YxVXfOpHix8bgIe+8jOop1POK57Okjr55GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SBAl/Bz7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBAl/Bz7"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-824ae2cac9dso2237137b3a.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 11:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772567759; x=1773172559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dq/OV3i9BQc2Nxo8MqQVMxCoaBT7eVK8KXpu8kyi000=;
        b=SBAl/Bz7g8wUyIfoOWqBebb9/XtKX/DOKzT4m1N42I8caEKbRF4LXcTYEXO/nykKJb
         LOBi3UT2nBpp9aJl3PcbderSvVThUbl6Hru39LudvvZdfdx/mg0gs0Nf1q+xUuvkIUhk
         k1oGYK2N/hpTaoAtqgm1BtVMGEfkIq1W6vEwlxd+WvB68ZDRbRuDIy+Hy0ey1uuFYmPc
         JvX9VNTXxgRES+my+BVrUZeCM0yFVrak+MMQjmiQj6yh2f3GHYQqQp79EIkj/NZIpQ03
         Rfr5TOoZkLDTwwOWxK5WYaddrUzlnzdLPB1QFClEGujmNCE7aQGaCVNKAL0BudEYI23a
         zMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567759; x=1773172559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dq/OV3i9BQc2Nxo8MqQVMxCoaBT7eVK8KXpu8kyi000=;
        b=NS3nm8XsUNkhsuBZP9BlEcckslaAZZp6eOg9yyVl5Bh3mUZtnxT9hscnPKqb/XaN5p
         cmuc7RrLxVvMv/zBEUuPP3PVnq+uQO1ivCHyoh+Gi0OgLWTbTAehAWJDOAfM0QqQO0Oi
         cqW5VAYcZbps3oZOpTRGxYiZomNkDO+k78RpG0xjkCAiicLSTvZ0cq/HhoWymVL/DIY6
         HJq0BywpwYFA8EqR6Yjce76ysIx3FwTua0eHb4u0Kl6jmGm16qSKYEB9nmYfGDxl2yDp
         o47mUev79Ayp1rdrCFfzHL6ytcUGpSSmcqhmO5Pi13GUj9r0bA9HtOyBGVQ2W1BVcN9G
         /5iw==
X-Forwarded-Encrypted: i=1; AJvYcCX0jtriKn0I31ScqGHyUkgmW8C+ub+4lTaoTTSGyWKujlmwIkG9yC8a51NGTl2GB5uFxXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu781W690PWCLquEGJubKIoVrt9N794VGUMpEGrR5NEeFFY2DL
	Ah695J7KsbetUz9GpKVj4HmNqZFwV9D9xHLDBfC2dL/tygkI1KJC4R9FXtvWTjVzpovXdZhAYTL
	8rkQNFxjIGkHX/g==
X-Received: from pfjt7.prod.google.com ([2002:a05:6a00:21c7:b0:824:a3b4:6d0])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d95:b0:822:1dbc:e75d with SMTP id d2e1a72fcca58-8274d933c52mr13543880b3a.1.1772567758991;
 Tue, 03 Mar 2026 11:55:58 -0800 (PST)
Date: Tue,  3 Mar 2026 11:55:48 -0800
In-Reply-To: <20260303195549.2679070-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303195549.2679070-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303195549.2679070-4-joshwash@google.com>
Subject: [PATCH net-next 3/4] gve: pull network headers into skb linear part
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Jordan Rhee <jordanrhee@google.com>, Ankit Garg <nktgrg@google.com>, 
	John Fraker <jfraker@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Matt Olson <maolson@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Tim Hostetler <thostet@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

Currently, in DQO mode with hw-gro enabled, entire received packet is
placed into skb fragments when header-split is disabled. This leaves
the skb linear part empty, forcing the networking stack to do multiple
small memory copies to access eth, IP and TCP headers.

This patch adds a single memcpy to put all headers into linear portion
before packet reaches the SW GRO stack; thus eliminating multiple
smaller memcpy calls.

Additionally, the criteria for calling napi_gro_frags() was updated.
Since skb->head is now populated, we instead check if the SKB is the
cached NAPI scratchpad to ensure we continue using the zero-allocation
path.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 5ba893e5..ac44f50d 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -946,6 +946,8 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	int rsc_segments, rsc_seg_len, hdr_len;
+	skb_frag_t *frag;
+	void *va;
 
 	/* HW-GRO only coalesces TCP. */
 	if (ptype.l4_type != GVE_L4_TYPE_TCP)
@@ -973,10 +975,20 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
 		/* HW-GRO packets are guaranteed to have complete TCP/IP
 		 * headers in frag[0] when header-split is not enabled.
 		 */
-		hdr_len = eth_get_headlen(skb->dev,
-					  skb_frag_address(&shinfo->frags[0]),
-					  skb_frag_size(&shinfo->frags[0]));
+		frag = &skb_shinfo(skb)->frags[0];
+		va = skb_frag_address(frag);
+		hdr_len =
+			eth_get_headlen(skb->dev, va, skb_frag_size(frag));
 		rsc_segments = DIV_ROUND_UP(skb->len - hdr_len, rsc_seg_len);
+		skb_copy_to_linear_data(skb, va, hdr_len);
+		skb_frag_size_sub(frag, hdr_len);
+		/* Verify we didn't empty the fragment completely as that could
+		 * otherwise lead to page leaks.
+		 */
+		DEBUG_NET_WARN_ON_ONCE(!skb_frag_size(frag));
+		skb_frag_off_add(frag, hdr_len);
+		skb->data_len -= hdr_len;
+		skb->tail += hdr_len;
 	}
 	shinfo->gso_size = rsc_seg_len;
 	shinfo->gso_segs = rsc_segments;
@@ -1013,7 +1025,7 @@ static int gve_rx_complete_skb(struct gve_rx_ring *rx, struct napi_struct *napi,
 			return err;
 	}
 
-	if (skb_headlen(rx->ctx.skb_head) == 0)
+	if (rx->ctx.skb_head == napi->skb)
 		napi_gro_frags(napi);
 	else
 		napi_gro_receive(napi, rx->ctx.skb_head);
-- 
2.53.0.473.g4a7958ca14-goog

