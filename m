Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D770416865
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758603; cv=none; b=PnawEY+XuEpjFSkj1ncO2FogEoYhan7LMUj8oA70F7pQbGx/73jfjT1/vny6RXtgI+9s0bYKv5grEHLzxkG1ua+dHDP1k8THNJBDds1rDPjd93mp/PGNA5yk3UNSVTzNxqveP+dmpvRma8dmner2LSh4y0MHO6/bJtwdLLpyEM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758603; c=relaxed/simple;
	bh=KRo8BqXZbY7QVPrkWY+7m9Y76muhXbcl9oTt8JcSLZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X0k6d+1GbbONCxX0pa02U6AEaPEHouKkIOpsFK3QPz2qlC7Pm5tVRVx2RvxQyziUrrDsMu7mZY4m1x9xr6it91GfkQ3YKNVnphlm4Ayo/c3h7zPfAle1JE9F37O3+qsarqi4VT3mLTAF8GkLXGA6C8P982Hy6OfuNYxBcKYJPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FxUUYCk7; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxUUYCk7"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84c4cd31b51so4363714b3a.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 15:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784758601; x=1785363401; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lP2vHby1eDwBtKihRSSnShKlcm4qY1KhKGcFEWBrgR0=;
        b=FxUUYCk7PJ4tv9OUUHr8CwGnxSmeMWLiCXV1HBhrylZd97YRXkKXSD3iZojcjV6GOf
         3DIeMGaObnO39V0Tbf7WB7nq4j8Pyhbs7ptgQw9snHvCoBsYroboifqUtTpYNzeTK1h3
         NOxXYLv2bHTMWU+KejMlbPjBOdndOwH9I4GT4GgT3utJMqloQS0nQofUItZKkMs1sran
         CA8ROliA5/TzesWLIwYIaJ89WAAjrloVBLUN8v2KKp8CJK8Y5biFwAe5DO5BfefEwA5O
         KhJ2o/nTNKh1/29k72f+dqU00KFbW/BIQQTBVKDpHjt1ACljMoVAeRQoeVsSAOs6oRpN
         4T2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784758601; x=1785363401;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lP2vHby1eDwBtKihRSSnShKlcm4qY1KhKGcFEWBrgR0=;
        b=PciOQcZuPKBHaoJM6xyXG9f3eyMSJWLbZe9oMkLz9XFm5oCyeQv/74u4aoY2wSjbEz
         Yp2xO45PLMHU9O03OQOOY9oV4T3FXkxWP8iD2If5q1dsN2gqF11kUu1Ilu9y5P+ML1gv
         sv+NQeQ1GCmgDYTc4ObsbdVTVMlo0QAewPNud3BKeuJ4sg2y79cU8tNDxfTd0NhuAXlr
         +OwP62yEZP7JYWair41PaXPmNPxTaJzk9dhZCKk2O/L+wCjg7QCU2bttQxqVN/icKOkl
         2hQxjWPCHO754Jtf2NvGEmEoZb92HDQBbH5XgMCo8mW1U+Hwo6uGEZIk5Rn8rcMPHivN
         2ZYg==
X-Forwarded-Encrypted: i=1; AHgh+Rrg+AT1TjHr5eD3zIJ6/D+axX1o7LKw1cXXrF17FoWcV2VjLewsc3qcW0LoDdtz5Y9VJvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYHxT/8UBfzPJot21qH/0qDYd6tnKEQ9kBU3aCnqNgennOPjFQ
	nwLhicFPmF/z5jl3/Bfg1xy1tw697Lflp4cPwG8qyvlM2N2VeHWPxWIU/umxmaFD0fCZUd7vAyQ
	ZWRDqPtXDXknnqQ==
X-Received: from pfbcb7.prod.google.com ([2002:a05:6a00:4307:b0:84b:9a71:ba78])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:8889:0:b0:845:dcc8:9da with SMTP id d2e1a72fcca58-84e2e92aa9cmr122192b3a.22.1784758601149;
 Wed, 22 Jul 2026 15:16:41 -0700 (PDT)
Date: Wed, 22 Jul 2026 15:16:33 -0700
In-Reply-To: <20260722221634.186886-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722221634.186886-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722221634.186886-2-joshwash@google.com>
Subject: [PATCH net-next v3 1/2] gve: use xdp_build_skb methods for XDP_PASS case
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, 
	Tim Hostetler <thostet@google.com>, Ankit Garg <nktgrg@google.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Newer common methods have been introduced to construct SKBs in the
event of XDP_PASS because many drivers replicated very similar
functionality. Update GVE to use these common methods for copy mode and
zero-copy mode.

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
v3:
  - Newly introduced. Ensures that XDP metadata is passed onto SKB in
    XDP_PASS case.
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 02cba280d81a..907a0c15bf30 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -736,8 +736,7 @@ static int gve_rx_xsk_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	}
 
 	/* Copy the data to skb */
-	rx->ctx.skb_head = gve_rx_copy_data(priv->dev, napi,
-					    xdp->data, buf_len);
+	rx->ctx.skb_head = xdp_build_skb_from_zc(xdp);
 	if (unlikely(!rx->ctx.skb_head)) {
 		xsk_buff_free(xdp);
 		gve_free_buf_state(rx, buf_state);
@@ -745,8 +744,6 @@ static int gve_rx_xsk_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	}
 	rx->ctx.skb_tail = rx->ctx.skb_head;
 
-	/* Free XSK buffer and Buffer state */
-	xsk_buff_free(xdp);
 	gve_free_buf_state(rx, buf_state);
 
 	/* Update Stats */
@@ -899,9 +896,17 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 			return 0;
 		}
 
+		rx->ctx.skb_head = xdp_build_skb_from_buff(&gve_xdp.xdp);
+		if (unlikely(!rx->ctx.skb_head))
+			goto error;
+		rx->ctx.skb_tail = rx->ctx.skb_head;
+
+		gve_reuse_buffer(rx, buf_state);
+
 		u64_stats_update_begin(&rx->statss);
 		rx->xdp_actions[XDP_PASS]++;
 		u64_stats_update_end(&rx->statss);
+		return 0;
 	}
 
 	if (eop && buf_len <= priv->rx_copybreak &&
-- 
2.55.0.229.g6434b31f56-goog

