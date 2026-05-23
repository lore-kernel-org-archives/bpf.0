Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCFD35AC07
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525017; cv=none; b=WV+32PSefmjl2qpGPfjCHuPUOY5Z+H//GNQDqZm2xffHwNRU+fWqlisod5H47tfLpM4XHoPtQT/NWM7icf6y8O8rsVPymwoPzDXeSlZgsxziDPG1d/uugErWw3Oh/IIKp2Oqxpk9qf4G61VqXqe3zeZ1b5ZBAAdZ+JtVa7aGMww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525017; c=relaxed/simple;
	bh=ZP/yjWLcyFfoXbQ0mJcb3h6qRhbU/40iNjGIRkuIu8s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HhP8xrNDmttiyljEpicPW3rBsQv2zlQKeMTj/VfzTTQcOOox3dkEoTRPx/o3vYi544kAtEC/5B016QB12osIfh2d6ChfkjddUHVgZUfK+qED9HLNKnsk3UmuC6lBIx40a5DT6LP1nYVao6lwsXGU/HdWg1E0SV+lzN6EzppPiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a2pWUlh3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2pWUlh3"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3663d5e9bf4so7737645a91.1
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525010; x=1780129810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdKvW6OTT1gS2YCnhs238bIchf/eYZIj5lDxHn+nM0Q=;
        b=a2pWUlh3afwNwYFewJfamuXu/PoIiH051jgNMUi28DQ43MrBPr8/FEIvqMyFhRA/ed
         QQG12aoGAmKzchLzqMgNzWHAi79g8XAOy9NdeevldfHFHujw5h3qgC1t5j3fqbX8NjP7
         10q/nAjLD++hhCOIIB1PzVyTAiR0onsBugCJQDCfZeXt5AkQDZHKLs4/2L0u7ofuUtIj
         8UC8nHc2/C76zSiXDRPxQOWQ2r+FLIyF1akI2uELGlBDnavu9lrtKptxffBAN1puEw7t
         F4IQ9GnSzMYcHW0Kr3GmGu583jwiCNrBibwmjnkeu7j7RC+H+U5V76h7moiaT20LiN3i
         Vxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525010; x=1780129810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdKvW6OTT1gS2YCnhs238bIchf/eYZIj5lDxHn+nM0Q=;
        b=pi1YOdQrjfx8c+/YkL3wOeoIXvOoRFXSM+MKgUO8zkHIak4O87YCXSy6at1ej+sSyD
         RCA47AHI85ES9AQKqgQ3s8/gCaXqV4QI2ycgeBH81GCafZDe976H5/FuvUJhCsuagA66
         7sViDRyH6Y5/cqWRLS7NO3JmrS/APqmRXbtTZyCVL8ZfoJfp9mqUVK2Yj9lx24oMBOQX
         0GTXuNlWOu525JWEr+WmjrPbGyioFYs4Mu1tHXqHFml0EM2Otdwrs9FAg9t5tRC10DE9
         YJs36ZkI5LDErzzOgDa+pLasX1HlXlZEvrpHgM6PPGYCnSfF8O9BNYWhJi0Pdctmhy6i
         6aMg==
X-Forwarded-Encrypted: i=1; AFNElJ/3xHLGFcfkDcJzV79T4j6kHHpKWbkTB5m0V9naGoA9+n6YFQu15Gba/vo2pnR+uUW68c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqSxGrF+ybqzKmW+bux0Jxm3VE4qFna1NGzlnnTsS0bPgQOGFq
	j18qs+D0UMeYFEOm4NT7ftZbUpGG6lIRHqNSMXmXhY2RxJFTnpgS40YnEk4iMT5ba/rHn+SyD5e
	eCdgrHg==
X-Received: from plbmj8.prod.google.com ([2002:a17:903:2b88:b0:2bd:4ef9:f6a4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce88:b0:2bd:a3c5:6d96
 with SMTP id d9443c01a7336-2beb0756707mr72213045ad.14.1779525009896; Sat, 23
 May 2026 01:30:09 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:36 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-8-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 07/11] bpf: mptcp: Don't support BPF_SOCK_OPS_RCVQ_CB.
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

MPTCP has its own sock->ops->set_rcvlowat() / mptcp_set_rcvlowat().

We should not allow calling __tcp_set_rcvlowat() for MPTCP subflows.

Let's disable BPF_SOCK_OPS_RCVQ_CB for MPTCP for now.

If needed in the future, bpf_sock_ops_tcp_set_rcvlowat() could be
extended to properly support MPTCP.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 1fb63b264b18..82ec2291d6f0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5390,6 +5390,9 @@ static int __bpf_sock_ops_cb_flags_set(struct sock *sk, int val)
 		return 0;
 	}
 
+	if (unlikely(sk_is_mptcp(sk)))
+		return -EOPNOTSUPP;
+
 	write_lock_bh(&sk->sk_callback_lock);
 
 	if (unlikely(tcp_in_sockmap(sk))) {
-- 
2.54.0.746.g67dd491aae-goog

