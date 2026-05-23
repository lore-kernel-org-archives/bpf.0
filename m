Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356D35E95C
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525018; cv=none; b=CfSEww5ZxlOK91wub19+Zkvh8wI0AT23VssHTGDJ8aq3TLn3UhBzOTqpR/G3naNsxriQnZTdgrh/v1hDEG63W/8i1m88YMpogwBBbPyDqCz5lMzNdPlURLNX4Unq3M++m9yyAYSaZjtUAAR3ipDnxDDmlFC4qPiX3qOG6ORl+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525018; c=relaxed/simple;
	bh=dc3cyu+G96Uz0mDs4rxrvr4WW2uo7W5uvC1JD1XZ3SY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o71AwUv4mMCnrKbNBa9cU5Nj2kvzfDqVERMcMQOtCFie+40hfrmDhJOn5sWAxcARofANtxJipPzm6y2oM62b4GbjuUfO7kLWI7dtkfrQ6mxXhJ1vS4nwq4r2aoWduJA3g3d7cKJV+YRjWC+PZZeQZOydP703hzoyalIMxToflHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGMSU+++; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGMSU+++"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa366fb79so10396183b3a.2
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525012; x=1780129812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6BrgoOQVhpg7Rxx27XWaxTVhF4O9VIqN8X5Igv+HArY=;
        b=JGMSU+++G9d538s0e/IdGl1foYSqEJ4RwIVFrQXUeP4HivwYdYlp8kq7vlifm6K/eQ
         hAiWJp7aUYJj/Tlf/DL4i8o9jX/TS3nsllUVeOe/oYdOacxIfvr88E0RRV4+vj47Pza+
         sLS0lqzxBvwd1urXvHBB6QUYNyHms+65rowpfd4JI689HNZeuIQPu+tSfmHTSQ5iUW0T
         LId2XmDq/VkJ2/inj/JfF6s6bTsA+iGttyL6z+uL7CjApLsafV8sLqFPLLecWnn45Qai
         MJVZbkjNUCC6GmVO9Gou3xjrS6SKSprinM/sQGzGxas04pNzs4c+PkkxRrMc3Js0LWPc
         zS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525012; x=1780129812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BrgoOQVhpg7Rxx27XWaxTVhF4O9VIqN8X5Igv+HArY=;
        b=ggAKlG+RatMfAl1IDBTkjM4h2Cy7SjPE+PxyL47XEz0g2zke6+eF0DRrWTWon94ABQ
         mvG/agR0r+yXEvo5ay5SjYYT0OxhBtcje39I9okVDnEQlwxTW0oRL3RDfa+Srl1X4u8p
         ZPtB67A+LHftFFMR0iZ7HKrMneCc6gakQG3hVfY2oUkil3lC7gqQ+fygNrIZcgmeMYzV
         cHiPSz1nh4YTQSxQWRTu1jskhKZVZZmC+V8n8tqoBxjRielC3+oEfluwWMg3VwXVcp4W
         YcOZydE3YAfVQxlKzyWmNYZvwWAXzVIDfm+RSS/9YpWDYTgm4J5k+dZBnGKhDLjOWKX+
         hzQw==
X-Forwarded-Encrypted: i=1; AFNElJ+NsjnX+Mn8VL2JZnjzDElneEbbQrgYIeZgQO30x8q6Hc+6IKXhdurKUp4adNOSrl1gKbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxozDwa00lTvY6phSMG+j1DEQn9UwcYCsAWNTZpcvKQb4cYpy3K
	Tq+NowVE68gwENIcAtfIWyQEA1su7dx2Us/RYf+utuXnWn9hOcwwrUbmAsbH4/Ubc9kUTZaJWT1
	vZTMPYA==
X-Received: from pful9.prod.google.com ([2002:a05:6a00:1409:b0:82f:b53f:40d7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1789:b0:81f:5037:a317
 with SMTP id d2e1a72fcca58-8415f15a6a3mr6389881b3a.11.1779525011515; Sat, 23
 May 2026 01:30:11 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:38 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-10-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 09/11] bpf: tcp: Factorise bpf_skops_established().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will call BPF SOCK_OPS prog with BPF_SOCK_OPS_RCVQ_CB.

It requires a similar setup to bpf_skops_established(), and the
only difference is the skb data length.

Let's factor out the common logic into bpf_skops_common_locked().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_input.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d5c9e65d9760..c4ba4f1e9d9e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -179,8 +179,9 @@ static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 	BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
 }
 
-static void bpf_skops_established(struct sock *sk, int bpf_op,
-				  struct sk_buff *skb)
+static void bpf_skops_common_locked(struct sock *sk, int bpf_op,
+				    struct sk_buff *skb,
+				    unsigned int end_offset)
 {
 	struct bpf_sock_ops_kern sock_ops;
 
@@ -191,12 +192,18 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 	sock_ops.is_fullsock = 1;
 	sock_ops.is_locked_tcp_sock = 1;
 	sock_ops.sk = sk;
-	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
 	if (skb)
-		bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
+		bpf_skops_init_skb(&sock_ops, skb, end_offset);
 
 	BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
 }
+
+static void bpf_skops_established(struct sock *sk, int bpf_op,
+				  struct sk_buff *skb)
+{
+	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
+	bpf_skops_common_locked(sk, bpf_op, skb, skb ? tcp_hdrlen(skb) : 0);
+}
 #else
 static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 {
-- 
2.54.0.746.g67dd491aae-goog

