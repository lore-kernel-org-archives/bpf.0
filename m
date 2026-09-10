Received: from mta0.migadu.com (out-165.mta0.migadu.com [91.218.175.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F293472531
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039674; cv=none; b=hu3+5dxUvUBIofAS8jO3cDrwUxk7T243SlDNvKj5yYQmX0ngGwQC++wOrpiW0F1bZxS63pwN3k7Iva35KYbdyUbhBvF2G+9ID2o5+7k17/jUlH8WvyT7l92ATh1GNkVEfiEieWmJli+DI3n+g3RC7OdM748Pw5f7BhaG2GGPvaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039674; c=relaxed/simple;
	bh=XiIXkLh7xZJlvQ5cEZsGq8UI4ICTYL+iKbirY9wCMFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUhDKO9g1Trz54N8bZ3t5XiNTHWUz7c5bR5KJPy1v35wNFB1FEsQHBla69hUwWoqrAGW2FLcnr0qeL5RR6kJlIs9fWO8ALU2c5QrO4HqP4O++rOs2kYvi4flZ5s6yAlf13v6raNUnBABGPBX4cq9gB68PbxtJVwQsBEl8n0Tbfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xp863vsz; arc=none smtp.client-ip=91.218.175.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xp863vsz"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XiIXkLh7xZJlvQ5cEZsGq8UI4ICTYL+iKbirY9wCMFU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789039668; v=1; x=1789644468;
 b=xp863vszhTaplqdWlyupcwnoPuyXA6P0/8j2OOA6CMJ3GdwwH43AUaQ9k5BkBG70TvlA/T7y
 Wxj6lABx/D/1C9sy7c92BozfNpoDRA7stVKxtpnwE/E5ZYohFvPpxtFM+1amahO6fgiVSgz6490
 vIJPN3lgpqP/0RPX5sWbAXwo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c60bcde16ef5a46e;
	Thu, 10 Sep 2026 11:27:48 +0000
X-Mizu-Trace-ID: c60bcde16ef5a46e
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
Subject: [PATCH bpf v3 2/3] tcp: Skip cond_resched() in inet_csk_listen_stop() under BPF context
Date: Thu, 10 Sep 2026 19:27:28 +0800
Message-ID: <20260910112736.153710-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910112107.148770-1-jiayuan.chen@linux.dev>
References: <20260910112107.148770-1-jiayuan.chen@linux.dev>
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
Do the same for the cond_resched(). The loop runs inside the iterator's
rcu_read_lock(), it must not reschedule or report a quiescent state there.

Fixes: 4ddbcb886268 ("bpf: Add bpf_sock_destroy kfunc")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
A reviewer worried that skipping cond_resched() lets a big accept queue
run without a reschedule point under BPF. That can't be helped, the
iterator runs the prog under rcu_read_lock() and rescheduling there is
not an option. The loop is bounded by the accept queue.

The iterator taking lock_sock() on a not yet accepted child while the
listener is closed concurrently is a pre-existing issue with its own
report, handled separately:
https://lore.kernel.org/netdev/20260807095707.224300-1-zirajs7@gmail.com/

Kuniyuki suggested to just remove the cond_resched(), since after commit
7dadeaa6e851 ("sched: Further restrict the preemption modes") x86 and
friends only have full and lazy preemption left. But VOLUNTARY is still
there on arm, mips, sparc and others, NONE on alpha, hexagon and m68k,
and this fix goes to stable where x86 has them too. close() on a big
listener still relies on this cond_resched() there, so keep it and only
skip it under BPF. It may be removed in the future once those modes are
gone.
---
 net/ipv4/inet_connection_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6257459bcee24..6a30f11384547 100644
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

