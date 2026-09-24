Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7903CEBBD;
	Thu, 24 Sep 2026 02:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215277; cv=none; b=BKShP08H739/EqklhZ1jtsxwMuy2/xYoNkpjFhXuUairL1Nw5emHwP+OvKMqJ1WXRAos7WQ7+U1dg4g1HmuBbqfrqnAetB4qfrjtf0jtkE4Wd6GIZVQGEsx+WA+8TMaPmzrLhx9jGQOoichKy0dbjC/YHsarAXJm1X7ebvvJkl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215277; c=relaxed/simple;
	bh=OM8FzaNdN/aNmNIyypdshST0LOswihwFcXsnq8D+/jo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BPxhb9VpubrgVQ+YmhOQ5bkzL1yZZWc2rAIt9e3wsDUrgXspf0ArXhPHD5WDqpFHAShG9BdmiufIps3S4ttuhtJw2JnqFDxSYFJe+2NU/hjJWv2wOF4QEoCFSCS/Ri0H5PeS39W1/uwV8CBU/0PAdhmLw+nHsLZdqexYlMxqMrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTrZSxhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTrZSxhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C324C1F000FF;
	Thu, 24 Sep 2026 02:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790215275;
	bh=g0aj46NEjoDGBadQK9wkroxvOgx7dhvNbNN8G7+etOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GTrZSxhxZt5c/DwijecymloH4R/EkRLVVBja2zNZlN3QErTBOycG+zfn5SJBUgoDC
	 tTTeIPiffidWmZ2WxBLgftgBngoFHx2ewSl1/Vheb+rt6ICR+YVOm+J/AwXlIB5++7
	 8TcK5DEs3rbO+AyNBxgrfgAld1LDJPPLBa2EoOz4HXM1yhL3V//DkLq4m8R1IzX/2q
	 m5FtvJmuidEIs7NYKVD4CNpeE0jnGKbYVHhlIGnq1gF30WbYYp4Po5zZ3RvLqmZ+U5
	 7jD1NJ1sbPkFcb9O7strCSVmjuGNykXVvDJhGbZBjMvJcV2a90j8tNILRmQb/U8YiG
	 gt7EiV+3YFwrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939CA39E9611;
	Thu, 24 Sep 2026 02:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf, mips: Fix immediate JMP JEQ/JNE on MIPS32
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021520541.1274904.9859067781953002975.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:00:05 +0000
References: <20260923105158.3514342-1-johan.almbladh@anyfinetworks.com>
In-Reply-To: <20260923105158.3514342-1-johan.almbladh@anyfinetworks.com>
To: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc: tsbogend@alpha.franken.de, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 paulburton@kernel.org, main.kalliope@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, philmd@oss.qualcomm.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 23 Sep 2026 12:51:57 +0200 you wrote:
> An addu instruction was emitted instead of addiu, causing the immediate
> value 1 to be interpreted as register $at. This made the comparison
> result invalid when the immediate operand was negative. Note that $at
> is mapped to BPF_REG_AX, which is used for constant blinding.
> 
> Fix the instruction to use the immediate form.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf, mips: Fix immediate JMP JEQ/JNE on MIPS32
    https://git.kernel.org/bpf/bpf/c/db762fd96be2
  - [bpf,2/2] bpf, mips: Fix BSWAP 32 and 16 on MIPS64
    https://git.kernel.org/bpf/bpf/c/8110ba097778

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


