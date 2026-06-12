Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCEA38D3F1
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267769; cv=none; b=JFJaDUBBYnsCk9SAvCIoZi+cI2ZchvXaFoa9XeCrLh8nHynfBk8tlQdEzuRa1ANH3P36rm1byDcTTdRfhvIqx621LT2X7Nk1IOYaHbp4EJFmiytgZvCCXuUh3xEG6LEVewR16zpffsdLnThNgSjLP/1GP/EityerG52t7E5QdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267769; c=relaxed/simple;
	bh=aGU2KaeNbjoMi9bbOYkVaOy/KRLHDhqpCo8qvpK791E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QoGvVWuCHb/Nb6AC9vRdLCJGPdZcLN6rCMRsxyWbCdeugiVw99fBarPbczh4sTTfurt0VPnF6r53h1HLwV3/bow6tvZG6VyK0gw/nMOogHvM703kuuWkBDW+CtWICF4eVYoevJJPNpaYULWC9u9pdEF6ccCcxix4jhtDJXNyTyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmGHwHLt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmGHwHLt"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf1f074a12so9405085ad.0
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 05:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781267766; x=1781872566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fxzmybkp5GeYR6ZlxIQWX4Jsc2twsYOIn8s9KXjfbM=;
        b=QmGHwHLtn0I+hke1iEE9hTWnxHhU8xe7ubdv6PTY0tfhdRmkHlqiRBc4T615WvUJc7
         bTQeaitWjwuH68KEXuKpsO5vIJmg6J/0/3OZM+aYDhQ3Ry90m7z15u21zxVoUYB3QipK
         hOhpzXZ4buoMCG7Bkbt2jp5JQoPZHgZGMBTCfz0vMGiTaJ6FyoJ4TKaAwtV1RGjnDEAJ
         AYVscizV0hZYaW7614aGh+IXC3rY3Q7huAxi0lEoRptpO0WPQG2N+BBaNu0iqZvDcrMI
         OQnXtUyLfrGOC+t9Cr+q1htUF3X4YrHW3c+DKGkvMdEVNkHvS33pEPQ38wmj/AURB1V6
         xDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781267766; x=1781872566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fxzmybkp5GeYR6ZlxIQWX4Jsc2twsYOIn8s9KXjfbM=;
        b=AE2vXltexVT5QIkMMi1aL30NzP1Mb/QvrZcyIKe1gB1y5OAu1hSP4iBVO8BDEon0pI
         +QdMoOYgbZw+IqadHDwwv5R0eaMhlbKPfnQqujJmH05yMaFmbq3exyGgoQhjl65g/EjF
         L1n7PiY5EbKI85oICyfIipnSljo3Erk8J61CBxLtNaAWPf7NvQwguGDLs5Ha2cROpG4F
         BXkCaxf76Nbm9r5DHojxyoIwbb6mzarYjw/wrBTLty3dFIA8rgLtwT8YGcVzmH9Abqwp
         5k36PlPjM9FhRWN6u2jQu3Y3sPnIANVMNB4KPo5ggGi+9aX19gsvbMIykcsO5ymiVWRt
         GWiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/qnfhMiFU8AvQcFXKHj/OA5bpV/5OBvAK4oz8+Nq71rjJx4Smdm8OXCxVCnKJ4y3OKQQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGp1u7HOSQW5mMLHjY7igsCGz/TfxO+kdydJ6g2qRNwgIyqjvb
	buhuirzcOqdBNTsn0ueaxYmiUYIhxQayVCQHt3EvFnEPcDqT95tbFGSU
X-Gm-Gg: Acq92OFzcgNL+fEOO5Ukd2qiBLDMs8UzQ6DZAly4qEJJNq8hvFdLV+AWVltYQvZ1nTt
	w2wwJThAututCqqi7xleu0YpZytvJgSavEDOxNiUQSwXle3H70LRm0FEmXAzg+4yx1L/nX1R49m
	03gfhm1y7A/DJCT+f61fK4DVpBr2yMqdvNJS1rkmJTN3svrGOax3dfWGOB7HDxLqU6q3RGz3/cc
	Im/XL6yX3BDGPE9yobNlGwy7P3LY2TSldgdef686o0cEwjVD7YqoaLr341AoeLIBj+oJv76hY70
	43t/t8H+nEITZVEo+ulcO/CRun3sUVXWSZOKR7r14l8VqfVWpHS8LDxUn2DMgkO5HhjbdUY/8wa
	fRQR85Op5vYdpTWy3IOpkrR+a6yGQZyKK4UPthzpB8u1BJx8OMMG/qYvoaphCV9aI9PDxLTYrBP
	Yz2vKSE4rqrvPkSw5RLynFJnTnZPdtSqbpmxEEKboHz/bAVZn5niAIDcythoUViA==
X-Received: by 2002:a17:903:22cc:b0:2ba:4e84:966 with SMTP id d9443c01a7336-2c4134ebeb4mr32201005ad.36.1781267766547;
        Fri, 12 Jun 2026 05:36:06 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c5535sm22161045ad.18.2026.06.12.05.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 05:36:06 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2] bpf, sockmap: fix use-after-free when the stream parser resizes the skb
Date: Fri, 12 Jun 2026 12:35:51 +0000
Message-ID: <20260612123553.2724240-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
to find the length of the next message. strparser assembles a message out
of several received skbs by chaining them onto the head's frag_list and
recording where to append the next one in strp->skb_nextp:

	*strp->skb_nextp = skb;
	strp->skb_nextp = &skb->next;

and then calls the parser on the head:

	len = (*strp->cb.parse_msg)(strp, head);

The parser is only meant to inspect the skb, but the program may call
bpf_skb_change_tail() -- or the sibling bpf_skb_pull_data(),
bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB.
Once the head carries a frag_list these go

	... -> skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail

and __pskb_pull_tail() frees the frag_list skbs that strparser still
tracks through skb_nextp:

	while ((list = skb_shinfo(skb)->frag_list) != insp) {
		skb_shinfo(skb)->frag_list = list->next;
		consume_skb(list);
	}

strp->skb_nextp now points into a freed sk_buff. The next segment of
the same message arrives in __strp_recv(), which links it with
*strp->skb_nextp = skb, an 8-byte write into the freed skb. The free
and the write happen in different __strp_recv() calls, so the message
has to span at least three segments before it triggers.

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

The same resize also leaves the head's length inconsistent with its
frags, so a later __pskb_pull_tail() can instead hit the
BUG_ON(skb_copy_bits(...)) in net/core/skbuff.c.

Run the parser on a private clone of the head when the message spans more
than one skb and the program can modify the packet
(prog->aux->changes_pkt_data), so a resizing helper can only touch the
clone and strparser's head and skb_nextp stay valid. Single-skb messages
have no frag_list and read-only parsers cannot resize, so both are still
parsed in place. If the clone cannot be allocated, return 0 so the caller
retries on the next read rather than failing the parser.

Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
 - clone only when prog->aux->changes_pkt_data (Bobby Eshleman)
 - return 0 on clone failure instead of -ENOMEM (Bobby Eshleman)
 - free the clone with consume_skb() instead of kfree_skb()
 - drop the unrelated guard(rcu)() change (Bobby Eshleman)

v1:
 - https://lore.kernel.org/all/20260609112316.3685738-1-rhkrqnwk98@gmail.com/

 net/core/skmsg.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index e1850caf1a71..97e5bc5f38c3 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1149,9 +1149,29 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
 	rcu_read_lock();
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
+		 * strparser still tracks.  Run the program on a clone when the head
+		 * has a frag_list and the program can modify the packet, so it
+		 * cannot drop frags strparser owns.
+		 */
+		if (skb_has_frag_list(skb) && prog->aux->changes_pkt_data) {
+			parse_skb = skb_clone(skb, GFP_ATOMIC);
+			if (!parse_skb) {
+				rcu_read_unlock();
+				return 0;
+			}
+		}
+		parse_skb->sk = psock->sk;
+		ret = bpf_prog_run_pin_on_cpu(prog, parse_skb);
+		parse_skb->sk = NULL;
+		if (parse_skb != skb)
+			consume_skb(parse_skb);
 	}
 	rcu_read_unlock();
 	return ret;
-- 
2.43.0

