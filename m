Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122D83E7BAE
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503708; cv=none; b=syDmdwZ2oe01XYuudTEpxd0+oQl38++KlFOT77HnxYNXChRhTpUTCO22re7ifZrvOQzQO6pqSxSaWLxbzXKSymFZuOe1q7T1SIYzNbslTScoWju6/EQucIPtypY9sMwO79HH9YR95Cz/4/stqhI01ODqCsHtty3E630cUQPo4UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503708; c=relaxed/simple;
	bh=bZWAhI/SNWesR7lukDoX5NGLCgeYv7Rk10k9NwhATLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8IaJblTm4gicyposJuif/VoaBE/RQec+oVh0zRqjz/BvE7FC48N0+K/RitqmW4/uOAbtiUhjV+vOm65UAtH/dg+h5Tc/Bl1jN9YqjLSBkUQrr7eTht914ldHB/j+upKEwKL9XXQSA5HvzF3WKh7XIS+XG4Af0vrI9rQlPwx7J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4f0WGQQ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4f0WGQQ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c85893bce34so1782583a12.1
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780503705; x=1781108505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd5YhtxLNp2KnXGrb45Y+o+N5pgMe2J5d5AaYwVVkHo=;
        b=P4f0WGQQLlTaVlQ5kO7uvNsKxIialrmV+hL9STXbyod7nCYXk6QlXzbj6wY9BMR3JR
         oaMu9ovTjj6l1T5daCPH4t+4O+miA/EwD+6wapQ5T13qSoXBDIaOzpwFW7MDSKqDi5gx
         qWecZQCU9Hde8UYq82yHdQfMIApt5lLc1r4iyCWkQ3ILm8/Ae7v1/qtCOKBSDg108pRF
         EZnJ6yVhEln5EzkILYTQh/lrPk3I1RgBa17yTXkk8PwaJ7hwqhV7ff+57CjzogAcGBFD
         e4hWo7fuxP+33DVFgdOQ7FTIHJJ2GC6+TPklE+ZVA8sCJaTIQSYwcasNIIw7cnntecB4
         mUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780503705; x=1781108505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pd5YhtxLNp2KnXGrb45Y+o+N5pgMe2J5d5AaYwVVkHo=;
        b=D0VZDnZ/6mNhaa3xoji9QOC6eQ3QMwKPl9lFEvYbShIT94tK0I5F8l67abdhElwB3K
         VYM05nWAEHDqzcNPv3m074bUnq86MJn5FPzxXPx1NXiJbIHunK9atdpzzIulFrM4AoqP
         tw1c35JVFIboVFdcj3caDKZF+xV8dzvT4NB+V5f4Mm/Y2Clcxxi24z07DldDMVM/NK+O
         OEyEv4LmbOwZqwG/u0QtFIumZwtmOAkY84n8RhP/ztkFLcA45DEzuwcL9JomKKJnheSh
         LwzBI/K1BFOUbUNyTbOqKrM+/JAIMFJVxteUjK0Sj/iLPxGvqm2vDyJjzdZ3Ytd/WdQj
         hXhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/R0fwYsDC5dGKobxKXJZTrdhq4ODq+omAZ+NWsQZcMZrcrZ7AqfjjdLaf0lRXT6Wn2qBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdrsGX8D8fVLiPQTQq4mpTxQCUe/cYyApUJOhU+nOefmpYTlxV
	gicNN4F02woAhytJ9bqvhlOiy+K2xRUR6ntcydclCd/YB0285mq8HZvoRfCXckBm
X-Gm-Gg: Acq92OF9HImKtwvBV8Emj0st4Ny/aWrOasQZAz2fT1HZGVXvwqVf1XlWWZAEzXtzhKw
	Jdh0ip1MuclcEzyRlOgJkIGaMJ3B1rRs8zUFfgTvIFWWffr7GrYyUDav2zOTH/iYBm25WWkvfTi
	pas+KnPFNHJ3C5kafFcGllh8Mp2d+Nz9++9Bjh6Ev8WeWzztMxLk3luhWpBB88GO1ohVfqigXGS
	AS+Jxml85cZdFLMgr9GsnffaurWTcoO/dkulb7bAzeWF7AGb7V6J1u93ZU/9B51QVynihQfurxq
	i6npRzP/plgq+566DNWYgbV6WzMqPNEjAQjWXS2iOSXSdSiX3w/F6reM9c7yFjOiIi07uoHkcY4
	Gsr+PhNdaoGtNXTOlwx9tCT8DkyPltty2GjxoFp6o1crmOUB917PA12E1+k8pdjx2TY9N5dpx/2
	DA6pPtaPrjdoXG4CeZpCWwzBLIP6mHvIcE89Y8PqW6l6DqKIoGtHqRgI2602f6KbFnOvTwKK1F
X-Received: by 2002:a05:6a00:b45:b0:842:678a:a7dc with SMTP id d2e1a72fcca58-84284e3668fmr4088859b3a.2.1780503705270;
        Wed, 03 Jun 2026 09:21:45 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221cc3dsm3505602b3a.1.2026.06.03.09.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 09:21:44 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] udp: clear skb->dev before running a sockmap verdict
Date: Wed,  3 Jun 2026 16:21:10 +0000
Message-ID: <20260603162120.694986-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603122639.615994-1-rhkrqnwk98@gmail.com>
References: <20260603122639.615994-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the UDP receive path skb->dev is repurposed as dev_scratch (the
truesize/state cache set by udp_set_dev_scratch()), through the
union { struct net_device *dev; unsigned long dev_scratch; } in sk_buff.

When a UDP socket is in a sockmap, sk_data_ready is
sk_psock_verdict_data_ready(), which calls udp_read_skb() -> recv_actor()
(sk_psock_verdict_recv) to run the attached SK_SKB verdict program in softirq.
If that program calls a socket-lookup helper (bpf_sk_lookup_tcp/udp,
bpf_skc_lookup_tcp), bpf_skc_lookup() does:

	if (skb->dev)
		caller_net = dev_net(skb->dev);

skb->dev still holds the dev_scratch value (a non-NULL integer), so dev_net()
dereferences it as a struct net_device * and the kernel takes a general
protection fault on a non-canonical address in softirq:

  Oops: general protection fault, probably for non-canonical address 0x1010000800004a0
  CPU: 1 UID: 0 PID: 1406 Comm: syz.2.19 Not tainted 7.1.0-rc6 #1 PREEMPT(full)
  RIP: 0010:bpf_skc_lookup net/core/filter.c:7033 [inline]
  RIP: 0010:bpf_sk_lookup+0x45/0x160 net/core/filter.c:7047
  Call Trace:
   <IRQ>
   bpf_prog_4675cb904b7071f8+0x12e/0x14e
   bpf_prog_run_pin_on_cpu+0xc6/0x1f0
   sk_psock_verdict_recv+0x1ba/0x350
   udp_read_skb+0x31a/0x370
   sk_psock_verdict_data_ready+0x2e3/0x600
   __udp_enqueue_schedule_skb+0x4c8/0x650
   udpv6_queue_rcv_one_skb+0x3ec/0x740
   udp6_unicast_rcv_skb+0x11d/0x140
   ip6_protocol_deliver_rcu+0x61e/0x950
   ip6_input_finish+0xa9/0x150
   NF_HOOK+0x286/0x2f0
   ip6_input+0x117/0x220
   NF_HOOK+0x286/0x2f0
   __netif_receive_skb+0x85/0x200
   process_backlog+0x374/0x9a0
   __napi_poll+0x4f/0x1c0
   net_rx_action+0x3b0/0x770
   handle_softirqs+0x15a/0x460
   do_softirq+0x57/0x80
   </IRQ>

The rmem charge that dev_scratch accounted for is released by skb_recv_udp() on
dequeue, just above, so the scratch is dead by the time recv_actor() runs. Clear
skb->dev so bpf_skc_lookup() falls back to sock_net(skb->sk), which
skb_set_owner_sk_safe() set just above.

Fixes: 965b57b469a5 ("net: Introduce a new proto_ops ->read_skb()")
Cc: stable@vger.kernel.org
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
 - add blank lines around the added codes (Olek)
 - use generic block comment style (Olek)
 - Cc: stable

 net/ipv4/udp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0ac2bf4f8759..70f6cbd4ef73 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2011,6 +2011,14 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	}
 
 	WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
+
+	/*
+	 * skb->dev still aliases the UDP rx dev_scratch (its charge was freed
+	 * on dequeue above); a sockmap verdict program may deref it via
+	 * bpf_sk_lookup_*(), so clear it -> bpf_skc_lookup() uses skb->sk
+	 */
+	skb->dev = NULL;
+
 	return recv_actor(sk, skb);
 }
 
-- 
2.43.0

