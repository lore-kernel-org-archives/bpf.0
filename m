Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F65828468E;
	Mon, 26 Jan 2026 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460011; cv=none; b=tqnC0Nob3wLOSUJ7MqM/Pc1a+5S9WUKd+7+SAMHdTYSlIQDv6zLbuzU1n0gA2R5UQiLgaijXVc6c4p3iWm22LWTDSZgJv+40aUt2DV7gXJG0u7ENon6lfUUOck8VYgM1ExdV+BIMRLlmIF8i1wTKABal6f8qGyccqg43OJwefwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460011; c=relaxed/simple;
	bh=SWRJ6Etxyuca0Vz51RgbSwY8s9GhpJAbphHswyNZ4o4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jZlb21ojJXVVdTc5PqlwcbYoNc+HDfcg3z6pDLN1Bl33yNZh20CqFB5f1/5DE++Ob22cNAuNA6O1d0HbpNe5QMFqetAokktikGKcDvHVG7PT9PDPoSdIP9obrd4zBM4ZI6uwe2Nmjr5Gcde+/N763HEBKv+o99TonzCY62+/CS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYdN0+CE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYdN0+CE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9377C116C6;
	Mon, 26 Jan 2026 20:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769460010;
	bh=SWRJ6Etxyuca0Vz51RgbSwY8s9GhpJAbphHswyNZ4o4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BYdN0+CEIoBgyKrH3FLDmQmC/12ykcQhM5fw4o9WSn4Aofpkg/ICdP7G61X6MqRCH
	 rGvGASKV2s44rxFcc1obPMNKrJY/KnufU9JeCcTgVrMVsSvpoFOmTZTp6GIcs6OQKP
	 YKHE8fbIhZvM/2te+mb3wdF1goAvNigDwa7T4S7jJI8EFEjxVr0nmj1+YbLkE0lDkY
	 g3yy6QqgMMaqZX3yZ/JaJnGx/GLE/c1yKqjtf/0UqfQY3DvLSrJKhcm5P+nwurvsLv
	 LMnIfEbB9OzvfhdoaA3UQ1xLMCpSVNEqHcnJ7ZgS8idazp8NfY398cspCukSd9WftE
	 xoYr3nl+OqG8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EB9D380A953;
	Mon, 26 Jan 2026 20:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Harden cpu flags test for
 lru_percpu_hash map
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176946000512.169775.3162391575586650912.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jan 2026 20:40:05 +0000
References: <20260119133417.19739-1-leon.hwang@linux.dev>
In-Reply-To: <20260119133417.19739-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-patches-bot@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 19 Jan 2026 21:34:17 +0800 you wrote:
> CI occasionally reports failures in the
> percpu_alloc/cpu_flag_lru_percpu_hash selftest, for example:
> 
>  First test_progs failure (test_progs_no_alu32-x86_64-llvm-21):
>  #264/15 percpu_alloc/cpu_flag_lru_percpu_hash
>  ...
>  test_percpu_map_op_cpu_flag:FAIL:bpf_map_lookup_batch value on specified cpu unexpected bpf_map_lookup_batch value on specified cpu: actual 0 != expected 3735929054
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Harden cpu flags test for lru_percpu_hash map
    https://git.kernel.org/bpf/bpf-next/c/78980b4c7fcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


