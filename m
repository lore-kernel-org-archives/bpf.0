Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95828234973
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 00:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084872; cv=none; b=cnwEiRkCOB92w1k/yqBv5aveLtR+xFMeV5XGu52NfuFS3g/+Eg+mDUjhdRagDRPmvustnj6U23gV5Xj/qlcW64kBwYJJ3fRTaDhng7ZdymN6yDE3zEDHEJ4k4Vxuqu+XTmjhOdyZUwiCttLrtvZ/EYGXpFXnuJney3AciQ+2bos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084872; c=relaxed/simple;
	bh=b5IszMBcaOi62svfHEnqRetPLfOyeaZuCdVekUm5aFw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OeJPeCIKmY5cdW32D1kj15rXTdEHUhZzNHVKrTnyzVc/L48wsJsRnLKN0Fc8Lhh0MyAW/l8/ejWYDIizuCzPmNGnosPvfa0HtaZd+j9gQBwMjhr/yDJOYoR7D4d54SxPd6BJ9w8hjuiVERn7izbHpmVTQSdhBWVIQbET+P1WBAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWmW6pC+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWmW6pC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FE11F000FF;
	Fri, 11 Sep 2026 00:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789084871;
	bh=Mhu9iLnwApZpBaGjUg4r38xh2ncLBRs7tHLx97icGtE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YWmW6pC+HCd90c9wZyARGnf6TnNIBetOpgofINAUT3a8pYxKGL1lDpTaaLt5FCZoW
	 /xMkZsMhcrKUfgXTP9/zZTqGN7wbtHL90J1J8IJo+ha1BLXEI15VfW1VdPy6hRXY9e
	 0b/RyNN9B80Q+VPv9xXRTjjZHcfWDvXaDqSFeA9xyOJWt1JbJsipx40CKIRaWGHapu
	 6ebgT1rQHgozflz11YPHzdjRFuwAFlhTgK71ivFrlehUKOMoRRN9n/1PWGvdNjuLhn
	 CG/8+lpUGOtb+osD7df4yJOMrN6CMbzVBfD0Wrxc2OH8uRTDxW48leW1K1MH7gxbnt
	 Xqyp+2WchlHYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A333810901;
	Fri, 11 Sep 2026 00:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/4] bpf: Add KF_PERFMON kfunc flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178908480813.2150752.11899607418108450585.git-patchwork-notify@kernel.org>
Date: Fri, 11 Sep 2026 00:00:08 +0000
References: <20260910213510.49358-1-daniel@iogearbox.net>
In-Reply-To: <20260910213510.49358-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, memxor@gmail.com, eddyz87@gmail.com, info@starlabs.sg,
 bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 10 Sep 2026 23:35:07 +0200 you wrote:
> Tracing related BPF helpers e.g. under bpf_base_func_proto() are gated
> behind CAP_PERFMON. However, the same is currently not true for kfuncs
> and they are accessible via plain CAP_BPF. Add a new KF_PERFMON flag
> which can be used such that check_kfunc_call() ensures env->allow_ptr_leaks
> is permitted. This follows similar pattern to existing KF_DESTRUCTIVE flag.
> 
> The rejection returns -EPERM to match the other CAP_PERFMON gates in the
> verifier, that is, check_ptr_to_btf_access() and check_ptr_to_map_access(),
> which report the very same policy to user space.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/4] bpf: Add KF_PERFMON kfunc flag
    https://git.kernel.org/bpf/bpf/c/88ce88e933e4
  - [bpf,v2,2/4] bpf: Require CAP_PERFMON for kfuncs reading memory
    https://git.kernel.org/bpf/bpf/c/81c975aae375
  - [bpf,v2,3/4] bpf: Require CAP_PERFMON for untrusted read-only memory reads
    https://git.kernel.org/bpf/bpf/c/f9191460cd80
  - [bpf,v2,4/4] selftests/bpf: Add tests for the KF_PERFMON gates
    https://git.kernel.org/bpf/bpf/c/a903f145a891

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


