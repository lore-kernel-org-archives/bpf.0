Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B633FE27;
	Wed,  8 Apr 2026 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775611237; cv=none; b=SAeFgoGDNJ4AS5HbmDH0NHC9whF44MDJs5vGKc+3HNqBsX0GNF6qYO9/mGRjo0Wp9uQvKJBTXs/ys0oS1xqnabsPswBVbtEkd/2Bo6jSrxcTAGxOKUwkuDZjYDyUEo8n/CXc9aCE6U/r7Gn7ZuZsIUryu2IcvICdHqJ9QvhXHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775611237; c=relaxed/simple;
	bh=wnMsjgtaRk5JZMUEyxFKsze0Quamegckjuhh+EfyLz8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N9Xh+eow3b8Sg/xRm8sF2NOdyD/WPD+c47DPLSl43XX/30gVjCu1h31O8qgsFtPEEaxnI9RDB3hdN7nPUrE0qi0SIiJmATk7pHLAIMyvz4xfBfC6twn68LDdjOEHL+ZsJRCCr0K48HEeR19Wb2fVpl5ZlY3eIxfHRozCHKV1h68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjzoli58; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjzoli58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8319FC19424;
	Wed,  8 Apr 2026 01:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775611236;
	bh=wnMsjgtaRk5JZMUEyxFKsze0Quamegckjuhh+EfyLz8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cjzoli58PIHE+fl1pkYsVci7+dW75uh4mcpchqdV7t6m31aN2HzwM2gKWu2iXbAN6
	 ceiK8+Vq7lhb/13OPi6gOANjEH9GnwD16x7QECIu8m8QBMuJwGOZ+qdXcZfoIU45/s
	 vv6PBqrXyU7bKQdNCAkpEO3Jq1c1wxCpU3RrU248yxxtp/RQVnCzIW655jXK2x4j9L
	 +xCxUqogfyhE5DGI6mDS6MZwngmkNtpLfrsqvKV7aR6bRcC3h8spLIQtiqu3+3t+SN
	 jf/KvaVzR/Ffvqod9hCE+JZITZnNVwWqmx0nWBR6fscI3Bb+spNLCmbDiEGrzH0L5A
	 OYdwrNYn4tLbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C893809A3D;
	Wed,  8 Apr 2026 01:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/2] tracing: Fix kprobe attachment when
 module
 shadows vmlinux symbol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177561121379.25865.559402724947422501.git-patchwork-notify@kernel.org>
Date: Wed, 08 Apr 2026 01:20:13 +0000
References: <20260407203912.1787502-1-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260407203912.1787502-1-andrey.grodzovsky@crowdstrike.com>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, ihor.solodrai@linux.dev,
 emil@etsalapatis.com, linux-open-source@crowdstrike.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 7 Apr 2026 16:39:10 -0400 you wrote:
> When a kernel module exports a symbol with the same name as an existing
> vmlinux symbol, kprobe attachment fails with -EADDRNOTAVAIL because
> number_of_same_symbols() counts matches across both vmlinux and all
> loaded modules, returning a count greater than 1.
> 
> This series takes a different approach from v1-v4, which implemented a
> libbpf-side fallback parsing /proc/kallsyms and retrying with the
> absolute address. That approach was rejected (Andrii Nakryiko, Ihor
> Solodrai) because ambiguous symbol resolution does not belong in libbpf.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/2] tracing: Prefer vmlinux symbols over module symbols for unqualified kprobes
    https://git.kernel.org/bpf/bpf-next/c/1870ddcd94b0
  - [bpf-next,v7,2/2] selftests/bpf: Add tests for kprobe attachment with duplicate symbols
    https://git.kernel.org/bpf/bpf-next/c/cea4323f1cfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


