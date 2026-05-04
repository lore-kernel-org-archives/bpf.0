Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A7233F580
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928783; cv=none; b=K7WY7ZttL1u56EMHoXQJ7wgY0AiMLoBnwj1KeWD7qdV60+VKgsprw8t/+xxLSKfqL3hkyk2byiO4t7L78cQ9/Cg6CIoO9UdSURFoT9LTYP+BHfRAzb85XCmvo3Odn55IdNdat/tznhZOMS1YdC2QVBMN2CZ2U7ebMTqPmgM58BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928783; c=relaxed/simple;
	bh=cG/yesVRvvntcKSQhtEbypsl9lWGthOVsQu6VxN6nT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QZvS/FEtK+mfyqbzzYCafGW7h3zeTmIAmv566c7se659RuarVnZCPTlbXWA44BbsMolBGKcWvTFBHKJ/P0BdXYrqd69wy84clpHO1kTVTkxpu09V2EVRj9yIV1kitWT9qTUQijwde1ucEKQgjgm4qMX6aX/a/fXfiV+9o7et8cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ICjNUjgR; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICjNUjgR"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fd55bf6cdso3196368b3a.3
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777928781; x=1778533581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5zoNImAKoVG1tOJMnje5UjYQ+6eRMKYNpQz4KdMgcck=;
        b=ICjNUjgR/Ph15ePSxM5cM96i+7OtqSKgpDtCoa+fk+XhuWMwf69HpVB+4euOvf68Y1
         cz31ZoBqjrHk/sukJDCE1Tc6H3T3Z4v95pD1RftMg+2eZJHFGe9ukKBJC3I5w2UzL64M
         mcWte52a6PugvicNVVCrLabYjLjjXVlp5S1JPv0GqbIX6kVkfB4woGbi7g+OVF6Px0BJ
         SdY1i1pgtSq3MXROZZt41SBXwbX7bowbd0LGhjM1V0O3L0/nJfoRu+2/w9m3OdCTdLgq
         DQIqaMWi2Qog1BP4TzAe2gvse8pRE2WWJPZq9Ep43g53p2vuWLbMjqSfYXOtNNTX8fdk
         GNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777928781; x=1778533581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zoNImAKoVG1tOJMnje5UjYQ+6eRMKYNpQz4KdMgcck=;
        b=jqoeKdIdkhSRq/Spc0gQuJkZx48yksVKIVLexAhGyJGVLeBM7+sSIAccGxuw4W7SYA
         IGqd+7bqwYXD8CSAR6gM96oj7qL1RSghUjmMfJlcHcS3u54jvMsnXqp38VUt0TCPdH9E
         sYZ0XPD/Mll/6mVcEVbG2k4HCL9pF7nZ6pv0h/UItFmhhcfUgDDejUTjE2HCHkfB2i3S
         hlJY5vPKYoArGljjAqwwIMHpVrBdv0lO9PWPzKEeXqOOI2/hxO2Vi5inbiPZ9UKEuKMM
         coqppU6d/tpahnaswLKgt+4atk4hfIZFPLHYH+2zXyNOxCx0VrG2+YsdfZbW/Dr9AnJ7
         Ru+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/jPO5StAmT03i+weNMH4KaKlvSBmILdyS9m95WQDxufY5coBQ7kTqFKDEC2t9vQZ/Ho0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQn1NEvt8zeQS4GS5jvngLZKzX7tjAAXuq4wNIr+mxY0X6yA8
	lWK0ng3whyVuawo0X6hO4BwrBDNfWh9so+fpYqVIQQh0xXCb9lz+9Otxq7lvtRX8FW/0OCOYiNb
	c5ftmgA==
X-Received: from pfud19.prod.google.com ([2002:a05:6a00:10d3:b0:82f:20ed:8059])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:288f:b0:835:405a:7e68
 with SMTP id d2e1a72fcca58-835405a7fd9mr7331136b3a.32.1777928780467; Mon, 04
 May 2026 14:06:20 -0700 (PDT)
Date: Mon,  4 May 2026 21:04:52 +0000
In-Reply-To: <20260504210610.180150-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504210610.180150-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504210610.180150-6-kuniyu@google.com>
Subject: [PATCH v2 bpf 5/6] bpf: tcp: Fix type confusion in bpf_skc_to_tcp6_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

bpf_skc_to_tcp6_sock() only checks if sk->sk_protocol is IPPROTO_TCP
and sk->sk_family is AF_INET6, but RAW socket can bypass it:

  socket(AF_INET6, SOCK_RAW, IPPROTO_TCP)

Let's check sk->sk_type too.

Fixes: af7ec1383361 ("bpf: Add bpf_skc_to_tcp6_sock() helper")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 7d945dc2cb92..684922efd481 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11947,7 +11947,7 @@ BPF_CALL_1(bpf_skc_to_tcp6_sock, struct sock *, sk)
 	 */
 	BTF_TYPE_EMIT(struct tcp6_sock);
 	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP &&
-	    sk->sk_family == AF_INET6)
+	    sk->sk_type == SOCK_STREAM && sk->sk_family == AF_INET6)
 		return (unsigned long)sk;
 
 	return (unsigned long)NULL;
-- 
2.54.0.545.g6539524ca2-goog

