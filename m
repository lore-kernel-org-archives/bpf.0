Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731208;
	b=gyM1Xpsy1FUL+FTdGtm4Do60UyDGTVPFL0JGOSpiCqiJJ4k5H/e6zv1qVDFTHs1DKYGS
	 wauSoaiomBkC6NehvhBThTcAviP7182ra3OeN4Khqsf6+6zbxUYqUEkzo3oDQP7q/8KSa
	 rarP9yRDBs5qb6AK9wlcyTZPTceEKy3JZLW7xEOoQhiqpztSEbV9VSn9fuLC78JmvhRk0
	 nKjzJA0UQLxP15dvexYED766bD0s9nAw6pPTp4OLjCsgwER+3zRxD5Isxxr1ts9Y92EsS
	 2htg43TP2SWzVoZxBpP/mpqc6xToqVxeUi5nwDuKNLvwfoWHZXQtMYeTJJ1klBXE8yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=/Iv6Xh/ysZxc9lCrm2TQiHC7VtH/bzTfnpoFUd4doOo=;
	b=HnqXo7+gxdbiGQmCT0ivGI2h8ZIrvVwduk+dASHTlZ0KP2Ra81rOj3C708QMr9euwN6i
	 gWxhe+WH2FE/4OpwqIXx/IVsX8bJpNMMkY6r0d+i3EG0SewFBNhjCNXVmYd7fGYi9SkOO
	 xTFUEmsf0QrJPcSmzufx648dwV6+ISRHoi5vBt+sMLqcNj2ymljfBwrPMQN3q6RlwQMqI
	 JzydEyACxXFw/YAYM9hDUVM2YjSW2mzvO2YdrxsNEfrshZr21RnFNTD9FMb1NZCRRiu/4
	 N33WG6k334LkLp4CYUmX3q72SDRN00tc/sn8K103z34WGF3ctxJJ+036XM1X1jzLcvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9x6Oqd8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C634606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9x6Oqd8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9BA1F000C1;
	Tue,  3 Nov 2026 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731208;
	bh=/Iv6Xh/ysZxc9lCrm2TQiHC7VtH/bzTfnpoFUd4doOo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G9x6Oqd8K4eZrI4n5qte8j2pjQ5eXhbyZmIFBuxfvRFACK4HXK9xPlPDyYn79ft99
	 MkaElynA9b9C56l5KvLsWeO7kVVN8buZD9p3lOQBCeilLX+hZXlCzMajDxNGFhQLhC
	 KNw2/KpEmyxbuqzZWJZir+dEvkLxnskG0ld9ySa3m3qZbc6Hkmx2IsxNgIDFTZTnFo
	 fh3CTaxqIEWeMgiRZahqbEyVnfgze/4B/OhVh95MPs86WLxORVvKWITSlxfI9GvXbu
	 VuAkJti0BZnx0fjR0aw/hZyHlA9JVjqegKdiMona6EAUQYCmCZU9UjOhJDYobCTwky
	 ILd675pmqN++Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 031F0391B086;
	Tue,  3 Nov 2026 18:40:08 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 0/2] bpf: The register of an implicit kfunc
 argument
 is not live
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179373120680.1810830.11917604471479274465.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 18:40:06 +0000
References: <20261101174405.4055052-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261101174405.4055052-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  1 Nov 2026 17:44:03 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The verifier fills in the last arguments of a kfunc that has
> KF_IMPLICIT_ARGS, for example 'aux' of almost all scx_bpf_*() kfuncs. The
> prog does not pass them. But the analysis of live registers counts their
> registers as read by the call. Such a register is live from the previous
> call to this one. Scalar evolution has no formula for it and gives up on
> the loop, and the verifier compares it when it looks for an equal state.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: The register of an implicit kfunc argument is not live
    https://git.kernel.org/bpf/bpf-next/c/2b1947689c29
  - [bpf-next,2/2] selftests/bpf: Test liveness of an implicit kfunc argument
    https://git.kernel.org/bpf/bpf-next/c/ef41474ed6cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


