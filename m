Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA53D45EF
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694424; cv=none; b=VqgjSghE6eVq6XHr8fM+tq4RNSB53FElyhPq06k2f9f5sxu7RXElYTcuI8GkYvjM/J27moYpwciyJcPjBQwH25fSTLKDT12PktEaaZ8Su9/CdB7WsCUQZHPEr7W8j80GlW9puAu+ejvEnJzlEmGql7mm5mDgFRCgiSHen7hHohQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694424; c=relaxed/simple;
	bh=Kvs9JmZb+ltjcwasPaqR3oHozlX2ZLYjhxMZSZmUwdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZSxVVwyfi3aGfdPQ1uCevEPwGhO6Rw1c2dUNI1AFWmsgnMEPDujIEOM/EN/Plj9bz+uENu/nEX7BwT5JiUAs4WiT+MA1uSYp9R/aYU3JBJOHBCUgscj8O+Ovp1OG3URJcLBYoMbozD9kjgP0Q4nOoE+d8Du4VK/8IE+ApfjYOHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QImyAZoB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QImyAZoB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D874A1F00893;
	Fri,  5 Jun 2026 21:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780694422;
	bh=I7NWy6V63P3OvgUrcITzzMN4sKhp6uypcYkKqAIyhYM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QImyAZoBWgZ6YQyAuRRHIHJ9PS630G2DWyEEem/IW2PQ559SepKD/3FkolQazStkG
	 mrPHkn0hTT0N8pqe0GtDKquDWz854MRQIXPSI7XCLsUvXhueDFikXRsI2Tej5htf18
	 9lOlSNOppk1tezcROqvzt3cN+0OJhA72S9AxqyZ9WJzsemaqlGjoYRYav5sEs1ZVEJ
	 /+pdeYMwC22YoSh0mJ9CqqykFHPzePaAHXYquu8FLXtbIzsuFWSh5SolhVJGgI6s8c
	 n3po59up4y5ghiunWem+sIhK3SWijXr7IO/E0nNmUmMOnDWV/CA84/oMsle4cc3jdS
	 5QOKmoSLIRLdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568F23930BB9;
	Fri,  5 Jun 2026 21:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix flaky file_reader test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178069442290.3922226.9418386976774897333.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 21:20:22 +0000
References: <20260603-file_reader_flake-v1-1-7f3f52d1e388@meta.com>
In-Reply-To: <20260603-file_reader_flake-v1-1-7f3f52d1e388@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
 memxor@gmail.com, yatsenko@meta.com, shung-hsi.yu@suse.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 03 Jun 2026 07:39:15 -0700 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> file_reader/on_open_expect_fault test expects page fault
> when reading pages from the test harness executable.
> It is not guaranteed that those are paged out, even
> after madvise(MADV_PAGEOUT).
> Relax the condition in the test to succeed with both
> 0 and -EFAULT returned.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Fix flaky file_reader test
    https://git.kernel.org/bpf/bpf-next/c/aa22d619ba22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


