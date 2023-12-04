Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8028E10
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrONCbVw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FA0AC433C8;
	Mon,  4 Dec 2023 15:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701702024;
	bh=l3PgZnEwBqhtCOw9jf3L0e8rowaPg80hNvj4/YpkyaY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OrONCbVwdSjxnh/2t/e0HifVT7qfavAJeXY60FVOqUlw+9YG5WFFInXwNLDRJwif7
	 7DFMYGHkEvX8vQm66XXs7qG+Xfz4UUL4oN1wQ3gzfswgtt06EhC0SzAacbCNu1QHy8
	 hpnGWSB7uIDz2LkYRA4rGhD8gsG0avvPGxhmQNq5S9Oyz31rir9J/PW0Spka9Qf2IV
	 XLe+EXjGvuhXNcCN4w0inCHKwARUys7XVjKWAkXYa9RAZ+Mwsd8Vtla4j3sJCtNZQg
	 mf1zNVECqI30Eth13vNjsXietzBOjhsaIcgSAPLbpwI2ysi4huFiKw8e91dcYQwX4d
	 knqOD29r6TKjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 053D7DD4EF1;
	Mon,  4 Dec 2023 15:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: minor logging improvement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170170202401.8813.5753912272937274867.git-patchwork-notify@kernel.org>
Date: Mon, 04 Dec 2023 15:00:24 +0000
References: <20231204011248.2040084-1-andreimatei1@gmail.com>
In-Reply-To: <20231204011248.2040084-1-andreimatei1@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun,  3 Dec 2023 20:12:48 -0500 you wrote:
> One place where we were logging a register was only logging the variable
> part, not also the fixed part.
> 
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  kernel/bpf/verifier.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf] bpf: minor logging improvement
    https://git.kernel.org/bpf/bpf-next/c/5bd90cdc65ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


