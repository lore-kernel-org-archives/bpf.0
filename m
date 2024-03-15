Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0796548F4
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710538230; cv=none; b=qXq3Vh3yIDLIGoMyl5fBSnoSeEfm8O6ugm2T4WJd0eY1YKX1IxSvQ/Q3Sn0+yTj9SskdSSnjowYY28A7uoERDuCFxPCmMK8TsBAc7e8Pa3ngacYdH6Ch1e8P5SUwqj3SlIUUXOEnSVD5+u/2zNPN4l0PG+b5l+aSc0zEzmCQkts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710538230; c=relaxed/simple;
	bh=iXVwe9X1A8dGriSf1J9Kv8ofwH2dMemEfpgJ65CNFOc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L3gG8CTVsWQC754iUOR4yFBiv1b5kYzxBRzsQHb8BZUFt/7iAINnDOyUgns7HmW2ErnoTybJhz9Uo/5m2ElOoJzHVl9ZjBjjxCK939srBHv13112jHCKBWu0FF1HOJ3LGv0F14KgBcWqfZ1up3sv576dDx2A7QPCLQGhZVnZxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqeGA28G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqeGA28G"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E308C433C7;
	Fri, 15 Mar 2024 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710538229;
	bh=iXVwe9X1A8dGriSf1J9Kv8ofwH2dMemEfpgJ65CNFOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DqeGA28GNirGkuMlp3TjPjjA7pJZBMZf0ItcjEq2x86DKhtBWeg7LeDzbC/CXlhyn
	 CuKH4jJDktCWJGmYrDSKhp/eCEs3062xuHb9H454nemZpwZr3zGBR4REdtV0nJxeKh
	 MH+wj5LV20BZYR/xH1l0Lf35Op7JgU7/6sPuL9K6FDcx01Ojbo5HlVRQWB20hEX26k
	 xZawTsU7D2jxT1ftpzGO3y5yqjFLLqN7aWFbCl63aND7/EW/F8n94so7KzZcJgOj9R
	 3AvqJ49shpYexvzAKB+cYfFxYCg/yq6cWGDpd5JXAZeAfkPbFGq1xXsB60zyoBXWKf
	 Q8TQbgpiCLPSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4ADC1D84BA9;
	Fri, 15 Mar 2024 21:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/4] bpf: arena followups.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171053822930.31377.3875227284796742974.git-patchwork-notify@kernel.org>
Date: Fri, 15 Mar 2024 21:30:29 +0000
References: <20240315021834.62988-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240315021834.62988-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, eddyz87@gmail.com, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 14 Mar 2024 19:18:30 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> A set of follow ups to clean up bpf_arena and adjust to the latest LLVM.
> 
> Alexei Starovoitov (4):
>   bpf: Clarify bpf_arena comments.
>   libbpf, selftests/bpf: Adjust libbpf, bpftool, selftests to match LLVM
>   selftests/bpf: Remove hard coded PAGE_SIZE macro.
>   selftests/bpf: Add arena test case for 4Gbyte corner case
> 
> [...]

Here is the summary with links:
  - [bpf,1/4] bpf: Clarify bpf_arena comments.
    https://git.kernel.org/bpf/bpf/c/ee498a38f317
  - [bpf,2/4] libbpf, selftests/bpf: Adjust libbpf, bpftool, selftests to match LLVM
    https://git.kernel.org/bpf/bpf/c/10ebe835c937
  - [bpf,3/4] selftests/bpf: Remove hard coded PAGE_SIZE macro.
    https://git.kernel.org/bpf/bpf/c/9a2d5a966b47
  - [bpf,4/4] selftests/bpf: Add arena test case for 4Gbyte corner case
    https://git.kernel.org/bpf/bpf/c/a90c5845db95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


