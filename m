Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989501DDD1
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577433; cv=none; b=koBXC2zyX7tYs3a51lWjFVwEEwHDeyJtwnhfFSU+YOdSe7P7NhC9HKcTvxc1jldkaC1T0lNzVqSnkCS0vdME45iMebG2yfCtHWbp/PoCHt9x5RkTFmZvfeE6SeNkCrkmqh53+exYchuAlaIE3xLyVxr6ZMg2s2MFq0PFdzzBb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577433; c=relaxed/simple;
	bh=pDYGyawPGEmDGFPRCqJt+G4naw1fg9dnue6C4Jh0Lkw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q9YplzTYRt61X9BBA4UZDadnuaj/Y/UbSVF3qXtopQBo+qpmrF/f8wzBmYW3zffvswoAq+AhATm8MJ5GFNIImIoDGZJZ7bQeNu74D+G2ISEwTshVDV4wlL8mdhRs/dY6wCvX73mcIWpn0ljVeVXx/eDdH6WBCzs129JS5d/YxmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5vJ4rQf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5vJ4rQf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 215DDC43390;
	Wed, 27 Mar 2024 22:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711577433;
	bh=pDYGyawPGEmDGFPRCqJt+G4naw1fg9dnue6C4Jh0Lkw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g5vJ4rQf9+0SFGkdMHejVf07pi+g8A33QwFrV1mWi7VlS7wqfk89djZeXCp24TZz5
	 VT1OxLShG+IXEPj61vlskez7NuCBNb/Yt3YJFY72stfg+qo2Z7p0PA4ZLELF0vY24K
	 PoRtEcIsG/oGXbo0YNJwvHRw0YAYuvrlWmenD9muG2hhSyWN7M9ljJMXDyAYwB2xmg
	 5CPxDL4QHkO2ahCozvPgeqqtUY8RgCI3Owp07S7p77JGySaosc3e/FrJQe3uzN4kEe
	 875Ab3YKH/qxtksHw2ndsUp5beVwoysMr37HWsqZD4ilQEo3SSATQ7TsteRg8ugG/l
	 J3i6HiOqyWZtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08E88D2D0EB;
	Wed, 27 Mar 2024 22:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/6] bench: fast in-kernel triggering benchmarks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171157743303.7147.9524380873313435641.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 22:10:33 +0000
References: <20240326162151.3981687-1-andrii@kernel.org>
In-Reply-To: <20240326162151.3981687-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 26 Mar 2024 09:21:45 -0700 you wrote:
> Remove "legacy" triggering benchmarks which rely on syscalls (and thus syscall
> overhead is a noticeable part of benchmark, unfortunately). Replace them with
> faster versions that rely on triggering BPF programs in-kernel through another
> simple "driver" BPF program. See patch #2 with comparison results.
> 
> raw_tp/tp/fmodret benchmarks required adding a simple kfunc in kernel to be
> able to trigger a simple tracepoint from BPF program (plus it is also allowed
> to be replaced by fmod_ret programs). This limits raw_tp/tp/fmodret benchmarks
> to new kernels only, but it keeps bench tool itself very portable and most of
> other benchmarks will still work on wide variety of kernels without the need
> to worry about building and deploying custom kernel module. See patches #5
> and #6 for details.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/6] selftests/bpf: rename and clean up userspace-triggered benchmarks
    https://git.kernel.org/bpf/bpf-next/c/8f54386ea7ec
  - [v2,bpf-next,2/6] selftests/bpf: add batched, mostly in-kernel BPF triggering benchmarks
    https://git.kernel.org/bpf/bpf-next/c/e6c97e34ad7e
  - [v2,bpf-next,3/6] selftests/bpf: remove syscall-driven benchs, keep syscall-count only
    https://git.kernel.org/bpf/bpf-next/c/850860ee6712
  - [v2,bpf-next,4/6] selftests/bpf: lazy-load trigger bench BPF programs
    https://git.kernel.org/bpf/bpf-next/c/f328a70ab28b
  - [v2,bpf-next,5/6] bpf: add bpf_modify_return_test_tp() kfunc triggering tracepoint
    https://git.kernel.org/bpf/bpf-next/c/c55e25089eba
  - [v2,bpf-next,6/6] selftests/bpf: add batched tp/raw_tp/fmodret tests
    https://git.kernel.org/bpf/bpf-next/c/b1d5f62f825d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


