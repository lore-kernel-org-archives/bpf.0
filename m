Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4383B2FF8
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299262; cv=none; b=ac7/O0sI4/ZOJ0FUcaA/jfS/rIunowdXBBEV/1qKaIH2zQKIUUPs9PQEVB0Sl3sZowxiCVRH7ARjP90vq2uZqt8gKU22DCX2z9BEdqKawLJTgwIEXhIMJ/qh6hQ29dBRZL6DxqCR2haeqsPrfs0PFd0GyfQ7M3Y8dmMJ5wgpve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299262; c=relaxed/simple;
	bh=hCspbKqKSZjKPwMpVzQpSC6ZnLYE2aCoTheh1QaYkYs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NSpDoneqPs6i9in0qabBszddb7MWJJPyE3MqSPaelb96IKocO6/cOIitzSwzx3BMnCDzhKt0EykYeF/Mx2XaCmxaNgVuZAVg7b2lhBG8JIym7fu736azaZ70KdwehabzkjUrHSNk+YY1RP8kES2QDr9gpFJlfcQSMiYrp6FcBTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyTQGMmV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyTQGMmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F6A1F000E9;
	Fri, 21 Aug 2026 08:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787299261;
	bh=DntpjWlbcBO/SNDu4QcamLYkbHQiWj0IHtruqekUdUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nyTQGMmVTFpuHW1ic0K7VcexOLlsgevEYqa2G9h+2OV/VqPdFNL8A+nr3IQvz2BDW
	 SLWqZD7YEg+zdGz+/YueU1R1dGCHZciGTcqgojDrilVJ0N8pyOfYiQPRsVEsc+sz0T
	 tzFK8hIRFmFcV5OfBtOW91XkrDOKBt/RlWesIl0llYI8XcnQ6+tMK6PIIqRXeps/r0
	 0ZFpO/ADFsNDzv23vMIhdTNaaV318e2FAtfDPbpxCYhlbsg6zUXLtqRbE5+un7lfBt
	 HWepbQPEtrbhYoAEiu8JwiBTZKJfUESfgitAd6nNGUtWsxKtdfxW2DqCP8yB/D6Efu
	 Yrck78xuiqlKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4F380820D;
	Fri, 21 Aug 2026 08:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] Simplify min()/max(),
 contains() and normalize() cnum implementation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178729921119.702555.109730715293541153.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 08:00:11 +0000
References: <20260730102129.15209-1-vldsampaio@pm.me>
In-Reply-To: <20260730102129.15209-1-vldsampaio@pm.me>
To: Vinicius Sampaio <vldsampaio@pm.me>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Thu, 30 Jul 2026 10:21:11 +0000 you wrote:
> This patches simplifies some functions of the cnum implementation:
> 
> - smin()/smax()
> - contains()
> - normalize()
> 
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] bpf: Simplify cnum contains() by removing redundant branches
    https://git.kernel.org/bpf/bpf-next/c/4e3fb5bba680
  - [bpf-next,v4,2/3] bpf: Simplify cnum normalize() by dropping unnecessary comparisons
    https://git.kernel.org/bpf/bpf-next/c/b601a4ecbe67
  - [bpf-next,v4,3/3] bpf: Avoid redundant min()/max() in cnum signed bounds
    https://git.kernel.org/bpf/bpf-next/c/705249119d94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


