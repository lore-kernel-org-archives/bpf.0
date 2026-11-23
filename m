Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402083;
	b=WleBY9LIpDjr9eXIlP/wfNPjhNdD7th8NJGClh7AvIKgcu4475BmTVPGqKy/bwuxKu6C
	 Fa2QgvBKXraijByJfKWxptZhQ57Od9hKX3nkT2kbGI67Kk5z6RUTSO/A7Xdg1pg9Uw6LW
	 VrwzjAwWkO64csyHVbzn7V8ZJbvreINXg854irfyy5qaMEd+KOnD7gH6gQTo7VF/NJWKU
	 4t4MEmdk9R/bmWz+4BG+MiuG6lNzT6lHpc/XUNW3W5kj0vWxESnRqCpxJLGm1d0pO9YEv
	 MZ0niamVgQbmrNu9kQR4NdkdLOrOKM7Z+4ezoJXkhp+ClQe2ed/u5SajjBAAwVtt5DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402083;
	h=Received:DKIM-Signature:Date:From:To:CC:Subject:User-Agent:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yrk9+Mje2C0J1qnXfhBPjrjMZR0Y6jR+rEChJda2HwE=;
	b=d2PZNk3Yik9CbqhBgFY0pP3qkw9am3yTXFRjY2EyORR4xuzzGkeH42ZeGPMOvmrc/gyq
	 AYbMLh7n4yBBN/HfGyciSVcia3l+xqijimkH1F2QOp5L/4l4KucvuX4AQxZIJ9dKjqHb1
	 21AjzJCB5MN8WHPtIfpqJirqbnBozfc6UFDCO06kK7UpESMs7CvyXp0DyToupmAvfmJ7q
	 2HSLg7JxptRJV7VoNwqWgi5W31mVhL4mBhCcv4gGCPHuBu5hiWGnbPbwuVpkDLvH2eq2L
	 Ac8CUDPRcfGSzxRzN0Fozy6KYk/30ffRATKQGC9v4hjepLRi3mBXMsWJ1xZN9rLdFOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CyI3qMqW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153FA606A335;
	Mon, 23 Nov 2026 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CyI3qMqW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743561F000D0;
	Mon, 23 Nov 2026 02:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795402082;
	bh=yrk9+Mje2C0J1qnXfhBPjrjMZR0Y6jR+rEChJda2HwE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=CyI3qMqWU+bbm41Pvu5eArEyhtjiTt0S0MgixsjmMnIX8XzpTtcXkx19YoV/xmS9l
	 HMpqGRoxOGOA1NhKJ3H2UtIeX3UTIJW+8eDTdQfbSrm9RXF7gJTXIYZnWa0oEyuel/
	 k0fJ/dWSKO/w4sFbvhQTmoVdrA+siN9We+OGlyygTU0SADHC3DlcG4iMgdpZlF42tk
	 yzlUeRBp4mvjlzXvg65kGKGeekb4OApYFk0FISD0yeZ5xSXG8+HLG4N+iY7Jf138SK
	 S+JMqNDwUcRvas5sBIC9/IUOI0GGEVtjdkuHqW7Kdddmq/3ie0D2BWFMo6kTy5UnO3
	 0THvIYbT0tEbA==
Date: Mon, 23 Nov 2026 12:47:53 +1000
From: Kees Cook <kees@kernel.org>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
CC: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Stanislav Fomichev <sdf@fomichev.me>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH 0/3] Introduce a classic BPF filter cache for seccomp
User-Agent: K-9 Mail for Android
In-Reply-To: <cover.1795139109.git.xukuohai@huaweicloud.com>
References: <cover.1795139109.git.xukuohai@huaweicloud.com>
Message-ID: <EF2067C8-7F71-4D92-ABC9-25BC3234036E@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 20, 2026 4:48:49 PM GMT+10:00, Xu Kuohai <xukuohai@huaweicloud=
=2Ecom> wrote:
>Sandboxes like Firecracker use seccomp filters to restrict allowed
>syscalls=2E Hundreds to thousands of Firecracker VM instances can run
>from a single template=2E Each instance loads identical seccomp filters=
=2E
>The kernel repeatedly translates and JIT-compiles these same cBPF
>programs, wasting CPU cycles and slowing down bulk startup of
>identically sandboxed workloads=2E cBPF lacks dynamic instruction patchin=
g
>features like tail calls or tracing=2E Its JITed instructions remain
>immutable at runtime=2E This makes it possible to share the same cBPF
>filter between different processes=2E
>
>This series introduces a classic BPF filter cache=2E It is implemented as
>a hash table that maps user-space filter instructions to the prepared
>bpf prog=2E
>
>The cache lookup occurs before filter preparation:
>- cache hit: Returns the shared bpf prog directly=2E
>- cache miss: Reserves an entry=2E Concurrent tasks loading the same filt=
er
>  wait on a wait queue until preparation completes=2E
>
>The cache is instantiated per subsystem=2E Currently, seccomp is the only
>user=2E
>
>This series ends with a benchmark test=2E Every producer spawns one worke=
r
>thread at a time, the worker installs a batch of filters and exits, the
>benchmark reports the number of filters installed per second=2E The table
>below benchmarks the batch size and the instruction length in one round,
>running the command below with different option values=2E The base column
>runs the same command on a kernel without this series=2E All data was
>measured on a local test setup with 32 producers=2E

I would expect either memory usage or launch benchmarks, not just filter i=
nstall timings=2E

Is there a workload where there is a problem? It is hinted at in the openi=
ng paragraph, but I'd want to better understand the actual constraints befo=
re jumping to a solution=2E E=2Eg=2E it's already possible to share filters=
 by way of process hierarchy, so perhaps the issue is lack of hierarchy?

I've seen proposals in the past about having handles to pre-constructed fi=
lters, which could be applied (i=2Ee=2E much of the existing caching and li=
fetime management remained unchanged)=2E

-Kees

--=20
Kees Cook
