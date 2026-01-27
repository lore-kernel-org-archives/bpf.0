Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8972612;
	Tue, 27 Jan 2026 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534415; cv=none; b=QQZj5T8QJrNP4vkjMXwkDzW7zxsz8qgbtY2YpAnSJhiqqlRpqg9Oyg5NpOeKJ4nOD1Qzz4vtCS63BFZUZAGJRRmAcRBqfBa5Bssy6h/MnSBUYBxarD7m9MIF2wVeiRXgSVzkNh/E4eKgheekqkTm6SubFPewAQ4IgMeLVyxUdTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534415; c=relaxed/simple;
	bh=xEWpUH0GpFu3Wi9qJlzazmweNqVVJJNm17C9pi8TVfQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l/uFiG6lUZLzRqqGUxLVGUvxnOd9y4UtE+PicdrTRDNUbLHCYav+LOT+ZgYmzO5G5OnO40YoXxt/6BSCNiiVvb9UR2FLUF2h3z5Alca6gR1Rb8P5jgsm/1730X6D2pqbUp3mRoTlsoVWU0tGJGtfduKbfUlYwf5CVaealJHVy+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCuuFT7E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCuuFT7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE4AC116C6;
	Tue, 27 Jan 2026 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769534415;
	bh=xEWpUH0GpFu3Wi9qJlzazmweNqVVJJNm17C9pi8TVfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YCuuFT7EgCzIVS+i2WYktxKB2uZWZHPMT1q1wJ3HB32Ojc/wBLH1iHzSWKsDx1ehS
	 gw1Mu0P6lbJXIWL9Q9hBQ68MBY/XjPKYgtclMgsiIvVnso9tvF5DmlfvgDB7NdGyFK
	 j6AWW23g64GQR7GZsloBUDgXBPM5zzecWllA6+3cVy04kD0VG1w+ie91aXPoz4Gtpa
	 moMzSs0APuPQZco90Xgp9J5cB9nxzxAT1AvSwbXZLa7qAeeUV/9fkjO5eS74FQLwxK
	 Kw7K4XifJ/srjSCD8Kf54F7sTHYAAh7XKTyHK2VD29kNCz3zPGVza198x8tIdkYZ0C
	 5YG28mAdm6mtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EC8C380AA58;
	Tue, 27 Jan 2026 17:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v9 0/3] bpf: Fix FIONREAD and copied_seq issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176953440910.945615.5240442156824844283.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 17:20:09 +0000
References: <20260124113314.113584-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260124113314.113584-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, ncardwell@google.com, kuniyu@google.com,
 dsahern@kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, mhal@rbox.co,
 cong.wang@bytedance.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 24 Jan 2026 19:32:42 +0800 you wrote:
> syzkaller reported a bug [1] where a socket using sockmap, after being
> unloaded, exposed incorrect copied_seq calculation. The selftest I
> provided can be used to reproduce the issue reported by syzkaller.
> 
> TCP recvmsg seq # bug 2: copied E92C873, seq E68D125, rcvnxt E7CEB7C, fl 40
> WARNING: CPU: 1 PID: 5997 at net/ipv4/tcp.c:2724 tcp_recvmsg_locked+0xb2f/0x2910 net/ipv4/tcp.c:2724
> Call Trace:
>  <TASK>
>  receive_fallback_to_copy net/ipv4/tcp.c:1968 [inline]
>  tcp_zerocopy_receive+0x131a/0x2120 net/ipv4/tcp.c:2200
>  do_tcp_getsockopt+0xe28/0x26c0 net/ipv4/tcp.c:4713
>  tcp_getsockopt+0xdf/0x100 net/ipv4/tcp.c:4812
>  do_sock_getsockopt+0x34d/0x440 net/socket.c:2421
>  __sys_getsockopt+0x12f/0x260 net/socket.c:2450
>  __do_sys_getsockopt net/socket.c:2457 [inline]
>  __se_sys_getsockopt net/socket.c:2454 [inline]
>  __x64_sys_getsockopt+0xbd/0x160 net/socket.c:2454
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [bpf-next,v9,1/3] bpf, sockmap: Fix incorrect copied_seq calculation
    https://git.kernel.org/bpf/bpf-next/c/b40cc5adaa80
  - [bpf-next,v9,2/3] bpf, sockmap: Fix FIONREAD for sockmap
    https://git.kernel.org/bpf/bpf-next/c/929e30f93125
  - [bpf-next,v9,3/3] bpf, selftest: Add tests for FIONREAD and copied_seq
    https://git.kernel.org/bpf/bpf-next/c/17e2ce02bf56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


