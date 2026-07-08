Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74804219FD;
	Wed,  8 Jul 2026 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507240; cv=none; b=TDvEMHjcCjMVuK2XjrXTmHgF+z6GbLM+aL/N483IvcLv/5fl6tSkf/0L1OgkuIitXcMaGSwORJeGA3FnO17MeEmV2BY6kqBhEnTzx5s2/KV7apYyDbC16FRsmO8KTf8lAuU6cfpmGei1hZcVcYgWE7YnuuWEpqg45u/bAnxqGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507240; c=relaxed/simple;
	bh=BSDQi9TTEUGku/M+2NpuaJTxk/kr4HgYxgNVRyZ6Pvc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N58a6TyfD7LyS80+tQh0fY2jzti2PtMiwn8Wnh8vikcRwYXvjfvkMUSrPs/a1N1234PovbF++s0e6pbG280/+1PzbYw/LMXJOMfFwuplYVRquOCF4Qlx2CshpAKIMWUW+OhXNxzSccbmiDx61QfInXy8Qp+oWy7Tw7XN+31419o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEAmveca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEAmveca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1DC1F00A3A;
	Wed,  8 Jul 2026 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507230;
	bh=wKwCsubqRnhqkGvjZy/M9ofAXQ/VIpdAisUsS/v0yaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aEAmveca5ky1UhGeknPgIFeaLKODYveKeq4BEONnlpIe4lPfKtxhxw8lH7txazxaf
	 Jp7NToObec2xsYXB/Nr09NRuKoRrCqtw9F/4wHUU/RfSiaN51n9ZPED7xyUg791d9n
	 zEzMo6fZpp2Uuku7hzKv/ZmNAE8GDAJWELY1i4LK+8kaa1wkTT9l0BB6HyWhDdAcIY
	 dXWygo0YVS5jGpHgEVMvOnxPHYkHfo3sERkDnCKISWmWh0vE07RoNdtmEf28GJtzWm
	 LQ6NxyJ3XUZ7atMHi5zsdfmD2IN0+Us2o4dTNkPIOSkv09zHg6DBSRnimULYBIh4BL
	 GqR9tO7kh7Ypg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C9215392666D;
	Wed,  8 Jul 2026 10:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] selftests: drv-net: run XDP tests with both
 IP
 versions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178350720939.2431187.11844691575013845734.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 10:40:09 +0000
References: <20260702062348.2123960-1-noren@nvidia.com>
In-Reply-To: <20260702062348.2123960-1-noren@nvidia.com>
To: Nimrod Oren <noren@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, bobbyeshleman@meta.com, willemb@google.com, weibunny@fb.com,
 dw@davidwei.uk, cratiu@nvidia.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 2 Jul 2026 09:23:46 +0300 you wrote:
> The driver selftest environment picks a single address family for tests
> which use the generic address fields. When both IPv4 and IPv6 are
> available it prefers IPv6, which can leave IPv4 paths untested and hide
> IPv4-only bugs.
> 
> This happened recently in the XDP selftest, where an IPv4 checksum bug
> was missed when IPv6 was also configured. XDP traffic handling has
> IP-version-specific code paths, and the follow-up discussion concluded
> that the XDP tests should run against both IP versions [1].
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests: drv-net: allow switching env IP version
    https://git.kernel.org/netdev/net-next/c/432f4bab1ada
  - [net-next,2/2] selftests: drv-net: xdp: run with both IP versions
    https://git.kernel.org/netdev/net-next/c/47467501cb88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


