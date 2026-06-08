Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7EF374190;
	Mon,  8 Jun 2026 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920016; cv=none; b=joAHwIFeu5GlNTKDYHis1JtBjXnIMe7g9oEEjEn0/GcTDdWtW0RNnkOGuaV8Kgg0G5TgjDNU7XfWKeiQYryps7gjvJo8cDxBasD3Y7jkQ0M49AnDBfkNPB0jN/ehk9sSHAFkOSFdTBr2UMaVxkuODh3m1J/268NM7jY6jYf59wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920016; c=relaxed/simple;
	bh=RTbexiDmA0k6WhMICkfZFgn5eSdOkppo7Y8ZAANHLzw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AzINmcZike2SCfy/zQNKVE/2aXXKLnKWdzkr4uAHELz9cdb6zu3yw2cNOHAPloXyv04AVUlxJIF+gdKDDsXXTIFtfi92k+CZ/XxPaPPjv/scZ+EHq9eVDhHf/LNpm3m7BZEpIJkdtndWalQE9wI+HaOr3aR+GI9JUYSPEg5sxSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFGM8N3r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFGM8N3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6729F1F00898;
	Mon,  8 Jun 2026 12:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780920015;
	bh=qsD2oRjrCcrZPKdGTJvv1+6WcUONRfvZ5mjhjjBqDGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VFGM8N3rK6zrSAQuAfzB01hk0Vrc/IL15oNCw3zoNeEO5ra97Ao9lqwYjLcMUjkjl
	 jUEAgatoAJ3IdnY6NzLfvpNi6XtWws//FsRpBpei9s1CtyxUQXfrjjKMXeVdCASgzm
	 B1rBThf/6gLi2Sc05qFy8Q2UGo0v1tNIoV42ovzqYVUMdQZ6gUFsLPESxJOL3ffzg7
	 tZVs4EfbHAulP+7hEw1oyNPOQaFd1Dle4VfRcr2Nip5oR0tI4WqiLIkwKS8Hz8Pi8Y
	 oaCnLs70laMvqh7KrVqcZeaUQ18TedTo0ICPceSjSzsjJHKSx7DUG3wrow6wfQ8c+j
	 1E/10Q8C/Utrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4A3930D69;
	Mon,  8 Jun 2026 12:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4] bpf: fix NULL pointer dereference in
 bpf_task_from_vpid()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178092001415.1007295.3281904800740524491.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jun 2026 12:00:14 +0000
References: <20260608050001.2545245-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260608050001.2545245-1-rhkrqnwk98@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, juntong.deng@outlook.com,
 leon.hwang@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon,  8 Jun 2026 05:00:00 +0000 you wrote:
> bpf_task_from_vpid() looks up a task in the pid namespace of the
> current task, via find_task_by_vpid():
> 
>   find_task_by_vpid(vpid)
>     find_task_by_pid_ns(vpid, task_active_pid_ns(current))
>       find_pid_ns(nr, ns) -> idr_find(&ns->idr, nr)
> 
> [...]

Here is the summary with links:
  - [bpf,v4] bpf: fix NULL pointer dereference in bpf_task_from_vpid()
    https://git.kernel.org/bpf/bpf-next/c/50dff0061552

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


