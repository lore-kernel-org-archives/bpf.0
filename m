Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB836923F
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 03:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429369; cv=none; b=Z0FhZj1n8saUCCHJKiMFZ6d27MadTQIGkqm244SbcJJ7LhicF2d8RMPVZoNs8cAGm+mjrJaeBnDnf/bWIjO2h60FCrUqIiaOBlv76Gj85QdkMXTemEszD3Rj+riNvsPRhwGDVJmcOuqjDNxF9DOPxw64kIJn75Nnhe3dCIItGIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429369; c=relaxed/simple;
	bh=AXCXHk09OzNmxEjC4yZ13QKLrdc6Ad3tuYvTKTd2o3c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S4bRTHgGFndGSyKhqGv9i562gg3N11UCpjcICFVTt42V9E3CwgfK6pxEW8zP681wI6S6cAvz9UMs3OYG0UotpI+tnKnho693c0zOihft6xPCjPV1iIdKBVAKRRIziC4iS541GNSDCZCBgZy5Zvl2/X3DytzieMzILgMgjGqDNQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ktjUTy5x; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktjUTy5x"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8886059d3faso9691391b3a.2
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 20:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791429367; x=1792034167; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MDo6yBNzGh7wfI8PQp0GIPMbc3Xn0RNsqaXiwgY9tk8=;
        b=ktjUTy5x1s9JXbs03+IURYAH+RY/iEYpe0C9i/2XJ6ErNAmDoHBTld9gGj4Bj4Zi/y
         kB8FKrAOji/AlYJ3HGEeeh24J18NjIo/a8/OabaYAq3f5YYPOu9JGnwtGm6aqfKf/pfo
         G2vGHwh5pf+ipmXlBba4HZ8Rfy1NF2MIwObGiVpZIlKgy4ldtn8m3tnhIHHutCcXaQq5
         AjzsKDb9LZ4swR9hb2VUdpTMVtZov2Kpe1VEAv+sC8q2+i0dtUl143+bOHJab5arjz58
         dO+prw1ptcO/P8V5XYiaMAOhNwqY4xvhabyImmv/l/ItDQwon+oFjTJ0xXWcXrQrAvli
         T7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791429367; x=1792034167;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MDo6yBNzGh7wfI8PQp0GIPMbc3Xn0RNsqaXiwgY9tk8=;
        b=OTSYAc0r78YsNP/eQ/3uPd41Nrytpvo0+72XFs9wcf49HtMZrp+QCJR+iyxvjur/z7
         uH2sdQZrKFOAMyjMIHoNQqXiwsa9UDnqO6G4ZssC+zAuFNjMjQTPdtAZKu4qCHk34rJv
         DOp9bVZgPQe6Iabp3w/9xHr70a8WneV9/qQnXLNMLqE/9meIRIhKKt6MNyVxhfi4kQyc
         tKpDTwQKmrZnm/k/pOS/Pusm8TjIcLloJE6RNoy9C7na/Cx0Bz6/dIaLPLgZJhY3kXMa
         3B00tW/3Z1LPBwb5av2cUR5cY54MfGRc8C49msg+l2aMiDEQvRn2y3sN/nNKCqz+Svvm
         T5gQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/gRtY7DO9DTjFO2qCTv6xU5goGKsRD/qAsIZsvBxbYV4DmAozKwtu9nY7e/FVrPWB1v8=@vger.kernel.org
X-Gm-Message-State: AFuF++mKibPbmuMv5eOIqzPQAvwKYAX3QYGJKcO4ZikAzRL35bMsvzuu
	ICPR+yWpNoQ8cvBtfWYdb5a1dkc8kZmRyQ3YUqOoEw2oUa2omzh8ED1irLNgWnDW5ZdMS71bJaq
	zvUIYwg==
X-Received: from pgbfm8.prod.google.com ([2002:a05:6a02:4988:b0:cc7:6c9d:d39])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7104:b0:3e0:df21:9df4
 with SMTP id adf61e73a8af0-3e134176a5dmr3540862637.61.1791429366778; Wed, 07
 Oct 2026 20:16:06 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:15:20 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008031604.256498-1-kuniyu@google.com>
Subject: [PATCH v5 bpf-next 00/10] bpf: Add bpf_tcp_ops hooks for TCP AutoLOWAT.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series introduces two callbacks for bpf_tcp_ops:

  .enqueue_rcvq(): invoked when TCP stack enqueues skb to
                   sk->sk_receive_queue

  .dequeue_rcvq(): invoked in tcp_cleanup_rbuf() after data
                   is dequeued from sk->sk_receive_queue

Those callbacks can be enabled on a per-socket basis by
a new kfunc bpf_tcp_ops_set_flags():

  bpf_tcp_ops_set_flags((struct tcp_sock *)sk,
                        BPF_TCP_OPS_FLAG_RCVQ, 0);

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
  v5:
    * Patch 4 & 5
      * Always inline bpf_tcp_ops_hdr_opt_len() and
        bpf_skops_hdr_opt_len() to tcp_established_options().

  v4: https://lore.kernel.org/bpf/20261006192601.1875100-1-kuniyu@google.com/
    * Patch 2
      * Allow-listed BPF_PROG_TYPE_CGROUP_SOCKOPT and _SKB
        in bpf_tcp_ops_set_flags_kfunc_filter()
      * Add doc for flag enum and bpf_tcp_ops members
    * Patch 4
      * Check static key first and then flags
    * Patch 5 (new)
      * Bubble up static key check for SOCK_OPS similar to bpf_tcp_ops
    * Patch 6
      * Use bpf_tcp_ops_call_flag()

  v3: https://lore.kernel.org/bpf/20261005154533.4147685-1-kuniyu@google.com/
    * Add patch 2 ~ 4 (guard bpf_tcp_ops w/ a new flag)
    * Patch 5 & 9 : Adapt to a new flag and kfunc

  v2: https://lore.kernel.org/netdev/20260923213719.224838-1-kuniyu@google.com/
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


Kuniyuki Iwashima (10):
  bpf: tcp: Convert deny-list for bpf_{get,set}sockopt() to allow-list.
  bpf: tcp: Add a new per-socket flag and kfunc for bpf_tcp_ops.
  selftest: bpf: Use bpf_tcp_ops_set_flags() in bpf_tcp_ops_hdr.c.
  bpf: tcp: Guard fast-path bpf_tcp_ops_call() under per-socket flag.
  bpf: tcp: Check BPF_SOCK_OPS_TEST_FLAG() after
    cgroup_bpf_enabled(CGROUP_SOCK_OPS).
  bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
  tcp: Split out __tcp_set_rcvlowat().
  bpf: mptcp: Don't support BPF_TCP_OPS_FLAG_RCVQ.
  bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
  selftest: bpf: Add test for bpf_tcp_ops.{enqueue,dequeue}_rcvq().

 .../networking/net_cachelines/tcp_sock.rst    |   1 +
 include/linux/bpf-cgroup.h                    |  36 +-
 include/linux/tcp.h                           |   7 +
 include/net/tcp.h                             | 122 +++---
 include/uapi/linux/bpf.h                      |  25 ++
 net/ipv4/af_inet.c                            |   2 +-
 net/ipv4/bpf_tcp_ops.c                        | 159 +++++++-
 net/ipv4/tcp.c                                |  20 +-
 net/ipv4/tcp_fastopen.c                       |   2 +
 net/ipv4/tcp_input.c                          |  37 +-
 net/ipv4/tcp_nv.c                             |   2 +-
 net/ipv4/tcp_output.c                         |  89 ++---
 net/ipv4/tcp_timer.c                          |   6 +-
 tools/include/uapi/linux/bpf.h                |  25 ++
 .../selftests/bpf/prog_tests/tcp_autolowat.c  | 350 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     |  20 +
 .../selftests/bpf/progs/bpf_tracing_net.h     |   2 +
 .../selftests/bpf/progs/tcp_autolowat.c       | 294 +++++++++++++++
 18 files changed, 1052 insertions(+), 147 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_autolowat.c

-- 
2.56.0.360.g66cac248cb-goog

