Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05514542EE1;
	Thu, 15 Oct 2026 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083022; cv=none; b=PpE57k8cL1z8lYcsMaX8PNKXa6eL2rDc5OzFU8r350dv59GSG/2spYtosmgGcllw1+ttPKWYtEWv2Qtb5pOI3cXLZao4rn1f6viZjbLU0OdTw75fXcuROlngr+mIkRtfwAgAKt4sNzNR9cnvknX8SVMa1gEIxUJdDqkYGxoVII8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083022; c=relaxed/simple;
	bh=0of8ygD0Az/gkV/NZQnboRbRtEkEHNj7Pwpy6iuBarM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DXNk/WGIXBSMLV0rpx0M/WzRHPuFBUT1ZLIoK/Td3ApTWLRwuLuB2GMCkT3+5I9sMxWbLgjE7SGf2IG49WRgr/lvYjTmXcdBcrHAaw70rkpy797BYJPZpmBfyoAR7Dv+8tkMEl7qNHKoNpOhNOz5V0Mqn3RPrDroYphep0GvKSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQ16d5uX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQ16d5uX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438BC1F000C5;
	Thu, 15 Oct 2026 16:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792083006;
	bh=QrV2O0h8+VmYQP4q5Ksnbwms+9XwOxF//OXe+IHhOEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EQ16d5uXPvP/SuCBk4C5rcjDtnu545sk+jYwbT4eupqv4UvsnmK8O3m1XOG75/fha
	 K3ecmhZN3qpz4mxjGS008VRG+lMOYaHUm9bz/d3ubiR08Y64ZIS6ApqtqYD2xBIczc
	 VsOz0BQQXFO8uhb8f88kGipFUgjbADy+XbcKKyMHhMpTlqo+0bO7wOibXXAjwnAg5i
	 KtBniYFJDnZCPm0u5g/F5xkDzjbq86PQuxgAsrk3OHqPX+sUKZEo6u94PwFrTaLxrF
	 tvWAiOb09jyW3FKNdeGUlO3RKYxEg5pGPSIakn9QHU/HV13obp8hKGMFseKpcxWHqr
	 nzMNaGulEOgNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A35E3808209;
	Thu, 15 Oct 2026 16:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix map fd leak in no-BTF wq test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179208300503.4004131.2666615375051381971.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 16:50:05 +0000
References: <20261013030114.292157-1-luyun_611@163.com>
In-Reply-To: <20261013030114.292157-1-luyun_611@163.com>
To: luyun <luyun_611@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, yatsenko@meta.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 13 Oct 2026 11:01:14 +0800 you wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> bpf_map__reuse_fd() duplicates the supplied file descriptor instead of
> taking ownership of it. test_failure_map_no_btf() closes the original
> map_fd only when reuse fails, leaking it when reuse succeeds, including
> when the test passes. Destroying the skeleton closes its own descriptor
> but leaves the original descriptor and its map reference alive.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix map fd leak in no-BTF wq test
    https://git.kernel.org/bpf/bpf-next/c/d3c9ecb8765d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


