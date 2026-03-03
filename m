Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09FF47F2DF
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556624; cv=none; b=ZthBIf0ha2oL/JwXKL00gvFnCkhTHkY2VAEl3G4gXozqHe77a6zd2/FUylmhVeS4DwtOhf2+kgJnn5RhLPK1N83nIhMm2zVu09azf7bL7xmDOkWVBVEQ4+wqjqKc0AcjMNOtXETRqJbK8UOn5455/McMxA+r3PLWPw0vUQwLPJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556624; c=relaxed/simple;
	bh=TLj+fEwXyod5YZubWKzmjs07NflfH5b8nes4tUwcT9w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tfPzdYYUExFGKCYlwllliT0SWO14BnznOh+z7zdxD8JoqI3IpPjQWNvm4lNhuboZ1BlpOeTaVYXIcq2zno133csZivEjQDvNFErXr3mmdREJ+QHszPuBmKaQ3Z7+2JIuiaix8/Dbl5SHoZPXqoTiWU+jkQJG8ugPX0txEBd3Z/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnmlaCRg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnmlaCRg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE91FC116C6;
	Tue,  3 Mar 2026 16:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772556624;
	bh=TLj+fEwXyod5YZubWKzmjs07NflfH5b8nes4tUwcT9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CnmlaCRgMeFAgBBqnOGMW7lW4UOm+FFGMWgakdgehBIUT3h54NBkWMfT8YqnH3poJ
	 LqZdxfBTri0SEMGLPijLvAeyNvPPF09WiVRYooiwT+03YErGej1GicnCyutJS797/m
	 ONDkonzA9Bqdtf+D7M0n0SPQewrEa8QdaUk18HgCKLmu8cW+Ki+P6NJ01ZEkEIx9B7
	 L/yiGNx494BuFEoYbKFNrLJDhJkgPJoK2CJI7F8XOObo3Nv/rJQiITbTmE4o71rbuA
	 z0jv3k+Qhh18rHPcxW7ncdpes8g7XV+8bid9LVVNfJ26M2GFjtWywFGd1ZiwCbbkdB
	 2fPUgY7Fq7aYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDF53808200;
	Tue,  3 Mar 2026 16:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 arm64: Use ORR-based MOV for general-purpose registers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177255662579.1383432.9417786387157861523.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 16:50:25 +0000
References: <20260225134339.2723288-1-puranjay@kernel.org>
In-Reply-To: <20260225134339.2723288-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com,
 xukuohai@huaweicloud.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 25 Feb 2026 05:43:38 -0800 you wrote:
> The A64_MOV macro unconditionally uses ADD Rd, Rn, #0 to implement
> register moves. While functionally correct, this is not the canonical
> encoding when both operands are general-purpose registers.
> 
> On AArch64, MOV has two aliases depending on the operand registers:
>   - MOV <Xd|SP>, <Xn|SP>  →  ADD <Xd|SP>, <Xn|SP>, #0
>   - MOV <Xd>, <Xn>        →  ORR <Xd>, XZR, <Xn>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, arm64: Use ORR-based MOV for general-purpose registers
    https://git.kernel.org/bpf/bpf-next/c/b1d6bd5462f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


