Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3966B16CD33
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696015; cv=none; b=HqcZSyIkDLXQUXEh6DIK9ngQDV1Xx86v/qmoPCg9ieRqebV+PVjFJa7buxo8zlQ7DddWxXRsM+vzpTm62JXC3a7/zh7OUvR5jWdypu3WnI3jieJ3RwdPlIa+Ztw1dxhMdqjrSrHESLMj3IQJRv1Epty4mIJI+RRAoUrtbwZUCZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696015; c=relaxed/simple;
	bh=gaBXtVoVY7YPscVFU9wyPHc19g5ziz39ifn35doy4Jw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A+C0zP6pf5IyLAuxoEHE3dwZX7vUrzMKKWQW2eoSO11yZhE/Q1CwBEYRKEfivUKwnbat5MXq5DH9Ny44BBf6D05zLafyZ2EWE/O6Ow8D9+XaAjqPdyzf7B9i13lJ8jbG5/eEM20Lji1W2JTLylXCcSg7EGaV9kzLygjRhzFOpjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=an7Y2IV+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="an7Y2IV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24DBC19421;
	Mon, 16 Mar 2026 21:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773696014;
	bh=gaBXtVoVY7YPscVFU9wyPHc19g5ziz39ifn35doy4Jw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=an7Y2IV+y0Ls4GV2d8h/EE8OcJEIqC08ZyeXavRAAyTeuy3exd7Y4uAHBFA3htpdb
	 nMC//yV6bOtt/uccU25BF9E1g0sa8wBj9S9GdOdC52ewk4f01Ml2y/uUuNrIsJuOVs
	 vIzoJzA4jhg8qSIVKS6r0Ztnrojh4xYhtsPv0OTyAyBNKJfedHOEF8+w3zfdRXmYc0
	 hH/g3LuijQLk9FlS1nrNQtavtrK72pVlaYIttsoqPwNN+bwamQHYMJM9//X2PS/qOz
	 w9W2SVZPAa7bWz5AzmVkJwR+Jx9YyX+PwWzOH6wc2zvtE8BE0YptcfSDV9MiEgE/JJ
	 33shGltE4KBqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1843808200;
	Mon, 16 Mar 2026 21:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Start v1.8 development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177369600755.3315352.4283005294036271220.git-patchwork-notify@kernel.org>
Date: Mon, 16 Mar 2026 21:20:07 +0000
References: <20260316163916.2822081-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260316163916.2822081-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, bpf@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 16 Mar 2026 09:39:16 -0700 you wrote:
> libbpf 1.7.0 has been released [1].
> 
> Update libbpf.map and libbpf_verson.h to start v1.8 development cycle.
> 
> [1] https://github.com/libbpf/libbpf/releases/tag/v1.7.0
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Start v1.8 development cycle
    https://git.kernel.org/bpf/bpf-next/c/2364959abecb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


