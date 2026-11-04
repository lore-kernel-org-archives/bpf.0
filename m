Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818236;
	b=nQBNyYJueDkhtYGNwtRg4VT2OA7S1tC6kX/44uM3xMI1yhLRHzdrTmxPwrEidco4/2He
	 3LGB5IvWatDvQI/ziKZWgrJMwhpUAA37GSudxGPJOK2EaoTo7uShGvT2H4AhMofrHlymh
	 /B/uICsK9Vb494Mr9U2J8WWTn50eOe7ryN/gPkb78dfmuONwrx3PDiFdAXWo/n+gJhYfi
	 A/Chkrdm+DjGzCz+AWL1mHWesY+5RA9JgZrPSzbX4ANKFl1VXaVR26yklGVrke3owSsdH
	 U5sV+q1CymkF0RA7vtzqnRUBA6w5PS5td51RhBAPjoBnnsz5oAn456W0eUMypwGWiTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818236;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=TCe3QCxOCVvg1soUtzYcHjTQdqmyGSWntKSRt/F1bxA=;
	b=lx4Yd8k7WyP2SP/qDqPgBgz3R8QKMkLFd+XRIDUb8Cg5bokYI0bX3eEWtW1Qby6T89Fr
	 O126UYn367PDSd9EozzaSs1oDql058sd3ou/3COUxBCJ3rRhF9BSR9AXL8eLg+VUc+F/z
	 jcG/M5cx2iSghQF1VJ987qqrX99l6IGRq2+A853Bt+Gfb+fijvjLu0NTA8ZPFULui0B1P
	 ii+OvX+XctjE1XVSWQajY6nxN+0LDVmYtr+hDEpEr3sHzV1O7aX1OozlXaQg0Ipe/kFOH
	 WpWqZ+mKjfzJwRT5o6Ji6THDeJo4VL28i1wJclTZtq50AXeabwYs8TI3cvdgSGxenuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eaX736Dz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1E6082BC5
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eaX736Dz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A021F00919;
	Wed,  4 Nov 2026 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818235;
	bh=TCe3QCxOCVvg1soUtzYcHjTQdqmyGSWntKSRt/F1bxA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eaX736DzEAnL8JvLG92/LaYmp62scjLeYKCa+m18D1SQ8DhPFLMYgxVuwuQ7ToU7V
	 Sjw78kiz915TQ/hNKhwArmMhEwb1/raXDWtp5ytDyQeI90Djxfgp1rjGM/pY0pa5Vn
	 aDT9Ifc/m2DncR9Nvhj8Qmhs29Len01hltCubX4Vf04sD3Qrhu23WoBRkiKCIy6v5w
	 PtXZi+DHgLbb0TLssnEVJhB76Nfffl3QMaiXyeUOf1ygJT88ufIdXek/HPpmMrYt3j
	 W6nMRMFSQntO2M6qLY2RDbUbJVrgDM6CWJhMIaPL+URf54NesIkllSRXq9bbF5hoo8
	 F8t8rhdQosJKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0D7380045E;
	Wed,  4 Nov 2026 18:50:35 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 0/3] bpf,
 arm64: Keep BPF_PROBE_MEM loads away from tagged user addresses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179381823407.3044562.9880414122485782665.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 18:50:34 +0000
References: <20261103231931.89739-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261103231931.89739-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Nov 2026 23:19:28 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> BPF CI on arm64 reported "BUG: sleeping function called from invalid
> context" in subprogs_extable. The prog loads from 1ull << 60. arm64
> ignores the top byte of a user address, so this is user address 0, but
> the guard that the verifier puts around a BPF_PROBE_MEM load compares
> the whole address with TASK_SIZE and lets it through. The page fault is
> then handled as a user fault in the context of the prog.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: Force BPF_JIT_ALWAYS_ON on x86-64 and arm64
    https://git.kernel.org/bpf/bpf-next/c/8db2aca155a4
  - [bpf-next,2/3] bpf, arm64: Filter user addresses of BPF_PROBE_MEM loads in the JIT
    https://git.kernel.org/bpf/bpf-next/c/8d8794555932
  - [bpf-next,3/3] selftests/bpf: Test a load from a tagged user address
    https://git.kernel.org/bpf/bpf-next/c/f68a11f141ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


