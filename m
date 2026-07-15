Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBEE3644C5;
	Wed, 15 Jul 2026 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114433; cv=none; b=ONFph4gH7Lc2UzFDfyD5B1uFKzrOmP+XFaMmj1puZB5gERor0hVi9I/+8w61+rYvRfyLcXmZLu1xmcrr9zJ84cRX330J0uf4Lzy8WzwRzegeJVi2SkBkwWwA8Zdy37l91jtKYdrbqWLssbFOTf6x7CpIUmbwmXKnNJVsC3w6sPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114433; c=relaxed/simple;
	bh=0NcWneMKzs6bNMV2FYY4+6v7TNNTf1TS4eisR/SLjvI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PSSmYX/KwtsvDyNNssNNzAOc7o9HmD5VedJvyFG7JJNTPQhBchyr434f8qMzts1df712Em2WVQ44ZOsaiLfvzcmaPZpSsjc/rMZIQWYmekG4qENtDMuy9pocYbZIm9jB/trUdpXgI0N/ZL/+6z3BKYrt5IwNZ39cjmqulzsAmig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0/vtt8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0/vtt8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223EF1F000E9;
	Wed, 15 Jul 2026 11:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114432;
	bh=xK7lmLKOgzYo+r9AmMW2eLh2JhwZ/hLDl7uoITZGQR4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d0/vtt8dZ9yFZ4+8QNNJ9Le0V2qIPlonrjJN0Wa8YpAw7q+JYfStUG+0avmfI87ZQ
	 cJ7p4K76OQjhF0hgHwkSt08OEjWSeggJYc5GgEpdXaA8ejEAdaFidC/hnwsCsyht1v
	 qD4Yzxkix3w+l9uyDrkHPqYn3lNpMSoqla01ZOVP4gCANaRYpf+KEYBwXy/czV/7Ya
	 Qg17SPgemlWfThFvL0Wp3UISKed2uN7gH/nviQgBkFFSGE9BXVeJQNc7Fn92/d9NGY
	 zspI/uVDYCr5gSmZcK9i307azdvtxMcA3QRxQ8GC8ZPQSajVPw1KwhgYa2dyhK4sx1
	 Ipdb3dGTky4lQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569603939352;
	Wed, 15 Jul 2026 11:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix fib_lookup VLAN tests on
 hosts
 with forwarding on
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178411440591.4020782.15937168768043001912.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jul 2026 11:20:05 +0000
References: <20260715100349.2684391-1-avinash.duduskar@gmail.com>
In-Reply-To: <20260715100349.2684391-1-avinash.duduskar@gmail.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 shuah@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 toke@redhat.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 15 Jul 2026 15:33:49 +0530 you wrote:
> The VLAN tests assume the test namespace starts with IPv4 forwarding off,
> but a new netns copies conf/all and conf/default from init_net
> (devinet_init_net(), with net.core.devconf_inherit_init_net at its
> default), so on a host with net.ipv4.conf.all.forwarding=1 the devices in
> the netns come up with forwarding already enabled. IPv6 uses compiled
> defaults at the same sysctl value, so only the IPv4 arms are affected.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix fib_lookup VLAN tests on hosts with forwarding on
    https://git.kernel.org/bpf/bpf-next/c/d1f4b56417a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


