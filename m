Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF869171E5F
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338829; cv=none; b=jsK+wkbe18rB3rUN8YxTeAc2qrnP0PE7HCZm9e7rcoFEzirYb5YKurAA51QjYM0R5qtBe8Iv44VCbSioWCftrMlAWRmCwejmpZtgGBwQmE0gWsZB/EFrVn/I6lNS50z1TNB6Ioc8CK25kZSqnh+cC7ag8VQYxKM0zw4PRWk2Ut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338829; c=relaxed/simple;
	bh=Aevg3U9VUq299LIE4NuS7iOZtd7ffK4M8mwb0mFgXjI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V8771Bf3eYgowsFoqg+6bM+BiFZtx9WL22gz1Ii1T2SMGGmXg6WekizDkNN3g0VPjs2ajsoiWu/+sIW6C1/4lsh4Qwx4TIV2NN2RrcmBM2sDjjkpbSwAVanv6fIV47kehroe2aCsenYOZYg0/6jWMiQqCRyflAzM7qbti6EV91I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoTmQ447; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoTmQ447"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 465B3C43399;
	Fri,  5 Apr 2024 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712338829;
	bh=Aevg3U9VUq299LIE4NuS7iOZtd7ffK4M8mwb0mFgXjI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GoTmQ4477J7EMdRRQi5FA8v1RbQMQyUrceiFe6BWsWT57CkkB4SK+OpT9BDWvmj1y
	 jfAO8FnhDmUclmCjbkwD6fj/CEFcGbTyhEQdH0NBGwmNarwLckfbw3lusIf5hv1GxH
	 WvPgU7MlWJUWeEaLeuIIxfhbI2npPta9NR83pVGTXmCW52RHkA+dBjsIzcHxIl4xkE
	 26Aimnt2TSOLQ5Jme+izq7jzO+aAuAEw2Wbq+MEjHaGZAg/Ia/0j7kmlhDBeyhablU
	 5y0B9WEgc2ojyhx053zDHR71QytWtsEgD0KKSmq7R1Fd5zct0NdWpjHZvZVCZWYLqu
	 93tJfsU/WgM8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A81FC395F6;
	Fri,  5 Apr 2024 17:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/3] bpf: allow bpf_for_each_map_elem() helper
 with different input maps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171233882923.27871.7584547552854184481.git-patchwork-notify@kernel.org>
Date: Fri, 05 Apr 2024 17:40:29 +0000
References: <20240405025536.18113-1-lulie@linux.alibaba.com>
In-Reply-To: <20240405025536.18113-1-lulie@linux.alibaba.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org, xuanzhuo@linux.alibaba.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 Apr 2024 10:55:33 +0800 you wrote:
> Currently, taking different maps within a single bpf_for_each_map_elem
> call is not allowed. For example the following codes cannot pass the
> verifier (with error "tail_call abusing map_ptr"):
> ```
> static void test_by_pid(int pid)
> {
> 	if (pid <= 100)
> 		bpf_for_each_map_elem(&map1, map_elem_cb, NULL, 0);
> 	else
> 		bpf_for_each_map_elem(&map2, map_elem_cb, NULL, 0);
> }
> ```
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/3] bpf: store both map ptr and state in bpf_insn_aux_data
    https://git.kernel.org/bpf/bpf-next/c/0a525621b7e5
  - [bpf-next,v1,2/3] bpf: allow invoking bpf_for_each_map_elem with different maps
    https://git.kernel.org/bpf/bpf-next/c/9d482da9e17a
  - [bpf-next,v1,3/3] selftests/bpf: add test for bpf_for_each_map_elem() with different maps
    https://git.kernel.org/bpf/bpf-next/c/fecb1597cc11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


