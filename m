Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B1D451044
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134218; cv=none; b=rQM1YbV5HufIbmc+DIYwgQ2nAFklbAMlxvbpaVp/FqKcANkGEiCFu/tszIDg4hpVRw0tbhKgHV7kB+udKo5U2azePFhZoGPP0xW+ycB3wvlKp+vlaAmBOZZ25MCv2HrZaQfoFvAODF80Jw/KJwiYodScTt8ADHHcBlWHor/2WDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134218; c=relaxed/simple;
	bh=MQUzNhvE+luWP6M+agczzNcVCMwBKRVm/fMS+/sWACE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eKVQcL55UG4mXqWgU6ZosdEP7iSHT+wVmy8fSO1gKA73ves3ID3J2wgeoVnnAEABPxUUyfSVjfPQA96Dg2HcYp87nf7NhXye3LR6hjWFRn+g3jbztMTMaOAWm7y/Mr8wwQD2bf8vQqdXh+SlmuawCoSgTWCEnsYuGezSULLyQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1T7ciyG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1T7ciyG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8AFC116C6;
	Thu, 26 Feb 2026 19:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772134218;
	bh=MQUzNhvE+luWP6M+agczzNcVCMwBKRVm/fMS+/sWACE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F1T7ciyGWuKE64VRNm+NkOrlAxPy62Q/lS/nbc1OOS6cLpPCV3OAiag1HhC7i6Tui
	 cW896qebeaW5PoHeiPbNUPW18g1NbkcZIw050qTGrBeVcWeGqGe4o6ngGfUZokNzCl
	 C0wCUFtIUGD1aioLvr8AilzFrTU1Bchwe7HpCc3ISUkAb87+WJhPPQOIbvKebV7S7V
	 7WSpTwnCGXILTZQbC91K9+GK988D9tPYEOZus+N8sySF2vaVENvbxBQIPEmYtG8EP2
	 YVFTXUsPjZvCP3uXqsmA6cC4o5U9DjLEaPdmeYENY2AituaeDYfUUkd07OiVBT5zrb
	 WAxUdYDDXdu7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DC83931090;
	Thu, 26 Feb 2026 19:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix a memory leak in xdp_flowtable
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177213422254.1808439.1401384174214570976.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 19:30:22 +0000
References: <20260225003351.465104-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260225003351.465104-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, bpf@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 24 Feb 2026 16:33:51 -0800 you wrote:
> test_progs run with ASAN reported [1]:
> 
>   ==126==ERROR: LeakSanitizer: detected memory leaks
> 
>   Direct leak of 32 byte(s) in 1 object(s) allocated from:
>       #0 0x7f1ff3cfa340 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
>       #1 0x5610c15bb520 in bpf_program_attach_fd /codebuild/output/src685977285/src/actions-runner/_work/vmtest/vmtest/src/tools/lib/bpf/libbpf.c:13164
>       #2 0x5610c15bb740 in bpf_program__attach_xdp /codebuild/output/src685977285/src/actions-runner/_work/vmtest/vmtest/src/tools/lib/bpf/libbpf.c:13204
>       #3 0x5610c14f91d3 in test_xdp_flowtable /codebuild/output/src685977285/src/actions-runner/_work/vmtest/vmtest/src/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c:138
>       #4 0x5610c1533566 in run_one_test /codebuild/output/src685977285/src/actions-runner/_work/vmtest/vmtest/src/tools/testing/selftests/bpf/test_progs.c:1406
>       #5 0x5610c1537fb0 in main /codebuild/output/src685977285/src/actions-runner/_work/vmtest/vmtest/src/tools/testing/selftests/bpf/test_progs.c:2097
>       #6 0x7f1ff25df1c9  (/lib/x86_64-linux-gnu/libc.so.6+0x2a1c9) (BuildId: 8e9fd827446c24067541ac5390e6f527fb5947bb)
>       #7 0x7f1ff25df28a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2a28a) (BuildId: 8e9fd827446c24067541ac5390e6f527fb5947bb)
>       #8 0x5610c0bd3180 in _start (/tmp/work/vmtest/vmtest/selftests/bpf/test_progs+0x593180) (BuildId: cdf9f103f42307dc0a2cd6cfc8afcbc1366cf8bd)
> 
> [...]

Here is the summary with links:
  - [bpf,v1] selftests/bpf: Fix a memory leak in xdp_flowtable test
    https://git.kernel.org/bpf/bpf/c/60e3cbef3500

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


