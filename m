Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8963124EAB1
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860855; cv=none; b=A3zZH5xu50u7y2YXigA6HX7S1Z3Ifp+LRzfli/sUzbkMG47OpZh6iVdRDNNFpOeajLMyWoONimnjVvSLxZMjROFOugtX6sSoz0FYQxV9t9nO+2vpYBC+o4dY96vXFmG/7it9wgP/cnbkAEtgglmTsBo2BZ50l/UASqzODfDwTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860855; c=relaxed/simple;
	bh=kJIYTSq6HfHQiahpyK716pobFGrzDQd2g4R/dvC3UhQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZvSSAAu1p1YgVfzEDJFxA2aXKLAn2VkZzwaM04v1IBdFOj16ETW14QafaHfiW3njGbznXVwywamBocGQM83cjuuAeJFT1E2bhjh8ns1sVn3BN1DtrJ9DO6C23YfB3KJbDQTatPl7NVC4RMurvlDoIpf4jrL/r4GpWBvNbsZMHlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di7TeDLC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di7TeDLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A857C19421;
	Fri, 10 Apr 2026 22:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775860855;
	bh=kJIYTSq6HfHQiahpyK716pobFGrzDQd2g4R/dvC3UhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Di7TeDLCX7Z2GuvsQQrJAIaz/50jbhSQmShWOxcH5gcgh3Wb1o8KcHv7kEH+3NNKa
	 0PqB8HOcrmQUImO97u8uyT7xaKwsKGSv0MfqfvMlfDuGE8SGjxfLmSWm4Nb0hFAAeQ
	 r24b/P6NSYkPTGNHk8s5qoJAB+3/UJL9/8beMFx8eke3zdihbsYsmP+PY7WKL0Y/OV
	 1dSoLFJDbC1YWCMfKzu1A/Y1xqTuDeYvAZ+vCqpZ1oYxgX+1JNRufAQ8n8SMSnxRdq
	 vSKkzyaOyhvPs4HYqBSvojyj7pQSjq0+DPEN6D3SEnv5jrtfS84RiEpkzEtceTwKUc
	 vJ5mA50r0lMSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DD33809A88;
	Fri, 10 Apr 2026 22:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/14] bpf: static stack liveness data flow
 analysis
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177586082939.2670415.9674652667360393346.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 22:40:29 +0000
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
In-Reply-To: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 10 Apr 2026 13:55:51 -0700 you wrote:
> This patch set converts current dynamic stack slot liveness tracking
> mechanism to a static data flow analysis. The result is used during
> state pruning (clean_verifier_state): to zero out dead stack slots,
> enabling more aggressive state equivalence and pruning. To improve
> analysis precision live stack slot tracking is converted to 4-byte
> granularity.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/14] bpf: share several utility functions as internal API
    https://git.kernel.org/bpf/bpf-next/c/33dfc521c20d
  - [bpf-next,v4,02/14] bpf: save subprogram name in bpf_subprog_info
    https://git.kernel.org/bpf/bpf-next/c/cf3ee1ecf346
  - [bpf-next,v4,03/14] bpf: Add spis_*() helpers for 4-byte stack slot bitmasks
    https://git.kernel.org/bpf/bpf-next/c/2ad45b414b87
  - [bpf-next,v4,04/14] bpf: make liveness.c track stack with 4-byte granularity
    https://git.kernel.org/bpf/bpf-next/c/7ca5f68cda07
  - [bpf-next,v4,05/14] bpf: 4-byte precise clean_verifier_state
    https://git.kernel.org/bpf/bpf-next/c/be23266b4a08
  - [bpf-next,v4,06/14] bpf: prepare liveness internal API for static analysis pass
    https://git.kernel.org/bpf/bpf-next/c/8d3219f64d98
  - [bpf-next,v4,07/14] bpf: introduce forward arg-tracking dataflow analysis
    https://git.kernel.org/bpf/bpf-next/c/bf0c571f7feb
  - [bpf-next,v4,08/14] bpf: record arg tracking results in bpf_liveness masks
    https://git.kernel.org/bpf/bpf-next/c/fed53dbcdb61
  - [bpf-next,v4,09/14] bpf: simplify liveness to use (callsite, depth) keyed func_instances
    (no matching commit)
  - [bpf-next,v4,10/14] bpf: change logging scheme for live stack analysis
    https://git.kernel.org/bpf/bpf-next/c/2c167d91775b
  - [bpf-next,v4,11/14] selftests/bpf: update existing tests due to liveness changes
    https://git.kernel.org/bpf/bpf-next/c/b42eb55f6ca2
  - [bpf-next,v4,12/14] selftests/bpf: adjust verifier_log buffers
    https://git.kernel.org/bpf/bpf-next/c/957c30c06748
  - [bpf-next,v4,13/14] selftests/bpf: add new tests for static stack liveness analysis
    https://git.kernel.org/bpf/bpf-next/c/27417e5eb9cd
  - [bpf-next,v4,14/14] bpf: poison dead stack slots
    https://git.kernel.org/bpf/bpf-next/c/2cb27158adb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


