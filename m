Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013BC51813B
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028418; cv=none; b=ZeocR1SqX3tN6RpPmIswLYmBDGjAQkk9gfBaurbZU7BB7/OWXQxfY5Rmn4Bwd/gNYLfDZmahsUdX8roWuAmPTA19YkO7XdcA0jt7S2p9gcCksxlNl4olPdUfbQ7HFD0gq2gZUl/BTsmhAaMcl0MgHjyz97xRgc03AYzUKjV/exU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028418; c=relaxed/simple;
	bh=rt4rJrCdSMc9PaghsuGE5Giauvboswa740GoEbTngDo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NXFBLnON+HLQwGJ83m7N78y7cqt7tFZwlSqsUEaRAKg0QQXJsLhxKbUHEUCmOKW01Hzy7mvkmS/Hg/GBbfvOPj4y6BeqfndtAC/Tpu8qzzvcriPsG4vZlvIgIyMU0m9IWwGso9a5piSP2UboBQVKPjgQaF6vydft5u5n6AVWmYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbGr3bLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbGr3bLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52771F0089E;
	Mon, 21 Sep 2026 22:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790028416;
	bh=D9pqBUL2I6bTp4glf0e5qErWa1G9MEtY3y5lyb/xB4g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZbGr3bLFHJIFwId5yBMdQN/gGyhp3rUPIWtLPHYGT5DZzCZ7itSeDBxCjWN4RghD6
	 p3pg9OPP/E10dLMw5Ee03R7yz1g5x7KlX1T2dOBFQOVMp7UIcYFInf2rf772YV3NJM
	 qOgcfL7xuWZ3kMAhR1/ZExp9CpNwXgIKGyL3hpo9LjzE/tpj9qrskaHY+wBGtRWkWk
	 17PvMjKR7OBL8J6lANybKlmr0mtdQfpk7xsMfhbv08XLTkLqahYa7gVlQ7lYYTH6cp
	 qVN7kXw7IaNWALRqB3VUYVZkLpuISlnN78fLH+6EvCY2l5pBbiqy4oKG1EKMoceHDO
	 onGlo4N8hNccQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93912393020C;
	Mon, 21 Sep 2026 21:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Guard link cleanup in
 fexit_bpf2bpf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179002620816.3245651.7322943257336533118.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 21:30:08 +0000
References: <20260917093928.48495-1-running910@gmail.com>
In-Reply-To: <20260917093928.48495-1-running910@gmail.com>
To: Zhixing Chen <running910@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 ihor.solodrai@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 17 Sep 2026 17:39:28 +0800 you wrote:
> test_fexit_bpf2bpf_common() can jump to the common cleanup path before
> the link array is allocated, for example if bpf_prog_get_info_by_fd()
> fails. The cleanup loop still indexes link[i] unconditionally, which can
> dereference a NULL pointer and hide the original failure.
> 
> Guard the loop so the test reports the original failure instead.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Guard link cleanup in fexit_bpf2bpf
    https://git.kernel.org/bpf/bpf-next/c/80ed1435d97d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


