Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778CA3E317F
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504076; cv=none; b=VeF5a1v5ZPCRCy6PpLNTm93Catzrb8Ciw5idfr64X0QAEg3YI1p/iGTs2W6AVkbneX/KmHZvxk4KEd59nxWeRaxwBn9/lJe1OxKJGAWuSpZEuO9ahcNq3netqzRkoCrRsyb31MJH/RfZUXs1HXKmAkupCizEerUEtRU7CYiHJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504076; c=relaxed/simple;
	bh=bZWAhI/SNWesR7lukDoX5NGLCgeYv7Rk10k9NwhATLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czYxcDMr1Q8FTtDIRHQzUr64gLIJHmzUwoYMTJuasYAciLTDta8I7M9o0Iy+O0UIJXJeS5oiVxBL+8u7azq/Lw6JkwKVaKD9FRrwsDMLRpI2FuHlPedbAXCtRqM1E3WGOuUWnmOBR0cXAZIdtHkU2f1TIdBsXzm5dXAe2H29n+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAoOHqiH; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAoOHqiH"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c85b2139015so1409395a12.2
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 09:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780504074; x=1781108874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pd5YhtxLNp2KnXGrb45Y+o+N5pgMe2J5d5AaYwVVkHo=;
        b=lAoOHqiHkGUQKO158ZG8BXYY7dp+xUKGtR0Uqd7YQ3hzvXx8cbmitf8nBbmDHGUO3X
         WyCHEdkkzlYQ9bm4hhSJ2jgxQyMFzh4egE6wSU4BeeTtf0++tTZHjpjceEYm5nVXzEPq
         8s5mh9hCc5fC/aqtto6ILqCCRK5A0Hw06w6cT9A5GZvdxVMDtRr3onb1WslsiwKGrLWS
         SFH58u91/hd5ZmBxXAkOfeSZb9kT2qSxrG3u2f7zL/IueAtb12AJCucNLp5LoaT+0Yr3
         AcvSJQPYP0upHmUbLwGjP6loiveY6Emstqzo9CEgm+aHFTxckrMN2xzHZBSO+NaalPBl
         pChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780504074; x=1781108874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd5YhtxLNp2KnXGrb45Y+o+N5pgMe2J5d5AaYwVVkHo=;
        b=H1bCRSh7PYn8TO+l64LNrTNataKk7Pc9KSCS726p/xll5x2iQ/lLYZLzljGjaqdWpN
         V76V/rc2ll4m5AzvT1Ps3uAGvzYAJQPm/SViCaY40ktXZldTgdU1jGZsvZyqeI8mBOak
         hPl5KBO2jNW9GdyTqwv+xnNgdHAjNsj13KPdwjvD9GExZLQjK+zCHBDUrPyPforp4wDs
         Dindp+lMIG8AGuH8y4h2stnANvxEdOM4csGaEP2rY2yweRSCWoX9BOkavJfU9yW/e3ib
         RDA7u/CxYlDnRrqsMxUaf7hmOGSmz9mV0VvylLpQfqPzZ0JqCZBeIVxGTFyrkn3LPlHq
         dDng==
X-Forwarded-Encrypted: i=1; AFNElJ+stjMEoTAocTEh5d2vig+h3Lkg52YJ7rH1A0s5W5tuQzP4K3y2buuFktvNZoG+ddpO2b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkuZkH24HyVEwXzcPW2ABlCfZYx7GEqgzR4h0H1m7cNcfHxuZU
	C90kRLBWnOyZD+9XAJNhKrVxNJ74TwTWDPSef8pQCN2ZUDuZ6LyLqHPi
X-Gm-Gg: Acq92OGnlO8dvP+x9mtyymYbIBx/xqFir7T1oh7wOUTeYh+fd2rZjR24+SW5Wyo1xIV
	h3YtOlKf0DwB7RuCvMwINDTP+xeD21ghrXFbMT+FktjkmE8j8FqNazRp2H+5VxNtiiEa53wvyNV
	4Lyo5zcO/YOAurA+ZhmtYKznBm/EG7ekTcgZm+vJNwkAgzbQ3VlMVuOHew1JnP5hYO38g4mzeIy
	0XzMd1lohh6jqWP5TjbJyenI6AmFtCJroxV1RpDsrm8SjfcI5fHZ2NOMo+CVcruDFmfvXu5OVA8
	TKr8kCPGOEdIC5nmD39pvMtVBy2wT872eD8ODWpXi0vP04FGvqnFmpTgdf6dNmSO7sZ3jKmIhB5
	x9ZGMSTAHyA/PaOKBKYOTmE+NRoxHxTfr08uZLxs8fGi+sT0q3KiY3UHzK4eyXRsVlqScvAGzFW
	j3LcYrWt+nWU0WFcJ9FTtexoS9gBE8P0V09t3CkNYCP0GSHLO+9HyL8fmsQNu5vS7/Y/TnGZHnm
	C8OBXX+CrQ=
X-Received: by 2002:a05:6300:67ca:b0:3b4:813d:dae with SMTP id adf61e73a8af0-3b4978049femr4892709637.16.1780504073819;
        Wed, 03 Jun 2026 09:27:53 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a4e59sm2930976a12.16.2026.06.03.09.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 09:27:53 -0700 (PDT)
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
Date: Wed,  3 Jun 2026 16:27:33 +0000
Message-ID: <20260603162737.697215-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
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

