Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF1390226
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787253665; cv=none; b=idSW/Q6g62z8Xj7GcZIjB3gwkY6GIhM5BlXffoRCLFPGp+WlOIihW4HCHy4h5onyHyNQozLu9EKwovU79pK1tk0aWGOJU8USbWpOubnAKp52vFmwbjjCMBtWHO4a4cmpbGm7jhgCnX69TKdnkUWqHYQ540uLL3YRNGg3YWIbQLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787253665; c=relaxed/simple;
	bh=pzJ+/u8n3c6ABbVQjsaKCa6OXimbrioBQanG5w4lO8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WyZX6F7hYV4UzPe5CA7I4btTepr8TRBHLCSrTBdzj4ZpO0UeKfwaTJyKviWBLwZouHV1+gN/2ZS8LFgXIx3x6Inprk2TFBAIOoHGa0AEQv89L2u0KrSiyi+2rW+tivgCOWWjY4lI74HPtIKuhNQdjuiFMjzDsPP4uTRCcPT/k9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNt8cFbw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNt8cFbw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E611F000E9;
	Thu, 20 Aug 2026 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787253664;
	bh=AI4jAmy/f37FKX1jsfCvISWkyBudQa5zrm4aoJlo98g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XNt8cFbwfXdrPypQ8wR8SPq7dEx4yaO6vSKDt6UEv+/c6Jy3VYHwZsLHGRBoDgZ7n
	 OHui3jvBxmhVV8KjaZYhYlZfUDvB+577IyHlKpOfuT7IpXEfEdwtiTkoMqTDsxN2Tn
	 0LYgq8fpfYIVgvJn2wTaLKdRKpGoIofeoj7+sl6s4dkORM9UpXAW27dJd8CVhU+Xhf
	 3/EOSdLTlf4O7OJpm4vM18rTu50MIdkzulXxSXGQbL9pWDYnfI2vkw+jdBvDBwUD3x
	 1BExNugqtf5mfdkxqJGoSxJDTWJAQiHUQ5AxorJ3JYhJdI/OhBiWoLX6jJXps4lEPc
	 46u4fM4sicxww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C51392444E;
	Thu, 20 Aug 2026 19:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/6] selftests/bpf: Fixes and improvements for libarena
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725361440.443080.9462048749636340667.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 19:20:14 +0000
References: <20260817191616.11071-1-emil@etsalapatis.com>
In-Reply-To: <20260817191616.11071-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon, 17 Aug 2026 15:16:10 -0400 you wrote:
> This patchset addresses issues and feature gaps in libarena's existing
> code, and optimizes some common code paths.
> 
> Patch 1 fixes up an inconsistency in the SPDX tags.
> Patch 2 incorporates a followup patch for bitmaps that inlines
> the nonatomic versions of the set/clear/test operations.
> Patch 3 makes it safe to use the arena allocator under IRQ reentrancy.
> Ensuring the allocator is correct under NMIs will be addressed in a
> subsequent patch because it is a larger change.
> Patches 4 to 6 add a calloc() interface for the allocator, along with
> a benchmark that is useful for quickly finding obvious regressions
> during development.
> 
> [...]

Here is the summary with links:
  - [1/6] selftests/bpf: libarena: Normalize SPDX headers across files
    https://git.kernel.org/bpf/bpf-next/c/ee66e3796b80
  - [2/6] selftests/bpf: libarena: Inline nonatomic bitmap operations
    https://git.kernel.org/bpf/bpf-next/c/db00d61fa433
  - [3/6] selftests/bpf: libarena: Disable IRQs during allocation
    https://git.kernel.org/bpf/bpf-next/c/620e1e2b4377
  - [4/6] selftests/bpf: libarena: Add calloc() call
    https://git.kernel.org/bpf/bpf-next/c/283cb6513c88
  - [5/6] selftests/bpf: libarena: Add a benchmark for malloc()/calloc()
    https://git.kernel.org/bpf/bpf-next/c/047099824cbe
  - [6/6] selftests/bpf: libarena: Optimize and make public arena_memset
    https://git.kernel.org/bpf/bpf-next/c/8be79805b06e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


