Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E501267386
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149825; cv=none; b=IZ0fnr5P8ZhqusPIaEbe1aK80nSTabJ792not8KxH4kXKZyXoZoP3EtAB07+G3QPnO0Gh5LSegvg7LuPZK6z9WWmcC76KN1s30TRqVjDPnaJtsc+rEUmA3epMi3ZBwIwIxSYDDSQUZ+XgWossB6/QgLj9MeMkPaM/QKlMBKJkks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149825; c=relaxed/simple;
	bh=YPH3CLN7RcysFMW0LzeUbynAfnw0bDB8m+bEYMJmEQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CRngX6vlkYt6kUIxAAkes26g3mcNGs47zbkiWsQ8yzSCnJrNfXvnB7N0oXQgSgBSX8uYvKrZXxPbw++jRWKUwucaRys6VxQwL1T92+dlXX7STvWHLgGAPW6tTAd8b5R7zPM8iZFDo21dpZH3Bi+gi9oH0e6NJoAFBDXo8La3pd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb/NGVNr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb/NGVNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC836C116C6;
	Thu,  2 Apr 2026 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775149825;
	bh=YPH3CLN7RcysFMW0LzeUbynAfnw0bDB8m+bEYMJmEQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tb/NGVNrXZjaWnUtDqD3DMhk/jbleO4z/BFFy0+Ez73Oy2TIbDrNowZ76J/N6lj9p
	 KieM5Gc/lpKViXyqPbTTMzRAEMjN+IlCR86cKKCvacY1206eykuLTDknLRVZis2CJk
	 gvOhgz2z25i6NLos4+CCb4UJFtyNzGwNZCMgJMjbZOf56502ZQnfk2iSGWqbfDtSuz
	 6r2+K37dXt6MaUgrQrrYnVnDwcksDr+UDzzPvnn8JYe+USV6urbcwp/9bobK4+x8cE
	 H9niX//RQ7ko0trbfOY7KrtsG01XlrJq7eOe0zi/cmV9+/c8gHWLK9hZcbVuRWzgga
	 Jv979cN1ZKmDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CED83809A08;
	Thu,  2 Apr 2026 17:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix incorrect pruning due to atomic
 fetch precision tracking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177514980704.537718.10686504392612421936.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 17:10:07 +0000
References: <20260331222020.401848-1-daniel@iogearbox.net>
In-Reply-To: <20260331222020.401848-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, puranjay@kernel.org, ast@kernel.org,
 eddyz87@gmail.com, info@starlabs.sg

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  1 Apr 2026 00:20:19 +0200 you wrote:
> When backtrack_insn encounters a BPF_STX instruction with BPF_ATOMIC
> and BPF_FETCH, the src register (or r0 for BPF_CMPXCHG) also acts as
> a destination, thus receiving the old value from the memory location.
> 
> The current backtracking logic does not account for this. It treats
> atomic fetch operations the same as regular stores where the src
> register is only an input. This leads the backtrack_insn to fail to
> propagate precision to the stack location, which is then not marked
> as precise!
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Fix incorrect pruning due to atomic fetch precision tracking
    https://git.kernel.org/bpf/bpf/c/179ee84a8911
  - [bpf-next,v2,2/2] selftests/bpf: Add more precision tracking tests for atomics
    https://git.kernel.org/bpf/bpf/c/e1b5687a862a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


