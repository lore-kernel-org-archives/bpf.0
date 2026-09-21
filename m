Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F8351B185
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028679; cv=none; b=Jo3iuc+ExLPHfiLBn4BgXpX63RaQspXrAqHm/DVxVsnwKPG/OzTYGrpO0IvEVR7khAUxGJwKvxf3/E8IZp6okDhFdfEjocM10O+9gyMJP19d5lxg0/WtNj1q4fL63UjB16pbXwScxUXubnEJyIKXaRf/joSOoM6mTpyWzuMKIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028679; c=relaxed/simple;
	bh=WrUCMVYEAgJdscHDaCCjus8C3wCk0/77GDz7zMKBzMk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nkWX5XbfUO3hS2eRHqlJ+ycwx95WY6jUcEyu5dbbFj5+iUUcBT+j1Ieb1cHqFwy8gVSF859EL38HxRnamP4nYphp9G2LL3QpTQbO4cil0I+4EZ5QMWlQtzobnHU0eNFoVq5Fpmcf2X+QLAUzeHkGmr1q4OcQn77UU9hM/l8E4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0P1Kr36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0P1Kr36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ECE1F000FF;
	Mon, 21 Sep 2026 22:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790028674;
	bh=6ZLix6XDjqAI/8nHJnojcSORSrCyqYEJkWI/Q5EnXBg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X0P1Kr362yjYP0pgDhvxvRyHkef3b99br3rsY1uLJa0HjGqKs1C/iy4yT1cP44E2G
	 bAswXY6UdVpA+nNgCw+koYrRxyjRh9XQa2Jvg/cjUqcGGL24eRtP9e3JYfi8BVUzid
	 gOjzibvE6+zIbR1+JmTWzLBtC68oIK6inrQIEDyoLWGFxDpU2h6wMUKFPFgISgkPEn
	 /89TmWvElEoBZ54RGCcVcKJ30loW2Jh+aCwk/3xWuU3rKcgPM2tOLqA3iYTwcnXpji
	 xz3LlrWGkJROOm1RKHKpvtTw8fcp8tgVw7UwO5HBH8mTnzmxfmkIsUlsdm5qyXK+IQ
	 wGZMXLAi0tmKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938C3393020B;
	Mon, 21 Sep 2026 22:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] bpf: Reject non-negative stack object offsets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179002860614.3260819.5672763578696261726.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 22:10:06 +0000
References: <20260920210423.345636-1-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20260920210423.345636-1-xyx2021@mail.ustc.edu.cn>
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 sun.jian.kdev@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 21 Sep 2026 05:04:20 +0800 you wrote:
> Reject non-negative offsets before converting a stack object address to a
> stack slot index. Add a regression test for iterator destruction through
> fp+0.
> 
> Changes in v2:
> - Split the kernel change and selftest as requested by Andrii.
> - Rebase onto bpf/master at a11212910cf09b2fe8db9afa41ef60c4f81879c5.
> - Keep the original code and test changes unchanged and retain Sun Jian's
>   Reviewed-by on both parts.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Reject non-negative offsets in stack_slot_obj_get_spi()
    https://git.kernel.org/bpf/bpf/c/79a9172f3ab4
  - [bpf,v2,2/2] selftests/bpf: Reject iterator destruction through fp+0
    https://git.kernel.org/bpf/bpf/c/8244668cbbff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


