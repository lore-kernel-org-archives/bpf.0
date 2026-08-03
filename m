Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739AC3B1014;
	Mon,  3 Aug 2026 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789045; cv=none; b=gxYgu4o4hHG6puX7ZN8WE4qGUGo3jXgL26H1NTYIzCZifL2JQPOoye032dChv5Q0JEY+6gclOIR1GfXAlos2XAGvKNyVOcHjRpLZIVfJaLd25sYBDDX0dlhSa1PbiWKuoQfR00o+2j4iOqdAJSHE0ZtH9kz5qhnZiFCv4WVTrXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789045; c=relaxed/simple;
	bh=6VsWk7uOMLEOEtohHHLSZnaD7P1uY+fD73NkRS10a3Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M7y5Y+mI5WKPD9go5tiyJZl2k9JqPMCZJ7GI3SR2sY7M+zIciTeURQkyZKft59rhb/Bdahhxte1AWjG2RZRtxX9QER1PoIvYNvrt/ccx6Aj8dstDE9hHPgoHnfkQnolEyRQbt5IEGh5vg6i5TvURbroaAVIqgdAECYvzfuR3VqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JC+szgQ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JC+szgQ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C5F1F000E9;
	Mon,  3 Aug 2026 20:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785789044;
	bh=y4L/+0E4iNnbYSWeBPnvD5y2pFB18GcS1dqID77LUTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JC+szgQ9Lgdl37mUG1CukgKUIWU67fu4tlj3aDBxspu3C1Gl8dv3TxVi+rp0lF0ag
	 8Fa16cNt0X3LaBCtJD+ay2ruYM4PTqr1WpQDctqd8oRTlTrGNyFPXLzRDWUTpBOekl
	 8EUe+Mqn0WpnUZAs3E35ku161a6TRgEX+ozypkcNEUnBfWubbRbsrVT8J5l0vM3wXn
	 Qt3mNgu8aJHlJqtpscOhyeCXe/UEME4TQek51gI7S/xHk8GDNeSwmm8CAfAQqeUtfz
	 3NiK2BKp1yZEn5qPkqErAzj1Yln27/8z9U5hPUfWyNTWLyk+Il0Nw3Wr3eioyeRINn
	 KgrwgpVY0VwPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D1392445D;
	Mon,  3 Aug 2026 20:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: enable devmem TCP in the
 test
 config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178578900514.2821811.1990216783569793637.git-patchwork-notify@kernel.org>
Date: Mon, 03 Aug 2026 20:30:05 +0000
References: <20260731-selftests-devmem-config-v1-1-098014348d9d@meta.com>
In-Reply-To: <20260731-selftests-devmem-config-v1-1-098014348d9d@meta.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, bobbyeshleman@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jul 2026 16:36:23 -0700 you wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> The config fragment already sets CONFIG_UDMABUF=y, but kconfig silently
> drops it. UDMABUF/NET_DEVMEM both depend on DMA_SHARED_BUFFER, which we
> can't enable directly, so we need to enable a config that selects it. We
> use SYNC_FILE for that purpose here.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: enable devmem TCP in the test config
    https://git.kernel.org/netdev/net-next/c/8c7badd19e13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


