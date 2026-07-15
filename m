Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14E330AAA9;
	Wed, 15 Jul 2026 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104840; cv=none; b=F395zsBGHSYnNfNGD2hUpSg6YEuJeJ1wd/KbIwbjnjy0Vq1W2ZaZDq02HzjcCQ9Ozl5lEn5YFamzfEVeBy2r/o9q6mzMuTUN+VMxeR3kGa/bwts4H83Bhuutx0FWm2ZnNgw+ZyXi+cPa2ZbmUFwGc8OPfYRyPagMSzKefLh0R2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104840; c=relaxed/simple;
	bh=XZ+UP6SL1gjTGREjGTlBL+zx0cwpy4UD3RrZUMJYC4U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HAdInKOIBBZReHBMTwjkYiAdgwppI/CmC4xwjOf8RD93KKAPuoTeGMKBiM/JKBPDqzJlVFIe3IyTP6cCscsemdj9a6SAoqcLQqn9RjxJvuPp/OBKwzFeSyB55l+RkDzTnnwPWP4ZvDInKZj/3SZDfXyAJoHYludjGEUprM6xu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ3MIUm3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ3MIUm3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EAD1F000E9;
	Wed, 15 Jul 2026 08:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784104838;
	bh=zAjrGa64tqK/7nRkcEaSFxMhCRl3hQjTgA9NIHb98NE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VQ3MIUm3hlselemW6SnktNAF6vZ4Za3/HscrWSRlRra1m+kUetXOhxxeu/cX8smhp
	 ApQe4Dj3lMTtSziawoOgL8c5dFJ8zNaEh/WkJC6TLMMjPRMZuJcxKgtaaVLsXU1i54
	 kJkmykmHz40LB0mgIEZ4NWkB23pwK6dm8MRx+Eel/B3XynyPDpOjzOtFhw3dznhT2L
	 fPsaqkCAdkSx+maf5PcbAM1zzQLKZSZ/wD2wsvzI6tCej4xMKz98GYleWeI1H1PLb/
	 CZE8gmkvDn1X92jt2xJEjJbIP8P2F9rDhhyYNrNLbm+Uqyn3W1nivD/XPU9NLlZRtu
	 Djy0QMIdKfOLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AC03938C6F;
	Wed, 15 Jul 2026 08:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/4] bpf, sockmap: Fix sockmap leaking UDP socks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178410481264.3960544.5024095828575176304.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jul 2026 08:40:12 +0000
References: <20260707-sockmap-lookup-udp-leak-v4-0-f878346f27ab@rbox.co>
In-Reply-To: <20260707-sockmap-lookup-udp-leak-v4-0-f878346f27ab@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, john.fastabend@gmail.com, jakub@cloudflare.com,
 jiayuan.chen@linux.dev, edumazet@google.com, kuniyu@google.com,
 pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, cong.wang@bytedance.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue, 07 Jul 2026 06:23:55 +0200 you wrote:
> Fix for UDP sockets getting leaked during sockmap lookup/release.
> Accompanied by selftests updates.
> 
> Two Sashiko's concerns to be addressed separately:
> https://lore.kernel.org/bpf/20260626205814.BAC3C1F000E9@smtp.kernel.org/
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/4] selftests/bpf: Ensure UDP sockets are bound
    https://git.kernel.org/bpf/bpf/c/fe3ff273767e
  - [bpf,v4,2/4] bpf, sockmap: Reject unhashed UDP sockets on sockmap update
    https://git.kernel.org/bpf/bpf/c/66efd3368ae1
  - [bpf,v4,3/4] selftests/bpf: Adapt sockmap update error handling
    https://git.kernel.org/bpf/bpf/c/30581eda4a07
  - [bpf,v4,4/4] selftests/bpf: Fail unbound UDP on sockmap update
    https://git.kernel.org/bpf/bpf/c/203b06932777

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


