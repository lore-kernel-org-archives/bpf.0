Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76125A645
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790299880; cv=none; b=uEqXNEynbpu7nJFwEmaycXYy1YTAjkDRBt7DdKjDklaOQ43NFirB0WB9bcn7iJSVALcw0dohMNjaET2AJoZsvBqnF1yM2nucFMzTMXQp/PXZhakBDsUGgPTBpt4OODk/pdHLtHzlaKkmDYgyfpgSNvyFO/W8Y22Pc5afQQbe4ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790299880; c=relaxed/simple;
	bh=egTXobsi7l2hXIttd7uu2QiheE2mh0de5JlFGACVHmg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h99kaIDBVPucATafKsCa5Js0tA3uSarnjVqi05wCoXhikLanUCw/X581Vefjh0OMTPKpMuLd1BHTmOnPVnX2B7grv5DjXos2PvSNO057zs99VW3TfAi58Dfh1OjcBwFjUO/aus/PnPYP9/0qJcE+2PtV7a92FXIifbEt3C9crR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZzu6N6e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZzu6N6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2FC1F000FF;
	Fri, 25 Sep 2026 01:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790299879;
	bh=FicNRB9ygft7SvGNKvaoCjRCuFsZrCjShkme7uWS48U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CZzu6N6e5JhM9rcStGUOIHuIAzd43q5aimp0wjFy5XIYTNXsZqV7WoqnFaGzBHjkw
	 2rPixNZEZzr2uRbrocs9CxTsbky/fyVM+ZTGANc+S2etvQxsQTzhm3ALJjUxNvYyvM
	 MFLDDZIpIZpBm7vCfvkae9fd6xkZdvtuCwxbhIFveGRrhrMKp3xyfJFM3JIYnTrhhe
	 7lMslFzmDP/Qj9WLE5mfcJxO9rBmISpXrdJ1GAbcbqu1FbcVKvQaS5H9bmIMS+NnBi
	 o3ZgadwQtz0qA4SyW3dFvfM3VPA5u/zoyKoAWmZSK/zU31etBV988imQFf6LcjpJ28
	 fFv5fwhnwdG5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1983A3A566F7;
	Fri, 25 Sep 2026 01:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/8] bpf: Fixes for may_goto,
 insn patching and iterator loops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179029980789.2276978.8073552198545610278.git-patchwork-notify@kernel.org>
Date: Fri, 25 Sep 2026 01:30:07 +0000
References: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Sep 2026 23:31:22 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Fixes for four bugs in may_goto, in patching of insns and in
> convergence of iterator loops, each followed by its tests.
> 
> Patch 1: arch_bpf_timed_may_goto() on x86 computes the address of count
> and timestamp as rbp + offset. The prog with private stack keeps its
> stack in r9, so bpf_check_timed_may_goto() reads and writes the kernel
> stack, where r0-r5 have just been saved.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/8] bpf, x86: Fix timed may_goto with private stack
    https://git.kernel.org/bpf/bpf-next/c/bb83425b3cdc
  - [bpf-next,2/8] selftests/bpf: Add test for timed may_goto with private stack
    https://git.kernel.org/bpf/bpf-next/c/d17107a3051b
  - [bpf-next,3/8] bpf: Adjust pc-relative insn copied into its own patch
    https://git.kernel.org/bpf/bpf-next/c/67a3b916a7ae
  - [bpf-next,4/8] selftests/bpf: Add tests for pc-relative insn copied into its own patch
    https://git.kernel.org/bpf/bpf-next/c/913a5466dbfc
  - [bpf-next,5/8] bpf: Fix overflow of jump offset in may_goto expansion
    https://git.kernel.org/bpf/bpf-next/c/8a12a00f6c5d
  - [bpf-next,6/8] selftests/bpf: Add tests for may_goto with far target
    https://git.kernel.org/bpf/bpf-next/c/948c658c93de
  - [bpf-next,7/8] bpf: Don't converge a loop on an iterator that was created anew
    https://git.kernel.org/bpf/bpf-next/c/6f3ee3516305
  - [bpf-next,8/8] selftests/bpf: Add tests for iterator created anew in its loop
    https://git.kernel.org/bpf/bpf-next/c/36e238196ac5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


