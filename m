Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67582DF13B
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789934197; cv=none; b=kPbSfsG12RVp1CESiV9V1miwc3Z5X+9gLBQiSKyHN6NOMFQTD1TFrATV1Xq2jVFm0te7DQen7S6OGPprZZryQNNX8G96uZ9REMb36RNGJ7VMfnRjz/2dIk66zxY6ZsFX5HtnKJR90BaWCYrCGk9DCWq4Ae2Pyi8B7e5eYKRqFKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789934197; c=relaxed/simple;
	bh=2M+zZ46WjDWkuw6jAFwlSuElh82u89s3wPdtIRsEfxI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qbd4xh9H184NMuuSQTHcuMwME0+L1WpJEolz2zhQJVGj+QIPWDz8LmGRBLmUVVnSUJKLKakVUOCFEIcR44J9ZNoZz2as7bjHJGt2Q13xGhKG0YqYWUUgFMpgUF08gg9wbutTg++5CFqcmNBsNcR9uMBqnDNoQUmv71HoIbhK4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FJemOOAI; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJemOOAI"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8623e5d4279so4147921b3a.1
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 12:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789934195; x=1790538995; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M7xlMcM7k7NmdYoMcu//TATkd+slGsM+tuPmkLctMrQ=;
        b=FJemOOAIkT0jpCu11wic2PvfOmcgZX694X/FuLdEC8br3OoNTt+YmiJhLTafP8KQ7f
         6IxrjoTVUGgkWX9xJMJVEc5VO5bweBI+iTixt7YvmhYJFij/Jix/3oj6XZ5JOkMuoRCL
         MZyQ0GM9FG0VbQ1yyAT0vjoXy44MdHfNCP9582yXcy/rYoGq2xshjdZMiC4zEOzEOxd+
         /cSTektQJftklDZQAA6+5MGe16cipG6YT7/z3NRpXFhifDou4NLoEf+aVtCh5iAYYPYX
         DCr+d9HVJjcFk/c487xHwP//u4HlM4jdbbu7bclwIH6HSjplXzQ01mxiDgBM/S+JYx0p
         S2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789934195; x=1790538995;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M7xlMcM7k7NmdYoMcu//TATkd+slGsM+tuPmkLctMrQ=;
        b=ObsFMLpbFD3UWViCmprVOQg6XB4AnxA0LEq9wiNifki3x+mT21tl+IF/JFqdfkn9p5
         DzBINReY1/F9i+/eOtA8FKChphF9B7dxGBgdZYIz4jRj/aK9WFmQPwXy6FYn+jH74GX3
         wPZM8Krw9ydt14T1kBnAQBz2KpokyN6oTYixl4NC+disdxGymvJ6JT80iqelqrL7rKy9
         hsGqPFeVJF03ney9sLXuC8dohZah8QeH1gWG424OjL2k70DIQuerZypW2ToJ4SCTMrGB
         k/ymfMMQIMggxnIMklZiSg0MOGzi/ZzFPtZWD95ffT+oAsq5jwai0ogprqnnodaaNnsQ
         doTA==
X-Forwarded-Encrypted: i=1; AKwUvByjAwSzVV1FcQkSJQDXun5wn8i14FWb24krklavX7S1Z9tg7zi1x5wBrUTPa6Ecf8OfCLU=@vger.kernel.org
X-Gm-Message-State: AFuF++krDOHBtyULFHtQCGjulKA5ojZ5FwgQztsqukcuW+ZLpCRQ5mn3
	Jf/kmSqL2cyqGEdPYxGv/2FZcPuVrGLwHSBtDjt8zzPPMOgwP5XISMWrQqnLA6CxGB0SEIX5FXb
	sW9VIYQ==
X-Received: from pfiv14.prod.google.com ([2002:aa7:99ce:0:b0:853:9149:8801])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c8e:b0:878:34d7:697a
 with SMTP id d2e1a72fcca58-87834d7df67mr4963513b3a.40.1789934195003; Sun, 20
 Sep 2026 12:56:35 -0700 (PDT)
Date: Sun, 20 Sep 2026 19:56:09 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260920195633.3033620-1-kuniyu@google.com>
Subject: [PATCH bpf-next 0/7] bpf: Add bpf_tcp_ops hooks for TCP AutoLOWAT.
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

Legacy SOCK_OPS version:
  v3: https://lore.kernel.org/bpf/20260523083001.2911931-1-kuniyu@google.com/
  v2: https://lore.kernel.org/bpf/20260522074601.1658705-1-kuniyu@google.com/
  v1: https://lore.kernel.org/bpf/20260508073355.3916746-1-kuniyu@google.com/


Kuniyuki Iwashima (7):
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
 net/ipv4/bpf_tcp_ops.c                        |  96 ++++-
 net/ipv4/tcp.c                                |  14 +-
 net/ipv4/tcp_fastopen.c                       |   2 +
 net/ipv4/tcp_input.c                          |   4 +
 tools/include/uapi/linux/bpf.h                |  13 +-
 .../selftests/bpf/prog_tests/tcp_autolowat.c  | 350 ++++++++++++++++++
 .../selftests/bpf/prog_tests/tcpbpf_user.c    |   3 +-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   2 +
 .../selftests/bpf/progs/tcp_autolowat.c       | 312 ++++++++++++++++
 .../selftests/bpf/progs/test_tcpbpf_kern.c    |   3 +-
 13 files changed, 842 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_autolowat.c

-- 
2.55.0.1082.g2b9226bbc0-goog

