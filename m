Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2217E1A6826;
	Thu,  5 Mar 2026 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673007; cv=none; b=qQKve3bAdYDddHeaSd3wDFhEI7ICWTkOIsT01MDpwnJxjXn6P031ANf7Oy1T3F60wWBqtAzaDiK8IiwnEY6WxfMYMcodfiU7NBYWPyh3TlPeRYln7HpMqehuHVds4OvT9KPuQnYS/s4ZGu6OTl1cnDZzwHaZjHIYQZOkEJq3HiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673007; c=relaxed/simple;
	bh=4Qo7jvBU5fJ3BLp86Ae77NL3X3nvsbZjZ+yAMfjk7Eg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oPL3zPb5hX8drv6oUNCNwbqofo0I0WkFo0jlxgcxRJFRxaHRMPy5QDoZOEiF1sFdcthyMIWGGELNl7gSt8jHaYbbfsknxJPZoORSbfSVPKXMGcVSADrxlnt1mZmHIos3lULvZQlMlzw2xgE6Xpxf/GLbtng/1kyeM0qrXzVF/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSMpMrk+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSMpMrk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A336AC4CEF7;
	Thu,  5 Mar 2026 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772673006;
	bh=4Qo7jvBU5fJ3BLp86Ae77NL3X3nvsbZjZ+yAMfjk7Eg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OSMpMrk+IegZGQYfjaxyOnMjTpd3+yhM3KwZQ9nKw0RWAuOfyXVQuRKP87QKJePI2
	 vmeulQmG4pEhcah2Z0nWUbQiuNytuliXRcVN8FCR2geLxzmoU1sr6l5jPfNv32fk+h
	 NoAmDh6Gyl6otcWLb3tqC2upPZtB6saN6g3E3z3NvUnmxzIiPRghC/jqNtyD9Kz1mJ
	 Hpf5PsRghs9gA6zzaOXhOaDXDpX7dIRfMhuB3XJynhbORksb8KGfUYJkLkflXi9oMZ
	 L2KH8G4CXPxvGyaNz1BFRnnqDp72IHxipsToTs84LVrDrebqPsoWaFr+64N94yHXWw
	 sQjsmN0spS8Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEAD3808200;
	Thu,  5 Mar 2026 01:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 bpf-next 0/2] Fix the null pointer dereference issue
 in
 bpf_lwt_xmit_push_encap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267300705.2465987.7557394320965019773.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 01:10:07 +0000
References: <20260304094429.168521-1-yangfeng59949@163.com>
In-Reply-To: <20260304094429.168521-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, posk@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  4 Mar 2026 17:44:27 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
> 
> Changes in v10:
> - Optimization patch. Thanks, Martin KaFai Lau.
> - Link to v9: https://lore.kernel.org/all/20260303074423.172680-1-yangfeng59949@163.com/
> Changes in v9:
> - Use dst_hold() and skb_dst_set().
>   !skb_dst skip.
>   Move all changes into the IS_ENABLED(CONFIG_IPV6).
>   Use #if IS_ENABLED(CONFIG_IPV6); otherwise, a compilation error will occur when ipv6 is not enabled.
>   Thanks, Martin KaFai Lau.
> - Link to v8: https://lore.kernel.org/all/20260227082133.96951-1-yangfeng59949@163.com/
> Changes in v8:
> - set ret to an error code before goto out.
> - Link to v7: https://lore.kernel.org/all/20260226095156.117996-1-yangfeng59949@163.com/
> Changes in v7:
> - Use ip6_null_entry to avoid. Thanks, Martin KaFai Lau.
> Changes in v6:
> - Modify the bpf_lwt_xmit_push_encap function and add selftests for it.
>   Thanks, Martin KaFai Lau.
> - Link to v5: https://lore.kernel.org/all/20260210090657.86977-1-yangfeng59949@163.com/
> Changes in v5:
> - Refer to the bpf_lwt_xmit_reroute function to configure the dst parameter.
> - Link to v4: https://lore.kernel.org/all/20260209015111.28144-1-yangfeng59949@163.com/
> Changes in v4:
> - add rcu lock
> - Link to v3: https://lore.kernel.org/all/20260206055113.63476-1-yangfeng59949@163.com/
> Changes in v3:
> - use dst_init
> - Link to v2: https://lore.kernel.org/all/20260205092227.126665-1-yangfeng59949@163.com/
> Changes in v2:
> - Link to v1: https://lore.kernel.org/all/20260127084520.13890-1-luyun_611@163.com/
> 
> [...]

Here is the summary with links:
  - [v10,bpf-next,1/2] bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
    https://git.kernel.org/bpf/bpf-next/c/972787479ee7
  - [v10,bpf-next,2/2] selftests/bpf: Add selftests for the invocation of bpf_lwt_xmit_push_encap
    https://git.kernel.org/bpf/bpf-next/c/e8ae16d65ac6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


