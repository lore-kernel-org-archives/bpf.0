Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F7B44F57B
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791726017; cv=none; b=p0+FBo58xmkBr3iexaKtmO/Sm00sqiXT3TOemVcMF5u7tNCDqtnyiI0M59rq6cUE80EYUc7YrnpsCdQwqfszGiCRHNxFir3Hn8Ovh9vHtrSg4cKl5nnbZmvvUDUFwwGeDe+sAyHIV/Dk9HrifKR2SlzOa9AuhP4MxAFZHQ/STNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791726017; c=relaxed/simple;
	bh=aBsgPh70DmyaNuov8vrtJ6tCTwDT1cTAi3qWN9XTjFI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jrYOncmapEHVboJn2vY82YU1V1qpT4lqge3hMdA35JEZbM39iRhjXPuMFO7dOc0NPuTFkv7Vp6lasIkRNc5z4OeMlEANetwfYhAdDTC50v5XqJeQG5idhDo/4l57nEj7bNqGjCgCKChMv8PYlMEq/fbOWHYCDLf5dmAoe7zKTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiGyXw8a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiGyXw8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BAC1F0089E;
	Sun, 11 Oct 2026 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791726014;
	bh=2oGOihFMlH14ZPOxpdZxrhS1kLVJsNn6JIB838S21Ys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eiGyXw8addIgPocbNupwcasKriESzdKqLi8+FsNiK0vCg4EbY2axe+5UzxM/6qO78
	 JsKWUQI2kG1cZDpHVAvKf+OauR6h7gCaVhiQ474i0r+0gl8m9+F0MZPQGuNhuAcUzM
	 6cNu31PoMpoDrSjKLRGy/wdw1xMdQyPniw4tEZfpH5Bn2KFwcNuLXL4GHWuX6fC0z2
	 dTNBhvYwpImUcIVJ8yE8tlN7FpKnJNNxUIm7AVWF9UgZLqIDtIG4m9R64kEwEooby5
	 0HHlVMlcRZeYwH+913JYKQ3TOv4Q4b/m9JB6bqaJ8d0l4Bz9Nn7JSKaTl2OuKGvcpt
	 Oi2d9/raahXog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 770EB3811966;
	Sun, 11 Oct 2026 13:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] MAINTAINERS: Add myself as co-maintainer of riscv bpf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179172601303.2055679.524571324990468455.git-patchwork-notify@kernel.org>
Date: Sun, 11 Oct 2026 13:40:13 +0000
References: <20260930104659.1919027-1-pulehui@huaweicloud.com>
In-Reply-To: <20260930104659.1919027-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bjorn@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, pjw@kernel.org, palmer@dabbelt.com,
 luke.r.nels@gmail.com, xi.wang@gmail.com, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, pulehui@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 30 Sep 2026 10:46:59 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Over the years, I have been actively involved in the development and
> have proactively taken on maintenance responsibilities for the RV64 JIT,
> covering the related bpf core, riscv architecture, and selftests/CI
> infrastructure. With the continuous growth of riscv bpf features and
> testing workload, adding a co-maintainer helps share the review burden
> and ensure timely patch handling.
> 
> [...]

Here is the summary with links:
  - [bpf] MAINTAINERS: Add myself as co-maintainer of riscv bpf
    https://git.kernel.org/bpf/bpf-next/c/10aaef818b15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


