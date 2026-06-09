Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20648B389
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029210; cv=none; b=tgGXiZsO6ctarfUmlr6SKyzRb65e276culGA69ZYavc1TDnSUWVlJo80BbbefNnjalYjbjVDgv8Nkrhs0CjVSQFEmgw7dzjEkhRI6cI/DVYVekvaBumr96OjedLCa43k4wz1EK9HyUZzmdNJUQC7rEPgWAr8AtmNX4mFZWPhx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029210; c=relaxed/simple;
	bh=T+AHdKqacHPUNwGoVlyr2JiGmGr+6Cw0MooBrCrZVbc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MMon5s3z0J9RC0amH4vkPDnxvAgS4WUHN5sIMKoQ9bDyNxUsUoFQynBEl41PbaNPErv1FoNi8qVAGh17E5ho20rUkKyhcDz0uUNC12vmiZ+h4phMN8HNeRNw3uHnhMcGmB6hi1SqPOxKJr/8Gnc4rDuJmqi1YbWbKIoaVvwNNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa6uwwTl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa6uwwTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C818E1F00893;
	Tue,  9 Jun 2026 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781029207;
	bh=eJoZGNXYmZaB6J4+ar1hqzWoxOAyejNF1psNGF4h7oY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fa6uwwTl3pZK8g8u9xm1gNfJpi17ap2vSnpLblnq83SmKzCuYhD0AcqpN+/azQpVB
	 UJfgJZESAHCush8Wa4ty+Cc0hsAzPrf5lvtVFFHedwWBWcX2SERdDSjsjYWidYXkcV
	 NZWJh+cU4gP72vTaWatuTBDASP1RiB0D+oINHNCWzMuxOBVKAGSmH46mmzZspUGyvD
	 d0yEWbhArjows21GqB8VwwObK/uasP/ItSKWjVosNOQ1RcneEju3TmE3Gn2mr2yjhQ
	 A0wcNDXKFIX730mPaVfo8oTBfFUMUjeNbIpZ13x5Q8EMAYPnpsrFDyGhZv68wSlSMJ
	 XWD3Gzi1CSsVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568A539309A3;
	Tue,  9 Jun 2026 18:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: libarena: Avoid spurious spmc
 parallel selftest errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178102920590.2172433.205048003639089840.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 18:20:05 +0000
References: <20260609063630.10245-1-emil@etsalapatis.com>
In-Reply-To: <20260609063630.10245-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, kuba@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Jun 2026 02:36:30 -0400 you wrote:
> The libarena parallel spmc selftest is nondeterministic by design.
> As a result it depends up to a point on the relative timing between the
> producer and consumer threads. This introduces the possibility for two
> kinds of spurious failures that this patch addresses.
> 
> 1) Spurious timeouts. The test proceeds in phases, and threads use a
>    common counter as a barrier to avoid proceeding to the next phase
>    until all threads are ready to do so. If a thread takes too long to
>    reach the barrier, the already waiting threads may time out.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: libarena: Avoid spurious spmc parallel selftest errors
    https://git.kernel.org/bpf/bpf-next/c/68f4e480b089

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


