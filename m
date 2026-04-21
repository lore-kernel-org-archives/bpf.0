Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83437364931
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776741722; cv=none; b=BnB5APNbo447iqMMzZANK2ECClzazy4mPDS3wTKh6zjc9q3YHeRjyrhiYfvse8iTIJKpcptzn+w8Q68F3c9uu6rsz6urEXTcowb9Mu1rUJ9c0OAZrjyAc93JBXfckJCFps87R9dvT9Pi361qCT5MD9z377H3cRiVX/wVSM31fME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776741722; c=relaxed/simple;
	bh=J73dGupcaQh+HDl/V7HHrcCZFL1QupSS256ZdmyF88Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+jJoqAo3FAps+E113gjrKkLzwFZ0oDwCxktFfC0LxF0hSmYMgKxpwxHlhYWOLhP7GQLX9WL7OPmd9tlrK9dijs/8NiXZHsBp8DWcmN4Sy5+B2l+h1aVCxNxJVvvR0APx7o+ZFy1DKYCD1g6E2uWK74HQU0CHhBhgtru+04up8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AI1x65Af; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AI1x65Af"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=+i3S30UCECDHFf2aWiyav3l9pWVUeZbRoGfN5HJrahM=;
	b=AI1x65AfX6umX4/+sj2enxgXJ8bnwDq8fNU7LCS4bw6OCOmrXeabDXSVeK+HAD
	68YeaZIvXfOXxWwfQ1On3o6GHiipFUglO7KDNvhpze2sAySj13bHGdKijiSkbUTh
	RSuKNUSCx1atJ1qYJeQSmOHp3eQC1mUunnCjPBf7TP9Ow=
Received: from [10.54.24.32] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCXRaw47eZpTzwXAw--.74S2;
	Tue, 21 Apr 2026 11:21:31 +0800 (CST)
Message-ID: <062b1b3b-dedd-422b-83a6-1ca78d7270f7@163.com>
Date: Tue, 21 Apr 2026 11:21:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf] sockmap: Fix sk_psock_drop() race vs
 sock_map_{unhash,close,destroy}().
To: sashiko@lists.linux.dev, Kuniyuki Iwashima <kuniyu@google.com>
Cc: bpf@vger.kernel.org
References: <20260420194846.1089595-1-kuniyu@google.com>
 <20260421011357.70974C19425@smtp.kernel.org>
From: Jiayuan Chen <mrpre@163.com>
In-Reply-To: <20260421011357.70974C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCXRaw47eZpTzwXAw--.74S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw4xKF1fGw1kXF1fXFW5KFg_yoW5ZFyfpr
	n5CayUK3W8JFy2qws5Za1UXr18ta1rJF1Yk3WUua4rZr1fGw4S9FW3XFyYy3WI9rs7Ca1U
	XrnxWrykC39xuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi22NtUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbC7BudRWnm7TvU2wAA35


On 4/21/26 9:13 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] The newly introduced unbounded `goto retry;` loops in `sock_map_unhash()`, `sock_map_destroy()`, and `sock_map_close()` can cause a hard lockup (deadlock) due to softirq preemption or priority inversion.
> --
>
> commit 08b24da207c576eef44ad9d88356dbd6600ab733
> Author: Kuniyuki Iwashima <kuniyu@google.com>
> sockmap: Fix sk_psock_drop() race vs sock_map_{unhash,close,destroy}().
>
> This commit fixes a race condition where sk_psock_drop() might not have
> finished restoring sk->sk_prot even if sk_psock_get() fails to bump the
> refcount. It adds a retry loop to sock_map_unhash(), sock_map_destroy(),
> and sock_map_close() when sk_psock_get() returns NULL but the protocol
> hooks haven't been restored yet.
>
> Closes: https://lore.kernel.org/bpf/69cec5ef.050a0220.2dbe29.0009.GAE@google.com/
>
>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> index 02a68be3002a2..99e3789492a09 100644
>> --- a/net/core/sock_map.c
>> +++ b/net/core/sock_map.c
> [ ... ]
>> @@ -1652,20 +1657,25 @@ void sock_map_destroy(struct sock *sk)
>>   	void (*saved_destroy)(struct sock *sk);
>>   	struct sk_psock *psock;
>>   
>> +retry:
>>   	rcu_read_lock();
>>   	psock = sk_psock_get(sk);
>>   	if (unlikely(!psock)) {
>>   		rcu_read_unlock();
>>   		saved_destroy = READ_ONCE(sk->sk_prot)->destroy;
>> +		if (unlikely(saved_destroy == sock_map_destroy))
>> +			goto retry;
> Can this unbounded retry loop cause a hard lockup due to softirq preemption
> or priority inversion?
>
> If sk_psock_put() is called from process context with bottom-halves enabled
> (such as from sock_map_close() after release_sock()), an interrupt could
> preempt the thread immediately after refcount_dec_and_test(&psock->refcnt)
> drops to 0 but before sk_psock_drop() disables BH.
>
> If a network interrupt fires on the same CPU, NET_RX_SOFTIRQ may process a
> packet (such as an RST) that triggers socket destruction via:
> tcp_done() -> inet_csk_destroy_sock() -> sk->sk_prot->destroy()
>
> Since sk_psock_drop() has not yet restored the protocol, sk->sk_prot->destroy
> is still sock_map_destroy().
>
> When sock_map_destroy() calls sk_psock_get(), it returns NULL because the
> refcount is exactly 0. The code then falls into the !psock branch, sees that
> sk->sk_prot->destroy is still sock_map_destroy(), and jumps to retry.
>
> Because the softirq spins infinitely in this tight loop and never yields the
> CPU, the preempted process context can never execute sk_psock_drop(),
> resulting in a permanent hard lockup.


sock_map_close(sk)
|___ sk_psock_put(sk, psock)   <- refcnt-hits-0 window lives here
|___ saved_close == tcp_close
       |__tcp_close
             |____ sock_orphan   <- SOCK_DEAD set here
             |____(later) inet_csk_destroy_sock

At the exact instant the refcnt can be observed at 0 with
sk_prot not yet restored, SOCK_DEAD is guaranteed not to be set.

So I think AI is not correct.

> A similar priority inversion deadlock could also occur on PREEMPT_RT if the
> thread calling sk_psock_drop() is preempted by a higher-priority task.
>

