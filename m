Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EE5372662
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788487272; cv=none; b=DNk+dmCO+kXo6qeeoi0Xo/S35wcmis9hUNA3c90JqB2M4v08fMpJdDuHrzEvmKHieR9thnKS9z3Ia65RNkBmxD/sOxzHmYj0lT4eFTCnERrLe0ZPxOCElDrjS2Na9GZ6qQMcSAJTysIKtAtnB9kJwdzS19Ri3wX8RBXAM2C8JwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788487272; c=relaxed/simple;
	bh=8yzs0jabwtdb5WiXY2w1qcVX1ps5QipsAF03gd/7ACo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZJrAuYmKQ6pG9HVMUVE3hVsSfi4Sp8YJO8bpwWaD3BOYmWwNbHYdJmlXbjfxdi7FXYguze+Z0lt2TDAXsQx1PZ6FOtj3Yb7sCFmOOHPPsmH6UXWKnK4JOVCCqT+o9Tp3tNT/m542harE2CRM3PtfagIjImZ7/vxIiUhsSHalhto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMLewiv1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMLewiv1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA9B1F000E9;
	Fri,  4 Sep 2026 02:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788487271;
	bh=X5VpBHaKEFIT1xnTBDD5wNVonLn/QaNce8ioPpql2jY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EMLewiv118Mi6RBet3aNuj6HaQJXxkGshbQuLiojv2l9/TxeKb73GOlWgwTej72eL
	 /4OGUDngBz67wMBwuRPYYpdQwvhk9sAEGgVzoffeCwSR/+W8bp9qAPpgccHVr7YYDQ
	 1aVgfZW/Lq9N/0TBGTLb6Z41nBGVzutHbJH9kH/Pm0U9QM+k0SkPq9F92jKYPPmlzf
	 m7P//WUPqVNadH1l+0Kzfi5CGm5BGejoGsp8Uj/jQ823FTPfrIMH+gnHdUZaWJ0lac
	 EcQG9+l5ZVsWX5rqFIT37XfrmcJfng5jZ7N26ajG/yznjz8kmSeRJz+14opZoBAUNu
	 TAqJrfbI8GknQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A5938119E3;
	Fri,  4 Sep 2026 02:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/3] bpf: zero extend the result of an arena 32-bit
 cmpxchg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848721214.4116251.11029484236998441366.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 02:00:12 +0000
References: <20260903171542.1438050-1-eddyz87@gmail.com>
In-Reply-To: <20260903171542.1438050-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, memxor@gmail.com, npc@anthropic.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  3 Sep 2026 10:15:39 -0700 you wrote:
> bpf_convert_ctx_accesses() rewrites an atomic on an arena pointer from
> BPF_STX | BPF_ATOMIC to BPF_STX | BPF_PROBE_ATOMIC, and it runs before
> bpf_opt_subreg_zext_lo32_rnd_hi32().
> 
> That pass emits an explicit zero extension for a 32-bit cmpxchg even
> when bpf_jit_needs_zext() is false. This is done because on some
> architectures 32-bit cmpxchg requires explicit zero extension for the
> dst register. E.g. on x86-64 'lock cmpxchg' does not change the %eax
> if comparison is successful, while BPF semantics declare that each
> operation on a 32-bit register zero extends it's upper half.
> 
> [...]

Here is the summary with links:
  - [bpf,1/3] bpf: zero extend the result of an arena 32-bit cmpxchg
    https://git.kernel.org/bpf/bpf/c/4814ed6406f3
  - [bpf,2/3] bpf: update disasm.c to print BPF_PROBE_ATOMIC as atomics
    https://git.kernel.org/bpf/bpf/c/1f3cd9719c40
  - [bpf,3/3] selftests/bpf: check zero extension of an arena 32-bit cmpxchg
    https://git.kernel.org/bpf/bpf/c/54ed91950363

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


