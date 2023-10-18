Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6341401C
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r59T8zg4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 626E7C433D9;
	Wed, 18 Oct 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697617222;
	bh=g92m7+sSdBA8KJbvUHeNmVunsbDNRD1vE8MRrBz6ljA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r59T8zg47HcnAHnSOnRAUnW0uvwPdLEQKC4KCkYgr375lpc7ZUlcrJKybGMbzx1+F
	 4C3J464Or47cKMqLHRKHVHfjX9UEN1ER7Ppz8GaD+jFKb4ANMaozLRpLayx80xbVZs
	 Q9lvT87ebPHTmcJ55SsRkEndMxPx+F4AyLfBoWMDZ+sJQa7urPxiH18jHy8Gkt5oZ+
	 wwxvURhcQq7ZdWxnd8koALV9vpof7DCGYlPti+bLISNlYVpGYZspX4mISmud7OqYU1
	 H5dZgDpG20EKP1BpZQklijygeUlG69Y4zhgnmUJJx6SiFtoEQO7GiVZm5imdEar0b2
	 ePJOpyc6MMlow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45BD1C04E27;
	Wed, 18 Oct 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: add options and frags to
 xdp_hw_metadata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169761722228.19172.14123962875957627623.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 08:20:22 +0000
References: <20231017162800.24080-1-larysa.zaremba@intel.com>
In-Reply-To: <20231017162800.24080-1-larysa.zaremba@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 maciej.fijalkowski@intel.com, hawk@kernel.org, sdf@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 17 Oct 2023 18:27:57 +0200 you wrote:
> This is a follow-up to the commit 9b2b86332a9b ("bpf: Allow to use kfunc
> XDP hints and frags together").
> 
> The are some possible implementations problems that may arise when
> providing metadata specifically for multi-buffer packets, therefore there
> must be a possibility to test such option separately.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: add options and frags to xdp_hw_metadata
    https://git.kernel.org/bpf/bpf-next/c/bb6a88885fde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


