Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4DD4414
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775870433; cv=none; b=DOrttqzetPaTagkcgRl473RZcwtfL29kpIo0hAMEGbFaRi2Yc8EPY456/K1JSef5G3Vu7H4BWMHbFpJ3x2JN2c+RcfxOoqhuWE5q1PlhlxV8/rnZn+UpBTx/A5vr7Yjo0UmLwLh0DNz67exK3E+pOA1xltFng2ArVgOyOW3lviA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775870433; c=relaxed/simple;
	bh=C8aieDQ0KPli9AirI92lSBQh/SReVSZvVKwzuOTXC6I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pzso90e9kVznkWpeg6qjvSPsxz2l+Ig5LZ45HL6ZrcwoFQF8M7IftrFlKDi6T9IxzpEbQO674mKbmor5fxqtDFgzi+P0tRVWGebjysJ0oeX224VJcY1p+AMnxXBDo/VQzbbK3nz6/GjLe2L4B9kQdVR5Y5dy7cndxA1QSBux9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/888UI6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/888UI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D347C19421;
	Sat, 11 Apr 2026 01:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775870432;
	bh=C8aieDQ0KPli9AirI92lSBQh/SReVSZvVKwzuOTXC6I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G/888UI6/mLksSGW5UuELZdFseNpcGmjqpdZ3eDHpDiRHwevitpRUMwDbs1iWhz2p
	 DsMD+dsCoJ+nzexmR4Qdm6t99SmlG8k7yQgS1ChzAD3lvh0L3mu/47X/hzZo3LqXyI
	 7uywYiN6soZjHSvimCyaRMRRZqD/Qqq702D9ZGwHCvACB4oO99p7XeTVJM1Eo/6vOw
	 S7oxpuO1cG6Nb0Mdm4UZa7xwuIdQywbYM94wq5apmaJ4eY72JN0hgggDCH9lZVlc0E
	 PeUCo3ieKI7C5GwSaRopKlvpN7UU8aXdui3ZVmLHQluBntut1/QPpDKccymIiimtLF
	 OSjolRzfBiKcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BDC3809A88;
	Sat, 11 Apr 2026 01:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Enforce regsafe base id consistency for
 BPF_ADD_CONST scalars
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177587040680.2708733.16822135192644626939.git-patchwork-notify@kernel.org>
Date: Sat, 11 Apr 2026 01:20:06 +0000
References: <20260410232651.559778-1-daniel@iogearbox.net>
In-Reply-To: <20260410232651.559778-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, eddyz87@gmail.com, info@starlabs.sg

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 11 Apr 2026 01:26:50 +0200 you wrote:
> When regsafe() compares two scalar registers that both carry
> BPF_ADD_CONST, check_scalar_ids() maps their full compound id
> (aka base | BPF_ADD_CONST flag) as one idmap entry. However,
> it never verifies that the underlying base ids, that is, with
> the flag stripped are consistent with existing idmap mappings.
> 
> This allows construction of two verifier states where the old
> state has R3 = R2 + 10 (both sharing base id A) while the current
> state has R3 = R4 + 10 (base id C, unrelated to R2). The idmap
> creates two independent entries: A->B (for R2) and A|flag->C|flag
> (for R3), without catching that A->C conflicts with A->B. State
> pruning then incorrectly succeeds.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Enforce regsafe base id consistency for BPF_ADD_CONST scalars
    https://git.kernel.org/bpf/bpf-next/c/2f2ec8e7730e
  - [bpf-next,2/2] selftests/bpf: Add test for add_const base_id consistency
    https://git.kernel.org/bpf/bpf-next/c/497fa510ee46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


