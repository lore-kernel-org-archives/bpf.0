Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8290A4AA3E9;
	Fri, 11 Sep 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148478; cv=none; b=Dk/5UMXgswhMwzlxJk4FOfsMgJW0+T8LzQMtA73bdTGuxr5zm3Zd+l47rCpR+POZyTh9+ZtaRU+rTfJcHwmrXW81Mu9P7kQr/vvgGWgQOzC9vUIZrqOk8/o88COv2Difz1Hedsno/e58aB8J6PSNLonfJBVLY0EOHzmYuEvnyL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148478; c=relaxed/simple;
	bh=Qx5n2BBdFgLI6dEt2EFNOEvHbv16tyjdEvV2bkO8ANg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A9DK5bk8PjT/7sdjB7N4qgd01iMdnWhC2S7X6/OuX28gMgkyjXdaZiE5w+hG4lUYzhKncMOoB3mJ1i8NFomG4KusPEAEsru3xl1jee9wCGqhCeNshlJezsSjAlsetUhLP7DLKKICij1EQv7emiiaOatWyYBTB6+LSlgfCa4KjDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef2itqK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef2itqK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6051F000FF;
	Fri, 11 Sep 2026 17:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789148468;
	bh=S33eBp+X5coiPLOqCdCWKhuXhDggdwTNMGhHAQrMbE0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ef2itqK+BdECXz4nRBlslLvdnH5zckZr2EM4aVHiyT6rRUmS8jS1ily0vGUpxCyEV
	 g0wYe3vGZLCoMBqOJjGosnEuPHtCj1/N8jmKsascdh5DdT2LiBz8r9rRgOJI2qz5Np
	 Ulw5GZK++R5tvYdLwe7qTKTWoi+XXoFRlUm2/kDUdze28QN/YOmtTHWdNYIEqHYJAo
	 eMTQXMtEENp8yAIOyw3ulFFofty3dfStLV+a2Xm2pEGh7E30lPMcX6AdzCoAFhm6FF
	 y+tww5BOVTfOH8mh47Y9jq+/OcAEPhsrVl0S6U8gL3Qnx6O6RbC8zk8Dleigk5pWhq
	 ovHPsMCfMqO2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569703924450;
	Fri, 11 Sep 2026 17:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf,
 docs: Fix two struct names in btf.rst and kfuncs.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178914840504.3026440.16596619579892095283.git-patchwork-notify@kernel.org>
Date: Fri, 11 Sep 2026 17:40:05 +0000
References: <20260906222656.3459-1-kmehltretter@gmail.com>
In-Reply-To: <20260906222656.3459-1-kmehltretter@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org,
 corbet@lwn.net, linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
 rdunlap@infradead.org, void@manifault.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  7 Sep 2026 00:26:56 +0200 you wrote:
> struct btf_variable and struct bpf_cpmuask do not exist; the names are
> struct btf_var and struct bpf_cpumask.
> 
> Use them.
> 
> Fixes: f063c889c945 ("bpf: add specification for BTF Var and DataSec kinds")
> Fixes: 027bdec89364 ("bpf/docs: Document the nocast aliasing behavior of ___init")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf, docs: Fix two struct names in btf.rst and kfuncs.rst
    https://git.kernel.org/bpf/bpf-next/c/cf95f22a06b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


