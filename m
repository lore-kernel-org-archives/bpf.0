Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1830370D4D;
	Sun,  6 Sep 2026 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788683022; cv=none; b=pKquU9CMWJS6jJK2EdNKOOWQxKYFFL14rcG3e3DIqR1X+fZyeH54zy65dHI/2yQyrIsa4pGjEWakmqvMviGarNY6dwIoeoGWhxen7IhkV14q/r+LSRJaVSHCY99pnuXTlXn3dsqJDTDLo10RYPr5eeV6Zwya1oJ4yf5EeC5R+jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788683022; c=relaxed/simple;
	bh=UePYk5EV/Qaqw0IY89yRO0r3qk+k5k+KkQ9cDqfoG4Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uOjBtvbTDNTgM4DXjXHw08QAzYGknBQ0JQfWZiuZbuTZuMJHKA8qd5rtwXGdK8N2lUSv1JLF0Uvyd0v34PSz8X6/EwwvGI2gq3KK3ooWLx4ZPdH6O79OCuy4DzpZJQreMdtBlyM2u6FqwvVvOUZxI4Mb7Jy11hDeyC3Ce7zX59w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzyqDPzS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzyqDPzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189521F00A3A;
	Sun,  6 Sep 2026 08:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788683020;
	bh=tf2tdIx2P84L1/srTfE4j0DrGr7do6OVoEKFu4XPMyg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AzyqDPzSWkPtereqLO0/5w/WRiBqEltQzimGBA+SxP5qglz0IEpD+bHK8qQjgzThf
	 w5E8aS/sLkv450lSvAzxzUsn09MfzGBJTNY8Lk+5PIFCO4bGVcp9zmFw1/w6vIl/i/
	 Mtms+8NtSw4CSyxv5i9EHYxuEV3k8KytrIBEqR9OJsktQi0bRZD1nNGA43bhxTJWaq
	 KE58ACJ+JAcSwRvlL1zYv4V6rFWUq0o2fjtjhyeIgezRHmGSFumW0YHB+Cv4As6LGd
	 UBsaahYwt1n79WitFwM3nBsK4KtfqhwiLhspf4MdXeBOfb4lWvGSX7yCTSk5ElkeUu
	 b4qxMIXiVnnhA==
Content-Type: multipart/mixed; boundary="===============8904504023982474725=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0aa6425f9e8f32705ae827f6325b29079234c3f3d0c7b2cdefba3e5b50432766@mail.kernel.org>
In-Reply-To: <20260906074135.185212-3-jiayuan.chen@linux.dev>
References: <20260906074135.185212-3-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v2 2/3] tcp: Skip cond_resched() in inet_csk_listen_stop() under BPF context
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,daniel@iogearbox.net,john.fastabend@gmail.com,sdf@fomichev.me,martin.lau@linux.dev,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ncardwell@google.com,kuniyu@google.com,shuah@kernel.org,aditi.ghag@isovalent.com,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  6 Sep 2026 08:23:39 +0000 (UTC)

--===============8904504023982474725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tcp: Skip cond_resched() in inet_csk_listen_stop() under BPF context
>
> bpf_sock_destroy() runs from the tcp iterator, under rcu_read_lock(). If
> the sock is a listener that still has children in its accept queue,
> tcp_abort() ends up in inet_csk_listen_stop() and the cond_resched()
> there trips the debug check:
>
> BUG: sleeping function called from invalid context at net/ipv4/inet_connection_sock.c:1523
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 628, name: test_progs
> preempt_count: 0, expected: 0
> RCU nest depth: 1, expected: 0
> locks held by test_progs/628: 3, last CPU#3:
>  #0: ffff8881158cee18 (&p->lock){+.+.}-{4:4}, at: bpf_seq_read+0x56/0x1210
>  #1: ffff8881106bb858 (sk_lock-AF_INET6){+.+.}-{0:0}, at: bpf_iter_tcp_seq_show+0x32b/0x4b0
>  #2: ffffffffb435af20 (rcu_read_lock){....}-{1:3}, at: bpf_iter_run_prog+0x46b/0xde0
> CPU: 3 UID: 0 PID: 628 Comm: test_progs Tainted: G        W           7.2.0+ #65 PREEMPT
> Tainted: [W]=WARN
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xc1/0xf0
>  dump_stack+0x10/0x20
>  __might_resched+0x3d2/0x610
>  inet_csk_listen_stop+0x7b/0xbf0
>  tcp_abort+0x23b/0x3b0
>  bpf_sock_destroy+0xfc/0x140
>  bpf_prog_448133d24601754f_iter_tcp6_server+0x81/0x8a
>  bpf_iter_run_prog+0x538/0xde0
>  bpf_iter_tcp_seq_show+0x26b/0x4b0
>  bpf_seq_read+0x424/0x1210
>  vfs_read+0x197/0xe40
>  ksys_read+0x119/0x240
>  __x64_sys_read+0x72/0xc0
>  x64_sys_call+0x647/0x27e0
>  do_syscall_64+0xe5/0x610
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7fad39b28aca
> RSP: 002b:00007ffc381c61c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00007ffc381c6a88 RCX: 00007fad39b28aca
> RDX: 0000000000000032 RSI: 00007ffc381c6250 RDI: 0000000000000014
> RBP: 00007ffc381c61e0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> R13: 0000000000000000 R14: 000055f077c1bbb0 R15: 00007fad3a0f3000
>  </TASK>
>
> The commit that added the kfunc already guards lock_sock() in tcp_abort()
> and udp_abort() with has_current_bpf_ctx(), but missed the listener path.
> Do the same for the cond_resched(), it can't reschedule there anyway.
>
> Fixes: 4ddbcb886268 ("bpf: Add bpf_sock_destroy kfunc")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Is the justification "it can't reschedule there anyway" accurate?

With CONFIG_PREEMPT_DYNAMIC=y booted with preempt=none or preempt=voluntary,
cond_resched() expands to __cond_resched() which can actually reschedule.
The splat in the commit message confirms preempt_count is 0 while RCU nest
depth is 1. With preempt_count==0, should_resched(0) can be true and
__cond_resched() will call preempt_schedule_common() for a real reschedule.

Additionally, in configurations with CONFIG_PREEMPT_RCU=n where
rcu_read_lock() is preempt_disable(), __cond_resched() falls through to
rcu_all_qs() which calls rcu_qs() to report a quiescent state from inside
an RCU read-side critical section. That's a correctness problem beyond just
the debug check.

So the call can either reschedule (PREEMPT_DYNAMIC none/voluntary) or report
a bogus quiescent state (non-preemptible RCU). Could the justification be
reworded to explain that the loop runs inside the iterator's RCU read-side
critical section and must not reschedule or report a quiescent state there?
The code change itself is correct and matches the existing pattern in
tcp_abort() and udp_abort().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34020353095
--===============8904504023982474725==--
