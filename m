Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ACC425CEE
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786820284; cv=none; b=KZ3ddrntlHWb24KvlboWZqeqbLj9UDQwP7CxYF86W1+KNvYpK/kVZbI/U8SHQ3G+yEkC2ptcSNW7I2bLxuTKZ8nW4pi5wJ8ZuuW1dJk4eebqfwM76Lhm4LYke+alDu+1GLE5i77BgDGFSncXWbp0R/kvfmFKeWrFQ5xMDBEgOl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786820284; c=relaxed/simple;
	bh=9DHu33ktm+zdIO8lnZV4lbGsiMbOBbfzDHwk44yigfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gnwf5LTol+fruMT579Fijfh7ssIifnDmhFVjYvjbHfF72YqXTbCZPVwVCEZFD9CqSEALTEPYSqGNYUTp0bNxzf3FeXtTu/2iM6UoXroU8k1B+0xQfT6dmkX0yPlzCgJh4p+zcXIYKe3ccmS3hyeiqngC/m+jzzyAJFtIDCIucv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5mbMG/L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5mbMG/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13201F000E9;
	Sat, 15 Aug 2026 18:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786820282;
	bh=Z9GzlBdBh/rVHmfIAdGkNeEoignPe4VSqxeSyX6YLCU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I5mbMG/Lz9BnyQQkE+dpSZuHZ1Nnb+lbNULSdxEykd37qLrxcGZJBM2s7JZccafmm
	 uf1R/qGl/hixdnPFBgMm6vAjXB5+wzGwb4T47xU05MIXe8hRhG7VvYYURDI6b3lOoz
	 nJlzjNcwAtTnwTG+JdtPso74VvQP+ovWcESwiwmNryTZs/uQfo+qqTVMJGbu+5qZ4L
	 lURLglYcg4jCpPcR74s1HN1VjxAK/j+6n4HAH+4cvooM79kxccz0VR0ArqNZorXz8E
	 cofATK/GibgLX9VUViab29D0t/CEFJuci1h3MKI7hU6Qh6aC1R7izNA0Utje+t0f5F
	 O7+uXPWh1aMeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4E3811968;
	Sat, 15 Aug 2026 18:57:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 00/14] Redesign Verification Errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178682023625.53386.10978136746024990805.git-patchwork-notify@kernel.org>
Date: Sat, 15 Aug 2026 18:57:16 +0000
References: <20260815064612.378577-1-memxor@gmail.com>
In-Reply-To: <20260815064612.378577-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Sat, 15 Aug 2026 08:45:55 +0200 you wrote:
> TL;DR: This set reworks verifier error messages to include source and
> instruction annotations, together with more causal context, making
> failures easier to understand and more actionable when debugging and
> repairing BPF programs.
> 
> Changelog:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,01/14] bpf: Add verifier diagnostics report helpers
    https://git.kernel.org/bpf/bpf-next/c/5ad746166341
  - [bpf-next,v5,02/14] bpf: Add source and instruction diagnostic context
    https://git.kernel.org/bpf/bpf-next/c/b9c5d822f677
  - [bpf-next,v5,03/14] bpf: Add verifier diagnostic event log
    https://git.kernel.org/bpf/bpf-next/c/daf8248701b6
  - [bpf-next,v5,04/14] bpf: Prune verifier diagnostics when switching paths
    https://git.kernel.org/bpf/bpf-next/c/a6debd5f25c9
  - [bpf-next,v5,05/14] bpf: Track verifier register diagnostic events
    (no matching commit)
  - [bpf-next,v5,06/14] bpf: Track verifier reference diagnostic events
    https://git.kernel.org/bpf/bpf-next/c/9ecd70304e28
  - [bpf-next,v5,07/14] bpf: Track verifier context diagnostic events
    (no matching commit)
  - [bpf-next,v5,08/14] bpf: Report Register Type Safety errors
    https://git.kernel.org/bpf/bpf-next/c/d63284e62b31
  - [bpf-next,v5,09/14] bpf: Report Memory Safety bounds errors
    (no matching commit)
  - [bpf-next,v5,10/14] bpf: Report Resource Lifetime reference leaks
    https://git.kernel.org/bpf/bpf-next/c/5d5764627555
  - [bpf-next,v5,11/14] bpf: Report Call Type Safety argument errors
    https://git.kernel.org/bpf/bpf-next/c/66e2727395dd
  - [bpf-next,v5,12/14] bpf: Report Execution Context Safety errors
    https://git.kernel.org/bpf/bpf-next/c/99a6a288a82b
  - [bpf-next,v5,13/14] bpf: Report Program Structure CFG errors
    https://git.kernel.org/bpf/bpf-next/c/a8f427835394
  - [bpf-next,v5,14/14] bpf: Report Policy helper and kfunc errors
    https://git.kernel.org/bpf/bpf-next/c/ac545b00ca56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


