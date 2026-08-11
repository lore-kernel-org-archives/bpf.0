Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07740DB55;
	Tue, 11 Aug 2026 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438851; cv=none; b=eM9zTYoEFM06+6Csc1UvsRnFOK8FV9jt+3F3EPGF7+hCvOaV/q7gBTx5x172e+Ef/Ju6LmeQmg101tSYIhn1FDZs4W55i8z3hrSOYx0YQkKqmzGyARik4a7NIftPxKUoE8p4M0HMgBmLIaiy82paAR6dixj5Ij12Qe6OLbT4bRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438851; c=relaxed/simple;
	bh=zPa5gQjd87pxw5j1/zqiAs8OPccLs3XzN4mvupUEIVM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qZj2H+BpGqNF4qZOpf36D4YFOJe7c16Wo5XhGrn+laLZ/TIMBdzHdkgHoogz0gcZA/+9RQjh+VEckCxoAyQSDhS439U7OCgfLjoZ8JEHvkosCOSwnUtUoUUB/aRbhsmSy0LsZnmT9ifh0ezcXFs0AYOrS5YxhO5OCuaUJ4DjKbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNu+sC57; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNu+sC57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5D51F000E9;
	Tue, 11 Aug 2026 09:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786438850;
	bh=EchQr0zd1qqmPYlNJ/VG4LDlQnn0sGNB6b86Y+LDId4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZNu+sC57NhSUNyoYcm6w05EmJHy378oCcRDNjIa0iLie3qfGxWvmZkmcUJS6VtODI
	 A7ZJ7liGVmuhpYSI9RRxsXiVYUdYXIgaNvW4d8EfB9cMQ536/og2Z7duqRTQgN0Az7
	 XoqxQffnN56sHzigybHQ0NI0p4yswivgfKBlqPDN8i72G/31q30l5kr/cXbfepuoFP
	 pVNIGra+OJ7280c+EaSur/Zsqn2v+CpCPz5NRw+IT3mhBIjfuATA0gjj5sok0uFEXp
	 GrvZnw2LSshq5GWtIBnZwdvRUvJs4thZGiMfDV16QW7dMQCERMYdMo8o0wEDB0JEKs
	 S10BwhwiO4Uvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A1F39263A4;
	Tue, 11 Aug 2026 09:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: net: reuseport_bpf_numa: consider
 cpuless numa node
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178643880650.425104.3752643968566507501.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 09:00:06 +0000
References: <20260807002436.43991-1-feng.tang@linux.alibaba.com>
In-Reply-To: <20260807002436.43991-1-feng.tang@linux.alibaba.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, ak@linux.intel.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  7 Aug 2026 08:24:36 +0800 you wrote:
> reuseport_bpf_numa case failed when testing on a platform with CXL
> memory:
> 
>     #./reuseport_bpf_numa
>     ---- IPv4 UDP ----
>     send node 0, receive socket 0
>     ./reuseport_bpf_numa: failed to pin to node: Invalid argument
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: net: reuseport_bpf_numa: consider cpuless numa node
    https://git.kernel.org/netdev/net-next/c/88b8d85e889e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


