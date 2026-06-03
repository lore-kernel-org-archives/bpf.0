Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985D47CC64
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489616; cv=none; b=aI5EekQmlruSNSZ+pyYGizZcR4gmR221nj0gQtVIjJP8UhUBHculry4sSDmhs1NxBqGSreSNAch7iBZFCIFiyI6vgCGdrllULAFCumTiEgNfA2lTj4DeJvHQ555cTiMvd9HKnOeTm4FvLB/9Jwrv+Ij9PCke2LvPTEDdu/aQXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489616; c=relaxed/simple;
	bh=LATkU20ItJcDAgt51w2Kpl/BMGu+r7P8lEqoZDqTk4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNLhHPDK5CgfOKDVVnjoLXgohq/4VHCAZeSVRtMt1wAFuNrP4PI1leVlySXzPgcFONSIrbHDg86ZDG1B6CqvyckBfBa2eJwze5BZ49JcgmyfwEdpA6yzgSsClU/KfwGFOWAYo0HVOUaCkCz3bYMXIn1qtBcmnuYbj8yx5WPkTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AafWywoy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AafWywoy"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0a5354da1so4898945ad.0
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 05:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780489613; x=1781094413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ir9ee/J9UxTvHkZL8rS9qQiQHxJ7L7pXrHJ3bldJ8Mw=;
        b=AafWywoygTvk0QPuXJug2nrGrNjoT4PGPj7ccndh/myFubHCbkk7IJQkEqmTsSVnPa
         zOMMq38NGNN3v4AC0l5uPJoHD6AgVgEeK13T3GKjQigv+hcxQf9MTjH/E1pUPxcUtHXY
         oc84lmIOMnesyxuIgaGlJjOlyBP1ahPOIvfVGZ227DoVis9qSW/6v4lSBlVwyZWMgKy5
         Qv9Zf5KkWX3uHiNktuMBb1y5jz3FUZH/dWJdUuvO0hp+69jmuyIOg/9Q0S0kDp6q3g9v
         mIVGailEG3Xtb/+Rjx+xScJ9j1P8pGGhySm/kY1cTK+Ds8fvYuOxS2OlrAHY6TSr/IMD
         WJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489613; x=1781094413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ir9ee/J9UxTvHkZL8rS9qQiQHxJ7L7pXrHJ3bldJ8Mw=;
        b=CgTsWobYrLwwyKcW+PDUAztVsX/sMj7k1mD9QvcdKmeuCHQ5OjJYh8ucNBteH1a6au
         bWHMA2m8qZiIle+u5ObU4q19EchfRTOP1KbN/KoFV06TCv/KZdwXViE4cyZ3dioG/efX
         sfeMGIK75qIJ1jUqeccVbe/1rrsi5jJZ5hQO3ka6/a57GkwECAsAvxq3UUkynK2Ubacl
         EYgJ5Kk7lhJjR9+3VsoQ6xNusQscg/J6YNoy9VlY+kUp3L7rSG4Oy0pogla/gYSw7bAE
         CHSC/2QdThSeu6JCmC9u1nMRYljSJXBJc6MWLotTElGTD3vd2uIwaPtKIfzcGOzQO/KR
         j1/g==
X-Forwarded-Encrypted: i=1; AFNElJ9EJc+ZmD2stapg39mmTfmQY4xvjdTkBFLNyL0NE3IKGYH1lHYOc7DnMYAdnDcZaUZO/Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzklJ/sH/lcRB8P0q0I0fFDzLv8lVdQZV8LxDn9GanRpB3lCRSJ
	zpmdrImJ9qGt4QwetVD17FoV0/OvyICzfqErOuabMeG4ojJ8thDjbobk
X-Gm-Gg: Acq92OFA7OxcmVCX9DkVLWqzsfgb//+U1aq+t60nxL/mo27C4ljjuxvVUw22GiM4TjY
	gxkoQeuY6IiE/vUqVfGHstNSzr78UufxxEQ8V1c182SEZgJANhgguPWOn7VOP/Gz8BsOfdA+7XQ
	Dc2VfXi0Wiimn7EH8sqAe8K4Uq7DNBT7xkvq7QJV5j1yE/okSggMcFkNyEvhDdKUcoksAjIz9e5
	oV10u08bjLsjreQbBvHk7l+ZerEHA5y+/Jqr7iEetZyrk6G8zIAqqIuCHy+az2cAP7h+fGN4kZ9
	zlt2uRxfp7C4nxEJG97M3BLju7kqIUQSCKUeu6dlh/Z3rEg1ghf0nuZdjcW2D+OiT9TXynuoAsE
	6pupL31ABNO2p4TcUAIIJaVsKg60t4GeSmV7B1NkP089BFcsBidrMyLXe7Rr/8LoW21YvtnpV+1
	5LDuKTGTSpUkhAg3x8MQV3MDarWmU5UUFHI+tTb/4Hx+N/0wtkYCCFVQjFFlnWRhwG3ZLAwF2l0
	FS0y0yiQC0=
X-Received: by 2002:a17:902:c40d:b0:2c1:13cd:f801 with SMTP id d9443c01a7336-2c164d71c6amr25892925ad.29.1780489613279;
        Wed, 03 Jun 2026 05:26:53 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f88473sm26810795ad.25.2026.06.03.05.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:26:52 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	daniel@iogearbox.net,
	cong.wang@bytedance.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] udp: clear skb->dev before running a sockmap verdict
Date: Wed,  3 Jun 2026 12:26:37 +0000
Message-ID: <20260603122639.615994-1-rhkrqnwk98@gmail.com>
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
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/ipv4/udp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0ac2bf4f8759..f5ba36e721cb 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2011,6 +2011,11 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	}
 
 	WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
+	/* skb->dev still aliases the UDP rx dev_scratch (its charge was freed
+	 * on dequeue above); a sockmap verdict program may deref it via
+	 * bpf_sk_lookup_*(), so clear it -> bpf_skc_lookup() uses skb->sk
+	 */
+	skb->dev = NULL;
 	return recv_actor(sk, skb);
 }
 
-- 
2.43.0

