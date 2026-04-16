Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F211A9F97;
	Thu, 16 Apr 2026 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776380441; cv=none; b=sF19bj6uv6ywer5jANtteN4Ws0CT2/TX5tZLSLBof1S/ANRMykWA9PZFCulF1gfirj92ahkW7fCT9tVL/E9iAzhAV3jZcxhSjFzBk1ifxbfNlMbAVxDkKzsaBeZVCfYL7LapyoMOxE9cP/B8o4n8oyXfepoPURFXppjSec41qzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776380441; c=relaxed/simple;
	bh=W4Vt6rRPn4QV5NYLBE9XgIPtDWAbAbZUXjd91b93wFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eQR018CtMwcMO8LDv62wxaIrmZFLewOmfRbBqkmloNljO0Y2j8qWfsaArMW7u8Hr41fY+gCuPejlsz6v6Az862T2A01bv6aozgZVCbjIrxozFz5Wuq6e5YrHNkzBlwvkK9TXnba6GT3HTvtAirMOjLqmn/zJJyD8R0OUq6TP16Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnPSa5G8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnPSa5G8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AC8C2BCAF;
	Thu, 16 Apr 2026 23:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776380440;
	bh=W4Vt6rRPn4QV5NYLBE9XgIPtDWAbAbZUXjd91b93wFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pnPSa5G8gbqA2HVgwNN92BN6EiV016GphjVUyqLyq7c97GT7wGkyTteFXgoOyT4mt
	 OEkN4qNrml/aeUzHORnwJPA3YmR0xVpC4o/1UKFUR+Zt2UZBucjWS7pMWC1PBjAbMv
	 Vpex1V7y+BKWqDmnlsf35zrqcprjhUTSkP106xJQBpre/XPnfbTt455zfD8nkUsPkN
	 gCbq6qsiwXFXFT0C7h8jNDL/6gInfkpx/0StlzWEZfVMaKZZm1tVfHHDYKUeL/DIza
	 rXrDa55IxI9ryB/4faGcbIm87VayS/+Ad2fsXCYJaBP/HPT1vksN185vn39II15cY5
	 Ajn2F2YbfvF6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E06380AA76;
	Thu, 16 Apr 2026 23:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] bpf: allow UTF-8 literals in
 bpf_bprintf_prepare()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177638040855.3431809.14537321276770181909.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 23:00:08 +0000
References: <20260416120142.1420646-1-dingyihan@uniontech.com>
In-Reply-To: <20260416120142.1420646-1-dingyihan@uniontech.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, shuah@kernel.org, alan.maguire@oracle.com,
 paul.chaignon@gmail.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 16 Apr 2026 20:01:40 +0800 you wrote:
> bpf_bprintf_prepare() currently rejects any non-ASCII byte in format
> strings, so helpers such as bpf_trace_printk() fail to emit UTF-8
> literal text even when those bytes are not part of a format specifier.
> 
> Keep plain text permissive while continuing to parse '%' sequences as
> ASCII-only. Patch 1 updates snprintf_negative() at the same time so the
> selftests stay consistent during bisection. Patch 2 then extends
> trace_printk coverage for both the valid UTF-8 literal case and the
> invalid non-ASCII-after-'%' case.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: allow UTF-8 literals in bpf_bprintf_prepare()
    https://git.kernel.org/bpf/bpf/c/b960430ea886
  - [bpf,v3,2/2] selftests/bpf: cover UTF-8 trace_printk output
    https://git.kernel.org/bpf/bpf/c/4198ff31edb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


