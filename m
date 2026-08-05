Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65822DECC2
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952255; cv=none; b=buWMinejv8Se1G526e2MQQsXv4FtHt+t4XjiQJGZi5uzbGRmNkDaj6yyHTLcz/D29V4r3QmI/+YwtSfHdxNbEvXkTdEyU9JaOy2XH9Wb3REgr1+Yw0r97oAT3ISGUefPmh7Fu2MtOGtpam41FqUHwfcUYS/0S+YDjdtoTqNVnGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952255; c=relaxed/simple;
	bh=xU7EJDS6NlreH8t+QWe/2TMrS57lcdBFP78G6UvOW/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ANFwr5ERDEMnulELWiSc/31v4TxDf7/Pu++YKj9USRrFw26Jz184uHA2nitZV4dJhPh0p13XnQloRGZD/PZaoNG2GG1QMX8DjcH6gSoAQRXW1b6jrlVoD03z8esFkCazgvcjxHU1UqlOy8/tCX5rhu9kWdVUEaVo3y1oUYLz4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaWTzZID; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaWTzZID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53F71F000E9;
	Wed,  5 Aug 2026 17:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785952254;
	bh=rZewCEEXM/F8BXWl2KFrZszyCdJywWj1Jkb4hMSZSzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XaWTzZIDI10jnD025Ll838l5+0fUI7UzRqcz53VI9QC9vdJK4YjBDY9W9z9koF2zC
	 f5ey3r1eKX3+9I1E60gVY1h6qgu6HKf+2ix/auk4oUuD/ITJkaaEsLQoj5U735zO9M
	 mbWE41G1RYG67MN3xi9btiQ2wjEz79j3HFAxIi9V3bnl7BODseqgHZekKGH0R4NxGt
	 VzUqPTYSgMIhfWUpUh/foalticcs9qLb3ILKv/KrnXW1I1YKpdto8FyKQtz2J4eXW6
	 NgxfUrLxzjL+6WhmBey9YnGYjADGU6ChEn5rAozhZhWM0HlL6fRWPJ4k6SPrynOrBh
	 d+Bvx7ucwY6Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09E5392FFC3;
	Wed,  5 Aug 2026 17:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/6] bpf: Inline the numeric open-coded
 iterator
 kfuncs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178595221439.468918.12755390994472161307.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 17:50:14 +0000
References: <20260804134601.2305303-1-puranjay@kernel.org>
In-Reply-To: <20260804134601.2305303-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  4 Aug 2026 06:45:52 -0700 you wrote:
> The bpf_for(i, start, end) macro is BPF's open-coded numeric iterator. It
> expands into calls to three kfuncs: bpf_iter_num_new() to set the iterator
> up, bpf_iter_num_next() once per iteration, and bpf_iter_num_destroy() to
> tear it down. The verifier emits these as ordinary kfunc calls, so a
> bpf_for() loop pays function-call overhead on setup, teardown, and -- most
> importantly -- on every single iteration via bpf_iter_num_next().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/6] bpf: Correct the overflow check comment in bpf_iter_num_next()
    https://git.kernel.org/bpf/bpf-next/c/8efd87051c3a
  - [bpf-next,v5,2/6] bpf: Inline bpf_iter_num_new() kfunc
    https://git.kernel.org/bpf/bpf-next/c/f8f2b567d560
  - [bpf-next,v5,3/6] bpf: Inline bpf_iter_num_next() kfunc
    https://git.kernel.org/bpf/bpf-next/c/e93347704878
  - [bpf-next,v5,4/6] bpf: Inline bpf_iter_num_destroy() as a no-op
    https://git.kernel.org/bpf/bpf-next/c/39f047682fe3
  - [bpf-next,v5,5/6] selftests/bpf: Verify inlined numeric iterator shape with __xlated
    https://git.kernel.org/bpf/bpf-next/c/b829bc167705
  - [bpf-next,v5,6/6] selftests/bpf: Add bpf_for() benchmark
    https://git.kernel.org/bpf/bpf-next/c/5a1de41147b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


