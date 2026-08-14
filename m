Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39853CFF65
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725057; cv=none; b=GW3H4sHRX9xPyZUqCLxEyAY17fWzMqqYqur96q+qhV4WFOnPC4mlfwHwzeu+iHwq0GQk2DwyPG3eyATwcVaYxMIrC5UIc3s2KQ8+oT0mMdXjuzAAf2zgZ5NWQSTm13QT64G/aE6TA44ein76YUiHzLcdbC/WjjLEijnmLa4lPsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725057; c=relaxed/simple;
	bh=IrUMZh8x0n+usfAexiOjhuefD7U1caxd0I9gy2ya3c8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FPjfFh1BvYZpwmzB9zCo85sQSDgyl2UK0RP4i9YTCPenJu/L4nufbGRYGIBDlAHGHBXLVhf64tNkheu0jeRgRuJAbotMvdWjZiLlKgJXccu3dw9tYKNiVKg5pSErXdeWHOuxv6NO2A3tI8pJG+1jpP1eVE6PAeSag4OfU7VKxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsEDkl6i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsEDkl6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9CA1F00A3A;
	Fri, 14 Aug 2026 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725056;
	bh=5nMnat7s7Zben4QM4m8vpDasgEc9ECJDz/KqLCwwQHE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gsEDkl6igwgqcj1DVoSsIT0iy1poUGW8w09LWCvmkvra2gFcqHjfs1s6ACvGBNC4D
	 YmLL+3ipM2py88xh4MLI53gpn/Fe1Px18t3gvPD+NGJStNC+5rj1HsJczI3DHXNM5v
	 ryoSgpZ2IfNpkdvSh5xC1r6MXtuOohAkuNsyvajMIq1Jk1gl/ympS3smYpGxv+JOd9
	 RBgnFU1WSMKwCDdgrWF75VssjzciSN/xNLg0qHEBfBBMuuoxsBbqBUY+3A+wWehdey
	 8/PAWkfjBu8Dx4ub8TjpdUlormGcPgMC7sfYoNAuWNa9Jn4kocslR5RhjQWOe7dclo
	 q1GavZ2yCzetw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938493924451;
	Fri, 14 Aug 2026 16:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Use ping_command() for IPv6 pings
 in
 lwt_ip_encap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178672501014.3867910.10216668768556024884.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 16:30:10 +0000
References: <20260813213558.3103179-1-andrii@kernel.org>
In-Reply-To: <20260813213558.3103179-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 13 Aug 2026 14:35:58 -0700 you wrote:
> lwt_ip_encap hardcodes the ping6 binary for its IPv6 pings. iputils
> merged ping6 into ping long ago and distros have started dropping the
> compat symlink -- Arch's iputils 20250605 ships only arping, clockdiff,
> ping and tracepath. There, every lwt_ip_encap subtest fails:
> 
>   check_ping_ok:FAIL:ip netns exec ns-lwt-ip-encap-1-0101330 ping6 -c 1 \
>     -W1 -I veth1 fb04::1 > /dev/null unexpected error: 256 (errno 2)
>   #217/1   lwt_ip_encap_ipv4/egress:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Use ping_command() for IPv6 pings in lwt_ip_encap
    https://git.kernel.org/bpf/bpf-next/c/073574da7a8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


