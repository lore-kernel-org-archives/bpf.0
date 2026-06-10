Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB6B43C079
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104217; cv=none; b=LHVGkyjS3y1GDZdiO/tkkbp1TOmOBysibfM7A0NNaDuDVtDWsQJHl6fJ0vHlaFdjuGVLICd0ApUOEEh5VB5sLx4u+ggREJJHVozp1NSfTCi0gd5jYAb0umCpQ8iReNAfb/omnoV3UKjFZqShDz6k5RksOTuZxhLZEK2oHcG/PDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104217; c=relaxed/simple;
	bh=05S0yOYLddk5hHaQgUNsXd9rFc14eOED5u46Gb0DAHg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eGI+XdzXrwSvt2fSJ3WrrYo0ePqly/fzRtYuLPlJTM/Q8RdP/WEa4/LMwHNUvMRbafTsk16rlOn74Fzcep9+dMEAH8vsFI2aLzIN1Jd61I9Quslbw9O47M5R7tM6/9vox9++CZCsxvnE0t16SHv2unZpsiIRFN7gtqVzyIO2lWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2Ma48D+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2Ma48D+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E71F1F0089A;
	Wed, 10 Jun 2026 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781104216;
	bh=YTBACdzYC0m1sfjAugFPn2aveydq4thLmcD+xldBZts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=i2Ma48D+IdDFEnM8xOu3i4yFmiOi0/A+tkstDGSUv757wVFlZ4qFlTLxHObYe9mf8
	 NgFCRDOfFy3mIDTCZEPO4FL0XyMjS0zKjKH30S6v1X1c7BjTCZE5tyU1dYWiF//jKb
	 i8no4sehnYONzETNoK7lHsySlBgwiFpenvbpshUzx9j6QfC1iQERM0rNQZvfilQqv8
	 h8iHelB/fDsnaQZFnDT3PDFHyDVvpYRlK7Irgblb3MagMfLIcKT6q+es4eyN0jFTUE
	 XSMBSqTLlic48FtJggByZoy6XN/LtF7GGL2Yot/4Uxj2IxvPB1ZF7tT+QWqpiPw5FC
	 yLl5HGVzFBl3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939073930D5F;
	Wed, 10 Jun 2026 15:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix bpf_iter/task_vma test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178110421414.3082243.2862648154007476914.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 15:10:14 +0000
References: <20260610051831.1346659-1-yonghong.song@linux.dev>
In-Reply-To: <20260610051831.1346659-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Jun 2026 22:18:31 -0700 you wrote:
> For selftest bpf_iter/task_vma, I got a failure like below on my qemu run:
> 
> test_task_vma_common:FAIL:compare_output unexpected compare_output:
>     actual
>     '561593546000-561593585000r--p0000000000:241256579534/root/devshare/bpf-next/tools/testing/selftests/bpf/test_progs'
>     != expected
>     '561593546000-561593585000r--p0000000000:245551546830/root/devshare/bpf-next/tools/testing/selftests/bpf/test_progs'
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix bpf_iter/task_vma test
    https://git.kernel.org/bpf/bpf-next/c/2e8ad1ff712d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


