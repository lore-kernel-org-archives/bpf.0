Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68079145355
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275019; cv=none; b=FN7ffRohkYXLnxgZY55I9Kop3mNGFd2D0S7j4eDYnR7z0l53Q18XLTq70u2DOekU1397IpWAeIR0BGnaa49Yln0bRf/fjnH+dZrla2Eeyzlxp2Fi8VnKO67e4pIskQiM35Op5irC4r8bSrJcA7BEUDR4RRB8RxXcV8l4XLgB8xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275019; c=relaxed/simple;
	bh=nFGDgUyY8d6OIt/c/Zb9NWbvhG736Ecz3LRf2xwSPeA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u/eqApQAwpTApQr0JNoplQOecGiIERVXUlLPdV/HnOhnG++sge01spe97dYBbxMBLTL5zgnk7G1gOypLO+bs7gGPDoCzZCcLz2V5gUJeAfVpmueA88j4xsgkHwySK+9R70tQ1zB82UfPYfyk2gpnchb3kh+oeKtx+E7EKVFg1iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAXXV1KQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAXXV1KQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2164F1F00893;
	Mon,  1 Jun 2026 00:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780275018;
	bh=HScCnBHI/7rzj/ffYVv1k3oCCWj9T3EgF1RjpLSmbYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nAXXV1KQaUSEN9C3dxSkIgft3bQzyf1NeRsQGHGwAVlpAVxnoNT3HnCukzMvBWjjR
	 OCAoZmi3i2u6aES7z19V2U66JQaQX8Fp32COHbQl/2vytzcdof/GaVLtBr4bVPk4ki
	 xqtqzaEBNgXTe6eUoRb+07LMPMUU7iAKXbipdjHjTkXFRsDjgxE9+uU8u/XTJS+5vk
	 Q5ZbN7TWburQ/ETcdpiN/fIUg2x/8e+Bxn6xcOdytSyKeD7rPwoQYpnQu0RifFxLnR
	 EIvjkgu3UMN4/bxbY+a6NsSVR/cXUHuXPjPzcUSzPCI9vwtQfgcObg+t5OQHScTWnY
	 HKRPJA+Pv3+1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1988B39302FC;
	Mon,  1 Jun 2026 00:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/3] libbpf: Drop redundant self-loop in
 emit_check_err
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178027502064.3441607.11821331034609173538.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jun 2026 00:50:20 +0000
References: <20260529094119.307264-1-daniel@iogearbox.net>
In-Reply-To: <20260529094119.307264-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kpsingh@kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 29 May 2026 11:41:16 +0200 you wrote:
> When the cleanup-label jump offset does not fit in s16, emit_check_err()
> sets gen->error = -ERANGE and then emits a BPF_JMP_IMM(BPF_JA, 0, 0, -1)
> self-loop.
> 
> The latter emit() is dead: gen->error is assigned on the preceding line,
> and emit() then bails out early in realloc_insn_buf() the moment gen->error
> is set, so the jump is never written into the instruction stream.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] libbpf: Drop redundant self-loop in emit_check_err
    https://git.kernel.org/bpf/bpf-next/c/e2c88266147f
  - [bpf-next,2/3] libbpf: Skip hash computation when loader generation failed
    https://git.kernel.org/bpf/bpf-next/c/3c5e2f1a8584
  - [bpf-next,3/3] libbpf: Also reset {insn,data}_cur on realloc failure
    https://git.kernel.org/bpf/bpf-next/c/d2f7bd066ed4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


