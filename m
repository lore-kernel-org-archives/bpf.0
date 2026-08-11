Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69633546EB;
	Tue, 11 Aug 2026 22:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786485660; cv=none; b=emK9dVp8wlK7ccjxD/hLHylRxSyC3g8KaGKX9uCAGc+5OyhRLU8Loyg60eEDp3HGJs01KBZpdWa4joP8qkS4661tCo1Vvykyw6qIWWMKmXqJShxb6Em5+7m4M7Wdt0hFOl4bQTTT45RomsFJXE3WC1ZYee4BJkk/FDiFhM9DHLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786485660; c=relaxed/simple;
	bh=6iUFqViir8BKsjNj/kf7rPJwnXAgmbZF/h3D5BANJHA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uXVXF5KSF3AS/HI4j7CLizWxLX6fFKkhgLM+lMpCm3G0l8lB8c8ipjbXjc+qZR/83nSM+Ka5KYMCAHMr8zT5ikIYkB0VR9o7Brr5LtPRQe1SZKVVet16NSyfov/xWi3lA9JxFBrXdlv6F1TTG4WH+RoWcpau7GQp8/siDzPRCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCseeTIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCseeTIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710AF1F000E9;
	Tue, 11 Aug 2026 22:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786485659;
	bh=0vm0yw+vi0wlgF31QzqFAoKqtJv2rCFSfJ23puWRuD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oCseeTIeiSLD05sYneQd7wErtQDCkni4Xp1dMAY6Wpl+PlxQDVVZ7RpiM9RZYyQb9
	 t46AV4EFYMBYBtgq7YrWXvqiub2LmNitflzWig3oMwZ8gsWsiVs1Ds3EBR2tqbceBI
	 ctgt6gJHgNprfnrdynF+/4JPH8LJWj6ds9fDcyVtccczr/zTbbu9IroOtcVxDqdJtB
	 gKMxYIiSwQPo9twrGwVx4/UMxzkvu7Et6zUzXopu5BVZ+bO+wyBXHi4V3UKBu4N2sF
	 mMJwQr5iudyIPyoN1VF6TnuL25PEZaJUOHrltFRRQVSVXUH9sl3NnHaqS+qP7Xleh2
	 VYot9plFngf/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938E63809A22;
	Tue, 11 Aug 2026 22:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Compare iterator types during state
 pruning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178648561523.1170542.5254278257474503414.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 22:00:15 +0000
References: <20260811035955.132989-1-dingning04@gmail.com>
In-Reply-To: <20260811035955.132989-1-dingning04@gmail.com>
To: Ning Ding <dingning04@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 zhouchuyi@bytedance.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Mon, 10 Aug 2026 20:59:53 -0700 you wrote:
> Iterator stack slots can be marked MEM_RCU or PTR_UNTRUSTED. The
> STACK_ITER check in stacksafe() does not compare this type, so state
> pruning can treat these states as equal and prune an unsafe path.
> 
> Compare the type and add a test where RCU protection has a gap.
> 
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Compare iterator types during state pruning
    https://git.kernel.org/bpf/bpf-next/c/83608e303b95
  - [bpf-next,v2,2/2] selftests/bpf: Test RCU iterator state pruning
    https://git.kernel.org/bpf/bpf-next/c/81f209d5f743

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


