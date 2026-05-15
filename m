Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC65F2949E0;
	Fri, 15 May 2026 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864392; cv=none; b=nwM0Qg5L6O2s9JwwgEIZkQjQB/oQeGpyCaiAED41msUGz9u55g2voBKhA/N7hjmxZ/E3GWrcqin1/uo7cIdYwMDlVy7/eTwPtpsoA1eBWRPXTa5T38JRbxhoEKQt8AnQrdZE7kK8hwRl8fSi33DMJ1KVpEP0eFr9qjaEMM0wtqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864392; c=relaxed/simple;
	bh=yT88VGm1O0iWdRPjtmbD5nQ9vGaeHRcFz4WazBu1XLY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DIxCb11kpebu3wtqcScbysW7H0NYGDn2+vx/DIKSo7SPKBzdEP19aARbAOlcNh1YODqd/Z/NV+I/hv92ZhZFMZdm/TN96/UCns8Doff+jF2MlsgRM6HaEwaoFlc2WfvpTfW/ZimjOSGtODQY8py+WSCZSfeis32QnXLefhkQmlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVnwThpl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVnwThpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A3AC2BCB3;
	Fri, 15 May 2026 16:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778864392;
	bh=yT88VGm1O0iWdRPjtmbD5nQ9vGaeHRcFz4WazBu1XLY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iVnwThpl8d+z7QzOP37vLhy7W63Z/+DW8ZCEugTjGB4AUHnjbbuny58d87LIHc+/j
	 immuR7gaPSv1xVZv9xUe25yyvNeaEP86nh5AldLiqmi6iBqa6As9ddVEfK2+VXPeNM
	 vHhx1hLUSw1JKL9Shavfd1mWUmNQucGjNHRFWY6O1Aw9T9wKJTdCokC7exUaJF0E5D
	 2oQBHaIRFWruKamEigpAlrXwsqUVktUOmoXu7X5e5HQaKN/wS39X214DqAmewxow9v
	 dj4SYyOD6gY4+9xOGejYZE2ZD+javIpLk7fta1OrBM8ZUX9EvhYYsF42hTemXYj4L/
	 7VGCh45oS47YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF06139309B3;
	Fri, 15 May 2026 17:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v2] bpf: make bpf_session_is_return() reference optional
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177886440577.81152.15071075076553689391.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 17:00:05 +0000
References: <20260515113242.2706303-1-arnd@kernel.org>
In-Reply-To: <20260515113242.2706303-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, menglong8.dong@gmail.com, arnd@arndb.de,
 john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, puranjay@kernel.org,
 a.s.protopopov@gmail.com, yatsenko@meta.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 15 May 2026 13:32:32 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building without CONFIG_BPF_EVENTS produces a build-time
> warning:
> 
> WARN: resolve_btfids: unresolved symbol bpf_session_is_return
> 
> [...]

Here is the summary with links:
  - [v2] bpf: make bpf_session_is_return() reference optional
    https://git.kernel.org/bpf/bpf/c/a828abbb8976

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


