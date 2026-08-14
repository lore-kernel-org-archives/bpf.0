Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5EF3BE14D
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725059; cv=none; b=Ci5yxNQNGeQQqHWBZUaSGFaYkbUzh0MzmCcx8J5igM8i5tcz9iejdLaWEAZyqI5GEEmdIwwWkVVWil2Vzc1vUE8OOoKcD6jzfXKXdTRsoUhtYu5tXdhedQJltsygXzlp0st8GiYjgaG6hMt5uIy/Bl9+sOI9rRSQjkBCpZW6crc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725059; c=relaxed/simple;
	bh=df/6JgtcXYRdjdQlrEyJT0hWdsMZkgd/abTT2om2+4U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UJ5hXz2pI0ifmWFyVRiPcHfkf5riTADgnIRowO4/QEhA+hOcn9a5xPKd2Xh8YFSva5Tm7FdDKtVkDGP0h4qG345r1BgOXNJ2UGkuGGQrS8O2vi4vUW6N7Jw046QfgZb/GIKGFEypbfitK4Nh3/ey4ix+6EQXnPBIj8A3blbuWMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGOJIFTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGOJIFTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34181F000E9;
	Fri, 14 Aug 2026 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725057;
	bh=9Cm+NmBRNO5fTJrFTe+wTjJEvNkgp37AC9/k4WvA4iQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YGOJIFTZzAe3TjLjzcGqKVAawd4zZ3jOmBkdQDnwQjMuxF6dfdNMesqxtuZl7m4M6
	 D7KZPg4A948niQNyqu1z5JiiYaDtTs+IbHSuZZ82ysX/HX9OXFauyq7QKCEM89tCNw
	 rPZEbh5wdJJJk69aZo/bJGQgzoQGgBUck3II9h4xxIB0JHnb6dOPfHVPQqc4TosQVm
	 4+bz26W4v8kZ/61UXAYkiFJRmEEVVwHc62TrUPRSEiCwkNkRxP0bmsf/qT8A7eZYbi
	 oqu8R6idkToZYckGGR4DX5bzslh3UpdtYbEaEfSLfg2/tbiS+ESDF9mC2deKSuQAHW
	 XqzYxD04RwrSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197BA3924451;
	Fri, 14 Aug 2026 16:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftest/bpf: make pyperf600 a success again
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178672501164.3867910.13102220432411605922.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 16:30:11 +0000
References: <20260813232943.581283-1-andrii@kernel.org>
In-Reply-To: <20260813232943.581283-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 13 Aug 2026 16:29:43 -0700 you wrote:
> pyperf600 has been running into 8K BPF_COMPLEXITY_LIMIT_JMP_SEQ limitations
> for a long while now, after some internal compiler changes.
> 
> Until BPF verifier is bestowed with scalar evolution logic, make that test
> actually work by doing what would anyone should do in such situations: by
> moving repeatable per-iteration work into independently verified global
> functions.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftest/bpf: make pyperf600 a success again
    https://git.kernel.org/bpf/bpf-next/c/c7e617552938

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


