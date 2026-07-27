Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767FD3E316B
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192643; cv=none; b=SJQqORCkPzMG2GqBUDzqCjXwf9ODcYjFxeOG31CfXwEjOdy2Le7cC0X9uL+km2RPGhsdQfHp9JMENPB+ZavqNo4aWbSYqj9jmZ+BNMkt2+9L8aFKRb9SDcl5Kfq1JYpi1qb8aJ5c6R8BQTMPBNtCWr/kWzAw7YVTggLaXubmsXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192643; c=relaxed/simple;
	bh=AfTpr9vnDA19bxT/fGAxc/ifU/yWbPPbRrGfegfpeEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CmDjJuny6gvVZzCd52Yonv6otoLYvD7l95x38zocE/hdbHAtZdVNNTA6r0Q8TI+m74u2vXk5SQvFKcgLWJYWUJvZAogCQkGGcYHBayGahBjD+XTs30OtvDwY9TmvFUPifT89sNnO7lNEPXgGrPYGQih3Z8SzTdr5mda1Jkzlbbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5AleIET; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5AleIET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC681F000E9;
	Mon, 27 Jul 2026 22:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192642;
	bh=msFw1XQqaycME55XU6aCdiRpitDitVcsEciPwyCxGtE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W5AleIETNxvzYYmwIzAbDh64P94TTwzMMxtIDNETgNDopbsdJIPEZntJvUAuqDgp/
	 Gu2VUQRYOkR93GFx4kav9d711oytD/k7/KHvqRlZDmKoCgvMprWHuYxQZx83cYuKRe
	 RtaJXazYFuYn8tChQpz0Jj4oova/mlp6s0m3iI+Cxj6ohuWc0mETHE7K1rzpYzpIMQ
	 ez52pFT0SY59wTiuDyf+0VCr4U9QBKKhpQJZt5Ikb3BjZWxdLjvWp2xmIHdI5Mq9kF
	 j7h8BQOP/BmkC+GQ7jQSgZlX0chQZh8uRHfoNsvT6Cbvz/7438ejlAFWeyAsuqe/Kh
	 exxE9J4E0IDgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 937C9380CED0;
	Mon, 27 Jul 2026 22:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/2] Open up res_spin_lock() in all contexts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178519260713.1445878.13477862582196438048.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 22:50:07 +0000
References: <20260724201634.3025247-1-memxor@gmail.com>
In-Reply-To: <20260724201634.3025247-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 24 Jul 2026 22:16:30 +0200 you wrote:
> Spin off first patch with added tests from [0]. See commits for details.
> 
>   [0]: https://lore.kernel.org/bpf/20260719113551.1294284-1-memxor@gmail.com
> 
> Kumar Kartikeya Dwivedi (2):
>   bpf: Allow bpf_res_spin_lock() in all contexts
>   selftests/bpf: Test res spin locks in tracing programs
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: Allow bpf_res_spin_lock() in all contexts
    https://git.kernel.org/bpf/bpf-next/c/59b9731addc7
  - [bpf-next,v1,2/2] selftests/bpf: Test res spin locks in tracing programs
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


