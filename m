Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C8477E2A;
	Thu, 13 Aug 2026 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786624962; cv=none; b=UZBlNMMCMbcLNqoxMlR16a6iszTXAN+qRG1RGnNY2M9urU2wLT73/MP69wWE3r0aseaZhKEsFfTrkc3gst6CQnpB6bNY00IMNotBCik6Vxk3Khamnh1X+cSHuLOo+MOLq4zSXOeDMC8dh/N+sy76mdwXROsRqjrLM3HYkwb+i6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786624962; c=relaxed/simple;
	bh=MAyIhd4OTujjRAk3w4qWF6gNgHtM5mq9HxniGAv8O8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gR5/9XN4vI6xvtQkoqMjz5dcJqCTEdWcNBoDinpIWUJvpR3V8Xm9VN+kVUy7kg3V+GG0C4R5qM8rDQ9jISka+ntjYMCnDHQ1/ii22CniZVDkbOJQCzEhX8+TJM2IjQ/vy5BpvLAr3Xp8gZ+VDB+OczlVAbUMoytDQdAm/szv5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=BvY+8UrP; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="BvY+8UrP"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wuUlR-0037N5-JE; Thu, 13 Aug 2026 14:42:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=neIBxG1dO3Dd/8acsToTT3/rHql4H8HTe+mfnp9NxW0=; b=BvY+8UrPcxOAHxci4q5DjfXYnJ
	MXYPtjbA7s1GvqehbHabnLmzUyspJjoq08fdrp+O3Q1RjO05ydQfMBCkNjCRAMh9xZblx4tluzQg7
	COelmUh4pU02a0JsSWVbV8TVe5Rx0QUNoTpXUzwnTRYQ4Je2YTdNyoFE8URNNdW2A4Tk0/bwP4y6X
	bWPDh+CAiELKjNwIL089od3nwIeRGNsQRuf4U4boaLHaWfcg7P0veZHr6AADGU29d4vUQiy7g4pdK
	72gWzHs76ejBtsFrKqouXG+XJUqnm4AvcUVZUCrcFrFB/j+YLC0+il3ZWIqlR/oPv/dQPVpnHs1Qy
	2HAeEvfA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wuUlQ-0007Dx-U0; Thu, 13 Aug 2026 14:42:28 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wuUlE-001YW5-PS;
	Thu, 13 Aug 2026 14:42:16 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 13 Aug 2026 14:41:59 +0200
Subject: [PATCH bpf-next 1/2] bpf: Extract shared reqsk-to-listener upgrade
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-sockmap-lookup-get-ref-v1-1-31f5d55f44ac@rbox.co>
References: <20260813-sockmap-lookup-get-ref-v1-0-31f5d55f44ac@rbox.co>
In-Reply-To: <20260813-sockmap-lookup-get-ref-v1-0-31f5d55f44ac@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

__bpf_sk_lookup() and bpf_sk_lookup() duplicate the same sk_to_full_sk()
reqsk-to-listener upgrade. Extract it into a helper.

Leave the currently unreachable WARN_ONCE as a defensive assert.

No functional change.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/filter.c | 58 +++++++++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3423734124a5..031fb2aad792 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7167,6 +7167,28 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 	return sk;
 }
 
+static struct sock *
+bpf_sk_lookup_full_sk(struct sock *sk)
+{
+	struct sock *sk2 = sk_to_full_sk(sk);
+
+	/*
+	 * sk_to_full_sk() may return sk->rsk_listener, make sure the original
+	 * sk sock refcnt is decremented to prevent a request_sock leak.
+	 */
+	if (sk2 != sk) {
+		sock_gen_put(sk);
+		/* Ensure there is no need to bump sk2 refcnt. */
+		if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
+			WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
+			return NULL;
+		}
+		sk = sk2;
+	}
+
+	return sk;
+}
+
 static struct sock *
 __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 		struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
@@ -7176,22 +7198,8 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 					   ifindex, proto, netns_id, flags,
 					   sdif);
 
-	if (sk) {
-		struct sock *sk2 = sk_to_full_sk(sk);
-
-		/* sk_to_full_sk() may return (sk)->rsk_listener, so make sure the original sk
-		 * sock refcnt is decremented to prevent a request_sock leak.
-		 */
-		if (sk2 != sk) {
-			sock_gen_put(sk);
-			/* Ensure there is no need to bump sk2 refcnt */
-			if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
-				WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
-				return NULL;
-			}
-			sk = sk2;
-		}
-	}
+	if (sk)
+		sk = bpf_sk_lookup_full_sk(sk);
 
 	return sk;
 }
@@ -7222,22 +7230,8 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 	struct sock *sk = bpf_skc_lookup(skb, tuple, len, proto, netns_id,
 					 flags);
 
-	if (sk) {
-		struct sock *sk2 = sk_to_full_sk(sk);
-
-		/* sk_to_full_sk() may return (sk)->rsk_listener, so make sure the original sk
-		 * sock refcnt is decremented to prevent a request_sock leak.
-		 */
-		if (sk2 != sk) {
-			sock_gen_put(sk);
-			/* Ensure there is no need to bump sk2 refcnt */
-			if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
-				WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
-				return NULL;
-			}
-			sk = sk2;
-		}
-	}
+	if (sk)
+		sk = bpf_sk_lookup_full_sk(sk);
 
 	return sk;
 }

-- 
2.55.0

