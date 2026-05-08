Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1AA2F8E81
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225657; cv=none; b=SN5tWsJ4ZhNJ79onForUkAsZI2bc3I1r/bbYePq4IocjqoUYG4WqOJ2lpiKjdzcTZcx5mN+y0GKaIvc+YquexwdQz39M6mGdLtPmBWY6MVhZLmgxHhVDXg7NiS9X+nwXkgd8iZROtmM1k4MzLqZutLJEhX9MWgL6pzWyEP6Bl/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225657; c=relaxed/simple;
	bh=9rbpH9sTtoxDH1P1A5GC1ty6OQLE5yq76Pq1luSCRBI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qi10QcbkRxbZOGepFjsM8Q+JGtjyWOnZn6yFEPr+GGHf6y5n4vIkn55L98SAkKBTmezbUwMD/2QIDbmkdlNHOFBAgLjowUk+h9w0Y0vjfAkAvsjeOkZaNlD0hPDqbmjMIrmOviuk4RjO+E2TiNA98VoK1jkDxak/qWPLw/GD09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=id6RhLto; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="id6RhLto"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so2067707b3a.2
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778225655; x=1778830455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/7Pn1xhB3shHE/iVX8WNrP72hOJ5ZDHm6Pa6CaRu/P0=;
        b=id6RhLtoEAYT5svEeBM4dmxnNme44cs7+/tC2mcRp3Z7x5h15DklA3tgWO/0UwUJXq
         +zU/NwfZh/ZkDfep6lrmrsnODZM5WZYTW7E9o/jymObT0lKyIQiRZFmbmgox8WfzfD8s
         sZL6oGV/ixilkMN7pSzjBKvhTXUbCy6kTwlAsb62nHyrLYprJPV4SVbE4cprPS40C1N+
         2O14qriJxpzaOseA2qogvmFfFNGN0CdsauqEy1rnggjxAgB0jIQG5X79J76V4rat6OH8
         FY401UFWqTSLnfGf6vrzF7WpzHud6woyiZrgAYcnIKyDXBJkYaPx/dVIu/OTSM0txAsC
         RjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778225655; x=1778830455;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7Pn1xhB3shHE/iVX8WNrP72hOJ5ZDHm6Pa6CaRu/P0=;
        b=LYyX+66XWFr84tD+wUX+nE/gUNOoOSbtj3oTjYJz9bnyqZvCjUQjPBSJliC6I9mXeQ
         jnvQzruF8T+ut99+Uu0pmL8vCt8/3hMSDtxH8ZTACyGh14SBBeoX8JqVUHq2bDMc806X
         qlll+iJh61dS0utFlY/eqcch4Ye5SyoC9EJCM0vjQCQk4HDLfp5Yhm+pfa0lyxCu3iq4
         Fcnr4mZWOL11fwmWMb7poRknxaiTe/qK6xCMPUIuVa79UmkG8FpdYRyF20fc7s47bR1u
         5MlIWJdfyxIsGkvG37c8kSKMKogp/5QTEIS8V3dl9SRTU8obZIoxnt9f6pbXeW4nkMRs
         cNSw==
X-Forwarded-Encrypted: i=1; AFNElJ9UQMOwf+1TGkmDE1s7HABnrZAU8oV7YtReip2K60ADhoxSKMmLXeRodxCZecl7dIivYl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfSvnPmFLCfR8BMEL6uRokSKnR/U8juNKZKnn62sIZi9JkdMmX
	iZ2NzW6f2kt3VpteEqL9r+p3UkpofvDJIZrKIrNQ81TuRSaHhrbtfakb1O+PRo2dA2bDSPa4hQE
	IFqZqJA==
X-Received: from pfbmx6.prod.google.com ([2002:a05:6a00:6ec6:b0:82f:dd9:c650])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94f6:b0:82f:a6bf:bee7
 with SMTP id d2e1a72fcca58-83a5ea435b1mr11249860b3a.49.1778225654929; Fri, 08
 May 2026 00:34:14 -0700 (PDT)
Date: Fri,  8 May 2026 07:33:21 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508073355.3916746-1-kuniyu@google.com>
Subject: [PATCH v1 bpf-next 0/8] bpf: Add SOCK_OPS hooks for TCP AutoLOWAT.
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

This series introduces BPF_SOCK_OPS_RCVLOWAT_CB, a new type
of opt-in hooks for BPF SOCK_OPS prog.

The hooks can be enabled on per-socket basis by bpf_setsockopt():

  int flag = BPF_SOCK_OPS_RCVLOWAT_CB_FLAG;

  bpf_setsockopt(sk, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
                 &flags, sizeof(flags));

or via the SOCK_OPS specific helper:

  bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_RCVLOWAT_CB_FLAG);

Once activated, the BPF prog will be invoked with bpf_sock_ops.op
set to BPF_SOCK_OPS_RCVLOWAT_CB upon the following events:

  1. TCP stack enqueues skb to sk->sk_receive_queue
  2. TCP recvmsg() completes

This allows the BPF prog to dynamically adjust sk->sk_rcvlowat,
suppressing unnecessary EPOLLIN wakeups until sufficient data
is available in the receive queue.

This functionality, which we call "TCP AutoLOWAT", was originally
developed in 2020 by Tenzin Ukyab with the help of Soheil Hassas
Yeganeh, Arjun Roy, and Eric Dumazet.  It has served Google RPC
workloads for more than 5 years.

Combined with TCP RX zerocopy, this typically allows us to read
an entire RPC frame with just a single wakeup and a single system
call.

While the original implementation was specialised for our
internal RPC format, this series introduces a more flexible
version by leveraging BPF.

The BPF SOCK_OPS prog in the last selftest patch closely mirrors
the core logic of the original implementation to provide a real-world
example.

Overview:

  Patch 1     : misc cleanup for testing
  Patch 2     : Add BPF_SOCK_OPS_RCVLOWAT_CB with no actual hooks
  Patch 3 - 5 : Add bpf helpers
  Patch 6 - 7 : Add BPF_SOCK_OPS_RCVLOWAT_CB hooks
  Patch 8     : selftest


Kuniyuki Iwashima (8):
  selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS + 1 for bad_cb_test_rv.
  bpf: tcp: Introduce BPF_SOCK_OPS_RCVLOWAT_CB.
  bpf: tcp: Support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVLOWAT_CB.
  tcp: Split out __tcp_set_rcvlowat().
  bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
  bpf: tcp: Factorise bpf_skops_established().
  bpf: tcp: Add SOCK_OPS rcvlowat hook.
  selftest: bpf: Add test for BPF_SOCK_OPS_RCVLOWAT_CB.

 include/net/tcp.h                             |  15 +
 include/uapi/linux/bpf.h                      |  18 +-
 net/core/filter.c                             |  51 +++
 net/ipv4/tcp.c                                |  14 +-
 net/ipv4/tcp_fastopen.c                       |   2 +
 net/ipv4/tcp_input.c                          |  25 +-
 tools/include/uapi/linux/bpf.h                |  18 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   4 +
 .../selftests/bpf/prog_tests/tcp_autolowat.c  | 350 ++++++++++++++++++
 .../selftests/bpf/prog_tests/tcpbpf_user.c    |   3 +-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   2 +
 .../selftests/bpf/progs/tcp_autolowat.c       | 316 ++++++++++++++++
 .../selftests/bpf/progs/test_tcpbpf_kern.c    |   3 +-
 13 files changed, 810 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_autolowat.c

-- 
2.54.0.563.g4f69b47b94-goog

