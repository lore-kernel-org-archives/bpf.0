Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF82486BB0;
	Fri, 14 Aug 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725655; cv=none; b=IQHZSQuZbOTbtVK85oydkbvzEcgitn83h2xLCf9JA6pX+whYQ922ksHAJMZGygBDBDQjOAB1yJCE25/D7yDi4Tq0IitISUY8WTXRcexdEz9YMp3oXF13hR048c0SC9unlNWchmDZX5qZt35UauY3D4ED34pAbimzUVopzVrZL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725655; c=relaxed/simple;
	bh=EYscIen0Tqg/mtSOBr6JW+aVyo3Az1UzBsQoXPI/p9U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZZ7FbKX35eyZvMNDemEoydtKsZb7e7iCi4E8Bs/hx8ZAaK824RZTCzzqocAhkwOn42TEUu3ndVLnxEVd2duaY7VOrWpStBbvEpBTZrzfzkBrh7OjhwVCMF1tGYOUrRd+yQ2CgCPPDh7KpJXg9yyNYwT0rAXQqIYCovizibhWR+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5t8JaxH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5t8JaxH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760E51F000E9;
	Fri, 14 Aug 2026 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725651;
	bh=pesslFaOEa8JvyJ8uAg+pzK1/3qJ0pf9Cp98BtT67BA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B5t8JaxHUQsD7z+6awfaL8VBAOPgBvTwnd1TusZLms3Y8soHGmIJAHOHbio/T4xE/
	 QYp8VF4B1BXPHpookI2WFs8a+y5LyfNhCwD+ETzU7dJiJEm1ilkh+7rEEx0R2zSOyO
	 3uBO02WIuIs62GgIQeEv5kMPjK7JkZNfIZdgg0rLXMUKMeIlhrE9qkZoXR/qHpNC0Q
	 0fWdEJVAXAqA2Z8e7JQ01rSzfxkKWwfyCp13rqCtUkrt235VJEogbacq4vAt3CFCSK
	 NGFQYs7VQZoOZrCrpvzRroHx8K60FV+nz/zJZ1q7ZswhpZT5zXMvVrVS+nclttMcA7
	 J1ELHJ3pykqYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D099A3924451;
	Fri, 14 Aug 2026 16:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] riscv,
 bpf: Fix missing sign-ext for signed 1-byte and 2-byte kfunc args
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178672560540.3871347.8662836444766849077.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 16:40:05 +0000
References: <20260814064726.3607615-1-pulehui@huaweicloud.com>
In-Reply-To: <20260814064726.3607615-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr,
 pulehui@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 14 Aug 2026 06:47:26 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> On RV64, the ABI requires sign-extension for signed 1-byte and 2-byte
> kfunc args. However, the RV64 JIT currently does not perform
> sign-extension for such kfunc args.
> 
> Before commit 7ce090afbf72 ("bpf: Infer zext_dst based on static
> register liveness analysis"), state pruning could potentially omit
> zero-extension of 32-bit subregisters, which inadvertently masked the
> above issue by making the args appear as if they had been properly
> sign-extended. After that commit, the problem is exposed, causing the
> kfunc_call/kfunc_call_test4 selftest to fail.
> 
> [...]

Here is the summary with links:
  - [bpf-next] riscv, bpf: Fix missing sign-ext for signed 1-byte and 2-byte kfunc args
    https://git.kernel.org/bpf/bpf-next/c/f2aaa6215910

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


