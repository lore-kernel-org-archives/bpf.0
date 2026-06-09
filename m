Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB9638E8C7
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781004212; cv=none; b=gYteavfRiAEQJDu3CSfUmV+VJJ25WPAxDVnyNuKkscYQACcmO9dTuI2M29xNnRwE1Qb2VdugUftWEOyHK4T+9iNsI2g65lcBEy+j0CNtW/3I/Y1/iVGsAXdRAXC+gJC+Fxqbt/cMXyGdL6vzaL/d4TmLjWeU3J4ZFX1tUk3n8SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781004212; c=relaxed/simple;
	bh=P4XGoRQ5BTryg0GgBlPYvMJjZgaDdzAwmxXZAWkJolA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUQaHkG2tSMJgIfc4XIdRWsSxosm1ZJluD2EkObNsHeyOylZU7D/npLJMW3Ez8xamiMF2Z3mV3VhRlRaXIN9Y6qOm0ODfF8vNgRbxrT9sZx+qNqISzc/3ogFfWf8cJSnHHbD3jN9G8dZ+mj4tVg4b3AcXRpH5ap6561ZTwUWfI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNom5odz; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNom5odz"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so3644257a91.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781004211; x=1781609011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kk/KQ6BJWiQwzMAsi31u8EPjaiQOWvIKGyuiY9ezidI=;
        b=CNom5odz3fE7e6Jj4svbf81T5VRgXoNRKs+LDwHjmJr7UucLriuJSreP0Z1rKaCH11
         tPv4WFy86coLOeaGJMuPXugf33TKxc51Qjp1tlfGuT3Nc5Sua5Dknd4473wwGmg3X258
         VNbBJ/s4T+hmQ81b8M3n8j8AaIq2BdT0C1L+ctfXMcIOmGqVVI0grrRDNGDmVNuyYdHM
         kvQhuTFJgaZknEBG9FqDxS4ojwbT+qkslm2QskHF7jY5oKtfnG10Fd2LkU4vlWlx+a2Z
         aAWrVxoxMqzGTPoItzKYo3teshoyYdQyyN0SkKAfSn3Ahn3pxwCSRSGCP193eF2QREx5
         Atzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781004211; x=1781609011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk/KQ6BJWiQwzMAsi31u8EPjaiQOWvIKGyuiY9ezidI=;
        b=HUrbT3UG46QbWnXtBoE6u761AQi8ypY0OVm4Vj8DBXQAYoctr8+2/UWbwQjhqYWQMq
         YM+Ww3+VLyH/U8kjTxHj1cZQzPohKFZ8jLdo0UyV4XGDsZ+VAz0L9oKsixVGSq6NT7RR
         59SdaqZc51oZUNywbzPZbKEqEj/tixRNBSuX910RJ3r3ryaqc46scvqHC+Zf9/OX3pMT
         pdaka51XGnucgR4UtND9a4TSGiO5aFHmNlfw9M7b6fskCbMSM8f3uURobN8SniIArZi6
         md2J2QT2hzFlSKZxAnFyEZAxjS6+FFLR/jb/CK1KxX2gqe9/Ztbezckb6DhYKQ46kO4S
         HI1g==
X-Forwarded-Encrypted: i=1; AFNElJ+pMjR7cxXvOg7/Y4belQfhl3LQuenPeWeyZgAcnXVOu3chaHMMMhtkB+NJcXY8eB2HO28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqGwrOUWAVjknI3mIeBOYh/BIjc3+UnlAd3jWanOw39UvO/2Lr
	i0lj5XkWnbGTQXPfnFX7W3Gy96vazOJRVBXYZVp8AQ6/PU6N5UGPsUIh
X-Gm-Gg: Acq92OEYKONU+MHGpL4bcJ/yJ41GDK0LgxBf/jlsHZOX55pw2wL7/9xrWj+Y2qsKsyZ
	FqxxTXju2nBFua8ySPlpX2iLkdNmqhHI+jyxmyR/z/MhdbM5VUwwfZLViSf9FcVh9lTuX929hA1
	PZ6e+7pu0rbTXK5pSyY92RWYVyUR5iSt4dtnEmW1RXxwI1wHf3+Q19lRs5f/u/IOwYs202jb5jz
	bUxvcifxWHKWVdP/SHB2OXRiURFXZPSHyo8V11aVfUzyG25DaW6WNHRO2pIKr1i7OGQDJUCkpY/
	5k6Fx/B06Piaw7gYvnBXn3nMYljmEPKc+KvzjSEm4+QRq78GBdOyJx0c/BYex8UOf1FqwBx8j3w
	ynTgQMzjZ6vDxgfPkYqrS5E9sRRFdmfEKAy0ghEFs9hZvhrrqdxkihgVEdSdvj7kbcs8FpNeeea
	CKvWI/5ex1WYV6XjG9wfdA+Zbi4DQ32DmVbWz2RsiHxdM5RrD0OFfzDSDAUO60VU1cFVPaW7uf
X-Received: by 2002:a17:903:2342:b0:2bf:1486:e6ca with SMTP id d9443c01a7336-2c1e7d41eb6mr213499545ad.12.1781004210540;
        Tue, 09 Jun 2026 04:23:30 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649ab01sm202528565ad.71.2026.06.09.04.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:23:30 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf, sockmap: fix use-after-free when the stream parser resizes the skb
Date: Tue,  9 Jun 2026 11:23:03 +0000
Message-ID: <20260609112316.3685738-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program to
find the length of the next message. strparser assembles a message out of
several received skbs by chaining them onto the head's frag_list and recording
where to append the next one in strp->skb_nextp:

	*strp->skb_nextp = skb;
	strp->skb_nextp = &skb->next;

and then calls the parser on the head:

	len = (*strp->cb.parse_msg)(strp, head);

The parser is only meant to inspect the skb, but the program may call
bpf_skb_change_tail() -- or the sibling bpf_skb_pull_data(),
bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB. Once the
head carries a frag_list these go

	... -> skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail

and __pskb_pull_tail() frees the frag_list skbs that strparser still tracks
through skb_nextp:

	while ((list = skb_shinfo(skb)->frag_list) != insp) {
		skb_shinfo(skb)->frag_list = list->next;
		consume_skb(list);
	}

strp->skb_nextp now points into a freed sk_buff. The next segment of the same
message arrives in __strp_recv(), which links it with *strp->skb_nextp = skb,
an 8-byte write into the freed skb. The free and the write happen in different
__strp_recv() calls, so the message has to span at least three segments before
it triggers.

  BUG: KASAN: slab-use-after-free in __strp_recv+0x447/0xda0
  Write of size 8 at addr ffff88810db86140 by task repro/349

  Call Trace:
   <IRQ>
   __strp_recv+0x447/0xda0
   __tcp_read_sock+0x13d/0x590
   tcp_bpf_strp_read_sock+0x195/0x320
   strp_data_ready+0x267/0x340
   sk_psock_strp_data_ready+0x1ce/0x350
   tcp_data_queue+0x1364/0x2fd0
   tcp_rcv_established+0xe07/0x1640
   [...]

  Allocated by task 349:
   skb_clone+0x17b/0x210
   __strp_recv+0x2c3/0xda0
   __tcp_read_sock+0x13d/0x590
   [...]

  Freed by task 349:
   kmem_cache_free+0x150/0x570
   __pskb_pull_tail+0x57b/0xc20
   skb_ensure_writable+0x236/0x260
   __bpf_skb_change_tail+0x1d4/0x590
   sk_skb_change_tail+0x2a/0x40
   bpf_prog_1b285dcd6c41373e+0x27/0x30
   bpf_prog_run_pin_on_cpu+0xf3/0x260
   sk_psock_strp_parse+0x118/0x1e0
   __strp_recv+0x4f6/0xda0
   [...]

The same resize also leaves the head's length inconsistent with its frags, so
a later __pskb_pull_tail() can instead hit the BUG_ON(skb_copy_bits(...)) in
net/core/skbuff.c.

Run the parser on a private clone of the head whenever the message spans more
than one skb, so a resizing helper can only touch the clone and strparser's
head and skb_nextp stay valid. Single-skb messages have no frag_list and are
still parsed in place.

Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/core/skmsg.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index e1850caf1a71..d5b10f9b0ba8 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1146,14 +1146,30 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
 	struct bpf_prog *prog;
 	int ret = skb->len;
 
-	rcu_read_lock();
+	guard(rcu)();
 	prog = READ_ONCE(psock->progs.stream_parser);
 	if (likely(prog)) {
-		skb->sk = psock->sk;
-		ret = bpf_prog_run_pin_on_cpu(prog, skb);
-		skb->sk = NULL;
+		struct sk_buff *parse_skb = skb;
+
+		/*
+		 * strparser chains the message skbs through skb->frag_list and
+		 * keeps a pointer into that list in strp->skb_nextp.  The parser
+		 * program may call bpf_skb_change_tail() and friends, which go
+		 * through __pskb_pull_tail() and free the frag_list skbs that
+		 * strparser still tracks.  Run the program on a clone when a
+		 * frag_list is present so it cannot drop frags strparser owns.
+		 */
+		if (skb_has_frag_list(skb)) {
+			parse_skb = skb_clone(skb, GFP_ATOMIC);
+			if (!parse_skb)
+				return -ENOMEM;
+		}
+		parse_skb->sk = psock->sk;
+		ret = bpf_prog_run_pin_on_cpu(prog, parse_skb);
+		parse_skb->sk = NULL;
+		if (parse_skb != skb)
+			kfree_skb(parse_skb);
 	}
-	rcu_read_unlock();
 	return ret;
 }
 
-- 
2.43.0

