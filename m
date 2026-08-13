Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ED22F7F13
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582260; cv=none; b=C5erVsOvb8LRrkJ7HkwZ3sirVQ4JNAgDjFNGuJLBz6uzkL2gDnWf6lGtGoekPwGg/lRRRvN4oTHRuEIvY0miYiHOHvqvEp+JzUi7Z5aDghE7aqyPagHiDw09zz+ZF1V50t0vpsqkC6SsvMtiKwxliAcY/FeXUp0i810/+yQjDOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582260; c=relaxed/simple;
	bh=hOoXX07XZA+K6iaDTcyUi0QLgmfBPhP/qRTf85PqfKY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qk8MzRrLkMKVO0x43JdAFjBhP1mKfY4i6hDEO46Rz5XCOmlEHKj6GqK5J4nsSU9Lbcbp6p5cYecWa/sYbgvIjPZUZXPVfadfYtZ1LU7hJ8hUbgJx48CDXN8IifSfW1/2ti7VV/sGWAfnm0JT8VSqyOStWby/JpdtBjHqP5YV0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7FwZhAC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7FwZhAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706921F000E9;
	Thu, 13 Aug 2026 00:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786582259;
	bh=3FyZSWVAjzrwvgbSkaGI0Hltcr87y6FPJTVk5dnuv2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Y7FwZhACEgFVCg3kXcdw6SZV8VVpWAr2RmF519ugz0TLkwzeAwj3+A5wbTKMdDhiD
	 49qx/Z9jaZnQAXfiGQ2r+A6opmxo/TeM4eu5+uSxFWg0EqA5bdEeqgeaZU6IN5DQzL
	 +NBwna6bR1joWjhpSVjAKGKeEfIjfYddYFeE/iWCHFDhZ1LwctuOIPY2Y+RrOmYBYZ
	 uKL2UzyLw+X7SEDY/Mc9wFj6PcmxAGRdeY06zmxuix/ELjhuZ96bg+ig0gAb/vGxS/
	 vloi4BSiPNtFru06SMhjnCyci7USpCj7PNCzOEJXcR1xPhQCq50wbdEu03UaYzmLaw
	 sGmfu4XCusH2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A86380CED0;
	Thu, 13 Aug 2026 00:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v8 0/6] Improve stack depth verification stats
 output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178658221464.2168272.5125774255091198511.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 00:50:14 +0000
References: <20260812221925.3358041-1-memxor@gmail.com>
In-Reply-To: <20260812221925.3358041-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Thu, 13 Aug 2026 00:19:17 +0200 you wrote:
> Some improvements for more clarity in the stack depth verification
> statistics output. See commit logs for details.
> 
> For example, ./test_progs -t subprogs/subprogs_alone loads prog4,
> which has a main program, two static subprograms, and two independently
> verified global subprograms. A sample run produces:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v8,1/6] bpf: Track verifier instruction stats for each subprogram
    https://git.kernel.org/bpf/bpf-next/c/14c950ac2be8
  - [bpf-next,v8,2/6] bpf: Attribute async callback instructions to verification roots
    https://git.kernel.org/bpf/bpf-next/c/6137fb7c5f83
  - [bpf-next,v8,3/6] bpf: Show more useful info in stack depth stats
    https://git.kernel.org/bpf/bpf-next/c/c2e6c7de8830
  - [bpf-next,v8,4/6] selftests/bpf: Adjust veristat stack depth parsing
    https://git.kernel.org/bpf/bpf-next/c/502686233493
  - [bpf-next,v8,5/6] selftests/bpf: Test stack depth stats without BTF subprog names
    https://git.kernel.org/bpf/bpf-next/c/b961cf317100
  - [bpf-next,v8,6/6] selftests/bpf: Test subprogram instruction statistics
    https://git.kernel.org/bpf/bpf-next/c/5cb481e1391a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


