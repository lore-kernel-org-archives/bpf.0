Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D14B2CD3;
	Sat,  5 Sep 2026 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633674; cv=none; b=b/2qf0eXvr18WRT2KaV50Bx9/AXP06Izz6+2xhSPtTvaygTDNtbJUX24AjtahEPQzQIG0uqdKTJTkiqiQ76hvhjfInRjtwFXiiAnbdYrZauVY8Zf0JReSXj9eAYJv+ZIHSk6N6cEHwQ4c0XjKQ2rIO6916405igVt1rkisfigN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633674; c=relaxed/simple;
	bh=ewk5jUFWugtdbZ+RqO3jOlsoysJfgd4ZCb4odm3rda0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VRR7TJ7Jn3iFVTE222F8PIkpLcLi3vmSmqHPHiabHnO1NaLl1FN2Xn60WUqwXK8VoocUuWPBmgMbgudn3E2ypznj1vS7vH8gXSxEZJLIVd+1nF5CVC+Mr3dvtmqm7zxIRWZwWgeVcbdmuTsTmC7wR3dQ1cueb4FT/BEgwIivV6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ephk7wDu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ephk7wDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C5D1F00A3A;
	Sat,  5 Sep 2026 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788633669;
	bh=N9g3nNiuaKLsxniTy4aPz1K40ka5HFK4AVVUy4suEqU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ephk7wDuiXgQm5M+WKCKSEkbQj/oX+s5aHMg0UKwHu4c+/PofrkLqIJyBIingjLyb
	 UTcG9rEDMZwgM5xODwQD9wajDHDzfN26Ov08dAhuzm/u+AhcH1gkDQNkNxyoqGRDct
	 QfHktzyxT54vm7JvK1r+LMhbEajgO9/AZo2QnWSuf2vrahjtFEez/8EFMw+wdDKVVV
	 EY/ANuwV+OefwVFkhUn5dYqe2+tFyDOdzYy4lDYSGr0HA7C174j9loc2Xag/DwLIMB
	 TlTAWujVv29PNsaJqhn7qgnJwod0WmLVhaIK7zPl0JEQDwugejwN8D0zvFntub3J54
	 5G6tTyPhmJobQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A3C3924FED;
	Sat,  5 Sep 2026 18:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/2] Explicit TSO segment count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178863360890.1316297.2694047527811233143.git-patchwork-notify@kernel.org>
Date: Sat, 05 Sep 2026 18:40:08 +0000
References: <20260831165230.2696893-1-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260831165230.2696893-1-chia-yu.chang@nokia-bell-labs.com>
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
Cc: ihor.solodrai@linux.dev, john.fastabend@gmail.com, jakub@cloudflare.com,
 jiayuan.chen@linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, horms@kernel.org, dsahern@kernel.org, pabeni@redhat.com,
 jhs@mojatatu.com, stephen@networkplumber.org, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 kuniyu@google.com, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com, Mike_Rudolph@comcast.com, Jeff_Howe@comcast.com,
 srichard@netapp.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 18:52:28 +0200 you wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> This series replaces the existing min_tso_segs() congestion control
> callback with a new tso_segs() callback that allows congestion control
> algorithms to provide an explicit TSO segment count for each data burst.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/2] tcp: Replace min_tso_segs() with tso_segs() CC callback
    https://git.kernel.org/netdev/net-next/c/cb145191e9d3
  - [net-next,v9,2/2] bpf: make tcp_tso_autosize() available to BPF congestion controls
    https://git.kernel.org/netdev/net-next/c/f69a0944415f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


