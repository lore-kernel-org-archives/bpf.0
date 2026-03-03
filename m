Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CAB3890FA
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567761; cv=none; b=duair1bkqIw8jazNLsUSLElXMkIJV8Beu8Vx5zcd0unW6V/DFchH5jZzhkz1WmVGAwm/WgdWMeUv4sKnhD9QOOfXHIjqR4ol6cu14qPImWy4Dc7om+cP7ClH2b0adI+I4epn4QoL++jSSX8QWDDHzjtFBsFsmVQni9N4/Pp+o9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567761; c=relaxed/simple;
	bh=lAeoYgBQM1LTZWAFlAqqO4VQEX8bViSlLynqua3uy0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pug0MdMxgj/ja23zFX0b3nAe0WNrOMiMQ+Z9l76DZsry+qanC5dqo/MIS+V7WN5CmVB2QjNKpeQXxSE559QLSyiE/oU0PTbLNq9byjkkKgsFO2jtthRPYIZ26QF6n6d5Sfj2IQ4u7rkIo1sbLJneYi3NW/gARvHA4hkjn1URBg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4Ox95DJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4Ox95DJ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae48a21d12so20007375ad.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 11:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772567757; x=1773172557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8wBZYOjVx1PhHvmvhSvpE8PvzwVvcrdiZixhCtvqCs=;
        b=C4Ox95DJEU4xS4hut7ebGN7EhQuj5gI5uyqv8ZG3MykMA0+D6qSI00Y2sUqQ4/MFzp
         1es9iKGyLyN+8+ZsqqNpWeEl2lPaEw5+dfYzNb5xKxv/cOgohvnNk1jgUUaejXjGSzvS
         R7CdhQm171QVnmftcC0Spv/JIuDdRuw6KeZkwCXHbzLivJwc5HwxGvx0B7gtWrF3YWuH
         tJ+9+3qZkCV47mD1EMoHkABcQMvsPEFxHpRbCkA5AChg7yHNOCAMPkncQfNn7nYlAD5i
         o5O13KWsSW0kOmkPs19p+Ge9a5PWpXeCtCulzwWOVgtagzuRNxQRUBlNh7sR0oP1SwMO
         AllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567757; x=1773172557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8wBZYOjVx1PhHvmvhSvpE8PvzwVvcrdiZixhCtvqCs=;
        b=Koxd50sCeSaY/iPzLIQZUhTJnJCxmxGVoxJWg9KkghFBRP8th/nYt+4yyUQWYVooym
         Y46+j+j4Uog23QSZ1s8zYzRfyjD/eX4pumfkQ8ilI9aDwXNC32VIXUtFzUFp59sRkbcg
         UvOXbzZQOpqXiJWED/J1SsgtCiBbYD8Pjs9IF7L3kQ6LvIXiQoFVQxaP6GEjbqwGEE0e
         6k0ipOIuoDHgHwMf/s132+5J3ixFQT4Zaldj2td+dNVfJcom/HP2l1px88DZMKj5Mmww
         qijBh00tBaY3Z/XHWCle7jE2IvddWGOaG40zO3586TJNDTwf+0aUFIQksTRoupQ/hkAS
         YLaA==
X-Forwarded-Encrypted: i=1; AJvYcCWjxxLYYm5/ydsnoeqU8Iut6RikSZuqDaFQXj/Dg9w9SjjlWBcSwOAVxyeI4xAiQczzf2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh6cLddXb+PfwinIDd58lYFFzbdyH29lwcbmNfaYEwxJlknfko
	YfZ5WPQfzZ95x8I/IDL9jpMYcMoXMMui3l+O7jnHePGAP9Mo/Es1XD6z2iJpo6BaJFafhQDctf5
	YNMrPXj4NRJ1GRQ==
X-Received: from plrd24.prod.google.com ([2002:a17:902:aa98:b0:2ae:4655:2b3b])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2ac7:b0:2ae:3afc:eb38 with SMTP id d9443c01a7336-2ae3afcefb0mr135265005ad.41.1772567757193;
 Tue, 03 Mar 2026 11:55:57 -0800 (PST)
Date: Tue,  3 Mar 2026 11:55:47 -0800
In-Reply-To: <20260303195549.2679070-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303195549.2679070-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303195549.2679070-3-joshwash@google.com>
Subject: [PATCH net-next 2/4] gve: fix SW coalescing when hw-GRO is used
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

Leaving gso_segs unpopulated on hardware GRO packet prevents further
coalescing by software stack because the kernel's GRO logic marks the
SKB for flush because the expected length of all segments doesn't match
actual payload length.

Setting gso_segs correctly results in significantly more segments being
coalesced as measured by the result of dev_gro_receive().

gso_segs are derived from payload length. When header-split is enabled,
payload is in the non-linear portion of skb. And when header-split is
disabled, we have to parse the headers to determine payload length.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 63a96106..5ba893e5 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -945,11 +945,16 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
 			       struct gve_ptype ptype)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	int rsc_segments, rsc_seg_len, hdr_len;
 
-	/* Only TCP is supported right now. */
+	/* HW-GRO only coalesces TCP. */
 	if (ptype.l4_type != GVE_L4_TYPE_TCP)
 		return -EINVAL;
 
+	rsc_seg_len = le16_to_cpu(desc->rsc_seg_len);
+	if (!rsc_seg_len)
+		return 0;
+
 	switch (ptype.l3_type) {
 	case GVE_L3_TYPE_IPV4:
 		shinfo->gso_type = SKB_GSO_TCPV4;
@@ -961,7 +966,21 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
 		return -EINVAL;
 	}
 
-	shinfo->gso_size = le16_to_cpu(desc->rsc_seg_len);
+	if (skb_headlen(skb)) {
+		/* With header-split, payload is in the non-linear part */
+		rsc_segments = DIV_ROUND_UP(skb->data_len, rsc_seg_len);
+	} else {
+		/* HW-GRO packets are guaranteed to have complete TCP/IP
+		 * headers in frag[0] when header-split is not enabled.
+		 */
+		hdr_len = eth_get_headlen(skb->dev,
+					  skb_frag_address(&shinfo->frags[0]),
+					  skb_frag_size(&shinfo->frags[0]));
+		rsc_segments = DIV_ROUND_UP(skb->len - hdr_len, rsc_seg_len);
+	}
+	shinfo->gso_size = rsc_seg_len;
+	shinfo->gso_segs = rsc_segments;
+
 	return 0;
 }
 
-- 
2.53.0.473.g4a7958ca14-goog

