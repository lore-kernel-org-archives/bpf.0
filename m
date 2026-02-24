Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4DF3A9DB1
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958400; cv=none; b=oZ4t+95lKKuleoQJALX65uLjiH06xp7U7urivvRj3IVm2zOz8nzAP46zkrlerNT2SruuBAyyrRaBrUu2WBCfYAr+SkiB9vHuyWUbuoB5oK9IG68wtECYJ6vDQeWpyEAznno7GR0+XyV8U5tNCbH1zxKDG4jW14YYtZgTO2o2MIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958400; c=relaxed/simple;
	bh=1FM7+H/EiXE3WnGlz2e78+LvBABEo/4yAYT4BkdIpr8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cYm+PpyZZG+54uyP+emjSv2n7LCGUT2hisssG4ZZ+w6aN3oiemnhT2LvOeSw0Ya2kQt2tKnbDnYw487+Cu5wGtPs0/py9nkjuj+y6ZRmvNO16LzQyVX7zIGZ606X+x+SUm1l9PGHnfWm7SXgRvTPlp8al/EaEQu4gTtOJh8CkbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOh2KYyb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOh2KYyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BC3C116D0;
	Tue, 24 Feb 2026 18:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771958399;
	bh=1FM7+H/EiXE3WnGlz2e78+LvBABEo/4yAYT4BkdIpr8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hOh2KYybSErWFy/dGGGJkBsPRBJPdjREJ2+xNJnLdg4dDi7hwxZU7JxdvV5cnT/WR
	 sIgwaqHsFX728EqALPWxj0VT0wnU9FsQZVikTAiqdLmtTFWoWCwkge69bR8WXOZpX+
	 FYYsHKJu0+71TDARpdh6D8jXWVeCWITGtvTX5esXO4F4dQCIFjVbt8+mM1VdLfBp1Q
	 0TSsilg2TN/C3netSFzXfXn+KnmyARK/PnPPZ6Btx59WXA3fPiBouaXbnejGfa9Sa3
	 +Ptgq6LsSMsVu/4b48NwjTua8XNmyCjmi7WMssu48ajoCLLBVIv6qVUHbUXGVpI+cL
	 Dk68hHwe2fVNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF613808200;
	Tue, 24 Feb 2026 18:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] bpf: do not increment tailcall count when prog is
 NULL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177195840505.4103960.10553057022632125451.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 18:40:05 +0000
References: <20260220062959.195101-1-hbathini@linux.ibm.com>
In-Reply-To: <20260220062959.195101-1-hbathini@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, skb99@linux.ibm.com,
 adubey@linux.ibm.com, iii@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 20 Feb 2026 11:59:58 +0530 you wrote:
> Currently, tailcall count is incremented in the interpreter even when
> tailcall fails due to non-existent prog. Fix this by holding off on
> the tailcall count increment until after NULL check on the prog.
> 
> Fixes: 04fd61ab36ec ("bpf: allow bpf programs to tail-call other bpf programs")
> Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [1/2] bpf: do not increment tailcall count when prog is NULL
    https://git.kernel.org/bpf/bpf-next/c/3733f4be2870
  - [2/2] bpf: zero extend function arguments while calling kernel function
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


