Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AC2E8B9B;
	Mon,  3 Aug 2026 01:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721847; cv=none; b=ETF8aNO3rz5rbf1e/EsgVzPLd2d0bUvoW2J6ZfbSEj6cbnFrA241vsiGrinvT3NS9JIKg7hH9MgqUa01GKRdvGhvKb/X22eeatX4tXltr+CpXH+dLalxi5zcfahgHACPnuCu7IcVKm5evxM5TK2bPdGW3x+nYt9CDBveCV+Hl8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721847; c=relaxed/simple;
	bh=hM8hbIvaGufZ5tz8ZcHq3ezDSkLfOvRbKJq4mJE+698=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KK5+S0SUn1sTPMyGkIIv+D/Ev6ih2/v0EG7tI6H2irsJ8/kDEMBmWkkCq7OfYOdKqOmvr0l13YV2Z8wlYFLPf7T0o/LuoVCqdlnNn4H/fCf3x1ZQUlRP+i0kRydt9yzI6V/NFClmvmO9LNySTbEl/nZBG2+XT01HDobJUXpKpuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W18c6lOq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W18c6lOq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80D21F000E9;
	Mon,  3 Aug 2026 01:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785721845;
	bh=seDND7QMza+Si2gyrbvlT9ZatbMFCqBhLBDcjCFl0PA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W18c6lOqO6Bfo5JsuFtvwjCUpKdaloT4tOLcxE3hJiQ/gF4DSDvvteMmKoG50Lv7x
	 btCbd1hKoAWSsnULjVKe4BBUdi0xtuCqCMh+AMDntYyJfh4HkhIF0pYSIEDFKuNtxV
	 zj1O/2jycMxGyY7pf2j3bFWFRcI068MSaQGY/UrCjvYEN4MuSytwcecLYDhLyqJuBj
	 hI+8oYkz4b/CvfGaU0qIF495t4OH7xOdQV0dqtn4gq9mJtwiBsxap7sbZTpE2k/zpk
	 fJTc2P/kaM7UubuG91pPID2t63H7LbOH3BQxPao0kYwHb+EfQ1mh92u3zM3eM4QQT1
	 DObP9WyXqdqOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A3E3809A82;
	Mon,  3 Aug 2026 01:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Allow IP_TRANSPARENT and
 IPV6_TRANSPARENT in bpf_{set,get}sockopt()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178572180715.1984759.12851810838710096236.git-patchwork-notify@kernel.org>
Date: Mon, 03 Aug 2026 01:50:07 +0000
References: <20260801051307.478469-1-shivajikant@google.com>
In-Reply-To: <20260801051307.478469-1-shivajikant@google.com>
To: Shivaji Kant <shivajikant@google.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kuniyu@google.com,
 anubhavsinggh@google.com, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sat,  1 Aug 2026 05:12:59 +0000 you wrote:
> Currently, bpf_setsockopt() and bpf_getsockopt() for SOL_IP and SOL_IPV6
> only allow a small subset of socket options (such as IP_TOS,
> IPV6_TCLASS, and IPV6_AUTOFLOWLABEL). Calling bpf_setsockopt() with
> IP_TRANSPARENT or IPV6_TRANSPARENT fails with -EINVAL.
> 
> Transparent proxying (TPROXY) and related networking components often
> rely on IP_TRANSPARENT and IPV6_TRANSPARENT to enable binding sockets
> to non-local IP addresses.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Allow IP_TRANSPARENT and IPV6_TRANSPARENT in bpf_{set,get}sockopt()
    https://git.kernel.org/bpf/bpf-next/c/dec58a70d4e7
  - [bpf-next,v2,2/2] selftests/bpf: Add IP_TRANSPARENT and IPV6_TRANSPARENT to setget_sockopt
    https://git.kernel.org/bpf/bpf-next/c/60781269e26c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


