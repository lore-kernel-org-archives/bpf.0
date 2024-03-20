Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CC7179B7
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915629; cv=none; b=UyblQbbFErk/EiwqcgdwrNihuNn+13yR6fqNV6BIsOKkL7DPr2ZN7RV/KrjZQH/Dfo6J3lS7mSf8TgfAuPAFGvMlLW245NM7FbKN4nehkLIz5SM7Ne6tC1FuYT6jfuNPiFdaRUwsvcWwhpUIR9uSdtV0ZYAPr+a0hmgJNgEYsQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915629; c=relaxed/simple;
	bh=gC3OJtOmNfYlNnZ17xZO7ZriCFwKLFCXFl3F+OJHDhA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d7pVuubNtyWTqVf9ZomJ473SrLGlzsEWaphAF652sDoRbadznBEVdCI0m6y0DKY+nQAgIlZnPqyA+GccHk17r1thK4cgsn+K+EmMoWdI9Fhn7gRZH9DrZd9ta30sGWC7A7qWNb1FZfD3/GkXXWBDugeA8CpeWBQJW6NdNIC2rgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CajPNADG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CajPNADG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54714C43394;
	Wed, 20 Mar 2024 06:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710915629;
	bh=gC3OJtOmNfYlNnZ17xZO7ZriCFwKLFCXFl3F+OJHDhA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CajPNADGf3eAfb1F2eDbyo/5WVBSmXzO8y9UEJ40GrRkC3+uX0BNHjQR4u461lNzk
	 bUI5FwkR3drvSihF7VFvTtUFz3KWQiH8zhE28zmjqr/XJ5gvcf/mgU2DjCTao2CV4t
	 7S2L2wTDvcxqggiFwEUPHHfWNRjGZftmx/pe6VU0McYdQMdXRsdVk1Ito3kDo18C6Z
	 9ZV2/sWGXOLe3Iig8D7MArBDvZKNJyKJVNwMEihbcHsfJUv1QFTLXSi6lq0/R1G/oW
	 ZJj6F6gUZ0vjeeY8G4id7HHpwMZ+0CkH9DJDscS6oO1i5xN8Uo2mCp5lzhBRsOmACJ
	 GWTvH0HJyapHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CD25D982E0;
	Wed, 20 Mar 2024 06:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Enable libbpf logs when loading pid_iter in
 debug mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171091562924.21070.16045518099386859584.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 06:20:29 +0000
References: <20240320012241.42991-1-qmo@kernel.org>
In-Reply-To: <20240320012241.42991-1-qmo@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 20 Mar 2024 01:22:41 +0000 you wrote:
> When trying to load the pid_iter BPF program used to iterate over the
> PIDs of the processes holding file descriptors to BPF links, we would
> unconditionally silence libbpf in order to keep the output clean if the
> kernel does not support iterators and loading fails.
> 
> Although this is the desirable behaviour in most cases, this may hide
> bugs in the pid_iter program that prevent it from loading, and it makes
> it hard to debug such load failures, even in "debug" mode. Instead, it
> makes more sense to print libbpf's logs when we pass the -d|--debug flag
> to bpftool, so that users get the logs to investigate failures without
> having to edit bpftool's source code.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Enable libbpf logs when loading pid_iter in debug mode
    https://git.kernel.org/bpf/bpf-next/c/be24a895149b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


