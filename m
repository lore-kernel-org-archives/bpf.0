Received: from mta1.migadu.com (out-243.mta1.migadu.com [95.215.58.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070C265621
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247233; cv=none; b=eLxU2pX70GbVavMsnNEI4nudMS4tNZfCiZPZAtYfzQGVVO6IILj7FQtJ/HXaLROBjrarxXUkGaNz0ZWR65L+82BFwB1BSJO1XJwYSRVcCnMiZ/KliL1y0dBrEHCQ8xgbL5fzD89H1cAD3mzgS/kNz6zRmIJT8Dho7yn4t3MYRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247233; c=relaxed/simple;
	bh=UL4pprsZO6OvfXb1upkca/LW8TWZV/38NQpc3vG1cyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HFD3SPqvKt2ho1YEPVDC+5C5gCze0BbtkH/9x+hqL/7RFLxdNmkLkINisLwAzR7pWp07wSapQrKSCnyhJUCspEiumXvhP5ru/FDC+7i9LW9v7Z6nMt5Xub9z16c6CIiNQSHhVcp0sp7XrnxLRC3TRT558EyHReBvsDDT7dOm7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N27RD/ET; arc=none smtp.client-ip=95.215.58.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N27RD/ET"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UL4pprsZO6OvfXb1upkca/LW8TWZV/38NQpc3vG1cyo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792247226; v=1; x=1792852026;
 b=N27RD/ETTodehjoSXR49uO60gF+xbg+uYw19P0I7B+S9LtJ39ek11ennyKC9oJFgR077Vozd
 XWjqdrc871LwI0Id2jvld6YB8ZICeRb6HwmopeJW4i8fFyXW2tQPGdpSFRiKVXKASw4guo644TP
 MHu+woDz0kf3QOapH6naiIKQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4c3ee20dda7a1f97;
	Sat, 17 Oct 2026 14:27:06 +0000
X-Mizu-Trace-ID: 4c3ee20dda7a1f97
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Masashi Honma <masashi.honma@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next 0/6] bpf: Add syscall common attrs support for xdp link_create
Date: Sat, 17 Oct 2026 22:26:43 +0800
Message-ID: <20261017142649.51047-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm planning to add syscall common attrs support for LINK_CREATE cmd.

This is the first series for the plan, that adds syscall common attrs
support for xdp LINK_CREATE.

Thereafter, retire the tracepoint bpf_xdp_link_attach_failed, because
the underlying driver's error can be back-propagated to user space via
the syscall common attrs.

Leon Hwang (6):
  bpf: Add syscall common attrs support for link_create
  bpf: Add syscall common attrs support for xdp link_create
  bpf: Retire tracepoint bpf_xdp_link_attach_failed
  libbpf: Factor out __bpf_sys_fd helper
  libbpf: Add bpf_link_create_log API
  selftests/bpf: Add tests to verify link_create logs

 include/linux/netdevice.h                     |   3 +-
 include/trace/events/xdp.h                    |  17 ---
 kernel/bpf/syscall.c                          |  36 +++--
 net/core/dev.c                                |   7 +-
 tools/lib/bpf/bpf.c                           |  59 +++++---
 tools/lib/bpf/bpf.h                           |   5 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/xdp_attach.c     |  65 ---------
 .../selftests/bpf/prog_tests/xdp_link.c       | 132 ++++++++++++++++++
 .../bpf/progs/test_xdp_attach_fail.c          |  54 -------
 10 files changed, 215 insertions(+), 164 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c

-- 
2.55.0

