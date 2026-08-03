Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E33BE16C
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747716; cv=none; b=ATrOIzkHVJ00Yedl3E1Jx2C3HibYT4/2ZXkTCnmPwPJ5+zZrR1J1Jj1bqC6808o+uuoSWPa7ZgGZS4kaaHDQzxCbzT6+ANShyxQVMzhDA7Z0YPg+SIMHKr3EhKEt348j1ux08e1l7+cdvb3ex3wQiAvumKa3UgMGgeuwqM2HsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747716; c=relaxed/simple;
	bh=52iuD3i7TRN4nBU/20dqpqs3iGShQDt+XaFa/feofZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YmWLUzL+sOMfYMng6KimVdUI4tLrOCr60osxs3L0ns6l5l4e9sqzrVc6JCMr3JPLw8+or5cC5fYUolxkqBCnKk6J6EMfawzOLnPkuU9veVkmB4zD8RZD61mhkztu7QPF5k42XAJJLmlxmHeA1/FA05pPzEsH9KE+Z60Ye8/N8/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=KS4U5oJw; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="KS4U5oJw"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wqoYE-003g9E-A5; Mon, 03 Aug 2026 11:01:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=gEL7vrretHDhWO9eEJSfhdss43QrZ/6YR3FxQETnLjY=; b=KS4U5oJw5WzBNCffDf/Y7782E3
	8J87X9/mfUQNzfgZflruji669E8nBv0WIpbk4J1i/rx+CTTJwTbTOrmqd+g56xTk6NXYnrUyHek5k
	8giywGWK6lxKEwsXwN0ZNljeYoiChrquTu9F4/X6WKfXhXqCnQqV94e7XDaFoPyXuQbVQKE4BNcE2
	KY8Tc3X4n8/BqraDcPVUMUGZfammxjtlrRVdqmUIyEIogNamTeXIGknRhEQPQmgm7RAEsAG7z1mju
	4z3uN03KyFH5XWbIUDAAvi+YlwqmU6SzzxuoDkNt/9YXx9q4VV3rWVP4EHVVkKuN7gRUzh3aQbcqO
	8inBhKrA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wqoYD-0003xn-Pd; Mon, 03 Aug 2026 11:01:38 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wqoXu-00GDCj-CY;
	Mon, 03 Aug 2026 11:01:18 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 03 Aug 2026 11:00:43 +0200
Subject: [PATCH bpf v2 2/2] bpf: Unconditionally take socket references in
 lookup helpers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co>
References: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
In-Reply-To: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, Joe Stringer <joe@wand.net.nz>
Cc: Michal Luczaj <mhal@rbox.co>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
TC bpf_sk_assign() has the same issue; it takes a reference only when
sk_is_refcounted() is true at assign time, but sock_pfree() (the skb
destructor it installs) re-checks sk_is_refcounted() independently at
release time. The same connect(AF_UNSPEC)+listen() transition leaks the
socket here too. I'd welcome suggestions on the right way to handle this.
---
 net/core/filter.c   | 27 ++++++++++++++++++---------
 net/core/sock_map.c |  4 ++--
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index fede810ef37f..d71e069f669a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7032,6 +7032,14 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 		WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
 		sk = NULL;
 	}
+
+	/*
+	 * Always take a reference, even if the lookup skipped one;
+	 * bpf_sk_release() always puts one.
+	 */
+	if (sk && !refcounted && !refcount_inc_not_zero(&sk->sk_refcnt))
+		sk = NULL;
+
 	return sk;
 }
 
@@ -7090,11 +7098,16 @@ bpf_sk_lookup_full_sk(struct sock *sk)
 	 */
 	if (sk2 != sk) {
 		sock_gen_put(sk);
-		/* Ensure there is no need to bump sk2 refcnt. */
 		if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
 			WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
 			return NULL;
 		}
+		/*
+		 * sk2 is RCU-free, but take a reference anyway;
+		 * bpf_sk_release() puts.
+		 */
+		if (sk2 && !refcount_inc_not_zero(&sk2->sk_refcnt))
+			sk2 = NULL;
 		sk = sk2;
 	}
 
@@ -7279,7 +7292,7 @@ static const struct bpf_func_proto bpf_tc_sk_lookup_udp_proto = {
 
 BPF_CALL_1(bpf_sk_release, struct sock *, sk)
 {
-	if (sk && sk_is_refcounted(sk))
+	if (sk)
 		sock_gen_put(sk);
 	return 0;
 }
@@ -11571,11 +11584,13 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
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
@@ -11605,13 +11620,7 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
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
index 9efbd8ca7db8..92a006fd3368 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -392,7 +392,7 @@ static void *sock_map_lookup(struct bpf_map *map, void *key)
 	sk = __sock_map_lookup_elem(map, *(u32 *)key);
 	if (!sk)
 		return NULL;
-	if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt))
+	if (!refcount_inc_not_zero(&sk->sk_refcnt))
 		return NULL;
 	return sk;
 }
@@ -1218,7 +1218,7 @@ static void *sock_hash_lookup(struct bpf_map *map, void *key)
 	sk = __sock_hash_lookup_elem(map, key);
 	if (!sk)
 		return NULL;
-	if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt))
+	if (!refcount_inc_not_zero(&sk->sk_refcnt))
 		return NULL;
 	return sk;
 }

-- 
2.55.0

