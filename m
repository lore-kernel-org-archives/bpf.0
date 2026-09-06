Received: from mta0.migadu.com (out-147.mta0.migadu.com [91.218.175.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C52C3BB69B
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788680574; cv=none; b=d81q6j8lE3wRnKPdGTZg0hDykTvUGexlJvQHut6XASL8LjszFItljEStzqt7de7A2uHWyku3ubvvQ5m9Ee3vzAQH21Gjs5iSh3f0XOU6pEbbVz3YiwKJBxCHluDkEdy88C3jLzddzXFiRE9aUtTRIye9Q7WpbpoG/KHyoIO+LME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788680574; c=relaxed/simple;
	bh=z7yZlf33a9kbZGQmD+FmdOWuDoUNMGHembcGvT1Q4oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8eAGNeCV3uMKh1gcGxjpKvBW0X5ohpgUDi0Ec6Iy6peQXPzyeVl2ZWeK/4i2z0DCC+C0jutEBYU59feWTXrPae/a97KticrF+tNnfa9fdWzdBZIA166y+26xRAyHlx38tvEA1WZeZzQXQRuoK0pXOusSTej08CfsPAHYeuBKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PS0LeDrR; arc=none smtp.client-ip=91.218.175.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PS0LeDrR"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=z7yZlf33a9kbZGQmD+FmdOWuDoUNMGHembcGvT1Q4oY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788680571; v=1; x=1789285371;
 b=PS0LeDrRm/8yjP7Pm1AYBFWwijZ0qvFU6wgdHFtx3cvecB45tXYMw56wN1bVXnroCzNNoJh+
 qyktjxRXVsASQCwPmflqIU6p15nKOL7cZyQ3Hi8DZKvZ7Tq/c2r33A3FykIx4bvfbNCjzUHpNNb
 XQmdKhJ8dy4/76Gt1QQ5g+aM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 58940fcb809ddae9;
	Sun, 06 Sep 2026 07:42:51 +0000
X-Mizu-Trace-ID: 58940fcb809ddae9
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
Subject: [PATCH bpf v2 2/3] tcp: Skip cond_resched() in inet_csk_listen_stop() under BPF context
Date: Sun,  6 Sep 2026 15:41:03 +0800
Message-ID: <20260906074135.185212-3-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260906074135.185212-1-jiayuan.chen@linux.dev>
References: <20260906074135.185212-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_sock_destroy() runs from the tcp iterator, under rcu_read_lock(). If
the sock is a listener that still has children in its accept queue,
tcp_abort() ends up in inet_csk_listen_stop() and the cond_resched()
there trips the debug check:

BUG: sleeping function called from invalid context at net/ipv4/inet_connection_sock.c:1523
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 628, name: test_progs
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
locks held by test_progs/628: 3, last CPU#3:
 #0: ffff8881158cee18 (&p->lock){+.+.}-{4:4}, at: bpf_seq_read+0x56/0x1210
 #1: ffff8881106bb858 (sk_lock-AF_INET6){+.+.}-{0:0}, at: bpf_iter_tcp_seq_show+0x32b/0x4b0
 #2: ffffffffb435af20 (rcu_read_lock){....}-{1:3}, at: bpf_iter_run_prog+0x46b/0xde0
CPU: 3 UID: 0 PID: 628 Comm: test_progs Tainted: G        W           7.2.0+ #65 PREEMPT
Tainted: [W]=WARN
Call Trace:
 <TASK>
 dump_stack_lvl+0xc1/0xf0
 dump_stack+0x10/0x20
 __might_resched+0x3d2/0x610
 inet_csk_listen_stop+0x7b/0xbf0
 tcp_abort+0x23b/0x3b0
 bpf_sock_destroy+0xfc/0x140
 bpf_prog_448133d24601754f_iter_tcp6_server+0x81/0x8a
 bpf_iter_run_prog+0x538/0xde0
 bpf_iter_tcp_seq_show+0x26b/0x4b0
 bpf_seq_read+0x424/0x1210
 vfs_read+0x197/0xe40
 ksys_read+0x119/0x240
 __x64_sys_read+0x72/0xc0
 x64_sys_call+0x647/0x27e0
 do_syscall_64+0xe5/0x610
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fad39b28aca
RSP: 002b:00007ffc381c61c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007ffc381c6a88 RCX: 00007fad39b28aca
RDX: 0000000000000032 RSI: 00007ffc381c6250 RDI: 0000000000000014
RBP: 00007ffc381c61e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 000055f077c1bbb0 R15: 00007fad3a0f3000
 </TASK>

The commit that added the kfunc already guards lock_sock() in tcp_abort()
and udp_abort() with has_current_bpf_ctx(), but missed the listener path.
Do the same for the cond_resched(), it can't reschedule there anyway.

Fixes: 4ddbcb886268 ("bpf: Add bpf_sock_destroy kfunc")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv4/inet_connection_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6257459bcee2..6a30f1138454 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1520,7 +1520,8 @@ void inet_csk_listen_stop(struct sock *sk)
 		local_bh_enable();
 		sock_put(child);
 
-		cond_resched();
+		if (!has_current_bpf_ctx())
+			cond_resched();
 	}
 	if (queue->fastopenq.rskq_rst_head) {
 		/* Free all the reqs queued in rskq_rst_head. */
-- 
2.43.0

