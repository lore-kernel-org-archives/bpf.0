Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7432EB860;
	Fri, 30 Jan 2026 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769809821; cv=none; b=V5+RiEPDtXAJth97TSQOGXTOW0vNBrbOmtV4utNKNOZQGW19g8/Ac2OwpevhIAGAjF+KvUjv5euRLik4jVTJnAIbkYxa3cBp460CbmyYxkxD7dF3Cvdwb/cvsC9dVAwBe2YeJ6a0YpzpTwV5Zle1SRilhNENv3z8Rf9STZtqGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769809821; c=relaxed/simple;
	bh=GSma/sKKHn5GPT2YE4RR0N7FCQcq6kNiXVbod5Rx93g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EWG4puWHFNhEAkaHY90d0gFEPuu+wDT9UCLKJQq/TZ5nZyXF03iSLZvw02nBJA2GDj7C8i40Pm8LEhr4ThRISjNQz9BJ8y7ySVvgJSIzxyehgEjhz1xG0L7JIYuFkPgiv/obVuFkXdO6iLN2Vd6Y4EKE3Hen4vkAOSBY354Z9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4fTmsaG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4fTmsaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29A6C4CEF7;
	Fri, 30 Jan 2026 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769809820;
	bh=GSma/sKKHn5GPT2YE4RR0N7FCQcq6kNiXVbod5Rx93g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H4fTmsaGFfFd/I5AivGn7kCjyjfZ5jBYgC4KSEIwsIXrdQ7Yp/Kn1YAxGjvMG4VpW
	 ydOayniLiF19V3ehWK+WuPm8K+OZiCpLNu2UQBbZIiweXkshwFqQCwyOm0U+3mo6/I
	 SOOAzlhhwhCkt2ActGVPr5qGW7/4HKtrTjhMIjKTrshDy8Njbi1k28gdRXouRMMs4a
	 F2WgbsQ5QJuwYq6RATC4n+HIXlCwI5lG+UDaq2oB6HN2EsCI4mSLhNYFSkAZnoCvg4
	 uo0YeJgx57HtcFgi4ZOZtmVWNNkpugy23n5LgORtnELai9RlLzV3f++utP2HLkVbgN
	 G94MtKL8GFrsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EC0E380CFFA;
	Fri, 30 Jan 2026 21:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next 0/6] x86/fgraph,bpf: Fix ORC stack unwind from
 kprobe_multi
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176980981310.3903231.8224581222051574017.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 21:50:13 +0000
References: <20260126211837.472802-1-jolsa@kernel.org>
In-Reply-To: <20260126211837.472802-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: mhiramat@kernel.org, rostedt@goodmis.org, jpoimboe@kernel.org,
 peterz@infradead.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org, yhs@fb.com,
 songliubraving@fb.com, andrii@kernel.org, mahe.tardy@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 26 Jan 2026 22:18:31 +0100 you wrote:
> hi,
> Mahe reported missing function from stack trace on top of kprobe multi
> program. It turned out the latest fix [1] needs some more fixing.
> 
> v2 changes:
> - keep the unwind same as for kprobes, attached function
>   is part of entry probe stacktrace, not kretprobe [Steven]
> - several change in trigger bench [Andrii]
> - added selftests for standard kprobes and fentry/fexit probes [Andrii]
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next,1/6] x86/fgraph: Fix return_to_handler regs.rsp value
    https://git.kernel.org/bpf/bpf-next/c/8bc11700e0d2
  - [PATCHv2,bpf-next,2/6] x86/fgraph,bpf: Switch kprobe_multi program stack unwind to hw_regs path
    https://git.kernel.org/bpf/bpf-next/c/aea251799998
  - [PATCHv2,bpf-next,3/6] selftests/bpf: Fix kprobe multi stacktrace_ips test
    https://git.kernel.org/bpf/bpf-next/c/0207f94971e7
  - [PATCHv2,bpf-next,4/6] selftests/bpf: Add stacktrace ips test for kprobe/kretprobe
    https://git.kernel.org/bpf/bpf-next/c/7373f97e868a
  - [PATCHv2,bpf-next,5/6] selftests/bpf: Add stacktrace ips test for fentry/fexit
    https://git.kernel.org/bpf/bpf-next/c/e5d532be4a3b
  - [PATCHv2,bpf-next,6/6] selftests/bpf: Allow to benchmark trigger with stacktrace
    https://git.kernel.org/bpf/bpf-next/c/4173b494d93a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


