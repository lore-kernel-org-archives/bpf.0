Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D82D6407;
	Wed, 22 Apr 2026 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776893444; cv=none; b=frLBzY89esM5t9nYhvnEBSgFyf1xZ1XwaicaVBtVUt7by+Fqc2t62XH2JOVyEz8SlwJEOQotjtoaayZxKHvyz5KZ5Kgm4/CcQ3JPoKY1cXgqVFCoOlOWd8PlMS2PehILdgGOeJm3t08lDLqUt66scztSTX+pXkr6BYN0Q3kJSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776893444; c=relaxed/simple;
	bh=Itkh848k0Dmsyn5wght7EMx2QMJVBYyDBSXSJueFdj0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lg18mtvo5CMg7BA1NzROLfxs/J1Wqu4F+KpLd0ak173tS4azjt/4oayd+nWhPs+48nsesHGNmyPVREUfpTdX4wAzlZIlUQIWByK1v/7swYAorxR9tQdpS2eGOtoB2fSN0CI/taF/31U8V/EUIWTsswXy5GMWAOU6Bg0qJc/OXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFMz14XH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFMz14XH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A60C2BCB6;
	Wed, 22 Apr 2026 21:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776893443;
	bh=Itkh848k0Dmsyn5wght7EMx2QMJVBYyDBSXSJueFdj0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hFMz14XHTxXW1Z+xY0s0cxkVxWF3H/mgIgfE0tMCclHTQ4Wm9uF+phJXn0KCvYRnG
	 /7/o+xSM3msPD//VF5H7DeFH2G0AJ1i7s2aHHltJkAheaOG997gkDnA6rQe/F8g7fV
	 BMypb5NTyMs+iZZRkGhOYynJQlOOIo4+LXax597fM/TAqOr7wjJVWLfIlh1rvgjYnF
	 BhV3MFBD7r1mY5hXxMPfhXhpZPpZzzc+kFBK7JxdRjjuNzzuAuG+TzTiBSUDMvPXyz
	 5v/Pkkr6710glr6pIAH8TGX7ZQgqwW+rewOoOM1mDOZOrZbAO5eLbpWqjbFgcPdwvS
	 icPih0bzy73hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E903809A85;
	Wed, 22 Apr 2026 21:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf/selftests: fix uprobe_multi usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177689340581.4044244.17385542984883270612.git-patchwork-notify@kernel.org>
Date: Wed, 22 Apr 2026 21:30:05 +0000
References: <20260421-uprobe_multi_usage-v1-1-4c51675955e6@bootlin.com>
In-Reply-To: <20260421-uprobe_multi_usage-v1-1-4c51675955e6@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 ebpf@linuxfoundation.org, bastien.curutchet@bootlin.com,
 thomas.petazzoni@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue, 21 Apr 2026 16:33:29 +0200 you wrote:
> uprobe_multi usage message not in sync with the list of subtests it
> actually supports.
> 
> Add the missing subtests in the help message.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf/selftests: fix uprobe_multi usage
    https://git.kernel.org/bpf/bpf-next/c/7f843c0584f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


