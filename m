Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE44921D5AF
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237794; cv=none; b=jpkwjGPzY35dN37h50u5jyxBc78fJCcJvsENMPjJ0WmbkKri8jbudhMiP8/Z8u5JuuaqxZxE4a2R/l0JDQRFq+Ymjpq0Us+4N2N8Kt+Eyq8hh3QTtgQZwes4Et8xYgpN8bPBpJ3WAT3OsAuzstcXyx/2Vw+emlJjOZcOMpp+8m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237794; c=relaxed/simple;
	bh=a5UshyE/bkF5sH8kPnnlkA8aFTOAxuPpX+MUydmVDnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GAZQRIJH0axWFGtrnNn0FvwVpweZI/Ncqa7rcanRCSvYPtWpGj55sbtgyNEW/Ch0uy45qYfSy4bckPeHqTiMtT/Daqxrh1k9Bm9y4cM2+lq1G+lpbryGvwQq8ON68RDNGlx0bu8LjECjw6FoaK8VwodFsW/LhjT9Avc48U/ccB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgB3HWgS; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgB3HWgS"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-369002b26f4so2207593a91.3
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 17:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779237792; x=1779842592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZXYU5Yo6j5J7XOLRXMLLYjxyG0GpFZ6EWg+P+KiBs8=;
        b=VgB3HWgSyA8+CY0ZVHQc6f1TLem45BjHXgeHpuSqxP5otJyt/WW0MczKW5oYotPwvT
         EcUV7ArV3fM9fXLJnT0TeSlVcLYLbZjPxUJb+37uUjIMtpo10vc8Q7HLhyStZNzhLjEl
         KKFlBuDCj4wQqMXgR9Gj6od4DB9pEuf1tKvhwZnZePHN6iiP9HeqvLlMzW57/UadQlYu
         KC9MLDjF685XuK9jrkrs41OQseP/j0o098vuvNhxRL9Hyz+6DCmXyDMZMx8L6/Yycbga
         WAxnFwacgCoAX/4oul+StqwpZN48y/pgbOTWar3b3EUO5k6ZzGUfGP3+514yf0RwS4Ky
         KJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779237792; x=1779842592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZXYU5Yo6j5J7XOLRXMLLYjxyG0GpFZ6EWg+P+KiBs8=;
        b=LqG6ztM+AtBkxXqLbs170Z29Q+E//reCzahM9FDt6J5GLZze2+yVzMZXETwb5B4WOq
         26ChLDnBXj1tE9swnIMesXQxSGIpOpB+q4HBccI6u+Df6YlcI+9OmdwMV3GW8Fg4Vzi3
         LC2PloWSkZauWxlpHZxP0I4sYnbILQeD6n2xo38QFHdMfWJCXIwScTFDedSe6ffi6/iI
         fAqIjUrPuWUY3C19LNYfHBvUBo1Ap8PHb3AG8YHJ1Oqz8ezAI9Gmvzl4DwjBVj1gP7Qa
         nsR8Cu+9bGOhPPZqzSrNSIqomw6I7EjGVyv+GppEp0ss/4/mk9iYGpCuaWfVCB5mEUW4
         GYfQ==
X-Gm-Message-State: AOJu0Yzhlnf53D4PiJu/cz997MfIPAYFZsKKzwVDkG47wWHPjx2FSkRO
	1qHHEY3p6n4P2GVUYB1ijhdiwU+s4muez0nRCvI0AiEFLzKskJEeyt+r
X-Gm-Gg: Acq92OH67M2iFfMFhIJAkD8gGPULuqGNIhfQlOlGyJl8yiTxbTWSlC7Wmz0Hy3WWfol
	k7N/ympPqVQLPce1BcBHhgSGraArpPfs155E1ZZi6+fvkXokrkRsQwfwGeKXJIMy7iMHAb/jc6b
	nhhQwyZDjsvP8TJOeNX8YruWJz/URAgVfwfI/bDFs0eUF+noXD9UVdap0UKkIrFi3SMdoLcBBkU
	N0v72n3ODZ2Zu33PeUz+uVy8SFEXS3ij3IY4k0TPmKv5zxLM/nBrNpUWXzhJ7IzhyMq/rzKPMwN
	lhihX1XgLRkxC1yGcWpZa6tWSyBadQzsN+kB+mfW+csmMhK1w8IiuKgi7C6LkczX+0Ni9/hcQwf
	51PldGDDF8/4kswbQCefQEV29C8w6tZeiKGddrugZzO2nChuiyHbeTGYr0BInfUUyunadI0Ahqy
	I8PC9I6/eCLLswZhCUzk5v9MDnpmCA9NQqwUg3OA2yBKfcKvOShUUX8EDUQ78EoWqXSwuMJPl7f
	OjB1KeNWskl938GVDJCHaugqjP04lVV1vGcKgSIXDgUVVaB+XlE
X-Received: by 2002:a17:90b:4c02:b0:35f:b5df:453 with SMTP id 98e67ed59e1d1-36951b8aab3mr20791888a91.22.1779237792105;
        Tue, 19 May 2026 17:43:12 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:f1df:d520:8103:19c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951059f4dsm14746277a91.0.2026.05.19.17.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:43:11 -0700 (PDT)
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
Subject: [PATCH net v4 2/5] xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
Date: Wed, 20 May 2026 08:42:41 +0800
Message-Id: <20260520004244.55663-3-kerneljasonxing@gmail.com>
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

This patch is inspired by the check[1] from sashiko. It says when
overflow happens, the address of cq to be published is invalid.
Actually the severer thing is the whole process of publishing the
address of cq in this particular case is not right: it should truely
publish the address and advance the cached_prod in cq as long as it
reads descriptors from txq.

The following is the full analysis.
xsk_drop_skb() is called in three places, which all discard a partially
built multi-buffer skb:
1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_FRAGS
2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
   the TX ring prevents the partial packet from completing
3) xsk_release(): socket close while xs->skb holds an incomplete packet

In all three cases, the TX descriptors for the already-processed frags
have been consumed from the TX ring (xskq_cons_release), and CQ slots
have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
the buffer addresses never appear in the completion queue, userspace
permanently loses track of these buffers.

Fix this by letting consume_skb() trigger the existing xsk_destruct_skb
destructor, which already submits buffer addresses to the CQ via
xsk_cq_submit_addr_locked().

Note that cancelling the descriptors back to the TX ring (via
xskq_cons_cancel_n) is not a appropriate option because an oversized
packet that always exceeds MAX_SKB_FRAGS would be retried indefinitely,
which is an obviously deadlock bug in the TX path.

Also move the desc->addr assignment in xsk_build_skb() above the
overflow check so that the current descriptor's address is recorded
before a potential -EOVERFLOW jump to free_err, consistent with the
zerocopy path in xsk_build_skb_zerocopy().

[1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f8c8a8c9dfba..0a6203c42576 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -793,8 +793,11 @@ static void xsk_consume_skb(struct sk_buff *skb)
 
 static void xsk_drop_skb(struct sk_buff *skb)
 {
-	xdp_sk(skb->sk)->tx->invalid_descs += xsk_get_num_desc(skb);
-	xsk_consume_skb(skb);
+	struct xdp_sock *xs = xdp_sk(skb->sk);
+
+	xs->tx->invalid_descs += xsk_get_num_desc(skb);
+	consume_skb(skb);
+	xs->skb = NULL;
 }
 
 static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
@@ -876,7 +879,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(-ENOMEM);
 
 		/* in case of -EOVERFLOW that could happen below,
-		 * xsk_consume_skb() will release this node as whole skb
+		 * xsk_drop_skb() will release this node as whole skb
 		 * would be dropped, which implies freeing all list elements
 		 */
 		xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
@@ -968,6 +971,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				goto free_err;
 			}
 
+			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
+
 			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
 				err = -EOVERFLOW;
 				goto free_err;
@@ -985,8 +990,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
-
-			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
 		}
 	}
 
-- 
2.43.7

