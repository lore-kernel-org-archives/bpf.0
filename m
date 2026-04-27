Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14E6243951
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777252860; cv=none; b=ftyTR28rDSLf2uJNZOWuMCoxzazCGV7308qtztwbQMpMdn3W01gjJMOUBi3/MzRKjw0LtwsWYAFGbw+Kx1q7yE6bTz1mOLN28fNUw+RbY/8ZSRKyiDWXfbr/tF6FjimuO5tZxj01yo+aS0xywOCUJ7KOVcRS3bGCeKZVGpjQilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777252860; c=relaxed/simple;
	bh=DdDhfajJxG/HmvAbpaVbMTNgUHIXIjwK5v15nTvqrFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gka4/FJ23/4o6eaAjAUBcRlr7q7z3u1cwTRcWkGKwHKPV9Aa/+smRoTMtT/RvThf+kJhpgyxMzaieC+ijEUcjCoJ6JeIHherVrsOWPlmWaz2OdlFnL/dFCWHztNlR+4nbCSzoYKCOvarYo66T2Q1Kg7ZmTScgyqrH633XH9SX1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iygGIupN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iygGIupN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8FBC2BCAF;
	Mon, 27 Apr 2026 01:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777252860;
	bh=DdDhfajJxG/HmvAbpaVbMTNgUHIXIjwK5v15nTvqrFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iygGIupN4nT67qBvpSp1wGfSW22+QJ9/tl4KnEwujVAf+5cQ/RjtdfrDldidqa48/
	 xLlpXFO80NZP/9zrgsacymq0IVWbjFHSeTzgqvSZC6Nacj6m13xwQxEDSD7T5unz1c
	 zP4pKsqVSsxJIM7U7l7g3AwPCBplBD2KXLaKjVztcM24d4Le/J4UzvHmVupALzR9A6
	 gor2joy7pWr7RcwW8rI9YQN30ZTpIkaekJ9BJ7+Aa/Mxu0Ot9GHDSgviepP0kMjmWP
	 1vslzvLq5Of2rsSGZxtX7QZ2d522OFSmFKmu+CppnYOv2KUYWTS812p1spLRE8q0JG
	 T2xnCvhLlfFJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA00A38119E6;
	Mon, 27 Apr 2026 01:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v9 0/8] Introduce arena library and runtime
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177725281855.2918873.11476351172430817233.git-patchwork-notify@kernel.org>
Date: Mon, 27 Apr 2026 01:20:18 +0000
References: <20260426190338.4615-1-emil@etsalapatis.com>
In-Reply-To: <20260426190338.4615-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
 mattbobrowski@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 26 Apr 2026 15:03:30 -0400 you wrote:
> Add a new subdirectory to tools/testing/selftests/bpf called libarena,
> along with programs useful for writing arena-based BPF code. This
> patchset adds the following:
> 
> 1) libarena, a subdirectory where arena BPF code that is generally useful
> to BPF arena programs can be easily added and tested.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v9,1/8] selftests/bpf: Add ifdef guard for WRITE_ONCE macro in bpf_atomic.h
    https://git.kernel.org/bpf/bpf-next/c/1fb8e9b32e19
  - [bpf-next,v9,2/8] selftests/bpf: Add basic libarena scaffolding
    https://git.kernel.org/bpf/bpf-next/c/d5327480a12a
  - [bpf-next,v9,3/8] selftests/bpf: Move arena-related headers into libarena
    https://git.kernel.org/bpf/bpf-next/c/8c1e1c33fe5a
  - [bpf-next,v9,4/8] selftests/bpf: Add arena ASAN runtime to libarena
    https://git.kernel.org/bpf/bpf-next/c/9ab78691eb5f
  - [bpf-next,v9,5/8] selftests/bpf: Add ASAN support for libarena selftests
    https://git.kernel.org/bpf/bpf-next/c/cfc00618b9df
  - [bpf-next,v9,6/8] selftests/bpf: Add buddy allocator for libarena
    https://git.kernel.org/bpf/bpf-next/c/86426a28c52d
  - [bpf-next,v9,7/8] selftests/bpf: Add selftests for libarena buddy allocator
    https://git.kernel.org/bpf/bpf-next/c/b1487dc1b181
  - [bpf-next,v9,8/8] selftests/bpf: Reuse stderr parsing for libarena ASAN tests
    https://git.kernel.org/bpf/bpf-next/c/554e4eb9e4b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


