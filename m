Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB787080E
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769568611; cv=none; b=LUGVPIJX8RxcsKyI79IxS5aiUHOv8TkNyg4YHEA7Szz0i9ofg4Z1bDYw3ScX7Y+4I0qN0vSK+1+m4ep2qAbtfZk/GW/RXOP4YwrnKNISsggH0WVjM3lVjHZuRmeovRek/N3kI2I6Gmg3vMmMyutBNhx1cEen9o+tc4HUeJRzTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769568611; c=relaxed/simple;
	bh=WN4MiNMcYwJITJb2FccQtbpUs2P3Z12MW1kM6pDkVHI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PC6vRtZE2YBH1zshzkreBFp0gE5Hs3lVaYTO/XP9uoxt5Kwd9M/SAJQBiEc6HFobgYZHaUBYUHl3Fxy7ZnoxSn7FMD8IQuS8s445GSCOXwYTfkB/LU4xE/vyNlIiZfiOnWtFsGb+dUGatv/PHgt3E4WQCw/xiRfkE4xg1bqao0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMMO96Gd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMMO96Gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D374EC116C6;
	Wed, 28 Jan 2026 02:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769568610;
	bh=WN4MiNMcYwJITJb2FccQtbpUs2P3Z12MW1kM6pDkVHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tMMO96Gdt2aRhCu5KPAYzEYLh5C3z1ppfEBfxBrWZV4CjXZ3SU3Y+u+strVerlAhk
	 8VLHBBV1jhS8R27rsWq5VW5LQQKFWMioR/9rKRIX7KZqGz3NiLGZrl4x7OOyn7KXJW
	 V50J2FBShW8YCPgKgrVqMHf1ekBftPl8/T81+S07dkRc9xsM8s+Z6fBBwRpi/jG3Ll
	 fOqXGdkFJXYtneF380+DqUsKt9ogZ5KfgCSSl7AdB0GWJoXKQiAUbrpL3SGp8zdxiC
	 nTZXXFd+3ia0FJsM9PHROkTZjf9KGg7iDMvmYmYFqsXN2sua9iwCm4uvasl9VhZUOc
	 N6CPiLAEEsauQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8B2C3809A15;
	Wed, 28 Jan 2026 02:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v5] bpf: Fix tcx/netkit detach permissions when prog
 fd
 isn't given
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176956860461.1489558.7025980277858474466.git-patchwork-notify@kernel.org>
Date: Wed, 28 Jan 2026 02:50:04 +0000
References: <20260127160200.10395-1-ggonnet.linux@gmail.com>
In-Reply-To: <20260127160200.10395-1-ggonnet.linux@gmail.com>
To: Guillaume Gonnet <ggonnet.linux@gmail.com>
Cc: daniel@iogearbox.net, alexei.starovoitov@gmail.com, ast@kernel.org,
 bpf@vger.kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 27 Jan 2026 17:02:00 +0100 you wrote:
> This commit fixes a security issue where BPF_PROG_DETACH on tcx or
> netkit devices could be executed by any user when no program fd was
> provided, bypassing permission checks. The fix adds a capability
> check for CAP_NET_ADMIN or CAP_SYS_ADMIN in this case.
> 
> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
> Signed-off-by: Guillaume Gonnet <ggonnet.linux@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf,v5] bpf: Fix tcx/netkit detach permissions when prog fd isn't given
    https://git.kernel.org/bpf/bpf-next/c/ae23bc81ddf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


