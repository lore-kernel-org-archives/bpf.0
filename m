Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074385;
	b=tG/y8rI/cAA7q0Jh6vQP0aUv1iAWAj5fqU19S3vYQyyFwhLgb1CIExqdB5K6iovDZw/U
	 Ny9LJSG2F4ElUxDRcuxVuJeZb//ytis2nderrHEI7TnWtOiP/PAuO8IZ61lvT354sRo80
	 lR3qeG/eEZG5GD0bEpFIaSonBagbh0cbvfpFwuOXLsXTEN6sfoDxvn+zD/c9PGvAZLd4j
	 5Dd2si0RmY7+CtlaKIY7UtrBvDWJm8S2scVAY+5VaW1x/JV9p71QBZf3vpbwWwuCkkfcP
	 Tji11wX0wZ39fD+7F12ipSBxtsSQKc8wGil3jDr4vjPUUEwtgAIBc44MsBD7NS+bvMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074385;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=hAVvC8vR2vBGPxoDQZWFQGt78GnzQvCqPY56LF4FZtY=;
	b=xfdJwEydPb5Ms/xpLTf8XjqJSQEyY/fY98d/kyuHmcgnguVGZOH0S6MLTaXD2Ksz8QpY
	 Q4IOpY/qp5yu07D/Lq4aGlsGxsiPdnywQunADun0BNMDAEo0GkyL8zXp/JH6oII1J6sCF
	 pe0G2jgRRWp+ai/DZ4rRWoG+RFAXVuStPf95xOec6gx7VKFzYOkV8g8FGHs/l+AL6YK4e
	 wP8qmdUYt9tI8B00Ph/E3dziYYFMoXIzq2su2/829Lnb3Kg2qAvDpXrFU6x9OXW14sn7t
	 BVKVeQjcYV7+TmO0V8JpSAsL02cIztjw1/3jrUZKStEoJt+c0+cuCiLMuHp7JbiSo9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=TwF4N8si;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E09606D823;
	Sat,  7 Nov 2026 17:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57E09606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=TwF4N8si
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhM-007oTy-Sh; Sat, 07 Nov 2026 18:59:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=hAVvC8vR2vBGPxoDQZWFQGt78GnzQvCqPY56LF4FZtY=; b=TwF4N8sivqjwKkX5iFCFEdaGQY
	DCKlitYFllpArna8Ly5GqytdumjLupii/oA5s/x86OCMoYRDFvGvp/XqOglyn7PyIoHKrZPA8SRqb
	OeiCkorrf8uxE0+A9tMZXGabIz+lG5UO4g4sSQO1U0S7X5SmALkGh5vfJ3xTnmZiQa6Hp9qmn4RVL
	cGdRS6DTOvheqwrBVezNibDwtirfUngw50vB+eHhXY18BhUrKqdKdTT1KusXVXH60ArkH8kTPmFem
	HMOi1M8ksa7WBcminsv1VRnCQo4mwiyknK3ndlYYfBHpLkn4bQzP0B0I8qCdrWMiiffQm2XG2LGpI
	MCLHfSaQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhB-0006ae-1h; Sat, 07 Nov 2026 18:59:17 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xPkh8-007LnK-14;
	Sat, 07 Nov 2026 18:59:14 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Sat, 07 Nov 2026 18:58:28 +0100
Subject: [PATCH bpf-next v3 6/8] bpf: Mark bpf_iter__sockmap::sk as
 PTR_TRUSTED
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-sockmap-update-limit-iter-v3-6-7c0bad1ad036@rbox.co>
References: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
In-Reply-To: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: Michal Luczaj <mhal@rbox.co>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2

In preparation for plain-PTR_TO_BTF_ID removal: allow calling bpf helpers
with sk provided by iter/sockmap.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://msgid.link/DM92JCFA4X4U.30MTDH0KCPTJ@gmail.com
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/sock_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index efe49551caba..1a8478b03c24 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1993,7 +1993,7 @@ static struct bpf_iter_reg sock_map_iter_reg = {
 		{ offsetof(struct bpf_iter__sockmap, key),
 		  PTR_TO_BUF | PTR_MAYBE_NULL | MEM_RDONLY },
 		{ offsetof(struct bpf_iter__sockmap, sk),
-		  PTR_TO_BTF_ID_OR_NULL },
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
 	},
 };
 

-- 
2.56.0

