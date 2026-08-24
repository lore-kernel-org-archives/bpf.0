Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAAB353A73;
	Mon, 24 Aug 2026 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598665; cv=none; b=uI/HOG1kob3Hjmb3jofETKb2pmfY3v7tfh7PPpFmvAWQOnwBHaqa2ijJIr7Memf0fBBZqAwzHQrI2GeQ8E8N7VkDB0n5IHvtTHd2JFLZvoo0LrqeQamVXYD4C6hlc+N5bJd8REjE4NCyfmhL10PtOhR9MPFML5tr9H1J2rrusk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598665; c=relaxed/simple;
	bh=LlE0v14jIZFQcZScYahFSSdCIt5FOAKsf3blKlZk4hg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z1eLTVDJPne5AefcuF24Feg6BwQr7xHfaGaL6AkVtHltumSidkPZTcvnwxS7164/ftI87CmlHR6xNaJ2ZiBKrscx8eL75VNlsHPwAw0RaQjFBEyuK6lRVftRQ8VfP7IoeLCJFy/fvvRSXz8klHBhOSmt1ITRYiD3dPGTXGzrUhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVR4e0Ds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVR4e0Ds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5321F000E9;
	Mon, 24 Aug 2026 19:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787598664;
	bh=BGvRfX77aXl0KgKLOcYiFwpOnMqNbg8O7G3TxQ5APK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LVR4e0Ds2DE4ZK/4aIz/HNOa/KRBrE8HCghO99ikH7DsHhZWpjFB/t0PIS29HTRSp
	 hAgnKbdLLMy4bFUbS0Ev0nl+QnqsFlweJqt37pjQEk/2920tgTxTL11i7D+j1Z7U5W
	 2zA4hbiyk+OVQbODw+FcxCHn3koE3PX9GCJ4zbJF49273YcwHPf/uMPaz5zzrNm6z3
	 bYXTcUiBj646iyjlOiTsLSbGAuV504FNosxuYmw0sdQlrd2OXPJU6zY4YOZv2/T7+3
	 SPXQxn56xXLTutDC+Z33azu7BwNNpDVA//YSPqvGtsWsA+IJvpeeSzwE9Q0KWIhRmA
	 tL/4LI5V6A7Vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A2F3924A4C;
	Mon, 24 Aug 2026 19:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] octeontx2-pf: fix NULL deref of af_xdp_zc_qidx on
 rep
 setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759861141.3069565.3646630361476379764.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 19:10:11 +0000
References: <20260821105536.2998765-1-rkannoth@marvell.com>
In-Reply-To: <20260821105536.2998765-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, sumang@marvell.com, andrew+netdev@lunn.ch, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, sdf@fomichev.me,
 sgoutham@marvell.com, gakula@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Aug 2026 16:25:35 +0530 you wrote:
> From: Suman Ghosh <sumang@marvell.com>
> 
> af_xdp_zc_qidx tracks receive queues using AF_XDP zero-copy and is
> allocated during PF/VF probe. Representors and other non-AF_XDP paths
> leave the pointer NULL, but several call sites used test_bit() on it
> unconditionally.
> 
> [...]

Here is the summary with links:
  - [v2,net] octeontx2-pf: fix NULL deref of af_xdp_zc_qidx on rep setup
    https://git.kernel.org/netdev/net/c/b09a0503c755

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


