Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECECA13E7C0
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709751030; cv=none; b=JzPeOGVCxFqJWSkck1Rzloqn5r4HkLfN72kLo5IpTE3NqaMU0yil298lmIt6VGXVFcwRtsOKAJMBp31NZbcv0j2JdonbnxdPgf3JRtCfDBxSbKKfFTBY9OUMivO2e32kqGj+HUerEh8leKx12iDNdSZmTxh/IsU5qXbSE9mc70U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709751030; c=relaxed/simple;
	bh=b4CDBFIr6Wg+L3QYeetR//lvot/fw5TYAzoWppah6+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gkHfw7LkXFSFRCwaiHzuDwDkRNn2oKrKHRZkFcGewwejxN9z8c8OH+ww8SAbs6xNtx7sAchFUfd7+IoD/E+eZANVFkqRhgDVIq8BTFjylqG1Wd4OtNGJ1+jsHZkhQO74xiCabB/SqRd/iOqzKmoPBZgYPQ06WiSg5jbuQpCp/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tft+DcIF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tft+DcIF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B5DBC433F1;
	Wed,  6 Mar 2024 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709751029;
	bh=b4CDBFIr6Wg+L3QYeetR//lvot/fw5TYAzoWppah6+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tft+DcIFnara6pMfacQzGo4qqZB1fSh93CrQFY+iVfgQ8Z19C605hKEg9/SRJ28iF
	 m0W5GF0E7C3q3xiQtSBSC3Clzp6MNdIhu5tPq72XQBx9r17eXBTkR7P100kOxbwDO7
	 H48LjOd+Y27TDG0yEwGCw4qsSCgFrvyIL8PmkhyybnIPf7w9sy2b2FJBfUnkrdcITs
	 UNLCrcDJXJYMI/scqeR4czCxG49mAL8kOSjIqp7AbMb8gVqLQHf+Z6uB337Fo77vNU
	 eCpmsUQ9hYrVA0SXRvhwfW7MpXvd6uWMls6cBNdr08TioOZlkMuRc9Z+N3wWfrFl7O
	 pTalFovhRLJ5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B17AD9A4B5;
	Wed,  6 Mar 2024 18:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next 0/4] bpf: Introduce may_goto and cond_break
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170975102930.9518.8336084287032577662.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 18:50:29 +0000
References: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 john.fastabend@gmail.com, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  5 Mar 2024 19:19:25 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> v5 -> v6:
> - Rename BPF_JMA to BPF_JCOND
> - Addressed Andrii's review comments
> 
> v4 -> v5:
> - rewrote patch 1 to avoid fake may_goto_reg and use 'u32 may_goto_cnt' instead.
>   This way may_goto handling is similar to bpf_loop() processing.
> - fixed bug in patch 2 that RANGE_WITHIN should not use
>   rold->type == NOT_INIT as a safe signal.
> - patch 3 fixed negative offset computation in cond_break macro
> - using bpf_arena and cond_break recompiled lib/glob.c as bpf prog
>   and it works! It will be added as a selftest to arena series.
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next,1/4] bpf: Introduce may_goto instruction
    https://git.kernel.org/bpf/bpf-next/c/9c4cab4e6756
  - [v6,bpf-next,2/4] bpf: Recognize that two registers are safe when their ranges match
    https://git.kernel.org/bpf/bpf-next/c/cc570d85e66e
  - [v6,bpf-next,3/4] bpf: Add cond_break macro
    https://git.kernel.org/bpf/bpf-next/c/7825948e135b
  - [v6,bpf-next,4/4] selftests/bpf: Test may_goto
    https://git.kernel.org/bpf/bpf-next/c/8089b99d4649

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


