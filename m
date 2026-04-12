Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EFB363098;
	Sun, 12 Apr 2026 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016853; cv=none; b=g7HDn+tW4cgjrqGwbqbCyYsK/PJOh+x6jTPMAP5yPRga5LNg9L9mdeWDuIqqNrxbfwkxaXsMj5G/MwSFv3UhFLrU3hN+2z/tubfjd9uYCbi2evZ913ebs8EElN9aYfroJoT2L+y9nixnj8+meJtbjAu1r+37ApZpHeGAFC1hto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016853; c=relaxed/simple;
	bh=FwdVfbbOGsqKSJ2PuYf5oEgTP0rXLNLZGxQ71dARoyk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GlKRye3oDozK4SZkQYJ/LAdTcWG/zyWQBZdV4nkHH54kuWBjMbnj+ofbsMdfHZZPJiP6cYNnw+4Ik4q58UYP7E6ETJjG0vHAB+rPCrUMhg2i2YIcRCl+szhs5Bsrkg8r+VAx2dQSoituqFD21F8MaonnxiwgJ9tiNbBP57nUynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWNweUuc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWNweUuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2818C19425;
	Sun, 12 Apr 2026 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776016852;
	bh=FwdVfbbOGsqKSJ2PuYf5oEgTP0rXLNLZGxQ71dARoyk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mWNweUucs0t1RVbrYMRjin9dyaYvvfUW90YmC6kHh9IPagi4MM/+T2Fu2iG0CmWsO
	 CBv8eyhQAISXs8cJ2now8rfRKWsnH2r7cYdsGSqLT/PTFdQG2D4K0kiIPxNS8Fs12j
	 Ay951sfawkSUlAkafeoL4xurkaL06rtQQWrjH0qipCt12q2lMbJwZRhKgNAIwpnSaf
	 WntCIDk0jBPFhIIQgYqdVx//pag8aH6RwRXIC+KnaFEE66fAFZE6IeA+D8QLhbZXmB
	 mlOiTd+R5/hOFKFwpLdgwiYF5KM21xwqETCo0IilrNoeHgOj6xAbfgjIRfIn+/qUTG
	 L8JfBpbWsvqaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CC793809A8C;
	Sun, 12 Apr 2026 18:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netkit: Don't emit scrub attribute for single
 device
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601682504.3359939.2160598201131721875.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:00:25 +0000
References: <20260410072334.548232-1-daniel@iogearbox.net>
In-Reply-To: <20260410072334.548232-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 dw@davidwei.uk, pabeni@redhat.com, razor@blackwall.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 09:23:34 +0200 you wrote:
> When userspace reads a single mode netkit device via RTM_GETLINK,
> it receives IFLA_NETKIT_SCRUB=NETKIT_SCRUB_DEFAULT attribute from
> netkit_fill_info(). If that attribute is echoed back to recreate
> the device, the seen_scrub presence check in netkit_new_link()
> causes creation to fail with -EOPNOTSUPP. Since it has no meaning
> for single devices at this point, just don't dump it.
> 
> [...]

Here is the summary with links:
  - [net-next] netkit: Don't emit scrub attribute for single device mode
    https://git.kernel.org/netdev/net-next/c/e530b484b705

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


