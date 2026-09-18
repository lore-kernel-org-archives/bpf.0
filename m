Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F2385D7B
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693877; cv=none; b=b/cLWNfCnl+BCDXaeUzy9lD2n658ivSM0WgcP+/Vk+XEsF6FrW2DGlQ9vdvt3qaQR6503/vZ+M6OWtnLMdh2VrG45Ak1fpQ9FQOZ+r+wXI/gvFKAFJWRYU7F/43SZrh1fUJCOexXKZxkeoc23NoLvCUXMB+gig6WS3h6a5f7Q9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693877; c=relaxed/simple;
	bh=KEoTecE/TJ3GZh2NkSgSNeH8cj6UxLl80a6MFs62Yas=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YGlpWeRAMNRW3PS2sLrY6DLrRKUehInARXd3JZDjCYdP7y79UmW+qeGViJLj8aW+wXGMi6wD0iuz5XPdh86RMV7Q1ucMx6VbH9PCBOJ7013TrcBJ7/IIoDo2/jpLFje36QYh3sQI0VbvTOW7FsGidQduUMKcjCqQHHPzNC4fsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ+dvxW0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ+dvxW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DE61F000FF;
	Fri, 18 Sep 2026 01:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789693872;
	bh=GPd59GYjhWYAD0ue6iDR5t7yfTWzPodon6Pr5YnWV5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GQ+dvxW0E8tH0Uqj33Roh0gRN4893ZnThSdtZdXRj6B4ceEPhQtoylrPsGDvYa+w/
	 HVvEMB/IDglkhi+rVseUd0mN4Nr3wR3odQocPDCWhK6z0aPjp1f+Oq3WuyPh/s9jWA
	 F9rpi7bQPuHLFXiMpgoWWwdkCH3nEvNaEalqTdV+f2CgeXe/MTCufzH+y9K1AUjyHP
	 7h8xw3BSQv2L3qHkOT4deSbiYY8Vu3ukiBEGGVMmi9i0K5eundcFIsOG1hQlDsMbMf
	 L0DcQzaI1hjbT241fAOtuyWJI0ErtBiA9O2E2e+ViPzfirgrQGndSzeh3knFkFN31L
	 lvaRi2CJnol9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1989F380820D;
	Fri, 18 Sep 2026 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v7 00/10] Misc bug fixes - part 5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969380588.207424.12819902681607372321.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 01:10:05 +0000
References: <20260917233222.2542500-1-memxor@gmail.com>
In-Reply-To: <20260917233222.2542500-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 npc@anthropic.com, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Fri, 18 Sep 2026 01:32:08 +0200 you wrote:
> A set of miscellaneous fixes for bugs reported by Nicholas. See commit
> logs for details.
> 
> Changelog:
> ----------
> v6 -> v7
> v6: https://lore.kernel.org/bpf/20260917111127.3780880-1-memxor@gmail.com
> 
> [...]

Here is the summary with links:
  - [bpf,v7,01/10] bpf: Make post-verification instruction rewrites killable
    https://git.kernel.org/bpf/bpf/c/261b61d3735b
  - [bpf,v7,02/10] bpf: Preserve packet pointer class displacement in regsafe()
    https://git.kernel.org/bpf/bpf/c/fd16449a9b3b
  - [bpf,v7,03/10] selftests/bpf: Test packet pointer class displacement pruning
    https://git.kernel.org/bpf/bpf/c/2059d9af54f0
  - [bpf,v7,04/10] bpf: Apply CO-RE relocations before subprogram validation
    https://git.kernel.org/bpf/bpf/c/c26e97721b17
  - [bpf,v7,05/10] selftests/bpf: Test early in-kernel CO-RE relocation
    https://git.kernel.org/bpf/bpf/c/968ee7c06b62
  - [bpf,v7,06/10] bpf: Restrict CO-RE poisoning to relocatable instructions
    https://git.kernel.org/bpf/bpf/c/394ae398337c
  - [bpf,v7,07/10] selftests/bpf: Test CO-RE instruction poisoning restrictions
    https://git.kernel.org/bpf/bpf/c/3440505aca92
  - [bpf,v7,08/10] bpf: Assign lock identity to callback map values
    https://git.kernel.org/bpf/bpf/c/71919742c83c
  - [bpf,v7,09/10] selftests/bpf: Check callback map value lock identity
    https://git.kernel.org/bpf/bpf/c/04ae4ffc57a6
  - [bpf,v7,10/10] libbpf: Reject truncated ldimm64 CO-RE relocations
    https://git.kernel.org/bpf/bpf/c/b4e875d397da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


