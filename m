Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60CC1B424F
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301416; cv=none; b=k45cBCNFCzTTxYyEVdHPDpVpLGn3rBhGuFS97s0A/zYULc39Z+ne8jUPL52mM1pcWvfeeNeK9ELNtHiJi1q2reb4fzFXm2HGSFlmBkLpv6BQJw3XNJIi3Y7s/o41xr3fKURJoLihjmwu9cV1Qu0WzoU1D+8/V8fOl6WeFRmPZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301416; c=relaxed/simple;
	bh=OFLmbPrUMdYHtmXhv6j6mLpnM6hmgHyMKHUpunE1o4U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O6+StE/kbpMJmcSn8IAFQ8qL0CXdnUxw1qv8UHFwsHJw4gSARpVxO0ECLKdCuV4KUo6ymDgGx/pPEVU1NpexkennO0mkd4ntiZLwb4xL9l+Qeb47ZJ2qkweB5CTlJSvZR7zk/888aNr01y1Y5p1GGcIqmmOMB4mF/e+HPq/sHn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6pC7wCH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6pC7wCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35EBC4CEF7;
	Mon, 23 Mar 2026 21:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774301416;
	bh=OFLmbPrUMdYHtmXhv6j6mLpnM6hmgHyMKHUpunE1o4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P6pC7wCH8K7uo+Ex6b2kWO4H6sYpsUUc9uZ81d1HSMlJlBl4J2BwCrjuId1+4QxQ2
	 +bqUQSvNf0+JluYIOj4S7d7M1NWVRkHI7BohCp/pXhrF6PhU6M/4y7xH7kL4l7Fuzv
	 6sN4ivDuK24iz4PNifNNxYbeOxNcVCPNyq7v+HZp6JVqkNnWqr8bFSSF27a5o2Whgb
	 q7dMoYfFl3ItSiXHQwdWd2vJ9GJbm+3XAJ2a/IyZ4YxXWoImm8EZddsfBgukvSgtKY
	 /NQKi28fqSR/JUW/12xxOIZcke1L3qKTPedATRbHWeyArQCXBpDxwzFMZ746meXrav
	 rYuHw/i2VBx8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDCC3808200;
	Mon, 23 Mar 2026 21:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Improve connect_force_port
 test
 reliability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177430140504.327436.8561244214463910730.git-patchwork-notify@kernel.org>
Date: Mon, 23 Mar 2026 21:30:05 +0000
References: <20260323081131.65604-1-varunrmallya@gmail.com>
In-Reply-To: <20260323081131.65604-1-varunrmallya@gmail.com>
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: jiayuan.chen@linux.dev, yonghong.song@linux.dev, bpf@vger.kernel.org,
 sun.jian.kdev@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 23 Mar 2026 13:41:31 +0530 you wrote:
> The connect_force_port test fails intermittently in CI because the
> hardcoded server ports (60123/60124) may already be in use by other
> tests or processes [1].
> 
> Fix this by passing port 0 to start_server(), letting the kernel assign
> a free port dynamically. The actual assigned port is then propagated to
> the BPF programs by writing it into the .bss map's initial value (via
> bpf_map__initial_value()) before loading, so the BPF programs use the
> correct backend port at runtime.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Improve connect_force_port test reliability
    https://git.kernel.org/bpf/bpf-next/c/bb6da652c585

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


