Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6CF194C96;
	Fri, 17 Jul 2026 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784249440; cv=none; b=iibsCsaFo6tgrBxDRPTt5hC6y4xx+F1on707OlmU5OQTXihM2ZHU3Sn0ehUsj5lASBbwIuevGMeykPUJGh1L6EvVMw0SG5ofOkTFlTlWI3WMR4VeTLi+eTaXdgHl4wEHvXfiLitaKmo3LsC49DznCm9I9L8+W6FpKXvS/jaqmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784249440; c=relaxed/simple;
	bh=mv/ZqKV+A4iIZ1OBQFdjcegc+1pNV28NTIk0nlHZS0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mdxpk8FZav+RE1OSHYDO9BvAaJ5yQ+h4uAuucg5AhYts1rnSXeLouSqiK2U4aUO94K7e2/CvCxRqv+PJcJj9bB6zSzscDNUQed7CyzoLw5McQ+00tj7dldjCOoWr/pybRiHpIqyZ2+n+LYz4FKwynTUh3Gbgqu1D0QfR1Eyncoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHX3FdZo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHX3FdZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2331F000E9;
	Fri, 17 Jul 2026 00:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784249438;
	bh=n1gMdrI3Q9rjWX+zRZlsTMXPTaWDy0K0K2F4e6/E/qQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dHX3FdZopIUiFCYYN8ei8DXASLnAJe7ZmbSj26yjQRRu8rvbSGtGre77VZ2QyaZ0K
	 /6COS1bmkTg+SVIZTwZwEc6DGqyzii8Z5pOH0XkuB1NuDBCNgOIBSo/iidGkp0GzFH
	 2OI89lcDt0kA4j4a2tmSIkEmZOmvh45N+tCJ2jJPcKMTBAUSw5W0dvf1qk3g9hlV8C
	 mCoL9ns3LQIfdJ0vYeoDkm85DtPL/4vJiSJuZjJcVqsBkubBHdWmOUQPKSL/mDOpOY
	 O/7+nENQGRDYN9RW0m1urKbl5yYIMzc1M4E8CW3csuu27aUitrmzLHJxve1FwY1uMZ
	 dP6BnnNuVQl8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A89380A97A;
	Fri, 17 Jul 2026 00:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] Fixes for tailcall with subprog and
 callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178424941139.1475787.18080893330670192934.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jul 2026 00:50:11 +0000
References: <20260716120157.835937-1-pulehui@huaweicloud.com>
In-Reply-To: <20260716120157.835937-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, eddyz87@gmail.com,
 bjorn@kernel.org, daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 memxor@gmail.com, yonghong.song@linux.dev, martin.lau@linux.dev,
 song@kernel.org, jolsa@kernel.org, emil@etsalapatis.com, pulehui@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Thu, 16 Jul 2026 12:01:54 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> This series fix two issues related to tailcall:
> 
> patch 1: Fix tail_call_reachable state leak across call branches.
> patch 2: Reject callback subprogs invoke tailcall.
> patch 3: testcases for patch 1 and 2.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: Sync tail_call_reachable with callee state on entry
    https://git.kernel.org/bpf/bpf-next/c/3513ea9dab6c
  - [bpf-next,v3,2/3] bpf: Reject callback subprogs invoke tailcall
    https://git.kernel.org/bpf/bpf-next/c/a41d0c30d764
  - [bpf-next,v3,3/3] selftests/bpf: Add testcases for callback with tailcall
    https://git.kernel.org/bpf/bpf-next/c/42bfd21a8b70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


