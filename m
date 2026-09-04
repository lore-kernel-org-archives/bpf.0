Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072E44E80C8
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534080; cv=none; b=r30kQ5lx3ASQR76rrtwtHu3qH/7161HDq9HidtuiRxzUqT+MJ9+IG/nCYxNtXO6K9HyWnU1cMiwrLe2yxcPCnQ/spsXmi0xmrcicAGoVGuh0GmwkYLxtEBsD7lIu5b+Tc4qbgNUQXjqolMhDjb+zBYhOEPhzf3uY5isZSepPIEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534080; c=relaxed/simple;
	bh=NP9ubpYsSgGySPtteEwQEQTjsgJF1exmhDXb/4fPoz0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=poKMCl1rVpJ3NmrXMuCBRsUEexF7hDlYYnnliMUQ6THOkuy1mm21wi13TqcjNiwkvbuXDACjrqoMs4/F+Wm+bKsrVR36V6CJXO0ztPI/iGt+xRxs/T0Wod52UXg1z+ick1lB2u/o3VeHbF7JJN26ZsbrJ3+LhLK3yMyfB2awR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c448bad0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c448bad0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FCC1F00AC4;
	Fri,  4 Sep 2026 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788534077;
	bh=cO57Ry4f6JRnNZF1jJstCDmKWL6rgDKDRmesgR+ZFmM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c448bad0JyvS9y/wmTH6TwrvAcnH/YaQrLBktMMObSApc5DwxDN0kfHL2A2ddatkC
	 s0KWO8gXTQ/LEnLz+JsCNw2InBcN2afygR2v5ZVTLslU4J+6rdiHm8SXDZb8WM8N6m
	 deXOlgIavA/YOUsNF8hn+C8NhQ+B1OhZpl8msCwnaeL6pLZ7mJ1GWs1LvNfWVWELWd
	 oZHoJCjlQDaoHtS57jJAyT2WP+s3CaLyWmCWnyqSFRwrNScru9MvX1lkWBvgkEGHia
	 3I/Vh9GSZIk/26Bu74CB+zdoNgAKYNDvoaMXl5WFNt2XsMQ8zlKbJQmuJU5zXz1XWj
	 C4EIB42IJf41A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19C0D3924468;
	Fri,  4 Sep 2026 15:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/8] Misc bug fixes - part 3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178853401764.323612.13062376369096458140.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 15:00:17 +0000
References: <20260904084325.52250-1-memxor@gmail.com>
In-Reply-To: <20260904084325.52250-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 npc@anthropic.com, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  4 Sep 2026 10:43:13 +0200 you wrote:
> A set of miscellaneous fixes for bugs reported by Nicholas, batched
> together again. See commit logs for details. Some of this was caught and
> posted by Ning before, but AI raised some concerns, so I'm resolving
> those issues and commandeering their patches now.
> 
> Changelog:
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/8] bpf: Require MEM_PERCPU for percpu kptr stores
    https://git.kernel.org/bpf/bpf/c/048029ba1c79
  - [bpf,v2,2/8] selftests/bpf: Reject non-percpu values in percpu kptr fields
    https://git.kernel.org/bpf/bpf/c/17487b31f479
  - [bpf,v2,3/8] bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
    https://git.kernel.org/bpf/bpf/c/dc36739e5cc9
  - [bpf,v2,4/8] selftests/bpf: Test borrowed refcount acquisition nullability
    https://git.kernel.org/bpf/bpf/c/2edd8339468e
  - [bpf,v2,5/8] bpf: Clear NON_OWN_REF after RCU protection ends
    https://git.kernel.org/bpf/bpf/c/cd6f72d7f38e
  - [bpf,v2,6/8] selftests/bpf: Reject graph kptr use after RCU unlock
    https://git.kernel.org/bpf/bpf/c/6668ed271eae
  - [bpf,v2,7/8] bpf: Reject untrusted allocated-object pointers
    https://git.kernel.org/bpf/bpf/c/7441ee827664
  - [bpf,v2,8/8] selftests/bpf: Reject refcount acquisition after RCU unlock
    https://git.kernel.org/bpf/bpf/c/9492baf8532c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


