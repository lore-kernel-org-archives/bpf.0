Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C72642089E
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410028; cv=none; b=RolyiAdMb/KWvEXJw3Lo5WdSNe8vOTW8/Bfa1NHMawTWj3SqjIG7PDEP+M18wbuzVJ1CZgbTku8cQL7/khSEWDpGMtUCwCRUtmBO9C0P+rTjGgJwP/IAkHUfrotzCzY4NBLe0J/HSsW0J0eCzHjLyULq7Jb3/7fD9AeI/cYnp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410028; c=relaxed/simple;
	bh=p1o4jh/CipE4oIWg7Cj4tKHkt55FSpaxGj7uHViY+5c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ovPNO+voGWvIhLI7G6qpmCGN2P09KT6KzM+FWIfraCDSB/orhh9IssmuDZSS7Fre9TeCqUFEIJegbvlDYit71E0f+GMLyG2k4AUr3NTl3Tzvfb71m9XSeDeVn/EfgX2saczpJLCihoro9KDlAKex0kKvQSZhKC6WKKl5Rzr2bUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NH9xJFGh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NH9xJFGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148251F000E9;
	Tue,  7 Jul 2026 07:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783410027;
	bh=s+jXfTma7lwhtlVKeQP4Di6ygGtUIDA1mvpuxqBZOfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NH9xJFGhPTxuNGbnAcu81jYPeLWZnr1+cV2/rh4V3i0nLN6/jtabKOqZdm0FO2QUG
	 cgtyh9LxMZrSqafCDjuCi0kcn+idopP/Qemnh5038mUt7c1msoL4l0HXBRbrNvvNoW
	 LBQI711+Lw4kaBQioJUFZ2xoQiXVkPNjUUFk/5KBSL84vgmvAI/AZ6ZZ5QGl9foxCd
	 R16s3irzYM7sGhZ3th+hbyyydZtNzCP5eiX33DfIZoX6p4fwa2ReRvK6SF8VIzG1o9
	 ZkSd0LrkF2rkID9dMkaOiO/VTtwqQfBTCMYZR8NWoUHTgYQQsqGXGMz5Uq8vD3Nrk8
	 8iG8ZYIQYGq0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568A13925457;
	Tue,  7 Jul 2026 07:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] s390/bpf: Replace ly instruction with llgf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178341000689.1401757.18314278498253295999.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 07:40:06 +0000
References: <20260703125648.919196-4-max@linux.ibm.com>
In-Reply-To: <20260703125648.919196-4-max@linux.ibm.com>
To: Maxim Khmelevskii <max@linux.ibm.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 bpf@vger.kernel.org, iii@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  3 Jul 2026 14:51:34 +0200 you wrote:
> Sashiko found a bug [1] in 9012cf2491e3, where upper bits of a 64-bit
> register are not zero-extended after ly instruction in used.
> 
> Tested:
>   ./test_progs -v -t get_smp_processor_id
> 
> [1] https://sashiko.dev/#/patchset/20260414142930.528751-1-max%40linux.ibm.com
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] s390/bpf: Replace ly instruction with llgf
    https://git.kernel.org/bpf/bpf-next/c/4abb1bdb600b
  - [bpf-next,2/2] selftests/bpf: Add test for bpf_get_smp_processor_id
    https://git.kernel.org/bpf/bpf-next/c/f71f6c98d1fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


