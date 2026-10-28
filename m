Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213409;
	b=hJ9XbGZ6BOlPPi4PWNpLXrGy78ambfmtdYGz+YoSpwGqyFCitMT3bNn1Fl7ki+f31K2x
	 KCHDJdtKtjY/HwjRi5Z7IdEsx6w2CTfhIMc1FvyPWufQEFgGJr+xrZs/VXvCJv1lcw+/p
	 MwL74R17RyqJW6aGFIXQmNdEha5lNd2Y9KKUHCCF54fz9Gx0spyddB/di9O3zka/ZVqBZ
	 5ax6U/GWC0bau72dDqdtYamjBl/C2+XnhDn1noXTcJUrz8ZgodCpQX4YQMeARRN0ZZWko
	 VS0jx/l71UVCBje3lUImaUnBxyYjcWEovfz/CnbBxac+KqqYJyPLsHZsDywjlzXky+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=DFRyj+Me8KzZokOsmqKcvuXCip9S+r1epzySMXL4bro=;
	b=XJX6bDGmXQd38VmkB8ecDxWpb1ayRNHbPNuayp8aRq1XJ+MmJwN+merrW7Zdy0IfK+7E
	 S7ZpNvGaJFzyWk4kz4h5quHZhOAC++T+/tS56vMZhmK/3ZyA7i5s2g1GUZQHtJAJzWeQu
	 m0m9uuRC74/jvCbDOd8qoSPKKIsPXpdjq6NZRCG5jMls8R3bRXaF8kAozHypU7B5SXDIV
	 qXMWtKlX09F350qxW1cae90yfr/IJEW8wo+P6K11w21S1tatx9efTB04Z807b6gdKskUA
	 rIAgms2dzpVLYACmzRhEkrYSrbiTV+tygc7DQlefLkrjgd1V6XoAGR8LwQDShYHeqDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1w2AU4Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D9606A31C
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1w2AU4Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108E71F01825;
	Wed, 28 Oct 2026 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793213408;
	bh=DFRyj+Me8KzZokOsmqKcvuXCip9S+r1epzySMXL4bro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e1w2AU4QnmEH9I1RQaS0NOLb+K0QI9WOoOfaCH5DsfhFhtn8pw/u/4RpJO1W6oJRZ
	 Eay/oLlCkkNldwdHI+uvFEZ6PAkQ7i6SAFFAyXxBhJ1uzSfPntpsU+bn0TsOuxfVfC
	 4QP4N8eE7+kxfUkOA9lVOac+whI+15DU/+xkFFOrNLWTSldnuxKzWP74C9dAX54oqP
	 776cxUhVPzm9MZuaI0kR5Unkylb07vZQfGC4g4K3g2IHsSS1wzCcyos+IVSoZuPt45
	 sFYxOV0JOhMtSmv9oO4T2sSXMAVNshLaoKsWbUcGA7/s1JTW2lLXjdC8apcpM15SC0
	 tRSvG532wijmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0730E3AA9F6C;
	Wed, 28 Oct 2026 18:50:08 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2 0/4] selftests/bpf: libarena: compatibility
 fixups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179321340681.1368518.4323708231773244970.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 18:50:06 +0000
References: <20261027192413.5038-1-emil@etsalapatis.com>
In-Reply-To: <20261027192413.5038-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, daniel@iogearbox.net

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 27 Oct 2026 19:24:09 +0000 you wrote:
> This patchset fixes several issues found while integrating with large
> BPF codebases.
> 
> Patch 1 fixes a mismatch between the in-code licenses for some files
> that do not actually correspond to the licenses at the top of the file.
> Remove the in-code license sections, since libarena is distributed only
> as source code anyway.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] libarena: remove in-code licenses
    https://git.kernel.org/bpf/bpf-next/c/6e7f37fc8623
  - [bpf-next,v2,2/4] selftests/bpf: libarena: make allocator growth on alloc failure optional
    https://git.kernel.org/bpf/bpf-next/c/8e192d828784
  - [bpf-next,v2,3/4] selftests/bpf: libarena: add explicit buddy_grow() call
    https://git.kernel.org/bpf/bpf-next/c/1d9c7ff6e163
  - [bpf-next,v2,4/4] selftests/bpf: libarena: Make zero variable type __u32 instead of u32
    https://git.kernel.org/bpf/bpf-next/c/c2bc2eebaa83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


