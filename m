Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB642BC2B;
	Thu, 23 Jul 2026 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806467; cv=none; b=lt6BhJt0B1Hld0qyvXpCJPRC9t/OYS2t2S5IlSUwOHgnKV6+vlGIwcmil7wBPdsm7f4KFoWXq4TSX+wXih2UogReOvnguZzUOlaelGpirccjFQvKoTCreiG5MLpYIkkFjhnNkhhqtKKGatNWSdK8Vn1mF2sMTADnwtjP8yA5XWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806467; c=relaxed/simple;
	bh=5zsJURl3gkFpfGTzJNX0BHG29S9pjPdFCEagmTkgvXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=moCQ19y9Khp3a6E1oeO/Wvi5u46S8ECaHulkYIyIMVAHzUa37N1aHKz7NX1oZyDIq/VZwJLDFPFYhAQSw9F9OJ4VFQLhAyh2sBApxJLu0AAJDZom2W+qulGpNJw83ZRM7Fqcj/dwCCW16bIKTLSKXPGO1cLXxdDOQVrn4Up3tKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=PI2FIzK2; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="PI2FIzK2"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wmrgo-007G5Y-Gu; Thu, 23 Jul 2026 13:34:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=k7p+B/COPdonMnN0TNVDcPtVKw0DyjIEi9WHuqqWM5g=; b=PI2FIzK2OkgIBWyRuzNq4muSse
	XTq2QI7XP15D001zM5pCLVGQI0FU+5up0G17a0hUvM8HPlBYHT4wdGPFhx8XFymXhNmwjANeMZ+aa
	lLRMTDBnzA+VPAHi85hHYBEvkVAPOQOobZG9uMQi1mw9uCFO7B+3zxRo7oH0mgmmxB4gD7d9dNxcR
	/9zUJMvxA3oiBhvJKhgcc5nuQcCLxJiQoGkMDsLd12qpFyuhbMrWlv7X/Fn7ZehY3aayMulBdc+0U
	tZECP7r6nA9H0JfMQmEmYvZm6NTCkHdv2leN1n1J9NduzJy43A22ojwv+oH66R0/G1trsamozoPVh
	eon7HTqw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wmrgm-00079p-AE; Thu, 23 Jul 2026 13:34:08 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wmrgX-0060aI-HC;
	Thu, 23 Jul 2026 13:33:53 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 23 Jul 2026 13:33:29 +0200
Subject: [PATCH bpf 3/3] bpf: Unconditionally take socket references in
 lookup helpers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-sockmap-lookup-tcp-leak-v1-3-1bbdc58ce514@rbox.co>
References: <20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co>
In-Reply-To: <20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Joe Stringer <joe@wand.net.nz>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2

Lookup helpers gate whether to acquire a socket reference on
sk_is_refcounted(), a check re-evaluated at release. An established socket
refcounted at acquire time can gain SOCK_RCU_FREE via
connect(AF_UNSPEC)+listen() before release runs; the release-side re-check
then reads sk_is_refcounted() == false and skips the put. The reference
leaks.

Make acquire and release unconditional and symmetric: always take a
reference, always put it. Adapt sk_select_reuseport().

Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
Fixes: 64d85290d79c ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.kernel.org/
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/filter.c   | 25 ++++++++++++++++---------
 net/core/sock_map.c |  8 ++------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 403aba3ce891..4bc0b59668fa 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7027,6 +7027,13 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 		WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
 		sk = NULL;
 	}
+
+	/* Always take a reference, even if the lookup skipped one;
+	 * bpf_sk_release() always puts one.
+	 */
+	if (sk && !refcounted && !refcount_inc_not_zero(&sk->sk_refcnt))
+		sk = NULL;
+
 	return sk;
 }
 
@@ -7084,11 +7091,15 @@ bpf_sk_lookup_full_sk(struct sock *sk)
 	 */
 	if (sk2 != sk) {
 		sock_gen_put(sk);
-		/* Ensure there is no need to bump sk2 refcnt. */
 		if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
 			WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
 			return NULL;
 		}
+		/* sk2 is RCU-free, but take a reference anyway;
+		 * bpf_sk_release() puts.
+		 */
+		if (sk2 && !refcount_inc_not_zero(&sk2->sk_refcnt))
+			sk2 = NULL;
 		sk = sk2;
 	}
 
@@ -7273,7 +7284,7 @@ static const struct bpf_func_proto bpf_tc_sk_lookup_udp_proto = {
 
 BPF_CALL_1(bpf_sk_release, struct sock *, sk)
 {
-	if (sk && sk_is_refcounted(sk))
+	if (sk)
 		sock_gen_put(sk);
 	return 0;
 }
@@ -11565,11 +11576,13 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
 	bool is_sockarray = map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY;
 	struct sock_reuseport *reuse;
 	struct sock *selected_sk;
-	int err;
+	int err = 0;
 
 	selected_sk = map->ops->map_lookup_elem(map, key);
 	if (!selected_sk)
 		return -ENOENT;
+	if (!is_sockarray)
+		sock_put(selected_sk);
 
 	reuse = rcu_dereference(selected_sk->sk_reuseport_cb);
 	if (!reuse) {
@@ -11599,13 +11612,7 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
 	}
 
 	reuse_kern->selected_sk = selected_sk;
-
-	return 0;
 error:
-	/* Lookup in sock_map can return TCP ESTABLISHED sockets. */
-	if (sk_is_refcounted(selected_sk))
-		sock_put(selected_sk);
-
 	return err;
 }
 
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index ca49bc7f8687..ae18dc4d60f9 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -390,9 +390,7 @@ static void *sock_map_lookup(struct bpf_map *map, void *key)
 	struct sock *sk;
 
 	sk = __sock_map_lookup_elem(map, *(u32 *)key);
-	if (!sk)
-		return NULL;
-	if (sk_is_refcounted(sk))
+	if (sk)
 		sock_hold(sk);
 	return sk;
 }
@@ -1216,9 +1214,7 @@ static void *sock_hash_lookup(struct bpf_map *map, void *key)
 	struct sock *sk;
 
 	sk = __sock_hash_lookup_elem(map, key);
-	if (!sk)
-		return NULL;
-	if (sk_is_refcounted(sk))
+	if (sk)
 		sock_hold(sk);
 	return sk;
 }

-- 
2.55.0

