Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A298E7262B
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 03:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780717214; cv=none; b=r40fQAQZUjowmTFFIXhGoiOs1sZumyTL5Y7fRkVGfvgeyfo3mfdAC/uGWL1XyIx9216KTzoW7XTaYRAH6l3kSRVC0vOPBwXqvDD0twfcPzMN+Nu/fmRwXnXFCpzZRdw1HK9Om8ApkrjtbBm3DjN/6mjkyQYXWaxvs5+uWdgE1EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780717214; c=relaxed/simple;
	bh=0dpGhuMccBN33lnMLiZVZiFEWq+Oqlajse99sD9LztI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d1lHKTmEF9iggXLQnLpFPpzHSz4DunJjji0nIAwXxsYsXV/zwEgxUbSG7KyoSfwyr3lUOHYONfB+kT7W8H1cdyBRNtEzMOm52xwfrHJ0CZo/ZzWCQAzdgvmLHRreyrp4rzKkIVY4xtiisVRxacvvOhcuUuaXgnz68RjIQ8uMILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRCqE7Qw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRCqE7Qw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D241F00893;
	Sat,  6 Jun 2026 03:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780717213;
	bh=NEFlghXAmHfa6bAzSCQvg0nvB7PDshq0WFdsuWzsiKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gRCqE7QwjjyjCxR97OIdMRx3OlfnvsOEh3zFKvg3Mf5EVBxlvRd+LES09PpLmhY/F
	 NSJPhOF+VX7Lu27FX96Pvn5fOwiYvS7pKLE3KGgWvucqrrrOgeSzSajD73rP40ayE8
	 mFUJN5yiE4h/Orku97S2ZaPLA6AybQQ/2aMHveKcIrlKfDZOtrZL7Kg7zcf/jXN9Vo
	 dLZhW7KmF/dNiJB5BndPIiJbUszt7xneiT7ScemoM2HYeIa9AAWTxYpL9t212AB0CN
	 dEPSDv3s8Sv60e5ufkirHEbchonNtRcAdFif5OLEKS9uEH3/BeGlti4Nw42CtHA2Jw
	 3TtMdSOSkfb7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939253930A9C;
	Sat,  6 Jun 2026 03:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] selftests/bpf: libarena: Add initial data
 structures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178071721314.4008217.11212320727117689901.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 03:40:13 +0000
References: <20260605222020.5231-1-emil@etsalapatis.com>
In-Reply-To: <20260605222020.5231-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
 mattbobrowski@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 Jun 2026 18:20:17 -0400 you wrote:
> Add two new data structures to libarena. These data structures initially
> resided in the sched-ext repo (https://github.com/sched-ext/scx) and
> have been adapted to the internal libarena build system. The data
> structures are:
> 
> - Red black tree: Fundamental tree data structure that can also serve
>   as a base for more domain-specific data structures.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] selftests/bpf: libarena: Add rbtree data structure
    https://git.kernel.org/bpf/bpf-next/c/6c3e8a4d4765
  - [bpf-next,v4,2/3] selftests/bpf: libarena: Add spmc queue data structure
    https://git.kernel.org/bpf/bpf-next/c/57c6ace8395d
  - [bpf-next,v4,3/3] selftests/bpf: libarena: parallel test harness and spmc parallel selftest
    https://git.kernel.org/bpf/bpf-next/c/42998f819256

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


