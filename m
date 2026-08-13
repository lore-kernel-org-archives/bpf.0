Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0143D4E0
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658014; cv=none; b=q1MCTE3i4+cq2fqDwoTOs/n2UP5mcDMK7MdbKzpS/9WLI5aNhRt+Q8EaYzH7sgk11zQ2CVkE6nNBpYJUNixk++T0KQtoQ29geJ3y2FUqWjQlI7BfcEAb7f2rhjPb+AAfdKtIzkx7EJaJGtsevRmvEnkS3SB6Fg5XNlXN9+a0HsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658014; c=relaxed/simple;
	bh=fYLwZrvNlQxGwlPI0UQmca6Rp4m8wQ6Bkf8LJPqH324=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FeY6jNn8cASpX1I7nEsi6DZ/EvJzMHs82WFa4X/QSBNtZa5mFjhB8pWMu9QYf0A7vNTHJ7cRAWGnXxWPxYIAYQN0gEZAc4gYsLYqPEDmp8Y9cznPtU9x96i2/FU2UXPTb/aJ09jYt6Miy0zgvKITYoi2VE251qD0nXepOvy9zGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcK4nnLA; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcK4nnLA"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-669944f60b3so505968d50.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786658012; x=1787262812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cPTXEYegZPPH2jkQqlfi+zU8F5mdAL4ScUHPzIFB1i4=;
        b=bcK4nnLAToE/MFDRAU3Es48wA9EbUq8MoE31OpsRD6WD4haSk6YZNJ04e4BvjJ6guB
         A+IxM8uHAO9GjGBCyL+b44lIHiNLGzk42teqJnD1LO9xGg811yX3zfIKBFjRBn2nUZWP
         OgMdSJcSYarFZOCjM8RUtTUjmZvrPlWqbN/zxUij7TUudCXYvZCTL8jCxRBb2sKwnvsI
         bvz61FJUhJa1cttS3gwQ84a1c+BWJf+5xV8CO0EnbHGqVeBGwxQguh2PbvHsgzL181W6
         5dPAkzpkAiH07W/pXyLJxdxuU+Lqq2fBbelsuIiv6vkavL9uSgS1A12MoeIvylOaXnD6
         5XSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786658012; x=1787262812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPTXEYegZPPH2jkQqlfi+zU8F5mdAL4ScUHPzIFB1i4=;
        b=j7yz30J3J53IndX1juQp/mkLFq9rEbLDNcjOpZO6B4MOVV9LLyLp4iDky/syGkD++O
         7RTs4eRMm+50zIQtLm69d4Bpzwm/NVB0NuFxCCqa+0krheY88j5b/IIHYvOdKiJb0B6r
         GPQGLqEBGVWcCqSVPFfToFqWcy9juTUJ30G6gO+gL5dWE5KRcYT1IMwOI7aIMoB+faJC
         6CxgI9JKYmps6KItQ2vPDn/DepfFl33r9vE00Y3ZbpIWeMyS1l9zb5pYEsclSrIhd6gS
         kXFZgkyaPGLvQGOA49cfmR4M5bjMKBnimg8F4ffbXIk0wNk0Lk5XLzXACJzrl84vLjRZ
         doaQ==
X-Forwarded-Encrypted: i=1; AHgh+RpRm2eUKxIP0I/kx9n9gA04EPoQdpoZSzzB1rNXcfUkooMm/au8DJKrC0NZiW97RBtkeRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQbpVAgC9o5ELRBJ5ItXXfbxQ7oW6jJNCeHZVAhi6KlKztQMl6
	3AlOsIgdVFieHfOgbUN2rzjUOMr6ugMCbbtWY/pl+iRZWiL8phxiMRq2
X-Gm-Gg: AR+sD13wNFcxmyULM0UaWx8a719jgNuTVIDt4EbInkKnzbn4h50/j/rm68btL4sOFhC
	JzcfeMxcIlK5TgImxwq+XyBUU930NSp9TkxzIrs2hsArIwe9FW6xSjXgfDm4DJCXoHQyENXlD38
	jQ2ei0MPtmmrORJHxM0T16bGtuWuC0y61tnKNxrB9J3EvytczFKVFhdb+GBL/m4/+JmA24ViA7I
	s5Toxvk9I5GKNcAcfBHSS0hVsfq0zXLPKrsDBDXgjvZuBWw/wAcQPbD8dTMdhI04/90eMoxj8pb
	maN5nAmSeY5JvqnFAmGmBOKk86XWbjo2Au+r8JFakKUtpgHJNnh1Q/B/TTdPZWDVpsdCMasUD8+
	AAGIZrDtqBuOIYd2QmCL81FFhiqDUAnFLXLjxFwyJ2ASj6a95Ee1cS7l6a+Tqy+wD4ct+VpHh85
	e4khYoZ/qc3Bz/A45ZPfDRALvXeDXTrF62qimFNyTMjjvtKxZbWIc90YOZY74XzdBvqeAM
X-Received: by 2002:a05:690e:1c08:b0:664:dbd0:23b7 with SMTP id 956f58d0204a3-66c72b1cdedmr612953d50.9.1786658011698;
        Thu, 13 Aug 2026 14:53:31 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c573c46d3sm1458852d50.10.2026.08.13.14.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 14:53:31 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: magnus.karlsson@intel.com,
	kerneljasonxing@gmail.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v4] xsk: fix NULL pointer dereference in __xsk_rcv()
Date: Thu, 13 Aug 2026 17:53:28 -0400
Message-ID: <20260813215328.99311-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the __xsk_rcv() multi-buffer path, xsk_buff_alloc() is called in a
loop without checking its return value. xsk_buff_can_alloc() only
counts fill queue entries without validating their addresses, so it
can succeed while xsk_buff_alloc() rejects all remaining entries and
returns NULL.

  Oops: general protection fault, probably for non-canonical address
   0xdffffc0000000000
  KASAN: null-ptr-deref in range
   [0x0000000000000000-0x0000000000000007]
  RIP: 0010:__xsk_rcv+0x426/0xc20 (net/xdp/xsk.c:350)
  Call Trace:
   xsk_generic_rcv+0x26d/0x5f0
   xdp_do_generic_redirect+0x3c5/0xcf0
   do_xdp_generic+0x92f/0xe70
   __netif_receive_skb_core.constprop.0+0xf7e/0x2b30

Fix this with a two-stage transaction. First allocate and stage all
buffers required for the packet, recycling all staged buffers with
xsk_buff_free() if any allocation fails. Only after this stage
succeeds, copy the data, reserve the RX descriptors, and release the
buffers in an error-free loop.

Fixes: 804627751b42 ("xsk: add support for AF_XDP multi-buffer on Rx path")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 net/xdp/xsk.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7855ee09c4b6..33475b180ea6 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -298,9 +298,11 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	u32 frame_size = __xsk_pool_get_rx_frame_size(xs->pool);
 	void *copy_from = xsk_copy_xdp_start(xdp), *copy_to;
 	u32 from_len, meta_len, rem, num_desc;
-	struct xdp_buff_xsk *xskb;
+	struct xdp_buff_xsk *xskb, *tmp;
 	struct xdp_buff *xsk_xdp;
+	LIST_HEAD(xsk_buffs);
 	skb_frag_t *frag;
+	u32 i;
 
 	from_len = xdp->data_end - copy_from;
 	meta_len = xdp->data - copy_from;
@@ -343,23 +345,45 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		frag =  &sinfo->frags[0];
 	}
 
+	for (i = 0; i < num_desc; i++) {
+		xsk_xdp = xsk_buff_alloc(xs->pool);
+		if (!xsk_xdp)
+			goto err_alloc;
+
+		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
+		if (unlikely(!list_empty(&xskb->list_node)))
+			goto err_alloc;
+
+		list_add_tail(&xskb->list_node, &xsk_buffs);
+	}
+
 	do {
 		u32 to_len = frame_size + meta_len;
 		u32 copied;
 
-		xsk_xdp = xsk_buff_alloc(xs->pool);
+		xskb = list_first_entry(&xsk_buffs, struct xdp_buff_xsk,
+					list_node);
+		list_del_init(&xskb->list_node);
+		xsk_xdp = &xskb->xdp;
 		copy_to = xsk_xdp->data - meta_len;
 
 		copied = xsk_copy_xdp(copy_to, &copy_from, to_len, &from_len, &frag, rem);
 		rem -= copied;
 
-		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
 		__xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
 				  rem ? XDP_PKT_CONTD : 0);
 		meta_len = 0;
 	} while (rem);
 
 	return 0;
+
+err_alloc:
+	list_for_each_entry_safe(xskb, tmp, &xsk_buffs, list_node) {
+		list_del_init(&xskb->list_node);
+		xsk_buff_free(&xskb->xdp);
+	}
+	xs->rx_dropped++;
+	return -ENOMEM;
 }
 
 static bool xsk_tx_writeable(struct xdp_sock *xs)
-- 
2.52.0

