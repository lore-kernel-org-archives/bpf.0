Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A0B2E7165
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790304677; cv=none; b=iU5cKRr5J9mnkeikt5jav9vw2CJDMPDsEUcvpfeStZ67pXHJnUgO/8ati/X/00vTq863Y4ZImTRrqd6cCpkSVZmhNOk6mQInkVWnqrmo5PN5Ap9hjat4RBvsCUc3FVmKgPA4oaUt9nXlrj5GiEZR6jMdAGNBbz0fVujXL+lIog8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790304677; c=relaxed/simple;
	bh=c4coVCk0WLzGgljmfLc6YCQ913k5mbLoRz8fXwdW1bs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NZUXUkqvt28H2zSuPKhtVWNlDAl2AWAWYVPYdcdkhckPETSuAaHvZlpLLG3i8jBH84QD7N9PVfGPoXqWibC3VltGS4wjWfCm97qP35y6LSNYnyNQj1QsLVkr/mtDfZW/TXn90LqIBv9+UXyToxiHwqdsBQhGte4By4JndMRFP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THvGYgkf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THvGYgkf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D983F1F000FF;
	Fri, 25 Sep 2026 02:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790304675;
	bh=mIEADOkPAGxwyyZeEek7mjAaK56HBMb6Rg4zVo96Sq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=THvGYgkfAX46rZtakIE2pZ/bQw4PRhKs3m7zliBax10qI5OB20jU/3/U6TwX9+VhL
	 jjts1kh/Bs3/qlZrCkbgPks7+wzTAv+YeOJCObzGkmoD1j8iWJP6qFIfZ4H6BC3RqC
	 Qvc/nMyqQ2sW09ljH/nADl07D5rZK52snq5AVNNU345slQ65prsjr1fRfXJANJ91C/
	 drZj5pSiwtkPojtouqhrroEqbSOVyzCuN7DHGBGFuo+ERTxzJhGg+3CnAovsxlpBmh
	 Ay6PLqylHDzOjqQR1C0JL/2bfDMMy7FBYw9Q4QlyZzlm3wMfP55VUfTFyoaapriOHS
	 7x3M9H234zftA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939823A566F8;
	Fri, 25 Sep 2026 02:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix overflow of jump offset in constant blinding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179030460440.2295241.4235988162109985582.git-patchwork-notify@kernel.org>
Date: Fri, 25 Sep 2026 02:50:04 +0000
References: <20260924182353.277516-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260924182353.277516-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu, 24 Sep 2026 18:23:53 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> bpf_jit_blind_insn() rewrites 'if rX op imm goto off' into:
> 
>   AX = imm ^ rnd
>   AX ^= rnd
>   if rX op AX goto off
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix overflow of jump offset in constant blinding
    https://git.kernel.org/bpf/bpf/c/ad139384ecdd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


