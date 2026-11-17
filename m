Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915845;
	b=UWnUqV36J42jTrcEZq+Iujuwx3kQgu0QhlRg4dF9gp0CGboy3WEGjR8DyfSa5eNo+Zef
	 jc/Cc6F390TKSw5vSDQSI0zjZfUViITQ89JT60LAkyX+h9omc1pYKfaV02dKpTYS6wxp8
	 Ia+00e73dDVs476o6HHFrW2ZZuB4nB71SzasTHoIU+DF2p+4uqI41+sJGb4WhsIeNaUjR
	 IdpmONpyPRg3Lsglnd6YxTTOVh0CPdD13kHvX9iFDdu3e3GMyPcB328ey6zy4mAbQGrqi
	 P9mmHQPzo6Gq4jrdisz6x8E1XMMhjeVSotgZdHucxh0hmE10SBYTbNI2ugWnE59nuRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915845;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ieN+TO1n4IB/ZKOl7F69AZAHpPBYXqZE4LxlRYEth50=;
	b=IcwkAlpKefVkAtxwISJpqPDCX15gvzjSuIWI8BqPMIHbRBhsedIhuh9xjF+M2Ao9VxcL
	 QQJwfRTVrkcdLx8Iv+4j3m587aBFKbL9NkeXpS77GCgKaWQanDUCDJJFS2jMVDxezHCsj
	 pzKyW63Cn9vWnLZTTw1BjwSwTA+bgC7d2RAmRA5MIyEfeWIrrUaLCYkCo7GRTu7xvvmTC
	 K2i0LgjxtatZVHLWXR1Eqd1+CSjeD4dR9usZdv5qoWeRjZvvzvOEvbuNuS+EYV8hepbQf
	 wKcn6PPhcmShWCXKT6OQ3H4m/gDhx/KmugGXpGLDlT5mjDAr8aJFBE75LHspc54Sb6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czqYB87R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360A2606A31C;
	Tue, 17 Nov 2026 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czqYB87R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A25D1F000C4;
	Tue, 17 Nov 2026 11:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794915844;
	bh=ieN+TO1n4IB/ZKOl7F69AZAHpPBYXqZE4LxlRYEth50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=czqYB87Rz7r4hHfDK+oinW4O3yisgEIjQt9IsziTSELpg8I7GK25iEtfqD9ZOQUAl
	 PgqVeDOrYw9dGbhV8u24Qvpcfokbc6YoWpb+BMyUxgTDxHjWiXkc9eh80o0sHdAUAc
	 6g+FsKo+q47rVTPVGCUmWS6aIWAvtXsj2UWKa8r/AcCicW4Q26vyDZ/rKtv2t9M0D4
	 weYSrlCbfREhQ63yZH8J2LqqchJBNcLFZq0pN2CzP/+ITjjf3dhB/GGksBsujNHrrU
	 1Vi+xUF0z/94roCi8eq4+xRugOjOgGfUv+juRjc527yPPbMlcWcF5MuUHzFnXmz2pP
	 Rjscz6uG3xvqg==
Message-ID: <sashiko-outbox-218720@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Avoid per-CPU private stack in
 preemptible tracing progs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mike Bazov" <mikeba@sentinelone.com>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261117-bpf-preempt-v2-r2-v3-1-586376ec3672@sentinelone.com>
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <20261117-bpf-preempt-v2-r2-v3-1-586376ec3672@sentinelone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 11:44:04 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bpf: missing Fixes trailer for commit a76ab5731e32 in commit
  message
--

commit 3dec129be9ecaaef86d1be659b28f0d6ce4d6395
Author: Mike Bazov <mikeba@sentinelone.com>

> bpf: Avoid per-CPU private stack in preemptible tracing progs
>
> A per-CPU private stack is only safe if a program never runs in two
> tasks at once on one CPU. Commit a76ab5731e32 ("bpf: Find eligible
> subprogs for private stack support") gave one to tracing, raw_tp and
> tracepoint programs, but they run preemptibly, and two tasks can
> already be inside one of them on a CPU:
>
> - Two raw_tp dispatchers that tail-call the same handler each pass
>   their own per-CPU recursion check, so both tasks run the handler.
> - A tracepoint program attached to a syscall tracepoint and to a
>   regular tracepoint can be entered by a second task through the
>   regular one, which only checks bpf_prog_active.
>
> The second task then overwrites the preempted task's stack. Neither
> case can be seen when the program is loaded, so never give these
> program types a private stack. The next patches make such overlap the
> normal case.
>
> check_recursion() told tracing programs apart by whether they can get a
> private stack. Make it check the program type instead, so that
> recursive subprograms stay rejected in these program types.
>
> Move the selftests that relied on these program types having a private
> stack to kprobe.multi and perf_event programs.
>
> Trade-offs:
>
> - These programs use the kernel stack again.
> - A program with two 2000-byte frames no longer loads: "combined stack
>   size of 2 calls is 4000. Too large".
> - Unwinding on a private stack is no longer tested at run time: raw_tp
>   was the only such program type that BPF_PROG_TEST_RUN runs.
>
> Signed-off-by: Mike Bazov <mikeba@sentinelone.com>

[Severity: Low]
Since this fixes per-CPU private stack corruption in existing tracing,
raw_tp and tracepoint programs, should it include a Fixes: tag?

  Fixes: a76ab5731e32 ("bpf: Find eligible subprogs for private stack suppo=
rt")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-bpf-preemp=
t-v2-r2-v3-0-586376ec3672@sentinelone.com?part=3D1
