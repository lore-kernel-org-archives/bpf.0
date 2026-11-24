Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533182;
	b=C6Hpa/wIiB5FPYxVQTqqwD4/agV1t2k1ftKgBnTNMlw8/lgCOf30MdfW99e0Y6KMZuoQ
	 u/h0/nHqlTMxUqadMoSMxrElYzqeP9mdIxZxT5GpL08v7qfMet7j04hLvjth0Zrm1R6yA
	 6HjJ9KpXW8YJE7dNhm0MK66PaulUrjeyCrkrEZz7Jnm11lR8Wgms8gsyzAwjkZbCRm5Hq
	 LEQgfP41Vlt2RTPzuB4w97pUfVGFhjbi7aJkk8sdkR7MAHJR7Ld1ylIXBgy+SE+zmSnfv
	 u7K8WCi3cI58dkKCmFoiJXouSBMmV9zxwPyHnNBSROJDIRM+5a0+37AmGjkNQm/pvjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lmsH11/9DkTlIQ6/VeThZwrNe3KS4D5hoTSxGmm1QUg=;
	b=Y8Xpt1uvHcuzqN+/laQ8iip7HcnDj1NpYiM7PMCJRrpQy5xtsrX5SEkzhQJvoV+bxDF5
	 0DKe0zpEFBH+ravFpVLQ2S6T6V7skj011ORc9so/26FUgkNkL9W5KBfsIcUvRI33ACi5y
	 wXH5ma7/5kfoVePxulWch1CqsVbhueOaj+v7/RJASEKg1re2WED4cSZPILZpiM0kwRfRB
	 gExc49qXb/9ypzZVnlXdxf6uUZ2/kCLvDL4En5xTqyw0XiwmPeRlr1sC8EFLeAT29ljoV
	 BU8/L5h8kMVF7ROqwA7aY1r9IzeXQNontHAirVO7DzejnG2ym0X0jRS1dSNaJMThTYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=OnTlYDJ7;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D5606A32C
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A8D5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=OnTlYDJ7
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso2683509f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 07:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795533180; x=1796137980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lmsH11/9DkTlIQ6/VeThZwrNe3KS4D5hoTSxGmm1QUg=;
        b=OnTlYDJ7PbcIKV8JLOGSwV+u3z3kCJF/LuK2QXbopoQg/k5OHls8DopNe6yrnmaMDr
         SXRRjqMezM7zdzApO3pOAYkKaEpEfJu021LK3lFk3yxS6+lDZuQ7ZlobsRp+FxZ5zOqR
         eapRxxvY8rWyzAIkpk0b2RtAn4lp3BHVdbEYQvj+KQlGMnDJD+Ei04R0jo2oMlAO8+NH
         zsXAOEk3b1F1wH9FQQSGCxKUyknmXGIJTuM+rUOLzo3CaBNQ/IqUW53TYpE+8tb8UFG6
         wHkMCwugZ42wY4cihIZXQSPzQlr2MVniqOhonS9t52nqrXqHoVHbwp/7iPHYiAZwaxMt
         SWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795533180; x=1796137980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lmsH11/9DkTlIQ6/VeThZwrNe3KS4D5hoTSxGmm1QUg=;
        b=Qc/V7VwIjmPJ83XI54m+0f77ejPyYBqK6T4KGcoAKbmXPzNep3IctdB8mOFBqona3i
         PyDAwC9nRBzuz2hr0HK5aAZKqj6jpYuvSTFyCmm3vkf/6l4ttMW2bFYKDcKnlHHCaqgY
         fgpx64OQK9d3M9ivqba2VJJDhYWaOrHmY+bnNTerWqaNxbk1J3F/HKFDDxJ2m293IYyu
         63tGiRgLEgpbehoO4DGBIe4SfeGsNEybtwgfwaWeVimtHsDZY7ozPIHlGlFX7rxc5B2a
         2FoRpbNigNtuH8oyDjFhjWggiZ4Kcs8lvEzRWoeEdaqLoGr99PWWU11iwYhJJKzjbsfc
         wGxQ==
X-Gm-Message-State: APuU4Z9yxrJDL8TJTbD3ufL6HEUBeNzcA8trFsZW7idxTddrJ/AKEnMW
	5nL6TRmW2/z+dlngPkiMndYBg9PR2pn0aTykYldqxeb/nw+NN/VlyYb9R0Pz7ndCHgvTgOH2W4G
	vE3eXat/uOQ==
X-Gm-Gg: AZFdTZeisqqbQt0cay13/MC4jspGoPPN4BYuULaTsyDNr/CaSqAaC2qc7NmjFAf177c
	nAMvdacST/jy9MIt5UMqqu0eTNg9lck8qrmxpWEXvVLYmX9tKa2xaCFgFtsI+uwnDhPiGcif/eD
	FaB7vYwmXsyT6Q6k/+rwVhpyY6r6O1WpqJmFeHYwb8bljK23MnffzOS4ESKlIpFkjYEgkWaFesS
	/n8xBpd+s34yivmmTtnIQFAQegxqnZk1/T1sxHjdsj9di+SLplL98pZoMfEVZ/jl0zP1GXhwy9i
	yRvM8S5IWpBm9O/w12Q83Ve2lup+ngmOacY94NiRsW9C4Q6IfRmaVU99zCVGFYK7Dy+pFo1aTby
	hbM1AN/e6mTAblv7HQQr2MNnv6b9pqt4YTpD/GL601oifV32+8pPYu++4oAA+RJBEFJO8lI7Wk9
	quN0Qr+Zn5aINIfXelxffg5+d9RgmXOYul3E6X4A6z/hPM5BFCVqDsIEl9t0Eh+qBVIPJVKeD2l
	Cko4n/VkkM/c6YoDmJsyWqT1aNbC5wm88FTwIRvJr0rtZRMgO1mJuXIcmR1M+aLN/E/RIzXVlPO
	sz2OiEx0ofFwQK91AfM0yrFVCCVE7NNagBgtugPm7l5IiHKc7SlUvpoB85YiQDAwWEwWrZjA
X-Received: by 2002:a05:6000:111:b0:490:71a7:6f51 with SMTP id ffacd0b85a97d-4abb4c7aab0mr22220450f8f.45.1795533179678;
        Tue, 24 Nov 2026 07:12:59 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6b2052c8sm28719088f8f.41.2026.11.24.07.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:12:59 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH RFC bpf-next 1/4] net: track references owned by prefetched socket assignments
Date: Tue, 24 Nov 2026 17:12:41 +0200
Message-ID: <20261124151244.1423343-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124151244.1423343-1-razor@blackwall.org>
References: <20261124151244.1423343-1-razor@blackwall.org>
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

Add sock_pfree_ref for skb-owned references whose release mustn't depend on
SOCK_RCU_FREE. Teach receive lookup, NFQUEUE and reuseport selection to
preserve and transfer this ownership.

A following patch lets netkit programs assign sockets. The skb is then
queued to the backlog before the receive path consumes the socket so a
borrowed RCU reference isn't enough and the skb must own a reference.

The reference must be on a full socket. skb_steal_sock returns the
listener of a syncookie request socket before it looks at the
destructor so a reference taken on such a request socket would leak.
DEBUG_NET builds warn if sock_pfree_ref meets a socket that is not
full either there or when the skb is freed.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/net/inet6_hashtables.h | 10 +++++++---
 include/net/inet_hashtables.h  | 10 +++++++---
 include/net/request_sock.h     | 10 +++++++---
 include/net/sock.h             |  4 +++-
 net/core/sock.c                |  7 +++++++
 net/netfilter/nf_queue.c       | 16 +++++++---------
 6 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 2cc5d416bbb5..e461a86f8eaf 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -134,10 +134,14 @@ struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	if (!reuse_sk)
 		return sk;
 
-	/* We've chosen a new reuseport sock which is never refcounted. This
-	 * implies that sk also isn't refcounted.
+	/* netkit bpf assignment holds a reference on the prefetched
+	 * socket and reuseport returns an rcu protected socket so if it
+	 * differs we have to release the original reference
 	 */
-	WARN_ON_ONCE(*refcounted);
+	if (reuse_sk != sk && *refcounted) {
+		sock_put(sk);
+		*refcounted = false;
+	}
 
 	return reuse_sk;
 }
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 44b7e39a1245..d4dd9c3487d8 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -476,10 +476,14 @@ struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	if (!reuse_sk)
 		return sk;
 
-	/* We've chosen a new reuseport sock which is never refcounted. This
-	 * implies that sk also isn't refcounted.
+	/* netkit bpf assignment holds a reference on the prefetched
+	 * socket and reuseport returns an rcu protected socket so if it
+	 * differs we have to release the original reference
 	 */
-	WARN_ON_ONCE(*refcounted);
+	if (reuse_sk != sk && *refcounted) {
+		sock_put(sk);
+		*refcounted = false;
+	}
 
 	return reuse_sk;
 }
diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index faa6dc49cea8..72fdbf0dccbc 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -103,21 +103,25 @@ static inline struct sock *skb_steal_sock(struct sk_buff *skb,
 	}
 
 	*prefetched = skb_sk_is_prefetched(skb);
+	*refcounted = true;
+#ifdef CONFIG_INET
 	if (*prefetched) {
 #if IS_ENABLED(CONFIG_SYN_COOKIES)
 		if (sk->sk_state == TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie) {
 			struct request_sock *req = inet_reqsk(sk);
 
+			DEBUG_NET_WARN_ON_ONCE(skb->destructor ==
+					       sock_pfree_ref);
 			*refcounted = false;
 			sk = req->rsk_listener;
 			req->rsk_listener = NULL;
 			return sk;
 		}
 #endif
-		*refcounted = sk_is_refcounted(sk);
-	} else {
-		*refcounted = true;
+		*refcounted = skb->destructor == sock_pfree_ref ||
+			      sk_is_refcounted(sk);
 	}
+#endif
 
 	skb->destructor = NULL;
 	skb->sk = NULL;
diff --git a/include/net/sock.h b/include/net/sock.h
index 3144efad8c36..33cc361e941f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1874,6 +1874,7 @@ void sock_efree(struct sk_buff *skb);
 #ifdef CONFIG_INET
 void sock_edemux(struct sk_buff *skb);
 void sock_pfree(struct sk_buff *skb);
+void sock_pfree_ref(struct sk_buff *skb);
 
 static inline void skb_set_owner_edemux(struct sk_buff *skb, struct sock *sk)
 {
@@ -3034,7 +3035,8 @@ static inline bool
 skb_sk_is_prefetched(struct sk_buff *skb)
 {
 #ifdef CONFIG_INET
-	return skb->destructor == sock_pfree;
+	return skb->destructor == sock_pfree ||
+	       skb->destructor == sock_pfree_ref;
 #else
 	return false;
 #endif /* CONFIG_INET */
diff --git a/net/core/sock.c b/net/core/sock.c
index ad414878dc5b..11d5d221a2fe 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2871,6 +2871,13 @@ void sock_pfree(struct sk_buff *skb)
 	sock_gen_put(sk);
 }
 EXPORT_SYMBOL(sock_pfree);
+
+void sock_pfree_ref(struct sk_buff *skb)
+{
+	DEBUG_NET_WARN_ON_ONCE(!sk_fullsock(skb->sk));
+	sock_gen_put(skb->sk);
+}
+EXPORT_SYMBOL(sock_pfree_ref);
 #endif /* CONFIG_INET */
 
 /*
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index bd603e3a99a5..d920a67b6fa0 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -195,17 +195,15 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 		break;
 	}
 
-	if (skb_sk_is_prefetched(skb)) {
-		struct sock *sk = skb->sk;
-
-		if (!sk_is_refcounted(sk)) {
-			if (!refcount_inc_not_zero(&sk->sk_refcnt))
-				return -ENOTCONN;
+#ifdef CONFIG_INET
+	if (skb->destructor == sock_pfree && !sk_is_refcounted(skb->sk)) {
+		if (!refcount_inc_not_zero(&skb->sk->sk_refcnt))
+			return -ENOTCONN;
 
-			/* drop refcount on skb_orphan */
-			skb->destructor = sock_edemux;
-		}
+		/* drop refcount on skb_orphan */
+		skb->destructor = sock_edemux;
 	}
+#endif
 
 	entry = kmalloc(sizeof(*entry) + route_key_size, GFP_ATOMIC);
 	if (!entry)
-- 
2.47.3

