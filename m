Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8427703;
	Sun, 18 Oct 2026 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792363808; cv=none; b=bXsXgsTwyo2V0JpRyfSJ+iEMt+ytcoUNbd/g2yx4ZeA2Tv09FocZKLalVe3jg/6+4mp+nJvyoKi189+3yI7xgJkctpDHZv1mrR/teY63/0QFdy5sSGp+vcO052nqNvhtRKvDMl9JHUlfk2+A7HnthIcfP4h7snqmRFIKinCvyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792363808; c=relaxed/simple;
	bh=i5rwtphQYO7mhl4M+EOeMudB0nDgFKO4LFZX2esHHbo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X+BYzTV42l3gHitpzZs1RShWxyLm4ECljTlAqJxp3MX/1RH5o/skT//s1RH/XAaMYZpgRKP39z06pgwzkWJMQh9LFID/GZ9zq09QcYlgPVWQBaUeWm/1qEZXF0QXnqc7ghGNvk1LHQ6hOIyMZz+dgnNMStXaYLx9Wh+vEUAaCQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ksk5ufrr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ksk5ufrr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CB41F000C4;
	Sun, 18 Oct 2026 22:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792363807;
	bh=sfOq/BD1uOhxqBFKEcsGT6dRqMELQnKcVnXIhK35zG0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ksk5ufrrDct3/J/gpiK+9aiX3Bf66v67/vMiGjyaSMjXlauXV2frOlz1Hkhhq4pmr
	 Jd7CUb2War5oVdnCyHtLT1uyJebVisDfEziPfmL/wVINpd7oIwR2asuXTS0tDJfQrX
	 BjrlxnLGMZwavYaVdf6m6Wzm9tvrodmMR/f8Nc07No7Dl1Yuh0PIIz35zWxagPp5OY
	 YVFSGyWAtUfp2MbK+Pdb8SEhJpLIOFzVQ2dbGjVkTqsOy3R88eEzdx76N0uRUYh2gC
	 mZIo7eiKsybFp6BVmHwmPx85zxtp5CwjcD3Ym3AP+AMeXafUpnQOL1zQZSHS75MXFp
	 oXmX9KL3OHktA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 775413811977;
	Sun, 18 Oct 2026 22:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] selftests/bpf: Fix selftests fails with
 clang23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179236380628.1845637.4163386381881195257.git-patchwork-notify@kernel.org>
Date: Sun, 18 Oct 2026 22:50:06 +0000
References: <20261018005348.2195130-1-kafai.wan@linux.dev>
In-Reply-To: <20261018005348.2195130-1-kafai.wan@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, leon.hwang@linux.dev, donggeunyoo.kernel@gmail.com,
 menglong8.dong@gmail.com, yatsenko@meta.com, jiangfeng@kylinos.cn,
 vineet.gupta@linux.dev, puranjay@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 18 Oct 2026 08:53:44 +0800 you wrote:
> Building with clang/LLVM 23 breaks several selftests. Patches #1 to #4 fix
> those failures.
> 
> Changes in v3:
>  - Remove the patch already applied.
> 
> Changes in v2:
>  - https://lore.kernel.org/bpf/20261014113043.640435-1-kafai.wan@linux.dev/
>  - Collect the selftest fixes from the two patches in v1
>    patches: #1, #5, #6 and #7.
>  - Add three new patches: #2, #3 and #4.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] bpf: Determine freplace staticness from BTF linkage
    https://git.kernel.org/bpf/bpf-next/c/0ceb2f21d3e0
  - [bpf-next,v3,2/4] selftests/bpf: Fix stack_arg precision backtracking log expectation
    https://git.kernel.org/bpf/bpf-next/c/8d637d4c62c1
  - [bpf-next,v3,3/4] selftests/bpf: Fix stack arg pruning test JOIN log expectation
    https://git.kernel.org/bpf/bpf-next/c/8342d47ad791
  - [bpf-next,v3,4/4] selftests/bpf: Use _exit() in uprobe_multi_test clone-ed child
    https://git.kernel.org/bpf/bpf-next/c/ce42271dc517

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


