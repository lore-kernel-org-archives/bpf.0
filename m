Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0856513CFAE
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384233; cv=none; b=XY30NNH3Y/nK0xiIPiGv6k9zd/myRk05+0yctQldLLwWT1s/j+/tGYNErXPN+vXsbZlZlK2LKe0GWt5/hqqaws/OKyiZ+Fhg5iQ0FGrPbm1ERlTsz9KJn6y7YGrQiiLYITYPmpWjQ/3dUe3L1nEVJP5wg3yF9igM/2gueNKsP4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384233; c=relaxed/simple;
	bh=oi5veR/ojO6upE2mhiofbLviAfjnWKk+Tn6eZShOoRg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gH5QVkr89X9681RT0dBkxVEeF6mp8sc5sjY7ojKPjtr99szK89Gi35zbaQGNS6aOchZGpujYCpZAejpR7ygmJh5kldafc3T5ziov+znzC+5FH6E0SvxpDoM2/gcgjm3RU24k9cOQOjcIWW32S/Gbw3wtyhnwoITbav/Xqd5PYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUQ83J50; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUQ83J50"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F344C433C7;
	Mon, 25 Mar 2024 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711384232;
	bh=oi5veR/ojO6upE2mhiofbLviAfjnWKk+Tn6eZShOoRg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YUQ83J50KrJznlAb3tkJRBAlLTSPz8Tt1QfUVP2+wkHJ0mzOJdv8KJ9JdDN7dNZ/v
	 KUI1UAUyWVl8p7UV5BxBIMVvRbRtt+LBDNCYAh/9Eg6xYIdJXbtU/g5FrTwCu4OCzF
	 AMGaAD63KptRE35f2AtqGpLBeHaWTukgeI2xKdpkNu2H6/DelNtVtplKAW8iXKysV8
	 t+tpAZMIva7O85CreiDQBXrjQsBcEhEGIid1jsaXj6nikHJlrF2TPMgIurGe4TVSJr
	 wkHc3wrH5dKs6tfSxLnlH83WDjvH37qERR47zYPQO8VAHQd54ijQ6I1x70h4QNVMkb
	 AlQjceHzfwTug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E395D2D0E0;
	Mon, 25 Mar 2024 16:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky test
 btf_map_in_map/lookup_update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171138423231.22247.17992219697516714017.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 16:30:32 +0000
References: <20240322061353.632136-1-yonghong.song@linux.dev>
In-Reply-To: <20240322061353.632136-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 21 Mar 2024 23:13:53 -0700 you wrote:
> Recently, I frequently hit the following test failure:
> 
>   [root@arch-fb-vm1 bpf]# ./test_progs -n 33/1
>   test_lookup_update:PASS:skel_open 0 nsec
>   ...
>   test_lookup_update:PASS:sync_rcu 0 nsec
>   test_lookup_update:FAIL:map1_leak inner_map1 leaked!
>   #33/1    btf_map_in_map/lookup_update:FAIL
>   #33      btf_map_in_map:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix flaky test btf_map_in_map/lookup_update
    https://git.kernel.org/bpf/bpf-next/c/14bb1e8c8d4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


