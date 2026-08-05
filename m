Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378301A3029;
	Wed,  5 Aug 2026 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961847; cv=none; b=hmasnf+5PhnH756dOwsS/s8GNIhbftpkalHIcEmlI0imKJDk/nrwMWwTtMWmYFR8hVJ2c/cRQj3SPZ5wW7K/JvcR69fUTl6GRo2oSN4HJWtCmGeHK2PWJQKIZ6uxkPkrsTueTIB6dD5OMtOqGFKq6VZ0EnH7v52IPxKC/t6Lkxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961847; c=relaxed/simple;
	bh=V9eEKCOZVfDmogE+8kP5gTtOeTIiAf0oa9nZ5jL6V5U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PhWXLmGjO/b+GG6LfPMYubWFQg4eG1KLcwrruDaTz1vLIBGPJHl5LqpY8QqXlQtH6IC+BSjiYunqMmMGAF1n7TXUjaDoXtLTXFPVCiX90sTop+r/C8AVZhRbiTm5+PA+gEbb+zCeQFncVxMa4bkXhGEgLQfhHZFjWHrOgQRMPJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H11NBHbJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H11NBHbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87AC1F000E9;
	Wed,  5 Aug 2026 20:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785961845;
	bh=5AcqBOC/xjW3FonssKOl/rujYxKC5zL5C94NWMspmk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H11NBHbJkdeNXvwj3od/9Rx1MtN/E40ObzEe07wmaPA1N2W6wA7kDIxMETD6aiIEq
	 oyQAJbeFTs//G6H3NTul98axDP/ZdWOB6GlQud6rb/Rx+QQWRLDzJKAKNplezGCiis
	 BKuh4pkbULh9EQNpVnnfm+5gdZ9KWxuNJzd7LBeHQPF4Ew3DedjVDsjMMGwF8MFlVO
	 ssdgGm0gcsYpQod/Yb0mSdh6ztXaWfItQoxPiwuEwcPSTr1/vQ4wnrM+9ch70ie5tJ
	 kij6YCRYPxbri7vavez1A4hGrC7e3PzMIHfJrFJMZKYmltQmAEDqF8+uy/l3WPuamb
	 JXGZhILKHykhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09DA392FFCA;
	Wed,  5 Aug 2026 20:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/1] bpf: Check sk_state before sk_protocol in
 bpf_tcp_*_syncookie
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178596180539.512924.16475522048304513684.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 20:30:05 +0000
References: <cover.1785823138.git.rakukuip@gmail.com>
In-Reply-To: <cover.1785823138.git.rakukuip@gmail.com>
To: Ren Wei <enjou1224z@gmail.com>
Cc: kuniyu@google.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, lmb@cloudflare.com,
 ppenkov@google.com, vega@nebusec.ai, rakukuip@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  4 Aug 2026 22:29:00 +0800 you wrote:
> From: Luxiao Xu <rakukuip@gmail.com>
> 
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/core/filter.c. The bug is reachable
> by an unprivileged user via user and net namespaces.
> We've tested it, and it should not affect any other functionality.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/1] bpf: Check sk_state before sk_protocol in bpf_tcp_*_syncookie
    https://git.kernel.org/bpf/bpf/c/31a420a822ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


