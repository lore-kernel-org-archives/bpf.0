Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E135286A4
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787938263; cv=none; b=kvnJu+39sV9Q6HZUc/XLh2HxeXqVrDuYF1ZZ0w6OQpGmEucb3/6GgOVpc5+GDXouMOmmqJaRnqYGW1zl7gk5Wn50pGVfbiPbADUqr9lbHHPE1HMrgqxOl2ZOgU6Tn+T2iD1QS1PuifuAKjz09dfdAKWYampjzrsZBbw90wt0x3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787938263; c=relaxed/simple;
	bh=4+qrQi1p9HZ/MVomRIeDmvpJHfJJHpXjCqbBeQhV2RU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U6HPXrkDXCiqkT83GJS1Df/wIhqF8tXIZmejxlJb2RyF0OgMq8LBvjO1n+z175/E5bezXkDzWikcxb57veYRQve4YSBOYnwdfLA0wFzVnmSM6l3nJWoeYoLUGSUoz93tmLaJT0yfPH23Manc1V2KRjhQqywmymIMah9xxNnc1gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqieMdaz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqieMdaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8241F000E9;
	Fri, 28 Aug 2026 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787938261;
	bh=mt+ylBNPZBDX276tRJMQ3TMp66GXYtCW3C50Gvrg0GA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cqieMdazv4Vb+gV4MR2SOm1k0PDC6hFpT2lAXQkdjNJiN3yaZDBD3EdHGYx0ylJOz
	 bOONjfESDB0hcl4HvKZdDxSfuOg5SUkC1D1nLGGv6EOL0EKoU2m1Ea3RzRHaDYunri
	 lnwvpVUrherho3l7aZRbJR8eK3hJd5TohFp5p/emvoDVuKD5o3lIw29PXMev+EjYxv
	 +Y+1ZFrYon98zD90oJzzRGoBDmQGi4xKw8zfb/++IJjOYBRQBvLamd99iDp0NOX6ox
	 g9Uj2aGOutPyxn6JS8oaPZaWCXGRXsUjG5J/wljKDJIaoxkZ3+Ec4LJ9elxMpQGmaH
	 LVLG8J4NEVslw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D097A380AA67;
	Fri, 28 Aug 2026 17:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] libbpf: Fix for the potential undefined behavior due
 to
 shifting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178793820640.2701758.12473646012331554611.git-patchwork-notify@kernel.org>
Date: Fri, 28 Aug 2026 17:30:06 +0000
References: <20260828003448.1684064-1-tw19881113@gmail.com>
In-Reply-To: <20260828003448.1684064-1-tw19881113@gmail.com>
To: Tw <tw19881113@gmail.com>
Cc: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 28 Aug 2026 08:34:10 +0800 you wrote:
> When compiling libbpf with sanitation, ubsan will report the following:
> ```
> left shift of 1 by 31 places cannot be represented in type 'int'
> ```
> This may lead to undefined behavior according to the compiler implementation,
> let's fix it by casting to unsigned counterpart before shifting.
> 
> [...]

Here is the summary with links:
  - [v4] libbpf: Fix for the potential undefined behavior due to shifting
    https://git.kernel.org/bpf/bpf-next/c/cd35e1b10182

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


