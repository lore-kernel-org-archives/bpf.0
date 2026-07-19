Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEE43F08E;
	Sun, 19 Jul 2026 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784478640; cv=none; b=kBbE4C6C6YgbPZiiPo/Pc52SbJeGvB6hYMJiVDBcfOqjhDhYegb1OEgDIQ8HcAK5JlBF5mPEgzhNFWMlrhOqnOm6ple80JimDL2iOyEYP6j2XG8YGubQ+NsV8c3aeHo10XQQucrvofRpbjGX7bVvYl3fKM/dsV/tVnBmAf4e604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784478640; c=relaxed/simple;
	bh=vKn94+yJXsHkcXdvh95dTeZUhqrGrxecJCEdEGlUMFA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=avdN5ByPxeTq/NAdDJs0jyvQT6Qa7+guVNHKcvz7pu+cr8qK98LjazglId2b7Asz1SHi8+vFBGetRxss6Z89iIgVRkvjDxv5Jv3Jd2EM5Zl0SJXfMoX/2kA01VwWV+78xm0uVttO0nuApiLRxwhA2DWCDmYrqQL1QNCWZQKpFM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILnOtJZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILnOtJZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2347C1F000E9;
	Sun, 19 Jul 2026 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784478639;
	bh=0JtiUosTGU94LYAEXZruLshAwkoPc7AwAUt1c5cNxrw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ILnOtJZvCSClfVHcfAsRuoWHVyit/oSL2w1gm0zFWoyxxkX4yU3Vzmu6sq0uHlHNT
	 35vSNtPSIp9LoAoFJCMmdYOUpztJujeN5ADsIWE5KmDxhJ5ofNmIpP4LDDA5zZzyFg
	 4IIQbDo0JnVaSFITS7iksOCxXUk+0D7RtCjlc9QEhgUWzT5DEmrnpFO47NQLqLhOjh
	 XRySYDSG6+pcSsjsGFdi80/HbQevYOhQ5NJ9OHjuUOMInCzhA+ZQ7SDV/RSl16OraD
	 p01fcs8IjjM4MWCXIeC7c2amrDHWN73IT7VqHHIA4eJFTmu0KLozxVljtCM8+enGzR
	 QYpPNgNIO9ztA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A0538119C8;
	Sun, 19 Jul 2026 16:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Reject arena frees below the arena
 base
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178447861014.2768115.6826703778150125984.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jul 2026 16:30:10 +0000
References: 
 <20260717-c10-031-public-bpf-next-v2-b4-v2-0-54b555443a7c@mails.tsinghua.edu.cn>
In-Reply-To: 
 <20260717-c10-031-public-bpf-next-v2-b4-v2-0-54b555443a7c@mails.tsinghua.edu.cn>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 emil@etsalapatis.com, puranjay@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Fri, 17 Jul 2026 12:53:46 +0000 you wrote:
> bpf_arena_free_pages() can be called with a scalar arena address. The
> runtime reconstructs a full user address from the arena base and the low
> 32 bits before returning the range to the arena free tree. A scalar one
> page below the arena base can otherwise produce an out-of-domain free-tree
> offset and make a later allocation return an address below the arena
> mapping.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Reject arena frees below the arena base
    https://git.kernel.org/bpf/bpf-next/c/b5a71cb2db6d
  - [bpf-next,v2,2/2] selftests/bpf: Cover scalar arena frees below the base
    https://git.kernel.org/bpf/bpf-next/c/770b62a6d389

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


