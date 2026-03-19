Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D0F23536B;
	Thu, 19 Mar 2026 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881050; cv=none; b=tj6GQgBX7HZ2qDKyxeLD31M1k4gHf0T4FuNHk9XXgIEpRziB56MuD7yTx241RInQe5gx5uvoHhpH/HHVlEv6UWgvxP2kudTWDABXMG0Sa7OAYM7qb191cOSISGU9chopYRDU3rFMOyaVascOtwF6Bjf/az7OPD3ovK0dCqEY7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881050; c=relaxed/simple;
	bh=2J7H3P4JRqpPW25xIQc8pi4YGX/q3BRPvTntY/nBnd0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HoB/o2ugwORzPrYQvnkcQzodR7+UU6CO063iQCcjsgrC9YTcsUdZV033P4METFdW+N8CPY231BzW+5YmmGmrMSk87TQmo+eLJzpZeJLu2QcDcYwKfFuKu/UWAAA4mD/V2/Do/BikfO5qf2iYXUiMLe5dVx8fZOYAVvsIp5c7Guc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2kKeqrE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2kKeqrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235E2C19421;
	Thu, 19 Mar 2026 00:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881050;
	bh=2J7H3P4JRqpPW25xIQc8pi4YGX/q3BRPvTntY/nBnd0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p2kKeqrEc2iJCdntfJZqxoRiOOQoPDNmj7kbNsQCt8uLSM2LTFAs6Bqcz5JhmpW7h
	 BsR4rI/srYMXfoenhln6h9rB290SAZCJPOqQ9BCGX2NhCB7UOEeqIxB2hWYj/InIOa
	 HqE1bAMEJEEsEYD51erNwRieCGAoV/21BWGEk0YRhC/1SF6Wa9xb/jfMJNztb9vK9e
	 joW0Vml63bwnCludYZfD8y6tz69dXg051lM2QsTljxXInGyn6Q1PujGuFje6CNjuZM
	 fjjutanMlpdwdh0aDywfUCqM0H1CKpGR4IMmpOIdxoIBmv2JHBxHyxSqsFG2jBq6zB
	 NujWJrH9dA0XA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FA53808200;
	Thu, 19 Mar 2026 00:44:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests/bpf: modify_return: isolate fmod_ret hooks
 by
 pid
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388104130.935482.1912662959372766803.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 00:44:01 +0000
References: <20260313034540.255805-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260313034540.255805-1-sun.jian.kdev@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, andrii@kernel.org,
 shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 13 Mar 2026 11:45:40 +0800 you wrote:
> modify_return's fmod_ret programs can override bpf_modify_return_test()'s
> return value, which conflicts with get_func_ip_test when selftests run in
> parallel.
> 
> Store current tgid in BSS and make modify_return hooks act only for that
> tgid. For other tasks, fentry/fexit become no-ops and fmod_ret returns the
> original ret.
> 
> [...]

Here is the summary with links:
  - [v2] selftests/bpf: modify_return: isolate fmod_ret hooks by pid
    https://git.kernel.org/bpf/bpf-next/c/4a4fedb8a523

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


