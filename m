Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4CB4DD3A6
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008876; cv=none; b=EELkj+uoXobEBgQz18XwOuiEtEFhD3Zm80Ak39Ic5E3hTGUM5gPPNdpQVTwyz2MOrT32cnAkUTiMyXfxzitGTG0pUogFX5MYU2CxfCC+ZGiuN7Qsj57fOXJ2wSt7A7WW5CuWoYxfNmyZvW1voug00Z2ZM0OQYPOK23NW+Kxd5Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008876; c=relaxed/simple;
	bh=33JKacDJiqu5WGx7OEem241XKITjvzsxObPxXWqyykU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TZW/R2ja+CnfV/OyhjVN97U7pGMQtf7QHFJdM8eHl3lRoFz5IXT+XQ2rbRx6UKYX+Qt2Mgrg73CyzTj1/qbUWdKcBMfK/DbecuwOuGUdyhdR3hnW9xI79FcvWLz/RZ5snzN6GvgJ5gh4P9u0S8WCqSJz/Hb0/oo2xT+LhcLMQpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUSDLTHY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUSDLTHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC2B1F000FF;
	Mon, 21 Sep 2026 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790008874;
	bh=bGfYuvyjRGv8KOHtfG4TAyz2AJhCCFiDjVcP198e4jA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WUSDLTHYpwWwhR5S9lWPoaowgAVwH78livyI401JNXBwHMY8aTFxnJNB3B3PNEWRy
	 kD7oSZIt7uxs/KEpISwAMo5Zaicn7Uhw9taHto3i6HdGtUC6PnO5+lM7mbLagSspcR
	 ln2R2Gg2FnLlZvUq3xs/sTOnTBwieK9HA30JwEwI51BNDQUIBHxNtoldchZAopSEwz
	 Ox4Tf9ZvJMaq8Z5ggLmMTwjggllNtAbaloKgsxpVT3CdtvFxC0sSwPUcgBaCHdzp2T
	 VoMrwO1XbocmOEzt2WM/6fOyU5YzZEt20jaES+Ydgw1RxH7jFM3TA5ZKd8r8V9A4qa
	 0Lq2y0LUCpb1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569263927047;
	Mon, 21 Sep 2026 16:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v9 0/2] libbpf: improve BPF load performance by
 selectively loading module BTFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179000880614.3127600.4490583996264592511.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 16:40:06 +0000
References: <20260915124104.77287-1-zhaofuyu@vivo.com>
In-Reply-To: <20260915124104.77287-1-zhaofuyu@vivo.com>
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, andrii.nakryiko@gmail.com,
 alan.maguire@oracle.com, olsajiri@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 15 Sep 2026 20:41:02 +0800 you wrote:
> Currently, load_module_btfs() unconditionally iterates over all kernel
> module BTFs and loads each one. This introduces unnecessary overhead
> when a BPF program only needs BTFs from a small subset of modules.
> 
> In our Android testing, BPF programs are loaded on demand rather than
> preloaded to avoid unnecessary memory usage from unused programs. With
> 93 module BTFs present, the total BPF loading time exceeds 300 ms, with
> module BTF loading accounting for around 69% of the total loading time.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v9,1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts
    https://git.kernel.org/bpf/bpf-next/c/34b184792443
  - [bpf-next,v9,2/2] selftests/bpf: add tests for selective module BTF loading
    https://git.kernel.org/bpf/bpf-next/c/66c22d8c0f62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


