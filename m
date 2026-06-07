Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470904071E5
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780861208; cv=none; b=gvqUwUmKte20bQ7UcT31I4LhscwLoB4+h7TeaAKYQLmLkv9beZ7YD6x1p2ACrM14hHeOm4RCfgoOya6LhBuScbh5NxBmp4rCRiu3Fe+fe2ABXeNP1v2YQq03DXVmMaf1wEv809nM6tPoSJzUFovIAuZNBrrjVHzQis29iogjVg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780861208; c=relaxed/simple;
	bh=1EgKhOEi8gcijUG7l7+bPxyzHE80kXIYpOPLzVVBwu4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jhZzIYXf5L4lOpF3wC2nqO2uHYlHE7BFnbjuIEg5v4B/0KDnxSyncgnLTIli0j2cyy/KjVf4AydTao083+oszkVqEYcL5gSWqUt27cp9NRl+M/lJs6veRd6H6QjCscUmKIHUahbdfVKd0RV3TSWma9aoKv95vE0e1gFrZBQO5Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPTwyOTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPTwyOTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4BE1F00893;
	Sun,  7 Jun 2026 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780861206;
	bh=IkUkVjcaoMDjvkT71YecdfKaos7ibZ8n6f+Z3ypgBdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iPTwyOTW5Gt1XE+A/zTQuW7v9cC6e7YvDZgVpyKlWwJvuW9Cy+IJNh5eIkgr56y2U
	 TVIDx2h7HsJHuaD9PZfkIS+dgT946dF8p2+dhNTltRwQ+ar9oTRFeNkAlWOtt7JKux
	 bFzShwli66C0N/NKMC1HD2cx4wVxakR9ETAm/mBBrcXrC6HQ8406y6TA+ecEx6rN60
	 zJFiW4MwhoypfuZ9vwDGxvPbsYq9K01bmjguhpe3FPLfPQ96e0uU4Ae0yHIa5HDhl4
	 SSoc+YSkuL9Z7qczBJNYJVjS/+qKMnDZzDyZzMG7VRWDhtt2KPaH76i96jylUjwqrP
	 s7hyTK73Wc3ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B2F3930C9A;
	Sun,  7 Jun 2026 19:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] rhashtable: Fix rhashtable_next_key() build
 warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178086120590.289093.11149901271242453541.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jun 2026 19:40:05 +0000
References: <20260606-rhash_fixes_1-v1-1-932ab036e6bc@meta.com>
In-Reply-To: <20260606-rhash_fixes_1-v1-1-932ab036e6bc@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au,
 yatsenko@meta.com, lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 06 Jun 2026 10:30:32 -0700 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> rhashtable.o builds with warnings as rhashtable_next_key() kdoc
> from lib/rhashtable.c does not have the arguments descriptions.
> 
> Move rhashtable_next_key() kdoc from header to c file, matching
> other functions.
> 
> [...]

Here is the summary with links:
  - [bpf-next] rhashtable: Fix rhashtable_next_key() build warnings
    https://git.kernel.org/bpf/bpf-next/c/1444ee886e6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


