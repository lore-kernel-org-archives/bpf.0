Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B452E175F
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789795877; cv=none; b=I1/I/62qVVcic6tUmshyaieAggBW9X9w84TXp6C7CKsRojV3JUnR5rMTtf1VG0YovafVzsnGp1pdtkatYNbVSjIOm06d7ebRsc5iZe93LmcKVSfTKWxm5NuCaCWkcMEJlpU4EsG0nwX2BHTgux6ZVqCxolNqUJH2CpQNZYgJVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789795877; c=relaxed/simple;
	bh=I2BAFCBxR/gVjDUpgGSzK+ep7kUEJU8oFe3qkOoobC8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i823FQfF+QtxDZDrxjePeOjT3NP3uNZIXIDAKiP8fsUwgr5kVlhA8mBmUDacQWA/jPrBjEZbte82uCxsxICjpr40T17W67XoOiuhNgKDNs4/xZvsNXEQePVCahaNWUNbnzuP+FGItf8d3A2MIuJRwOS1sWwDwtQCOaub7zs1lQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wpj2l+bn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wpj2l+bn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1561F00898;
	Sat, 19 Sep 2026 05:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789795876;
	bh=A1CrblczE1czI4Ovv5LXKsKFd/bO1KQoKc/uIvZGo5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Wpj2l+bniL4Ll7+eeFtT+D55Ma8FG8PI7FgkqBliiiPFeRkvn55U/YQxAJPJ08WTF
	 1EC70B+ZhzuWW2aJ6mSPtiG9i8izwoLfSqJI1IpmJScp9nm/r5U3Y3PfLGznsZqUtG
	 g83/Cg/nmDPJ4pzu0BoTwMaA+F4/KlqQic+m4UCZezQu6LSfnM3c7oz8hO4vbBArdg
	 VVHHhjeLgNGL0zGJJg4JgPtfivBE+DsxrDH5zdsujuH8QQD4qYIQf9h8aYCbpIshN7
	 /ueb9erLmB4rejBCvzhkA+gEyEhGbRrM7mrPXncG6dnqdoKC3LcDkrM1cRe2DkhFfG
	 Can1B+NkT4Tcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569C7381197E;
	Sat, 19 Sep 2026 05:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] Fix acyclic ownership checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178979580888.1275551.13918303217936513358.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 05:30:08 +0000
References: <20260914132444.2564218-1-memxor@gmail.com>
In-Reply-To: <20260914132444.2564218-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 npc@anthropic.com, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 14 Sep 2026 15:24:41 +0200 you wrote:
> Bound and ensure acyclic ownership graphs for native data structures to
> fix a bug reported by Nicholas. See commit logs and tests for details.
> 
> The existing list/rbtree rule already rejects graph-only cycles and bounds
> those chains conservatively. It misses ownership through local referenced
> kptrs, which can produce unbounded synchronous field destruction. Validate
> all local ownership edges together, with an explicit depth bound, and allow
> longer acyclic graph-only layouts within that bound.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Bound ownership depth through local kptrs and graph roots
    https://git.kernel.org/bpf/bpf/c/bfc888f04588
  - [bpf-next,v2,2/2] selftests/bpf: Check local object ownership depth
    https://git.kernel.org/bpf/bpf/c/0288ed67482b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


