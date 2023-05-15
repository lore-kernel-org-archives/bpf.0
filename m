Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928F118C18
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 19:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 549EFC433EF;
	Mon, 15 May 2023 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684177819;
	bh=SlEwJNrzW4LBUMaa7nAb9tSaJ/5R4QMO5KZEAy3iggI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kv+4iBsI4VIEXWYeeWKkhqbaJTlAV7GU1wd09FPYuIJJgb3mgdwlQQrPOvl3lsSdi
	 7Dl/nuMdXnC/9F2fny/aYkFtr8+XOCsazWuLB2ackvOEVWifWsc8nYpJRr5ATsX7XV
	 oNuOSi9uVNDrulbLEJ/ywaDQllRKfPjUBxsbDvpuVgMLbzbDl/NzvvXtYaIBH7is4M
	 vdWkhZE4vJqS2x6cPBo2FBDR7xgA25q2conzFmX3fB/3C23z/PWJRerULah7Iv8g1W
	 SbIKU5PBUSqC0x45kBrnDT6tGbIVVVHG4zOD/YTaViKb737kNDw+LbUJ/vzaP1alMG
	 JXtsWh7aWP76g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 338BDE49FAA;
	Mon, 15 May 2023 19:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: fix calculation of subseq_idx during precision
 backtracking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168417781920.28646.15216696634083551111.git-patchwork-notify@kernel.org>
Date: Mon, 15 May 2023 19:10:19 +0000
References: <20230515180710.1535018-1-andrii@kernel.org>
In-Reply-To: <20230515180710.1535018-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 15 May 2023 11:07:10 -0700 you wrote:
> Subsequent instruction index (subseq_idx) is an index of an instruction
> that was verified/executed by verifier after the currently processed
> instruction. It is maintained during precision backtracking processing
> and is used to detect various subprog calling conditions.
> 
> This patch fixes the bug with incorrectly resetting subseq_idx to -1
> when going from child state to parent state during backtracking. If we
> don't maintain correct subseq_idx we can misidentify subprog calls
> leading to precision tracking bugs.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: fix calculation of subseq_idx during precision backtracking
    https://git.kernel.org/bpf/bpf-next/c/d84b1a6708ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


