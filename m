Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF26823DD;
	Tue, 10 Mar 2026 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169225; cv=none; b=caiAEKViKZSjGCcpZ7hI9+J5Np3wNCUEURi25Cn+wdqmtljeka6eMk+8PXP3lxleha2h4BZI3MepdYKdVyEHZULZIUGf2T7HsFVnLr9vSIQKcRRNVxsNQI23Pg9VLeS+KOH4thJ7rrJkzH20WYhtwyrpQNGvN9Jasl1l5TL+KQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169225; c=relaxed/simple;
	bh=U/VJ4f7cn/wdCFmTlCed+eW+Uzn3cUBENQhSyH5iARM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rj7RmnNAxAONOM6HpacUo1OUZ4hVXbYHeyqYOLWj9+DcMA9eQuiqD/7jGR4xBsxMndAlRc5Yz0L2JKuwbcfptQybEcOslEDbdVr8GxO3AqIAzH9002uuGdx4Ri1Egb47yJH6lH0v0aTNm+rldXXiD0vCh7+F3I+iFUNgcBP0c5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgmA/PpR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgmA/PpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918A7C19423;
	Tue, 10 Mar 2026 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773169224;
	bh=U/VJ4f7cn/wdCFmTlCed+eW+Uzn3cUBENQhSyH5iARM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZgmA/PpRyqmyfJ08L7BKGJm7EbWdnfDgE5Vk8GYzOGn94VayzX5i490ow57EWc+u7
	 Nh4sUqCbNgupmfw6chMDb/8Uk/u9n0Pr9GRIH0JkUKfm0YOjL9d8UKhl4hi9U0GchT
	 wI/53QNF0hFW7z19mh0KipOdKDoAPewF1gCqgLKUKdM+kjdq5VDCARvlkojhV/WHqR
	 lGC6pUkwl4awVX62zE1QXh21V0ubRMHqI157EZz2MutpZlYSdI3NGhpxVOmZSYuWlY
	 n+AtZ+9dFrbsvLncY/wxE2luTegE4NVCh7+8asxQvlbWXzgQ78xLjvvPPOI2D0LLxd
	 0lY1xSz4N192Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D02F3808200;
	Tue, 10 Mar 2026 19:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] Fix test_cgroup_iter_memcg issues found
 during back-porting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177316922104.2465788.9552012796707736697.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 19:00:21 +0000
References: <cover.1772505399.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1772505399.git.zhuhui@kylinos.cn>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 inwardvessel@gmail.com, roman.gushchin@linux.dev, emil@etsalapatis.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhuhui@kylinos.cn

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Mar 2026 13:53:07 +0800 you wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> While back-porting "mm: bpf kfuncs to access memcg data", I
> encountered issues with test_cgroup_iter_memcg, specifically
> in test_kmem.
> The test_cgroup_iter_memcg test would falsely pass when
> bpf_mem_cgroup_page_state() failed due to incompatible enum
> values across kernel versions. Additionally, test_kmem would
> fail on systems with cgroup.memory=nokmem enabled.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] selftests/bpf: Remove kmem subtest from cgroup_iter_memcg
    https://git.kernel.org/bpf/bpf-next/c/a8fce027e17b
  - [bpf-next,v5,2/2] bpf: Use bpf_core_enum_value for stats in cgroup_iter_memcg
    https://git.kernel.org/bpf/bpf-next/c/da99028c2113

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


