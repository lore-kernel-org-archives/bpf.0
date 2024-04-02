Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC351C23
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068227; cv=none; b=cT05LFYk0G0oFxewSSf6LesmJVwMW62SOMeyEiSH0iTakkNnSrQRmeJSf6EfYbjA/iADNELc5bccMimPiMDmltJrALvgV7jS8y+6AmPoiUr080cpn+imH6vbP8dlOtpIfmEkMFO5wG+ufvclISKUhLQ6t/I0ZRMRwlLnkLLQQ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068227; c=relaxed/simple;
	bh=SHH0t+KTYCClMn7YJNyAU5vJFmEWU5GfoC4X4OjuCwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sWR1JI5vH+KjpcPZK0zGBmPYdR1BW1UN5ovSfkHZFwG9OEzJ10kS7GCtQLqVL6hUQpZniDJGp85JHijJ6/v0R2urhAp6pWiZfIhBhLnavcRIPrqaIgEaau9ErXkPEPysGoOqsSsryRZm0balCxXebGd82oWeuQswvP1vq2Fo3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cso/jcJj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cso/jcJj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A0AEC433F1;
	Tue,  2 Apr 2024 14:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712068227;
	bh=SHH0t+KTYCClMn7YJNyAU5vJFmEWU5GfoC4X4OjuCwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cso/jcJj/H3G5UL9EFnDaVt3vgc/7OfdwHi7i2mqMkSh8acjZq9/aTKAabYkA2iv0
	 +BKyVbkj59dLaviYC9tLWvKVh1ivpZ0mk+8a2XXz/g6MS6Nyzpx53Puey2kGW/Gsgj
	 U9GA8kONVZ+N73P3pRiJKQ5vigD4f9E/cr54oEZNVofhNY2n16+LV4yhH7HIh6hRiX
	 HikMGJVM+7xgEXCvE3fKC0YzqvdYRUPaoa8rZqYiHPFF/vSqd4ZruzN3HYawiSLFO6
	 gviT3ocaE0NbPK9V2buGZD5JcIm2cji4ZTmXi9/y/VRo9HPTQaD4pdFdWaC2lus7R8
	 iE2TGGzHHMkGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B5EAD9A158;
	Tue,  2 Apr 2024 14:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: use __typeof__() instead of typeof() in BPF
 skeleton
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171206822710.18546.11948562739802439995.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 14:30:27 +0000
References: <20240401170713.2081368-1-andrii@kernel.org>
In-Reply-To: <20240401170713.2081368-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  1 Apr 2024 10:07:13 -0700 you wrote:
> When generated BPF skeleton header is included in C++ code base, some
> compiler setups will emit warning about using language extensions due to
> typeof() usage, resulting in something like:
> 
>   error: extension used [-Werror,-Wlanguage-extension-token]
>   obj->struct_ops.empty_tcp_ca = (typeof(obj->struct_ops.empty_tcp_ca))
>                                   ^
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: use __typeof__() instead of typeof() in BPF skeleton
    https://git.kernel.org/bpf/bpf-next/c/2a24e2485722

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


