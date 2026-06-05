Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4979239A4B9;
	Fri,  5 Jun 2026 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695030; cv=none; b=M6HXz1sf2mlQLgTV8Oa6jmc9opgFylb57e2gELVa5xsACDL/w0XaF03dbu0ADvRI4XVBaxYxuFOEMoPzgw+oF3K0Vw8BFMzPjxtB8eSCIGy5LKEFNkBa1u4McvNyXmRyH9spjJ3wQgg3oY6Ce8UTEHqVl8jA1qlpBA9kPvGQ16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695030; c=relaxed/simple;
	bh=fdZSoBfDvgRDPhXFcZwO2Lr778PTgRQJfFAMKzrGcDI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AQRYjTIT1lWn46CmZ3q4qT2NNSB7gGdoIwc7FmxaeriHXNhWC+57jGESHxCn50n88gIiJRjg158KzYfowUN9Fqip9DHzURcF2WdW6NS3T1dTm2ndh7Y13tMKVoSZdmuXCcdaZwoA31fVxy269aQJzjlXnQTEFzAOAo6oe11XbMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkWCfs9/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkWCfs9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EF91F00893;
	Fri,  5 Jun 2026 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780695027;
	bh=Z69GpddxJ/SIhMY4VMCzc9llLu2bxuDx7glOzEnsb/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HkWCfs9/610ClG+iKk1ZXbgt/dKz0rrtrJLuQlHS1puLJiFjAZXVFofQIJROuSeVG
	 0q+4H6REcwXbsewRHe9yqMg8lnGimab4eX6Z88Ay8LdB1bmutIXbMST96t2+bi/3lO
	 1EGkHejBndMj1QWAeJkbj6bK+6/4urjW1q8VE8T43gmnPtSPs4fe9ge9cQ44ZhaDln
	 lRLHKMZ7zJb7crHcOXMxj/pYidhkn+dphdImVvpEqLMtVgPEiorz5xmR6S/VdMdu3s
	 th7vD48RDbnj1y/tLWV0dH0hT0mCqsDEslLdTRCDCrTZDzAvMNrUDpOeuzROjLDaAW
	 ZhJ6KjhQXGXpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569363930BBE;
	Fri,  5 Jun 2026 21:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next RESEND v12 00/11] selftests/bpf: Tolerate partial
 builds across kernel configs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178069502789.3925764.15952069390143619686.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 21:30:27 +0000
References: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
In-Reply-To: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, alan.maguire@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 02 Jun 2026 10:02:49 -0300 you wrote:
> Currently the BPF selftests can only be built by using the minimum kernel
> configuration defined in tools/testing/selftests/bpf/config*. This poses a
> problem in distribution kernels that may have some of the flags disabled or
> set as module. For example, we have been running the tests regularly in
> openSUSE Tumbleweed [1] [2] but to work around this fact we created a
> special package [3] that build the tests against an auxiliary vmlinux with
> the BPF Kconfig. We keep a list of known issues that may happen due to,
> amongst other things, configuration mismatches [4] [5].
> 
> [...]

Here is the summary with links:
  - [bpf-next,RESEND,v12,01/11] selftests/bpf: Add BPF_STRICT_BUILD toggle
    https://git.kernel.org/bpf/bpf-next/c/a6850fa388f6
  - [bpf-next,RESEND,v12,02/11] selftests/bpf: Fix test_kmods KDIR to honor O= and distro kernels
    https://git.kernel.org/bpf/bpf-next/c/9779193e871b
  - [bpf-next,RESEND,v12,03/11] selftests/bpf: Tolerate BPF and skeleton generation failures
    https://git.kernel.org/bpf/bpf-next/c/c476bdf27657
  - [bpf-next,RESEND,v12,04/11] selftests/bpf: Avoid rebuilds when running emit_tests
    https://git.kernel.org/bpf/bpf-next/c/a97bfc9aae07
  - [bpf-next,RESEND,v12,05/11] selftests/bpf: Make skeleton headers order-only prerequisites of .test.d
    https://git.kernel.org/bpf/bpf-next/c/5498e47741c8
  - [bpf-next,RESEND,v12,06/11] selftests/bpf: Tolerate test file compilation failures
    https://git.kernel.org/bpf/bpf-next/c/9c4de137a9a5
  - [bpf-next,RESEND,v12,07/11] selftests/bpf: Skip tests whose objects were not built
    https://git.kernel.org/bpf/bpf-next/c/aeb73a9f301d
  - [bpf-next,RESEND,v12,08/11] selftests/bpf: Allow test_progs to link with a partial object set
    https://git.kernel.org/bpf/bpf-next/c/af490669fd33
  - [bpf-next,RESEND,v12,09/11] selftests/bpf: Tolerate benchmark build failures
    https://git.kernel.org/bpf/bpf-next/c/f813a4d6877e
  - [bpf-next,RESEND,v12,10/11] selftests/bpf: Provide weak definitions for cross-test functions
    https://git.kernel.org/bpf/bpf-next/c/b85e63cb65f9
  - [bpf-next,RESEND,v12,11/11] selftests/bpf: Tolerate missing files during install
    https://git.kernel.org/bpf/bpf-next/c/3ca6543464f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


