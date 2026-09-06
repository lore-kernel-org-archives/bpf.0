Received: from mta0.migadu.com (out-131.mta0.migadu.com [91.218.175.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE78834EEE5
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788680531; cv=none; b=SV+eIwtvuzDVQU9I5wXJbp+6fxy43rG19LppEBQykV8ur84ZjQM5jNLs77w1Z8LBzRUqRDDzkHalMcBD4Ccu+TJCYqjgzURnSyWQFjRbJNSCA22zJFj8Ypxooixs18Ig5wTNQaDWN8SdrzxUygTQTmxlzScHvRjR5YdER9BcVZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788680531; c=relaxed/simple;
	bh=63KHiFfHLGH3Q099di+5QV4oPkQj3cHpP147t4LHXJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GABsbSx27vEKfh0kVOSrtnSGfwwwT33dyvmWANjBDB/003YXQnMVULwTRVGKKaTVxUP9VD/jXWb/zpFx1WBXX/fAhzcpjFLC6iWBDILiG8QHqgAYb+V6ykO0H9jZ/+v2dPq+yRe1156ftg75veWXzSmJLWpfblsmS/z90r8uQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CK/Cy9b+; arc=none smtp.client-ip=91.218.175.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CK/Cy9b+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=63KHiFfHLGH3Q099di+5QV4oPkQj3cHpP147t4LHXJE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788680527; v=1; x=1789285327;
 b=CK/Cy9b+0FILOOy3s/4m+/EIrZKO3xrDxSozP4tcqaWNPyJWrQS0Zf+K2iCwuxq3O+5zs8Qo
 CwAOs1ai4vtE1tY+2Aa1DmK26apIb8LZyYqwBphkfZVRRpG3BpZ4Wg1FJrNbqL2nqcenMkAbjC9
 L0iswk4a8UXF0MazboG5EN90=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f45d4e25d8183e57;
	Sun, 06 Sep 2026 07:42:07 +0000
X-Mizu-Trace-ID: f45d4e25d8183e57
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
Subject: [PATCH bpf v2 0/3] bpf,tcp: Fix bpf_sock_destroy() on TIME_WAIT and listener socks
Date: Sun,  6 Sep 2026 15:41:01 +0800
Message-ID: <20260906074135.185212-1-jiayuan.chen@linux.dev>
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
 .../selftests/bpf/prog_tests/sock_destroy.c   | 119 ++++++++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   |  30 +++++
 4 files changed, 160 insertions(+), 5 deletions(-)

-- 
2.43.0

