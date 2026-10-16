Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5548E4E2F10
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792173020; cv=none; b=s2xGzHW4WVGAspPaNaXKnKv3urHE4uNzApYZ8L6vTFCo8ugaZipxIjzCve84bNEGKJhlSNaYzCt/Vbw4lOs9NgblFxEji5ZEUAdgm6E2ZZveHm7V33xRbyS6L+VGgtibK4WheJuh9FjpD0m+6PDM7p333mbsZrX/dYSZ2jwkFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792173020; c=relaxed/simple;
	bh=OduHUoaGajHSnojOfnwkJNlccgNGaq5N/6thyyORm6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eP3lbw0WvhrJe/tQtp+Y1FGu6SrCH71716RjG1LwcgBQTtu4zxefMMVPrLvQzdWaXkLL220CXazbWwsw1RyeDwBmRdDAI71OxB7OTYzIIn8Sg5sGDqqcD44q4/IjjYd9H+I4E53cbfCPP0kHVKTD5FlLc3FEQLJN3DPxrEP/H88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmAn+2pP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmAn+2pP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068D91F000C4;
	Fri, 16 Oct 2026 17:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792173019;
	bh=cEdQgYi71W48VS49T0f+myWJmE2vIihpr3f7xBMPGUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mmAn+2pPep7ApZiesg90BHrj7H9a+36oWn/y3K7CXH5YjTfur6zNdZK2AYFD9SRSZ
	 lBFVSZEXPcf3drLBLWyuQe/TVpDAOfPCSNJ4Pp7ILLUAIaabFpoafeg1uvE4GRopE1
	 ll80cb+9TdB5lsXL33iDTZ+dCY2y17UqFPeKRYHeKKWeqUVjQFVKUfUpoIEO7+IbyR
	 2Vqtlh1ehLqv6x8389vuNzmNY091gT9K/7F22R4JA3R4IeWC/RTthaTNdmEhVFEAOA
	 6Wbs3j2xFXD0bpARAtHIIF7MDWIFaSeIX753yDGW1V49tVHJraC/uEB27kHuQi1soL
	 o1ocMAkLnPySw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1354380AA60;
	Fri, 16 Oct 2026 17:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Free the subprog jump tables once the CFG
 passes are done
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179217301777.897417.11449085919420198009.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 17:50:17 +0000
References: <20261016155559.652461-1-daniel@iogearbox.net>
In-Reply-To: <20261016155559.652461-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: alexei.starovoitov@gmail.com, bpf@vger.kernel.org, ast@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 16 Oct 2026 17:55:59 +0200 you wrote:
> The jump tables which compute_subprog_jts() builds are only read through
> bpf_insn_successors() once CFG discovery is done. Its last caller is
> bpf_compute_scev(), which runs after bpf_compute_live_registers(), so
> free the tables right after it instead of keeping them until the verifier
> environment is torn down. With large insn_array maps, this also drops them
> before do_check() starts to allocate states.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Free the subprog jump tables once the CFG passes are done
    https://git.kernel.org/bpf/bpf-next/c/d2141481a764

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


