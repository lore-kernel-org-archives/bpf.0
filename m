Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A85472776
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199445; cv=none; b=HTG6Q95/3C/w4M+euIrwsl/jybAaHAU63Y2ncHIYUDe06TCN8WH11+t0eS1bWC9BxZM2K3sRXhmc6yoy1lY7edpEVqkLGwlGoManYtDIhd9Ln2bdVJBO5yBvJw5pjAnaLHV/cocLFyMG6k9zeluVW4K/I8ELHtm4+f0XxFxHcmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199445; c=relaxed/simple;
	bh=+g2TQZbj0y8d+xQ2Zm2UwnJZ3gjRdu0REmdwLwpE1L0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PHmmwa7IyvX2IgySAroejqKqu7WVOJQQH4LYrfPUMThjDsjUkn7UVSFhzW7ZTOyDZiGAQIHgcYiVgdGKPk95jCLAIDFpSHTh2uF/lFTEWD9GkHKb5sIO8P6AQ+YMywpIpQ19HrglYrGwL3tT+IkhA9NURBMJ8MdrwiZLLFn8aSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNyYirKa; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNyYirKa"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8633c0d7353so1064775b3a.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 14:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790199442; x=1790804242; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=27SgLD1I/Cvv7dG/kGYKQA4JzrNe4m10wNb0sLptOo0=;
        b=lNyYirKaFHsmSkJ1Et7sEgWn8ylkvQ+AxhfmJjELppScO4d7VHsou0mMyYi/9/zXSd
         EMwEMYbkDDmeO3mVJSPEjMqygVh0WmC82Jc5s5/rtLC63avSPCLNGOr5epH9qp63F0Dd
         +JL8jtm+Q8vnzx/OQEkE7A8C8M6lbpC+a3UyG5q7yrUVs0MUV+eSOwDpX136tCe88/Ay
         ek6H/uJtvQt2IH52l7srXmuf2GoaaeKq0Vesu9fw9bzVPHNldJgHHpiq/LJ3Qx/+oh53
         7NKfZSwnGap/GF1z5LI1rjZuD0ud1Y0v2JSxEjNs1ESwQv2PkFYXnsmJHB2TTPsJLGPM
         EcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199442; x=1790804242;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27SgLD1I/Cvv7dG/kGYKQA4JzrNe4m10wNb0sLptOo0=;
        b=k0TlkF+bL8pqXYV1TmqOw/ZcjwgNwBoMqeZjzefpG1dQRGD9l1gkZzohpbtOzKWxuL
         wOhljyf4GsoXWo3aChl6gdekWnUfFscQ3MFgR9q1KKV+HDnF7Uxq4zg/SmqrJiEaIOZp
         eZahyyseCm3GnIrLF1+guUN070vn9vE2O1JAC+cktRd26HaAgBZrojMv5lx7h8ODT3l4
         lhRWVgLOR20Ab+W70uAozZKxTwjINDS8TQCQkO/MoRXeZVv3KAJ+6C7spMPx9idHjoIu
         duLasbhW9wBVCQK+yx16as4/r65pVQp+UvscVni+Qx5ryhlRxypmaMdyhsVCnt8MKvcg
         4JAg==
X-Forwarded-Encrypted: i=1; AKwUvBxCXrFdCSPvS501pMmZQWUVOIVxbqbxIGCJDidbtkOuGImxfFLHjNzhOp415Bag4Fu2Dh8=@vger.kernel.org
X-Gm-Message-State: AFuF++lUmSDhJFXTpD8pZoLaT3xLhBexDU4VzazUCj3AnykDPUVzTkiI
	0EflnQE0q7/r9RThplUmgaUmEJU79mq0QEApRXwwk1AtmmcT4DvhVmQeOKC5/B96GOX7phFBfIk
	U2Zm0WQ==
X-Received: from pfbgp6.prod.google.com ([2002:a05:6a00:3b86:b0:87a:d557:6bfe])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6088:b0:87c:b5c0:738
 with SMTP id d2e1a72fcca58-87e993770a9mr337321b3a.19.1790199442355; Wed, 23
 Sep 2026 14:37:22 -0700 (PDT)
Date: Wed, 23 Sep 2026 21:35:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260923213719.224838-1-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 0/8] bpf: Add bpf_tcp_ops hooks for TCP AutoLOWAT.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series introduces two callbacks for bpf_tcp_ops:

  .enqueue_rcvq(): invoked when TCP stack enqueues skb to
                   sk->sk_receive_queue

  .dequeue_rcvq(): invoked in tcp_cleanup_rbuf() after data
                   is dequeued from sk->sk_receive_queue

Those callbacks can be enabled on a per-socket basis by
bpf_setsockopt():

  int flags = BPF_SOCK_OPS_RCVQ_CB_FLAG;

  bpf_setsockopt(sk, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
                 &flags, sizeof(flags));

or via the bpf_tcp_ops-specific helper added in the next patch:

  bpf_sock_ops_cb_flags_set(sk, BPF_SOCK_OPS_RCVQ_CB_FLAG);

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

The bpf prog in the last selftest patch closely mirrors the core
logic of the original implementation to provide a real-world
example.

Note that the new callbacks are not supported on legacy SOCK_OPS.


Changes:
  v2:
    * Add patch 1 not to allow setsockopt() from new callbacks
    * Patch 8 (selftest)
      * Avoid address comparison for a specific version of gcc.
      * Make rpc_test_cases[] static.
      * Update comment in rpc_test_case[].

  v1: https://lore.kernel.org/bpf/20260920195633.3033620-1-kuniyu@google.com/

Legacy SOCK_OPS version:
  v3: https://lore.kernel.org/bpf/20260523083001.2911931-1-kuniyu@google.com/
  v2: https://lore.kernel.org/bpf/20260522074601.1658705-1-kuniyu@google.com/
  v1: https://lore.kernel.org/bpf/20260508073355.3916746-1-kuniyu@google.com/


Kuniyuki Iwashima (8):
  bpf: tcp: Convert deny-list for bpf_{get,set}sockopt() to allow-list.
  selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS + 1 for bad_cb_test_rv.
  bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
  bpf: tcp: Support bpf_sock_ops_cb_flags_set() for bpf_tcp_ops.
  tcp: Split out __tcp_set_rcvlowat().
  bpf: mptcp: Don't support BPF_SOCK_OPS_RCVQ_CB_FLAG.
  bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
  selftest: bpf: Add test for bpf_tcp_ops.{enqueue,dequeue}_rcvq().

 include/net/tcp.h                             |  34 ++
 include/uapi/linux/bpf.h                      |  13 +-
 net/core/filter.c                             |  10 +-
 net/ipv4/bpf_tcp_ops.c                        | 135 ++++++-
 net/ipv4/tcp.c                                |  14 +-
 net/ipv4/tcp_fastopen.c                       |   2 +
 net/ipv4/tcp_input.c                          |   4 +
 tools/include/uapi/linux/bpf.h                |  13 +-
 .../selftests/bpf/prog_tests/tcp_autolowat.c  | 350 ++++++++++++++++++
 .../selftests/bpf/prog_tests/tcpbpf_user.c    |   3 +-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   2 +
 .../selftests/bpf/progs/tcp_autolowat.c       | 312 ++++++++++++++++
 .../selftests/bpf/progs/test_tcpbpf_kern.c    |   3 +-
 13 files changed, 866 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_autolowat.c

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

