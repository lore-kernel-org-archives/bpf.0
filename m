Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED43016E0;
	Sat, 27 Jun 2026 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600642; cv=none; b=KHfUqQAHsBkfDUu+YfaPKcIjOUPL9UQlygNWwPQqlit4kw8LZzSOSLzNAsMMxgn1/Pp+oxJW1traCg71y+bras4lPtd/hBcyY6gEVz5x2puUOYJxIWkrqJbL05v1R00kJzCSd5EEAqcupQoYIPZ9pq9X5hyQgmdwI7qSn5fuuqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600642; c=relaxed/simple;
	bh=dJ7pXABRGOScU6m4JSi0LnBB2aXeCP2ysvxhvfBOh4M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ryedgdm/u6N6px567TudISzt8hMN78t/Udh+ZmAjZg8CTzwl8EJ+WwtI8EYsXg5njCBt/fSw6Bbw71nKIU0k8qBkoR/j19XciusXx5ewrEyYYnxEtuOuLgM/BlZNaPrpZp/mIpJsD9oRBhsLXthl/+xzkyEbP+JKksFxP/5Hk1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8mZdO38; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8mZdO38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1538B1F000E9;
	Sat, 27 Jun 2026 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782600641;
	bh=KK1xQmf+wVy5ZvgMHkZv2n76zynSmPXrIRD2VdxwkJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e8mZdO38R36kEk4ixQxV02UtHkI/bO/JKZpF8prhj0Uf3ahkON7dMN8yJypr+mxPc
	 AzZCor7nxsgwwzkuge5w8PPYFZqD6UbyaNG2B+JY1CyNo7p8HuVhYXSPN2Y5npo0FM
	 mzPbnJK6tN9j9FYs8JQj10PvP2d4Qp7Pu4zPZM0OL9gld5wNn1Z2eNwN1+IfIEewqa
	 cQpWjzhUi/RH3mobLGhKAHC9evQ6YfYR2yR2YmPf11m5Pp3MeUL/2FPDijtWB8ZoZ5
	 y6x+oDn/CuhGkMt3sPX5D7op2+9nqLE/c7alJm+W9Kd0xPpupb5rn/l5Uya2HM4BD1
	 CUWJ08s41GZ1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198AD3938452;
	Sat, 27 Jun 2026 22:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: enetc: check the number of BDs needed for
 xdp_frame
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178260062679.1451849.6906135488386878812.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 22:50:26 +0000
References: <20260626073244.2168214-1-wei.fang@oss.nxp.com>
In-Reply-To: <20260626073244.2168214-1-wei.fang@oss.nxp.com>
To: Wei Fang (OSS) <wei.fang@oss.nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, wei.fang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Jun 2026 15:32:44 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The size of xdp_redirect_arr array is ENETC_MAX_SKB_FRAGS. However, the
> number of fragments contained in xdp_frame may be greater than or equal
> to ENETC_MAX_SKB_FRAGS, which will cause the access to xdp_redirect_arr
> to be out of bounds.
> 
> [...]

Here is the summary with links:
  - [net] net: enetc: check the number of BDs needed for xdp_frame
    https://git.kernel.org/netdev/net/c/555c5475e787

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


