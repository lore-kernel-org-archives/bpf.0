Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583C3F20ED
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480639; cv=none; b=mfNutYtij3qkWVxQVihn57MLO+gd36/J0Ejye2AnKhMtUQAY6W+LGjTgTlZOwbxOUhUhu6Vrblbx26ZAnmPwkOQvOjEkuoALkqgAkgmUvEk3x89PJjDAENt6AZkEFXuugf0ICVtdPpcuJAPpepB/ylvsCKL3bjeGjbkR0zVbOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480639; c=relaxed/simple;
	bh=CJxOjXEix1kDaMQ8QY3jzJ4hCQBH3rVsGzgU6epmz7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bgDX1yrVsc1NGleiYOeKwegEqsgE8Xrw9PNpdqM2NX6Rmr+0rA9y9WOX4vLeyUAlAxLVcm6wkukDny181phiGpvCe6DhY1kZ17qRzBtkBWxs6dCfFXtT6TyfmSVtJ1viIJW/mRBkeTe8v1nt/DdbnJBBfD8/vjFl+IsDBYhVZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXnOnE8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXnOnE8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039B21F000E9;
	Fri, 26 Jun 2026 13:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782480638;
	bh=n5syicAqDD2OQEZD7xSKsO9zXg6U8mU3ff679GgPS9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nXnOnE8ZKC6IogSIFaomGTT0wUOSTErFrqoE7+FX6vIArT3baIs/0d5xh+IQMILHa
	 DfdZf2HqT2bteSfr4UJ2JNCKM2tzAl97Q9uaDzsfCkRKPeXuvI1CANFgJIEO0V5ffK
	 KR2DAoJ0TQk/ciSYRriidBVkv3Fa1UVdb+2CvrM663h1ynRxSSPUWA9qvzMu27ZYI/
	 TZNMrT9HDznQrvVXk5cXwu38D0maI8kGoartI7p4TiIJcELLQymM7KayjLfwsMDT6U
	 hPEF/0yrU3Lm6cZhDjqkI9CQz0+ipIEKVDbAi+hqr2GpjxGaMxHCHZgNkNU6p7kCaG
	 JbEj40b/n3DYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1996839389FC;
	Fri, 26 Jun 2026 13:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] Modernize resolve_btfids selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178248062458.457674.8040507163692276842.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 13:30:24 +0000
References: <20260624005546.1818483-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260624005546.1818483-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, alan.maguire@oracle.com,
 jolsa@kernel.org, emil@etsalapatis.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 23 Jun 2026 17:55:42 -0700 you wrote:
> This series updates resolve_btfids selftests to use latest selftest
> helpers API and add kfunc set testing.
> 
> This series was split from a bigger series [1].  It's general selftest
> improvements that don't have to be entangled with resolve_btfids
> development, and makes the main series a bit smaller.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] tools/bpf: Sync btf_ids.h to tools
    https://git.kernel.org/bpf/bpf-next/c/1dbf26eca0a4
  - [bpf-next,v2,2/4] selftests/bpf: Modernize resolve_btfids test scaffolding
    https://git.kernel.org/bpf/bpf-next/c/07b181a084bc
  - [bpf-next,v2,3/4] selftests/bpf: Fix resolve_btfids test reads of BTF ID sets in PIE builds
    https://git.kernel.org/bpf/bpf-next/c/6f10765ecd46
  - [bpf-next,v2,4/4] selftests/bpf: Add kfunc set test to resolve_btfids
    https://git.kernel.org/bpf/bpf-next/c/795638829476

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


