Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5A39A7F6
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785546650; cv=none; b=tU2RoJXnAKtm38rM4JuonPpAbbIYa/LRMf3TfeYA3V3EKphEZ4TL9w/bxblmTAmhKOPehDpxRIV2KV4g1ccMgck9+iqywe/eCx45sKCNTM8XhTTME7gk1/GtEVtJGeU+cgwszKUzZSsHJCXv92C4v2UbcPnsgPzTUd6X+uk+j7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785546650; c=relaxed/simple;
	bh=RDZjSRT8QJnJ5Jpyee1OCFFvPnxuHYic8Gz9F9dgqf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ibUR24I0hhY5T3uWFfyUeylCV6B3l8esODFh0V3nNtQHnXrDawKrAbi//L7WZUuDqoslhikjjIDr0eoWGbL+yyeX8OE7e1TgbT1nHRYtjcBmqz0k0LtvKljUfntDeyJg/cKQ00GAGZJDem+zMGCnEydh1tZ1/ZdRhM7RYcknF4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0KLArVW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0KLArVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7083A1F00AC4;
	Sat,  1 Aug 2026 01:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785546649;
	bh=Evmqmk+2/MG1Y8i+0TU8L8MiRP6wuHVJhxfeMMRhc7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q0KLArVW2O2rT+2K38yMgqU/cWH7i9KM1ubqUczYkxEXlPIFTctVpaQ9BXw7GS7AV
	 GJ4HSUeJmZaKS8P02JjvxQlmqBmogOzv+9VQn0GZ767wWOuWij9Xf+Mg33xY249x+P
	 /UnXCFg6VzBy/2zLHYVwvKuk1yS+DFQ/iDSAWY0B3MIXZ1Az/3BhJlfZU7gQlY8pzd
	 YC4wMLDd6ftWw6L/AXPS7DdS2UZpMaad7db6NY5IGrgpJWqaTyTVAFo/0XUIu9F1iV
	 +bHRF7PYnep7fnrdX0sgthMC+1t04BfOFzkJGb27SqE7/M+aGEWgi6WnJSKwV74pZU
	 i3FPCZvDO8nLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5689E392665F;
	Sat,  1 Aug 2026 01:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] bpf: Fix trampoline handling of 128-bit
 values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178554661214.974239.3202155911510305468.git-patchwork-notify@kernel.org>
Date: Sat, 01 Aug 2026 01:10:12 +0000
References: <20260729050154.2585468-1-yonghong.song@linux.dev>
In-Reply-To: <20260729050154.2585468-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue, 28 Jul 2026 22:01:54 -0700 you wrote:
> The BPF trampoline preserves only 8 bytes of a target function's return
> value (R0), and its register save area under-allocates space for 128-bit
> arguments for x86_64. These two problems lead to memory corruption or
> incorrect values observed by BPF programs and the real caller.
> 
> This series fixes both issues and adds two selftests, otherwise, each of
> them will fail if without the corresponding fix.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] bpf: Reject >8 byte return values on return-reading trampoline paths
    https://git.kernel.org/bpf/bpf-next/c/c48796aa6c39
  - [bpf-next,v5,2/3] bpf, x86: Fix trampoline stack size for 128-bit arguments
    https://git.kernel.org/bpf/bpf-next/c/814cba835ef6
  - [bpf-next,v5,3/3] selftests/bpf: Add tests for >8 byte return value and 128-bit arguments
    https://git.kernel.org/bpf/bpf-next/c/13cc6b788b1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


