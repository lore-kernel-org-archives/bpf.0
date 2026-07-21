Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B004386C39;
	Tue, 21 Jul 2026 19:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662243; cv=none; b=pbO8LuYQWcfUUEfLiaLBuzDQ/S9+/Yulhots1Zvz17wZeAZG4nXoEd11uU7jia1tOuM8BlxusSrFuCTKt32LfMaeME5Z4ItZ5dw15jYm3Tt//l/O7CrZAotQT/KJN0xi8vhchRgZ1socbxcPJGFku65IeBE32VRf8F+vKMPy92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662243; c=relaxed/simple;
	bh=wGUyhxCMR8/dtL+rmjoXef019oZikOf4VZS3QWDqGjU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pME9wN8bMgKM4tP/p6X2GpkF9hx3TIOc4u+rqDRv2eu4pjH/68EXvey8vUXgH5E9K5VD6hiRcjX7Vh99i1nD8I3KkHyA5vdENvyuQ1+9XZC54obG03aorOlw+fWhH8RpinNx0RAPRoGdDXTZxRk7HRisVy7KjyTLg5yyiZZvjaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA+P+kNF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA+P+kNF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BD41F00A3A;
	Tue, 21 Jul 2026 19:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662241;
	bh=YmXGibOWH8dStd4vMn1C6h1FWYZ670twuktK5zBhKAU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KA+P+kNF8bmMB29ntagD0cuP9XACtm/X66s4YEIZXnB+6mEyjaKuq19UbvomNIVNP
	 27XaASMm4/Ctvm6Mg6qjwoJqPo2SeHU6V/hmppM9aB9ohATzvqY4N9MNKlrkHRn/Br
	 q8fuIGakHcHpUYTpNTfs5HNV6k/pOaponEXGQkpnq1tZnQK3vbwwmymH+ROinL+TgB
	 O+Ge4QTHurl4bllhxw7E+qpUHB4PrBFi4PaRz3e192Ux6r4XEvNvy5HeyeMtbmIQMQ
	 ZEOFU/dwi9jyEuA1bZ6Q1smMCpAmRP0g2D5UQDCBtlDhSCa6rrfEt7OmZe4to1DpER
	 TEzI7uVZu9aZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AF339253FB;
	Tue, 21 Jul 2026 19:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] riscv,
 bpf: Add support for signed operations and 32-bit atomics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466221139.987340.519683377902557290.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 19:30:11 +0000
References: <20260714002451.4091139-1-visitorckw@gmail.com>
In-Reply-To: <20260714002451.4091139-1-visitorckw@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, luke.r.nels@gmail.com,
 xi.wang@gmail.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 pulehui@huawei.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 alex@ghiti.fr, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 marscheng@google.com, bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue, 14 Jul 2026 00:24:48 +0000 you wrote:
> Add support for missing signed operations and 32-bit atomics in the
> RV32 BPF JIT compiler.
> 
> The current implementation lacks support for BPF_SDIV, BPF_SMOD, and
> BPF_MOVSX, ignoring the instruction offset field and treating them as
> unsigned or zero-extended. Introduce support for these operations by
> checking the offset field and emitting the corresponding instructions.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] riscv, bpf: Add support for BPF_SDIV and BPF_SMOD in RV32 JIT
    https://git.kernel.org/bpf/bpf-next/c/2e0fa2389c50
  - [bpf-next,v4,2/3] riscv, bpf: Add support for BPF_MOVSX in RV32 JIT
    https://git.kernel.org/bpf/bpf-next/c/c6a08afdfe3a
  - [bpf-next,v4,3/3] riscv, bpf: Add 32 bit atomic operations to RV32 JIT
    https://git.kernel.org/bpf/bpf-next/c/a1b37972efc0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


