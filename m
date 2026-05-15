Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE93FB040
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833594; cv=none; b=AXX8rWzYSJujGnEQeZw8R1tCoTC3tFN9J4RRlUSB1t9wLKviv6tvgto3yvSIOrj6C8P3XYie35KJKQ6Mee7XSqL6ziPigAjvgVJbOJp/K+bFLakNUnojCZT4osjwOV4Uyo9Y5/EUkBpSZXUrIQyS8DVZGfSeM+RdNBA+HOiIwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833594; c=relaxed/simple;
	bh=ZUfjXKYn3B6z42BPQD2XBa7OBP+izoAhR6k5tyBgJjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GaXLMGqjfTyz0QFvx6RHbT5LcpcUlfvQJ4DtCMSqmYMqXwVKY6r3HfsSCW/Pg1khWKZ/sOXZrMqqVQmp0wv9HkE5z/wV4FNDCfB3fsinOCcCToM9G7e/v5G/b80cgrUts2x3ychqdqyerWZr4Ah0NDoZwUmb3vQmgeAtMeutOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MDKhU2vw; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MDKhU2vw"
Message-ID: <c5fadf42-583c-4e8c-8484-46781a0581b2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778833580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XabvpQDNM+J86JDRbuohWAB73JVV3E1H7YgDDbtsPO8=;
	b=MDKhU2vwFXU0huKVVjPN2A9Dflc3bUk9Xo5kfL8xkJOsKWc7C1pjhOapONRWhOCwxWpYiV
	tBqtPqqv6eMnmERXcQ5iLaEaYPZ6EAXbqoIDkNDDyhz2PAU9tmYTzpX+6dj1MGTcnLg9lD
	qPG+s8Ll3JQskGtg4ziMnAMOKCnLoG0=
Date: Fri, 15 May 2026 16:26:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: skmsg: pin the delayed-work psock in
 sk_psock_backlog
To: Cen Zhang <rollkingzzc@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, zerocling0077@gmail.com,
 2045gemini@gmail.com
References: <20260515050437.104716-1-rollkingzzc@gmail.com>
 <e0a24b78-9800-4927-b611-ccbad1e906fe@linux.dev>
 <CAB7XQsEJDoZHUznSYE3v1DadVXGWP7J21rS4Q=BuMr_jV9tX_w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAB7XQsEJDoZHUznSYE3v1DadVXGWP7J21rS4Q=BuMr_jV9tX_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/15/26 4:12 PM, Cen Zhang wrote:
> Dear Jiayuan Chen
>
> Jiayuan Chen <jiayuan.chen@linux.dev> 于2026年5月15日周五 14:10写道：
>> Where is the 'last_old_ref_before_put' symbol from? I can't find it
>> anywhere in the tree.
>>
>> If you are using LLMs to dig into races like this, please also have them
>> produce a reproducer, e.g. patch mdelay() into
>>
>> the relevant windows to widen them, then trigger it from userspace.
>>
>>
> Hi Jiayuan,
>
> Thanks for checking this. You are right: last_old_ref_before_put is
> not an in-tree kernel symbol. It was a temporary validation probe
> label which recorded the old psock refcount immediately before the
> backlog worker's final put, and it should not have appeared in the
> commit message as if it were kernel output.
>
> The in-tree path I was trying to describe is:
>
>    sk_psock_backlog() starts at net/core/skmsg.c:670.
>    get path: sk_psock_get(psock->sk), net/core/skmsg.c:692.
>    put path: sk_psock_put(psock->sk, psock), net/core/skmsg.c:746.
>    detach clears sk_user_data at net/core/skmsg.c:892.
>    reattach publishes a replacement psock at net/core/skmsg.c:793.
>    warning path: REFCOUNT_SUB_UAF at lib/refcount.c:28.
>
> The trigger was based on the in-tree sockmap_redir BPF selftest
> under tools/testing/selftests/bpf/prog_tests/.
> The one-shot test used AF_UNIX SOCK_STREAM socket pairs, attached
> the sk_skb verdict program to the input map, inserted one socket
> into the input map and one destination socket into the sockmap at
> key 0, then sent one byte through the input peer so the destination
> psock backlog worker was queued.
> For validation I used a temporary local instrumentation patch in
> net/core/skmsg.c. It added a debugfs-controlled gate in
> sk_psock_backlog() after the TX-enabled check and before the
> existing sk_psock_get(psock->sk) call, plus counters and pr_info()
> snapshots in sk_psock_backlog(), sk_psock_init() and
> sk_psock_drop(). It also stored the pointer returned by
> sk_psock_get(psock->sk) for logging. The worker still used the
> existing get path and the existing sk_psock_put(psock->sk, psock)
> exit path.
> With the worker parked before sk_psock_get(psock->sk), the test
> forked: the child deleted the destination sockmap entry, and the
> parent retried BPF_NOEXIST update of the same key with the same
> destination socket fd until reattach succeeded.
> After the delete completed, the test released the old worker. At
> that point sk->sk_user_data referred to the replacement psock, while

So, should the fix swap the order of sk->sk_user_data = null and 
sk_psock_clear_state(psock, SK_PSOCK_TX_ENABLED)?


> the delayed work still belonged to the old psock. The recorded state
> before the warning had the sk_user_data psock and the psock returned
> by sk_psock_get(psock->sk) equal to each other, but different from
> the delayed-work container. The instrumentation was only used to make
> that interleaving deterministic and observable. The warning below is
> the kernel's normal refcount warning path.
>
> The native kernel report from that run was:
>
>    refcount_t: underflow; use-after-free.
>    WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xbf/0xf0
>    Workqueue: events sk_psock_backlog
>    RIP: 0010:refcount_warn_saturate+0xbf/0xf0
>    Call trace:
>      sk_psock_backlog() (net/core/skmsg.c:670)
>      process_one_work() (kernel/workqueue.c:3200)
>
> So the reproducer is instrumentation-assisted, not an
> unmodified upstream selftest. The instrumentation can widen the
> race window and record the participating psock pointers, but it
> does not publish a replacement psock, clear sk->sk_user_data, or
> add an extra put on the old psock. The final warning is reached
> through the existing sk_psock_put(psock->sk, psock) path after
> the test has forced delete-plus-reattach to happen before the
> parked worker resumes.
>
> I will send v2 as a new thread after the netdev 24-hour
> interval, with the lab probe label removed from the commit text.
> If useful, I can also share the small instrumentation/selftest
> diff separately to show the exact widened window.

You can just put the kernel patch and userspace program patch in this 
thread (no need to send a new patch).

Also this patch should be targeted to bpf not net.

--
pw-bot: cr



