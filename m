Received: from mta1.migadu.com (out-65.mta1.migadu.com [95.215.58.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526B3472094
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039283; cv=none; b=X+2iGA5B6jTJMMGGvt+I1FRyhnC5pnLZgKTn/0KNJKkkb8HuyoyKedIfdxgBMVQ+lPgnv3EDZb3LMeI1R1bQpGZQAXKGv+zxLveuDjW+Mffbqv0SBpBc6P9cdf1dfHf6AaPcCmsEUBsgZg29lQz+J9WXHq2hUJ4QrbTKfVvjwOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039283; c=relaxed/simple;
	bh=AV/OFTDfC0/OmXuQQ9vQBP4PE/RPxM4KkzhtVQdtba4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4LYgH3MFwPhlvagUvRSJB4vec+at7+KX+RmOAC3ua3NOEwZtPLvY3vkxPF0WUWTlcW2fF5lACSQRUMU3FkMnJnPZB7HssIC1Xj4KpSjtNzEeSJ8/U6dM24+kMQN3MKvt5IU4x1GIjJW/hKPKOwnU97ImBHfzyVBubivkaANJGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pXL1P7pG; arc=none smtp.client-ip=95.215.58.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pXL1P7pG"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AV/OFTDfC0/OmXuQQ9vQBP4PE/RPxM4KkzhtVQdtba4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789039278; v=1; x=1789644078;
 b=pXL1P7pG0xAOewStya2yRhLP8nS8P6NvJkODY+9l8WcuQRhUw+8l6ZozlEfo6+BrHtV+Srqt
 5ss0ZwX3k4eddiBl0+IOD7aoa3uuIM9tVX3buErwER+GzDO3D5v5PfEPp7wUp7Qduj8iq2vay/6
 UMSKcK4oGQivGgOVUzbGOb6c=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 83cf4aa7dd699a22;
	Thu, 10 Sep 2026 11:21:18 +0000
X-Mizu-Trace-ID: 83cf4aa7dd699a22
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
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
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3 0/3] bpf,tcp: Fix bpf_sock_destroy() on TIME_WAIT and listener socks
Date: Thu, 10 Sep 2026 19:20:44 +0800
Message-ID: <20260910112107.148770-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two bugs in bpf_sock_destroy(). One is an out-of-bounds read of
sk->sk_protocol on TIME_WAIT and NEW_SYN_RECV socks, since the field is
not in struct sock_common. The other is a might_sleep splat when
destroying a listener with children in its accept queue, the
cond_resched() in inet_csk_listen_stop() runs under the iterator's
rcu_read_lock(). Patch 3 adds a subtest for each.

v2 -> v3:
 - Patch 1: add Reviewed-by from Kuniyuki.
 - Patch 2: reword why cond_resched() has to go, it can reschedule or
   report a bogus quiescent state there.
 - Patch 2: keep the cond_resched() for the non-BPF path rather than
   removing it as Kuniyuki suggested. VOLUNTARY and NONE are still
   there on some arches, and on x86 in stable where this goes, so a
   big listener close() still relies on it. Can go once those modes
   are gone.
 - Selftest: don't leak the fd if accept() unexpectedly succeeds.
v2: https://lore.kernel.org/bpf/20260906074135.185212-1-jiayuan.chen@linux.dev/

v1 -> v2:
 - Patch 1: fix the return comment too.
 - Patch 2: new.
 - Selftest: server recv()s EOF before close so the FINs can't cross,
   comment style, keep the blank line before RUN_TESTS(), add the
   tcp_listen_pending subtest.
v1: https://lore.kernel.org/bpf/20260903125306.299943-1-jiayuan.chen@linux.dev/

Jiayuan Chen (3):
  bpf: Fix out-of-bounds read of sk_protocol in bpf_sock_destroy()
  tcp: Skip cond_resched() in inet_csk_listen_stop() under BPF context
  selftests/bpf: Test bpf_sock_destroy() on TIME_WAIT and listener socks

 net/core/filter.c                             |  13 +-
 net/ipv4/inet_connection_sock.c               |   3 +-
 .../selftests/bpf/prog_tests/sock_destroy.c   | 121 ++++++++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   |  30 +++++
 4 files changed, 162 insertions(+), 5 deletions(-)

-- 
2.43.0

