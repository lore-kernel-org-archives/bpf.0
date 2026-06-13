Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA78391E57;
	Sat, 13 Jun 2026 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781314213; cv=none; b=Z4ne7CP+Ua8tm5zVhlqV+PeuhJPdw92Yv8LiYG5Rq3bUiOWfqabz80TwAV6NeiLl9jHYTtHzjOzD3qWwPea1oXQzY430+4gmTFrS6imb/grXD6f68DGaLp92PtD3jETowdgumuyBdj3Hs9atJITaaTxyW9ftQJPxbN6z3qZvCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781314213; c=relaxed/simple;
	bh=3upDyn5RhcofBT2froWXmIYYJa39rXG8LBPHUpHv3oc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DMcXjiGDVOueAY85U9Fxa8cUnocz8Z51E95ROS433qscukXHF57t1hBR4Erlz53CmwAbwxtjKuHiG401GDXdQfw5WWGg1H+5VnnAFufHMkLvPo4htWJNiPM7CW7IZmRWR1liV7NEpH7Vkr5hQMK1MH3vKPfOZtkYWwHSw+0nudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYp6/NL1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYp6/NL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42811F000E9;
	Sat, 13 Jun 2026 01:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781314211;
	bh=5pcfRNmimPChlCbZjWnbiudfie8PBLs0TM/PI/AZ7NA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TYp6/NL1QCXWddtrd7pYD4KAGRSTgs4BPqNcBpAN6U0ygphNkvxJNX3r7Qdsnzyd2
	 sRMYW+0/KoRRVRaLENCm+mpjKMFoK7mdHF+tBmqmkDCWnutpLwhkWDlpUlGngsMlbu
	 IWx5Ts3NQrA3ibE3npyJZc50UTgK1UHACiGii0AEZBK6ZgTXcqtX5LVNCuKj/UDsOo
	 QyIIZyDB69Uf1KroYrcW+SrkeqBWWjQvIlIfQj/zB62N+aDyMCabVL1di1NXKZJS9j
	 wUIC+hGtdTIKTOHIlFI+mOcBcbuLkbFvQ3LUveu8oGzIJX3WPGlOyvilVAGKkaNanH
	 0GL4MYpGabroA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A3439E9607;
	Sat, 13 Jun 2026 01:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v5 0/2] bpf: Fix generic devmap egress skb sharing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131420839.1324271.17087407155107747116.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:30:08 +0000
References: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 shuah@kernel.org, jiayuan.chen@linux.dev, toke@redhat.com,
 menglong.dong@linux.dev, emil@etsalapatis.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 12 Jun 2026 19:40:30 +0800 you wrote:
> Generic XDP devmap multi redirect can leave cloned skbs sharing packet
> data. When a devmap egress program mutates packet data, another
> destination sharing the same data may observe that mutation.
> 
> Fix this by making cloned skbs private before running the generic devmap
> egress program. The private copy is made in dev_map_generic_redirect()
> so dev_map_bpf_prog_run_skb() can keep returning the XDP action directly.
> 
> [...]

Here is the summary with links:
  - [bpf,v5,1/2] bpf: Run generic devmap egress prog on private skb
    https://git.kernel.org/bpf/bpf-next/c/6001896f0098
  - [bpf,v5,2/2] selftests/bpf: Cover generic devmap egress last-dst rewrite
    https://git.kernel.org/bpf/bpf-next/c/f0eff94d07cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


