Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C384338BF75
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405498; cv=none; b=dmDggOaVLYmw/sloaRKZ6sSQEuAEjrOkw+5DiK0KMiHRKy/k3+IjTXEfs0ZbxaL1W4t/nKXFsSCYMdRS2ZElojsWZEYgTJTsGaFhGFjA7gepd2llqRXDnQub7XR07pSvmAPBGmzCqzwGrrcCr8JYrv183WkKALzzon8+gOy+sA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405498; c=relaxed/simple;
	bh=6tMUE+TlTPj1V8R6KjBLE7d34lJZH6rAFsftHa30yc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sHsNApgNevc7V45iUswVFofVjL7k7h6BirbhwXCLS0cuEK4bHMrUPqEfScGwgWo15PEKxq+u2nBQKeI+WxvmueNNsKuKepDEymR1GlVrQEEbv4HY/ceiZ6v3b0pOH6JbfgwZ6mEWyf43Jb7l4T/hNGn72133TRRygA41f65hAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DMLcBolt; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DMLcBolt"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ba6838e76f2so1232569266b.2
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 12:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1777405493; x=1778010293; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A4ZiG93hj0iUkFRM02kykYZWo1+YWZxugAjFUMM5ORE=;
        b=DMLcBoltifURRkc51CymmsFKFuDc1xzLF5npAoN8kFLZ2ixtqiu8Z7t3vGlyHPQE4B
         qBzlFUT2bLkgUVwzQfMviZK7WW6XPJjv+Oui0iBDsMSBpkhlPOdto8bsGxopcQyn/Gyw
         M/xIuyfjfFC8uV3ZV7LkrxXQdMWGRTRn39cD/oRsHliDe/qTXuTJ9eJX7SuBzsgs7oDE
         D8tyiu/iVEQ0X/srVnitXAix+LmtQiWvz9AH5FL3xgWg1xgo/MNZ3qnL1GYIVmecPN4K
         wtDYrA9Co2HIkX57spIrPqtbuz/iu0d8DBBBLoYU2lOlJTqct4EPEL52/A+al367tiVk
         Hd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777405493; x=1778010293;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4ZiG93hj0iUkFRM02kykYZWo1+YWZxugAjFUMM5ORE=;
        b=WLyi4QxAbVLVZz4E0sQsuzk1Qt8r7gU1EqwRMepO/ETsNeM3cx4WGCtvu1RB1/xvfv
         q2GB1Eu7b3yO1ewGvUTU8RZSZF6KWu+BHZapBFuR2iUztRQoY/fXSLr0ta+hHzHheZFV
         VE1EQqg5D6/ORbW1VIOFEw+pHQsyG53SBNDbtAgONOj1GkliStvgnGf050rtxl3zaVII
         9txP+S4guzkGbffCcEY8sQCSSOLyBYiiUYp3QIolllmo1TwCklVq/Vagu2M7uNN/8Xwp
         8LSu1Kx2fAht6vm0GIlfqsK37eWpOmyWZ5w59edV7ilOA+0NzY9ttfjqhDy6d1mf6rSu
         DsnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+86F5Dflh9GHghRQXSVKNBrmNoXH0oU9pjWzpZUKqoSr97MuQGb/F12Xg2wRy5GeLQVFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaNUFhyDS84AdIBj78vF2sZ5gHpJkIzaZgYygQSM8Kd9X2TRcE
	giVc8+/NpeFG5ewxahVwjeadbqRYb0Togqykrr1VlaE6M4VhtixlHyHHfwvCz+wvE8sKleaGI1p
	k2up/
X-Gm-Gg: AeBDiessT/YMVtPaPWJRGj408RqywYQbVagL+dDoNXY+Tp3JEyjac0XtOL6C8Mip4OW
	s/i0OJiXaQ4VygLmhZMp/8vkuhc1dv0+051IH6JHhnT81qZ8oeI1gkiNqLUrfjsuBL7gg+wKJBg
	GoxPP4kp7gLMxUS7THK6CaQkrTnAV66qy4Q2iJnbEeuUySbULPmwQxtHW6roy0ACDIBofbyRr6H
	t0+s+wzuyJfF2lKCPcJKChNLX+ZliSqX1olR40blc1OHBHTyNx6VGNF0js+e8tSnflbEhQSU+cH
	x9ZRJPGugsMz8C9brgNCykRu88Ic56/9IQvjY9vEuIjGHFvtRlVUbY09sBkzbA1nOqVr7t+nOyn
	aZA0R0MgeeuaDDm6mjX+GNOa8PpPXboTWexQYYQ6I7PNAUuQ5qHaXN+9D+P/HMT6YMBQXvwnWeP
	EiyWYnWDdvmUCT5I0HosnMpdD2Dama7H3nZxMU5xm1N3Vfvh9EnDwaXb9ImYK5AieAYxJ8wRj74
	HSIdebKBec=
X-Received: by 2002:a17:907:3892:b0:b9c:2c55:3384 with SMTP id a640c23a62f3a-bb93e64d116mr53898266b.31.1777405493522;
        Tue, 28 Apr 2026 12:44:53 -0700 (PDT)
Received: from cloudflare.com (79.184.127.151.ipv4.supernova.orange.pl. [79.184.127.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb808a3588bsm144691366b.14.2026.04.28.12.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 12:44:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 28 Apr 2026 21:44:37 +0200
Subject: [PATCH net] net: Clear skb metadata before LWT xmit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIACQO8WkC/x2NywqDQAwAf0VybmBdal+/UnqIMdZQuyvJ0griv
 3fpcWCY2cDFVBxuzQYmH3XNqUJ7aIAnSk9BHSpDDPEUjvGCX13QXz3OmWlGL9moSqPlNzobFZ7
 wSm0/sJxDRwI1tJiMuv4nd0hS4LHvP9pHQBp5AAAA
X-Change-ID: 20260428-wip-skb-local-storage-from-scratch-9a1bdce705ae
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.14.3

skb metadata is meant for passing information between XDP and TC.
LWT programs cannot access the __sk_buff->data_meta pseudo-pointer.

However, LWT_XMIT programs can call helpers that move packet data.
One such helper is bpf_skb_change_head(), which uses skb_data_move() to
move both packet data and metadata after skb_push(). skb_data_move()
expects metadata to sit immediately before skb->data. This is the layout
that commit 8989d328dfe7 ("net: Helper to move packet data and metadata
after skb_push/pull") preserves for TC(X) programs when skb_push() or
skb_pull() moves packet data.

The IP output path can run LWT xmit before neighbour output has built the
outgoing L2 header. For forwarded, or otherwise RX-originated, packets
skb->data points at the network header while skb_mac_header() can still
point at the old L2 header. If such an skb still carries XDP metadata,
skb_data_move() sees metadata ending at skb_mac_header(), not immediately
before skb->data, and warns.

Drop skb metadata before calling into LWT xmit from the IPv4 and IPv6
output paths. Metadata is not part of the LWT BPF interface, and keeping it
attached lets hidden RX metadata affect LWT skb mutation helpers.

Fixes: 8989d328dfe7 ("net: Helper to move packet data and metadata after skb_push/pull")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv4/ip_output.c  | 2 ++
 net/ipv6/ip6_output.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e4790cc7b5c2..3295e043310f 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -220,6 +220,8 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 			return -ENOMEM;
 	}
 
+	skb_metadata_clear(skb);
+
 	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
 		int res = lwtunnel_xmit(skb);
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7e92909ab5be..734818463e07 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -111,6 +111,8 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 		}
 	}
 
+	skb_metadata_clear(skb);
+
 	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
 		int res = lwtunnel_xmit(skb);
 



