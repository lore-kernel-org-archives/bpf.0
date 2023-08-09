Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B0F650
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 00:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6EBEC433C7;
	Wed,  9 Aug 2023 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691541021;
	bh=icVOaDz+l+fwv87cpMdYID2391OgyjZpI89ihNEQZkc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mob7j2dcAP4ycDpcCb0eprkfSLFCbhv4vQe+mZ+tqmdWfGkaPTneLlnJdAMJXgtlc
	 GNfLpXTPXBealAQ1E8bGmeG0zOgmSGXT8TFSgb/ZvQUCMqnlQ9DaHdiXPo5xHNDrf0
	 zVI0Fxx71FX399mm9zB+iDi9OcDVf9mQSkqXgurWyV8NRq3y64vJL1jGonCiIXASDq
	 f6I7pIO3la0LakuQuEa3m+nGMJ52H44SzKT0N5m/w6bnXJD8cqJ5cHernzJAhx9lgP
	 nuFxmOu24VaZL9ltT86Bp0LvTRbgZvcsrntG5Fn1Qi241o1Iq5D2sIBNp8TZaNZeoi
	 5YMOWnOeL+j8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB0EBE270C1;
	Wed,  9 Aug 2023 00:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: btf: Remove two unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169154102082.20035.14673618141697002418.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 00:30:20 +0000
References: <20230808145741.33292-1-yuehaibing@huawei.com>
In-Reply-To: <20230808145741.33292-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 8 Aug 2023 22:57:41 +0800 you wrote:
> Commit db559117828d ("bpf: Consolidate spin_lock, timer management into btf_record")
> removed the implementations but leave declarations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/btf.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf: btf: Remove two unused function declarations
    https://git.kernel.org/bpf/bpf-next/c/2adbb7637fd1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


