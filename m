Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4F5F87D
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127430; cv=none; b=Tdl5b72XR4nQwFVKlXptv8jQAoS/eWbqejBW2A6p9mtut+i+N92TCOt1mc60KUecGyxEIMQVHK9wtbBYXqTGYR/Qv0LPJy+pi5hrUCzfHlsatMN9JTYC7+rNecd1pelZuUQUfG6laT1eDe1HWynJeIl+5Kp2StyTQNrMEOn/pKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127430; c=relaxed/simple;
	bh=jUtGpnwSlYMviVqgzxLDbgqKQFsf+PANgqw3j/8YrK8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BhuYr4bXa3q1qHXeSGqmL2X6eiFeN3KPvGBSPCGSD+I0OfdLqNVQsuYbl/vtLWUz5zbpiIawcY0Gi6SyuRwdOMgCp9sFwIVSqfvZBRZVw84XJx4YVEO7iEFpf/Ni9ndKuBmfZIwjak6PCT7ldc8oAjvO9RzGwaRWHybH/jTy53M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBHMAnWE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBHMAnWE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8823C43390;
	Fri, 22 Mar 2024 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711127429;
	bh=jUtGpnwSlYMviVqgzxLDbgqKQFsf+PANgqw3j/8YrK8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DBHMAnWEKDQw4V/EvCSx85DDYwOc5C9Zg0cPesxRXuvNao9Y84uqeiM4lXI6LnAn6
	 zDOCkJ/RPDrbNcArwoWkyJ/P3PyhFku8vuW6vdv/AP2tcRyV3E7UOzt68QyO0Is4mE
	 xBP8hCT5v7zcho1WCz/CqA8VGfFl3ZM1fF6JGQL5ZJW9+piSVLZcCzsbm1I4RBQ6Pn
	 vEeWCSpGnLFITgaOD8Es8v8+Gq9DY6msA2ahBTqivhGK4hX2axGeXAMGG7mgt7os7a
	 p4NPHFHX5ATgbAAIEVI8uceDeVwzDYxzp/zqGmSfD7onv1eqlRXWJ6AW09zqEMN5r7
	 Og2ZmdtQtuSPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A78ECD9505B;
	Fri, 22 Mar 2024 17:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bench: use syscall(SYS_gettid) as libc
 support for gettid() is sometimes absent
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171112742968.3285.2618428112557964907.git-patchwork-notify@kernel.org>
Date: Fri, 22 Mar 2024 17:10:29 +0000
References: <20240322095728.95671-1-alan.maguire@oracle.com>
In-Reply-To: <20240322095728.95671-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, houtao1@huawei.com,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 22 Mar 2024 09:57:28 +0000 you wrote:
> With glibc 2.28, selftests compilation fails for benchs/bench_trigger.c:
> 
> benchs/bench_trigger.c: In function ‘inc_counter’:
> benchs/bench_trigger.c:25:23: error: implicit declaration of function ‘gettid’; did you mean ‘getgid’? [-Werror=implicit-function-declaration]
>    25 |                 tid = gettid();
>       |                       ^~~~~~
>       |                       getgid
> cc1: all warnings being treated as errors
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bench: use syscall(SYS_gettid) as libc support for gettid() is sometimes absent
    https://git.kernel.org/bpf/bpf-next/c/1684d6eb99e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


