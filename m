Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B233BBC0;
	Thu, 23 Jul 2026 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806471; cv=none; b=ur8wI5RbqsmPYZEbzzdJjWje8AnTDyH0Ng+/C8MILaC+CiPYURnrZuEOTLKBV/JpVgR3czPVK0WdmK2NrykfYrD8QoXCLFYKO0SpxctJLYccsbpbOzZTfzLVZRG6KnrhxnNztfG8tZkA6yTpKwKES8XWDHe4qgreei85GGCHUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806471; c=relaxed/simple;
	bh=2XfbegwDgk32hzymslP1u+I7qkHyP75VxS7Qf6Qo2hM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amh+5JAO2OGOUuhvGKatz6rniTgHOECDxTX2XHDxECg+NsRMfSLpmTNTQlLGiMyf+YUn4hoFHlzTRJdIK5iDBY7cbHhmql+9reQno8f9xqnz/v+/jU13SOQAAqaEz0nFl52T7IeP1LbMFoJA7mzDbEfVhk+WNrxs4SjU6n/qRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=PISoSM5o; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="PISoSM5o"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wmrgo-007G5e-Qm; Thu, 23 Jul 2026 13:34:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=W/Squ/6n9U/tVVqLPQzzUtwkXyf10bQergVKjvP/hvE=; b=PISoSM5ofb5BwIIciPTaQB0/v+
	hD6raYqqsUWl+web8PNiw2TFQ4C7U2ttVEHrztc0E39MRLNAkqcOo/O5PcfAaPB5WVbwzpW7vmiwR
	cnPYReCj0F0ehxC/LpxMShyw/CbQTY3lpPYJnAKBK47GY09vh7G/VEfYScR5XrowI51ytWO2J2RiA
	NuBKlnKoTWSwvFnrprOuPwHoC45Rr6UKW5fok8wR0+Ec72bdXJYEx868/pB4F8ZVhf9DebGSZypnm
	4mP0+7HMJgUIAntid1zuWjTNowoALA50pLB/S3P9RC2xLl9Wsy/o98HedutcVn3U9nmzAJQuaxH3k
	pe71JZ8A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wmrgm-0006Gd-UD; Thu, 23 Jul 2026 13:34:09 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wmrgV-0060aI-7P;
	Thu, 23 Jul 2026 13:33:51 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 23 Jul 2026 13:33:27 +0200
Subject: [PATCH bpf 1/3] bpf, sockmap: Use sock_hold() instead of
 refcount_inc_not_zero() in lookup
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-sockmap-lookup-tcp-leak-v1-1-1bbdc58ce514@rbox.co>
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

psock's hold on the looked up socket isn't dropped until sk_psock_drop() ->
queue_rcu_work() -> sk_psock_destroy() runs, which happens only after the
entry is unlinked and an RCU grace period elapses. Since the lookup runs
under RCU, a non-NULL result guarantees sk_refcnt >= 1:
refcount_inc_not_zero() can never fail here. Use sock_hold() instead.

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

