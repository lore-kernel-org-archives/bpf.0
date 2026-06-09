Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877534105B;
	Tue,  9 Jun 2026 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020893; cv=none; b=IJWJnwZBWzMyXq6XGKmPVRJ5BxMnSH1vL4F7dlbfwae57i62oYnVToNTe8x9W1s3+XJVSutjrAgq35jdSUvA+/Zaq0UKmXqNzpfojpj7wm/upBHjfnUoTRHbEPlg1Ec5w+QMEvyO3E7HLxUvhUduKJAf53dnBM1nDiSwb8DimVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020893; c=relaxed/simple;
	bh=ZUbyWpnLg3DX0UgwReg524QIkRAp88BMWw6ls7/4pZw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qYVTp8919ipIpj3lbmW7Ka6QeR0VBtEkyImts3GSUuLl6TXXaNEVHUMqw62LyqAsWBDDg67a00OZoUvzMljt0uyRY4/kW0RF3+N/i9MflsFWwzYITMTWi/3kRDE/9fLr751Mhsve6GSVTPfcD44pux9gdntWeDjqJfiP6obTJLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jccfX2wd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jccfX2wd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CD71F00893;
	Tue,  9 Jun 2026 16:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781020892;
	bh=5PrBFUSOGmHifdFyy1etemAnUkFfem2BMX2OODSs4bA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jccfX2wd/mdi39gwgG14lQ9h/sP9rALOhDkQnZVDbogWQiKboWG8reivOhItGEX5E
	 tQ6XxreyD71myk4A4o/wxWZD3q86XZUqkqzGQGaPlnGEmsFW34eSyyAQc9WNY37gNz
	 N0LS90/19EKDZXWROk5bbyM1yFx9padNTmn/PiOP8+7l2ud5BsYqO/e6UNvAGhIajT
	 eYre41O4SZk81LdGfKi2U2LlFq8sBWIyU1idogHrcVYp+TKZAm+++0RYcvVnNsNvqN
	 HnG+5dRRCHoPYTPYBtmOi/pjejnRLpR3w0KjcLG0mdzcmp0aPBESzn4RJViCaZrUQw
	 Nld6Xk18cjFAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B18393091D;
	Tue,  9 Jun 2026 16:01:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: Enforce BTF pointer write checks for
 global args
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178102089039.2105069.12169119537576635643.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 16:01:30 +0000
References: 
 <20260609-f01-04-btf-writable-arg-v1-0-f449cd970669@mails.tsinghua.edu.cn>
In-Reply-To: 
 <20260609-f01-04-btf-writable-arg-v1-0-f449cd970669@mails.tsinghua.edu.cn>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, john.fastabend@gmail.com, eddyz87@gmail.com,
 memxor@gmail.com, yonghong.song@linux.dev, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue, 09 Jun 2026 22:43:49 +0800 you wrote:
> check_mem_reg() verifies both read and write access when a caller passes
> memory into a global subprogram. For PTR_TO_BTF_ID callers,
> check_helper_mem_access() currently always checks the access as BPF_READ.
> 
> That lets a tracing program pass a task_struct field pointer to a global
> subprogram argument typed as writable memory. The direct field store is rejected
> with "only read is supported", but the callee is validated with a generic
> writable PTR_TO_MEM argument and can store through it.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Enforce write checks for BTF pointer helper access
    https://git.kernel.org/bpf/bpf-next/c/fa75b7c85b0d
  - [bpf-next,2/2] selftests/bpf: Cover writable BTF field global subprog args
    https://git.kernel.org/bpf/bpf-next/c/af8c3f170f73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


