Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036190;
	b=jXACKAeOaxW6wRraCgJuGgn70K+z6+EyHWTXEYE087lhNI+jq32MRB+dXO/Dph+0hp3a
	 NqcxQrH+rVjiH8+RcFmaMNfOIYqENhnc6c/r05ZeUkXKq9F0HAIGevlcLR2XptemOu7ne
	 E2oMmB04Oe9E5mKitIViVZUhcRuts/6+SqqWuG0UusGxhbiuPQUcHVJKQu57GyJWu1OSV
	 Ekecov5MMBYh81TYStGrLBrJuNxjBHkTgvMnsE8gTtcMwaMAYN1vULgSKVupuW/sheU6p
	 6auSLq/aTL+KcI4yCXVqrHwU7NnklDxxLrJD/I1HeK4kMdsYW0VnDUw2GmTRA8EpNWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=INm/FnEpTCfTyow7VOum/3qmO9+j35dJqSIb5QUtmvg=;
	b=QKd18viwszPKCUMut/JzyMfVXmqu4QGlGjfo9/e8QxTlpJdvlomzvV73pPwSWGp4cXxR
	 Fk+6+FwD/7xx8Rb/qu2YIVAaqzEtF1NdorIB1IZUn4J+NuZMH2GEaiZZ83aQSAhJWEUo8
	 xHoY8pWgb2MvSATBGbfdYghqoydUjmIkKXWfM2jf0nPh40aPaQLZpcaUmXGj19tmR+akY
	 NIT5vNaP2lW9Iy7gF6UwwHgdrSTSKQdX1Ir3ChbHB8YAQ1z1AGZnPXQOYZFkmlS7FTlaZ
	 BPP5VmG29vy56btREvF7MosXeHNlwY/YRmSCptvYyJDi27AL827a4rx0MGxV+Zbu3eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EEHEWhA1;
	arc=none smtp.remote-ip=209.85.222.72
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8EF60A260C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 21:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F8EF60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EEHEWhA1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9806756ea40so1052365241.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 13:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795036189; x=1795640989; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INm/FnEpTCfTyow7VOum/3qmO9+j35dJqSIb5QUtmvg=;
        b=EEHEWhA1wUvsfNWjiWjO8Btw4tCYofSgDkVStNN+MPTXz1TUEM+a7g26y/lO4VSZE2
         PLW7N9U4/nIwLw/yUf/UNYhvt3rBs9fSMXnVW5JRv19r4S0lNcV88821rj5zQFFO1KPV
         fVlT3qTZORCDQEG8l4nnEy9TGplQoHk5udO6/akwUAVB5uqEQuawfO1S4L6VhWnffN5s
         u7WIhm8yfIyodg5yNOQHX4S8S7mWiBVS0whd0AKDNUVD53A2G8E/MvHK1RotSqOlKwzg
         3mA588qLmM5Sp/xHUcfb7d0LdjFNCUG73SC8zJ/2yJE79eOGW9bCKQvWr4u+Fc6EQH/c
         BDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795036189; x=1795640989;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=INm/FnEpTCfTyow7VOum/3qmO9+j35dJqSIb5QUtmvg=;
        b=HphX8oRUUc19bLoq8+KtdDhqeI56/fA7TK1Ous1Tpv+yeD5LmeHi7APkZEU91NBSc7
         enTiwopvOSRAdsdApBtgLSrRa/f0o+33xMCOrQb6r4Jkn8nCtE1T2KSexdUCC6t+L8ua
         4RWEHoOuY7VDcGFbUm/G8wj4e0Y0fg30GsbiibaNZgzQQwiYZhhii21qIkXXZ18rdomi
         yLOBeKA+uU9dA4S8Bv/oBjAzJwWATKpKB6/B3LOgmFeVHjWXHv8q1S8CI7zHzT8/ddYx
         VAjOqwLLgkBjIwi71cVll3YwLFWn8+PZe5Xn0txENO0qFAbjZH9kYxxHfqAkHGbifKjr
         Kgaw==
X-Forwarded-Encrypted: i=1; AL+hErHAob102qtmYoWzRVMHBnE281LkhHMJ8x4mRXG2XklNbBhAyu9Lfkc/u7zfYRQITyxYS4c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ADNIlWAKi0ZSS4SMKAQX+8DgHFov1Cs/1+O8yaFmMSsnCf8fu
	JYj+OgVp4Sc3k9zphrS6D/OWOvObhOxZYGbC4UbdWoyEzpeRSGpXVceA8dUB293bDOTAET0WQhb
	0NRXAk+Al5IkyrK7Idb35Sjkdhw==
X-Received: from uabjw11.prod.google.com ([2002:a05:6130:8b:b0:998:b46f:334d])
 (user=thaisonphan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:50a3:b0:7ab:af4a:f2f3 with SMTP id ada2fe7eead31-7d6ba43ebc0mr1873249137.26.1795036189080;
 Wed, 18 Nov 2026 13:09:49 -0800 (PST)
Date: Wed, 18 Nov 2026 21:09:33 +0000
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
Message-ID: <20261118210933.2477423-3-thaisonphan@google.com>
Subject: [PATCH net v4 2/2] tcp: accecn: initialize AccECN fields in syncookie path
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

cookie_tcp_reqsk_alloc() and bpf_sk_assign_tcp_reqsk() allocate struct
request_sock without __GFP_ZERO, leaving saw_accecn_opt,
accecn_fail_mode, syn_ect_rcv, and syn_ect_snt uninitialized. When
accecn_ok is negotiated in cookie_{v4,v6}_check(),
tcp_ecn_openreq_child() reads all four fields to initialize the child
socket's AccECN state.

In addition, because the temporary request_sock used to send a cookie
SYN-ACK is immediately freed, treq->syn_ect_snt is lost. For AccECN
connections where the listener marks ECT on the SYN-ACK, leaving
syn_ect_snt as 0 causes tcp_accecn_third_ack() to see a mismatch between
the expected Not-ECT and the peer's reflected ECT in the ACE field,
erroneously flagging TCP_ACCECN_ACE_FAIL_RECV in accecn_fail_mode. Refer
to Table 4 of RFC 9768 for more details.

Initialize the AccECN fields in cookie_tcp_reqsk_init() to match
tcp_openreq_init(). For kernel-generated cookies (!req->syncookie), set
syn_ect_snt from the listener's TOS/tclass in cookie_{v4,v6}_check() to
match tcp_{v4,v6}_send_synack(); for BPF custom syncookies
(req->syncookie), leave syn_ect_snt at 0 (Not-ECT) since the SYN-ACK was
built by the BPF program rather than the kernel and bpf_tcp_req_attrs
does not report the SYN-ACK ECN codepoint.

Found by AI-assisted code inspection comparing tcp_openreq_init() and
cookie_tcp_reqsk_init() while investigating the cookie_v6_check()
LOOPBACK4_IPV6 bug. Reproduced in a QEMU VM with tcp_syncookies=2,
tcp_ecn=3, SLUB_RCU_DEBUG=y, and slub_debug=P, observing bogus
tcpi_accecn_fail_mode and tcpi_accecn_opt_seen values in TCP_INFO on the
accepted child socket (and tcpi_accecn_fail_mode=0x2 on ECT(0)
listeners), and tested with packetdrill AccECN and syncookie selftests.

Fixes: 3cae34274c79 ("tcp: accecn: AccECN negotiation")
Fixes: b40671b5ee58 ("tcp: accecn: AccECN option failure handling")
Signed-off-by: Thaison Phan <thaisonphan@google.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v4:
  - restore treq->syn_ect_snt = 0 in cookie_tcp_reqsk_init() and guard
    syn_ect_snt updates in cookie_{v4,v6}_check() with !req->syncookie
    for BPF custom syncookies; document in changelog (Sashiko,
    Eric Dumazet)
  - add Reviewed-by tag from Matthieu Baerts
v3: https://lore.kernel.org/netdev/20261117124710.1338951-3-thaisonphan@google.com/
  - clarify syn_ect_snt / tcp_accecn_third_ack() description for
    AccECN connections and reference RFC 9768 Table 4 (Chia-Yu Chang)
v2: https://lore.kernel.org/netdev/20261116023709.132684-3-thaisonphan@google.com/
  - drop redundant treq->syn_ect_snt = 0 in cookie_tcp_reqsk_init()
    (Eric Dumazet)
  - clarify how the bug was discovered and observed via TCP_INFO
    (Eric Dumazet)
  - add Reviewed-by tag from Eric Dumazet
v1: https://lore.kernel.org/netdev/20261114161248.3428695-3-thaisonphan@google.com/

 net/ipv4/syncookies.c | 7 +++++++
 net/ipv6/syncookies.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 4e0ff3b82062..89169c82431c 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -290,6 +290,10 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 	 */
 	treq->txhash = treq->snt_isn;
 	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
+	treq->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
+	treq->accecn_fail_mode = 0;
+	treq->syn_ect_rcv = 0;
+	treq->syn_ect_snt = 0;
 
 #if IS_ENABLED(CONFIG_MPTCP)
 	treq->is_mptcp = sk_is_mptcp(sk);
@@ -502,6 +506,9 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 		ireq->rcv_wscale = rcv_wscale;
 	ireq->ecn_ok &= cookie_ecn_ok(net, &rt->dst);
 	treq->accecn_ok = ireq->ecn_ok && cookie_accecn_ok(th);
+	/* SYN-ACK was not sent by the kernel if req->syncookie is set. */
+	if (!req->syncookie)
+		treq->syn_ect_snt = READ_ONCE(inet_sk(sk)->tos) & INET_ECN_MASK;
 
 	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst);
 	/* ip_queue_xmit() depends on our flow being setup
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index b33011b71fff..e8d45a627ca2 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -276,6 +276,9 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		ireq->rcv_wscale = rcv_wscale;
 	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
 	tcp_rsk(req)->accecn_ok = ireq->ecn_ok && cookie_accecn_ok(th);
+	/* SYN-ACK was not sent by the kernel if req->syncookie is set. */
+	if (!req->syncookie)
+		tcp_rsk(req)->syn_ect_snt = READ_ONCE(np->tclass) & INET_ECN_MASK;
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst);
 	if (!ret) {
-- 
2.56.1.831.g720f3f5937-goog

