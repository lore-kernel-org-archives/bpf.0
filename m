Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324FA3E4C68
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540833; cv=none; b=EhGGID1j6Jz46wQL1dDpW9x5P3qLRaE0BYjyFv0wikJeVbLf9AQANJGgdshTbKfZ1mNlScvQBfdhvrtAFuT5hzfoW9k1RbeBLbEqymdv/7XFHAfUseklsCTlMdao5xrFIc9vXDmoJjd6popGeFpMRMYwAscSrDKPbbDn4/05aMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540833; c=relaxed/simple;
	bh=XHyBfjkGtFBgD36LM/jzcVm6R5wRArjl7fh5gbW01Oc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U6Z+0YQ+RyFTlu1xS0UPYDrDyYE7fREXXSxuhrccjYPFjeGGBa1t/TUJUtE+JWjWAM+k/HfAJUfTy6nwYwQP7ZG2GkGmDANzi9UVNTh/ifaX22TYpfCKILwYOAG6XXLtmsL5SFeBty/lnSDKJ+Qmgh5lX6WcD6xa0HBIy/vF+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3sNNdaH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3sNNdaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB331F00A3A;
	Wed,  8 Jul 2026 20:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783540828;
	bh=GbmilDbAMPXjc2I1qXy5xgcHPdgUdt9/AnPN3cjiVco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G3sNNdaHSvfOJYTVw13G6ACOqIOXiW3ZjfBy6jGMTDcZzt+0E3TZNrfFHrXtFS1Fn
	 J5B/5d4/mt1jLzM234lsdvs686y9evDlo8p5lMJoL2+7a6AxZ2A34NVSG5X63HQsG/
	 waVpe/FvlzZ5MdBYviXp5E6fDOigDl90WqPZt+6XEO+bInRLjXYb4H3N5/2czl3bTA
	 QYYisOvNAbevU69Zi7f4DziADxH5ULv6qnexyAWPSHrG0G5BH+b02n59kqMwHej9r4
	 tlD8uHCxt+9CdPcB5HCgSV+PLgK0VF5FOxIi4kLbHuKbsyRAEUMSUDy3AGLnRBu2Qw
	 6gxBtMthBmNUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5693A3927224;
	Wed,  8 Jul 2026 20:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Skip res_spin_lock_stress if no
 perf
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178354080689.3087685.11132788742995671066.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 20:00:06 +0000
References: <20260708104729.1248234-2-max@linux.ibm.com>
In-Reply-To: <20260708104729.1248234-2-max@linux.ibm.com>
To: Maxim Khmelevskii <max@linux.ibm.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 bpf@vger.kernel.org, iii@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed,  8 Jul 2026 12:47:17 +0200 you wrote:
> Probe PMU support before loading bpf_test_rqspinlock.ko,
> otherwise the test fails with not obvious error without
> proper perf event support:
> 
>     Failed to load bpf_test_rqspinlock.ko into the kernel: -2
>     serial_test_res_spin_lock_stress:FAIL:load module AA
>         unexpected error: -22 (errno 2)
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Skip res_spin_lock_stress if no perf support
    https://git.kernel.org/bpf/bpf-next/c/41ec7e4a1779

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


