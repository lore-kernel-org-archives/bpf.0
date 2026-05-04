Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708F322DB7
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928774; cv=none; b=iOfFGoohgWRNZGEnd5kfbaCxh/4qpujea8mI6FGOjuFAb5i8ngFx+Ch+bvBhsVtylv6SUPAe92rAz2jhqPc3kmHwd72YXsrlzFDcnf4/ppXByvQwbRyhNH3PO/knRD5L/OIeNJziwl/GW+bTM9hbsDaYF/CWyJKH3WF480RZj3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928774; c=relaxed/simple;
	bh=vcU8idIUwMCKkvk/pPp3VWO6bf+ST48nqlXCkHAS8SA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XGMiGQOn1tye8RMfrBWzq/tzG2oXtu8v3OhlgUX51AOJ5ihcQXKD5F3sPO7yufg4IVo2Z06Ns/ZsvAaHe6I0cfr15n0qk78Y+72V0PiY+6rUcwJntoN/rgs8BAe63vUXnZQT/lW0NDvYKU7874ye2bvScd+rd8pd/ou0sYiyt2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pjhu7vqB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjhu7vqB"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35842aa350fso8745351a91.0
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 14:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777928772; x=1778533572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=saJcCx34yPqZu6s4wgP31guVMnuHq9ARYffBdNUR00o=;
        b=pjhu7vqBxOWBax8ppKxiWCSbI68nzAacuP+qPyS++bas8o/KZ3ddbA/wxk2r3i/2Tu
         JMocmIUWMKTBptGwyH5i93qb97WNHNpK3mAkegJcsSe9n1KzWNK+99rRG9+5ZVjwrI0T
         YGRqxzEXBg31H4GpVBcUKmZJeQDpVpdHE9O+9/YFr4kyZPBFvGxuAm13hXlEUtcayEf9
         V6sBou8E6RvmhDyDmSAKuRK0zDIHm/QNKYHmnA13QKkhluHelKta4FrbzRCPVxUMDYlQ
         W6JmxhAE5B/n9fAdVqFN2Bahu5PG2EJw/cDUDDZvZvNERU6xFu8D2EORKkbPgEMDaMGb
         xNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777928772; x=1778533572;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=saJcCx34yPqZu6s4wgP31guVMnuHq9ARYffBdNUR00o=;
        b=Z39HkRs715XyJBWTIPiMS8ryMc3ObbRwisG3qEpsBsv4L9TObF4sJc//jBgkXqNXTE
         6qCHPXW2KGrTcDeB9Hndk+BxxcglyIA1tVtcXukzjbF9s09belgkcj4il4Jq2T3QtNwa
         ULVjUpNQHCcRu6zXok7Zgah9kms4U51VMPwVlJYfIvtXI4Z3mmlemgQflZINwfuaORqr
         ncu/hO1FAtgFswmYMQoJQNn22jATuzxhjF4tNNtOJ63DtA1ayxVZFOKx0IlspJnr7Mru
         4BwPZfs4Oi8za3unBtdsuWHw+1kBqgIUBb7iOgdRTkDEXNt3dZKia9wqFIGfd698sDBd
         OYtA==
X-Forwarded-Encrypted: i=1; AFNElJ9Z6l4JcqKOrE1/tPGAJ86GTJSypWlF/3mk7sfA5mG1O1kvr4EPAfiByhbLPwXNxEJT920=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP34D56UAML78N26FzVx2rRj75VXEbJOnwbsmL8dIr9D2NcRvC
	x4njniRhhuxRSjhrc7OeKnIyAdd7C2I/P+Yfu9Decf/22HXyogwkBvCquhHcxRDJioivJBjFf2v
	OkuuCgQ==
X-Received: from pjva3.prod.google.com ([2002:a17:90a:d803:b0:364:ff68:5a3c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35cf:b0:35e:58d3:329f
 with SMTP id 98e67ed59e1d1-3650ce8654cmr11209655a91.13.1777928772105; Mon, 04
 May 2026 14:06:12 -0700 (PDT)
Date: Mon,  4 May 2026 21:04:47 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504210610.180150-1-kuniyu@google.com>
Subject: [PATCH v2 bpf 0/6] bpf: tcp: Fix type confusion in bpf helper functions.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

bpf_tcp_sock() only check if sk->sk_protocol is IPPROTO_TCP,
but RAW socket can bypass it:

  socket(AF_INET, SOCK_RAW, IPPROTO_TCP)

The same issues exist in other bpf functions:

  * bpf_mptcp_sock_from_subflow()
  * bpf_skc_to_tcp_sock()
  * bpf_skc_to_tcp6_sock()
  * sol_tcp_sockopt()

Patch 1 fixes bpf_tcp_sock() and Patch 2 adds a test for it.
Patch 3 ~ 6 fix the rest of the functions above.


Changes:
  v2:
    * Inverse if (err) to if (!err) in the selftest
    * Add patch 3 ~ 6

  v1: https://lore.kernel.org/bpf/20260430184405.1227386-1-kuniyu@google.com/
      https://lore.kernel.org/mptcp/20260430-mptcp-bpf-mptcp-sock-type-v1-1-d2ed5cda7da9@kernel.org/


Kuniyuki Iwashima (5):
  bpf: tcp: Fix type confusion in bpf_tcp_sock().
  selftest: bpf: Add test for bpf_tcp_sock() and RAW socket.
  bpf: tcp: Fix type confusion in bpf_skc_to_tcp_sock().
  bpf: tcp: Fix type confusion in bpf_skc_to_tcp6_sock().
  bpf: tcp: Fix type confusion in sol_tcp_sockopt().

Matthieu Baerts (NGI0) (1):
  mptcp: bpf: fix type confusion in bpf_mptcp_sock_from_subflow()

 net/core/filter.c                              |  8 ++++----
 net/mptcp/bpf.c                                |  2 +-
 .../selftests/bpf/prog_tests/sockopt_sk.c      | 18 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/sockopt_sk.c | 16 ++++++++++++++++
 4 files changed, 38 insertions(+), 6 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog

