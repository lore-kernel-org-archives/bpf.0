Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036188;
	b=BH0X5Zgiyrhkxi1Z7SkOv8oR0aIOJGN8YmtAwLtk9yrvX/f8G8MSeZ6flzbSrtFD3K4K
	 UhLc1BbuRGzakaEz70U/LvBML8foItUHKqfXZZCKHATy+1fGn+YGZHfVva7c77LlAu13p
	 eE9rYIjdnx4lTvaa2PcJIhcoRKqN5tGnf20ehhYgJW9NOogY9aLm60Uius7NZoNCBvF/R
	 jQUo64+FhGfnrHxrObyqeNFe3X1MSJpR2hfSAaryJhNRkDwhAkg/RxXuC8dcBdGBKRAa9
	 0empK4kIN6J0zdvPS1M+3YwxwBznHIvePMRcrld6X3+GdGaLug7S/tcdmsszKxZFQeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=qBeIaAPs35wohbd8bVNUMgZIH9FSaYRmslH33nZh4qA=;
	b=C7UneQunO7nf8e85W3DtOHao3NQR4wpFACcKez/CpK70CsyxNyJts0DwK3h+X4Zuyjtd
	 87o8SoSgJt7jbdioIbP/Hzs103eO39/+uml1DaNk9oGVXNDmterK5Vwor7bPR2ncq+Ahk
	 jttB+FgeTjH74fefk67eUt2o75emIyNNUTdK3+FQTRy37WUfz3gTGSHWTg9fm7NUb2ZR1
	 1KWTCmlzKQ0asSpv5+dN3EdK14RLleQM++dtyI2YU8j9wKAi5DPaGE4wn0yQybsooyuDc
	 Fz5avQvrNcHZWkVa1PGBmio23t0Azyu3NLkHj13V85rqRaKK+D2Hqpb4b0aOZkbWKvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PSTeU0KX;
	arc=none smtp.remote-ip=209.85.222.70
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C66606A332
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 21:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5C66606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PSTeU0KX
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-99062be02ddso283984241.3
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 13:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795036187; x=1795640987; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qBeIaAPs35wohbd8bVNUMgZIH9FSaYRmslH33nZh4qA=;
        b=PSTeU0KX+Gf40s9EhO1PmqTzCKtc/p/D/qnofMF1zWHBffHe7c571LSfyftrS/UcNq
         HW9cBsG0AMJqh+REFbRxm5ONAsFGBmvbsTKXfolUM503ZMnAPy+X1WssYXlIQfJehn48
         61ULlXM0mVVdAJVg9hUy6DJPcnlngmKow+d0wBOtLuY5SHbDkeTTcLFm++pNwLQ3a3hV
         tIYA2uQyvRO8fat8w9672wvN8/nkAjJrE5zL7gSILyMZ1J3w4F+kEUpSs7rINW5WhL0r
         OVAMxRvd6P8+ZH2GiZapXYbFP8JAs3oAsJaTnFn1bgnM4MR3LDJvPDa507I8fM0piFCJ
         IFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795036187; x=1795640987;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qBeIaAPs35wohbd8bVNUMgZIH9FSaYRmslH33nZh4qA=;
        b=CFINh/CX4dzWCSm6RhSx2Aj4sawn2p7Y5VZ5F2DwWGSZOFtsJIBuc5VA41eGT1WoLL
         vxetD+OOlNazVj80WPhLWVW5fE9F8HJzCwxq302J8fPa+g7CGc6ejFirt4EgsLRo/lrM
         7/5hrLqhefyK1xVB8awTDCn2VsPVRyA/QhLFMFfthZNoWgJ5oeYC3D0tctjicSJasJMN
         ld7/485A3nDVIhIJyY2Fw14yJdVD9Xayv1I2ES9E/vsybq+b3nLm36MM4KMwwZwDxN1Z
         PBkfo4usbWkgjhseDYTKLkJ3HF+An0YBd8XeFPjXMoEiP/DclIzE0hRanR+12PyRRiNv
         m0Dg==
X-Forwarded-Encrypted: i=1; AL+hErGaRAhCKcFj2hYyNu6vih5CJsZnIMzt6xCuhR7XpcAQJnqkHqSPscO2FSl65OF0C1pEIcs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OsLsal3+z41BfR+r3pocBs9qow7DQFVvGoeTDk+9NAWrriNSd
	tdpidJ/zL0l/Gs7X/qLIJtgGv6oiBmYg6izmscfw2c1qBX9KV86GRxABjuRdcPP0O5ZPhHbCJvs
	c0B5numth3tKgvZ0RVpbC6b65Nw==
X-Received: from vsbmq22-n1.prod.google.com ([2002:a05:6102:8656:10b0:7c0:f0fc:576a])
 (user=thaisonphan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:4485:b0:7d2:cc5a:f0bd with SMTP id ada2fe7eead31-7d6ba40e444mr1549052137.19.1795036186487;
 Wed, 18 Nov 2026 13:09:46 -0800 (PST)
Date: Wed, 18 Nov 2026 21:09:32 +0000
In-Reply-To: <20261118210933.2477423-1-thaisonphan@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118210933.2477423-1-thaisonphan@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261118210933.2477423-2-thaisonphan@google.com>
Subject: [PATCH net v4 1/2] tcp: initialize ir_rmt_addr and ir_loc_addr in cookie_v6_check()
From: Thaison Phan <thaisonphan@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ij@kernel.org>, Olivier Tilmans <olivier.tilmans@nokia.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, Stan Iliev <stani@google.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thaison Phan <thaisonphan@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit a3a128f611a9 ("inet: consolidate inet_csk_clone_lock()") moved
the LOOPBACK4_IPV6 initialization for passive IPv6 TCP sockets from
tcp_v6_syn_recv_sock() to tcp_v6_init_req().

IPv6 SYN cookie connections allocate a fresh request_sock without
__GFP_ZERO and call tcp_v6_syn_recv_sock() without tcp_v6_init_req(),
leaving ireq->ir_rmt_addr and ireq->ir_loc_addr uninitialized in
cookie_v6_check(). inet_csk_clone_lock() then copies uninitialized slab
bytes into sk_daddr, sk_rcv_saddr, and inet_saddr, exposing them to
tracepoints and bpf_sock and causing inet_daddr != LOOPBACK4_IPV6 checks
(such as IP_OPTIONS in do_ip_setsockopt()) to misclassify native IPv6
child sockets as IPv4-mapped.

This was originally noticed via an out-of-tree socket hook observing
inet_sk(sk)->inet_saddr != LOOPBACK4_IPV6 on KASAN test runs. KASAN
enables SLUB_RCU_DEBUG by default, introducing an RCU grace period that
prevents cookie_v6_check() from reusing the warm request_sock initialized
during the initial SYN. Upstream, with tcp_syncookies=2,
SLUB_RCU_DEBUG=y, and slub_debug=P, sock:inet_sock_set_state shows slab
poison instead of 127.0.0.6:

  ... sock:inet_sock_set_state: family=AF_INET6 protocol=IPPROTO_TCP \
      sport=59839 dport=41050 \
      saddr=90.90.90.90 daddr=90.90.90.90 \
      saddrv6=::1 daddrv6=::1 \
      oldstate=TCP_LISTEN newstate=TCP_SYN_RECV

Initialize ireq->ir_rmt_addr and ireq->ir_loc_addr to LOOPBACK4_IPV6 in
cookie_v6_check() to match tcp_v6_init_req(). Tested against a QEMU
reproducer checking inet_sock_set_state and IP_OPTIONS, as well as the
packetdrill syncookie selftests.

Fixes: a3a128f611a9 ("inet: consolidate inet_csk_clone_lock()")
Signed-off-by: Thaison Phan <thaisonphan@google.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
---
v4:
  - no changes
v3: https://lore.kernel.org/netdev/20261117124710.1338951-2-thaisonphan@google.com/
  - no changes
v2: https://lore.kernel.org/netdev/20261116023709.132684-2-thaisonphan@google.com/
  - clarify how KASAN (via SLUB_RCU_DEBUG) exposed the uninitialized
    request_sock, how the issue was observed, and include the
    inet_sock_set_state trace line (Eric Dumazet)
  - add Reviewed-by tag from Eric Dumazet
v1: https://lore.kernel.org/netdev/20261114161248.3428695-2-thaisonphan@google.com/

 net/ipv6/syncookies.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index b581cb1ee2e8..b33011b71fff 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -17,6 +17,7 @@
 #include <net/ipv6.h>
 #include <net/tcp.h>
 #include <net/tcp_ecn.h>
+#include <net/transp_v6.h>
 
 #define COOKIEBITS 24	/* Upper bits store count */
 #define COOKIEMASK (((__u32)1 << COOKIEBITS) - 1)
@@ -205,6 +206,8 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
+	ireq->ir_rmt_addr = LOOPBACK4_IPV6;
+	ireq->ir_loc_addr = LOOPBACK4_IPV6;
 
 	if (security_inet_conn_request(sk, skb, req)) {
 		SKB_DR_SET(reason, SECURITY_HOOK);
-- 
2.56.1.831.g720f3f5937-goog

