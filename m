Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA13612ED
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435976; cv=none; b=o46OUBRwrnXY/7A+xJrE7meWg2EpziWS+WZgpfFDUJ8vylfC3tu7KPcRLVQQBjlyoE5MjVIGL0QzPhH2tb2tWNcnHoHFcEq3zNOqHn451kCs8uWmOpnI++pNNTnpngLOtfcSQPtlbDruCcvHTznSx6rMixKZlvE9ED+rwLVHwHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435976; c=relaxed/simple;
	bh=ITNyLUTiNArq3+p1wCkL+2oFFFQASXvWz83jxEAII34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g3XDmuqoi0gr/ldxok07E3bOjBMJQlpZQY4Pbqk5zaR1c3mLUd0h6sm0JmZSVPsKkkoHkKk6snnCEGvvulu9zrKNtaDhpUi0Rh2U+t26dBQjPwgMaoMfZxH0f1jINEPs1bqGKJ/dRvwCBO7YIyeMbKMPOpBKKHqHZE7PToWHpkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mu6JSYQC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mu6JSYQC"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8353fbc7ad5so3572015b3a.3
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 00:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435973; x=1780040773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oJfhavb7c0g8BRp/awps30Nd4Ebc+ZK855mSv70HAsk=;
        b=Mu6JSYQCR/wVZX8803khlYq2qR5CjPheydWKh/yhXwBuu1GsZXAEqYEHu+ezwDfJlN
         KLugjCHb1u48Nx3/LFjhbehNSIycN+6/tlIbYonh9Rhily99A0mozSrWp1NyqFvEhhAE
         ykgTnb00SkUXyAZIO6OXNPrtWRU5lXbBP23Megh7qLcqMVZYakVMkanktSbdMwS5+q80
         9DN8Pa9oivvrEL7ahFnOT/RWvu/YpLVG0WO6P+8m9PJG3GUaBtJBpoYxS1YrihjYGTxV
         JRStT36SmPGqDVd3TSnpYIK3JE+gP+cpcSd2tVjGAV70EwAm3SwOTbNlrmCjT5+bi+Nl
         NF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435973; x=1780040773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJfhavb7c0g8BRp/awps30Nd4Ebc+ZK855mSv70HAsk=;
        b=lbiXPbRBiP4X36ujQaGyGuFXH6SdzDVerIkJYdrUqzee5csKtjxeiTUM3dtPlavzqh
         nx+awX+/IGBSIlB/v0/VkesMg0f6RRdhoyV4KkPtnUO38VjuVKXN4IfCK6PTMqwFImL0
         sbbu9SGnuS+jt1i+0Bzm/dmeT84f94s+pzsUqiOC6AZuBknuItz5oGp1cdLL8A4aaOOd
         39emdaQDhzXneMSuV7W/4xNsk8C4hjvgH7Om65CWqeYTr21UP2yKLXGEe/O9AnoRGdGo
         WBgkivr6Ukeumj2j2XQaE+U5xgRHLPB4SiDs6QaS0re4QA0rhlsZ2WyepG1lvI4xzNuI
         sUFw==
X-Forwarded-Encrypted: i=1; AFNElJ/Yg60pNRFHb7XxpKVJROyPJoQbyMywhL7LGV8hijcoMJ0HdClFIOudjK8kgCKWg0phi08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzuATFI1tPwzxXlxMdcgoENPtFJODPr9bRqD2mDBJseHyr5R3M
	NuLtwiOXZJKhjFT60K2ov+YW4wQ2HlevP4Zip7HmC2/uHExWNQo6FufiK5pOS2o42Cy95eLtz4Y
	psiFCLA==
X-Received: from pfbfq9.prod.google.com ([2002:a05:6a00:60c9:b0:82f:7833:9aa9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1acb:b0:82f:6e7:1527
 with SMTP id d2e1a72fcca58-8415f32f286mr2675412b3a.23.1779435972280; Fri, 22
 May 2026 00:46:12 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:59 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-9-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 08/11] bpf: tcp: Reject BPF_SOCK_OPS_RCVQ_CB if
 receive queue is not empty.
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

Unlike SOCKMAP, BPF_SOCK_OPS_RCVQ_CB does not iterate existing
skbs in the receive queue when it is enabled for the first time.

In practical production use cases, this behavior is usually not
a problem.

We can safely assume that the upper-layer protocol is designed
with specific synchronisation points where the connection is
temporarily quiet.

At these points, the application can completely drain the receive
queue and safely enable BPF_SOCK_OPS_RCVQ_CB while no skbs are
pending.

A prime example is an application transitioning from HTTP to an
RPC protocol:

     Client                                Server
       |                                     |
       | --- HTTP Upgrade request ---------> |
       |                                     | [Drain all skbs]
       |                                     | [Enable BPF_SOCK_OPS_RCVQ_CB]
       | <-- HTTP 200/Switching protocol --- |
       |                                     |
       | --- RPC Frame 1 ------------------> |

However, to strictly prevent any potential race conditions arising
from unconventional upper-layer protocol designs, let's explicitly
signal a failure if BPF_SOCK_OPS_RCVQ_CB is enabled while the receive
queue is not empty.

-EUCLEAN is chosen to indicate that the caller needs to clean up
the receive queue before enabling the feature.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5913b3be9f1d..883e4aaed49e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5395,6 +5395,9 @@ static int bpf_sock_ops_check_rcvq_cb(struct sock *sk, int val)
 
 		if (unlikely(sk_is_mptcp(sk)))
 			return -EOPNOTSUPP;
+
+		if (!skb_queue_empty(&sk->sk_receive_queue))
+			return -EUCLEAN;
 	}
 
 	return 0;
-- 
2.54.0.746.g67dd491aae-goog

