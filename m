Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724F54E66C9;
	Fri, 16 Oct 2026 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169408; cv=none; b=TD4hv5Q5ywg25/2swJoRxJnSYlRdufxcvJPTXkOMKlwinomUXo4QXJZdaVSRY5tQepmxdsdGhZBvImgr+vWnC5KKrSsUJODB2d+T4hYeHOQMbYtGRsbGNVVLL7UE8zUIYNysB+wFHdEZIwODHa8jSoFJQ25zJ6iHzbdYX5Ofuk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169408; c=relaxed/simple;
	bh=CUgMP96DLWQFyTmIzRJKec6OZNXfYQSXAg0KladlZuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HqwUB+hYunrw0f4dvKtdSlp0nYN74z56oMtmFybP/NCSGfOIqqxBQxPjFt2DQSq/Sj4GJH4u4IZ/wlQmBOpyGskq/ZtoBhau68dHfc7vVu32TNOEIHyXh1WMrzB40Ohx8L+5eZZHp+CeaDllKFHoTGU1qn+NXJyiI11JQw5PJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBjfUSeD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBjfUSeD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FC11F000C6;
	Fri, 16 Oct 2026 16:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792169407;
	bh=5fx8eg5gTmDU5Z/9d3tGezQ02ds6dzT1pbZkF+XQKeg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UBjfUSeD2KpdsyGCPPasRHccNQ4hrAU1ceiwQDSKrmzeoOv9KeNiCc7FXY4GycFl9
	 W/QUWNbki7ky+NiB8qHgX8f4/a8No63B0Y5buLl7oZxB6KQFUaHbaG/pkz+F3WSfc+
	 0rrUaMNNhntztWHuH0R8zVv3M1MBSQFCp5zTl5LJhRIqXCe2YH6WcVmBK0nSzC6ZPY
	 EnXWFo/PrYfySv1yzznddBGFJCWZO7f63umsvZinlmr9AtCo3NyS0OT+Y7rBWR2IIo
	 tjFagmmtPMClgxlEGm4eTLwNSkp8I3klr2P5YTfDopupJ22dyrqynVgH9M3vomvFUP
	 Qlp5VdhYZJ4fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3AB7B380AA4C;
	Fri, 16 Oct 2026 16:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: Two trampoline cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179216940603.871030.5244441859189245098.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 16:50:06 +0000
References: <20261016142014.12420-1-leon.hwang@linux.dev>
In-Reply-To: <20261016142014.12420-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 16 Oct 2026 22:20:12 +0800 you wrote:
> Split these two cleanups for trampoline from the series
> "[PATCH bpf-next v2 00/21] bpf: Add tracing_multi link support for bpf progs" [1].
> 
> Since the tr->ip is ftrace_location()-ed in bpf_trampoline_lookup(), no
> need to call ftrace_location(tr->ip) again in
> register/unregister/modify_fentry_multi(). Also no need to call
> ftrace_location() for the target addr in register_fentry(), when
> initialize ftrace_managed in bpf_trampoline_get().
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Initialize ftrace_managed in bpf_trampoline_get()
    https://git.kernel.org/bpf/bpf-next/c/09ec92d70723
  - [bpf-next,2/2] bpf: Drop unnecessary ftrace_location() in register/unregister/modify_fentry_multi()
    https://git.kernel.org/bpf/bpf-next/c/b443a4578a0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


