Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0267325483
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 01:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775611853; cv=none; b=OEnZPVXtE/9EOTKwUnWl4zZSCpXkjpw1j2AZjUKt31pS6aGeTQ2M/7qVpTIElWjuTL7bpqLOcwGla9zcNlChRUwo9u15zwb1WWZh965KhotYS8vsZJvaHDHunEV+aqenA/y8VJbpLAHAr4JJdxrUa68e2nUD5YSOnEDuC78F3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775611853; c=relaxed/simple;
	bh=NMrOAlVc5dslBSCy+Ok0gmFhUknu3knW0Adx5neggS4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dfa91gDkCsHLmte4c1dLQmwYA5j9CHDFOYO8OwfcQlhPQ7SpBBB3sEEY1dfBVnFWM0ETjHyRWWjYglRdz/QvHKRaM2UuL/f6ZI+nysn3bqYalXWK0zHaRdxp384CNhLGqBn606V4ak7Mv2gMHJMJJ7ftmfs4oooewri/EScEkkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDBXuMow; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDBXuMow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1C7C116C6;
	Wed,  8 Apr 2026 01:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775611852;
	bh=NMrOAlVc5dslBSCy+Ok0gmFhUknu3knW0Adx5neggS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pDBXuMowy3qOEsgyaQRenXelJQFNF36ZxxPmPYAErOO5FLGz0wMdb+ng1ipxNVqby
	 5DdteobH0BQhYtcxv39wX5K0M/cPIeNa899wvMOWzBfhdcVSBSnrH/zUVUHJxV3B86
	 DEGyiTD8+vr0pVi/EeWNv7njSnrUaPZd3J2kshJ7xdP+XThIKd6ucp1Xh+dKQnuUcr
	 CFzPM7sn+b40KEzevosYgAaSAs9hEQBZBJbksOKTzZiL7rlIkd7Ia8Y/4rcHXY188y
	 oAhLBoDcxtqEJF7Jogze2CfW7Os+ykp9Web65GfZEJx1Z97kc40uCqDcoiLzRdqdvg
	 UPgO3HgpXZKIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D673809A3D;
	Wed,  8 Apr 2026 01:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/2] Allow referenced dynptr to be overwritten
 when siblings exists
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177561182979.28494.17307819279533756669.git-patchwork-notify@kernel.org>
Date: Wed, 08 Apr 2026 01:30:29 +0000
References: <20260406150548.1354271-1-ameryhung@gmail.com>
In-Reply-To: <20260406150548.1354271-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 martin.lau@kernel.org, daniel@iogearbox.net, memxor@gmail.com,
 eddyz87@gmail.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  6 Apr 2026 08:05:46 -0700 you wrote:
> The patchset conditionally allow a referenced dynptr to be overwritten
> when its siblings (original dynptr or dynptr clone) exist. Do it before
> the verifier relation tracking refactor to mimimize verifier changes at
> a time.
> 
> Amery Hung (2):
>   bpf: Allow overwriting referenced dynptr when refcnt > 1
>   selftests/bpf: Test overwriting referenced dynptr
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: Allow overwriting referenced dynptr when refcnt > 1
    https://git.kernel.org/bpf/bpf-next/c/017f5c4ef73c
  - [bpf-next,v1,2/2] selftests/bpf: Test overwriting referenced dynptr
    https://git.kernel.org/bpf/bpf-next/c/4cfb09a38357

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


