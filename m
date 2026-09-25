Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1C4F6463
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370686; cv=none; b=hrN5d24pcgQq6qBQZYngGXlLcJdo3lpVMQ4wiXkxJA9Qb/js9KdAX2ZbOFDMUgwUW3+7UO9X8wlMEF2vNamrinFmpkGesUKLtiZBKFhIhgjybj/JEdbGogVD/5ZHas4Y+MEsqfCuRikPukgZOcEh4W3uoRY9ggBA4TaUkmjh7Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370686; c=relaxed/simple;
	bh=2lTqS5M9fuQw/jKoqyDP4FdK4nT/O17rhohY5I/qsuM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ojVLI8zBOVx9Aw9VY2VWaci8UhxDtc6c6eVnRIEcouHPyHSonqDppx8KDLcD4cZyYE/4mSsEm5929/J4fa+VqGR+4BBzQKKEJJiv4UMuA/xahf75t2/BWf56f0Sro5HsAkEY5wKxHegbkEntdQY3GSqPU74kDVAKGZW3NwBGh3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT8gqwH7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT8gqwH7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6B71F00893;
	Fri, 25 Sep 2026 21:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790370684;
	bh=EIGxXqzu550sANoiBZtFVwLuWa4VfhqMTWbjBncL9x8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UT8gqwH7pDez/aStvCurc0KHIXOQaessVmgwsbw1HLRBLcQ1C+gqPESY52GcFltUb
	 cIMQ33MXSRfzPKfriqkga8BhgSPA6TpEzkI4GHCqz+GB/+W2h/Lf6BDloQq6w+Zv2h
	 cvKdHbDpl0GPMPksQVhEwSEnq4cHS3vc5ErQK+3ZjXfkWjYK4dGJ7IsF6RMGr4K42l
	 DnhMsifdNrDfAYum55DTQtvkbQ0Bg6+jNuHpb27zEoyvNrKt29ncS55VIiR8bfh1IP
	 +o1lhLGU+HM7Rz4UXpNWNIG8d1kGGxQwCoHTNUhh/OH8XqYog6aKNpaz8jsRfi8Tb7
	 eaE6AayScq/HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56894380820D;
	Fri, 25 Sep 2026 21:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/5] File descriptor interface for BPF streams
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179037061189.3153796.7083515358565524632.git-patchwork-notify@kernel.org>
Date: Fri, 25 Sep 2026 21:10:11 +0000
References: <20260925045536.1480933-1-memxor@gmail.com>
In-Reply-To: <20260925045536.1480933-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, tj@kernel.org,
 kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 25 Sep 2026 06:55:27 +0200 you wrote:
> BPF program stdout and stderr streams can currently be consumed only
> through BPF_PROG_STREAM_READ_BY_FD. This requires repeated bpf() calls and
> provides no way to block for output or integrate with poll-based event
> loops.
> 
> Add BPF_PROG_STREAM_OPEN to return a read-only, close-on-exec descriptor
> for a program stream. Reads block by default, with an option for
> non-blocking mode. poll and epoll report readable data and report hangup
> when the program is freed, while allowing buffered data to be drained
> before EOF. Stream descriptors retain the stream storage without retaining
> the program itself. Waiters are notified through irq_work only when a
> publication turns an empty stream readable, as bpf_ringbuf does, so a
> program whose stream nobody drains pays for a single notification.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/5] bpf: Skip zero-length stream writes
    https://git.kernel.org/bpf/bpf-next/c/f17bedcd2951
  - [bpf-next,v3,2/5] bpf: Add file descriptor interface for program streams
    https://git.kernel.org/bpf/bpf-next/c/e831ff570908
  - [bpf-next,v3,3/5] libbpf: Add bpf_prog_stream_open()
    https://git.kernel.org/bpf/bpf-next/c/9054903ab51b
  - [bpf-next,v3,4/5] bpftool: Add option to wait for program stream output
    https://git.kernel.org/bpf/bpf-next/c/0abecacb4bfd
  - [bpf-next,v3,5/5] selftests/bpf: Test program stream file descriptors
    https://git.kernel.org/bpf/bpf-next/c/4e1d734651e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


