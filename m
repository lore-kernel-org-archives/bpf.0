Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7912F39C7;
	Thu, 17 Sep 2026 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618871; cv=none; b=rCLnf8Y9CNF2TvR06cJhauTXSuNFfH7wEyEMsY+6SSr5Lc7HlMvUjhWnf0E8DW4XYAI5vipLgMxNTZs8cCOuoQmLqW2idriiuJJQPFUORStrET7uTMt1v15L3qbtkQ86I8MJlnJ9cGROM1Xl1tFWXl7sVLdiqGku/enhAc+aaME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618871; c=relaxed/simple;
	bh=NITzg/IawPO5gHHiRFo1BKay2jgi60t6YJt2v++F6Cw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l2SmxocxYggoZgxj0+0OfNiv57+ithbfRskKVBSVdqzlXM1drXHfjflcn8L0X5YvpMdRABOUDSey8E8Ns3KsUyxYjxfjJvbmYZlBmngX8aNAs0XoYxFi+tIVSQIYVn9IrrxPAgCINq8HblD7/ODOIBeqX/VMhwlKBIalwWzc3vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mktdNDJg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mktdNDJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172341F000FF;
	Thu, 17 Sep 2026 04:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618870;
	bh=3vJ2qVOabDJ1ajlW7D+ZZ4Nhf4mYDdbeKPbTxttiyio=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mktdNDJg7SqeQbiMsf4Kg6CqdjgBcayRfHXrxn5LivXhXm6Usn0dr0yN+iUod0Pdf
	 Eyue4IBM8ZKJQdybrwe5ayiL8VEBSAvGYZcj0BdA5Z8XZQyIKWAdLBIw82WMhi8L5i
	 53EJ61lZQqdNTGl5Q9KqyG5vx5y6zX0jqrhJM6c8G7ZRrNuaxHjFkuS6jW2pQNVU8i
	 fQnToQ++pxp2YGZR6jjMs/udE3kyuKsRVHmq5Ye24LXlKN3S11JuO7G/ps+fK5tdBK
	 jTcFjj2g2W+EaQAXeiw9YdC6lT0nQmcMAoTUKBYxvtLOPcEXu8dftzPmHENZDlKu7m
	 hCTaK17KSTa2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1976E39E961D;
	Thu, 17 Sep 2026 04:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/1] xsk: use a 32-bit compare in xsk_map_gen_lookup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178961880388.3413236.5976606806799988875.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 04:20:03 +0000
References: <cover.1789056660.git.zhilinz@nebusec.ai>
In-Reply-To: <cover.1789056660.git.zhilinz@nebusec.ai>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 jonathan.lemon@gmail.com, vega@nebusec.ai

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 11 Sep 2026 00:18:23 +0800 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/xdp/xskmap.c. The bug is
> reachable by a root user.
> 
> We've tested it, and it should not affect any other functionality.
> 
> [...]

Here is the summary with links:
  - [bpf,1/1] xsk: use a 32-bit compare in xsk_map_gen_lookup
    https://git.kernel.org/bpf/bpf/c/8d9eae69170e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


