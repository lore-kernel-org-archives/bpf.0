Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00B2F5480
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661642; cv=none; b=QRAAzYp/WQ71UTYvjvFGDTuAtt1GIrPXr0/3ZzagDCo+ZDUCzRZW61dml8G/0/FY+doEHh728A0krIa6WnOzeXro3qsY0lC2MQPjd8OG3NrrpQ8IxvH220eLrmrnu9z58NN/04H5JTsWwMs862Hgv3RehDxbD7tBysmUsvIS3U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661642; c=relaxed/simple;
	bh=IpxkhHSy5zjDfFq5ZB82JYL2I4kHL9R2p6rF8xanUsY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IgeO6A5GKuMeyOt5wyBbSzyidjlGcpGbwO2DZepltX6FovnW7jEWmLedGctFUawthECV1muM4bRA4hg5ucK9NkLlbFsSpUdjXG97LVft1Jnhlmv2tp81nxT4kiL/I+QGRF27lVlo9jXkdaEeOcRwrFvTDPtuCvbTR5kNowRnrl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpEEjUjx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpEEjUjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECE9C4CEF1;
	Thu, 20 Nov 2025 18:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763661642;
	bh=IpxkhHSy5zjDfFq5ZB82JYL2I4kHL9R2p6rF8xanUsY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bpEEjUjxTWZ8QznXAgWy/86v64AgSXNdSdRXTOoA8/ND9CH8sJMbEvr1co17SiAaD
	 cfS9qwsNGTE5O/RMM6ZYrTuHhidH9sGg+THivnqepL3V2ceSTnHcQ3qILupMfSG2Uv
	 mQDyTzgvKKvg+0TVZ+wW4fgMSl0/9LH6XxebmjkhN3I0LBOBBJ2W/lQTe67EnAJFGC
	 j+a8qAz+xhPxfsS7JeyGaIqLOatNFAdkR6hMRGtXGyEiiexHXql39ipbkI3PqRPT8/
	 ULi34RIhh0c1j67jf6Zg37NemZe/lbaJQRtfJEXIqpzcoyd4YEuCuxS0dVaZDo0S2P
	 3ikMphUxl6XFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ED93A40FDF;
	Thu, 20 Nov 2025 18:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: use ASSERT_STRNEQ to factor in
 long
 slab cache names
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176366160727.1734423.6098824718738308268.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 18:00:07 +0000
References: <20251118073734.4188710-1-mattbobrowski@google.com>
In-Reply-To: <20251118073734.4188710-1-mattbobrowski@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, namhyung@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 18 Nov 2025 07:37:34 +0000 you wrote:
> subtest_kmem_cache_iter_check_slabinfo() fundamentally compares slab
> cache names parsed out from /proc/slabinfo against those stored within
> struct kmem_cache_result. The current problem is that the slab cache
> name within struct kmem_cache_result is stored within a bounded
> fixed-length array (sized to SLAB_NAME_MAX(32)), whereas the name
> parsed out from /proc/slabinfo is not. Meaning, using ASSERT_STREQ()
> can certainly lead to test failures, particularly when dealing with
> slab cache names that are longer than SLAB_NAME_MAX(32)
> bytes. Notably, kmem_cache_create() allows callers to create slab
> caches with somewhat arbitrarily sized names via its __name identifier
> argument, so exceeding the SLAB_NAME_MAX(32) limit that is in place
> now can certainly happen.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: use ASSERT_STRNEQ to factor in long slab cache names
    https://git.kernel.org/bpf/bpf-next/c/d088da904223

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


