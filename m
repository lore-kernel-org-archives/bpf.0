Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDFD1A6809;
	Mon,  1 Jun 2026 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275020; cv=none; b=MYG8Gsh4QrXWnH9YR2Z9y/QkGbbJycNkQvomG/AZIZkx2x5n9Xt3TijpPO3/WM1cYJj3qf4DEMcMtJP40UxBKtK89B++Ae7/2Dyu1n6wAHwuc4gVVhe9TmbZ2Rmeke5AKZMI5bNWjyFvkpDlH1y/dsdY/kTYOGdiOEUcwrtC5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275020; c=relaxed/simple;
	bh=o3QZ7joHeCua4ARKd6coQkqkg6DV1TaJdjgtyuCsxi0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ImUfgyPv6eutT7AgyLQ60s9UShxFCpIkye0estc6LQSIgVXuZWLwaYaLXkRxyjBSh1v4nl92jILPKycYPHiJN//9boDqSeKSVRH4yw2MP1ppBA40FD6xuSwZhykwR1D+2Nvct4+X+xvNj8jpiLHXrDkrkhHZ1eVvze5xglxU10w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6/YVLfU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6/YVLfU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE901F00893;
	Mon,  1 Jun 2026 00:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780275019;
	bh=XooSvW1kLwj27xK2ukkkhI5PXD2HrDc0SJ9SBlVJZyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D6/YVLfUg/3sf+CELwWctiMu4GuquOhzhuDgPLoqnmW2ljpEcz78uFt1iKMD3bHC5
	 AxOma0WVCt8SKZ4/sLfiUa7Yp/0GwbiJj8zp5EyzR0BY2rTsyPw2/C6XWHchBnEOHT
	 QwpUYFLASD3mN8h4g3UhEatOGadPx/9HCdTLQ8sB6CsK9QWEG7cJPpEKmkU8cFVMf9
	 Q3fByEJ6LBoNThszB9O14Tes7GpvODCzkZnYXDojkJv2poC7Wx623rGwQ8N9JrCdbI
	 lbELur49fXqMX2pjeczNn8s9Wt518HOuksSnqpjxndfBYkIyvJaStvKcy1rmEl4sRD
	 oVOsSeinXs44Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938FE39302FC;
	Mon,  1 Jun 2026 00:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: MAINTAINERS: Update bpf maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178027502214.3441607.8343308159469006100.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jun 2026 00:50:22 +0000
References: <20260529203909.1222164-1-martin.lau@linux.dev>
In-Reply-To: <20260529203909.1222164-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 29 May 2026 13:39:09 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> I am making a life change and will take a long break
> from my current work, so I will step down from the "M:" responsibility.
> 
> I am currently a "R:" in "BPF [GENERAL]", this part stays unchanged.
> I am folding most of the parts into "BPF [GENERAL]".
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: MAINTAINERS: Update bpf maintainers
    https://git.kernel.org/bpf/bpf-next/c/7c7c42d606ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


