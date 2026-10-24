Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814409;
	b=mA5SQZ8gR8+5pLoh3DdXAA25d0bnLQt74NYEyZPLQquorMtX42Kglf9U0Pr6NzaIE7hW
	 o7I93Rfq4+uyCAK92klvVu3kVHlpKAtzgSiVqbqzqp+RoXWMedaqFXOLONyh5tftUrBZV
	 KOM/xQJWAMtUnv7+P14j7f7x9l0WH1ffkhR5OrbtFHPiEZeK2zTm476Ozdyt+5N85vG2W
	 aBUUM0g3jgSIOuNdJaGZXxRURdPGHaVfNHInvqbznSwRq9EzyNsrBVKXZtlo6sXR9jpl7
	 LNja/RKbXoJnp2JvhK3sWXNwfIij97RZi0qDBfyckWMF9VQOSFSZhIsWkYL12buwD1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xzFdIIa11YBDxQ8I6g0C+Blr+Y/lvRqAXL1ZChvDV3M=;
	b=pq2jNlPukQSKuZnp345WoeYXwPJNYwGGkjOU3rPtjuzow8MMsGImJinGf0Kj6GsxQKvP
	 tAoMSJvl3pUvGaMWX4hzuX5xVmqdL5r7dJRYu0pdHJEdTzfbRVo6OohNxaiBsunVkn9SE
	 eCw3H6LOWHSy8yyhBNl0hy103FENkl1/2LrYHCaJgLcgqfj6DzPJcrhnuC61geNojDvjr
	 iRmKbs14MSDXhJsLExz8B2G+9I5rxSzvBaRYlWmZk2NSj5JaEDVWsDrwLT51WtQbWXAdz
	 mKF3HBW+SB0TNh25KpJ/Qs2duvAbBrMP2J+EZrtKCHWohtT6XNUGVqi2zidPVertOaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/ALKu+t";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845B9606A31F
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 04:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/ALKu+t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED401F01825;
	Sat, 24 Oct 2026 04:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792814409;
	bh=xzFdIIa11YBDxQ8I6g0C+Blr+Y/lvRqAXL1ZChvDV3M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m/ALKu+tytuoUNgKhYqUr72ESEtbpVWpx1IXObq4QJYiEYOGOHCbG/ZdkDVIBosnW
	 UGQTA97tC1hMxCKqCjs4CV28H+sKOUsxigVrqr8VJu6jJWMC+sqKuKxuHlu+W8jTNR
	 wvp+PZYcgZsAfaoY8XZ9f2z8EEKuDXE7UvXdUZ39smcJjyzLIjDR7KWBQM0lUddh/w
	 uhQpwwAxgxQqpAvKIcs2b5f8sWeiuCopS30tCpGL8s639PO9zbOU5WGDlInOabvM95
	 o63/02Vnhc7v2ILg3AJ1jrt/nesmPgOYGuOaJfy4+3LiBO7gxgy5rlJADGDFjGC617
	 6MWe679fXMvfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 073C8391B17A;
	Sat, 24 Oct 2026 04:00:09 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix x86 JIT stopping before jumps
 converge
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179281440756.1452471.11448260868452726971.git-patchwork-notify@kernel.org>
Date: Sat, 24 Oct 2026 04:00:07 +0000
References: <20261022-jit_size_fix-v2-0-4bee6921b218@meta.com>
In-Reply-To: <20261022-jit_size_fix-v2-0-4bee6921b218@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
 memxor@gmail.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 22 Oct 2026 05:04:54 -0700 you wrote:
> The x86 JIT stops its sizing passes once two passes give the same image
> length. A backward jump can grow while other jumps shrink, so the length
> may repeat with jump sizes still changing. The final pass then emits code
> of a different size than was sized, hits "bpf_jit: fatal error" and the
> program fails to load with -ENOTSUPP.
> 
> Patch 1 sizes backward jumps by the insns they jump over, so no insn
> grows between passes and a repeated length means nothing moved.
> Patch 2 adds a selftest which fails to load without the fix.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Size backward jumps by the insns they jump over
    https://git.kernel.org/bpf/bpf/c/ebf0ab370bcd
  - [bpf-next,v2,2/2] selftests/bpf: Test JIT jumps which change at a repeated image length
    https://git.kernel.org/bpf/bpf/c/a938f51d3522

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


