Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7444C26AE5
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737839; cv=none; b=X3R8DKx23dOFunSh5ce1I6SVDID99ks0fbwksQhsjlUfCl8ySxe7kMbjiI1RlXGLcJXvSf0ieXiKAA9bLCkeD9PmYhQW6Du7VLNNb3s7rzHybYW5NsJq0TAcgrwWgq5YdfzIHCVBfJ1QCJYziJCLgivl4UI2uzaYZbknWUZEE4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737839; c=relaxed/simple;
	bh=H7QEIB/uZe1G/x+D4DsXr6pM5qcdFZ7qBNvkVwEipE0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uHKuYQ0d5xfGMPHFceV8FMMhU/05KW0d1cfFauEDjrRRcZg4l+NhW5SCoplRFMJVpeZmryK72f2VdS5BGg03mfZj3wq2mg6iWizg9U0VCQOqvxXSb49xwBWF+BrL7de8r0Btoa25toWi4hJaKOpBfeHFLQgrW2kKA20GzGCcIMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw+fPSqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw+fPSqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083291F00A3A;
	Wed, 22 Jul 2026 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784737838;
	bh=AY36yop0+c/Bp0L1jm99MCyNeDN3E5jShgT7kcj943E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lw+fPSqikMAW9DhKWzz/6Suy5SCxRwzb31h4rJfm0C1RE6FnI8U7ub2HZGWS9maw5
	 IpsGWlTz+9FfRoVVgyMjLAfWmib4pJtkGcGWa/2GAt1dn/9TGPBNzxg9+TUsmIpXSG
	 94Tl2ltLUwp76tTCt6aITt6i/d+VnatOr203K1oOKT1e1hH/9h0jQvy//2nB4VgPaF
	 pxgrwsTQ1JpIla2xGBP8Tebmw1pPW0656L7MMUhcWR0LfEKgzoQusvEj8/i5AZX1VG
	 EQGeqRg9Z/cU8wydTPWxZRkmvTlx254VdGi4WwI6VoLh2tK15Rdh/ZtpVGA8OehYA0
	 u9tP5HeFGTMrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199D4380AA78;
	Wed, 22 Jul 2026 16:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] libarena: Use compiler
 load-acquire/store-release
 in bpf_atomic.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178473780665.1930219.14117956766901037446.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 16:30:06 +0000
References: <20260722141003.2841007-1-puranjay@kernel.org>
In-Reply-To: <20260722141003.2841007-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 22 Jul 2026 07:10:01 -0700 you wrote:
> Teach libarena's BPF atomic primitives to use compiler builtins for
> load-acquire and store-release when Clang advertises
> __BPF_FEATURE_LOAD_ACQ_STORE_REL. Older compilers continue to use the
> existing barrier-based fallback.
> 
> Notably, as BPF programs begin running on arm64, it is better to use the
> more appropriate variants since we can no longer rely on x86 TSO ordering.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] libarena: Use compiler load-acquire/store-release in bpf_atomic.h
    https://git.kernel.org/bpf/bpf-next/c/87267b894598

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


