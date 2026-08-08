Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3216417D7E
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786193272; cv=none; b=RVfioQVhgRkppFobjq9x0PBVRe1f1e8es7HveSfP3ALePNke9CxKuYHUEbc/YwB7kaKNFd8wnjDCDauuSAB4tCgKbhPw6eV8PTOc3/56ylP/QDce0CuLld8vAO6Pe/s31IkDZhpkAGWKRS2YN1g5f/vwllY0RVhVlz93o9nA8xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786193272; c=relaxed/simple;
	bh=/fbogozw1zeV/JOzTmM7eJH0RHURU22UmcsDBf8ZDSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XulUbB6Pgu9+Zam5VHyA6fLrs+2VpbwQEnRTYTebryJk7FJ5lFwrRuxIgzgNKjMPG08k4SwiMWuY52ZtNKIS+H9FHwPHCoJCr9S0rLfIkE6zIYKe0oovztvX4fy0ub0CVmfJwBUXyV9XJQa6ULVBIY7t8YtiZPQEAxvd0Rhowl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OLovJeHH; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OLovJeHH"
Message-ID: <ad3513fd-746d-430e-a297-17d0628d6ff0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786193247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5CHfoHcwxpByabt65ri1mNhkYgoO4YP9qUMYtW/E80=;
	b=OLovJeHHpzndLPFs57DAIvfuW9SlrhgGeUsneaetTE6I9BEBkKXaHF4+TwV8bMNApG+zBU
	Ey95sP+U43RwbZ1wygJhKKQr6GUokkRY8jd8zHYbMn0IznzaFjzdm0ftD/bvMzl9FDGVP/
	aXBqdMvYcAo4XucuYbIp3P8yjOB8YJI=
Date: Sat, 8 Aug 2026 20:46:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/5] bpf: Add ksock kfuncs
To: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org,
 liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com,
 song@kernel.org, netdev@vger.kernel.org, sdf.kernel@gmail.com,
 ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
 <20260807171532.125149-3-mahe.tardy@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260807171532.125149-3-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/8/26 1:15 AM, Mahe Tardy wrote:
> Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> sending data. This provides a mechanism for BPF programs to emit
> telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> socket types with IPPROTO_UDP protocol but could be easily extended to
> SOCK_STREAM and IPPROTO_TCP in the future.
>
> The API consists of five kfuncs:
>
>    bpf_ksock_create()   - Create a socket (sleepable)
>    bpf_ksock_connect()  - Connect socket to remote address (sleepable)
>    bpf_ksock_send()     - Send data through the socket (sleepable)
>    bpf_ksock_acquire()  - Acquire a reference to a socket context
>    bpf_ksock_release()  - Release a reference (cleanup via
>                           queue_rcu_work since sock_release sleeps)
>
> The setup kfuncs bpf_ksock_create, bpf_ksock_connect, can be called from
> SYSCALL programs only. While bpf_ksock_acquire, bpf_ksock_release and
> bpf_ksock_send can be called from SYSCALL and LSM programs.
>
> The implementation follows the established kfunc lifecycle pattern
> (create/acquire/release with refcounting, kptr map storage, dtor
> registration). The kernel socket is wrapped in a refcounted bpf_ksock
> struct. Cleanup is deferred via queue_rcu_work() because sock_release()
> may sleep.
>
> The kfuncs are only compiled when CONFIG_INET is enabled, as they
> specifically support AF_INET and AF_INET6 sockets.
>
> The socket operations go through the expected LSM hooks instead of
> by-passing them like many kernel sockets since those are created by BPF
> programs and thus system users. Thus, the bpf_ksock_send() kfunc, which
> is exposed to LSM progs has a verifier filter protection to avoid
> recursion so that the whole bpf_kfunc_set kfunc set cannot be called in
> a program attached to security_socket_sendmsg(). Also, because of the
> LSM checks, we prevent the use of the kfuncs from asynchronous workqueue
> as the current value would then be invalid.
>
> In bpf_ksock_create(), we copy the arg values to avoid TOCTOU races
> since the kfunc can sleep and the arg values could be stored in a map
> that could be re-written by BPF progs or even userspace programs if the
> map is mmaped.
>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


