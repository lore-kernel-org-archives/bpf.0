Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575035A4C0
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201634; cv=none; b=d2Gh7Avi5RcWEUFgosiQoqae8ycBskT2v8BhtKxmuPipr2V6fg+wtaqWp5JgLhgf8ymdWSbwN1AHqC5O6nPU1GS9Ud75QUy7+7hlRBgVJbLO/spBGqHcs+j6Z9L7JGm92at34N5nNn2pPIOdcKwvyAP4O9VYChziGBMCW5mLGc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201634; c=relaxed/simple;
	bh=yBbLbc2fCHXx87Iz7QqdPvWseGHO3rw9x/Jzs338+NQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Opm428ghbaDRBoNBqAl6usYkJhzjO/efUUpcAb2eH6a54eXocdElTboup/CrdqM/n3D5R3+2jt1tXU8GjRuDki8wugc6V9DkNAtchdEvOXnNOT3y0WzzidwA8uUjyZztV8OyJ+n8Rr5d/C0GnaldWATXk6QTP+j2cnc5xp9b/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1GkI35/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1GkI35/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D16C4C43394;
	Tue, 12 Mar 2024 00:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710201633;
	bh=yBbLbc2fCHXx87Iz7QqdPvWseGHO3rw9x/Jzs338+NQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z1GkI35/M6Y0QZ23lSW/yM/ClWKHYlb78/8X85SEHOS6npJLKkfXVqWxyVAyegfUZ
	 dTOmEzAspADJhHzBwR2/7lxj1vgb6KJne3e0ZlkSToygZCdhIJr/MxGtWz/qh3lHKh
	 liEbQWPS0RA9IXQgN5BBfWk36fsmewgOJ+QNbs5UrXLiI2k4VsVcl2F/H4TbTrPymc
	 3szwYJaIDlykdRBBPyPBsMyPIaosuXApTykIMi6pG+2DGAiKEW1AAyPi3B0OAQXjkx
	 O+IamvGxyKtwBdnsGszamKYAVpC2QGTg4T/faHe3wguTu4NRXjfDbpnPWDjE82MKkX
	 TuaJYUMiHeBCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7302C395F1;
	Tue, 12 Mar 2024 00:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: move sleepable flag from bpf_prog_aux to
 bpf_prog
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171020163374.16311.12828564126297825012.git-patchwork-notify@kernel.org>
Date: Tue, 12 Mar 2024 00:00:33 +0000
References: <20240309004739.2961431-1-andrii@kernel.org>
In-Reply-To: <20240309004739.2961431-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  8 Mar 2024 16:47:39 -0800 you wrote:
> prog->aux->sleepable is checked very frequently as part of (some) BPF
> program run hot paths. So this extra aux indirection seems wasteful and
> on busy systems might cause unnecessary memory cache misses.
> 
> Let's move sleepable flag into prog itself to eliminate unnecessary
> pointer dereference.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: move sleepable flag from bpf_prog_aux to bpf_prog
    https://git.kernel.org/bpf/bpf-next/c/66c8473135c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


