Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66900225417
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124423; cv=none; b=S73HAHPIbImCm4pDC95/VrzUyxGvY8LK3yfzuIhftqsHjtS3ziPrtlUFdIKD1q0vA2BmeH8HWugLSMjPCKe49W76XJG/PH/GMpnB4gIV3eI8KVQGV8j14VAT0+bi7Ua28BWrtlNb1L2S1Lk1pMF+5uyS9vsLCfm8HT7tQe8n38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124423; c=relaxed/simple;
	bh=GtF0GUducLesdEIE5aHjk2lqvs7vCj6bFd1nmEm9RDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KzEYzWsr8japzLvf5s0a2qShwehcV0rWY2U0IeT/hCgOpNI8pBixokVPHBpdPNlVLmshH0wwrOUQSow6DCEYqMT+jyl806cYf1G8cEUa7n6py396zohcNif9aqsJAR2iYHfo4SQ/umTpljIHi2x6FIvSF0p1ZMDC1n8XBDO3ZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAvPXkeb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAvPXkeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32729C19421;
	Sat, 21 Mar 2026 20:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774124423;
	bh=GtF0GUducLesdEIE5aHjk2lqvs7vCj6bFd1nmEm9RDw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MAvPXkebp0mLZpnhAjvWYofP++w79mK9Zwj9Wz0llGz6ZBStzkf9qRX+Zi3qzRq3n
	 anW7bMbbS+OdQ+fFu7qImIqs7C0C332F9as4/uyd7T/QexqNsorUoAQkbM1ngvKdLE
	 6JdiZKSHpEs817Z99teEKKTQt6JfI2JyT5afOn+rh+iMFtancFpWg04Z1+lSb8BLCP
	 cwa/47DUXK2OPq7OEKPNRfy7AAKmg2BkWu+u8FcXd6Ik5/sBVONBfCX6ptzJeLAk02
	 NT70BJd8ru+B4Ivm1hAKBXN8U3agErkcFSikwqlHpSpC2GM2OWSKqUm0QalsslqSuU
	 2nusflVDHqfJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EBA3808200;
	Sat, 21 Mar 2026 20:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/2] bpf: Fix unsound scalar forking for BPF_OR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177412441253.2951219.3596535924088439799.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 20:20:12 +0000
References: <20260314021521.128361-1-danjwade95@gmail.com>
In-Reply-To: <20260314021521.128361-1-danjwade95@gmail.com>
To: Daniel Wade <danjwade95@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 ameryhung@gmail.com, ast@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 14 Mar 2026 13:15:19 +1100 you wrote:
> maybe_fork_scalars() unconditionally sets the pushed path dst register
> to 0 for both BPF_AND and BPF_OR.  For AND this is correct (0 & K == 0),
> but for OR it is wrong (0 | K == K, not 0).  This causes the verifier to
> track an incorrect value on the pushed path, leading to a verifier/runtime
> divergence that allows out-of-bounds map value access.
> 
> v4: Use block comment style for multi-line comments in selftests (Amery Hung)
>     Add Reviewed-by/Acked-by tags
> v3: Use single-line comment style in selftests (Alexei Starovoitov)
> v2: Use push_stack(env, env->insn_idx, ...) to re-execute the insn
>     on the pushed path (Eduard Zingerman)
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/2] bpf: Fix unsound scalar forking in maybe_fork_scalars() for BPF_OR
    https://git.kernel.org/bpf/bpf/c/c845894ebd6f
  - [bpf,v4,2/2] selftests/bpf: Add tests for maybe_fork_scalars() OR vs AND handling
    https://git.kernel.org/bpf/bpf/c/0ad1734cc559

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


