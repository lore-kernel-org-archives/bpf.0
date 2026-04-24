Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C743EF669;
	Fri, 24 Apr 2026 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054849; cv=none; b=kHpA931SWz1JbnGWB2M5jDxPrtuavjlLLkho1KrscurP88zB381lU/MKRm6sW2oIO+8ULHkizoLYnIXUi9R1Hx94qOhPRY7UKxpfZXdc/SdGv65cNZWxNwDfMVj26z3wkDCCw5W4kdEyjdFLqFaC0OkyRVRwXNZKE3h60NyESxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054849; c=relaxed/simple;
	bh=fPAbYszOYtL10ym6d9Nwm9WB5nSR2Kqggw78z0h+UpY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HdzXL8XZcheyjt5i5jULA6L3ef+ZNTOrcoxhjU5zE8xHBcUy60QdC92hZcM/Zb+RQwGvipLjfYbiwgXPSP6Qzm5+xGgZ5j+4jXnWLkh2/mdvcswwpEDCanKLQaqjEJtTHeGkj9+FxPjBLTHdDOcNMK1ukzrqiULbUn+mzhjkdVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3LJa+Mc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3LJa+Mc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745D5C19425;
	Fri, 24 Apr 2026 18:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777054848;
	bh=fPAbYszOYtL10ym6d9Nwm9WB5nSR2Kqggw78z0h+UpY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m3LJa+McnhVi32mADpapuSEfTG9xZF/8YAWofxUOdSk8bGL1QCsaxeOx1sPkQHXeN
	 MTMgN5BxhJ6OlIzvDGvKF2cjbWO956YbzpJKwWri6dBX5rA7re9R4y6cQ1xL+HyCle
	 Cr//5iWk2yeWQwLQyjiEbqQd1XoKQHUpWROX/c8UesKumBSgNuLw5gr1WTxgdGi1pc
	 +wRv64yOYhiuSFmfct4bLbiHISDZs5m92dKOK+9w+nlrTwEcvw1KaDs6jxbvg35vJ8
	 ZpA0n2OhAlymEJHuM+AJb/3028JkXKQlDoarJHxNQsK9HrFoY7kRjOPak6KNhElviu
	 GCtq20RZxUVTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CE938119C3;
	Fri, 24 Apr 2026 18:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] selftests/bpf: drop xdping tool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177705480880.1650547.11751423238740714723.git-patchwork-notify@kernel.org>
Date: Fri, 24 Apr 2026 18:20:08 +0000
References: <20260422-xdping-v2-0-c0f8ccedcf91@bootlin.com>
In-Reply-To: <20260422-xdping-v2-0-c0f8ccedcf91@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, ebpf@linuxfoundation.org,
 bastien.curutchet@bootlin.com, thomas.petazzoni@bootlin.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, alan.maguire@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 22 Apr 2026 18:20:23 +0200 you wrote:
> Hello,
> 
> this is the v2 of the small series dropping xdping tool. This removal is
> part of the larger effort aiming to tidy the bpf selftests directory.
> This new revision updates btf_dump test to make it use another bpf
> program rather than xdping_kern so that we can drop it as well.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: make btf_dump use xdp_dummy rather than xdping_kern
    https://git.kernel.org/bpf/bpf-next/c/d4a2eeb2ac78
  - [bpf-next,v2,2/2] selftests/bpf: drop xdping tool
    https://git.kernel.org/bpf/bpf-next/c/feb13b19f3fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


