Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763DD3B14D3;
	Thu, 15 Oct 2026 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051207; cv=none; b=ZFVWiy0oBSpLv2CEY2P03oVJe6bzAsazJg/7N6mz69wCDwzzCg1h461BTmPfS8cReNfRLCdRka73dwIfSUb5WeE8Whn4Hq6Py9eEqtVfFGpOyeRfCqqNnd1mF1A99g4aXtzeyweCUvbn8SMiw4h1QmN3KKHGWeexynp/9wBKCfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051207; c=relaxed/simple;
	bh=7PdqvHamE5qLFi+NsFi5iJXbKerKoqZg6e7sn0Ep4bY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P7LnXIGURD3+1YK7MxzW6y/LJrlE1UQ/xo7aqMhiyavt3C//i3DKUxAbYdbRhGSDfSkQrPBmcZvgUFTuGGfA/vMikfiRgSSGASLBDBKsuAZerikKsRkikweJKJwJtRRqyI0c35tO/b0/7L6L3YuIS64JVRq2MD0KpECWKQuHi0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcS8Jq9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcS8Jq9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF011F000C4;
	Thu, 15 Oct 2026 08:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792051206;
	bh=Sqzc6qRT22g84Fna4XRE3SKPfBVSv2OUl7BH2NBKTnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OcS8Jq9Z4uMYdiugg5oj5U2y96FQySHyHhdJSHi2kpqhRimO05QteTDFijD1bucGu
	 HCgAXNdR01OPinclmc0VA3oOqb7ILMToSUsulXv/+G/JBRYkGZXzuoX0B5jGR6Ls6J
	 hsthi7vaPcvH0PVmFIDQ0GGSx1CaHn8FppKpD/VADFwmmXjvthU5mQjyXyAhi3apMR
	 4x9XNDwJLWMzK/o3VcWa3eClgxhb2mxvTg09Lj6QCdmk8AfDbugdzG9oy3p25cdxP6
	 XUqi25auaTQ1ag6Wq3DSOiD2sW1h9R6NqaiuVkFVasw6TXoV9fVciZjxQjOMpjY+MP
	 0Ba0gC8xe9ZSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1503392E9CE;
	Thu, 15 Oct 2026 08:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] tools/include: Add Linux-syscall-note to
 uapi/linux/types.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179205120452.3257574.2106728768170589694.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 08:00:04 +0000
References: <20261014194516.3030362-1-marco.vedovati@crowdstrike.com>
In-Reply-To: <20261014194516.3030362-1-marco.vedovati@crowdstrike.com>
To: Marco Vedovati <marco.vedovati@crowdstrike.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, yonghong.song@linux.dev, gregkh@linuxfoundation.org,
 thomas.weissschuh@linutronix.de, linux-spdx@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-open-source@crowdstrike.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 14 Oct 2026 21:45:16 +0200 you wrote:
> tools/include/uapi/linux/types.h is the only header under
> tools/include/uapi/linux/ whose SPDX identifier lacks the
> Linux-syscall-note exception.
> 
> The file was originally added as
> tools/testing/selftests/bpf/include/uapi/linux/types.h by
> commit 0a5539f66133 ("bpf: Provide a linux/types.h override for bpf
> selftests.") without any license header. Then
> commit 579f1d926c66 ("selftests/bpf: fix broken build due to types.h")
> added type definitions copied from include/uapi/linux/types.h, which
> is licensed under GPL-2.0 WITH Linux-syscall-note.
> 
> [...]

Here is the summary with links:
  - [bpf-next] tools/include: Add Linux-syscall-note to uapi/linux/types.h
    https://git.kernel.org/bpf/bpf-next/c/f5bffe9f098f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


