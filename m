Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F133D6CD4;
	Fri, 14 Aug 2026 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740054; cv=none; b=rH9HmU+g+4iB+IwobmiGm+ExC2u8Hq9zNCtsPfhGP4CQEY4Kkrb34zVW8AL3S6GvQaobXPQCSK182WOs+pNGjbv2fV0LfuuzukhWMHOWWVHog3w/i2PJaHc4xVP3J+TNtvzJLyCF0r7YTB5O9QFFWd9E00X6jNyLgbIoIpnOjvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740054; c=relaxed/simple;
	bh=P7BvITomrPihq0stPLQbsaDySHfenwWe/mn3vdqY8Kk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t334bPmpPAJuMq1PuRuNWg/ko6MjD5tceLp3NBTKtIfgVB6cJnTgw8X0GfPtw9fV3U73rpPEfhCZvQQiSGiHElYgfxY+OW+D0s3ZXhf4bE2c2yYurTwrZKM1YH+doAh5Mhl2Pr6eYKsAQkmettrae2HG0gp6VnARRKJ22zeqPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxurE0re; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxurE0re"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192071F000E9;
	Fri, 14 Aug 2026 20:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786740053;
	bh=DJlgCMZh9k/IHWGQGORDYoZ0jkGyxQshPUjevMKM0R8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UxurE0reVKPx4cYr80xygvfmGHqUVu2+vg/QTx5Y4T7uu8ZryDLujTUULuL6ck8cw
	 qsRoN0NPmii8o6GGJimLXL2rC/iy8PcCeR3cNiOtOawFQSUWpVftqq3VErxIR3Vs0d
	 VX59iqoFDbfnaQeQwPCcrYUZpt7OcxfcU701mXgR6N3fN207i5j80qbfAAygKnRz4d
	 fSJZObrnok2KcZ34RUcTDA8C3YZqHFaA3N670GmVof1TWfDzSX1KEky1aW1ULv7LzJ
	 jyS62L62VGNohvE/pBDA2J1zPzCbm7pXuIJUceu5TAnDF1qGSd6ja35E2FSRb8OY5E
	 YLm7K46muKqbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A79392445C;
	Fri, 14 Aug 2026 20:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/5] bpf: Followups for global percpu data series
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178674000714.3952289.11571452001394871910.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 20:40:07 +0000
References: <20260814173206.93082-1-leon.hwang@linux.dev>
In-Reply-To: <20260814173206.93082-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, qmo@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 15 Aug 2026 01:32:01 +0800 you wrote:
> Address some LLM reviews in
> "[PATCH bpf-next v12 00/10] bpf: Introduce global percpu data" [1].
> 
> [1] https://lore.kernel.org/bpf/20260813152324.97937-1-leon.hwang@linux.dev/
> 
> Leon Hwang (5):
>   bpf: Drop duplicate blank line in verifier
>   libbpf: Avoid unnecessary mmap resize for percpu data maps
>   bpftool: Update comments about skel data maps
>   selftests/bpf: Avoid flaky resize value test for percpu data
>   selftests/bpf: Improve readability in iter test for percpu data
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/5] bpf: Drop duplicate blank line in verifier
    (no matching commit)
  - [bpf-next,2/5] libbpf: Avoid unnecessary mmap resize for percpu data maps
    https://git.kernel.org/bpf/bpf-next/c/3808171428f5
  - [bpf-next,3/5] bpftool: Update comments about skel data maps
    (no matching commit)
  - [bpf-next,4/5] selftests/bpf: Avoid flaky resize value test for percpu data
    (no matching commit)
  - [bpf-next,5/5] selftests/bpf: Improve readability in iter test for percpu data
    https://git.kernel.org/bpf/bpf-next/c/90bd0329abd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


