Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1E7175A79
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778540471; cv=none; b=i5kvapxQ289PzLq9U75gUVShkyC22VRL7vcHAAso6kkEv+3J8kqPtSyqD6qdb4OPieqyjefQDlqBEra4PJjWwlr9fPc4DschRwNpAZ4trFyRl4Fvred3LLKIMhhUIg966sGae2JuH6UtLpmIX6X0ESIS1luNUaUTQimKDwlb6Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778540471; c=relaxed/simple;
	bh=eP1yC9xP1nDay4yUTLJoBsfkFuHv7gdEyUHAQK1ShGg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GxwY43GasBWH6qQMZB9MJBsxpfwU6xjawbD9/v43hvbWRlJ4ko4/If5iJF56+yXzix47cGCa709Ne760TK4IGYteNKURppK/39aB8X06yrTEXEbMJ7FaB0c/jnYNdXlghntArgfj7ndB0FUpkaud6rGhssAIbdbAb5yrCqxIJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVuPuKUB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVuPuKUB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6849C2BCB0;
	Mon, 11 May 2026 23:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778540470;
	bh=eP1yC9xP1nDay4yUTLJoBsfkFuHv7gdEyUHAQK1ShGg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WVuPuKUBTYQr1AoMVJ3x60NUqcKdPExCz2x3F9phJpkSn+ABRMe10Yw9jf9NKxgDj
	 emCmCHDHkIMu9WstubWICQpc/ZAxp9Wt5wh4w1KHsGpCo5RjZ8PXUM/BbPjDs8Nloz
	 W3JtuBSrrVMd1SxZYHiayw91pBX3+GLZHnZNrXuagLv+NFSVYGqyOY5wJYgCNrH9fO
	 r9++wpsr4zQMU144tUVPEX7M3qgRlRP6lteXBeRopwQOboVLFlPptEjeYN+q89R0Dr
	 S1/0pZLb3KhotGNQF+ta6XtmHPle+SITecJ5JbyExNIMnq4QKxYtTmZMnKukIB7KYm
	 GOROmI7Je04lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDDF39308BA;
	Mon, 11 May 2026 23:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] selftests/bpf: Use both hrtimer enqueue helpers in
 vmlinux test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177854041705.2496500.7441021912913320811.git-patchwork-notify@kernel.org>
Date: Mon, 11 May 2026 23:00:17 +0000
References: <20260509005730.250956-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260509005730.250956-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, tglx@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  8 May 2026 17:57:30 -0700 you wrote:
> The vmlinux selftest triggers nanosleep and checks that both kprobe
> and fentry programs observe the hrtimer enqueue path.
> 
> After the hrtimer_start_expires_user() conversion [1], nanosleep
> reaches hrtimer_start_range_ns_user() instead of
> hrtimer_start_range_ns(). Hard-coding either symbol makes the test
> fail either on bpf tree or on linux-next [2].
> 
> [...]

Here is the summary with links:
  - [bpf,v2] selftests/bpf: Use both hrtimer enqueue helpers in vmlinux test
    https://git.kernel.org/bpf/bpf-next/c/25bb05dd06cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


