Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED043FFF9B;
	Wed,  8 Jul 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498828; cv=none; b=KRJKxoigTxlyyVMLBUqHjMhBN87/t5TWrGfpIv6ChWXLWK5j0WB/PtW/i9XS3QDYYxXap+p60B/98/Vbrw1lJZoEkWKymJrIDjIqQxObT1JQGT8iGgtX36tyGI+Iz/ggCq6UwBI9J+M6edgmpaIqG6L+Mkk/5lFCAm6rs3DmRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498828; c=relaxed/simple;
	bh=e9Y+9vX7kUG/+sFDymQjExYkxiGsYQbZ+4rLH4B5CEk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bcUk2mI3LOpycPhISLQ8IHkd5FGzTpk2E1u/YVATIDMIKlKGooESV0/DwauGDa56XSDlIGMVozaAvZv5iV8IH97ETIXKtxrvCr+aufeO630QQ0a03UuB1q1kl2UNULYEqGdiYxsPSrUeSoGIkWKyTUgvhMKRK6KRFptg4uRUZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gf9FVOx3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gf9FVOx3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7514D1F000E9;
	Wed,  8 Jul 2026 08:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498826;
	bh=CjvLLLNQW00a75OTauCn6qsFRF0egL/0j/rjTC0xHeM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Gf9FVOx35r7tkRTgLFJo+6PiaZPH6083Zt3mbvkoQWqxttOSXHvedwM/FxjwYRl4n
	 ea+m6fJpDwX3AyWMd8CdyveWv4ftR6qhV9TUTgkfvyVFBrB9YPKNPDCSGkYc8xFXFJ
	 DAP6ozwVM38XO/zC00Shm0L1ceVewQIw9wNGCkQflQF29+S5djPDHdXtiy9Yfp7ZgV
	 kNocuNktkmHO35SQ1R3LeGrVv2J7NPvLUY0SrrFVohfUlWWQ8afy7KYWPlRATJAYHJ
	 d6U1+AXPGLFgu5HVReJrjNcK0AL74RH+d2V+XHLPbG0SLFX+VgMpQv6hOje6avlY6O
	 mCxOeyI++qVvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 12FA33926383;
	Wed,  8 Jul 2026 08:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools/resolve_btfids: Include libsubcmd headers directly
 from source tree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178349880566.2367097.17823362594573943433.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 08:20:05 +0000
References: <20260702-libsubcmd-spam-v1-1-300ec142a62f@linutronix.de>
In-Reply-To: <20260702-libsubcmd-spam-v1-1-300ec142a62f@linutronix.de>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Cthomas=2Eweissschuh=40linutronix=2Ede=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: acme@redhat.com, namhyung@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Thu, 02 Jul 2026 10:26:30 +0200 you wrote:
> Currently each build with resolve_btfids enabled unnecessarily prints
> the line 'INSTALL libsubcmd_headers' from libsubcmd.
> 
> Use the libcmd headers from source tree instead, without installation.
> 
> The same was done for objtool in commit ac999926774a ("objtool: Include
> libsubcmd headers directly from source tree"), albeit for a different
> reason.
> 
> [...]

Here is the summary with links:
  - tools/resolve_btfids: Include libsubcmd headers directly from source tree
    https://git.kernel.org/bpf/bpf-next/c/0bdbed9133fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


