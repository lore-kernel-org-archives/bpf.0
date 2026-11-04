Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815806;
	b=U6UOS4K4ztb33qJv8nqNRM9RbRCDFnDTfJ5Wcp8LxIS8gDyIcFY6poPXp+6tttmBdUpe
	 9NyO/tKyVFtbSyrPpm4CDIsnoaP5JoV8e4R3weLN2hnbUumO5gDCc85/GT+hqd/QJsyOX
	 FBQTtXVILke3EahwTscVYptgif+Dksx9sADdhhdrPr8abeOTe37T+E9gqnCWmd58QKZ2F
	 2LJeFR4v4K8OpEZaE2aPAtDb4yHdkyvTwFBun7Z5MAKWhdiFZ0Jj1QGmQZ/WG5gn8vvRB
	 280xt0VIBrlY3OjLyph6WU359Tyq8LzxXyvk2L+g6J6I+O2xF9xkdPvp97jnZy5dy7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=NCgjTmpbfTdty7jfSH4fNaXhQxSVgOKLPTtCr6/ivrs=;
	b=ruBOZWgHcBQ5aum+ZOeQDs51if483xfADT4/Y6UmHALw0FhpcLbqDI8kJkju9NTeBJHm
	 fl9XVLW72veXmKbIQc+se7RULFhcJs/k2v8qK3kWWjrD0LCBTgxihezFAJgIOfLaHBEel
	 a/cePjea0fCxko97fEsHYvygds+0GZ8iwQPbfRqD4D18Gjx8+Z4zM4CfIAJuFlc3b9vV7
	 vuX2NaE1l1bCZEYNASW7m1n0h1BsOwMbwnApMvLc726CLPOJdDAqcfdlF/As4dE9cyPS+
	 Gl/pKEvoKfX+/HB4hKZNrkHyYFhjLILp8EMEqy4jloecYNbxHixLwhtkcSgkESjzFBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0AdudNG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382F8606A326;
	Wed,  4 Nov 2026 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0AdudNG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC241F000C1;
	Wed,  4 Nov 2026 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793815806;
	bh=NCgjTmpbfTdty7jfSH4fNaXhQxSVgOKLPTtCr6/ivrs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=J0AdudNGkXSebCsE08VjqzEq9SYmOmn2VHyXpY2WMdl687dHnojBJP2dir0jx7iDh
	 BZ4fuPq/ykmtBx855UZdR881+RgAbaFZdDkPM0wdH7ZmDOrVGtojjCaU8KZkvd1SWz
	 kPizLdiaEWkl86dLgCdTTdaEYdXeNL9Fb0lnREa2xLxZ6qiaBVUd0psj1ozpTRv2KE
	 yL5m8hxXppYZMeYMlx/7AMT0j3/yHq65t76XxaA2a3xy+Jof9Jcd8MdRDaRsqGUFiz
	 VLKsEIJteiosjcdOzSrpndvScvVS3zju9BVseu86jRvMUqSZ460+s0vbPiJPs3Uwgk
	 LpXAH5MVzr/Ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030923800451;
	Wed,  4 Nov 2026 18:10:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2] selftests/bpf: port test_ftrace.sh to
 test_progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179381580481.3018497.14332341271124252677.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 18:10:04 +0000
References: <20261104-ftrace_in_test_progs-v2-1-45363230d228@bootlin.com>
In-Reply-To: <20261104-ftrace_in_test_progs-v2-1-45363230d228@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: ebpf@linuxfoundation.org, bastien.curutchet@bootlin.com,
 thomas.petazzoni@bootlin.com, andrii@kernel.org, eddyz87@gmail.com,
 ihor.solodrai@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 04 Nov 2026 10:59:33 +0100 you wrote:
> Commit ff205766dbbe ("ftrace: Fix function_graph tracer interaction with
> BPF trampoline") made sure that trampolines generated for tracing
> programs did not collide with the function graph when we are returning
> from the hooked function. The series bringing this commit also came with
> a new test ensuring that the kernel does not crash when executing BPF
> programs handled by trampolines while the function graph trace is
> enabled, but this test is a standalone shell script, hence not executed
> in CI.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: port test_ftrace.sh to test_progs
    https://git.kernel.org/bpf/bpf-next/c/77ac1105bf1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


