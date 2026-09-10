Received: from mta1.migadu.com (out-16.mta1.migadu.com [95.215.58.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33D247CA90
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041067; cv=none; b=Ymer2DHCmLgSV4he6aXc5W9sUp1+U92an7A0c54+C4MclM8sdh8xdBmTNeCl/+Y7NjxloxDVZA585xEP9npDHzDffCIClFBWkwQtwTeBBiKGuK7CwW/8W9E0QzsSjdFi7L7DMc+yOpVtVgsc7Lo7IhHCUy/72yROdflAqtsKwl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041067; c=relaxed/simple;
	bh=UrdEZ9AJIbVBw5+rxtLVeDF1XfzC2ga5F/RnCm+PPbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Clu1ebfUUhv195YLegQCPyWfup1qsocDtfM4OFr0sN8F4HJaefX2nCLNrClEm2dFaD/Gm7AGgSHsHKJfa5kbn6swxGI8RdrfYbrmHANafNzZwhuPVJhxw6pSKv99XZt2T3GnS33erYcac45u/VAbVDt+5yi5wswxc6oMVL8H8eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dio6r4j6; arc=none smtp.client-ip=95.215.58.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dio6r4j6"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UrdEZ9AJIbVBw5+rxtLVeDF1XfzC2ga5F/RnCm+PPbg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789041060; v=1; x=1789645860;
 b=Dio6r4j6N8VOpV4lutHpx2PjTU1H2HMaAIZ1n5+wTss5XUvI+jfb+ayOeHiOKKhHMsRi1GoI
 cpyRK1ZAiis/IrBfY3Xv58hsDSb8nhLAX0l+1pvfNS8zd8QKXwDls71etnxdnH45frHyWcCnGZj
 Oke7jX8kay9abRxbOG0n3/Og=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bf38fb4ee310e6c3;
	Thu, 10 Sep 2026 11:51:00 +0000
X-Mizu-Trace-ID: bf38fb4ee310e6c3
X-Migadu-Flow: FLOW_OUT
Message-ID: <c9a9b25c-e8b3-42d5-8042-10401905e0f8@linux.dev>
Date: Thu, 10 Sep 2026 19:50:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/3] tcp: Skip cond_resched() in
 inet_csk_listen_stop() under BPF context
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260910112107.148770-1-jiayuan.chen@linux.dev>
 <20260910112736.153710-1-jiayuan.chen@linux.dev>
 <20260910114428.7CFDF1F000FF@smtp.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260910114428.7CFDF1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/10/26 7:44 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] bpf_sock_destroy() incorrectly relies on has_current_bpf_ctx() to bypass lock_sock(), leading to lockless socket state mutations and data corruption.
> --
>
> commit 5e3e5dd8730687f6f2e1d9b86f565fa03b6e3366
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> tcp: Skip cond_resched() in inet_csk_listen_stop() under BPF context
>
> This commit skips cond_resched() in inet_csk_listen_stop() when running
> under a BPF context. It prevents a "sleeping function called from invalid
> context" BUG when bpf_sock_destroy() triggers tcp_abort() from a BPF
> iterator.
>
>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>> index 6257459bcee24..6a30f11384547 100644
>> --- a/net/ipv4/inet_connection_sock.c
>> +++ b/net/ipv4/inet_connection_sock.c
> [ ... ]
>> @@ -1520,7 +1520,8 @@ void inet_csk_listen_stop(struct sock *sk)
>>   		local_bh_enable();
>>   		sock_put(child);
>>   
>> -		cond_resched();
>> +		if (!has_current_bpf_ctx())
>> +			cond_resched();
> [Severity: High]
> This is a pre-existing issue, but propagating the use of
> has_current_bpf_ctx() highlights a deeper locking bug in
> bpf_sock_destroy().
>
> Does relying on has_current_bpf_ctx() in tcp_abort() and udp_abort()
> lead to lockless socket state mutations and data corruption?
>
> When a BPF program of type BPF_TRACE_ITER obtains a socket pointer via a
> lookup helper like bpf_sk_lookup_tcp(), or operates in an iterator like
> iter/task_file that doesn't inherently lock the target socket, passing
> this socket to bpf_sock_destroy() calls tcp_abort() or udp_abort().
>
> In those functions, the socket lock is currently bypassed:
>
> net/ipv4/tcp.c:tcp_abort() {
>      ...
>      /* BPF context ensures sock locking. */
>      if (!has_current_bpf_ctx())
>          /* Don't race with userspace socket closes such as tcp_close. */
>          lock_sock(sk);
>      ...
> }
>
> Because has_current_bpf_ctx() returns true in BPF context, lock_sock(sk)
> is bypassed. Modifying socket state (like accept queues, timers, and
> flags) locklessly can lead to use-after-free and list/RB-tree corruption.
>
> Since the underlying bug stems from the commit that added
> bpf_sock_destroy(), should the lock acquisition be addressed structurally
> for those code paths instead of relying on has_current_bpf_ctx()?



Those paths don't exist...

Iter progs have no sk_lookup helpers, and sock_from_file() returns an

untrusted pointer, so the only socks that can reach bpf_sock_destroy() are

the tcp/udp iter ctx args, which are already locked by the iterator.

The verifier rejects anything else with "R1 must be referenced or 
trusted", see the note on patch 1.


