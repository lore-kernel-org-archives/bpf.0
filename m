Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88538E8AB;
	Sun, 19 Jul 2026 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784482841; cv=none; b=hqBdREyseIjqTzdWrMUhckzDEJy40z4iWSg2E43rrwvddr1/Fm7jeAYzYaOYQ8sJMyyNwcKGc/kO05TsdprA/7QmFUyV7mcgMWgkUU9MS1bUqcSASKVri0+7trO4pb4PuprWCfPVEYcBmq+zrsEREfwgE29IK/TMpd69wu6wPIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784482841; c=relaxed/simple;
	bh=MuBZEs4ANYef+ktbbYN1x4h8iv4DipendJaUS/ouLaQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IpGmaeAzSoiYd+pDIQ3fgiwsU1H47ex5+cPx0uUCcyUxe7jFpeYwVP5jX/xwdQ5QC5DywQWwMJFoVi6nIuEBNxhQys8eOSeVIJJ3E2bEf7KhmbyMW15JVpc9VZbU1qx47TwDTEL7z2W+M+I/4IOyawykTqevI0+kllt8Hvxulq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8O+3E+T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8O+3E+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0871F000E9;
	Sun, 19 Jul 2026 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784482840;
	bh=mtiVtbqsxcC8JHOa7PzLbrJR4kDLcy0tPMjAO2Ekvdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=J8O+3E+T2aSBtzyATzAT+J/GXCDV1dmbgRThFZRAR7DlQngMUoMyR7CmIXOmyJ7/S
	 DKhWJ/tVEec+fYYIsyRPq4Fm8OfmvCNL7hTNe/bvZDgN/xugH5+1fwOE0KzFzYTRaw
	 6QD+RLnE4HFvGTHsVQwnrvy4JytY59hWS6plQAMaQmgUMh7IRIDGOailoO7X3wFxKz
	 Ungu3K9HL/2qNzJC+3dx4PbHtcULTDwOgdZVBODQrhy78M9gBJZGLDPEA8d1kPEepu
	 9QCksX2oJzuUlFBxUbH5QcwQtKv5f7/do8njcZu2lXKR6IuzfTfwAOHTFCTCt+2VgH
	 cBaUTOaAMku0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A0938119C9;
	Sun, 19 Jul 2026 17:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] bpf: Disallow interpreter fallback for
 interpreter-unsupported insns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178448281114.2779986.17251425930565305503.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jul 2026 17:40:11 +0000
References: <20260715141122.15783-1-leon.hwang@linux.dev>
In-Reply-To: <20260715141122.15783-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 akpm@linux-foundation.org, shuah@kernel.org, puranjay@kernel.org,
 a.s.protopopov@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 15 Jul 2026 22:11:19 +0800 you wrote:
> Sashiko reported two potential issues about interpreter fallback [1]
> [2].
> 
> After verifying them by patch #7 of v1, I think they are real issues. With
> LLM assistance, the interpreter does not support the internal
> BPF_PROBE_ATOMIC insn and the gotox insn (used for indirect jumps),
> either.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf: Disallow interpreter fallback for arena-related insns
    https://git.kernel.org/bpf/bpf-next/c/34746b5a84ec
  - [bpf-next,v2,2/3] bpf: Disallow interpreter fallback for gotox insn
    https://git.kernel.org/bpf/bpf-next/c/905f716362e1
  - [bpf-next,v2,3/3] bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn
    https://git.kernel.org/bpf/bpf-next/c/7a0855e73757

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


