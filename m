Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792546022;
	b=gWzXGjVEWwuaOIiYAM2PjlHD4v6Tz1IvN82/AsnTJ6SN27NIBXCYn8rLswxEED0cjzps
	 +2Dw7YWzu9UnkcqIoCoSFwvb08YrH1r9gR53uQeGH6cxOxrRt/tFmcV9nGyadqY4dDR6K
	 uWC6HLsLxNejk+ukecBXTvH2oPdni0DlXaGRyWiBIQL1QZrYj9aFs9Eoz9kKCSrIRVXeN
	 ++SaVUMmmK0iJHexLnDTVZp6jNATp5ih+U52m/unWI0yFwa5Ls/yDaEj7YuOkybafT4AR
	 IIOxNH8j+Oj5QtELUbXHQUIQddDbEhW/w25zTG124p+9x9xEUeeJGARCGS1kKF2h3xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792546022;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Hn8gzc0bhv9nfAFVJ07Ihg2A3G1+jFD+Sf19dCfHSbY=;
	b=i5DDx7CBt4uL+krngksTtwSQy7sXin8+xeTCtz6mrXvoMtScKJw1IiOn/tjUZp5k5Z5q
	 EcDXx1vO+1Je3JpWVfn9g0lawCoDoHKgaePfNyVbf4ewaKD4XUqD/5hhLjcAw5EUSn3vP
	 HrM8tsLQu8mJBxAuX/cH+cSyX0aJXblU10QzmAbOVn5UiAQ6UZOBGiyIhvtsfg66AcFw6
	 1yIYsOEBn0BX8K2E6/Zdm5KKR2/T91pPMMG/Zmz2oS71Vu7yRVDCPBHgT7KG2oeMAQ0pg
	 bhA8YSQAPFpmK+8Qx3Enk94a1B14aPpn1/HOqJGQShUE7RaOVVSgcnLGYgbawLISE0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqAL0qUz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6718C606A319;
	Wed, 21 Oct 2026 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqAL0qUz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71DA1F000C9;
	Wed, 21 Oct 2026 01:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792546022;
	bh=Hn8gzc0bhv9nfAFVJ07Ihg2A3G1+jFD+Sf19dCfHSbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KqAL0qUz4xPSyMQk//AkXpBg3r29MgB+IoltQDglGmB95pf5a4atsqZNzoqxf6fEA
	 u7IJunerI0pRUQyRpQTQjap35SeyZzUcCKXYBWvPkC2HY9khoIfObY8mNXIKz954+b
	 F9RDJ4jbYplSTQussplNWihVem2ijW3486QYs9NbN70LzzsFNNUIkAQ0qQ6zSzbo9l
	 5atela3Ng2hDrREmNky8h3HvvFVnO0N/O98ejswphaxx0z81OwP76nb9rqDsmjlIm3
	 1FoCB9c0qKYfByjmL4/fKzCIavyp9lHHLT0SGfYSZ8fvfyiLO11BNGdihaQaDhPO64
	 OpkzuQmi/hrDw==
Date: Tue, 20 Oct 2026 18:27:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: ast@kernel.org
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 shuah@kernel.org, kuniyu@google.com, liuhangbin@gmail.com,
 mkarsten@uwaterloo.ca, masashi.honma@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 0/6] bpf: Add syscall common attrs support
 for xdp link_create
Message-ID: <20261020182700.655edf14@kernel.org>
In-Reply-To: <179253001886.208021.6536312952037292688.git-patchwork-notify@kernel.org>
References: <20261020152804.39863-1-leon.hwang@linux.dev>
	<179253001886.208021.6536312952037292688.git-patchwork-notify@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 21:00:18 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
> Hello:
> 
> This series was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:
> 
> On Tue, 20 Oct 2026 23:27:58 +0800 you wrote:
> > I'm planning to add syscall common attrs support for LINK_CREATE cmd.
> > 
> > This is the first series for the plan, that adds syscall common attrs
> > support for xdp LINK_CREATE.
> > 
> > Thereafter, retire the tracepoint bpf_xdp_link_attach_failed, because
> > the underlying driver's error can be back-propagated to user space via
> > the syscall common attrs.
> > 
> > [...]  
> 
> Here is the summary with links:
>   - [bpf-next,v3,1/6] bpf: Add syscall common attrs support for link_create
>     https://git.kernel.org/bpf/bpf-next/c/c8e3a753a9ee
>   - [bpf-next,v3,2/6] bpf: Add syscall common attrs support for xdp link_create
>     https://git.kernel.org/bpf/bpf-next/c/d80d00835520
>   - [bpf-next,v3,3/6] bpf: Retire tracepoint bpf_xdp_link_attach_failed
>     https://git.kernel.org/bpf/bpf-next/c/278568acb588
>   - [bpf-next,v3,4/6] libbpf: Factor out __sys_bpf_fd helper
>     https://git.kernel.org/bpf/bpf-next/c/deb9732f53da
>   - [bpf-next,v3,5/6] libbpf: Add bpf_link_create_log API
>     https://git.kernel.org/bpf/bpf-next/c/1480f290d1f7
>   - [bpf-next,v3,6/6] selftests/bpf: Add tests to verify link_create logs
>     https://git.kernel.org/bpf/bpf-next/c/f23fa8f01ce3

Please don't merge changes touching core networking without an ack from
networking maintainers. I haven't even finished mopping up all the ways
the XDP link bypasses normal XDP safety checks :/
