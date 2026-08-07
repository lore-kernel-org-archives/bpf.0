Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C182F30;
	Fri,  7 Aug 2026 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786143059; cv=none; b=Fi457dWOlDmXRCTodnviJWAZY/MC1Bfc+kJYWB22k0NrZOgttJnL6No8vNYxsq+5xFv7a4PGpABdosjvZk/PiSbihoFiEt/q0VNC7cxtOlLoak0rgB+0wWzvLPVqh7b3uyYN9IUXRqsf9zB5BW3jX62mKlUVxDvTLgQ5JGVp5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786143059; c=relaxed/simple;
	bh=VeuRcAmobwZiWUzuEPai4P2mHmegSSauMujXjG5LCYA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DHRjFLn6XRmUEKrxIXFtl6KKJPHGsMPXy8HFwJ2Vxhf2Ptdd4mmnA8j0WiD5+YX806I0LGaTtfCdD1g9B0+foyJJmGvCbI55iZw5burj0W7s0p92arn5buE1X99XJGs0MNUnY1GbEOtXVN2pf3TB/5sLLnVb1lOzyUSs/H+WikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHE7KcG7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHE7KcG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B271F000E9;
	Fri,  7 Aug 2026 22:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786143058;
	bh=b6jraoRloGXuCQya4sCtCNvzLdlYdYZd5F6GInK3IWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KHE7KcG7YlNzbRE1zzQJfwMdJ0QsiLvuOMcviVyHbi5xsimnk28Ba68VYN9qWOft5
	 JlOXD8jktPYk/16Of90gjt+eMHk/FypEOfZY57o6dTcBw507o29MyGrIbNQrR3swZ6
	 xmq+0mJsSjvE14SJpz3a/HJQE2zK6UCcw9BqGTuj5OZVNul86phLIwkbU00HFAvXOd
	 1KDr+wzFPV7MOHvQ7YbJwoh3Ra5GUUO1sInCe5e+5WkpO9Bx/pSbOFPt8VAgm3TgWr
	 Ch/0keCWxPMpylkin8441nOp6g3NDGvboFAcXohpN7ZvLCIwpF6V9Ev9XHzzYQhOBQ
	 FsL05rBd8Z4GA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A55380CEF9;
	Fri,  7 Aug 2026 22:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v6] bpf,
 cgroup: Fix storage null-ptr-deref after replacing prog
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178614301665.2448714.16771338876998687568.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 22:50:16 +0000
References: <20260807104403.1013064-1-pulehui@huaweicloud.com>
In-Reply-To: <20260807104403.1013064-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, andrii@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, yonghong.song@linux.dev, song@kernel.org,
 jolsa@kernel.org, emil@etsalapatis.com, ameryhung@gmail.com,
 pulehui@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  7 Aug 2026 10:44:03 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Syzkaller reported a storage null-ptr-deref issue after replacing prog.
> This occurs in the following scenario:
> 1. prog A, an empty prog, is attached to a cgrp.
> 2. prog B uses BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE and calls the
>    bpf_get_local_storage helper.
> 3. link_update is called to replace prog A with prog B.
> 
> [...]

Here is the summary with links:
  - [bpf,v6] bpf, cgroup: Fix storage null-ptr-deref after replacing prog
    https://git.kernel.org/bpf/bpf-next/c/3f562c537e9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


