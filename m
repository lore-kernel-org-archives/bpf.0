Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA334A76A
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776378640; cv=none; b=PTQq6fHElj0SzmS7+bH39dsiqQbn433u4Q+eyIVrqquIwt1GjqfFJRJQ6vPRyMihubyDYRNVex2zretlLoyffHxj9zAZO7eaSX1Sn4J5QgDzTSwRXe3x8ObGdxHEkTMoIwJlwKnkj/d1Ko6TBPXBqOxfN//q37u1qg7pqc1m1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776378640; c=relaxed/simple;
	bh=KWs8jQ5kcYQ7dOj6V4vUanDrkRj752m+eRXl1RZFuQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WjU4YTwVTHZHg/kTFzJdaDxN17SQo2K3aBZr6BC/nYAL/8woFBFYtUhnprdWq+xshXSx9KM+FO1V+v0GK/YHORmv9Xa2wzXmW24NvR+KZYCzHWzaykG8NrVDxl4xUzaGY4fmRRo2dm7E3etKuQQ70b6SlgcZAB2WGkRsy54x9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVtJh+E5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVtJh+E5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CBDC2BCAF;
	Thu, 16 Apr 2026 22:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776378640;
	bh=KWs8jQ5kcYQ7dOj6V4vUanDrkRj752m+eRXl1RZFuQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uVtJh+E5oy3FicfihYQWqJfO0NDlnSMED2LwG1CVOdpP1NRoaO7QTGLsbcYtews+f
	 0UyvkJKXhXmedb83yIlhOiQI77zihnZPTV0MYhoabHizzuqybvwAHmC8ydjS5GZJlp
	 GTmtZj0dkK3LmAOYAGxwIT9YfN3YvwLr6mTY1QB2WZ8yGBT/s1TMFtLSnyTTTlgCeR
	 i39vr1UK39n06DXtqdbQPEU6Xk3+oeGqQ8WhjBuLRSW0IouPAlm/YTHWI5vS6w5trQ
	 zrhHB8RmSDj51MHTOMjTOKaVsSdHc8JNtoCKlIE5JmR27jEJlX1Vw+0jtEyxgbaUdL
	 nDntVQRQLoZnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E03380AA76;
	Thu, 16 Apr 2026 22:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: Fix NULL deref when storing scalar into
 kptr slot
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177637860830.3422196.3118668540928509911.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 22:30:08 +0000
References: <20260416-kptr_crash-v1-0-5589356584b4@meta.com>
In-Reply-To: <20260416-kptr_crash-v1-0-5589356584b4@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, yatsenko@meta.com, clhiker365@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 16 Apr 2026 11:08:06 -0700 you wrote:
> map_kptr_match_type() accesses reg->btf before confirming the register
> is PTR_TO_BTF_ID. A scalar store into a kptr slot has no btf, causing
> a NULL pointer dereference. Guard base_type() first.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
> Mykyta Yatsenko (2):
>       bpf: Fix NULL deref in map_kptr_match_type for scalar regs
>       selftests/bpf: Reject scalar store into kptr slot
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Fix NULL deref in map_kptr_match_type for scalar regs
    https://git.kernel.org/bpf/bpf/c/4d0a375887ab
  - [bpf-next,2/2] selftests/bpf: Reject scalar store into kptr slot
    https://git.kernel.org/bpf/bpf/c/fcd11ff8bd0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


