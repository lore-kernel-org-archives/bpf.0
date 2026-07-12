Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CAA2DC32A;
	Sun, 12 Jul 2026 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783814439; cv=none; b=EnyiQr0AnDfHbkIPlrXhFCja2nCsB3qMRLUQiQ9IwpSSVSr7h4YMOkCZynnZcbCSI4Zi9o07DB/59iXl5GIXkGMeCFR6PfNc4lY52RnJrLnFPJGuQjnnz0QKzQoaVtiv6kIqynszKP1dvAkbIbKUZk9f4kB/tNwk04z6wuU5uxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783814439; c=relaxed/simple;
	bh=969haNKGJYNyEjmlfynHxU5MNR8Rj3zWgGZB9MyPVtw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lDJkfvRULq/8qgTXgvkfaUdZ3RcNkPZp5pusO0vKys/3XIPboYQJ7UgYgl/oHy6ufn7WR5Rkmvet8iQl7Za6ehHfUdT5Aas59LJVjxGxE/Du7k7V3mDE8YpjeoRDG5vDEPGQVSHHISJ+/2QhX1MkSkeL66ricnBekIu0yc+P6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWE/ttSK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWE/ttSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C801F000E9;
	Sun, 12 Jul 2026 00:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783814437;
	bh=fLuDaFj4VFkrwrrruWtQy8eNFXxpSe6o2736DOBxNNE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XWE/ttSKi8XDYG5JG1f2U5CRl2TCjdt8mlrzmdPbJTX7IS8J80Sy/qecT3SXN8O8W
	 Qqx5+0DYMoEb16RaLkQRZVHhX15zf+vO3lzXhI4yqyLM9hcMSDJzXMQHNK96me/Vzm
	 TYa4cTAVeRTohGdoxCfK+Dtg4iUjceCu25osSdh+CqCPPNbnWXiYLD+045Fc94wMFF
	 iLn1qbNKz6MS+fvD1kgHiiJqeCRZVyN4rCD+BT0NnF84TfV/e1lS1NASnfXrVc2fq9
	 FjBk8/7gTvJSou52dJy2Ty+1A7kvtXmtLnpUXdkYa4dm2K6GvHCiolEYTbJ7HkN4nC
	 kJersFRGAxlHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19C0B3924A1A;
	Sun, 12 Jul 2026 00:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix WARNING in
 bpf_trampoline_multi_detach
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178381441365.1241617.6815515077282154741.git-patchwork-notify@kernel.org>
Date: Sun, 12 Jul 2026 00:00:13 +0000
References: <20260711124822.29406-1-leon.hwang@linux.dev>
In-Reply-To: <20260711124822.29406-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sat, 11 Jul 2026 20:48:20 +0800 you wrote:
> Since tracing_multi link does not set ftrace_managed, it would fail to
> release the tracing_multi link when attaching tracing_multi link and
> then attaching fentry link.
> 
> [    3.714215] WARNING: kernel/bpf/trampoline.c:1727 at bpf_trampoline_multi_detach+0x20b/0x240, CPU#1: test_progs/97
> ...
> [    3.733170]  bpf_tracing_multi_link_release+0x14/0x30
> [    3.733890]  bpf_link_free+0x58/0x130
> [    3.734414]  bpf_link_release+0x23/0x30
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Mark tracing_multi trampolines as ftrace managed
    https://git.kernel.org/bpf/bpf-next/c/30bdd6d1384d
  - [bpf-next,v2,2/2] selftests/bpf: Test fentry link after tracing_multi link
    https://git.kernel.org/bpf/bpf-next/c/539d3edf8e53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


