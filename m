Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE2231C91;
	Tue, 25 Aug 2026 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695761; cv=none; b=tM8ARo98S96L2FogCUCoKJU891ox6zg7kOsMQC6lEFReF/ahiWlhdO+cwb4hsvHBQeZ8XjY7BqcNLVNDfTHjA5pJnpJ1n5PFaq8pMWAUzClAmjSo1fO+ifgwM/MuUlQRgFuLlclYkh6QAmiIiTlWnO08MrCp4gPKv9nGjgy9PIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695761; c=relaxed/simple;
	bh=KIUnw8rnY0XVxoLq1hmY8srQ4m723IykO0zotJmInZc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c3FiuAuKOibLKURnKbNIusRSp/jY0kZrOtjavZSUAzuGYZhIRT2v/61V9nk62fBMvxe7EcTIAaMTwFO2Sm1GnuptFKxWGz8OuqSJ9T+o2tbY7b/DSFegykLRDwI01bWjDKgMm0kh8QJBrX20bDxKwylKFFYlWbbaIb+XrokdTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnA7TxQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnA7TxQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBB61F000E9;
	Tue, 25 Aug 2026 22:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787695760;
	bh=6c0zJgkl9EwDaCotrqn+qbGYtv9Z9zIIP+Eq/7Fsr4E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GnA7TxQ2vO6Kpf48wErLV12O5KZxmOv2KzsqkB4HrYU6LT9N7P5s2Rnn9dgcInsWg
	 XlICXO71suN/QsJljQT7fETExlFwzmvj3KPvr49+o4pES8viN5Lq4HQFPXwd4HbPcq
	 jCQR3Pf/XGX4E36TTVtpPp6iM6Z1YSxeczyjPYrYL2ILE/ukRA/kHDicWsG9gMDrW0
	 V0/GzgSj4FxILPAEIXOeyRsigcFjkQAJ60WLopMyCWlZA1aqzj3NijGvv/aBEu2X9A
	 CXL+Qn+sFkM588xUgqN/1I6FmYusEWKvFNGsiKSQlJ0wiGfY17QLLpl7Ro7ZQ8hHsd
	 bx7AA6eoF0yRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939BF39253DF;
	Tue, 25 Aug 2026 22:08:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/2] libbpf: Fix usdt attach failure when nop10
 crosses
 page boundary
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178769570714.4034253.13134837502022384543.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 22:08:27 +0000
References: <20260825150444.31603-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260825150444.31603-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, jolsa@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 jakub@cloudflare.com, mingo@kernel.org, phoenix500526@163.com,
 peterz@infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 25 Aug 2026 23:04:33 +0800 you wrote:
> The kernel refuses to attach to a nop10 that crosses a page boundary,
> since it can't be atomically rewritten:
> 
> 	/* can_optimize(), arch/x86/kernel/uprobes.c */
> 	/* We can't do cross page atomic writes yet. */
> 	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >= OPT_INSN_SIZE;
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] libbpf: Fix usdt attach failure when nop10 crosses page boundary
    https://git.kernel.org/bpf/bpf-next/c/8b94878b2572
  - [bpf,v2,2/2] selftests/bpf: Add test for usdt probe with page-crossing nop10
    https://git.kernel.org/bpf/bpf-next/c/1555de33018f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


