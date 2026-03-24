Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE7364E95
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367430; cv=none; b=YgJj2V0VPyu5lSFjAjDPwI9nrWNGpDN5Vwm1S8dm97muWrWQtWyUfs/ZRK8vp0u2eLGV5quPoZV0fAuhENvokYeXb1WHfh6D3CWinlN0QcYz3ONmxihcWGoqWcC0VmGyhObcR4O5v7PY4htcJw7t5CqQ8qeXsOQB10Psqg4uYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367430; c=relaxed/simple;
	bh=Ai04wbPHVyJ3Yh+ZC8l0WB7tEyzSLOmXyo8fBm/UkVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=galWiTpgeqMjvC0KcFXz4XTJ6lD6/bGuydTv9x3KJRj4fVh+eCp4sxXmlT0xfAcT8kitcZmZNP1r+hTCD3gh01e0B8n5eSk7ybAUd1PXqI2O3Scl+ky2QxnwXsHzrTgQCDl9l4ZJmFVVICHYgTiCnhTUxslJ6qfhZAhgdTsn8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LERf5cyg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LERf5cyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316EAC4AF09;
	Tue, 24 Mar 2026 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774367430;
	bh=Ai04wbPHVyJ3Yh+ZC8l0WB7tEyzSLOmXyo8fBm/UkVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LERf5cygLGjWM29+zv8OoOkVGDdFTlHsGWFSr8+sLRpvGIZXPVN9fMmY2K1F8sKsP
	 hZvG/ohLnq2SCfO5vRDrzicPieNygPtYQT/Bzv0APnxM+8s55I61g9GyD1UMO3elQL
	 5ZSMOKiHNdcUTXqOM+RIFVmgrImjZPT4GOl4Q1VKvSh5RsPEyCmJ6l9Az6CuAQVtG8
	 +o55HEnRRFqTb8vYLjhmJWVEivs502rtcHzHbyxoorA6P0R312SPL58IbmeohY0r2S
	 KecW3/gQewzGM4+KdTe3zX7OrCjIZG8DiA6sKKXOGnLF3UZC7Vt9HZ/8sXA5Bdgw8i
	 xwJUcOXj85z1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE633808203;
	Tue, 24 Mar 2026 15:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 1/1] selftests/bpf: Fix compiler warnings in
 task_local_data.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177436741779.1084685.5302847763304176383.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 15:50:17 +0000
References: <20260323231133.859941-1-ameryhung@gmail.com>
In-Reply-To: <20260323231133.859941-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 23 Mar 2026 16:11:33 -0700 you wrote:
> Fix compiler warnings about unused parameter, narrowing non-constant
> into a smaller type and comparison between integers of different size.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/task_local_data.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf-next,v1,1/1] selftests/bpf: Fix compiler warnings in task_local_data.h
    https://git.kernel.org/bpf/bpf-next/c/03b7b389fe88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


