Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C9437206E
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783573838; cv=none; b=gRQr8VzKCTgPFgAo4XdVFzwspTF5ansPu7sfYcgCPcxHlTMKq8ux2OWcSGcb8Gv2QOH4i0NzfGlhQsrybDWYphA6zSWFaSWsII+CvO9mm7OTieCEA/8qGpfc/4Z8d7Zyv6NqfaWRKGjBAz7O5610xEiStnm27CpnTU9o4V9qpN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783573838; c=relaxed/simple;
	bh=VB8PzA6q9IOmQrkt9o+m/hTME56Grr87CgI+wL8TcCo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ntfgs9jgoZ9mq2bh/eD18ccNtIZaiYhHEXrTJqxJTx0Z204TyP8QkjFYqpiDCOXglwPeMNoW9D7+F15F8q5I4LjvBWRFO8066kR3Hxe5z7On1lLVypqlTGA+LyecZJcYsnBGzbzLzuEbrW2u+4uxuTy/YjACAdIZNyOobL2jgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3zwR+f6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3zwR+f6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDEA1F000E9;
	Thu,  9 Jul 2026 05:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783573836;
	bh=w/PziqZFl0tQAqSngIbBKK2Tp98ETmO4KzcH16hcoCM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h3zwR+f6cGZgJR26s+80OIqrulZmWiyzT6pm4vrR1SyGaTGriXvHYhZx5MCSG1GE/
	 ji53HudBVFIBMJOu1zO2j/ebmgZp+WbpW88eYaX26umXqPC4233bktUbHz9PjbAd0F
	 1q3twd+7eMLuSssNIFUtd36lGcfy38T2/VUdtJ7XnRoEq7tD+iDH6snR5EUKGcVlfp
	 6AW7/BI/q41dIiHycHUTJmLPixXT6vn1e57HEvxT8PjM3JLwDfgUoHjhxn7E8ctEFc
	 ZK01EsdewIsGs+JrvegfYjM8a8MCTZiQO31LZePJfIW1Nw/6e5Ws3KbjLEE2ccPGFo
	 EYbDbYsi0YQ8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A6A3938EA4;
	Thu,  9 Jul 2026 05:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/4] Misc BPF fixes from sashiko findings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178357381539.3246569.1187552790538928711.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 05:10:15 +0000
References: <20260708211537.371874-1-daniel@iogearbox.net>
In-Reply-To: <20260708211537.371874-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, ast@kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed,  8 Jul 2026 23:15:33 +0200 you wrote:
> Addressing some misc/random findings from sashiko that are worth fixing
> which popped up as pre-existing issues while working on the signed BPF
> loader series.
> 
> Daniel Borkmann (4):
>   bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux
>   bpf: Give vmlinux BTF init its own mutex
>   bpf: Account insn_aux_data allocation in bpf_check
>   bpf: Account scratch buffer in bpf_prog_calc_tag
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/4] bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux
    https://git.kernel.org/bpf/bpf-next/c/92863e678070
  - [bpf-next,2/4] bpf: Give vmlinux BTF init its own mutex
    https://git.kernel.org/bpf/bpf-next/c/5e5e94d87dea
  - [bpf-next,3/4] bpf: Account insn_aux_data allocation in bpf_check
    https://git.kernel.org/bpf/bpf-next/c/42560699a83d
  - [bpf-next,4/4] bpf: Account scratch buffer in bpf_prog_calc_tag
    https://git.kernel.org/bpf/bpf-next/c/ff755b600790

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


