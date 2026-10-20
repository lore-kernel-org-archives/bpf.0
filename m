Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530018;
	b=tkFMFmrJ0XTAxWZK3czJfiZj6u8kfymWjZwk+mMx3ZXb7EdvO0PRRJ4igNG9+YdiFgFF
	 zxj8MrUnVVLVp13MfkXZdO+zeZFGp851NUQny50iz/tpapgv7RGdMz32w7cIzgwei4/FS
	 V99VwZHrwE6P32os73/qzx28nHf93pHmHsmfmD7v65cqW269Lw3VlautzWQmAzp/3E7sx
	 l1aTAD0mLasQE/ykvTxwYGhSBfzPH/hFLZoSygsGs+oM0/csisCYSXkje4z25gLJ4CIEm
	 /UO7yItLC5UaSSuT71Jol9FpjTjk6wW8+U4txkG4tWZik2Lb6dJcAAQpszyAaYx4cgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530018;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=BZZiE/z5rF980Eqj/J1JcYevvChj0IOpKnbHsSSVniM=;
	b=ypFM9C3zn7g9TjUJ6fIJwXkwC4/NFsR8wtOY8Y2OIumyfH0E+AEnfDT3IIs7u4IUBD0w
	 ycP/nGbcqVCQX0WtVW1mwuqo89UL1EMLJWyNRfO+FNaENek51LavuEI3mjduagkCEDtZm
	 7J63wJJ5abKIChOapnbV9JWaOLyFkwLgAIUMxWmArS9JFt/2j/zoMXX0TmnUtXEpxIKCO
	 tvog2NYnnKXK2bEgCgsqcBNa/6dbUon3213eiNh6Ck3qSkU6ysJN82n4P8igjXn6zCz72
	 0FAwjLYyVAqwq+zKBAPsDMIlEve2NwnBrdVwpcrLhPKKzb9z70JFgGwDtUuC4qlj/RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IeJjFuJT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD47C606A323;
	Tue, 20 Oct 2026 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IeJjFuJT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4793D1F000C9;
	Tue, 20 Oct 2026 21:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792530017;
	bh=BZZiE/z5rF980Eqj/J1JcYevvChj0IOpKnbHsSSVniM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IeJjFuJTBZ8Q+/YnFuqhKvBtYb6tY3GAHR7MJaAL1Amv2QdPTWFbCNJaq625kkEXB
	 GgEqRvKupjra3zymov9ysXZ4P5bCPVuKc3Yt1NB0VA5y8j7h46y+NAfDHEKOXlfVQF
	 oUYtYWBwoGCX3aExmqbVEnjy3ryFjb+Kf0fj8SPuTIKkdakii4093KXZlUIITsp+eZ
	 r5hGOBc0N4p8rjeH7FaTEVj+Ix/gVDQnk4/j8RoGwO0P6qU8261zzEj7kuD0HyuFGz
	 gKEOugMV+QTik/h2rMwtHJvpuZGas6hDmRpakbsa64t0yNXKXzZ8w932h6TKzx4h25
	 fNz+rwQeLh4sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3E53809A09;
	Tue, 20 Oct 2026 21:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] bpf: Add bpf_ksock_sendto() kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179253001577.208021.3409263261084470234.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 21:00:15 +0000
References: <20261020155848.75711-1-mahe.tardy@gmail.com>
In-Reply-To: <20261020155848.75711-1-mahe.tardy@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, willemb@google.com,
 eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
 kuba@kernel.org, horms@kernel.org, liamwisehart@meta.com,
 martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
 netdev@vger.kernel.org, sdf.kernel@gmail.com, yonghong.song@linux.dev,
 jolsa@kernel.org, kuniyu@google.com, memxor@gmail.com, emil@etsalapatis.com,
 almagui@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 20 Oct 2026 15:58:45 +0000 you wrote:
> This patch series improves the bpf_ksock infrastructure in line with the
> work proposed during Prague Plumbers 2026 presentation[^1] by adding
> the bpf_ksock_sendto() kfunc to complement the bpf_ksock_send().
> 
> This is useful when using ksock to reply to differents peers while
> reusing the same UDP socket and generally works toward the goal of ksock
> to support the basic socket operations.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf: add bpf_ksock_sendto() kfunc
    https://git.kernel.org/bpf/bpf-next/c/74be619845bd
  - [bpf-next,v2,2/3] selftests/bpf: Test ksock sendto()
    https://git.kernel.org/bpf/bpf-next/c/7d563ae3ed74
  - [bpf-next,v2,3/3] selftests/bpf: Test forbidden bpf_ksock_sendto() LSM attach
    https://git.kernel.org/bpf/bpf-next/c/d90912846f26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


