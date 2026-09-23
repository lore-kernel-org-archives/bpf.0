Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF7C34D382;
	Wed, 23 Sep 2026 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129478; cv=none; b=i8JHbEH3zwd4UFr5D/IdPmrPO7UERcQMr9mkdcV80XBqQRKyTnyKxFZ22pikVuGyzX8THB3grGkIOhkiiQc5Dl1L4nr2EP6+XwoaUdlSgXEGgAFMA82liX2zVWTT0hj+L6QdtIgDzbbALs3kuOj817XYmk2LW9pnxyMwM4wXWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129478; c=relaxed/simple;
	bh=idgMeQkolLxrBKlHTfh0UDxVONy509qU1OR0hdN1pNw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CEKqlD/VdMZzrQJiZpqsMKTNhN70ehgsujEFhxBqPWhQDMRSG9iE+4sHu5nwOpUfuQo3YXCRlzDrX5FqO4pGqGfUBilLpwoBjyrF6T/Dc0ZKK61pqgmRR9Of3H/CcqOALZJORTerKRkuAKOfgr+l+aVHpKrdkAqIeQG0zSXx2gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVLP4OIj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVLP4OIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F2A1F000FF;
	Wed, 23 Sep 2026 02:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790129476;
	bh=72o8XdeHOO0nvYEC27EwUle5PwfmgPHOTqUbse1xuP8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cVLP4OIjcQtBEQk4Kd7+/s85av0NOiwTscc85yH5tqVX7K142j5D8jaR0MXKkNq4a
	 bwoYZYF7dmvafW82Uycjl3ljoT1WBIHz/mSyzY/qPwHSjy99EB4w4ycF1UTR0NP7Xi
	 0TaqE4VaywsWORTsYkAJo1FugkE1Dw+f3espJKC0f+1Q48bIFmLAqW7P3Ujtfn/9az
	 gy3wRPtlQN37Oi923oZrlOUk6c+z+zymweTSXAlmgwr+pqW6VmHrQBhNC88m1ULN22
	 P30hTLlstZwRkWum1IRuMuzRR8iu9EXSHFE2fWPecCNYits1qR6qFAvy9szm4k1AAB
	 O7HpRJvnPtHWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A343924472;
	Wed, 23 Sep 2026 02:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v9 0/3] bpf: arena: handle memory.max on fault-in
 with reclaim
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012940739.177114.1298290865811499101.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 02:10:07 +0000
References: <20260922101831.192102-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260922101831.192102-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 22 Sep 2026 18:17:32 +0800 you wrote:
> Since commit e66fe1bc6d25 ("bpf: arena: Reintroduce memcg accounting"),
> arena pages are charged to the memcg of the process that created the arena.
> That exposes a problem in the arena user page fault path: the fault-in
> allocation runs under arena->spinlock, so it can only use the non-blocking
> allocator, which never reclaims. Once memory.current is at memory.max the
> allocation simply fails, even when the memcg is full of page cache that
> could be dropped right away. Reaching memory.max is completely normal for a
> healthy application - e.g. reading a large file fills memory.current with
> page cache - and the process then gets SIGSEGV on a perfectly valid arena
> address.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v9,1/3] bpf: arena: allocate the fault-in page outside the lock
    https://git.kernel.org/bpf/bpf-next/c/c7cd8be3d72f
  - [bpf-next,v9,2/3] selftests/bpf: Add read_cgroup_file() to cgroup_helpers
    https://git.kernel.org/bpf/bpf-next/c/a781db31b484
  - [bpf-next,v9,3/3] selftests/bpf: Add a test for arena fault-in under memory.max
    https://git.kernel.org/bpf/bpf-next/c/1fe5a5cd01e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


