Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794012607;
	b=sEBA2TJ4baDArWAIjkNlcEFAzwFdk5CCt2KlsM6OlMhvLhUWxJpebCaSHGMmR8NWhgCi
	 Wna/4jIz5xINdk2pYRRh9O3qutv7kDkvpZPoz4YhJkMiJSkPWDeqd2H1FZFoYCGDbQCbj
	 Vv6sIuuYdLF9M4wmIhEcBgNOJkH4FTvPp0reWgPMIsT1CLk8zi7MaISL/pcy8AdwYTugn
	 pSiROObyULyj3jMObPDtWekq3JtQHou63nttxvrPkgqW42NLqgrkwRn9xzpY/GooT7WYs
	 eWeoTihXrlDhFcax3GrCizdE19vLG02MN3Y0Gg/PiUQid9qQgfiGhOXXZJ18mAXcIXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794012607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=BCKPTmZC8JhwwlEsZEHbbgxt4KUTTVQxx6hBi70PJsU=;
	b=KYFfXRYwvksw0snobuA2zi31wknrNwj/k5gz0rmqAysoW80+oyps4Kz+d10KcS1Z2o65
	 hON6jDFWw7NO+tuj7g5rmHmgnS26Bw00dL8kNKUyf2s9Q7jQ0PKWq8of6JHKkQ8RvV/WZ
	 CfgwEjyoHAhmiHgB4QbKtoTHAIscJxudbyvNj3aag4U3P2KE6z0Nzr+zBrOX6H66PmCnN
	 ma5QGr3Q/hQVW9EcHlQpf6fuRmT4CM7UW3V8OjFhG5UO6RrepVBLWzuHUwsccQofOrRje
	 T2Tf0g5pNZVQQuF1gI/OJMiDzOm1gK2XG88SXNxy8Q/VDVGr2yIDC6EBNA/Mj1nSFzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZ77fTgR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB3A606EE8C
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZ77fTgR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A743D1F0089F;
	Sat,  7 Nov 2026 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794012606;
	bh=BCKPTmZC8JhwwlEsZEHbbgxt4KUTTVQxx6hBi70PJsU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dZ77fTgRieZeeih6NcCZkZ41QQQdDKVGlXMd+REd0t7oi26LTgnaUUPETHjrUGQ6e
	 s9ulvA+PCUenG08ZPpBUBbR/I5FD2TMDVHTqNYwTNfecXCX2hsvBmW9E/xAGjP4uyn
	 DDnM+WRihAF3crujInSW2wZ1/Nmh+yayhvq6YVZsx5KUpHnkrLUleZMs0xqc8tiyv4
	 z17UPHVc/lCZJRO4r9nVnvEXGx6AjuJzQFjBowx//ZdRB8eskcsia9Wo5uCeSHz8+Y
	 3q+k6WgmzaiB2AKofZbTsqrHvjwCI0euDHmF3jw6ayC5lrJk3kB860QYYtjYm4666m
	 WuLLX0YILCekA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B15F3A55FAB;
	Sat,  7 Nov 2026 00:50:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v1 1/3] Revert "libbpf: Fix use-after-free in
 btf__add_type"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179401260543.959208.4014028648619759075.git-patchwork-notify@kernel.org>
Date: Sat, 07 Nov 2026 00:50:05 +0000
References: <20261106195730.2623973-1-ihor.solodrai@linux.dev>
In-Reply-To: <20261106195730.2623973-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, qmo@kernel.org, bpf@vger.kernel.org,
 alan.maguire@oracle.com, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  6 Nov 2026 12:57:28 -0700 you wrote:
> This reverts commit 9abe2c42ecab6c86b54838d2d645ca2e10204606.
> 
> The commit made btf_rewrite_str() make every base of the destination
> modifiable before taking a pointer to the source string, because
> looking the string up in a base made it modifiable and freed its raw
> data. Since commit efeb5ab5753d ("libbpf: Look up BTF strings without
> making BTF modifiable"), the lookup leaves the raw data in place, so
> the pointer stays valid.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/3] Revert "libbpf: Fix use-after-free in btf__add_type"
    https://git.kernel.org/bpf/bpf-next/c/2210e69db721
  - [bpf-next,v1,2/3] libbpf: Drop btf_dump details from the BTF docs
    https://git.kernel.org/bpf/bpf-next/c/9736b748ee82
  - [bpf-next,v1,3/3] bpftool: Replace the type tag override table with two checks
    https://git.kernel.org/bpf/bpf-next/c/ad6472e01a5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


