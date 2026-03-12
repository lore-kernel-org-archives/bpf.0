Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D9347510;
	Thu, 12 Mar 2026 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773277818; cv=none; b=qTZkwoUNlPVLSEneAjp4a1/hjQPfec+e9SJBr9cwYSNVbrIQx4QMcwIrI29DZtJ+Bv6Ols8YKNnmkqaWt6q8F1Q/wdGMXeggBfUyulrXTqHQoOulfIsiPWzEuTxWReRLtMQaIpxB+s56di1Wif67gCTess+64SnK5890aaaCAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773277818; c=relaxed/simple;
	bh=TKeJT/xjc5Pdb24yNwte/PfYRiwvbPDzgq9rKudiD1o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ghVxPdzkJsbC3DN8WePAiMffXxIMzNiCYaAbCA0wE49nGs8p5OdQHlRFmwxLl/ZHJWpeZXj+WhikR3gDm3fBoXJilLUgwr6oeCM9zWK0Kfb3mLakizRljPKNCgMrgv8Dc5EflfedAepnrOhfJV3b4e7W5SBSHV3hddwVg66wtQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aasaijiz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aasaijiz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B69BC19421;
	Thu, 12 Mar 2026 01:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773277818;
	bh=TKeJT/xjc5Pdb24yNwte/PfYRiwvbPDzgq9rKudiD1o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aasaijizLxUCax4qDJUxQG9vhHuby2UQJLj42UMGam6gHMDGV015yhzw32NPrGxZQ
	 Mirsyq3wIM7PXGJQ8DoT82JDKtjMke4QjHWgWUyhyRfPCAdrTIbKyjyJoFp/oRxDga
	 5jGAKlrKsECnK5Em1rYUabVs+9BZtkT+6gpTwqigQRT4c5pJSLRjTJF+M6GKHXmrJb
	 vxfL/B4/UNMTDc5rDBmdoOyKe1OvHGNKyPXuIBGfNr1lVXNc1VxMn0DtqNM5jI1T7S
	 vtOy3wBjNNs8Pioh8Pk3GG+IuGHVjlL3zIhzLVjsV4D/7FHYROGATyOpGiKUgRJvDP
	 B5pH7WjFVePyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE523808200;
	Thu, 12 Mar 2026 01:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/4] {net,bpf}: nd_tbl fixes for when
 ipv6.disable=1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177327781404.3893274.18137587721158211759.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 01:10:14 +0000
References: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
In-Reply-To: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 toke@redhat.com, dsahern@kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 liuhangbin@gmail.com, fmancera@suse.de, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 07 Mar 2026 17:50:52 -0300 you wrote:
> Hi,
> 
> Please consider merging these four patches to fix three crashes that were
> found after this report:
> 
> https://lore.kernel.org/all/CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com
> 
> [...]

Here is the summary with links:
  - [net,v4,1/4] ipv6: move the disable_ipv6_mod knob to core code
    https://git.kernel.org/netdev/net/c/94a4b1f95998
  - [net,v4,2/4] net: bonding: Fix nd_tbl NULL dereference when IPv6 is disabled
    https://git.kernel.org/netdev/net/c/30021e969d48
  - [net,v4,3/4] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference when IPv6 is disabled
    https://git.kernel.org/netdev/net/c/dcb4e2231469
  - [net,v4,4/4] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference when IPv6 is disabled
    https://git.kernel.org/netdev/net/c/d56b5d163458

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


