Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23A43AC0CB;
	Mon,  3 Aug 2026 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747717; cv=none; b=hlYlKfsFblmS6G8j2Pkt2f3Hs7E/0vx1fKzh1zs3vVZ2BHWFl+FZ6rjjx69MXQnmQx4OQEMt8M7brIEBqI9qlGTpdO9Disnrw4WhlQAsg4xRS+BFVDOeugejb4vFIbe1B6YRp7YOrt6yVWYtctshXT6CiT5drTwghBQpf9PmscA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747717; c=relaxed/simple;
	bh=Z9oJOKfNkMISTXBIhGkL4Euhy5QznNcG5muaM0JGi2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ultD8gvT4c/GboEb5E5NMbrvBjMN6aX3orrhzrf10PtwHWQ/B3Myc+cO9fhfrkEen+iYnIqJXfDFw2DSfJdWbGpMoGJcrhSqSBjfZACa0wo/sQgwqoRsi0iYeppRo4gM8P3VfN/G6nHGpA4PX2oh4YyBst7l2VVCdY3to7zdgs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=gTwEnd3z; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="gTwEnd3z"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wqoYB-003g8t-2e; Mon, 03 Aug 2026 11:01:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=pfSMmgoKMBdfU0Z5WR10/bxb8fMdxnB7dgEW4lMNPXo=; b=gTwEnd3zDCZo3WCrhJdOL9TN5m
	pJobiDQ8x+5Hsh616A4UmOEt1T+G3+EO2KnBNIIvdVABZGThGuxBXvpqyNGldLoy7m158gq8rBedd
	aDaCPrLZBp+C5J2mShAZz36sLCnXkL4ekA7BRT7MapealYMIJ4Ug6VQ/JVB/MFMkyPQsib+opqwIi
	/Vkogq2wK96uL70B6vsVLhJlW0JK8v0Gmo9IwXy0XA+DD+F9h1ISuFcrq3FWOK2Nhu1W4mBJXXfMT
	+hxlmuR3jIkeykOA66LO1AqwbmfZ+Kw1KzWAPtcx9mQUmlE+sSxLTBpXozZ+/1bIPXxUZzVDWy1Vl
	9/W6Spyw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wqoY9-0006d2-If; Mon, 03 Aug 2026 11:01:33 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wqoXs-00GDCj-KX;
	Mon, 03 Aug 2026 11:01:17 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 03 Aug 2026 11:00:42 +0200
Subject: [PATCH bpf v2 1/2] bpf: Extract shared reqsk-to-listener upgrade
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-sockmap-lookup-tcp-leak-v2-1-306e025bfe66@rbox.co>
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
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

__bpf_sk_lookup() and bpf_sk_lookup() duplicate the same sk_to_full_sk()
reqsk-to-listener upgrade. Extract it into a helper.

Leave the currently unreachable WARN_ONCE as a defensive assert.

No functional change.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 net/core/filter.c | 58 +++++++++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 11bb0d236822..fede810ef37f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7079,6 +7079,28 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
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
@@ -7088,22 +7110,8 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
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
@@ -7134,22 +7142,8 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
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

