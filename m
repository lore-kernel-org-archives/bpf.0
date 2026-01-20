Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40CD363C7C;
	Tue, 20 Jan 2026 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938010; cv=none; b=KdTTUeBb7SNunkUyTOXDak233zvuhUv0fgTzKrSaFft7wtsVqByONqWekaULp4EcmxASfCRCl1005ol88KWs3kH+esFCQ5d5MSbjyKRqCo+0WTwiXGLpKTIrp80BuVDLEPKRK1wiZeH3R9G0cnYyeMI3DbhpvS2EjkGH4dZgFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938010; c=relaxed/simple;
	bh=HdNNmaWMF3Dz7TVaqx+f6mc40yNbGM5z3z/AeyJs8/k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MznMGbmef2VMKzjGR3C7dOIZbdUKP0SBW+dBmGH0FwDj2BfamTsgneo7rDBaZlpf/8Hp4mcXCDqjh3N1E+D+v3aWtQPtLjuTc5Q/FullDz9nvKdrVcepmkDd1rCMqn5evBZ/XAH65sVHZk9M2+0Qo3pMwgbTAqVbryZX5iwi5nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViSgeKsg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViSgeKsg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CECC19421;
	Tue, 20 Jan 2026 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768938010;
	bh=HdNNmaWMF3Dz7TVaqx+f6mc40yNbGM5z3z/AeyJs8/k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ViSgeKsgS4CWTP3FsUF1ompmSlRmBZ72pEekXzIG2y8qcpgtdsJpFG+ydOkeWQW9a
	 pLf8y4TJS69he2uMZiZ+a11N396Tz4V/N+H2qdvbpLxq3LHkMb45SfYs5B6NDkCjKC
	 ClEmlLVqlVXAeMspI2v87OUlvSkXRyHIOA/iVEAVJ59yFyKrj9hnsw9wAIWplPW0hx
	 LEFkIlz/yr7UenLtN6HQEC1k5uuys+XOydcgQHZB/de5aEWxMuTzUzJMkwNNjCo7vE
	 gPYDfiF5asZ5Ua+2VbNQVI8Jlc+COf/151/Fj18VztVwmHNkweKUF4THSFFHdI8Duv
	 3UHW8ibvggPiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11A21380820D;
	Tue, 20 Jan 2026 19:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] bpf/verifier: optimize ID mapping reset in
 states_equal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176893800760.583014.3550645133045023335.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jan 2026 19:40:07 +0000
References: <20260120023234.77673-1-realwujing@gmail.com>
In-Reply-To: <20260120023234.77673-1-realwujing@gmail.com>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: alexei.starovoitov@gmail.com, eddyz87@gmail.com,
 andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, song@kernel.org,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 20 Jan 2026 10:32:34 +0800 you wrote:
> Currently, reset_idmap_scratch() performs a 4.7KB memset() in every
> states_equal() call. Optimize this by using a counter to track used
> ID mappings, replacing the O(N) memset() with an O(1) reset and
> bounding the search loop in check_ids().
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v4] bpf/verifier: optimize ID mapping reset in states_equal
    https://git.kernel.org/bpf/bpf-next/c/f81c07a6e98e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


