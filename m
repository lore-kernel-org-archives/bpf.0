Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31D73563FB
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 05:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338449; cv=none; b=Ac3uFDmbysHAiCUniZErDptAquV8rJqvrLZdZ/sJ3RmUc0k7dyrhgoqub6woV/GjLMFYEzf/2j32pnXoO4sYk8t4QTEti4X956snYFHrownvcTSt+aA7xgxpw62JKv5WtzmXNk6U/Xg1txBXZ56YBkqaHamvbwZx5qEcTa0Uk9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338449; c=relaxed/simple;
	bh=cN9fOHlhzQCJUUZ/oNquIJDiEWbujPcnOU3aiFTgFHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVUkj31b1lrZLZWY9j5+P1IceWGPm1WGSB0MoMvhB/JEYzc2xhylqhYmTY9vGOEIMvQwzTzpEQ1OAISJgXnlzhsQ3S9A5xvyZ0rJ+o024F4xgcfo7wfti4ACmeHz9YK4NuWc1b6P1GMK0GtBeoXLvsFygSpSoujxhpvsSJHThEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NVHzdADA; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NVHzdADA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786338435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6BlzNCm1R5ViSNCwoQn8bYwDnBQH2fyyHg6GdL4UoKs=;
	b=NVHzdADA41+4lrIJyGmSaQu0X7x62uzZRXC127sKN6WsF0/Je8MH9I1GoBtFUibeZxZwvM
	H33zg6nwMczlQRK9448KnOvI4Un/2l3/wO2jSePwAyF9nUlpyJuBmVlyEHabcHRuP4ikc9
	NUpfvRp7optO6T834yCeik9P7CkqV0M=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/3] bpf: prevent offloaded programs from running on host via tcx/netkit
Date: Mon, 10 Aug 2026 13:05:58 +0800
Message-ID: <20260810050621.82035-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Patch 1 fixes the reported bug [1]. Patch 2 fixes an old bug that was
already there. Patch 3 is a test that reproduces the bug in patch 2.

Patch 1 has no test here: the original report already has a reproducer,
and it needs netdevsim, which is not easy to do in a selftest.

An offloaded program runs on the NIC, so its bpf_func is set to
bpf_prog_warn_on_exec(). tcx, netkit and XDP run programs on the host, so
attaching an offloaded program to them hits the WARN on the first packet.
Patch 1 adds the check in bpf_mprog_attach(), the one place both tcx and
netkit go through. Patch 2 moves the XDP check into dev_xdp_install() so
the bpf_xdp_link_update() path is covered too.


[1]: https://lore.kernel.org/bpf/64d8e2b5-a214-4f3c-b9e8-bcedbcb2c602@hust.edu.cn/
 ------------[ cut here ]------------
 attempt to execute device eBPF program on the host!
 WARNING: kernel/bpf/offload.c:420 at 0x0, CPU#0: poc/337
 PKRU: 55555554
 Call Trace:
  <TASK>
  __dev_queue_xmit+0x22cb/0x3530
  ip_finish_output2+0x621/0x1a60
  ip_output+0x170/0x2e0
  ip_send_skb+0x129/0x180
  udp_send_skb+0x65d/0x1300
  udp_sendmsg+0x13bf/0x2000
  __sys_sendto+0x396/0x470
  __x64_sys_sendto+0xdc/0x1b0
  do_syscall_64+0x76/0x10a0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 ---[ end trace 0000000000000000 ]---

v3 -> v4:
  - patch 2: also move the two device-bound checks, not just the offload
    one, so the link update path can't skip them (from the AI review on v3).
  - add patch 3, a selftest for the link update path.
v3: https://lore.kernel.org/bpf/20260425105942.223757-1-jiayuan.chen@linux.dev/

v2 -> v3:
  - Alexei said to do the check in one place instead of spreading it
    across attach paths. Put it in bpf_mprog_attach() for tcx/netkit and
    move the XDP check into dev_xdp_install(). Three patches became two.
v2: https://lore.kernel.org/bpf/20260424104201.217604-1-jiayuan.chen@linux.dev/

v1 -> v2:
  - tcx/netkit: also reject offloaded progs in the link update callback,
    not just attach (from the AI review on v1).
  - add a patch for the same hole in bpf_xdp_link_update().
v1: https://lore.kernel.org/bpf/20260423033609.252464-1-jiayuan.chen@linux.dev/

Jiayuan Chen (3):
  bpf, tcx, netkit: reject offloaded programs
  bpf, xdp: move offload check into dev_xdp_install()
  selftests/bpf: xdp: test dev_xdp_install() rejects device-bound
    program

 kernel/bpf/mprog.c                            | 11 +++++
 net/core/dev.c                                | 27 +++++-----
 .../bpf/prog_tests/xdp_dev_bound_only.c       | 49 +++++++++++++++++++
 3 files changed, 75 insertions(+), 12 deletions(-)

-- 
2.43.0

