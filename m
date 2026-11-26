Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724410;
	b=yhif76fvCWv3biVDbgrEc68PD4l9KASRI4TCnK/IK5OH+JRm5wmPkVR6w1/3uQjrLVAr
	 RNgSsLRGwuEwOK5OjfA3MOJIUt/EKJhPtRBoQ6fymXCQ50k/oPisjy95P0uKlxpylAp7x
	 mRRM+7wK4i20TJaIxURVSmV+OnFOiffXvHD9D2eB6hno2KQsh+6ZweN3oc0ymi/WI4h5k
	 EWvaADuMSqpnV8kI2dT9IoMy6PStj4GBzf2wGPYrTd3YwSx56JpU07loiHOT+up/hIoWc
	 vEe0vNzpsTWBfLIADwMayaOU4SAs1UhPuf16NzKFJbbwgVqU/qkTpwzVmNQN2iueK4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=PGIhukGpvyN+r5ZW93aLYHKuhGSLIq3HRGZ3FOZDv7A=;
	b=lTk53gssQonFC7Y/FCBIPrg+zBDQgVnzFc2vlOjoKqgMAHK+mSQOkTkEg6N/J7E2lVW8
	 c/VyYCmL0vieT33ttATlin194zhEwYVcrsiobAl0VA875JRJMMgV1XBh/VbcV0ERnwa4/
	 Ux3+NxyABWPCbqtUObDZmeWKl+bw0YHzV6yNQizmqOspK86jfsfQsdzxizYDGcc9DRoGv
	 mFEZLkJzuLh5BbWP/mP0YgdDYVUgkhx+jP4x2UxsbbagPxvTa1UB5n9RUbouP3X6/b2TP
	 JPPOfiNri8zX2uWXGeO2auseI1NO1VNByYlTlNysytSGZA1Ti6CPJpC+Pq7Ujeu/E0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dH+yb3VC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7A606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dH+yb3VC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8F21F00893;
	Thu, 26 Nov 2026 20:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795724409;
	bh=PGIhukGpvyN+r5ZW93aLYHKuhGSLIq3HRGZ3FOZDv7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dH+yb3VCAI83e/fjx6AxmHfKeHvGkzTvFSvC4A6N2X+FIqv9dIGNe+S38szEWGqjf
	 fUk//VuGPHFvFThkx1uPNX+Kk1y25e9XsMg1R9TuyB4qmyDm2AO73wqM2VFHsX3d6c
	 wRDN+DqN9t0w9UIm0JeApqDMQ67j/gvhFzH9SKcI4JZwQJbdHv1IfDMeCGxggjY8eg
	 +lRG/04+ObDFv9v+OTImuvZRbCknMFFPoOQt5qp4HB5v70KQZuhy1UEKwbY2qic3WJ
	 Co/q8hbbV8D0NFLBlU+uPOLX25qDARtr73g8G4Hnqm4KO/JhZBqn27eB+H2ag3vhcm
	 iq2heU7zKfotg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 347193803325;
	Thu, 26 Nov 2026 20:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/7] Do not tag selected functions as fmodret
 targets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179572440800.600058.8637428916451285561.git-patchwork-notify@kernel.org>
Date: Thu, 26 Nov 2026 20:20:08 +0000
References: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
In-Reply-To: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, jolsa@kernel.org, almagui@kernel.org,
 john.fastabend@gmail.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 26 Nov 2026 14:29:06 +0000 you wrote:
> With CONFIG_BPF_FMODRET_SCAN=y the build tags the functions that
> return errors, so that an fmod_ret program can attach to them. Among
> them are functions which BPF itself relies on: the verifier, the
> trampolines, kfuncs and helpers. As was suggested by Alexei in [1],
> we shouldn't tag such functions.
> 
> Changes split into a few logcal pieces:
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/7] selftests/bpf: Test the tag of vmlinux with do_epoll_create()
    https://git.kernel.org/bpf/bpf-next/c/c37bde8f153a
  - [v2,bpf-next,2/7] resolve_btfids: Do not tag functions which work on BPF objects
    https://git.kernel.org/bpf/bpf-next/c/3928e6a30793
  - [v2,bpf-next,3/7] resolve_btfids: Do not tag kfuncs and helpers
    https://git.kernel.org/bpf/bpf-next/c/168f3971b357
  - [v2,bpf-next,4/7] resolve_btfids: Exclude a set of functions by name
    https://git.kernel.org/bpf/bpf-next/c/e82696a19484
  - [v2,bpf-next,5/7] resolve_btfids: Exclude bpf_*() and __bpf_*() of vmlinux
    https://git.kernel.org/bpf/bpf-next/c/0c55fc04af8f
  - [v2,bpf-next,6/7] resolve_btfids: Exclude the code of kernel/bpf and of the JIT
    https://git.kernel.org/bpf/bpf-next/c/6a82d647cfdd
  - [v2,bpf-next,7/7] selftests/bpf: Test functions which must have no fmod_ret tag
    https://git.kernel.org/bpf/bpf-next/c/c8446ba69af5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


