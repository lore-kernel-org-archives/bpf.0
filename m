Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04817199949
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772850013; cv=none; b=mpfuITC2H9gMu8hBrJAc1sm/bZ0tp3oc+BTNya1Ih1b3wVmLB1h3O8BEt+D8F/UgRuX3OYFlXo7+Q+ersWMJZ7b2dRhFvaH93E1rI2Lt7BxcaB5roFcY3+E7fbNiO1z3jwms4hlL8jVhX1n6QDGIbpXMwFg20FKQkm3gO+ovCEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772850013; c=relaxed/simple;
	bh=qhJgvrHhngLVwew6lL0lFfStTqBoR9i5GJZkf3iuL9o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mjLdt1K7ieZfC0zqaY0+oMEfvS1lEn36mEyA8TPTjnVSG2J+iRlXBN53tIl8U5ykMTdSy5VaW7bQ0ZrvdJIp7Qjf9vR8QRuxqKyigOKRECkLfbtq3j8JF9zFh1iyOWVNG8+udaxRns0GulsKD6tvrDCpwvlamNEvhm3ky9GH8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+kCfb+z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+kCfb+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3846C2BCAF;
	Sat,  7 Mar 2026 02:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772850011;
	bh=qhJgvrHhngLVwew6lL0lFfStTqBoR9i5GJZkf3iuL9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q+kCfb+zMG2S0R1i+skiRFKq3t3fqKRTXembNVW2dz3xCXBzDfuqc5NnB5eh1qRLY
	 bmZxX0UK74MT++QZKiIkW4nyWQTc3E3uMt57CDH384x1HjDDU8hDgFMKmAES5Cwd1H
	 K5Ae2qX1ZC9XtKqwCtG0CVyJdoEsX+DCTWzoiC2RBG9aZr2bo/cso0A4t1s6cb39NO
	 E0mJyu/nEHIdhFlwVjXjsd+es54ylLLcZPkurOqf/PY9UEGRcZwxAYaVxF0zTI4ZK0
	 RpiTMmgTFrPnUKUKIhYtmE3GZVKfJUpaMnFlqi6IgowgJZASDvOkrXJwzUXUpqUj9Q
	 80nJ2BiHhCcBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D5A3808203;
	Sat,  7 Mar 2026 02:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/3] bpf: refine u32/s32 bounds when ranges cross
 min/max boundary
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177285001080.127433.15719934651642156765.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 02:20:10 +0000
References: <20260306-bpf-32-bit-range-overflow-v3-0-f7f67e060a6b@gmail.com>
In-Reply-To: <20260306-bpf-32-bit-range-overflow-v3-0-f7f67e060a6b@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, shung-hsi.yu@suse.com, paul.chaignon@gmail.com,
 emil@etsalapatis.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  6 Mar 2026 16:54:23 -0800 you wrote:
> Cover the following cases in range refinement logic for 32-bit ranges:
> - s32 range crosses U32_MAX/0 boundary, positive part of the s32 range
>   overlaps with u32 range.
> - s32 range crosses U32_MAX/0 boundary, negative part of the s32 range
>   overlaps with u32 range.
> 
> These cases are already handled for 64-bit range refinement.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/3] bpf: refine u32/s32 bounds when ranges cross min/max boundary
    https://git.kernel.org/bpf/bpf/c/fbc7aef517d8
  - [bpf,v3,2/3] selftests/bpf: test refining u32/s32 bounds when ranges cross min/max boundary
    https://git.kernel.org/bpf/bpf/c/f81fdfd16771
  - [bpf,v3,3/3] Revert "selftests/bpf: Update reg_bound range refinement logic"
    https://git.kernel.org/bpf/bpf/c/d87c9305a884

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


