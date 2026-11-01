Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793494806;
	b=tFYcWkQhgNZ8H9gv7wTZYRxVZ6eU8aBvmPbJz5CsCPNlcVOHoiQAm+oj9Gsr3qG/uQ9u
	 +kC9WZY1iI+2U469/0/bW4SG0XCqiEAsvlLBloilwdHc9/wFJodyTliNpAvxMjkCCTwsK
	 gjmpv59Zx/ErMEeMsk3wuTWKie/HQr3ztUJU0p18V06F/yeMfHMJSvjfcgkPds+e7wAWf
	 nv99N/vtiUEZZ3KhQ6HJbaLC1jwscuhTMNXi+qVW38SkCnMMDBiadOa/t1TbQNkTS/thj
	 GBaGkT688rxEXYI/UXXcgGAH6sn1259VnMNCF2aFT4gqrKEAGAT8o9GmMo9yySti2uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793494806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=gKYIcrCcAPs4Ien8ScZ79f2Vh5NZpcTlH9v/5KjpMHg=;
	b=a1FTEq3ngKDZuhAtM+uMJXk25n3psUr1s21C/46V40qu+z30YSQH7pesLBeTzBtzKCaR
	 vsiGCGvVwFBeKnam+ki2kAtZ2UcypbwTAXA65fnwT/aYXMAGtb0EC37B8WLQUi7mz1s19
	 8zkdPuslez4GUxBT0jkSoyfBFMKzC28gat9n1ZQZaYQLrZk4MQERoesGO3VJLZ7e9jLXW
	 ipWXTWRbaq+otMWlRSsSchDHLcxULaDrTiFmwjy4cay8DSRuFM3LAwguP7z7x1LSycLvn
	 rfVmwu1/KNfBeHsCC+SLD9sFXizbcG+gG7CWFfEKceIvj+qPSOz4OStddrg6brB8YNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eE2FyNx4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E7606A31A;
	Sun,  1 Nov 2026 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eE2FyNx4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8041F000C1;
	Sun,  1 Nov 2026 01:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793494805;
	bh=gKYIcrCcAPs4Ien8ScZ79f2Vh5NZpcTlH9v/5KjpMHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eE2FyNx4b4qvYdV9XPXg3FnOYbPFdfA0lSbRArI2b8BO0lGGobkE1QOEoiRa37vDO
	 vNuIeakTvW4z/vCk9ZwSKWUbHmpfdD3YVfEcuV7CPiLxo9F+T/A1Yo9xp6p7+WcNFr
	 GOm9FoegFp1enkC8CJyOG0FCcWVLr9hMGWXUaW0EVS7r1yPG1cctyFseNjSeYbtO/v
	 zwmUgesEMD7ectbNpRvZFCY1O5AzHNc9HZdzGP4bN8CemXWZmAmD7OTds1+tDC1I23
	 UripujIwTEkOD32DbR8zghvrg8XL6Bpv7zwUlaa/0wUUDKlXVULENUEA/UJekJSPnu
	 fbuxnh/P/9z9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1A138003EB;
	Sun,  1 Nov 2026 01:00:05 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next] selftests/bpf: don't count skipped reg_bounds
 cases
 as skipped tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179349480431.2292683.4825596703739217680.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 01:00:04 +0000
References: <20261028211921.1055711-1-vineet.gupta@linux.dev>
In-Reply-To: <20261028211921.1055711-1-vineet.gupta@linux.dev>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 28 Oct 2026 14:19:21 -0700 you wrote:
> test_progs-bpf_gcc reports an order of magnitude more skipped tests than it
> lists.  A recent bpf-next run ends with
> 
>   Summary: 720/6383 PASSED, 8392 SKIPPED, 105/368 FAILED
> 
> but the log for that same run names only 684 skipped subtests which are
> all accounted for; the other ~7700 are just ghosts.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: don't count skipped reg_bounds cases as skipped tests
    https://git.kernel.org/bpf/bpf-next/c/a30c772627b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


