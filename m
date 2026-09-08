Received: from mta1.migadu.com (out-140.mta1.migadu.com [95.215.58.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFB43AA518
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854892; cv=none; b=sbklDpQdeU6GIfkq2QPMa1z1XI6+rV09mD6Qx1K2CQqRB8EHSf5yPa+jznbB9fgYfEnJ43FLgbNlOCMpetIVvljdMpUuFCKqgL/AB95hJCDgJ3Le1tE8/ZH3FnR4XFCbWdinWsNe8mC6ipdsW7JLHR0g7o9Ct+7k3vZACT75fZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854892; c=relaxed/simple;
	bh=17Qpr2HZAfjTf+fUY0bEYiBsyBtJXKQkXqw9F9jXj84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqWhU9cprP341NymGWUGAsNo4aZozegq915BHFZA7RKM/BPg01pJrVplNIxab6edFrMnsyxEnxxHZvw0agUNPY6JPIH2WH0DCfa8UanhGkxCfppASvslTxA+wVvHZq4sFPuJH798+tuq99/xlek7sj5kTt2tJM0cblzFc2ptx6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YhKPa69D; arc=none smtp.client-ip=95.215.58.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YhKPa69D"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=17Qpr2HZAfjTf+fUY0bEYiBsyBtJXKQkXqw9F9jXj84=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788854886; v=1; x=1789459686;
 b=YhKPa69DdS5qZIl1G+SGZx4cR2YVxx0k6mS3QpgPwciPPwYelLamurWlQsD5W+ZQZsA6u7g1
 IrmvqGHkQNvFrE/Bum+vIYjfi6jVrBlqGmZYwySvi8xOekOZMLm8guERo+N5LfGFU7f0zQoNeR8
 M36VdzpZO26Hl6or04k7N/xM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f75abea937d6cb6f;
	Tue, 08 Sep 2026 08:08:06 +0000
X-Mizu-Trace-ID: f75abea937d6cb6f
X-Migadu-Flow: FLOW_OUT
Message-ID: <a44c1e4d-e9a8-4df3-aa25-20875cd4d30e@linux.dev>
Date: Tue, 8 Sep 2026 16:07:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 2/3] tcp: Skip cond_resched() in
 inet_csk_listen_stop() under BPF context
To: Kuniyuki Iwashima <kuniyu@google.com>, bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 shuah@kernel.org, aditi.ghag@isovalent.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20260906074135.185212-3-jiayuan.chen@linux.dev>
 <0aa6425f9e8f32705ae827f6325b29079234c3f3d0c7b2cdefba3e5b50432766@mail.kernel.org>
 <CAAVpQUBztYDHyiCN1fnhdxCPv_5AZ09yCMQfNW96SzZyw0LhHA@mail.gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAAVpQUBztYDHyiCN1fnhdxCPv_5AZ09yCMQfNW96SzZyw0LhHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/8/26 7:34 AM, Kuniyuki Iwashima wrote:
> On Sun, Sep 6, 2026 at 1:23 AM <bot+bpf-ci@kernel.org> wrote:
>>> tcp: Skip cond_resched() in inet_csk_listen_stop() under BPF context
>>>
>>> bpf_sock_destroy() runs from the tcp iterator, under rcu_read_lock(). If
>>> the sock is a listener that still has children in its accept queue,
>>> tcp_abort() ends up in inet_csk_listen_stop() and the cond_resched()
>>> there trips the debug check:
>>>
>>> BUG: sleeping function called from invalid context at net/ipv4/inet_connection_sock.c:1523
>>> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 628, name: test_progs
>>> preempt_count: 0, expected: 0
>>> RCU nest depth: 1, expected: 0
>>> locks held by test_progs/628: 3, last CPU#3:
>>>   #0: ffff8881158cee18 (&p->lock){+.+.}-{4:4}, at: bpf_seq_read+0x56/0x1210
>>>   #1: ffff8881106bb858 (sk_lock-AF_INET6){+.+.}-{0:0}, at: bpf_iter_tcp_seq_show+0x32b/0x4b0
>>>   #2: ffffffffb435af20 (rcu_read_lock){....}-{1:3}, at: bpf_iter_run_prog+0x46b/0xde0
>>> CPU: 3 UID: 0 PID: 628 Comm: test_progs Tainted: G        W           7.2.0+ #65 PREEMPT
>>> Tainted: [W]=WARN
>>> Call Trace:
>>>   <TASK>
>>>   dump_stack_lvl+0xc1/0xf0
>>>   dump_stack+0x10/0x20
>>>   __might_resched+0x3d2/0x610
>>>   inet_csk_listen_stop+0x7b/0xbf0
>>>   tcp_abort+0x23b/0x3b0
>>>   bpf_sock_destroy+0xfc/0x140
>>>   bpf_prog_448133d24601754f_iter_tcp6_server+0x81/0x8a
>>>   bpf_iter_run_prog+0x538/0xde0
>>>   bpf_iter_tcp_seq_show+0x26b/0x4b0
>>>   bpf_seq_read+0x424/0x1210
>>>   vfs_read+0x197/0xe40
>>>   ksys_read+0x119/0x240
>>>   __x64_sys_read+0x72/0xc0
>>>   x64_sys_call+0x647/0x27e0
>>>   do_syscall_64+0xe5/0x610
>>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> RIP: 0033:0x7fad39b28aca
>>> RSP: 002b:00007ffc381c61c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>>> RAX: ffffffffffffffda RBX: 00007ffc381c6a88 RCX: 00007fad39b28aca
>>> RDX: 0000000000000032 RSI: 00007ffc381c6250 RDI: 0000000000000014
>>> RBP: 00007ffc381c61e0 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
>>> R13: 0000000000000000 R14: 000055f077c1bbb0 R15: 00007fad3a0f3000
>>>   </TASK>
>>>
>>> The commit that added the kfunc already guards lock_sock() in tcp_abort()
>>> and udp_abort() with has_current_bpf_ctx(), but missed the listener path.
>>> Do the same for the cond_resched(), it can't reschedule there anyway.
>>>
>>> Fixes: 4ddbcb886268 ("bpf: Add bpf_sock_destroy kfunc")
>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Is the justification "it can't reschedule there anyway" accurate?
>>
>> With CONFIG_PREEMPT_DYNAMIC=y booted with preempt=none or preempt=voluntary,
>> cond_resched() expands to __cond_resched() which can actually reschedule.
>> The splat in the commit message confirms preempt_count is 0 while RCU nest
>> depth is 1. With preempt_count==0, should_resched(0) can be true and
>> __cond_resched() will call preempt_schedule_common() for a real reschedule.
>>
>> Additionally, in configurations with CONFIG_PREEMPT_RCU=n where
>> rcu_read_lock() is preempt_disable(), __cond_resched() falls through to
>> rcu_all_qs() which calls rcu_qs() to report a quiescent state from inside
>> an RCU read-side critical section. That's a correctness problem beyond just
>> the debug check.
>>
>> So the call can either reschedule (PREEMPT_DYNAMIC none/voluntary) or report
>> a bogus quiescent state (non-preemptible RCU). Could the justification be
>> reworded to explain that the loop runs inside the iterator's RCU read-side
>> critical section and must not reschedule or report a quiescent state there?
>> The code change itself is correct and matches the existing pattern in
>> tcp_abort() and udp_abort().
> or maybe simply remove cond_resched(), hoping 7dadeaa6e851 would
> resolve the scheduling issue.
>

Good suggestion. cond_resched has become old practice under 
CONFIG_PREEMPT_LAZY

