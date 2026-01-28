Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB64033A010;
	Wed, 28 Jan 2026 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636411; cv=none; b=m31SFXDA0Wh4z28hh4je8rZ1qWukzpN0/zXn2+SRP5vVvcgoy/wTDO0gf23oHm6LwLjutCGP69vMIgRF+lKL5Xajw2d9r8erODWD/EMroZvTqr0WME/Em2zHhbi5IRuh4ng1jLJcuXZqbeB8rMEE/Zg6w+cbM6l1cjHlna0+bR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636411; c=relaxed/simple;
	bh=lC3mmieYPjQpYRJw+RTHXNXbDOHOg4TTIJdM18csIpA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YDJPD5uVd5Dx826IP7s44P0BlOI95yNsvVNQj1/NweDKWh6pnHetRlT9aH+/UCqXmgv0b8SDvFkM5nvQ/CXDnPBcsIwTumww5ugsDI0wM3Pp+8C3lKorbN66TsVHAtR/vNs7Rq/H0lXpEWhK7UorNl73ow2o9VKZkQOlOdSdZvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgovHICW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgovHICW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D505C4CEF1;
	Wed, 28 Jan 2026 21:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769636411;
	bh=lC3mmieYPjQpYRJw+RTHXNXbDOHOg4TTIJdM18csIpA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pgovHICWgRzOiVFAHDgZtHhXnLODvL0XK7pkFNL/3QQJt8BsiktqH24rtkOgVqQZg
	 XRbGN3440U2ADxlLoeL6P0tnnvOEcIlO5DGZtfvUsV6IubFku4RbtDc5KJ11nWuE+v
	 +NK6uD29ePvWe9/pFv3U7Vm/CjEbhbx906clSURN6Y/jlHYZ2w4efst2UkqEmcLGd0
	 bn1R+mj4cQBdtIBeap1/wp4rQzCmU1loidj6CPm5H1N4w0FTAs7PU6uIPWtQNSJHLu
	 lyg+0pY9wFo9DekHtphttlNj4Kj9RRiXxwkbEvcMhVnGYEWp7dF0iyk2GW0l48/OKw
	 4QzZtw3m6/x/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8D1139EF953;
	Wed, 28 Jan 2026 21:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpftool: Fix dependencies for static build
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176963640461.2240971.7239537113425583931.git-patchwork-notify@kernel.org>
Date: Wed, 28 Jan 2026 21:40:04 +0000
References: <20260128211255.376933-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260128211255.376933-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 28 Jan 2026 13:12:55 -0800 you wrote:
> When building selftests/bpf with EXTRA_LDFLAGS=-static the follwoing
> error happens:
> 
>   LINK    /ws/linux/tools/testing/selftests/bpf/tools/build/bpftool/bootstrap/bpftool
> /usr/bin/x86_64-linux-gnu-ld.bfd: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-dso_dlfcn.o): in function `dlfcn_globallookup':
>    [...]
> /usr/bin/x86_64-linux-gnu-ld.bfd: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `zlib_oneshot_expand_block':
> (.text+0xc64): undefined reference to `uncompress'
> /usr/bin/x86_64-linux-gnu-ld.bfd: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `zlib_oneshot_compress_block':
> (.text+0xce4): undefined reference to `compress'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:252: /ws/linux/tools/testing/selftests/bpf/tools/build/bpftool/bootstrap/bpftool] Error 1
> make: *** [Makefile:327: /ws/linux/tools/testing/selftests/bpf/tools/sbin/bpftool] Error 2
> make: *** Waiting for unfinished jobs....
> 
> [...]

Here is the summary with links:
  - bpftool: Fix dependencies for static build
    https://git.kernel.org/bpf/bpf-next/c/08a749184322

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


