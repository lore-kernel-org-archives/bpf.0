Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE614347503;
	Fri,  5 Jun 2026 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780698619; cv=none; b=K323eTVu1vyhgKbgIvvn1FfJX8cs24V+hLqf6vLhwtIOb/WgmU3xB6iwe2Hme06FWj+eTrcR0QCPqSnJpyaDsnTx209sJZJpho9lgv73jYs40xmaecZosFnFf7+Q8DJJB1xMTZMWRbSFNvg0fhkj3KGYMPu0xZEL5muFVPWbm1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780698619; c=relaxed/simple;
	bh=U19LfsRgdKwSeFFxNxoOrtmBuXFDufpZJwURLyY5NTo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N1d3tbz2y3ynWsGzfbm7YG/Ci2WrBO2g/BCoph2eytxfC5Xzs60SMkgKUUECYGN0qQXI3QfB+2qBnDrWUSi5YcMbnryaNLXjgHSH9XqFHHvfuOHme2GovXYItyAPPi846pWbhB5KDupYnJ9gw+XJjnnSE6DXVm7xRo1JXCxsYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wh6I3zhT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wh6I3zhT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646671F00893;
	Fri,  5 Jun 2026 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780698618;
	bh=hlmbBlTrqmrDYDpcjR/k4okFjgvx2UOIyy3ZPtCIGN0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Wh6I3zhTa9v7VW8fXhj1NdVZJBx8npe087gwZoXvPa3vLURhF8HfoRzsK3l6kfVUO
	 8KW1oR9Lw/5T0K1PZH4+9DAdzZdFJEMkcsljyqjWNwALFKlMmEAZ5qyZEbuyx0dsRK
	 vKaCkvuLDhi6N6J4nqa7QY7jdm3MLR0wkk6FwUqL02HMYrudiBZzY7K+Bh9YLRmRLw
	 Amg0cu5RUvXgk5RTuQevV8rloV72bECeu+yPZpogltxIzUskscrAOpM57JRVukC/U/
	 dRg8b4lg2Zjcunh/40o08rakXMSEcRco/T0lB3waE/cJcvHLyjPBHHm7jKlaPUaEDq
	 aymzKAz40nMjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D098F3930C04;
	Fri,  5 Jun 2026 22:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/2] bpf: Update transport_header when
 encapsulating
 UDP tunnel in lwt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178069861864.3943503.1557962772185018635.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 22:30:18 +0000
References: <20260602150931.49629-1-leon.hwang@linux.dev>
In-Reply-To: <20260602150931.49629-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 gnault@redhat.com, idosch@nvidia.com, fmancera@suse.de, posk@google.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  2 Jun 2026 23:09:29 +0800 you wrote:
> Currently, bpf_lwt_push_ip_encap() does not update skb->transport_header.
> When a driver, e.g. ice, reuses the stale skb->transport_header to
> offload checksum computation to NIC hardware, VxLAN packets encapsulated
> by bpf_lwt_push_encap() helper may be dropped due to incorrect checksum.
> 
> Update skb->transport_header in bpf_lwt_push_ip_encap() whenever the
> encapsulated packet uses UDP, so checksum offload works correctly.
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/2] bpf: Update transport_header when encapsulating UDP tunnel in lwt
    https://git.kernel.org/bpf/bpf-next/c/82d7d0adbc67
  - [bpf,v4,2/2] selftests/bpf: Add tests to verify the fix of encapsulating VxLAN in lwt
    https://git.kernel.org/bpf/bpf-next/c/5477d55f351f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


