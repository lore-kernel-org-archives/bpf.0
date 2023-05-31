Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F48FC2D7
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 11:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C4EDC4339B;
	Wed, 31 May 2023 11:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685531421;
	bh=HPyxuv+32mzuFbyIZZQ67hhRqs4/0tjF0wvqYmuefj0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kKhfu7Kmopcc58c7cdqLZA/bGu0gprPRt+0DkCKWv0KSnyX9DAU3og8QflYksObev
	 PiEAUreCCuLbyKlrE4K2PUx/p/DfAwfqhjDKgCJKV04VkUvm9UJMQRAFPMt2Zf8+87
	 s7dHrVcLzf4D1YmRB93lxtFpDnBLZ/AbvjvZmojyOs1uFzgDtSBd/ldFakMV73LRlV
	 ruIFkwUxfw5YmiCONF0eBdRs364pPwo5LQiE0hXGIpPDnlyiltEQTBPxygfBidGHjY
	 P+7RSNchvGVfAIrjFjnPrPU9TtRS2YRRILcordrk376P3fXUVVZ8e2XI5ZCB5Aw986
	 VWW4rh1isQ7Dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23011E52C03;
	Wed, 31 May 2023 11:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf/tests: Use struct_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168553142113.8778.17191708621111165063.git-patchwork-notify@kernel.org>
Date: Wed, 31 May 2023 11:10:21 +0000
References: <20230531043251.989312-1-suhui@nfschina.com>
In-Reply-To: <20230531043251.989312-1-suhui@nfschina.com>
To: Su Hui <suhui@nfschina.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 31 May 2023 12:32:51 +0800 you wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more informative.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  lib/test_bpf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - bpf/tests: Use struct_size()
    https://git.kernel.org/bpf/bpf-next/c/0d2da4b595d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


