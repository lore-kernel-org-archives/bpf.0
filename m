Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13573A785D
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264104; cv=none; b=NMVOvla7vd6FXLsXHdBu+i9u7ZaaWBDclC+DXzdBeFxnVhU8xcPwvaRZOA9/m/K7hwHrs0JbIXw3hvVwA91gh39xp9ArgYzSYMFwmSu6uTYnKC4KkbqY5XwexZ6MtU1Xec16lHp5dyNK9S9B3+Cj1WTXN/E5ZXvAN/fzY2d+YhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264104; c=relaxed/simple;
	bh=v+a/0vxtzfg5vU/1AWu+LM9ezHbmg+SuWuOYwy+t/ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUfdc0nhppy5os6cM9cts/+LhIW7h6vfXCclPv4+VV1K0BWsVAmepnn16iUz/Jpjd8lQyVa5UukPOuV4xjBbWc8R6oRHmiCLgoMcqyzlanH0Rwp/GBkcNc2qKD7ozV5A1t0+Q8FpaUBVdCGmp0613dZSihzgNmoU9bCVahvtRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0EIjzFx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0EIjzFx"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36b9d265355so425145a91.2
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 04:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781264100; x=1781868900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZasNhzyut4yZ1h38+2iP2uzrqSBD3v2I7RBNB9rdm0=;
        b=b0EIjzFx+45gM/z452S9otOmVp0efEnS2H2SjMmV4Zt+HApgBf9SlxjJGjhCjDHJ+I
         kimR97ixZDDq+Ov4Wc//BcqWGC6S2LZCB4e5OVbl7u3htLuEYF+NHPnl9d8y5s7YNk+T
         SJceR39CZdSKCkwgywVtg8YOn7qg3QYhISqHhEqytcfY81lF0g2SfyYx6MyfP5vAcuPy
         o2KpqkdnMIWUgC4bz6sNvbsRk7vtE5BxkTigqj93BSmxE/CWrHCTKLh2GnxpHP86gc0P
         qoeB6JruaThYI+IjKQkKAznbCUzD3hBbYq6PwgrkJZ/zmLRLBWShQqPxJeei5sMD0+wT
         8FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781264100; x=1781868900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZasNhzyut4yZ1h38+2iP2uzrqSBD3v2I7RBNB9rdm0=;
        b=ccWIIVG+JKO2/SUMBhJDqg7ARQHxCpM9U7Ub0iDNluQFJ6/fQT1LhHeyPJusc1ogF1
         hpF1QDf/IHzsKMLwGzPJIr7gPnBiuGKnMtelx8yKgpVp3JHbPPsETEX/HO6SfyTlqD/K
         pMZUooM7jNGX6XTfudCNrMoEpKMfm3hyPNMzQxaai/JeIw105ouCk6UqfRKuXpXpi0zn
         RgKEN8kJizxzM13OvFy2xFyAknyVDyfpmImQnOhAYTFDMWDkdIURrC1m8boMZx1KsHBX
         Ec+gJPsSn7E7GDWMUt1wrNjrhIKEdWlbcUEFcbRVc746VL+c6v+O9Wcj8J/j0oMwn/jZ
         uUZg==
X-Forwarded-Encrypted: i=1; AFNElJ/JlEmN71MK5FGPkdGeLJruzVavCCF8HV+IDTpAx8MEIDDY1nZnquZtRpAHJz6j5nEE6oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4/gqQ/V0YUt97cEFhe03RaCX543M05CPDP0/SvCbmY+D6F/bO
	KLCC1WJ+k7SSry6qbTbNNq/uXFHjhwnXycmHp8zDBqzFmatMgtX9NvlP
X-Gm-Gg: Acq92OEDXV/3AipUD7zR84GuMDqbd8HPBbLvgGHlSudoxHWyckgY/4Tzkbfe83hBUS6
	jY7jOrKUtDT0qcTOQOEm8ylhToR2sgaef4uuTWvtrpmzDQkNCPLWxMRO35Aw4DXc2dxG79W9ltC
	BpW11YsTtWlot0WTTk0pGtWFCh5Fgsh4xUYapCagcO7N6+hXXDGyfUnJkOclm2P2Ga86YKl97vv
	8ZzvFQmM8p6nP2R+gW38vSWxUMBRnqDVgXwFhqGR0vqITsmmAlO/J5dMFuuuRY5CfTn74XJPryn
	BqQB+nKGG1BsZKAMfXeagC+7TEk8SQUOb2opemCuvFRtKs/OBFcjXGFvVnvlwk3jJD3LZK/Hq5C
	SQorTDZ9wVSPZY9OCFrtMxo3ARFQB85K/FDlhPH+P7Q27pb9kwsKsS5kCeZpqgjybuqaFVEPSwQ
	V0rpPr3Xf+hYVYac0hh0MxtSOlPR0iwf6/bhrsJqvz/znceFB3DphTCwH3S+Gykw==
X-Received: by 2002:a17:90b:3a05:b0:36b:944b:fd81 with SMTP id 98e67ed59e1d1-37a01845ec7mr2627752a91.4.1781264100039;
        Fri, 12 Jun 2026 04:35:00 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e7e217c0sm1543081a91.2.2026.06.12.04.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 04:34:59 -0700 (PDT)
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
Date: Fri, 12 Jun 2026 11:34:26 +0000
Message-ID: <20260612113451.2697869-1-rhkrqnwk98@gmail.com>
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

 net/core/skmsg.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index e1850caf1a71..501e8cfc7505 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1149,9 +1149,28 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
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

