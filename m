Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D97E555;
	Tue,  4 Aug 2026 23:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785884447; cv=none; b=K3WZ50DHcEt3osmm0MdyRWoAbLnAaNtzEYJXSqkCyTisBenMKasQpmoWlEtISzUq6HQBQYYmrYsRlCIPn8M5by826JBe/Emor36XDnBI7Q4K2GWhoahPsC8PCObQveMnvOSXuRV4HQ/IY7Mu0bIzC8OzYJaZq8mXH4+FRqfXE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785884447; c=relaxed/simple;
	bh=AUhYh2aI4ZmWcKmnmYMSkQ125e0CHL474lGi5D9irEw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DPX836TD1S5hmFSpkajExKMES43YxW9og6xvpKUbYQUUa7wU42XuGL/mgR80I/B5PxmsdUedIHKx/p1NdmL6Z1JDtudxR/Ws2MA7GI4TxkGKb/ZerS9V80G9+ec2o0Tncd9EiSZUmEY2fwC5b4e0N/RfYsdpjpBeeWKAhLz6Zh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jriVEUxU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jriVEUxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6B61F000E9;
	Tue,  4 Aug 2026 23:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785884445;
	bh=+ikihcHa2nfS9etdig4BXC8cRVkOD+N3HlYcgipzejw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jriVEUxUB+njr9wun3Gd4h04Kx3a9jmCCLZsNstYEW9fgrrufmTVDpgutb3rMo4Ek
	 E6n205ex6U3mrS42hAQ5zSOLtPzN8Uapyn1egzZudehMAlBZECC6OpmKdC0aIugwhz
	 nNBlaa96/SPzF0XVj6uIFcr3R7F6xbUlJ+Lk08BsW1O5Dntu/O0lp2amL1gdsL8jSR
	 Y/a7QuptUMxYFDGaEeLBrWzZGO2GsxUSV7Qcik10j9AqcXWEAaIQJ1nVtI5FkNDime
	 2aVzaDKpIQT49UgKZZi+kj024Wt8Az+o4/NJOLzszApTQzVNZoVxIvDsuuHuje6pUQ
	 S/YRHpUKzcZnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568F6392664C;
	Tue,  4 Aug 2026 23:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests/xsk: decouple xskxceiver and xdp
 apps
 from test_progs objects
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178588440590.3821475.12632430931858427615.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 23:00:05 +0000
References: <20260728115036.2049536-1-tushar.vyavahare@intel.com>
In-Reply-To: <20260728115036.2049536-1-tushar.vyavahare@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, stfomichev@gmail.com, kernelxing@tencent.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, tirthendu.sarkar@intel.com, andrii.nakryiko@gmail.com,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 28 Jul 2026 11:50:36 +0000 you wrote:
> Build xskxceiver, xdp_hw_metadata, and xdp_features from explicit source
> lists instead of reusing helper objects produced by test_progs rules.
> 
> Reusing shared objects such as network_helpers.o and xsk.o can pull in
> test_progs-only dependency chains and trigger unrelated libarena builds
> when invoking a single target.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests/xsk: decouple xskxceiver and xdp apps from test_progs objects
    https://git.kernel.org/bpf/bpf-next/c/e2baf9cc374d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


