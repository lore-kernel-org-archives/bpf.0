Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF42340403;
	Mon, 15 Jun 2026 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566833; cv=none; b=u00W/CG1GO9uCfWK8JwTpWtdMHcMVyWrUg50i8tFGELbJlMHvr1oZXJ8enfxqCUWCs+R/J3BnBK47nulEW+SKGZdGtPZE3mUEG61GGe17crhhVyzmOmLWIzuuR/uI2lMx9kA8N3CzoqrYaTcXosah+5Nitfr2RgBBDZ+eXL9kCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566833; c=relaxed/simple;
	bh=QdYGS+1gLW6kM+a+J7pjLRMNG7V653bD9q6hsT+UwTI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LGrUHLpqQ8mqtBhSaTKbBVR+IygqrCKMcnT9/Sse5wzXcvFgGWa6+oqfwTndg6+Iky15KtoDBV6TTt9GNFB7md8FAKzAWHEFBYYwPqvMzOmcDWm/jr86zfa8nZEESkcNc1jC8ayG20FNu+xQi9OopzMmVKAbsFk2c2RL2ugTh8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKqJ9c/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKqJ9c/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABE21F00A3D;
	Mon, 15 Jun 2026 23:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566831;
	bh=3bwzDDWjuMcDBe0LdROJFjXNIA8+HW4+PRiOoJLnH14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BKqJ9c/2Ugj7I+8FYqhVrXfe16R+zBQJVA9SDtQ9JwUBlTkG25GI/x1zntf/MNnHO
	 yGXKu6szzHpw+zSLiwKfNnuYYNieq1d/h3hWxVWdrke8XXO8OaOwqAI8rkcT8sJgB2
	 +IKIP5xS2BEuFWDX5STeD30QuPFd5J9e3MbY0/nD5AquQbOspu44WsFsg6FYDuJMl2
	 3wMzFgNgJeOQfp6VMthySSMqL3qqSFJ2cpAHPsZ/BWXp0u+NWAWi5VMef8uPYuI4xW
	 rvzfJR44gUqmth+ayfzyTFALI8I8qXMq3UL7WuCRFpyR4+M5AtWzX0S0CvRXjpfBNd
	 KQnHxjQXYU60Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08FB3839A08;
	Mon, 15 Jun 2026 23:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v14 0/2] tcp: rehash onto different local ECMP
 path
 on retransmit timeout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156682638.339383.5955465321121394941.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 23:40:26 +0000
References: <20260615042158.1600746-1-ntspring@meta.com>
In-Reply-To: <20260615042158.1600746-1-ntspring@meta.com>
To: Neil Spring <ntspring@meta.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, martin.lau@linux.dev,
 daniel@iogearbox.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Jun 2026 21:21:56 -0700 you wrote:
> Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO,
> PLB, and spurious-retransmission events, but the new hash is not
> propagated into the IPv6 ECMP path selection.  The cached
> route is reused and fib6_select_path() is never re-invoked, so
> the connection uses the same local ECMP decision.
> 
> This series adds the two missing pieces:
> 
> [...]

Here is the summary with links:
  - [v14,1/2] tcp: rehash onto different local ECMP path on retransmit timeout
    https://git.kernel.org/netdev/net-next/c/658eb696544c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


