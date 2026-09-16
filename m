Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3AF4D7D3E
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578079; cv=none; b=LKRJfGNgsxtjczy5sI+mR39SWNUhv7e9xDNScC0sG4Ar93Y53Xxgj8aaN/56jS1/T4q57+/NbAUeKc38PnCO/VZbT6AkNiW9cKqrUwjlCCiKZGA3JqAqhERXfZWxALxKKIwDsIC8PvqzBcpw3AEGx5viWLIgXH7RCjDiy0RdHKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578079; c=relaxed/simple;
	bh=OD2utf96j0I8q2TjnLj79ajRKgsaBACR1y04YgdNxiw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BKwSdHB2y5qGu/aFcoCrNAZBOFVO2T1aVwQp0TxvogTlRKz5JzoUVHCnDG9WpCW2BPNWDaFdvgP/W5Z4QADFQmpRo3afJZPi0YdkUZhSNGn6tsfzMWLmOoXiOQRpshZCxw46vP8l8xB85nKxLAgZcj7rKBpNRSnDTL5n08w8AuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtF7N1/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtF7N1/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898601F000FF;
	Wed, 16 Sep 2026 17:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789578071;
	bh=nzG9PxcfJgBfd0epyhJVOrLiBXvFHmqOAso8tfnkccc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PtF7N1/r/Tjf9zXYskTITmlMTyA1Y2mYWx2mFmpVLPlmW+1uzRoUYOsL9X9zklpIJ
	 fSW3bjPybP5sYUw+tBk7NZCg7Ae0wjb29qnRu5Rg7p6sgeBPpWLV4B2DHbm3TMn9oA
	 HM1LcHoZpkqC1wcQZQFItmSPMOjxPKvwrnPLTWuh9t48Ejl8CQFHnzbsUae0uzwC7P
	 UfZNM00lU1jlqQpIvebthd22hX0j3mYmB14IIQ0ZUZiY8Yu6zlZS4i+w2QV2VLdUt/
	 Pz2vcjcWC4Fu6cjNid4LqXYJ55pxXsIKo09xi1GM1Xehz6LuBSfSdR9qC3c2WFF8oZ
	 OYodiYEnITphw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D095539E8A4C;
	Wed, 16 Sep 2026 17:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] Fix global subprog verification context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178957800541.2752227.118013316774739668.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 17:00:05 +0000
References: <20260914131923.2544250-1-memxor@gmail.com>
In-Reply-To: <20260914131923.2544250-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 npc@anthropic.com, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Mon, 14 Sep 2026 15:19:19 +0200 you wrote:
> Global subprogs can be invoked in both sleepable and non-sleepable
> contexts, but are verified based on context assumptions for the program
> type as a whole and not the precise context in which they are invoked.
> Nicholas identified that this can violate verifier safety assumptions.
> Verify global subprogs once for each observed sleepability context and add
> workqueue callback regression tests.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: Verify global subprogs in each sleepability context
    https://git.kernel.org/bpf/bpf/c/3506b9a2f108
  - [bpf,v3,2/2] selftests/bpf: Test global subprog callback contexts
    https://git.kernel.org/bpf/bpf/c/4499609f99fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


