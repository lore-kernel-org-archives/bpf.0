Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB663477292
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786624960; cv=none; b=pemY1mOGgvyLyGa+H6AqLT+3LDpdUsVE1wY7f3iXQxpc/1YFKW1placg5Y3sjqgLRsI/g2CmCPKfZX5yl7YCWYLbeAFhdXSjc/pBuo6mg4EueRYXYR9qgv4c7/mcqnfvRs81ASAPRmN9m40KE4oQBq7ibqphZ6NM5D+dqR6aEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786624960; c=relaxed/simple;
	bh=wtrEB0dSZ8WvgbCQfYmBsgvqWkqbCDvmoG661uoK+Wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pyfan96RbKANUnwpdj7nX8g9tlYL/qOvgaToYQL7t9a0EWnRH2yMbvfjtsYcF8nVxaEDNvmwB6jN8TaEIiar6WRrKTB7MPJ+pdijK2dvhMeFoU0sCotjPYLtvkH5WF5JLHB1s8uiXlSGkciwRuuwICkaKsMHNa90mnASTbzFVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=hI9e3dM+; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="hI9e3dM+"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wuUlR-002U7m-Nk; Thu, 13 Aug 2026 14:42:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=jgidj5xzOQzH00GHOr38xpiCZIBP3l5xJh2vMU5I0tM=; b=hI9e3dM+mOEikbtfiYLzvwxobS
	Pw8CY3ltuxrQx5AVmKtO4U95ScAWbAxRDlxsh4xaRlGvxXtM1M4uW7u2IN6MTpw3gY4d2MuUZl5Vn
	JYIoaBH8sAHxFZznMaOMja2yMZN81v5osdZAR35IY4Zys3P62uVL1BcMSOVCLEHCh8GpQU7RvcV7p
	zUJzQXy/0TC9JtI7prk5s3hng1+MiL3ET6h96di0pg1FaxXN+aHWd52xDj08/iWo2ONlSuPXJow+g
	ATNz3w5HLZvuXtSkYFxrox39VJU1N62v7+AoqI9pgTKe6KN+2gtrra/uAHWNrSvDoJy8Ov6vXbiAS
	/70VCX4w==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wuUlR-0000DT-2B; Thu, 13 Aug 2026 14:42:29 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wuUlF-001YW5-V6;
	Thu, 13 Aug 2026 14:42:18 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 13 Aug 2026 14:42:00 +0200
Subject: [PATCH bpf-next 2/2] bpf, sockmap: Use sock_hold() instead of
 refcount_inc_not_zero() in lookup
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-sockmap-lookup-get-ref-v1-2-31f5d55f44ac@rbox.co>
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

psock's hold on the looked up socket isn't dropped until sk_psock_drop() ->
queue_rcu_work() -> sk_psock_destroy() runs, which happens only after the
entry is unlinked and an RCU grace period elapses. Since the lookup runs
under RCU, a non-NULL result guarantees sk_refcnt >= 1:
refcount_inc_not_zero() can never fail here. Use sock_hold() instead.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/sock_map.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 9efbd8ca7db8..ca49bc7f8687 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -392,8 +392,8 @@ static void *sock_map_lookup(struct bpf_map *map, void *key)
 	sk = __sock_map_lookup_elem(map, *(u32 *)key);
 	if (!sk)
 		return NULL;
-	if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt))
-		return NULL;
+	if (sk_is_refcounted(sk))
+		sock_hold(sk);
 	return sk;
 }
 
@@ -1218,8 +1218,8 @@ static void *sock_hash_lookup(struct bpf_map *map, void *key)
 	sk = __sock_hash_lookup_elem(map, key);
 	if (!sk)
 		return NULL;
-	if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt))
-		return NULL;
+	if (sk_is_refcounted(sk))
+		sock_hold(sk);
 	return sk;
 }
 

-- 
2.55.0

