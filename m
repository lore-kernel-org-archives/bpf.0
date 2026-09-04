Received: from mta1.migadu.com (out-86.mta1.migadu.com [95.215.58.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4BD44E043
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518903; cv=none; b=pwDpcK5iOQmxKJXxe/GOY+x5pLFRl6Bn35r/8yMh73ULCaY7wmxoVuq0hAJkIchVq42hfSqAoLF0zB6JtS6mFM8uzfe3pL1HM6GEvqTBLJPKg5yN54FpIJj8M2G8WFx1iqEIhCe9VnKIdP7pV22Nx1DVizqvM1foDHhZCLkw8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518903; c=relaxed/simple;
	bh=8QktsvnxWs3d45vAajo7gNZrNpg+i6MJb7/5u+nTQ5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+0ii6Hsyv//umaeZAwIZQby08FzQJRNscfCiTvm2P3MlMH5cQaOLQVh1tps1z7fJWzYBuQx4bjvoF84R0+8VhfRx6h3ebP3jGHKzzbVmQQvmkB4QHWm4uRVSuleqXYLWgv+RzZZZ0dYqjBRnXee51sHSYuhMkGMdeSTQDE6L5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tgKz/pQD; arc=none smtp.client-ip=95.215.58.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tgKz/pQD"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8QktsvnxWs3d45vAajo7gNZrNpg+i6MJb7/5u+nTQ5E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788518899; v=1; x=1789123699;
 b=tgKz/pQDNXmnpnSnKwCyuErDpGkHW47PHAXCaPHXCc7kijO/5rfzsSAlfY46xT/2dKfe38i+
 1VjSsxr3WtjpY21+1zLwbg2v86YMJ/6Zkw61bc3eJkU6yrF6Huq7JTVbikloSTSHQnt+omZEwUK
 xb65n8nSIINHvJpv5eA49ahw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eb4fad5add43f10a;
	Fri, 04 Sep 2026 10:48:19 +0000
X-Mizu-Trace-ID: eb4fad5add43f10a
X-Migadu-Flow: FLOW_OUT
Message-ID: <52a79ba8-2bb6-4e3e-a21f-a185ab48a6a6@linux.dev>
Date: Fri, 4 Sep 2026 18:48:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix out-of-bounds read of sk_protocol in
 bpf_sock_destroy()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260904094954.63447-1-jiayuan.chen@linux.dev>
 <20260904101958.2BE741F00A3D@smtp.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260904101958.2BE741F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


on 9/4/26 6:19 PM, sashiko-bot@kernel.org write:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] bpf_sock_destroy bypasses socket locking for iterators that do not pre-lock the socket, leading to data corruption and kernel panics.


Hallucination


> - [High] Calling cond_resched() while holding rcu_read_lock() via bpf_sock_destroy() on TCP_LISTEN sockets.


It's True


> --
[...]
> [ ... ]
>> @@ -12925,8 +12926,12 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
>>   	 * Supporting protocols will need to acquire sock lock in the BPF context
>>   	 * prior to invoking this kfunc.
>>   	 */
>> -	if (!sk->sk_prot->diag_destroy || (sk->sk_protocol != IPPROTO_TCP &&
>> -					   sk->sk_protocol != IPPROTO_UDP))
>> +	if (!sk->sk_prot->diag_destroy)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (sk_fullsock(sk) &&
>> +	    sk->sk_protocol != IPPROTO_TCP &&
>> +	    sk->sk_protocol != IPPROTO_UDP)
>>   		return -EOPNOTSUPP;
>>   
>>   	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
> [Severity: High]
> This is a pre-existing issue, but does this invoke the protocol's destroy
> handler without proper locking?
>
> The bpf_sock_destroy() kfunc can be called from iterators. It calls the
> protocol's diag_destroy() handler:
>
> net/core/filter.c:bpf_sock_destroy() {
>      ...
>      return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
> }
>
> For TCP sockets, this resolves to tcp_abort(), which skips acquiring the
> socket lock because has_current_bpf_ctx() is always true inside a BPF
> program:
>
> net/ipv4/tcp.c:tcp_abort() {
>      ...
>      if (!has_current_bpf_ctx())
>          lock_sock(sk);
>      ...
> }
>
> While some iterators pre-lock the socket, others (like sockmap iterators) do
> not. Does this result in tcp_abort() running lockless and potentially
> corrupting socket state?

No.


I try load "SEC("iter/sockmap")" but verifier rejected it.

Only the tcp/udp iters mark sk as PTR_TRUSTED and bpf_sock_destroy() 
needs a trusted arg.


> Additionally, if a raw socket with IPPROTO_TCP is passed, raw_abort() is
> invoked instead, which unconditionally calls lock_sock():
>
> net/ipv4/raw.c:raw_abort() {
>      ...
>      lock_sock(sk);
>      ...
> }
>
> Since iterators run under rcu_read_lock(), will this sleep in an atomic
> context and trigger a BUG?
>
> [Severity: High]
> This is also a pre-existing issue, but can this call cond_resched() while
> holding an RCU read lock?
>
> When bpf_sock_destroy() processes a TCP socket in the TCP_LISTEN state,
> it calls tcp_abort(), which then calls inet_csk_listen_stop():
>
> net/ipv4/tcp.c:tcp_abort() {
>      ...
>      inet_csk_listen_stop(sk);
>      ...
> }
>
> Inside inet_csk_listen_stop(), there is a loop that explicitly yields:
>
> net/ipv4/inet_connection_sock.c:inet_csk_listen_stop() {
>      ...
>      cond_resched();
>      ...
> }
> Since bpf_iter_run_prog() runs iterators under rcu_read_lock_dont_migrate(),
> will calling cond_resched() from this atomic context trigger a "sleeping
> function called from invalid context" BUG?


Yes, reproduced with a listener that still has an unaccepted child.

Let me think how to fix it...

