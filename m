Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319BA47A0DE
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285482; cv=none; b=RuIa1m26VH4NwqOdZNpK3IMKAaBoEUDItW+xhQ21+I7caTH1TPN0hHuOanWJAuEXE/aoO7VU4VFMc5+rRLIVzvLfyw5x2Xj4bNrAayCzIOUzbZ+dmsWn62S5ejE9mXyucIfX5okpYmUyNBmvJ8ofYf2wp1KLiXkIHxhfR7fbPlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285482; c=relaxed/simple;
	bh=IF38KoxzSvfa6MioivvZVrFr9sVWkrB1bmpTlh1qHN0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R03uo3w39oK+qHgaTiKNp1ToH80DNYTxfSDTF2tdMoqXkjzTPhJSSm0whSOBGqYZ98kwY0M5idqsjowUbSjj2MH3XXKZRUOfUv3SINdriiBcGdHIbewTann+WTDpRtTKW6a/XNkm+ZZ7+bxjTIbGa8uClvO52TcDMFUe4aODZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvIqJfrd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvIqJfrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9658B1F00893;
	Thu, 24 Sep 2026 21:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790285479;
	bh=UD+70d/Ar+DjGE1slalnB8FsBRmQcLT3jNNxKhkGJq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PvIqJfrdYKWYD4gA/tufE0X25sLSI41RuMZ7mHvi5eZ8ekcFG4ZYn3Th3iSZo7Jx4
	 l3nXKGI2sdmcwd+RZz0T227ohdIYJUxgukrvpp+yJwHLuzQ2jbiDVNzRgYLexP7IXS
	 pNWTi8AYUv4aa28CusKnksaKmHXIOkEfxFYEKQlltKzHjpYl2fXJmlKW0k1n7Y/Nnh
	 TBbhJ/No7GNd/CpC71uWfmo4r2U6ALe4v3iYsfZOF3z12033xlSykZ9q1J5rULz8J+
	 TYSIANb9oGBNAnMA66eGWOCxpyvkIRciUnxgg5NH5uMbiI/oUnWuedL7IGWSL25oh7
	 1iQszug4eNbxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939FF3A566ED;
	Thu, 24 Sep 2026 21:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix loop detection for re-arming
 async
 callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179028540814.2209702.10043434568520924501.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 21:30:08 +0000
References: <20260924162609.1746610-1-puranjay@kernel.org>
In-Reply-To: <20260924162609.1746610-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Sep 2026 09:26:05 -0700 you wrote:
> Changelog:
> v1: https://lore.kernel.org/all/20260923140152.4005097-1-puranjay@kernel.org/
> Changes in v2:
> - Patch 1: also fix push_callback_call(), which numbered a new entry
>   from the caller frame. When the callback re-arms from a subprog that
>   frame is not frame 0 and its count is 0, so every entry was numbered 1,
>   is_state_visited() never saw a difference, and a loop in such a
>   callback was still rejected.
> - Patch 2: loop_cb() now re-arms through a __noinline subprog, so the
>   caller frame at bpf_timer_set_callback() is not the callback's own
>   frame. The v1 test re-armed from frame 0 and passed without the
>   push_callback_call() fix.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Look at frame 0 when telling async callback entries apart
    https://git.kernel.org/bpf/bpf-next/c/e55220162aae
  - [bpf-next,v2,2/2] selftests/bpf: Add timer tests for a re-arming callback with a loop
    https://git.kernel.org/bpf/bpf-next/c/84bff37db2ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


