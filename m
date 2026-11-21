Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795304658;
	b=VkSHfX+G5mWm6NIvYkkMT+0qDuuDh1ubzjkgNM4eNVEx1iAL8AT+UIAC3SrXA8eCQPOl
	 nNrTruxLwm8OSQP6E9oD2GYMl/ks6joKhSzO/Am5Axb+jAIySYqhYt1C6DnC8eedtjrCk
	 26LxrK1QbP3HwPOwJBj4l9uVMlrCFTj1+QpHCbgUX2ilRxZXojjLlF6b2ExGVa4dKJXPH
	 +n3oXzxa70ysmh9/1j/rgRfS1hSEnbB49+mUyZ9ZqcZ/DtymKhhyYIjnKrI5C27zgjKVi
	 hwzGmGDVgAlh3xbUJ5TeHdxqAIlZ9YrzqW1z/Y9h/Gxt+IBNfGRt/Q7lX54oqlgE6xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795304658;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=df/k3ajSIskGLBKWipJ3E1vtkpO+CMqpP4zKb98vN2M=;
	b=Lk1V2KfkHsgFDRULwSc0qvEP0/1dkRtdb5J6xICKGc5uQcLKVo3dmloy7STDE6HtmDP5
	 KTZQLSLDD9FTMzGN8TIGx8v5HQvQuZi1omRfCz4q2clWjFYveoly0DR0eXHv/N+7sw/WO
	 xepU2GNfzg9Ggdo+twTVJqSziHbrcMSumLF+/TBD7IN34OnBAEn794NfclEWi4ZiLdy9E
	 mmWq06hXR80zo9GAqgCRFsfNwsza1uDJOQiLIliFKZUp9KiYGxxorCpcFOQ4AYpweA0Vu
	 GSb/aDpo2M+Ms7PzYCPuFrqiOU9sTF9YbhW2yr8BFZ0+JY9DDu4H5wmz5XAxT4xPZAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlncGxVZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C3A606A32A
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 23:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlncGxVZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6CD1F000C4;
	Sat, 21 Nov 2026 23:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795304657;
	bh=df/k3ajSIskGLBKWipJ3E1vtkpO+CMqpP4zKb98vN2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UlncGxVZbOEycDuRsH37gTFTVRVWpwp0QQ58s417VIAHbFcQAY9wZG32He/mGkRUC
	 b6U7b04cfpww0nZvx/CeVuZW4n0wT8j5d0BxLRsyML0M8zMeDGhcsoNCaVWhEEA7uZ
	 VSPDrhEa1thXysKyxOHQJIbKMYPB6wLj4Fevn/Uqj2S4mEVjeMzmGhSXIZaG6mZf22
	 PtHNnlD412BOSVGQTMJIH+Dz69VQPy7ZQ+ConN/oheYzAzVoDeefPF/pUuTWzGJtBI
	 sQKmqtjKh1GBxBu8jdGcuGaSIBUI0gI9z3KeMi5F1tAuwNw3nRjEYEy7Bx3/1Fq3Jk
	 k9aLMS2KB4nDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4361391B08F;
	Sat, 21 Nov 2026 23:44:17 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2 0/7] bpf: Fixes for the verifier passes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179530465627.1212208.13881178207842835566.git-patchwork-notify@kernel.org>
Date: Sat, 21 Nov 2026 23:44:16 +0000
References: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 21 Nov 2026 22:13:37 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Fixes for the series "bpf: Verify in passes, with equations in the state".
> None of the bugs makes the verifier accept an unsafe program.
> 
> Patch 1: the build fails without CONFIG_NET.
> Patches 2, 3 and 5: the path-sensitive run finds a failing path that the
> program does not have. It cuts the budget, and a valid program is rejected.
> Patch 4: the log shows only the last basic block, not the path to the error.
> Patch 6: after a failed allocation a load gets -E2BIG in place of -ENOMEM.
> Patch 7: nfp can refuse to attach a valid offloaded program.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/7] bpf: Fix the build without CONFIG_NET
    https://git.kernel.org/bpf/bpf-next/c/625e1bdc1db8
  - [bpf-next,v2,2/7] bpf: Do not skip trips if the bound moves
    https://git.kernel.org/bpf/bpf-next/c/d7db96e1c61b
  - [bpf-next,v2,3/7] bpf: Mark a skip of trips as a guess if a 32-bit value wraps
    https://git.kernel.org/bpf/bpf-next/c/e247bf610bee
  - [bpf-next,v2,4/7] bpf: Do not lose the failing path if only an equation differs
    https://git.kernel.org/bpf/bpf-next/c/e42c915f6a9f
  - [bpf-next,v2,5/7] bpf: Drop a path of a path-sensitive run that is out of frames
    https://git.kernel.org/bpf/bpf-next/c/5f2775434dc2
  - [bpf-next,v2,6/7] bpf: Return -ENOMEM if the next partition has no memory
    https://git.kernel.org/bpf/bpf-next/c/9ec090cadfe0
  - [bpf-next,v2,7/7] bpf: Replay an offloaded program with the precision of the good pass
    https://git.kernel.org/bpf/bpf-next/c/695ce5ca70fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


