Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00A2F8E84
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 03:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617071; cv=none; b=GPwD9xckkWUtHhu8M6rYu7Rlbtu+uiqSpA9HN/EHudIjC+asJfoqeAbiw1ay9gcJYQOdnURYdV/WaV2g4oomUL0WvNOI5HEdLDIwZQAX2wEDZDbH1GkjKTFcKwSe0nDzqa/RIklDB47hD1KBEqTc5LevxSbE6RyBg1ZCSeokhMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617071; c=relaxed/simple;
	bh=s5v6awWIPELX6QhhFlFGKGNIWNtnnS0mtklI4o0fM+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VJcyeY5vg/QT21WRX47pRb0CS2IWxV0vV8I2NB4yEyzaU6roZZSRVpwx95yKRuoDIoXR+mI+qOAtd6Ci6G2EU0GR5+HPNYjbEHLA2lgitKdmTQi6n6Bv9iYyJd7twzsNRtpd/6HiU68p3Nexdcv3m7lLs2GXUt/v4z5haz5GgBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjIiBTlT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjIiBTlT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146851F000FF;
	Thu, 17 Sep 2026 03:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617070;
	bh=Y/55b/ze4/oBEW2XUcpCXpOsM2Lh4YRbHA0mqN71xSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OjIiBTlTtWQXpYZV8bMOcwMprOSAZSyANHaG/Cg+KlW/mPhfjFz04mRDRMlXsKF0u
	 LjaIOWZ+ApMUrUEiEbBIK/gawpfWS2HDaYkqksgWJ9emjpPTk6eL8OvfqrSxac2HJi
	 mtz03I4mKPVxA6zcxbSRTg/4gvxbvyUPBzxhplaJGUpNIWk5V69dFmcOgWEL2UjqQN
	 4SFSv6v0CJPxyjZ04SE0oWXp1idbvqe5j/Ti7fR/y7eQ55et/vq4NST+m/EJaczj5H
	 VLk8X+Eax1mSy7uVXMTMmI7ZkxzCH0LzR3ToTu68VHlYoRE4PWSUWrLNTgn30ZyjbF
	 Jxg3IlvsVDb1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987D39E961A;
	Thu, 17 Sep 2026 03:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Wait for links to come up in
 lwt_ip_encap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178961700389.3406053.3788671897663360059.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 03:50:03 +0000
References: <20260916232407.764886-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260916232407.764886-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, bastien.curutchet@bootlin.com, ast@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 16 Sep 2026 23:24:07 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> lwt_ip_encap creates three fresh netns with veth pairs across them and
> then immediately pings over IPv6. The peer ends of the first veth pair
> end up with the same ifindex in their respective netns, so linkwatch
> does not treat the carrier-on as urgent and may deliver NETDEV_CHANGE up
> to one second later. Until that happens addrconf considers the link not
> ready: no ff00::/8 multicast route and no link-local address are
> installed, and the neighbour solicitation for the next hop is dropped
> as a no-route packet. The NS retransmit a second later succeeds, but
> ping -W1 has already given up:
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Wait for links to come up in lwt_ip_encap
    https://git.kernel.org/bpf/bpf-next/c/71b75648d1a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


