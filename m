Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6B529ACDD
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435967; cv=none; b=HjOcXxomVEK4wnq+hyC6G5fhraMKsN68VDq1OcrhectmFI0GnvITFLL+FltWQtzVBPGOizQoeaurAqZY860KtgSuIzQIBZF1xaSK5fetHU6snkefA0qy7S6QXDNwqnMI3yT8htzBdm3Fsa290sv/qacGXCLGFlN1TP0UZuPUXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435967; c=relaxed/simple;
	bh=YtuyIdQZY+eul6VUiynURNGynwN0UeTB6J/R8fpgDyM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P4z0G5EbAg6RNb9R6mI0zgKJHaFdGrem+I8mH+SM7D44rCWuWzoyBCohyUBvdLdpVN/7sTHEaChdYMGuq355C/Gdechhp1TGRuDqxrqcv1JrVh9VtxN2RG0T+BAhNiQS8oHDsSAVTVFLyRSle+YX6Ph9AwkSDs+OxEOYDEDaRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aPlNA/Nx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPlNA/Nx"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b7aba0af02so66870435ad.2
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 00:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435965; x=1780040765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L4N3hOfAzGfaW5hWnhwkjve/GusrE1zFUOtYHsUbX90=;
        b=aPlNA/NxZL9SyhsXSRP47saw3l7/ESbzyt1JlsYI6hCVzISdIHdY8a2S/BXnwh9hs+
         sieTUDDCjGQiFcrB7VdsM9wu6xHM97kRRIuLR/QahUwC6Eti9j0c59RsQk4IHWr9oVfA
         lLN8GPW4nZ3sf/pDFivDBkGN6i8o7W5e4ZvAByZ/spwmHdQbHE0dWsYMM3N00SyvXJQS
         kLfKUK4BaMaLvfHpXi/DTUPqxI6w9yTVcqZzMBCxNCtuFB5Nq/uDnaHbeuCzC50g0qbJ
         nP/pARjDmkblzBIHRKevSTWP1mEa8cge25Xvg2iDeSTFQYzvjgRxd5d0ZeEk+3cu7Alh
         QdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435965; x=1780040765;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4N3hOfAzGfaW5hWnhwkjve/GusrE1zFUOtYHsUbX90=;
        b=fXuL6swROtbUHHR3gxYwJydcvIMHE3sFT09YosKCaTUQ6VmFO0+sbS/5WqnJqF9CmQ
         C4H4EAFZccAnpEm90Lca4Ib7NL8LkgNcDwzzW5nC4HKOBLTmkMUkrRmiNgyLD/t0tZGd
         gedR3ZouHKL9wMYfczpZVxDWv39LoPP4SIMNQ+dGD91YhFhnWgXfRONLtU5FrjCcR6HP
         4B3YFOwuBR2M/81iIeLgEQx4j04Ka6KnNMZm6Gouu8YJt91o9geXBJf5YeOlvhXdfXAE
         90AJXE4dokwbv14Uh7bcRMhMifcIgcJUpQoSGhQCe1fB9asnXEkmQsN7Fj58ycVGa2QZ
         gq/g==
X-Forwarded-Encrypted: i=1; AFNElJ8bzniskrdQkSqq9ufEmCjgl+nW/TGtLuePgMl4oqhJ5j16aKlzXFY70KsNurts1Mxt0bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR9JfhALQUW3DK2LzP7PaPjPu2DLsezDFS2a9OxmdkW3M+RFzT
	GiG9XoWpgfAPYMyQUCgrUoDp7WmEfRcdpZWVIg775MV6c+YPXg1wkVMrqcDlUQKSO8Jl8DyiEy9
	4tMTWQw==
X-Received: from plek17.prod.google.com ([2002:a17:903:4511:b0:2bd:9574:2958])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94f:b0:2b0:608d:d8a8
 with SMTP id d9443c01a7336-2beb0366400mr25021195ad.1.1779435965129; Fri, 22
 May 2026 00:46:05 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:51 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-1-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 00/11] bpf: Add SOCK_OPS hooks for TCP AutoLOWAT.
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

This series introduces BPF_SOCK_OPS_RCVQ_CB, a new type of opt-in
hooks for BPF SOCK_OPS prog.

The hooks can be enabled on per-socket basis by bpf_setsockopt():

  int flag = BPF_SOCK_OPS_RCVQ_CB_FLAG;

  bpf_setsockopt(sk, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
                 &flags, sizeof(flags));

or via the SOCK_OPS specific helper:

  bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_RCVQ_CB_FLAG);

Once activated, the BPF prog will be invoked with bpf_sock_ops.op
set to BPF_SOCK_OPS_RCVQ_CB upon the following events:

  1. TCP stack enqueues skb to sk->sk_receive_queue
  2. TCP recvmsg() completes

This allows the BPF prog to dynamically adjust sk->sk_rcvlowat,
suppressing unnecessary EPOLLIN wakeups until sufficient data
is available in the receive queue.

This functionality, which we call "TCP AutoLOWAT", was originally
developed in 2020 by Tenzin Ukyab with the help of Soheil Hassas
Yeganeh, Arjun Roy, and Eric Dumazet.  It has served Google RPC
workloads for more than 5 years.

Combined with TCP RX zerocopy, this typically allows us to read an
entire RPC frame with just a single wakeup and a single system call.

While the original implementation was specialised for our
internal RPC format, this series introduces a more flexible
version by leveraging BPF.

The BPF SOCK_OPS prog in the last selftest patch closely mirrors
the core logic of the original implementation to provide a real-world
example.

Overview:

  Patch  1      : misc cleanup for testing
  Patch  2      : Add BPF_SOCK_OPS_RCVQ_CB with no actual hooks
  Patch  3 -  5 : Add bpf helpers
  Patch  6 -  8 : Add safe guard for BPF_SOCK_OPS_RCVQ_CB
  Patch  9 - 10 : Add BPF_SOCK_OPS_RCVQ_CB hooks
  Patch 11      : selftest


Changes:
  v2:
    Add Patch 6 - 8
    Patch  2: s/BPF_SOCK_OPS_RCVLOWAT_CB/BPF_SOCK_OPS_RCVQ_CB/g
    Patch  3: Explain why using ____ version instead of __ version
    Patch 10: Add explanation of tcp_bpf_rcvlowat() placement.
    Patch 11: Make copy_len u64 and swap validation order for it
               to pass no_alu32 test case

  v1: https://lore.kernel.org/bpf/20260508073355.3916746-1-kuniyu@google.com/


Kuniyuki Iwashima (11):
  selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS + 1 for bad_cb_test_rv.
  bpf: tcp: Introduce BPF_SOCK_OPS_RCVQ_CB.
  bpf: tcp: Support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVQ_CB.
  tcp: Split out __tcp_set_rcvlowat().
  bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
  bpf: tcp: Make BPF_SOCK_OPS_RCVQ_CB and SOCKMAP mutually exclusive.
  bpf: mptcp: Don't support BPF_SOCK_OPS_RCVQ_CB.
  bpf: tcp: Reject BPF_SOCK_OPS_RCVQ_CB if receive queue is not empty.
  bpf: tcp: Factorise bpf_skops_established().
  bpf: tcp: Add SOCK_OPS rcvlowat hook.
  selftest: bpf: Add test for BPF_SOCK_OPS_RCVQ_CB.

 include/net/tcp.h                             |  13 +
 include/uapi/linux/bpf.h                      |  18 +-
 net/core/filter.c                             |  89 ++++-
 net/ipv4/tcp.c                                |  14 +-
 net/ipv4/tcp_bpf.c                            |   2 +
 net/ipv4/tcp_fastopen.c                       |   2 +
 net/ipv4/tcp_input.c                          |  25 +-
 tools/include/uapi/linux/bpf.h                |  18 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   4 +
 .../selftests/bpf/prog_tests/tcp_autolowat.c  | 350 ++++++++++++++++++
 .../selftests/bpf/prog_tests/tcpbpf_user.c    |   3 +-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   2 +
 .../selftests/bpf/progs/tcp_autolowat.c       | 326 ++++++++++++++++
 .../selftests/bpf/progs/test_tcpbpf_kern.c    |   3 +-
 14 files changed, 855 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_autolowat.c

-- 
2.54.0.746.g67dd491aae-goog

