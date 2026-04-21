Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4226F8F4A
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776733254; cv=none; b=AMrmSYMt2KLEJPWk0P9fOC4Q3tsFJLwbr+xgdC19yFuHDTsTcpM4so4dytRA9AcB+Sb/R7QmF+Db+eV2g4U9exgLZZMf+k+IzwwOnnYWafReKjWWfrOrDfE9wKoJRZ48jvM70lUHkhbZuIbvpGRwGCtjJbiLFmEnr6cMUxt/C0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776733254; c=relaxed/simple;
	bh=Kn7czQQXwdcZJZsVPTuS1c9yRifGoaqJL4oOC4FiFMw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d+xHhaJoqiCnMvAzsxFffDBf4MpOcfEVPfKTZjj9onnKZEyNGVi/3ZtkOtBADGTU4KGoMlK665Zu29Jw/lXLMDtnXwQDcLDb3Gee0KInEPOJPHTWlPKOdNpQ/buI2bgpqn72fBNv57FLhA374hJi6DkuAijDBE+CXsrSbv+/YCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1gGZga6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1gGZga6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBF2C2BCB3;
	Tue, 21 Apr 2026 01:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776733253;
	bh=Kn7czQQXwdcZJZsVPTuS1c9yRifGoaqJL4oOC4FiFMw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O1gGZga6QwKnO/Jrw2Rs5R/D56PXs26q0fPzZQYKMSuknJ7OPwB06zncjg636UDQD
	 1E2I7eTlKK7JAU74eKhFqK3fe91wbhAI9ZwCq38igo1n/XyC+UxKS6z+nw58aRjXuY
	 IuYTVGKlIghmmEDLkRsORAbU8/UmFIkXesq51nEp2JYp6wYUDmcv3id1M6n/o8MmM8
	 nDe7zMLbR9M1yZGsNqvMuLgXK4+6Y6qfWMwTL7hkbUeyAO9JddAkLq1WOgSj2ay40n
	 FPQq8FZ1ayH1ciaThjphwx/FZNsfZScD3Nid2TKP5cOCdeyWdu5shQTf1KsUk+80o/
	 akMg1RpxgO+zQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDAA3930023;
	Tue, 21 Apr 2026 01:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf/tests: Exhaustive test coverage for
 signed
 division and modulo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177673321782.2153798.645802776680102725.git-patchwork-notify@kernel.org>
Date: Tue, 21 Apr 2026 01:00:17 +0000
References: <20260413172311.3918767-1-jmeng@fb.com>
In-Reply-To: <20260413172311.3918767-1-jmeng@fb.com>
To: Jie Meng <jmeng@fb.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 13 Apr 2026 10:23:11 -0700 you wrote:
> Extend lib/test_bpf.c to provide comprehensive test coverage for BPF
> signed division (SDIV) and signed modulo (SMOD) instructions, both
> 32-bit and 64-bit variants with immediate operands.
> 
> Introduce F_ALU32 and F_SIGNED flags to replace the less readable
> bool alu32 and s16 off parameters throughout the test helpers. The
> BPF instruction 'off' field is derived from flags only at the point
> of instruction encoding.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf/tests: Exhaustive test coverage for signed division and modulo
    https://git.kernel.org/bpf/bpf-next/c/c8f0ee969f76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


