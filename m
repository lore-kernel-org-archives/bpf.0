Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DC2502D4F;
	Fri, 18 Sep 2026 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746077; cv=none; b=FE/1MDfBEmY2DcBQz7NmKMZuW5gCGA8IxaQimq+ITOPFyv2n1wt2BOBggsb2k0YZHW4uo5e5zOujk5YxJUQIzltFua+4dNM5wwe4TSIpMEZZtuWVuoTRlhPrXT9Gw3yrWdBc6ROslqMuo7UpjlGSdQKvID8n+T6jhKuZ1NNaZ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746077; c=relaxed/simple;
	bh=nJ0jqfMkhBbh0EY7YFOS9lqsZZjqGxqd1UBptt337Ow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rCRKb4DAUZCCfkmBoMeLRyhMMMMpD31Q0tvVbAh/XT1d6M+kZty0Vl9Ii1/BQPBIqgMWPPDlhtslZYnqAOmpi0kz7oAkdJQebt2zV2ENphx2BTGFggBA6ajIj3lK63Q6/qp0X//njiG1wWmGmiyJRJ7y4jY3U4cJKdJ51z++3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsEW47le; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsEW47le"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775A81F000FF;
	Fri, 18 Sep 2026 15:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789746074;
	bh=QrTzPwZV+cIHnSFVSbgZEXJuYX/Blul42NpRNzRFFzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nsEW47leoMgc4FKORvNabd03usLFuSKRcNZFN4aW2Gy2b8IjCvOmkjH8vOb16uW4n
	 OtLHVecucZGHMkwvo/kFOcb2XsPtL6YobuauLHrX/2qiJmhHJLjyc5l/pOjnv2xR85
	 FnF1Sj1cXHLq3gZnhwAM2ieQvqtyhniQ8KkThAXcCFM/NRmhrWfbPomCBABz76KgDT
	 EkvZd/yoWeULD8qmIHu1Thz0Df88vTJrfp7VoyRl40N+/8j0bGvCeApXdmt+G9PXOL
	 pCNGO/cyreL4Td7NEoFWpr30qPniyQjVXRCxoNCbDmQWELDoE3f81gn/mnpl4/yPCE
	 QCRN32bOoYLKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A8C380CFD6;
	Fri, 18 Sep 2026 15:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v9 0/5] bpf: Add user memory access kfuncs for
 mm_struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178974600740.1015302.4891269233605977297.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 15:40:07 +0000
References: <20260918131757.42802-1-tasos.papagiannnis@gmail.com>
In-Reply-To: <20260918131757.42802-1-tasos.papagiannnis@gmail.com>
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@kernel.org,
 akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org,
 brauner@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 kpsingh@kernel.org, ljs@kernel.org, matt@bobrowski.net, memxor@gmail.com,
 song@kernel.org, sun.jian.kdev@gmail.com, utilityemal77@gmail.com,
 viro@zeniv.linux.org.uk

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 18 Sep 2026 16:17:52 +0300 you wrote:
> On MMU systems, during exec, argument and environment strings are copied
> into the new address space held by struct linux_binprm before that address
> space is installed on the task_struct. Existing BPF user memory helpers
> operate on the current address space or one associated with a task_struct.
> Because no task_struct refers to the new address space at this point,
> programs cannot access these strings from the bprm_check_security LSM
> hook.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v9,1/5] mm: Add copy_remote_mm_str()
    https://git.kernel.org/bpf/bpf-next/c/69d38c792c53
  - [bpf-next,v9,2/5] exec: Clear bprm->mm before dropping its reference
    https://git.kernel.org/bpf/bpf-next/c/adc7fb9955e2
  - [bpf-next,v9,3/5] bpf: Add user memory access kfuncs for mm_struct
    https://git.kernel.org/bpf/bpf-next/c/3f9d98dfed79
  - [bpf-next,v9,4/5] bpf: Mark linux_binprm->mm as trusted-or-null
    https://git.kernel.org/bpf/bpf-next/c/cca46f91737c
  - [bpf-next,v9,5/5] selftests/bpf: Test mm_struct user memory kfuncs with linux_binprm
    https://git.kernel.org/bpf/bpf-next/c/b5501fb38ff7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


