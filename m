Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26AA46AEF6;
	Thu, 23 Jul 2026 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806468; cv=none; b=R9lQaHkSqAfiaATjEprHTEIBoClu0qT1AZXC2OCb2YLcCrOeTQIjjTGLo4vyNtwMLjsrDIyFTA7zeMFJPhMpCxrRKxHnb5mepukKSAEvzmq08UbgwkBkNUZmzltW38Xy7MrH2Tbu4V0LVs1NZIH456K3yTc9VkLIRGcSavDaUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806468; c=relaxed/simple;
	bh=9dy3OBmEmptmBnLZGWx3UFrj5VqOypMzcqIRauS8+6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OYsKF7XPqduhRC4e9fKZVwe/zPmrXxHaE+IaNfe2vpt2se3TDHl7U1vm7eDIA52N6uNwC3rVPduBLQi5XKiNoo0IzBNO7ZSPI2w+Wg1AMpz/XL9LApSqUdRk+B/jOBqnCKX0qJSIy1LCJ4S6lnp/tpu59YEAC3wI4PoR4MLHEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ZqZLaLX1; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ZqZLaLX1"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wmrgr-007G63-Rh; Thu, 23 Jul 2026 13:34:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=lgd9qrAh/mt8mpiZLiLW/J3JKlUYADrx2KtmKJcePSQ=; b=ZqZLaLX1y+YgxF+pYF3jGg2vRD
	tF0JSoyrBTclcR8kKRxc7+9AOowPz/cb8iVUuDXvwxg+nMNZxCKsBYEHmp/tpqqQ4swvRa9RMvWY8
	pWNELy9CmNGnKpvWgbDzhg1YBuX7/FgY6HsOka9PvjKF3DVmjVTS2VwMM1U7L0iRfk2M9QJbWr8Hn
	mzy3wjb84JiZzVXZ7q6J4os43zANTE8Ax4TcL8yhxl5AHUhO3u/bf1SpIAEcE3dnx2Ylo0qb/WCjR
	9HBDOiI/wZ+2OjqpPdpNxlR0Yk1vHKr3W7R1j2RXCvoYONhYIaNNHgNZZG/p5J91+fE4muv+z55dD
	urNR2P7g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wmrgm-00079t-Ge; Thu, 23 Jul 2026 13:34:08 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wmrgW-0060aI-BM;
	Thu, 23 Jul 2026 13:33:52 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 23 Jul 2026 13:33:28 +0200
Subject: [PATCH bpf 2/3] bpf: Extract shared reqsk-to-listener upgrade
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-sockmap-lookup-tcp-leak-v1-2-1bbdc58ce514@rbox.co>
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
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

__bpf_sk_lookup() and bpf_sk_lookup() duplicate the same sk_to_full_sk()
reqsk-to-listener upgrade. Extract it into a helper.

Leave the currently unreachable WARN_ONCE as a defensive assert.

No functional change.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/filter.c | 57 ++++++++++++++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index b446aa8be5c3..403aba3ce891 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7074,6 +7074,27 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 	return sk;
 }
 
+static struct sock *
+bpf_sk_lookup_full_sk(struct sock *sk)
+{
+	struct sock *sk2 = sk_to_full_sk(sk);
+
+	/* sk_to_full_sk() may return sk->rsk_listener, make sure the original
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
@@ -7083,22 +7104,8 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
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
@@ -7129,22 +7136,8 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
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

