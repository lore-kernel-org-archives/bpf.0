Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A4175A79
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778540469; cv=none; b=tkQC8EMUPoNa6YmCP+vOwp4ez4SnccMMqVduIm20zFx6Qnju1iA8EwhsqGGXbiUndAor8Ip3wrvsxahK2GWxyBSy/wbdzYcKonNGeRwygxJKGLSavNAG18bSR2ys21nlr/mTWJCCbR2S6RzxTTcrL4ycUS3hViDgL0YOBTGaaq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778540469; c=relaxed/simple;
	bh=qVBOcFHxPUqEbEi9wKlSyN4aJInjx0IZMJskplsjGPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NJxoy8/MV08lKhd0cUVQOh1Pb+WWws8hZYK0PbzXSjMzoGHhtKIH20zn8QLnEtFvG9kTZWax//w8oB87lyHcq/UYbIty5Pm48uZ0YWqC3CFvdRfoFIggHkNf15lhM68K02h031QmEh486YEbIQfByTrDTFUEHm90ZrdKdYqkIwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDxF5YUE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDxF5YUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37649C2BCB0;
	Mon, 11 May 2026 23:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778540469;
	bh=qVBOcFHxPUqEbEi9wKlSyN4aJInjx0IZMJskplsjGPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oDxF5YUE2eAkXSqg3Lon3MtqWB/fJKlP7384J735o7WekTExczXXX7D9OLw67wydE
	 ehuQ4B+9YRP21QRc7T/WgcLgcrOf/u0xTnVPAkMNrY6sOixzlsVIHG/6A4XhYwITVn
	 r2lfwnW+LICuEKV84aArS+HHz2aUnJJXdyPNGL9a1MYOaOn7kkhWX3KRPpAmVL68wJ
	 t0q+4DrpfFOWIw6wUr7hnSerDol9ioHfrxWdXlBbDU6Qj5uQ5/lJKw6UB0paNDFpDf
	 Cm4fjTmASUxOwRd1CPUKYJnjGqhMnUZWOEIR7ZnozzVG9OschQOcqFHlIx29owdN/x
	 rzjhV6cN7Oncw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E4739308BA;
	Mon, 11 May 2026 23:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/7] selftests/bpf: Add XDP load-balancer
 benchmark
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177854041580.2496500.4714535434277470100.git-patchwork-notify@kernel.org>
Date: Mon, 11 May 2026 23:00:15 +0000
References: <20260427232313.1582588-1-puranjay@kernel.org>
In-Reply-To: <20260427232313.1582588-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com,
 feichen@meta.com, taragrawal@meta.com, ndixit@meta.com, tehnerd@tehnerd.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 27 Apr 2026 16:22:57 -0700 you wrote:
> Changelog:
> RFC: https://lore.kernel.org/all/20260420111726.2118636-1-puranjay@kernel.org/
> Changes in v1:
> - Replace bpf_get_cpu_time_counter() with bpf_ktime_get_ns()
> - Replace bpf_repeat() with plain for loop and may_goto
> - Refactor collect_measurements() to reuse bench_force_done()
> - Remove histogram, verbose calibration output, and per-scenario status prints
> - Trim run script table to p50/stddev/p99
> - Set env.quiet when --machine-readable is passed
> - Add || true to run script benchmark invocation for set -e safety
> - Add bpf-nop benchmark as timing overhead baseline (patch 3)
> - Use named struct for LRU inner map to fix build on older toolchains
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/7] selftests/bpf: Add bench_force_done() for early benchmark completion
    https://git.kernel.org/bpf/bpf-next/c/2b6f0a1e4c9e
  - [bpf-next,2/7] selftests/bpf: Add BPF batch-timing library
    https://git.kernel.org/bpf/bpf-next/c/08158c111d7d
  - [bpf-next,3/7] selftests/bpf: Add bpf-nop benchmark for timing overhead baseline
    https://git.kernel.org/bpf/bpf-next/c/dcf11479c2a8
  - [bpf-next,4/7] selftests/bpf: Add XDP load-balancer common definitions
    https://git.kernel.org/bpf/bpf-next/c/6b4003a7b333
  - [bpf-next,5/7] selftests/bpf: Add XDP load-balancer BPF program
    https://git.kernel.org/bpf/bpf-next/c/4b4f2229104c
  - [bpf-next,6/7] selftests/bpf: Add XDP load-balancer benchmark driver
    https://git.kernel.org/bpf/bpf-next/c/a4b5ba8187cb
  - [bpf-next,7/7] selftests/bpf: Add XDP load-balancer benchmark run script
    https://git.kernel.org/bpf/bpf-next/c/51312b6360a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


