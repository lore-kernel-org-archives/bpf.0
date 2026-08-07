Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42524746AE
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107672; cv=none; b=bP8YfKkf/KoE3YqIdvgYaRfwkHolEY7ZLTHKqsNFWFNOFn5WOzEE+We7wlwfV2FXqdV0ANuXuNTjGJ/cQTl903w58sOE9AX0F6q2ecvzIZycyN03NnFR2MYD+sv8kGEH+nvrrOfdalHrjqxrijRBjAhZRwUuz1cMa+NgtOR9txc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107672; c=relaxed/simple;
	bh=zYtDjwLg2qTJmpOnvB05qnq2Ak1ZPeHMkpA1PskzrZk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qXVK/Q83Ok43GdTcwxQUTBXw41KZttF9NVJPMn5IlzKUisw5rPkMEIXm0OjtAjmsLwj2c7dWdaeCYp0AJZWAMY+iR+ig5LaAfppOhfGn+xr/iaMFWKRrHUK08fj8m5GkS9BLMoYCEBx51Af30hB6HAmPRhDXmq5bAoXwwoS8WSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKR3PyiH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKR3PyiH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFDE1F000E9;
	Fri,  7 Aug 2026 13:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786107655;
	bh=KUypGj1d5xLPrQuz+l/y8Ecc1ymWhJZklkGtRFHs9bA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iKR3PyiHwy3+HWVnKTNLyNap4aIvHXJvtY1uuNSBW/MJhbvVwPjgvZh3O6OWRO/vx
	 AfhqDnC40yh/39jlS+Fn3rIG8jh/paTFYh4n8AQBZSkDypqREuPPdNUAXv6O3Rwffj
	 N1hiV3a84cQhj3llfPpAIDcTxxXdOZv29VYo+Ck6UOPj42ZQ5ghVO0e1fRVxlvkR26
	 M7iLMQCqx6AJ46htsx7vPhF+CnFmR1rfOuCxRH2oqESdd8Hc6mysTh4sYpKEnpsrCp
	 8Jacrbn8KHo78afoN7jHpvwWgt27vNqFAf47gZyo1ebGE6yluVh/qp0e7qXhybVJS1
	 TELJFvrSYLeJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19867380AA76;
	Fri,  7 Aug 2026 13:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Reject load-acquire from pointers
 requiring fault protection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178610761364.1785508.378629022804300518.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 13:00:13 +0000
References: <20260806201047.333389-1-daniel@iogearbox.net>
In-Reply-To: <20260806201047.333389-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, eddyz87@gmail.com, puranjay@kernel.org,
 info@starlabs.sg, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu,  6 Aug 2026 22:10:42 +0200 you wrote:
> A BPF_LOAD_ACQ is not rewritten to a BPF_PROBE_MEM load by the verifier,
> unlike a regular BPF_LDX, so the JIT emits a plain load with no exception
> table entry and a fault panics the kernel instead of being handled.
> 
> Reject the source pointer types that a BPF_LDX would have had that fault
> protection applied to, i.e. the ones bpf_convert_ctx_accesses() turns
> into BPF_PROBE_MEM: a bare PTR_TO_BTF_ID, PTR_TO_BTF_ID | PTR_UNTRUSTED,
> PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED and PTR_TO_MEM | MEM_RDONLY |
> PTR_UNTRUSTED.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/6] bpf: Reject load-acquire from pointers requiring fault protection
    https://git.kernel.org/bpf/bpf-next/c/7db0a00445f1
  - [bpf-next,v2,2/6] bpf, riscv: Add and use bpf_atomic_is_load_acq() helper
    https://git.kernel.org/bpf/bpf-next/c/e2577cd62060
  - [bpf-next,v2,3/6] bpf, x86: Fix exception table metadata for arena load-acquire
    https://git.kernel.org/bpf/bpf-next/c/4cf8def58b77
  - [bpf-next,v2,4/6] bpf, arm64: Fix exception table metadata for arena load-acquire
    https://git.kernel.org/bpf/bpf-next/c/af22d273aa1f
  - [bpf-next,v2,5/6] selftests/bpf: Add arena fault test for load-acquire
    https://git.kernel.org/bpf/bpf-next/c/007466d9e497
  - [bpf-next,v2,6/6] selftests/bpf: Add load-acquire test for probe-memory pointer types
    https://git.kernel.org/bpf/bpf-next/c/2b1f9f69ae25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


