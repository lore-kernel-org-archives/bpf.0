Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423392;
	b=BA4712elkFz9aBNfJCozcVgfzxWYcxN8k8hT/d4efUKyJeybIZuMYMqSAeBsMOEYfY77
	 oSt/oHOiW5SmcQtu11xZEN8F1dG9XO36d89IjccQNX0lQsALCHbv+gGLzlezR1QiBy49b
	 yT6T0GpopRVOeUgdEr4ziS8j0PMmcTDPWeKLL7bSC1JQnIXWJdRhIIcPlaigml+tClE2o
	 q8pGvn3P9vI3rj+49naMF9IH9DI01drX9DOlyUFj7gEsHgirasT+WwLJByODUDiIhPVUa
	 ZLPj2pGE3c6lJJPJrtlhodgRhGJTZeJEW1EABcIPuFWrXS9JvRxFeRlem7eLvh6uZLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CBIrGc2MWaw06JqurWdbfsggiM3MgsvPgye+6NxYKkg=;
	b=AKEPeuP8ldl8Xb0e8onNDdTaOmozgiCzgfdnBGEl0bRG9sLG7ZN3J5NanXP4yM2Kp1Nr
	 3ouuKGUCZQROpqRUWSqZ3daW9BBoFv7MLr4RyOaTe5ylZtTDwraP2Nk2s08g3Bfsy7EYi
	 QfNvy6/4hTjNUf10F+qhlzO7o4D+VDlQ/hqslAXQrbomezjIdRLh8i9YqEAPU8HLMu2aH
	 z39RyR/04FZjtleSaazZwq7fe5CMyFnfJmWj9P875gmdTlF/jmjxsWUWeCEb4xSo2CdcF
	 4LZojLNh9IsCTnDC2oGqYPoPk0sI3UOjbb1i00ZTst2n64y4Sez62V9ONrfxBF7zDww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=PCbUfyD+;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D273606A681
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 08:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D273606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=PCbUfyD+
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so28703135e9.2
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 00:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795423390; x=1796028190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CBIrGc2MWaw06JqurWdbfsggiM3MgsvPgye+6NxYKkg=;
        b=PCbUfyD+MzcMTzKGLZWc8UavbD3wRHmmyXEKWks6LSJMl04uxyKv+0JoDPE2YBevM7
         sBAXXz1Z7NZ3j2ZJLVKZEljOCcQVGSo/zHLcBFwEfTEvHHOc3584c62r6IqqRBj8Pvxx
         Xf1JC3znCULHUsbL8RhQl+cQy/4oepLo1k87y6BJb0gS5yh6OGxNALld+70vYygeVCxi
         WiaTQ7lMF2OZN/8s0B7Apy8h+25Uu/9qDgsYVPpU4AxQOolbnOWJNKLjqsPzhKw7nCJg
         6qjAI6YDPVYa6OFVf3Yf0EudtBKVZMpIU2kodBvDnL58zemQ8HGhUCtvx6hIAdl1YWdw
         Wjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795423390; x=1796028190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CBIrGc2MWaw06JqurWdbfsggiM3MgsvPgye+6NxYKkg=;
        b=v/XmjHx11HWCkF5mDmtcc8+zwqLEFXJ0nSscEKHsJ4tdqVcrSkDtVWWcWyjK15XZQ6
         X7Hu6oK+TOs7PuWg6znY1JE+8049j+9l/AsHYE40DfTjcutCUe5NgRWL6PRkP+2RJCyu
         sMgWHhGsNI9nv8Q0bw7xuL/k9drlByOgnxzgGkGrZt4jt0u0MoAoWkIUKoFwJa1YjJRw
         bHEpdQLU5+su9Q4g/j63E3YGqhKhLRrltcNTqXyKGD/Nk/wVMlcTysb8l7GyIr9o4Sa6
         BaI2S5WILLcMY4+qZbMopM7J0wWwdcHOnvwvOr+iIgLTO5ojvSzWVsq6pgOhP+KAphHc
         T0JA==
X-Gm-Message-State: APuU4Z8/TiHyTXACLUdkVT7StrfbEdQHz6bJhkumU9JKxFOuAGPDcQQF
	xyUyX7ksF+1hc/gGD1TFmXGybMQ4wYmaQUVEeNW9j5EZXMoCFMDcMyDIfRGCVBkVzWFN8wU+0YX
	/Jn7IaEVIJWYj
X-Gm-Gg: AZFdTZfvrZE5IjdJlyYLx7YfYbAPw7fubIYLxUvmu9AXSHXFqzS2mnskuxHnmGGRIGu
	bl8jvthowCdwo6zKXqF5q6H3GwxvunYs1oltXaZCU4C28aZ3TecdXavkmVXmb/foewpqQbNylLC
	Xj1sQy/rmGGM7zHCBYZF8kNGMzRRm5ZMtj3tlSuZsBmgNk9hkk/4hTlXBSaMPtHDDK9B7CS9tz1
	8+ux3P8mQ1OCBJMhS19AW4e2chChPOt25l5Gw6KCI+NOwBpS1d8pe23ZqLxNNtWIeZ3jizhmtIF
	4nrypaKzXuux7KqSX/YcPD29rPDiOgT2q8LD3Gxfvq3QO5wItqXCILV3PHNsASWDMZgSokJ+iEE
	6wRCGMDDL1tJxmcB7o6CnagUZtyTKLAHPSSWmlYk+hOEal91Cg6fB94EFUrYaT/U+e074IuhiaX
	e1LuVFGVSSLKD2E98NkbUJtnkLJU2d0fjvZDn+BAOCqDEA+vQLMfe65pxuHhrRdUrNawjdV+g+G
	BJAU3BE84J+qyx7OYkqOpK8hynE5DEeykwl0fcXSiNltZVcvm1eGGhOt2GlNx7GJbQlmcI8Dv5U
	t7/C9NIdR1BRJ1VYD9lUCX1n0SLrgORWjhcChE6xf/9gQFpOwspo
X-Received: by 2002:a05:600c:3547:b0:4a3:5991:718 with SMTP id 5b1f17b1804b1-4bb88809795mr221239065e9.16.1795423390381;
        Mon, 23 Nov 2026 00:43:10 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb8526cbd0sm437670855e9.0.2026.11.23.00.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:43:09 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf, net: validate assigned socket on receive
Date: Mon, 23 Nov 2026 10:41:37 +0200
Message-ID: <20261123084138.723275-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123084138.723275-1-razor@blackwall.org>
References: <20261123084138.723275-1-razor@blackwall.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_sk_assign accepts any hashed socket and the rx path uses it without
checking against the packet which can also be rewritten after the
assignment. A TCP socket can then reach UDP receive, AF_INET socket
IPv6 receive, a v6only AF_INET6 socket IPv4 receive etc. A queued skb can
also be delivered in another netns than the one checked at assignment, e.g.
after an rx_handler forwards it to an upper device there.

Check the socket where it is consumed: inet_steal_sock and
inet6_steal_sock take the protocol of the caller and drop a prefetched
socket on a mismatch. Like bpf_sk_lookup_assign, IPv4 also rejects v6only
sockets which tcp_v6_conn_request would otherwise accept through
tcp_v4_conn_request. A syncookie request socket left on the skb is released
as well.

The normal packet path is not affected: the checks run only after the
prefetched test and the protocol is a constant at every call site. The
full socket test before the listener test is dropped as only TCP accepts
request and time wait sockets and they are never TCP_LISTEN. The release
of a mismatched socket is intentionally out of line, when inlined it adds
~220 bytes to each of tcp_v4_rcv, tcp_v6_rcv, udp_rcv and udpv6_rcv on
x86_64 for a path only a bad assignment takes.

Tested on v7.4-rc3 with KASAN: a tcx ingress program on a veth assigned
a tcp listener to an IPv4 udp datagram and udp receive used it:

  BUG: KASAN: null-ptr-deref in __udp_enqueue_schedule_skb+0x173/0x1300
  Read of size 4 at addr 0000000000000008 by task test_progs/88
  __udp_enqueue_schedule_skb (net/ipv4/udp.c:1697)
  udp_queue_rcv_one_skb (net/ipv4/udp.c:2365 net/ipv4/udp.c:2455)
  udp_unicast_rcv_skb (net/ipv4/udp.c:2627)
  udp_rcv (net/ipv4/udp.c:2687)
  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:209)
  Kernel panic - not syncing: Fatal exception in interrupt

The problem was found during review of bpf_sk_assign egress support
patch-set.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@google.com>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Martin KaFai Lau <kafai@fb.com>
CC: Alexei Starovoitov <ast@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: John Fastabend <john.fastabend@gmail.com>
CC: netdev@vger.kernel.org

 include/net/inet6_hashtables.h | 33 +++++++++++++++++++++++++--------
 include/net/inet_hashtables.h  | 34 ++++++++++++++++++++++++++--------
 include/net/inet_sock.h        |  2 ++
 net/ipv4/inet_hashtables.c     | 13 +++++++++++++
 net/ipv4/udp.c                 |  2 +-
 net/ipv6/udp.c                 |  2 +-
 6 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 2cc5d416bbb5..9733d5b84bda 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -102,11 +102,23 @@ static inline struct sock *__inet6_lookup(const struct net *net,
 				     daddr, hnum, dif, sdif);
 }
 
+static inline bool inet6_prefetched_sk_mismatch(const struct sock *sk,
+						const struct net *net,
+						u8 protocol)
+{
+	if (unlikely(sk->sk_family != AF_INET6 || !net_eq(sock_net(sk), net)))
+		return true;
+	if (!sk_fullsock(sk))
+		return unlikely(protocol != IPPROTO_TCP);
+	return unlikely(sk->sk_protocol != protocol);
+}
+
 static inline
 struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 			      const struct in6_addr *saddr, const __be16 sport,
 			      const struct in6_addr *daddr, const __be16 dport,
-			      bool *refcounted, inet6_ehashfn_t *ehashfn)
+			      bool *refcounted, inet6_ehashfn_t *ehashfn,
+			      u8 protocol)
 {
 	struct sock *sk, *reuse_sk;
 	bool prefetched;
@@ -115,16 +127,16 @@ struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	if (!sk)
 		return NULL;
 
-	if (!prefetched || !sk_fullsock(sk))
+	if (!prefetched)
 		return sk;
 
-	if (sk->sk_protocol == IPPROTO_TCP) {
+	if (unlikely(inet6_prefetched_sk_mismatch(sk, net, protocol)))
+		goto mismatch;
+
+	if (protocol == IPPROTO_TCP) {
 		if (sk->sk_state != TCP_LISTEN)
 			return sk;
-	} else if (sk->sk_protocol == IPPROTO_UDP) {
-		if (sk->sk_state != TCP_CLOSE)
-			return sk;
-	} else {
+	} else if (sk->sk_state != TCP_CLOSE) {
 		return sk;
 	}
 
@@ -140,6 +152,11 @@ struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	WARN_ON_ONCE(*refcounted);
 
 	return reuse_sk;
+
+mismatch:
+	inet_prefetched_sk_release(skb, sk, *refcounted);
+	*refcounted = false;
+	return NULL;
 }
 
 static inline struct sock *__inet6_lookup_skb(struct sk_buff *skb, int doff,
@@ -153,7 +170,7 @@ static inline struct sock *__inet6_lookup_skb(struct sk_buff *skb, int doff,
 	struct sock *sk;
 
 	sk = inet6_steal_sock(net, skb, doff, &ip6h->saddr, sport, &ip6h->daddr, dport,
-			      refcounted, inet6_ehashfn);
+			      refcounted, inet6_ehashfn, IPPROTO_TCP);
 	if (IS_ERR(sk))
 		return NULL;
 	if (sk)
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 44b7e39a1245..ad8a7af17ddb 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -444,11 +444,24 @@ static inline struct sock *inet_lookup(struct net *net,
 	return sk;
 }
 
+static inline bool inet_prefetched_sk_mismatch(const struct sock *sk,
+					       const struct net *net,
+					       u8 protocol)
+{
+	if (unlikely(!net_eq(sock_net(sk), net)))
+		return true;
+	if (!sk_fullsock(sk))
+		return unlikely(protocol != IPPROTO_TCP);
+	return unlikely(sk->sk_protocol != protocol ||
+			(sk->sk_family == AF_INET6 && ipv6_only_sock(sk)));
+}
+
 static inline
 struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 			     const __be32 saddr, const __be16 sport,
 			     const __be32 daddr, const __be16 dport,
-			     bool *refcounted, inet_ehashfn_t *ehashfn)
+			     bool *refcounted, inet_ehashfn_t *ehashfn,
+			     u8 protocol)
 {
 	struct sock *sk, *reuse_sk;
 	bool prefetched;
@@ -457,16 +470,16 @@ struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	if (!sk)
 		return NULL;
 
-	if (!prefetched || !sk_fullsock(sk))
+	if (!prefetched)
 		return sk;
 
-	if (sk->sk_protocol == IPPROTO_TCP) {
+	if (unlikely(inet_prefetched_sk_mismatch(sk, net, protocol)))
+		goto mismatch;
+
+	if (protocol == IPPROTO_TCP) {
 		if (sk->sk_state != TCP_LISTEN)
 			return sk;
-	} else if (sk->sk_protocol == IPPROTO_UDP) {
-		if (sk->sk_state != TCP_CLOSE)
-			return sk;
-	} else {
+	} else if (sk->sk_state != TCP_CLOSE) {
 		return sk;
 	}
 
@@ -482,6 +495,11 @@ struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	WARN_ON_ONCE(*refcounted);
 
 	return reuse_sk;
+
+mismatch:
+	inet_prefetched_sk_release(skb, sk, *refcounted);
+	*refcounted = false;
+	return NULL;
 }
 
 static inline struct sock *__inet_lookup_skb(struct sk_buff *skb,
@@ -496,7 +514,7 @@ static inline struct sock *__inet_lookup_skb(struct sk_buff *skb,
 	struct sock *sk;
 
 	sk = inet_steal_sock(net, skb, doff, iph->saddr, sport, iph->daddr, dport,
-			     refcounted, inet_ehashfn);
+			     refcounted, inet_ehashfn, IPPROTO_TCP);
 	if (IS_ERR(sk))
 		return NULL;
 	if (sk)
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 24cbabc24582..840ec8495f51 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -403,6 +403,8 @@ static inline unsigned int __inet_ehashfn(const __be32 laddr,
 struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
 				      struct sock *sk_listener,
 				      bool attach_listener);
+void inet_prefetched_sk_release(struct sk_buff *skb, struct sock *sk,
+				bool refcounted);
 
 static inline __u8 inet_sk_flowi_flags(const struct sock *sk)
 {
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 860145d810ed..fbd0e0e67798 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -521,6 +521,19 @@ void sock_gen_put(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(sock_gen_put);
 
+/* release a prefetched socket that won't be used, drop the reference
+ * on @sk if @refcounted is set and orphan the skb to release any socket
+ * still attached to it (e.g. bpf syncookie request sock)
+ */
+void inet_prefetched_sk_release(struct sk_buff *skb, struct sock *sk,
+				bool refcounted)
+{
+	if (refcounted)
+		sock_gen_put(sk);
+	skb_orphan(skb);
+}
+EXPORT_SYMBOL_GPL(inet_prefetched_sk_release);
+
 void sock_edemux(struct sk_buff *skb)
 {
 	sock_gen_put(skb->sk);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2e5562f353f8..6841e447a14f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2673,7 +2673,7 @@ int udp_rcv(struct sk_buff *skb)
 		goto csum_error;
 
 	sk = inet_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh->source, daddr, uh->dest,
-			     &refcounted, udp_ehashfn);
+			     &refcounted, udp_ehashfn, IPPROTO_UDP);
 	if (IS_ERR(sk))
 		goto no_sk;
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index a6886a0432f9..f51f2495f103 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1116,7 +1116,7 @@ INDIRECT_CALLABLE_SCOPE int udpv6_rcv(struct sk_buff *skb)
 
 	/* Check if the socket is already available, e.g. due to early demux */
 	sk = inet6_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh->source, daddr, uh->dest,
-			      &refcounted, udp6_ehashfn);
+			      &refcounted, udp6_ehashfn, IPPROTO_UDP);
 	if (IS_ERR(sk))
 		goto no_sk;
 
-- 
2.47.3

