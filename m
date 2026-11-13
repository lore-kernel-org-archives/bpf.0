Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607206;
	b=D3eby081FsWV57WQIfO5SQRPfdRrWlneJI2vH5GIsXHbaMhlM0pyAtGL9JwiJq00aNSJ
	 KUzdSMXyE0MhY1MmTJMOB34c6jqde6QnADly0i0hFWK4Pm/AnjhVVEueTnRphtiQYNb+M
	 WGlpGqI10c/qLaSntxCxFLyb+KT1N0HFmtaTXh7Pypmg4ZAXq8YPfER37l34YFYeEc50T
	 LvfOsimqDg74s8hI15flFv78gMBiGLHI4oJu2lZMFV7tjf4Wz5Kaw0Uh69LM3a21xXIFN
	 XDClkBFnxZsNrYKLz6o+iCkw4LOlnhEjveuKLWH7bLnh/TTSlyixiDgjvLnjKsyuBgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=5urqeH+ZNfZzvFfHpvL0MZSQdZHgaWvWp1JZE9nopBY=;
	b=W2EVeID0rv5vAr2WhqL10X1G14SAvUqiLp1kPVrhsQTeYXYpKvpXYJG2lefOov5w3qKo
	 i7hz4+JEFD008uMwmqLsECHftoAEEo/u0oPnjJmmb8+hciGfhA0q8SvSSA21v1fU74ydY
	 sw5GodU5QHOhUuRi5vOrgQD0WmvuTViAHegZyXxq1xmPECdxtaISacC7a47ghJKOkJ3cL
	 qn6pAiAAeBjA9mgzr0Ac5mZ1V+YKiXc5D1qPVg5+R0s2oicU1QB+6NXYfre8tQ1ku0LOF
	 saToHMd3GyYjYGWZKT1fJbnkLoT5r1ZylfXt3LOatoGFEdeMXPXLTbGOLSiJWB87UKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdJi6AUD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574ED606A323;
	Fri, 13 Nov 2026 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdJi6AUD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FEE1F000C4;
	Fri, 13 Nov 2026 22:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607206;
	bh=5urqeH+ZNfZzvFfHpvL0MZSQdZHgaWvWp1JZE9nopBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mdJi6AUDFv/Jtua3OQE8bGoxIfYJe1XepllJ8CUcpbeVeO+Xk/wcv9e5JMSrOJpjZ
	 lIACuY/f03xxenUeLLcIFzYkKQBTBvQBMggcCZfn+TuFW6IbrzWPbVMU3VA1Knwgn6
	 u8v8aApmeXZ+7eZuR3SdA0Z/T7Rs8sAcBSDKPrCWHLK7tgolHKPIi1nV5PloohXSQP
	 UluSNRDR0Gl9DZs3f+I03O3VA6Btj9eZrlYLaOoPkNa3TRmmLlyFBaqyHtHPpL/KeO
	 WJhVpfMFAUapKPM2MJZH9v5rBxVYSecHKpEefa2R4LxEIaRNx0zqAhZsJ+cF6plL2L
	 3fGWqVHxV2yGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1D475380821F;
	Fri, 13 Nov 2026 22:00:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Add sleepable version of
 bpf_get_stack
 in raw_tp_prog_func_proto and tp_prog_func_proto
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179460720473.1862583.931377392708911121.git-patchwork-notify@kernel.org>
Date: Fri, 13 Nov 2026 22:00:04 +0000
References: <20261106080746.661431-1-yangfeng59949@163.com>
In-Reply-To: <20261106080746.661431-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: song@kernel.org, jolsa@kernel.org, ihor.solodrai@linux.dev,
 kpsingh@kernel.org, matt@bobrowski.net, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 yonghong.song@linux.dev, emil@etsalapatis.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  6 Nov 2026 16:07:45 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> bpf_get_stack() has two implementations.  bpf_get_stack() passes
> may_fault == false and resolves build IDs with build_id_parse_nofault(),
> so an IP whose backing file page is not resident falls back to
> BPF_STACK_BUILD_ID_IP.  bpf_get_stack_sleepable() passes may_fault == true
> and uses build_id_parse_file(), which faults the page in and returns a real
> build ID.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf: Add sleepable version of bpf_get_stack in raw_tp_prog_func_proto and tp_prog_func_proto
    https://git.kernel.org/bpf/bpf-next/c/4812fd2d2942
  - [bpf-next,v5,2/2] selftests/bpf: Test faulting build IDs from a sleepable raw tracepoint
    https://git.kernel.org/bpf/bpf-next/c/e8c1bcf8d591

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


