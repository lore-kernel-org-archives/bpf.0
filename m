Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753412;
	b=epmwg3uwFmtExrYTvXYnTmZq4IfAQcOHk/sBJCHhQckf8byfJQ7FdW1LTa17Z5CBVkTw
	 2kDJHfRUNBt8a2/5YBdvPXiaizyVEsue+f8U9+REGNGnKguptCebe7/LJLzplfsCaJaVt
	 Zyvm0BLhWDR/tQDbnzxOWM0+wu9MCGy1yoDZEOKwEifx0YUXmwFWGoS6T91o3fRvqBHgQ
	 J5VfFroMhWVP93cN8Z+d1yQO2G/FYuPOmB5ynveY00tWa0AfQ3U5WH2fM7rjIrxHSS5j8
	 kJPf3yWESC8jgnCwanhAYEhgaEQhMCBxV/BmZXqWtyCaHT/pVuZU3r/UO5H7wYsjThg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753412;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=r4tz8o1TlU/xEK9b3YrVdww6EoQHDhX4m9dHm6jXFbo=;
	b=iw35MjzC41BJD+gzjs0Ah1qiv+0CwnK7wpBK7x/DmUDXdym6d/CPvvHHkpFQ5CJ0QB0N
	 pCPl7YFSNZwuo09MrPcC6QhZRHbIr1SS4mauvt6zw1gvsUXL92XcFNhmZuxWHRv4TelSU
	 PwfpNNidVNpcZISC8TdUJjjO+c9C5HWn/BOGFwbUxW9RDyUBOBHkDevvXKW3C0rkrCHN4
	 XTeXQX94C7Bga1Vjnvhd7UlS7CAMGMuf1gjExsIpkSSBMV9vD8FcCA9WZogJ9lYF7xbHW
	 kU4sE40r+1KBI7Av2HAnJ46lx63v03wrW4BLdAbcJEKMGUXyGP6Sz3aXjjEiiUygaXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lgjauMfp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D80606A328;
	Wed,  4 Nov 2026 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lgjauMfp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497DD1F000C1;
	Wed,  4 Nov 2026 00:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793753411;
	bh=r4tz8o1TlU/xEK9b3YrVdww6EoQHDhX4m9dHm6jXFbo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lgjauMfpATlRYmKhs4FmHnDBN0KSd+dh2o3ETfHqUJdO8IF3M+SD0slSjLSLE/QN6
	 69VkAzxiYiglCGNY7hm/L12SCSLgEL5r1L2nJjnsV8M7lbUbj2gbZYjSCQUwjGRvsO
	 4bd7B6qoteHXhv0UjIB1s+Gx3lhAjYhwRmHuCgf9+oRYYakIQ2hERSW2yEyCDxlJwf
	 WOr1L6npqqapLtx3KFYvU/hoNU0Z2DUqzKbhAzmwFZaKvhEaySLgGe6Dp1UsM5QEeT
	 76ZAdcls4Dl5PIQyu8SyyivkTi0RFH2VPUllbEAOJ4n2Daq61k5Is72d+zH6AOguWZ
	 nHXLKGxyy/v1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401B6391B0BA;
	Wed,  4 Nov 2026 00:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Account for zero extensions in
 patch
 list expectations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179375341006.1981749.15460307595847324640.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 00:50:10 +0000
References: <20261103215309.19950-1-dennylin0707@gmail.com>
In-Reply-To: <20261103215309.19950-1-dennylin0707@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 iii@linux.ibm.com, bjorn@kernel.org, pulehui@huawei.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Nov 2026 21:53:09 +0000 you wrote:
> patch_list_insert_in_front() checks the translated instructions around
> the call of an inlined bpf_loop() and its callback. On s390, the verifier
> adds zero extensions after the two 32-bit register writes in the loop.
> The call is therefore at instruction 25 rather than 23, and the later
> instructions checked by the test are also shifted by two. The test
> fails despite the call and jump offsets being correct.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Account for zero extensions in patch list expectations
    https://git.kernel.org/bpf/bpf-next/c/8fb43ffc3327

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


