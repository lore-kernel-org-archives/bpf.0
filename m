Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4D272E56;
	Tue,  7 Jul 2026 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410627; cv=none; b=WxZartJpfqmOzvRZ24zVeowWGHBNY04K9tVeiwMOCJfPKR0Vdpx7b1wVvf2iuXF5Ws1Rm6T0t+MSEit805UI4f7XQUXFXg1j49kOazQR2cmjbkH60CpDP+bE7Is1gxDh35qG+88lFdNXyODIEJ9HZ2j+m3ejEvrqknXd0ktSkyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410627; c=relaxed/simple;
	bh=TVeh3sM4PAtVH+Dmy2qd6T/USNPySM6BFuZgD+fTHkE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GKF6N6JR1FQ+CQM85b4Oy4CQJW+WtN5wEJlh4ruRKEkStb8PL6HZCz2HXGl8vpBlw0ojPJF3ga24UrL4Si8G1gsp6WNQO5crFg3vaKmC7K/VII7/hMDXbcsueBoUzuIflpE5wEPdTi4aKXmKydYYaVelyFXIakNtQ+ywlFHizIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2ksKKSW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2ksKKSW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5576E1F000E9;
	Tue,  7 Jul 2026 07:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783410626;
	bh=YdtqUs65g04zLD1X0ivddRdcfBD37xDNz71Fr8By8eM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W2ksKKSWWOhuHG8OnXRafgAsr60XcRPlX5PHWBZtW/P1t2hT49hOvrhLyN4lfNapS
	 +ZIFHcll7HLj9m0n9w8xGIGS8XGbPnI0jE4EY9Lrg896TClYS5sMJmczHNaxhEP0Gn
	 RqNXlYrhAnqTQmQB019sGHXQigywZkj++yeU9spAgogfWbmDshz0hzu4tGVX3uEnin
	 6B3CnEKsnZv20Tr35lod5+4uhYnWFhGazzo1dAoCsJKK04s7mI9z5uWhdhHrll813Z
	 EH71+OBqyqI9Sh5Gi91KlIkc5fY9WWZDe6X0eawrOvVlpQEJyFAaccs48JfAU7v0Yi
	 X6YMcvGjaw96Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A2C3925455;
	Tue,  7 Jul 2026 07:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6] bpf: Fix use-after-free on mm_struct in
 bpf_find_vma()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178341060617.1406078.12554834845906004554.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 07:50:06 +0000
References: <20260630032543.3165720-1-sanghyun.park.cnu@gmail.com>
In-Reply-To: <20260630032543.3165720-1-sanghyun.park.cnu@gmail.com>
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: yonghong.song@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 memxor@gmail.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, emil@etsalapatis.com,
 puranjay@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 30 Jun 2026 12:25:43 +0900 you wrote:
> bpf_find_vma() reads task->mm and calls mmap_read_trylock(mm) without
> holding a reference on the mm. On a foreign task, a concurrent exit_mm()
> can free the mm_struct between the lockless read and the trylock,
> resulting in a use-after-free. mm_struct is not SLAB_TYPESAFE_BY_RCU.
> 
> For the current task, task->mm is stable. For a foreign task, pin the mm
> under task->alloc_lock and release it with mmput_async(), mirroring commit
> d8e27d2d22b6 ("bpf: fix mm lifecycle in open-coded task_vma iterator").
> Use spin_trylock() instead of get_task_mm() so BPF context does not block
> on alloc_lock. Reject irqs-disabled contexts and !CONFIG_MMU on the
> foreign-task path because dropping the mm reference is not safe there.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
    https://git.kernel.org/bpf/bpf-next/c/311e11cfbfbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


