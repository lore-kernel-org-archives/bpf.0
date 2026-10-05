Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6E74CB8AA
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215143; cv=none; b=AZE3acRwp662+sOo5KSK2aRcqS/XJFq0dvN8fj2fpg+WWpMIX5JKMuvb1/ISaw/8iem1nY8lPytXpVtwAhTXPOFHSnxJhH7EnvsaFoX8bxvxKV7lSYzVvLOJCxinzqirmg2aQadn9Wm2rYDnBwn4dyfJk/dZNVSBbuZrzf0Ek9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215143; c=relaxed/simple;
	bh=Nx4WkT8YX1B7IBxL1aRs4iVt/ySZY/aq4dV1P7xiVPQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D377lP1zDN69zAOGAYqsGO26KQjn7OM8XD3UbBqjLOkcBoHStPR+kdsQHt1DprNCpRQ4udYKEviJV6RpW9v4lv0igXFYtfYbtdKt5ScSzmwTxPV+gXlNxP5bLxDYFBe7D00gCgWLq3vBQtzMtbmZZXha3609HrwN6meXK4VLsgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v2JUm+CS; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2JUm+CS"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8872ada18d7so1770612b3a.1
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791215138; x=1791819938; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jzLQiNfC94upUpKAzGAz5GZxNgckj7DlI34uxjYP4P8=;
        b=v2JUm+CSugguOqYfYYUk+bBcp+dsZpnCw+T5FvP7PNnc4si19Q8q/9f4jC49chvndH
         7z1DIK+VrGC3RXxj4Uh9ZOvWZeXOUKg2T70PjGNyktai/SPtWiB/FrnBcfRz+VDCKZ7U
         jSL+LvGBRUCzmk8bT4KyXKjjYoaXC/kHmPipXF6ZZojdyFX7mvHAzxJOIBCVtyCVnbMa
         A5bMIK4/NuTyxVoK6ZSKrGb9/y7ui+cD6f73XB9ParwLbfQ7YtuluE5jJNznhH4I0PrR
         kOfdcif46hdTqStuCj11qNBqmAvHaKjkCXl6nxNK+WvDM0VmdbGboQCwz9SWdACgXwja
         7CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215138; x=1791819938;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jzLQiNfC94upUpKAzGAz5GZxNgckj7DlI34uxjYP4P8=;
        b=Q1uPl/TshGckZYdMlzvni/l8OVRt7V0utmY4XbQb0n7I3t8HzWckwlQ03v1lyClKwJ
         zKyeIivFzUu8oQMNWK0awHuupksc2JQEANIgGR3LkHUq6/altEsfPSeupkB1sXoS0GN5
         TT5HgjxO3tK38hoFmEmW3YQ3au0mlcnug1x1OfYtMM3keKNZXzviCwq8Lv2Bn0vwafcT
         EUAYH8PweDcoCnMY6wge2Ay7CutcApdjQhpDMuKSbxVbZKN6RZ+EcqfU2lP9OurMcgBz
         i17eXXH++x69Y+bklsZPT2uKJOq8NIW5Qxktnc6Rla5o4pdGqPmi/XmPnDZ8dwdMd67I
         NBRA==
X-Forwarded-Encrypted: i=1; AKwUvBy9MLZTzx0WHgp28PlkYyugzGw9UCneqDu98OzkH3qL3GBCQLZD7PlVn72DhYbuj7idBiw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGyYWv59qutMbADKwnRw/4SVvc4VoUbY/T7zUQtadER9P1I2Fx
	CcBzpum1fMiAMfeQjDuOLWV/xwsXDWIfFbkxz4oFFKGOV2TFOzmpbNcRLmfwHoypMyFlNCwiRSj
	90NXW6A==
X-Received: from pfbdl4.prod.google.com ([2002:a05:6a00:4904:b0:888:2e48:6a84])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94f1:b0:882:2195:5a6f
 with SMTP id d2e1a72fcca58-88c636a8b9dmr6828589b3a.43.1791215138241; Mon, 05
 Oct 2026 08:45:38 -0700 (PDT)
Date: Mon,  5 Oct 2026 15:40:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005154533.4147685-1-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 0/9] bpf: Add bpf_tcp_ops hooks for TCP AutoLOWAT.
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
  v3:
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


Kuniyuki Iwashima (9):
  bpf: tcp: Convert deny-list for bpf_{get,set}sockopt() to allow-list.
  bpf: tcp: Add a new per-socket flag and kfunc for bpf_tcp_ops.
  selftest: bpf: Use bpf_tcp_ops_set_flags() in bpf_tcp_ops_hdr.c.
  bpf: tcp: Guard fast-path bpf_tcp_ops_call() under per-socket flag.
  bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
  tcp: Split out __tcp_set_rcvlowat().
  bpf: mptcp: Don't support BPF_TCP_OPS_FLAG_RCVQ.
  bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
  selftest: bpf: Add test for bpf_tcp_ops.{enqueue,dequeue}_rcvq().

 include/linux/tcp.h                           |   7 +
 include/net/tcp.h                             |  23 +-
 include/uapi/linux/bpf.h                      |   9 +
 net/ipv4/bpf_tcp_ops.c                        | 154 +++++++-
 net/ipv4/tcp.c                                |  17 +-
 net/ipv4/tcp_fastopen.c                       |   2 +
 net/ipv4/tcp_input.c                          |  11 +
 net/ipv4/tcp_output.c                         |  20 +-
 tools/include/uapi/linux/bpf.h                |   9 +
 .../selftests/bpf/prog_tests/tcp_autolowat.c  | 350 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     |  20 +
 .../selftests/bpf/progs/bpf_tracing_net.h     |   2 +
 .../selftests/bpf/progs/tcp_autolowat.c       | 294 +++++++++++++++
 13 files changed, 889 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_autolowat.c

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

