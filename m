Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896808;
	b=i0xkmw6QqaR/L6R4+J/8tb//ThNC+ucBxoeqIhYfgZTMG72+eHZBvItnsrXGPjnEw+/W
	 z44Rq3/ciJVqUaRNW3oIU5QYzvKWAT33G8s7SBOIrcA7JwKQDMfPeWtQs2vM5LGwNG9pu
	 b9gtN3KJe+wEVkKaPgA/yGIeZf7lIHOenqKwE48Vc5JFGxqZemqjX4FT0vvQHrBXo0Q5m
	 CNwCBVc1ag5FK1WdY0kVSmP/w+zcWp6JF+BsIP0ZzxvvMUPdL2EanZXxHOu/D9rEmSSfI
	 Eddv6heXAcf3lUCARJ1JuX4j0EWRRNRJAJBHbJTB59XCqvFyKEpzbo40tcdcayJttGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=LE08nGDKxsOc05AnGuwLzDV6gM2iwaT2sNXJn7pQY+o=;
	b=5SWOhv5u5oOGwYPDL1EirDE9LhSR/J/c5QsA1M67McamffPWLSvLKWW9PtIr9sUr7NrX
	 o/hsFr3tli0Jxed03l0ynja56xO6xZM98mr9d6PRtK5TnGNDHI3O3yPb+n48E++x1mNWW
	 QEw16Jqpcl5pfnueFrpH9SlAM5xEbMacT9FyqhGTJMnzC2IaOOUGe5F8VXOMkskyWrcM7
	 VeL+IyzvgKfL5iMPPH6LRaMEMS6pdgz4ZDBSWlyhuVfjkuemrE52s+or3CvXx0JavXxxm
	 0eqojN7bhrE5BL5SHkXwrVAKBS4VKUtuYkVGqwjoG72b7RUCAn7aZwLcAxZ3IJdiqoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=caTUBmZ7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33507606A905;
	Thu,  5 Nov 2026 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=caTUBmZ7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CC81F00A1C;
	Thu,  5 Nov 2026 16:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896807;
	bh=LE08nGDKxsOc05AnGuwLzDV6gM2iwaT2sNXJn7pQY+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=caTUBmZ7Xr/AGAQehoXj4WY+8263LuNfudSraSKSIAGKCwXHPRB2BcHzhb4HRunsy
	 TXHw0SdvYHnfjeJYHKRum0oEjTwXHXvY9P80bxOVCQiOYTzAKiL2lWnCL2CeUfu/kV
	 mw6JV8DzmCDOD4Wkrg/1jy0/bK2J/r4MzLSGAT7MGu+lIkx6aQvTylks8uj9Cpsxup
	 SVX/o+s2PfTBVx0iFmHXFM9VIR4qh9QP8oBjqnQasZqm2q4QISS0rUDIMMLfYdJVM+
	 rzlwfhHdfgp7ox0dT230WSltxrp9z93ZmyeDr6L/a4WRUhGBj7lWgtX7jPTgYh2GJS
	 FLl3A3MSO2+Xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA3C8391AFD9;
	Thu,  5 Nov 2026 16:40:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next] bpf: Use 64-bit writes when inlining bpf_loop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179389680630.111114.7640140535035639069.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 16:40:06 +0000
References: <20261104032700.55296-1-dennylin0707@gmail.com>
In-Reply-To: <20261104032700.55296-1-dennylin0707@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  4 Nov 2026 03:27:00 +0000 you wrote:
> The error path in inline_bpf_loop() writes -E2BIG with BPF_MOV32_IMM(),
> zero-extending it to 0x00000000fffffff9 instead of the 64-bit negative
> value returned by the helper. A caller keeping the result in a long
> therefore misses the error when testing ret < 0.
> 
> Use BPF_MOV64_IMM() for the error return and loop-counter initialization.
> Neither write needs truncation, and this avoids the extra zero extensions
> required by the s390 and RISC-V JITs.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Use 64-bit writes when inlining bpf_loop
    https://git.kernel.org/bpf/bpf-next/c/8424858a5de0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


