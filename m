Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E60F386575;
	Sat, 15 Aug 2026 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786830064; cv=none; b=a30jtrXq4Ie8iLmvvYYg+0qw6U2nl7MA9GSpYu1J4efraErL0fG94vNJ3tdf05UPeGvmE2e5xDRZL345HCsRkFz0UK6N2P+vvXXl1brQKM22foWMYsSjmxZf4yQURvGPZmgdH9ZpEuggG1N4kqGJwY8wyB25Iig/EPO60/VPeLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786830064; c=relaxed/simple;
	bh=r9J8gx9IX9cSiMhW/DVeiKNY+yUo9gO1YTbdx4Ymemg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D0+z3DFICPFsqFbVViDOsJqKNCPQaCvtPGkPWD/eNiLKubCyHB1Uiw8IKqI42tL6jUJnoL5Yx6lv4rzLAzgbiqn5PyDVAHAOqfQp3dtaLhQr/j+ajlkjCBX3OOtjkXCX1PRG5bXABdcd6aHs6Lnq2gIbxgoS+cH94iv2jwjnvFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSnFye3Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSnFye3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4246E1F000E9;
	Sat, 15 Aug 2026 21:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786830063;
	bh=oTaC///mkAqgsedHRzVd1gBRz+aGX3C1gNf2mMv222I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MSnFye3YA+yE6D/70d+uTPZ8+FIRtA9lQwjS5/2fTFBx7s7+tbOxa8izA1CRai4EW
	 oJ+mmhFn7P5OlTLiyiblk2+fBeRr1htvG9JXAvsJV/fd2M4yuvYTC7NSxzFBdZ8Gxp
	 wpaVr45ZXAHNzceA/cdT2/P+ujG6P8RxFbTNY1SrCtTvsed6DhcOGBi6rxw1HaymSm
	 dkixtWlcwcBNzKU9iXnoHbK+K3BjLQlhSworULANzZo6sW3qc8XJm//j/YwxYQpahO
	 jkLJdAjjp+WBsVAblf6v/EjvyQJyskZ5YVjXzvAa86yCgYkJO7RYpbEOebjXk/Osdu
	 pDDDOrxmnXB5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A253924A4F;
	Sat, 15 Aug 2026 21:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/5] Introduce bpf_ksock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178683001639.93126.16574683717755052782.git-patchwork-notify@kernel.org>
Date: Sat, 15 Aug 2026 21:40:16 +0000
References: <20260813110540.103550-1-mahe.tardy@gmail.com>
In-Reply-To: <20260813110540.103550-1-mahe.tardy@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org,
 liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com,
 song@kernel.org, netdev@vger.kernel.org, sdf.kernel@gmail.com,
 ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com,
 jiayuan.chen@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 13 Aug 2026 11:05:35 +0000 you wrote:
> This patch series introduces bpf_ksock, a set of BPF kfuncs to allow BPF
> programs to create UDP sockets and send data. This provides a mechanism
> for BPF LSM progs to emit telemetry over UDP independently of userspace.
> 
> The main use case is to be able to completely dispense with
> agents/daemons for BPF programs after startup. In the case of
> Isovalent's Tetragon, the idea would be to be able to emit security
> alerts or export data from BPF even when the agent is down. For meta,
> according to Liam presentation[^2], this could replace logging via
> ringbuffers which created cross-binary versioning issues.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/5] net: Add connect_socket() helper
    (no matching commit)
  - [bpf-next,v7,2/5] bpf: Add ksock kfuncs
    (no matching commit)
  - [bpf-next,v7,3/5] selftests/bpf: Add ksock kfunc test
    https://git.kernel.org/bpf/bpf-next/c/c7838e3dc61a
  - [bpf-next,v7,4/5] selftests/bpf: Test forbidden bpf_ksock_send() LSM attach
    (no matching commit)
  - [bpf-next,v7,5/5] selftests/bpf: Add ksock test for async callback guard
    https://git.kernel.org/bpf/bpf-next/c/c93cbdb13f99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


