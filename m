Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323ED3B4EB3
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 21:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720250; cv=none; b=C2/CTiZpAeHxzAk7QpdHlk69THqhcLpK0oZWdewmArY9tkKLRTzrer1Mcn4zJcfYmh9x9zC+IvZum/bRtdL6lBe8mkIQB4kiz0Xrh/ezj9mlmZjtalAKh4qSg8OagxOM6iZhhpwycV0WVMLKBoFHbq2251oL+PU7jjWnl/Ju3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720250; c=relaxed/simple;
	bh=py3sall+N3+yqkzE592GtJMm02lCRD01GCxiXV8Wqg0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gdXQlPaQLXbwnPOJYXlDfFM9pU2ZAKUMH6F0G6evbY7mgD1vYZxXeHDtEn8Xlz7Im6i2InIa44cNHsAC1Xal4O2vxDQgB1E1Ri0KQXfuYqNbFz6aba2akFwFKveL2+B2YnEdGW3+RhallHCw+HsnACQFmAOzzAIsFvajsQM6bLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYhQSa3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYhQSa3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61E81F000E9;
	Fri, 10 Jul 2026 21:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783720248;
	bh=FAPSjuYtTxF+SDrwu9j/nms1dTwb2e1+DKmokbLAqbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bYhQSa3UJXRwkT39rkVMk2r7kKXj32KBsFU4dXrh2UnxSr9LZyAzmDjZQDKK3qdxP
	 mYCziIIEycfcqmUROztninblF9RyAZnCOXhFSf6mNtK3bMkA88Z0sOtarlLc4L/khw
	 vF/0igohevxiQsJzwdjNWrkWieM1gCqCOlAYDprs9m4P7qJLdmxA+dAt4WX2D9DQZR
	 Xt01WxV4Fk7d/n7c+dkhvj29ofMFb9lelc4qU/joBK6yd1vr4N1Zz8X3q8IFdfTMw6
	 BvekROn9b7qZcuu3fSnW9XVJ/ZMv7dk7LzTNtIOsqlRiXwb+lxewPTasc07uquPS/G
	 n7i7nmFdtJ+AA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93E5E39244CE;
	Fri, 10 Jul 2026 21:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: veristat: Minimize map size
 during
 verification
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178372022623.890620.8463960163402560619.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 21:50:26 +0000
References: <20260708193239.5063-1-emil@etsalapatis.com>
In-Reply-To: <20260708193239.5063-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  8 Jul 2026 15:32:39 -0400 you wrote:
> The veristat tool verifies that BPF objects along with their
> maps pass verification for a given kernel version. To do so,
> veristat loads the objects and maps into the kernel in order
> to pass them through the verifier.
> 
> Currently, veristat sizes the maps according to the max_entries
> field provided by the program author. Depending on the map type
> this field may be irrelevant to the verification process. However,
> loading a large map can fail because of -ENOMEM errors.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: veristat: Minimize map size during verification
    https://git.kernel.org/bpf/bpf-next/c/e821c2238758

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


