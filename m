Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447018;
	b=JReky0PDn0SFO3xva97SJLMvKpvDq95vFZYfq94GVqLCkid9qYT2ZQu/Obulvhw8USzS
	 MQcTIjPt9LRG+V9CeQXW4ic+r1Y9yjIGAFKQmuvNrxjxAs72f6ZY7mJCdpe4UKNfQY/Ul
	 jLJ8fUpcAJOEPnMOOzJ6js8Y9Z39DDX3tgEAcbAx/CQTTx7c/FhtnwoI6534pOXnraJVj
	 I7kUStBgc1X7ALA8osiR01CSr1rfPxO4SrS8QufPmhO8ocY7+zG3RSD9WGvyj4BS+Ly6z
	 Bv5rQdhljV9PlajkaZ9kwd+3nPmAc4OlNLairfcbKbw+RiLE6WSJu7l99GboGrJ6DDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447018;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Qid/G5a1pqWzkS2K4IyEOhP7Lo104ZjziYXhulVxCCI=;
	b=nR2j3ngH+23oSZkKRAHakFF6+rO40HnhbrbEBZm8mRChnXoh9CGal7Ep5arXp9/bnfbV
	 VcwzzaK5C7rGVqd9huL/WPaz00zODsHHQvPmFEJ/isqaXA4QlI77hPv60SMhhVT/T7NTF
	 TRZtAEeV35cDU6VA6UlzI0B1wHLhb8CvGVHWlliYSO6nkFdcFlAjgaLiwtipvQzXdL10E
	 eKYmHLIGWOACY0kVLzUrZ5TSDapFllV0wmyt2La9rTLd4uBYpyUD5Mf1CDhng7B1ltiT8
	 qDs5tpMUm6lazQyW9DrwcSZw9dLrGNnQOdVhJPCH8gmLKuIwYntskkkkdFSqK1yFRNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXYkuGID;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118D60A3820;
	Thu, 12 Nov 2026 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXYkuGID
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B90B1F00A08;
	Thu, 12 Nov 2026 01:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447018;
	bh=Qid/G5a1pqWzkS2K4IyEOhP7Lo104ZjziYXhulVxCCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YXYkuGIDhlNKB3oGQyLJmFa5WZdN+DG2ZQatVy34HJzHnTI/MY+/84bDjZYzJomb2
	 Dbe3ePo5dyV0z4j/Thj9e57o2iCXIExqEySoZtK6bjY992ewSiu47Aomn0yT7E6QLw
	 I0yj6/ywef5wkZ77PVHWILsSiLqdUJbk7NBVc1vYjrTlodDSgze7EcN74JzkKMup1M
	 6dIo8ddaWWzaEJmIyFW8NxgfIKoXTB8Hu6q+CSyFy1IMxP8d9FD9TNDpSRjZG8TI1+
	 dLMa9+eHJsDq7Ia1LHdE+qwIYtsNFTpz4IPu/8qt6bKe69S4aQEEKPf4Z48T8idrTJ
	 HS5YjKHE6Fn+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2105F391AFCF;
	Thu, 12 Nov 2026 01:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] net/sched: let actions drop their per CPU
 memory
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179444701667.1753823.7328231929071726614.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 01:30:16 +0000
References: <20261109124618.933149-1-acassen@corp.free.fr>
In-Reply-To: <20261109124618.933149-1-acassen@corp.free.fr>
To: Alexandre Cassen <acassen@corp.free.fr>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vladimir.oltean@nxp.com, idosch@nvidia.com, daniel@iogearbox.net,
 martin.lau@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, netdev@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 13:46:11 +0100 you wrote:
> This series lets actions drop their per CPU stats and lets skip_sw
> tunnel_key actions drop their dst cache:
> 
> - skbedit, police, mpls and sample honor TCA_ACT_FLAGS_NO_PERCPU_STATS.
> - bpf, ife and skbmod honor it too. All actions now do.
> - Action init sees the offload flags of the filter. A skip_sw filter
>   alone now satisfies the skbedit queue_mapping check.
> - tunnel_key skips the dst cache for skip_sw actions.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] net/sched: honor TCA_ACT_FLAGS_NO_PERCPU_STATS in more actions
    https://git.kernel.org/netdev/net-next/c/a4c9d4347525
  - [net-next,v3,2/4] net/sched: honor TCA_ACT_FLAGS_NO_PERCPU_STATS in bpf, ife and skbmod
    https://git.kernel.org/netdev/net-next/c/72760229298c
  - [net-next,v3,3/4] net/sched: act_api: pass the filter offload flags to action init
    https://git.kernel.org/netdev/net-next/c/7744652f1063
  - [net-next,v3,4/4] net/sched: act_tunnel_key: skip dst cache for skip_sw actions
    https://git.kernel.org/netdev/net-next/c/fc40a98e5be9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


