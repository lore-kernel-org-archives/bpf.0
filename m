Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D51370D5B;
	Tue,  3 Mar 2026 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556023; cv=none; b=nFDxVZahvxSUPMtDPVj7dX/e2Az+QHPHvz819ygGp1BX+LCYdbrQC0emwK1t13n7ap27eM4HZw9WSMyjyewplPIu3LZBp9IjMsj7tcGpJp1rFyq7uzMLoKq3+lmkAVpU44kovkKpG2gp3k7fQlrJgUVxQypss1KxfuagLBgPYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556023; c=relaxed/simple;
	bh=LvBjiaqoRxIb2MgnS7x0QRUA73mjeEFgkzfoey0ZNwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SDH01WIVACpR6NPT5QQ+XiN/W3l808gFLuwj9jsuKlV7L9gA84fPzTsoKXiNJ8QtVDxmda6XKg3EJrEKg9NGsUCDxn1JN8gWKZvYfOAK+jmDxA7FemyTrGqhg6AR6h4RHMyFpCKqCG20E+Mos9ziw9brLD2Ct7RqGNKSKnlVuzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWSbAfb7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWSbAfb7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723EDC116C6;
	Tue,  3 Mar 2026 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772556023;
	bh=LvBjiaqoRxIb2MgnS7x0QRUA73mjeEFgkzfoey0ZNwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BWSbAfb7bbE5LctDvD5vZJHbyy22Fyh4I+jywv0WZc5pgtp2qWl0a4eNEXXWEcwhp
	 TRzQ5zpR5HtIeRujshs8QB0MY+S5zdhzsenmR3+YXPKTpkzc9UGanyR5ns5qdq5Aqz
	 NmmarAwGSnOfcD22+dM8vkpOqqaXANU3k4Kd7C0MZHbP2UGlrFI0sZecXMtbv09wob
	 doZPyYs1hrfcUcSY5wfiz1XT/wgvvqkbXjd/tQpV4PHyzziOHvW3caW9zWExApiFiK
	 +WdlHUaTfWFs58i8iejpkosLK1AcramJVrWdgZCWoPIiH1qpFe/n+Xunp0hMPXI3wF
	 xxCK+Pu70xBlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EA93808200;
	Tue,  3 Mar 2026 16:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv5 bpf-next 0/5] libbpf: Make optimized uprobes backward
 compatible
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177255602454.1378092.12576640235442871997.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 16:40:24 +0000
References: <20260224103915.1369690-1-jolsa@kernel.org>
In-Reply-To: <20260224103915.1369690-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: andrii@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 24 Feb 2026 11:39:10 +0100 you wrote:
> hi,
> we can currently optimize uprobes on top of nop5 instructions,
> so application can define USDT_NOP to nop5 and use USDT macro
> to define optimized usdt probes.
> 
> This works fine on new kernels, but could have performance penalty
> on older kernels, that do not have the support to optimize and to
> emulate nop5 instruction.
> 
> [...]

Here is the summary with links:
  - [PATCHv5,bpf-next,1/5] libbpf: Add uprobe syscall feature detection
    https://git.kernel.org/bpf/bpf-next/c/05738da0efa1
  - [PATCHv5,bpf-next,2/5] libbpf: Add support to detect nop,nop5 instructions combo for usdt probe
    https://git.kernel.org/bpf/bpf-next/c/41a5c7df4466
  - [PATCHv5,bpf-next,3/5] selftests/bpf: Emit nop,nop5 instructions combo for x86_64 arch
    https://git.kernel.org/bpf/bpf-next/c/0c178e9debc8
  - [PATCHv5,bpf-next,4/5] selftests/bpf: Add test for checking correct nop of optimized usdt
    https://git.kernel.org/bpf/bpf-next/c/304841967c55
  - [PATCHv5,bpf-next,5/5] selftests/bpf: Add usdt trigger bench
    https://git.kernel.org/bpf/bpf-next/c/0c4fc6bd6105

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


