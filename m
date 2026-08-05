Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19C3A6EF1;
	Wed,  5 Aug 2026 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955851; cv=none; b=R4gOlg3LdZLFbDbz2GPHhLwEUkk/ZtMzKqoCV77OyOIZ/Jeeu9gHcKWBzVo7ZHIsw2IqXp93sKt2okLoWJf9aniDS9HEVLkxQ1gXre+pG8nGUrKw3oQTMyeq47qjMV5fLdVYLlGlcM3HJ+JljD+LKxN6NMDBYO5Xs48T+OFQfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955851; c=relaxed/simple;
	bh=+IKzGTkI0IE2HoQPbkT6tmm6ABvnhWQz9HUilx1DejU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JN6eQxCj5X5V9+75AVkOzbgkAJv/QfePmFlbo3AwrhA7Tc8/uV1iiXZ/6QYd9D7HsKme9vlj/s+SNF23WilxXhT9Vn0uh/BhpiAbwd1DrV9dKYMmTb+ERv2z0zZ0xZAErhiia9textT/eF6/NiWYiTwI/zbTKRloDQ6tAYVAYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gajx3gTe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gajx3gTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFF91F000E9;
	Wed,  5 Aug 2026 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785955849;
	bh=POZ8NcYk2hT/7JnAyuDtTDJ1zWN6iu+RzDbVxr71B/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gajx3gTehn/yt6FvtOfVoe5HZHMpSN9Yz+BJGsjqwIlNbNiCCYxQbEmp7oMAqVrMR
	 Yb9GVcveiX5PnXguxOZrz+c/3bz5kuvNw3sGicP+SdZylohnFQ2lvNyVYOZvunDdAu
	 SAd/dVNDXSjgYp5vkG7nF4PWCB5vFHnbjT70FipYtxY/2TxJ4EfMmT3VDUzMJLU1/q
	 PyEvfD94mJo4JvowWL3EV3iIvQQJH6bAKGTkBI/37bZCqHCTILyJMP0NIn4x5wQEH1
	 tDm9AWkfLFgAv4lTv/Yo9psd7YG8LpAyV4o1i3Lk+RpqOHEmWMvtF+4cI1/D98+n7K
	 w2px1rJAU7jBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A44392FFC3;
	Wed,  5 Aug 2026 18:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf: Fix sleepable check for tracing/lsm
 prog
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178595580939.485227.13936630340553482919.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 18:50:09 +0000
References: <20260805150810.34907-1-leon.hwang@linux.dev>
In-Reply-To: <20260805150810.34907-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, rhkrqnwk98@gmail.com,
 varunrmallya@gmail.com, vmalik@redhat.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  5 Aug 2026 23:08:08 +0800 you wrote:
> When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing prog
> is allowed to attach to '__x64_'-alike prefix symbols.
> 
> It is because the verifier does not verify whether the symbol is a kernel
> function or a bpf prog. That said, a sleepable tracing prog is allowed to
> attach to a bpf prog target whose name has '__x64_'-alike prefix.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Fix sleepable check for tracing/lsm prog
    https://git.kernel.org/bpf/bpf-next/c/00244bdaa423
  - [bpf-next,v4,2/2] selftests/bpf: Verify rejection of sleepable tracing prog
    https://git.kernel.org/bpf/bpf-next/c/045809795751

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


