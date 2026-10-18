Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300F248896;
	Sun, 18 Oct 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337410; cv=none; b=XmpN3xfIVpol3blyoOXU3amiDn9j1TucP3Dmsq4C3OOrxVcjRvdocUXaL45uCHH10jI784QUDfzJjLTH6zo3ikZ9c7TU1NfWPO4bPWgxPyEM85hkUcNMlZmiMQrGhGj0LHd1BQzIPn8H6mcCZci2hQssoi6WmXm2ofTzUNPEfjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337410; c=relaxed/simple;
	bh=tEoKc/rPp06pgCmkkNlYeQ9XL85I/oLfL04UNlC4lPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h9f8oGtl78s+RF3dB2A4QUgsbNksmi6t4UjtpM4PvJfcx3MHvbiQnFMKNr/cRuKsugs/mCrGLP8J5Rl3pJ/7eOCXm/FEo+0XTUstzIKfxgWUJM/+YpFxn0LuIRspVB4r9dQOYhVScVRPPYSPVi1Fv2j0TmIxNi3T/gTSFF5H7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDMCNere; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDMCNere"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FE31F000C5;
	Sun, 18 Oct 2026 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792337407;
	bh=Xw8tjepwG9FbE8Kip96v7ZhTRyp+FxNpGTh3m86oNyU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YDMCNerekJVBGfPJvnMKEH2m/CMasLLWT0MAbHhRCNn8JxjyLFkHfwpov47ofzW41
	 xwx1Kiwaoiuad9NVRQoHGzofYrWPJa6WvonfO1v1QVSkOJuSHmLgSMXRB9XuK07ywH
	 TLtWB66VtCSwpvK8M3KpvWwVzjDRALq/fFWSL13yA/u/L8T7d/BBZ+RwaZSzBZHkRe
	 VLOeoH+ipeobjzSXUX1zAl3avYgEisiJFDyAHWs5+j8X1zl26dwDoTZxJAmxPERM3J
	 DuGgXE1A/tIFLjd8IUOvVJC0gAMdshtk/DJChPC9qTZ5mEdAbDMgl7xkKt+cdT7TWp
	 74Aq4zsDaEzYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4683811965;
	Sun, 18 Oct 2026 15:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] bpf: Zero-extend the index in inlined
 bpf_get_func_arg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179233740603.1716327.12837007566420254836.git-patchwork-notify@kernel.org>
Date: Sun, 18 Oct 2026 15:30:06 +0000
References: <20261018-get-func-arg-v2-0-048848b3eddf@gmail.com>
In-Reply-To: <20261018-get-func-arg-v2-0-048848b3eddf@gmail.com>
To: Woojin Ji <random6.xyz@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 18 Oct 2026 13:21:40 +0900 you wrote:
> v2, from the review of v1:
> 
>  - Shift the index as a 32-bit value instead of inserting an explicit
>    zero-extension (Alexei). The inlined sequence is one instruction shorter
>    and the bounds check is untouched, so no program is accepted or rejected
>    differently.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Zero-extend the index in inlined bpf_get_func_arg()
    https://git.kernel.org/bpf/bpf-next/c/1c1dda9ba9f3
  - [bpf,v2,2/2] selftests/bpf: Test out-of-range index bits in bpf_get_func_arg()
    https://git.kernel.org/bpf/bpf-next/c/38dbc3047a2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


