Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D640A30AD1A;
	Tue, 19 May 2026 02:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779156596; cv=none; b=nri/sP3439T0F9V4735Gt5ZKEoAKT0tasStol/oNV+r2dvVgcNYiZp2jQvbjkiVViMrizzNFmAxL8z9IFaLD4xID4BFzDmJ5xZg4Gl6vCC6Qg7gxVlrYjHVNuw0SmyExEtYAU/4dfMwgNbMOxp7coDpKZuhZTbM+v6R4sjJ52OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779156596; c=relaxed/simple;
	bh=T0xSLxJ/GyTKjCog/LqeN/BNj3foZSjmpd4uaVwM4I8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZgEP3ij/udh/KRNbYuEJGVv6XC8CH29Zzm9/EwMk45NlXhNfVCDPqWMUo08XVUpKEaN/0zrDy1J/9BFnj8nCLhcLHg7MWcdCqpwkjNkjLYUbHlJsJUViq3ITpALXxjf34XK74nDuSdjIbMs9awRyNgCqjsiw8rEaYyu2qb8PYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHj91jVH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHj91jVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFB3C2BCB8;
	Tue, 19 May 2026 02:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779156596;
	bh=T0xSLxJ/GyTKjCog/LqeN/BNj3foZSjmpd4uaVwM4I8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jHj91jVHlZWsXgKv+mVodC4kLv99mlmuTcsb2g82m0k6OfPCZFzrNpPhGMTEtNGzd
	 eGMHHi5yaI0ux8JulOdKHUpNuPsQ+CQHIUPhcJ14ASRnU+vJ+aG2TqehpCBUwq/L/t
	 o+bgh6nvJtfmUWUCOmMdZAqx4cr/sG/R9ih8ghcsif1hmBCGCaOHbubjSga7P1USmh
	 ozQlKT3AY8OX1BoecAVMGx2QPVSO6xZHZ9LZenz37b/fH2I0L3Z36xzUviRDAhGM8V
	 JgxW2tQuM3n/Yji5NMKs0LW5PfRXYJm/AbDD0szIJH5GoVO6Dj5FENyVo6Z0BpTudO
	 Wl3Z2nJYo2FTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197AE3930D10;
	Tue, 19 May 2026 02:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Reject unsupported -k option in
 vmtest.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177915660790.2054007.17618199440509300067.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 02:10:07 +0000
References: <20260516120625.80839-1-roman@kvasnytskyi.net>
In-Reply-To: <20260516120625.80839-1-roman@kvasnytskyi.net>
To: Roman Kvasnytskyi <roman@kvasnytskyi.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 kpsingh@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 16 May 2026 14:06:25 +0200 you wrote:
> vmtest.sh does not document a -k option and does not handle it in the
> getopts case statement. However, the getopts optstring includes k, which
> causes the script to accept -k silently instead of reporting it as an
> invalid option.
> 
> Remove k from the optstring so unsupported options are rejected through
> the existing invalid-option path.
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Reject unsupported -k option in vmtest.sh
    https://git.kernel.org/bpf/bpf-next/c/6df582112aa9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


