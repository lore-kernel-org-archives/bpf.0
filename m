Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FD740DFD9;
	Thu, 19 Mar 2026 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773879013; cv=none; b=HiWmN2ZjovKdl+1iN2sNyBKPFwzi4qC/dgYtgzmcAVapKzZLhu7+78YRvm74O5dErCsd8gTTsY+/vDBiZEqM0oQSr0sPy0mChZHU1LDZD5TpBxGvd1OU3XA/UD/xmeMJ45sIA2bcfl476bKQ0dgS6CfsHdv26oka52MO890d5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773879013; c=relaxed/simple;
	bh=q4tv+JV9ICJL12MUm6g90PG691GoeMpGEPGaOzsBGtg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G82NEka0IOYnTP+DhdPymufRrflQbZ7KxgBqZZlJLzV5Slmvvl8AkO/h8EvAyiu1gxR2YNpY6nmluW7p2jSjbaUDgcHhAx3IghCWOh2zaI1C8h/ptIS5ZupnSZ5QUG+9giMVgxoikhk4QiK0zkjuXS4S6MrZ55NC3PjDH3hDbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ek7YLPH6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ek7YLPH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68805C19421;
	Thu, 19 Mar 2026 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773879013;
	bh=q4tv+JV9ICJL12MUm6g90PG691GoeMpGEPGaOzsBGtg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ek7YLPH6PMUiwg6B1ua3PZjp9t8PD6G8GlD4Q8XhYpZDNLc94RwvQlGrigyazTSrj
	 +rS3D03/eLHwSIh31KYWxdnjeZHMwzk0B2S7n2tQAC+azpkNK3vemncuBDiSKZo0JR
	 z5tqfXCQ0DAdqeAO3xYFnBPDhBD7txROjGlAXDzoGqsehE/Gk2bb8nse+oCHc1/rpQ
	 f5OIMv1uPWLSLGFZU4F24gqzTf7F5Hhela/TNc0+kvlZa9sutI77WG3kFYmx4RzAU/
	 GoJ6hZT0hujoHQY/ZTgDrsDJ2iIV/hKkjtuP3A+Ejv+lZN2qruH8rjsIaA5Td++Cq1
	 jSYBqfHMuQEuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DF13808200;
	Thu, 19 Mar 2026 00:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: perf_link: avoid failures in
 concurrent mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177387900482.933372.15248536714965968634.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 00:10:04 +0000
References: <20260305084306.283983-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260305084306.283983-1-sun.jian.kdev@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  5 Mar 2026 16:43:05 +0800 you wrote:
> perf_link creates a system-wide perf event pinned to CPU 0 (pid=-1, cpu=0)
> and also pins the test thread to CPU 0. Under concurrent selftests this
> can lead to cross-test interference and CPU 0 contention, making the test
> flaky.
> 
> Create a per-task perf event instead (pid=0, cpu=-1) and drop CPU pinning
> from burn_cpu(). Use barrier() to prevent the burn loop from being
> optimized away. Drop the serial_ prefix so the test can run in parallel.
> Also remove the stale TODO comment.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: perf_link: avoid failures in concurrent mode
    https://git.kernel.org/bpf/bpf-next/c/888329ba6c8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


