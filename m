Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B0E346A11
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 03:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784950971; cv=none; b=DAgj8ycu6q3bFfa22DEvi060WDioqMJ/QphGZQFzmFoZR6JaQ379KnjbZMP/qqQRFzlK0YljGiMHZjpRuoe9e1eBzD5Nq0Dy0lzgPZxQU3xIFFnx5DSspoS3Uykp9/ZjHlwPKRpIlNNhRmEGzEMqZqbeEzpdSDIJ3/yKSR+VXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784950971; c=relaxed/simple;
	bh=qdCRc3nJ771x3VQVRjLBimIKuM3JuBDSq8fvXhd8+lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lLbiy1KEpaE8b8JspbwekP8fZ/NHlP33tXyyDgSjHayBmurpvKT96Ws7bDL2lJcD1yzrDu9yxS0pqPXvoWfhRB4bnYJBW3lQrYzJB2oAm5zy5gFPYEs4BXxoz1YyRf+yNeZqJ4WGZI/dmhpMfZQu5pc6pmgqWmXpZsjVaX2Drjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MggFcivc; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MggFcivc"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66825847b2cso827372d50.3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 20:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784950969; x=1785555769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1D+KDOADjt6pawjgxVvSFGUpDqaxbR+onKq6lqxxAIs=;
        b=MggFcivcs7UIMn2oCbsyBCnkC/3LvLjriyxTo/aSy3epy75U+FKbEN7YxJ4TpxymSm
         G0enEL6dOAB6VHX4Jytt+OnlKnACYWERlZArBNRlms3EpIxw/XryRl+/24xlxWPYLjmN
         Mn4wQ3c83hvNu2deF0PhQ0MCcYBe+Mp3+8ypJ4YY2GEqj4n6XjbGQhHITgwf9Ybbdq9J
         xotbWH1ctVpJdDYnpK1baCOC4jVf9fzyCdhp9BpJGJCuaS7wHDPjwt+z+6mztzTQBSBS
         +fxHLZOe4MKHH3PaUB3ZZV6NRyyJGwG4RoqXXVI4j7Q+KuKrFtNUtfaBmq7hlVGHrBfA
         CF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784950969; x=1785555769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1D+KDOADjt6pawjgxVvSFGUpDqaxbR+onKq6lqxxAIs=;
        b=bsRss+wSaVnsma1ndOvsj/FuBxVUcs2vARdYZYPzK+c25ob/u0oi2G/z8yKBdO3kT3
         qiJLTW4DV1mKRRhDSc4HrGVkBMnbdvGtD08oKGQMkBCbZKV/48X50Py3o/pwkaTslUIv
         hDDyMr9Dmf1uyGq3KyA/ZZMHap7MzdtL/gd6+Ev1BtJdRjzSq6LV0dPub9m146rAbdjT
         Wk+2+hvPebY0FCkSfpl3FDbwaOgSe4H35h8bsFqkS2OfjQX37MzSaR/2nnMN72sVamRH
         F8pX0+UivnykKXOvBNTQS5uS7cNniHI3bLjNCtZ3l4kTpyT8jtg/xyjm0sus1XNi/XTJ
         mVrA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8PdmnPUb77osp8BbSIDummlnVXLCf7LnHhTfHGUdXOaPNzkZF2ZUAX4UCLsL/SSLzevs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybHDwPxF+E70AV4U7e/Z9gCJmKTM1mKcCxkASH3b/GrEhj9tpl
	KAzalOjdVZ0E2zLtlF4QtaD4y4syFCbu/POAuBlWrtpMPLksdN0o4acindMEUOsICbQ=
X-Gm-Gg: AR+sD11o4FAPuoLXOR87a/+r6DwYEroHqj0h43SXHJLWIY8XpMkOyJaLWmeVWySQfOf
	eTTI82omjXw0jYFBYw41Z4EIpp9iAQ2q2tvU1iE4OSSRYbE+BL5YwHHlhDkA/naoJF3shnhx9DM
	5qOTCyxIuhhFIw34pr8P5wnVXH+0UC1vPL6ZCcppuBJ5MU9ZrNtY7v1N4aogLxZ4QNFSc7VsyKT
	zsYG2Pq9sqpVBeF7Bq+xAh9N+25rx2rHGOIF8F8V88GN/xJH5TRf1fEib5n2aq8suSFYjv0gvM0
	K3Jwv8AYGxOPXI2Xczzs67ZCsurqpQfqSvdvbzjs6bKykgofQtZvGQnrwM8uF/1dq3KuFsclJp/
	+h59jYoFBkcK0daHXrE+MfdJna203AZMhuQ5A4cqKM0kpeaLUeIOt81Ag19x58954p4oFF2CUSt
	wwsEZQPOkcgvZVpdb3zipsQe9LKEuY71nfgaeMu5K9n5lnfh1F4YG5S7t/kAmZNzFuKfFFnQEYc
	6mKd/zrfsEi9A==
X-Received: by 2002:a53:ca8c:0:b0:667:9481:5b37 with SMTP id 956f58d0204a3-668c7a3c507mr214817d50.2.1784950968851;
        Fri, 24 Jul 2026 20:42:48 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65770059sm8525917b3.7.2026.07.24.20.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 20:42:48 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: magnus.karlsson@intel.com,
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
Subject: [PATCH net v2] xsk: fix NULL pointer dereference in __xsk_rcv()
Date: Fri, 24 Jul 2026 23:42:46 -0400
Message-ID: <20260725034246.192091-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
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
v2:
 - Allocate all packet buffers before reserving RX descriptors.
 - Recycle partially allocated buffers instead of only cancelling the
  RX producer reservations.
Link: https://lore.kernel.org/netdev/20260724164719.99563-1-blbllhy@gmail.com

 net/xdp/xsk.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f906d51b6699..383fc2b1de48 100644
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
@@ -343,23 +345,44 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
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
2.53.0

