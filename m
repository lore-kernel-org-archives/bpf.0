Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A8485CDE
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787670662; cv=none; b=qAGFpVI9wF1ArOtkFEwqv/e0jNh0KlLj0r1GbfGsQrchOOYS44YXI7h6/WdLhhb0LmbbfM5+zi2e07eFGVCU9eo6ytac0jy0EmLCfHbBN4DLjugcPmzgXge7m3d+FKYH4mBI42LTg8KuGq5oZgiXnngfbhrt5ZMJf2BlD8QBSnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787670662; c=relaxed/simple;
	bh=atRU3rYHt4zjwWK1W0/qXmzaJGl5HFKX2meef6iOdqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=niordNCR2Z8GvqkZPasHDu6t6ARkpGft6VG01zAakyYY3Fc6zWAuqlc7JcM9zflXE+pf39XoHFJBzNRx75JnpQHL+yRZyHdppFWftv23LPfiCwaJVcL1oAR19O2+V9E3M/YY8WMW+spcjTbfIV38srWRnwZ7ccABQIwS3v+CGx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDB/f1G7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDB/f1G7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746B61F000E9;
	Tue, 25 Aug 2026 15:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787670660;
	bh=c0joD/2s52R6txHoI6upTo7AL6QqI17uQFB9uBlGg/M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kDB/f1G7tTo+i0gK3m1HYTthLZmeUXMVgO4T3jP7FIvnm1Y5Al3TY7+8YbmXz8N8F
	 omRs2AmsO4rDe5LE7U89G9i643YsvyJYv8wJ22vfcmeazb6dSQ5BuCwRV/FOJKXrHn
	 NZmEyP/8panv6PSTDMzc6IlFBvJiZ140ux1fBf0OWdC7tS7Em1D8bPwc/wOUgjifiH
	 Caoxht9WMICRYs1AM7hNlQlk4GiFJ31/E17K7KxRMMKffLeBPIU7+uqzeLX/mGv0g3
	 6YLFwvteTZlZNmpUHvYmNIfpxwTS1dJ5oEk2r/O3qbaYj8PhdnGRqScgSzX8rjcHMR
	 bAjOPn62Oxzgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A3E3924FEE;
	Tue, 25 Aug 2026 15:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/2] Reject oversized stream read buffers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178767060739.3931813.2761477952792688796.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 15:10:07 +0000
References: <20260823193202.2389715-1-memxor@gmail.com>
In-Reply-To: <20260823193202.2389715-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 23 Aug 2026 21:31:59 +0200 you wrote:
> Reject stream read lengths above INT_MAX before they reach the signed
> internal reader, and add regression coverage for the error path. See
> commit logs for details.
> 
> Kumar Kartikeya Dwivedi (2):
>   bpf: Reject oversized stream read buffers
>   selftests/bpf: Cover oversized stream read buffers
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: Reject oversized stream read buffers
    https://git.kernel.org/bpf/bpf-next/c/ea0b60fae724
  - [bpf-next,v1,2/2] selftests/bpf: Cover oversized stream read buffers
    https://git.kernel.org/bpf/bpf-next/c/05ea1b6e2a5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


