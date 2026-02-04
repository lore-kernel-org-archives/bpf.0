Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7241C2EE;
	Wed,  4 Feb 2026 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219701; cv=none; b=s6rbK3WtRskoI58ADpIarB7eWD5zQEJyFHmSlq91VJDfzb1elGc1zuAInxImt1C4ciAvxtW4MbnEDqWoUS/ONFlDn1b8DeyE3UrfSDmsQNlErULIYINiOliwJ+mnSmhRaKzjy9iulNOMs/F4cSnuFxVWoLP0LRRvgJuhwhzLYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219701; c=relaxed/simple;
	bh=y+VfXyZfEv/iLTKOZwxeeQmhfZehJ6ewL2y08ntJHMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HP927FL0hOm8Bv5fnmt2b1N/brIMxJPBZJA6Mzal3x/T/sSAv8UiOC0gRfAgKkDFuNfAypH6UrZBwS4pWg6yp2AB5Pnm7EeSWQg0Ehfp69s6W0GVmUJ6J9U1av7lgLVVzPVWell6cxxUpu5NFxZGC4t+jHnpOUbTG+8VZvYG8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=XJ49bUqs; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="XJ49bUqs"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vnf0R-001HOM-Oa; Wed, 04 Feb 2026 16:41:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=yy+pfXDm9B5saBKTpihytUhl3OzuXowP2Q77KQkJhnU=; b=XJ49bUqsIwmLRJmMTrY7Hgn3IB
	x0hPLvwIniiuy5QCOcU5BOjXgph4Q9kcl1ckH8tDqEsWpDBdl1QHp/VFW1rMYoou3GyIiF/z56xk5
	EzS8M17Cv4q7LDUoooV+r4cpOWYV3ysV8wg/iIwCjAu0vnw6wS103rlswl6+EmRyoiUWzlnsK4i9x
	RKj5JMae3Q3pQDyntOvfNIXArl/vXogS3Hz9PnH0yjMHRkvYWPzVhWCagOZGADzhgoTIJ8ZG/shwk
	qMBCQDxxpRCl14y0X2a35lmXg5RPY+JVHYRqqgLmi7NZ+DrWfaKN8LTD4FovJKeSYG5wNHN7P3BzK
	KTKeAwLw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vnf0R-0005dh-55; Wed, 04 Feb 2026 16:41:27 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vnf0P-002MxR-0s; Wed, 04 Feb 2026 16:41:25 +0100
Message-ID: <408569e7-2b82-4eff-b767-79ce6ef6cae0@rbox.co>
Date: Wed, 4 Feb 2026 16:41:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jakub@cloudflare.com,
 john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co>
 <20260203200242.404131-1-kuniyu@google.com>
 <80865b12-7786-4787-81c8-08b754716a5d@linux.dev>
 <CAAVpQUCshzAAHZQQ7sVE+3UdKmBV42bKudcdDR0KtaTcTqn5gA@mail.gmail.com>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <CAAVpQUCshzAAHZQQ7sVE+3UdKmBV42bKudcdDR0KtaTcTqn5gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/4/26 08:58, Kuniyuki Iwashima wrote:
> On Tue, Feb 3, 2026 at 11:15 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 2/3/26 11:47 AM, Kuniyuki Iwashima wrote:
>>> From: Michal Luczaj <mhal@rbox.co>
>>> Date: Tue, 3 Feb 2026 10:57:46 +0100
>>>> On 2/3/26 04:53, Martin KaFai Lau wrote:
>>>>> On 2/2/26 7:10 AM, Michal Luczaj wrote:
>>>>>> In related news, looks like bpf_iter_unix_seq_show() is missing
>>>>>> unix_state_lock(): lock_sock_fast() won't stop unix_release_sock(). E.g.
>>>>>> bpf iterator can grab unix_sock::peer as it is being released.
>>>>>
>>>>> If the concern is the bpf iterator prog may use a released unix_peer(sk)
>>>>> pointer, it should be fine. The unix_peer(sk) pointer is not a trusted
>>>>> pointer to the bpf prog, so nothing bad will happen other than
>>>>> potentially reading incorrect values.
>>>>
>>>> But if the prog passes a released peer pointer to a bpf helper:
>>>>
>>>> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
>>>> Read of size 1 at addr ffff888110654c92 by task test_progs/1936
>>
>> hmm... bpf_skc_to_unix_sock is exposed to tracing. bpf_iter is a tracing
>> bpf prog.
>>
>>>
>>> Can you cook a patch for this ? probably like below
>>
>> This can help the bpf_iter but not the other tracing prog such as fentry.
> 
> Oh well ... then bpf_skc_to_unix_sock() can be used even
> with SEQ_START_TOKEN at fentry of bpf_iter_unix_seq_show() ??
> 
> How about adding notrace to all af_unix bpf iterator functions ?
> 
> The procfs iterator holds a spinlock of the hashtable from
> ->start/next() to ->stop() to prevent the race with unix_release_sock().
> 
> I think other (non-iterator) functions cannot do such racy
> access with tracing prog.

But then there's SOCK_DGRAM where you can drop unix_peer(sk) without
releasing sk; see AF_UNSPEC in unix_dgram_connect(). I think Martin is
right, we can crash at many fentries.

BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
Read of size 2 at addr ffff888147d38890 by task test_progs/2495
Call Trace:
 dump_stack_lvl+0x5d/0x80
 print_report+0x170/0x4f3
 kasan_report+0xe1/0x180
 bpf_skc_to_unix_sock+0xa4/0xb0
 bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
 bpf_trampoline_6442564662+0x47/0xab
 unix_shutdown+0x9/0x880
 __sys_shutdown+0xe1/0x160
 __x64_sys_shutdown+0x52/0x90
 do_syscall_64+0x6b/0x3a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

> 
>>
>>>
>>> ---8<---
>>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>>> index 02ebad6afac7..9c7e9fbde362 100644
>>> --- a/net/unix/af_unix.c
>>> +++ b/net/unix/af_unix.c
>>> @@ -3740,8 +3740,9 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
>>>               return 0;
>>>
>>>       slow = lock_sock_fast(sk);
>>> +     unix_state_lock(sk);
>>>
>>> -     if (unlikely(sk_unhashed(sk))) {
>>> +     if (unlikely(sock_flag(other, SOCK_DEAD))) {
>>>               ret = SEQ_SKIP;
>>>               goto unlock;
>>>       }
>>> @@ -3751,6 +3752,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
>>>       prog = bpf_iter_get_info(&meta, false);
>>>       ret = unix_prog_seq_show(prog, &meta, v, uid);
>>>   unlock:
>>> +     unix_staet_unlock(sk);
>>>       unlock_sock_fast(sk, slow);
>>>       return ret;
>>>   }
>>> ---8<---
>>>
>>> Thanks!
>>

