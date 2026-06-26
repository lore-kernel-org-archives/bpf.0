Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646753E2ABC;
	Fri, 26 Jun 2026 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476890; cv=none; b=cV7preUYWEDRV6Wl24Id0yVPrfy4D7IsE29y96y+oTytHIVvRngpzt6bi/vYTnhafc7BNejEL9XgGKQQmGr3xZxqbHOGqHdMjrnyI64B6XiMFrTrwBubtLAqztrBgLBUZ6hGUXfkNGu7rcpS1LscY3hAs1aFjQvxi85GuUDcSBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476890; c=relaxed/simple;
	bh=fcwsENDqSj0EFtHbG84gzBFIOOY65Q16NfCAHedimdQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QjddM+C5gg7quG8RxPo8tYGIh4bo/3f79QYBTNpp7uyn8MBaATH96ruH/9+geyh252u0RuS7vLT6vNMAkr9RGWMDE4KRYHwYVRQp0OSguf/8KUKS956S/SeXaW3alIQ3WLnry66cAB0fvjMhPRFsLRN3YxTUxM+uzA5dYKRUZ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8caHlxJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8caHlxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F021E1F00A3A;
	Fri, 26 Jun 2026 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782476889;
	bh=en5A7bqFbsLjnNBu9xTFskH1bw8lGFphnGZZzfz5/OU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c8caHlxJDSikiNfpeg8ziYT3Dgew5XQgk973Ssq5BOXNPuqQ/nTZ2myXylO6XFvAv
	 5rW3XMjeDQHF3lhEcjKr5d3TdwSki9d7K1c890FTdXnWvcbif/j6Kv6ZIQ0YqcCyL8
	 wxpXVKF176ZpkGV8mAIB/D3TF2mGkTfAVbmtiCCEhauyhQFGpWpPMsiH2Xh3o/OnmZ
	 Ql/orY+ODpD1MmAS2H4RGarxbMhPpaFqYGiOjzar//NPwknZppq1G+a4ob+eZr1tWh
	 MbRfBwRREuPW8HTl8fxX3ITPrMxmydZ/wZnZ+fqkXEjqON5B3feUWOrZPspIlLSPIG
	 nG0XzOQs7WgYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A9A39389F8;
	Fri, 26 Jun 2026 12:27:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/1] bpf: Fix insn_aux_data leak on verifier
 err_free_env
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178247687556.457674.4541360269158610374.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 12:27:55 +0000
References: <20260624123536.114757-1-kafai.wan@linux.dev>
In-Reply-To: <20260624123536.114757-1-kafai.wan@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, a.s.protopopov@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 24 Jun 2026 20:35:35 +0800 you wrote:
> When bpf_check() allocates env->insn_aux_data successfully but later
> fails to allocate env->succ, it jumps directly to err_free_env.
> 
> The existing vfree(env->insn_aux_data) sits before the err_free_env
> label, so that direct jump bypasses it and leaks insn_aux_data.
> 
> Move vfree(env->insn_aux_data) into err_free_env so all early and late
> exit paths release it consistently.
> 
> [...]

Here is the summary with links:
  - [bpf,1/1] bpf: Fix insn_aux_data leak on verifier err_free_env path
    https://git.kernel.org/bpf/bpf/c/26490a375cb9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


