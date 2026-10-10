Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BBC376A0B;
	Sat, 10 Oct 2026 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791650409; cv=none; b=ePeZ1b4UG45uZwiubfCpEmWvq7dswj1YaWmODNV8TjODlB90jPbeMVIJpmzgSZHjui8znaWY6paKnn9H15+y+t4YR3TEyMpX/QGw1WAuOLhCnRehir0TQzp4aQliq6vpP5Wtq1PstH7rhRBQYM2rDELX+FQWLEhReos43KOe/2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791650409; c=relaxed/simple;
	bh=W+rXmx71uElXmbjWgC7Q42fhpg1QDwyieQ/twAh+bf8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EcJoiCEPDc5BMixznKoCHlDN2bNg2S4mAPdO4iE+hCt9r363y3DR9dTiQ/wGFN6ZuBQ4Re3xN/yOc6tP/e8+yMugRd2tq3FuL/sflisM8qZVbE0705IFK6pMOd4+Ycjdz7arcWK4hUo8eIRkc8X7MlC5icFUkWvnX5XckvzaDb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AR9Mn8JX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR9Mn8JX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BF31F000FF;
	Sat, 10 Oct 2026 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791650408;
	bh=4UN5NAnx8hlvcuEwnHYSkiLlpT4gcUYPFfjfL//rXvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AR9Mn8JXqVJgLzzkz0Pjnhepkf5CB7BWGn0TKoa10Jyuojlog0hRy/wt0ekKN23yk
	 ENEj4YYcAC3cS5wFHokwCiznE+Sb3wf0bSMLblNooGpJXkXTbSze/39MeV3ea7Ba+1
	 iYqSIzCANn2Xf2LLCXB12SlxIoohjXQEF9hCCQyLUZi8y/rcyfYNy/JTq7brwrXGYn
	 1bFTfJhMA7Z9JdUi/iDToEj1roGfsZSgKmqBk1uhptNPeUkK/aP7JgLhHcNsOmtjyi
	 pKI3v+5m+QPYykiJHkqN+u5q3ikrLzlzFPmAVkkwHqZIDTWau//l5mNLoV3YJM8GU4
	 oQkjzNTwDD3ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A1EC38111CE;
	Sat, 10 Oct 2026 16:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 bpf-next 00/10] bpf: Add bpf_tcp_ops hooks for TCP
 AutoLOWAT.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179165040702.1772634.14891087593048357727.git-patchwork-notify@kernel.org>
Date: Sat, 10 Oct 2026 16:40:07 +0000
References: <20261008031604.256498-1-kuniyu@google.com>
In-Reply-To: <20261008031604.256498-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 ameryhung@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com,
 sdf@fomichev.me, edumazet@kernel.org, ncardwell@google.com,
 willemb@google.com, ukyab@berkeley.edu, cleger@meta.com, kuni1840@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  8 Oct 2026 03:15:20 +0000 you wrote:
> This series introduces two callbacks for bpf_tcp_ops:
> 
>   .enqueue_rcvq(): invoked when TCP stack enqueues skb to
>                    sk->sk_receive_queue
> 
>   .dequeue_rcvq(): invoked in tcp_cleanup_rbuf() after data
>                    is dequeued from sk->sk_receive_queue
> 
> [...]

Here is the summary with links:
  - [v5,bpf-next,01/10] bpf: tcp: Convert deny-list for bpf_{get,set}sockopt() to allow-list.
    https://git.kernel.org/bpf/bpf-next/c/114ce944d015
  - [v5,bpf-next,02/10] bpf: tcp: Add a new per-socket flag and kfunc for bpf_tcp_ops.
    https://git.kernel.org/bpf/bpf-next/c/4e2385abecb0
  - [v5,bpf-next,03/10] selftest: bpf: Use bpf_tcp_ops_set_flags() in bpf_tcp_ops_hdr.c.
    https://git.kernel.org/bpf/bpf-next/c/ca577d08f88b
  - [v5,bpf-next,04/10] bpf: tcp: Guard fast-path bpf_tcp_ops_call() under per-socket flag.
    https://git.kernel.org/bpf/bpf-next/c/59c25bb6759a
  - [v5,bpf-next,05/10] bpf: tcp: Check BPF_SOCK_OPS_TEST_FLAG() after cgroup_bpf_enabled(CGROUP_SOCK_OPS).
    https://git.kernel.org/bpf/bpf-next/c/c071408db308
  - [v5,bpf-next,06/10] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
    https://git.kernel.org/bpf/bpf-next/c/32d17fe8a9a5
  - [v5,bpf-next,07/10] tcp: Split out __tcp_set_rcvlowat().
    https://git.kernel.org/bpf/bpf-next/c/dcddae18f512
  - [v5,bpf-next,08/10] bpf: mptcp: Don't support BPF_TCP_OPS_FLAG_RCVQ.
    https://git.kernel.org/bpf/bpf-next/c/d65dc83603eb
  - [v5,bpf-next,09/10] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
    https://git.kernel.org/bpf/bpf-next/c/5f549c1e49f3
  - [v5,bpf-next,10/10] selftest: bpf: Add test for bpf_tcp_ops.{enqueue,dequeue}_rcvq().
    https://git.kernel.org/bpf/bpf-next/c/11f1c0b8a43a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


