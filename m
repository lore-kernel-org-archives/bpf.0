Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D5271A9A
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766034; cv=none; b=fjolP3HsScB8371TLZP07GSvYRR6/ayGLxMPH9aSXzEsXm3xidh6reU/SUgGGvuPG0YkxUB5nqCgUYTfOemaZNTHHRc3yLLHaH1V69vI1vlC4lWwJqX7Jmr531g973rF9vfNkEEhyNlg1QRFLWp26W8cJQBHIHbPVBlatxtWyoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766034; c=relaxed/simple;
	bh=t0pbKYzaRe9zA3bv2d62a55HGpuBg6UPCvPr9VMM00I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NIq6T6+3+P21zBVMEM79yXe3QX7v/V/R192JSXW9XrH9JDnWBCs/ZielIsiszfLfO7jjtd8ZuRjLvjBKpH3QlpIKYQMVoChDT25FUFF69USJsu+hWOqRPgxMMX7wdWkFwNOxyEPhvbYwlx/c47vK/JhUy5WZ9CsJTO6dhdq9C3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+7w2A1g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+7w2A1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B55AC4CEF7;
	Thu,  9 Apr 2026 20:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775766034;
	bh=t0pbKYzaRe9zA3bv2d62a55HGpuBg6UPCvPr9VMM00I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h+7w2A1gCTmRsG0duqki7fUVD+O1D9fHc6VyM7RDSdAHqQ+EPga8UcUhXJljlc7l9
	 vgc+rcV8sCODrr9lXJIpjPomu89ARtcBw6yKpKe/vDYLDHIMxORK6oVhzD6HNWS8dH
	 X77X/Niut6bMLZ6/sfX4++Ls4nH2B9jkToXOO05oCBhy8nwG2Kijcar54CgIELRsep
	 0wtRNpxESF5+w8euM6O9wl3M881GyMPvlv/HDMX5Neoz5Uq/ODQOlKXdhR5lTXbPHq
	 1s2dgSANURrFMvNP7K5Tw6iuH1JZB8Z/ciM8xnNNg8ndYCERAduUv7W6Mj/XsGF8IE
	 +73j8fyA6aPkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1D6BE39308B7;
	Thu,  9 Apr 2026 20:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Drop pkt_end markers on arithmetic to
 prevent is_pkt_ptr_branch_taken
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177576601004.1723637.10865726418244127226.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 20:20:10 +0000
References: <20260409155016.536608-1-daniel@iogearbox.net>
In-Reply-To: <20260409155016.536608-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, eddyz87@gmail.com, info@starlabs.sg

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  9 Apr 2026 17:50:15 +0200 you wrote:
> When a pkt pointer acquires AT_PKT_END or BEYOND_PKT_END range from
> a comparison, and then, known-constant arithmetic is performed,
> adjust_ptr_min_max_vals() copies the stale range via dst_reg->raw =
> ptr_reg->raw without clearing the negative reg->range sentinel values.
> 
> This lets is_pkt_ptr_branch_taken() choose one branch direction and
> skip going through the other. Fix this by clearing negative pkt range
> values (that is, AT_PKT_END and BEYOND_PKT_END) after arithmetic on
> pkt pointers. This ensures is_pkt_ptr_branch_taken() returns unknown
> and both branches are properly verified.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Drop pkt_end markers on arithmetic to prevent is_pkt_ptr_branch_taken
    https://git.kernel.org/bpf/bpf-next/c/9f118095dd34
  - [bpf-next,2/2] selftests/bpf: Add test for stale pkt range after scalar arithmetic
    https://git.kernel.org/bpf/bpf-next/c/8697bdd67be8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


