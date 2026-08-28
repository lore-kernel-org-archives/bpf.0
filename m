Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4903AE6F7
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939463; cv=none; b=Gnm1MkYD0FP3N50O/ZD+tCxQ/dMFjt1CfHQyKkGjQup2MDdZxjpJA7AmzHg5dR5RndTFCX13zUq2odrQYbNQkDHJWq16ZN2Ma+4Nqr16JbuWCgNRpseN1ZWT03cMWzpAa4+Ti2CjXgId3688UXlfNs+0dOHdT0Do2r1D125TW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939463; c=relaxed/simple;
	bh=8/6oK4kiB7VyEoRMCGmT8c3AYiR28TT1Uz5hYfeqXfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZadhCNEsisM84Y0Yx+sLKRj68ub4hYnyCfH9omKBlkJl0ZLyj2EaPjtujAv8p+Fxzw5xgNnqVOANytWI+xjtBCYNMJvSnirpXVp3Ja2gsLr11nSgjOPH2RRcrMUOiG9d1pCLqqQ974x/OniHg8MCUw23JAfULyvnRrYpTKjJdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9mW3JuV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9mW3JuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3F91F000E9;
	Fri, 28 Aug 2026 17:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787939462;
	bh=DnNgoIAlJcNsgoRlt1J8QxWmRKSi++0nX4Mc9KTzWtQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F9mW3JuV8XJNyuays4N4jLYBN0WmCciEM7idZ2+nMs9v3XzvCtEh48olmaFmTmahs
	 dvEqlr80d/XoMjrK2W9Q+LOsiqfzzb66CO4/8ux7dTjUPPuaWV4Ajm4xe/zQer4N/2
	 LHPR8Yw7WacMlEKJLeIX9if9SblKFbU8QxVx1DUU0R1BRBviFZkqLA5uxGYELn9VmU
	 dhkBAVv0HmqVOv9nMIUArocn1kxgqRRLCuSoV9pRR7TwQvonGa5lamYZLREKWOcbxG
	 0EdgH5J5j31n3a7NU9MII7AxvecuQMqH1WDfnYurVT4WZ9La8s1opMtU5BmaA8T8Cm
	 aGLYTNTFffe4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56922380AA67;
	Fri, 28 Aug 2026 17:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: don't downgrade half-dead scalar zero spills
 to
 STACK_ZERO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178793940689.2709471.3309560614561309281.git-patchwork-notify@kernel.org>
Date: Fri, 28 Aug 2026 17:50:06 +0000
References: 
 <20260827-bug-011-cleanfunc-stack-zero-simple-v1-v1-1-c0e996589a52@gmail.com>
In-Reply-To: 
 <20260827-bug-011-cleanfunc-stack-zero-simple-v1-v1-1-c0e996589a52@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, memxor@gmail.com, npc@anthropic.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 27 Aug 2026 15:48:23 -0700 you wrote:
> states.c:__clean_func_state() can downgrade scalar zero spill to
> STACK_ZERO in the following case:
> 
>   *(u64 *)(r10 - 8) = 0;
>   ... checkpoint ...
>   r1 = *(u32 *)(r10 - 4);
>   ... no reads from r10-8 ...
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: don't downgrade half-dead scalar zero spills to STACK_ZERO
    https://git.kernel.org/bpf/bpf/c/2f3536bff882
  - [bpf,2/2] selftests/bpf: half-dead scalar zero stack spill test
    https://git.kernel.org/bpf/bpf/c/c6ff14f1cd9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


