Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289229;
	b=b/IatSOSuhix0JQ7qK5Ynlse1VP6us9TrkzYCIP+KbLSE9YCSAP+9dPc6qrI7eSAjleS
	 LqGM13lG+vM+ICmBcdkwPSphQ8ecTkSkSQ91gY6LDVaFnDnpz3f5sixADADFqlI7lZP1N
	 hLSgO94TH/whZFww8O45+D8xNku9x7t+SNnmXsdl+XDR/kHsP87jnhfATHIMiFemNKC8p
	 AwxY61Qd2qoe1aYKgYp9GOUn4P7txKwBnHsKt8N1NI05XSoS6lvgVhhdRzzVdTUF/y3Nd
	 LNBcSL65xVLpT9B1g0nrsuvmbfbMmE/j2IlOQiqn/NlejvOs7yeDkTucEi8nOj9kXjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289229;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9oHgoMNppljA1v1665oeA7qzNnjE6fLvD9MUAVdurBg=;
	b=d3DvA8mVy2TRXxKnxmTSieRzlIZX9ZC3r+xrtVr6TvbyKoqYwbhL2Ij5EqWMKl3QDw5s
	 bxbafAsuhBJ4FVtQHZDRGEIQ/Yop8MOBeMorJWXBVk5ZwUTqdSciRh71qdeN+VDoK9HWA
	 GBlGHoBIqRwGbx5nBf+3Z4K/RqQ3PATOa04nvbqDbIFy9OHWqvzHCZxspUh6X6QH0nqYH
	 kH4CLwjek+bX1mLFjsmsqE5zTCsSP5ejiiiaVZ9h6Z5cBPy821TrbBm3DYnRR4P/Fy3dA
	 nc5tV3XENcIR5zzoEIFdXrS9zVY1aJmQCIYqri/cCsbVvarMGlH7A9U7I/Jb/Wt1d5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ei+Z2eWF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDE4606A325;
	Tue, 10 Nov 2026 05:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ei+Z2eWF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B9F1F0089F;
	Tue, 10 Nov 2026 05:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794289228;
	bh=9oHgoMNppljA1v1665oeA7qzNnjE6fLvD9MUAVdurBg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ei+Z2eWFJ9CODTLEDShOv/Pf0yFH6HijCt386QN1f3mFSRC4tlPgZ0OEf518Gs3fQ
	 6krIKjsElm6RnOZuHz7haXrSpR0oeUy7RoooTHrkViUYv9zcqyFFesgduijzfn7qym
	 iDolM3/t1xQgcOV5HiURSFdwMfQO/yhz1yZ2xfb1x2p53UR366JmaUJyo8njAjZJnp
	 QGQtx9OIXBbsSdTdlIr0MYMnDUyZiDrN4a97YyL0Nkcb+U3Zk+UU0mHBoExOM9xeUg
	 PtVHclxBAGrKGZSgMODhiUrs8b6jlFWji+E7jrKkuNO4ui/xC8aK9kj4x5ejXZzhjY
	 Sck12fmuO91Zw==
Subject: Re: [BUG] bpf: tcp: bpf_tcp_ops_set_rcvlowat() missing from BTF with
 clang KCSAN
From: netdev-bot+sashiko@kernel.org
To: leitao@debian.org
Cc: kuniyu@google.com, netdev@vger.kernel.org, llvm@lists.linux.dev,
 ast@kernel.org, yonghong.song@linux.dev, bpf@vger.kernel.org, kuba@kernel.org,
 tj@kernel.org
Date: Tue, 10 Nov 2026 05:40:27 +0000
Message-ID: <179428922768.994134.14043808841864559669@kernel.org>
In-Reply-To: <au27Y9m78_3EH2v1@gmail.com>
References: <au27Y9m78_3EH2v1@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message of "bpf: tcp: bpf_tcp_ops_set_rcvlowat()
  missing from BTF with clang KCSAN" is cut off and missing required…
- [Low] The patch fixes a regression from 5f549c1e49f3 ("bpf: tcp: Add
  kfunc to adjust sk->sk_rcvlowat.") but has no Fixes: tag.

--

bpf: tcp: bpf_tcp_ops_set_rcvlowat() missing from BTF with clang KCSAN

With clang and KCSAN, pahole drops bpf_tcp_ops_set_rcvlowat() from the
vmlinux BTF. This breaks the build when CONFIG_WERROR is set. When it
is not set, __bpf_tcp_ops_init() fails at boot. The patch works around
this by passing the clamped value straight to __tcp_set_rcvlowat()
instead of reassigning the rcvlowat parameter.

> The kfunc came with 5f549c1e49f3 ("bpf: tcp: Add kfunc to adjust
> sk->sk_rcvlowat."), and 201a454df948 ("resolve_btfids: Fix the
> --fatal_warnings exit status") made the missing BTF fatal with
> CONFIG_WERROR. Without CONFIG_WERROR the kernel builds, but bpf_tcp_ops
> is never registered:
>
>   initcall __bpf_tcp_ops_init+0x0/0x70 returned -22 after 302 usecs

[Severity: Low]
Should this carry a Fixes: tag? 5f549c1e49f3 is only named in the prose.
That commit added the "if (rcvlowat < 0) rcvlowat = INT_MAX;"
reassignment in bpf_tcp_ops_set_rcvlowat(), which this patch rewrites.

Users can see this regression. When the kfunc set fails to register,
the chain in __bpf_tcp_ops_init() skips the struct_ops registration:

net/ipv4/bpf_tcp_ops.c:__bpf_tcp_ops_init() {
    ...
	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
					       &bpf_tcp_ops_set_rcvlowat_kfunc_id_set);
	ret = ret ?: register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
    ...
}

The sched_ext workaround cited in this message, f2f095c87603, has a
Fixes: tag too. Would something like this work?

Fixes: 5f549c1e49f3 ("bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.")

[ ... ]

> This seems similar to pahole behaviour sched_ext hit with a bool
> argument, discussed in [2] and worked around in f2f095c87603
> ("sched_ext: Work around pahole 1.32 dropping
> scx_bpf_task_set_lazy_resched() from BTF").

[ ... ]

> Not reassigning the parameter is a workaround for me, with any pahole: clang
> then describes @rcvlowat in w1 from the entry, the kfunc is back in BTF,
> and __bpf_tcp_ops_init() returns 0 (tested in virtme):

[Severity: Medium]
Was the commit message cut off here? It ends with a colon, and the
virtme test output it introduces never appears.

The message also says "discussed in [2]", but there is no [1], no
reference list and no Link: trailer, so the pahole discussion can't be
found from this commit.

There is also no Signed-off-by: line from the author. The DCO in
Documentation/process/submitting-patches.rst requires one, so the patch
can't be applied as posted.

The code change itself looks fine. Passing
"rcvlowat < 0 ? INT_MAX : rcvlowat" behaves the same as the old
reassignment.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/au27Y9m78_3EH2v1%40gmail.com
