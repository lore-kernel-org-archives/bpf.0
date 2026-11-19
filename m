Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795053005;
	b=wcEdq1TfzIJrqVCxFxRLOE9nE4AMPCyl+q3AVkpFqu8VrPmT3rF0HLxlOHT7+yPpsZqT
	 qikL2t/vL91KVk2nnsr4aNg00Oz22ftTsVaY0DKIBiOKEqaTplnwO4is+OkMy4Ro1haOJ
	 lIXgz3vWzNVSNWV9TpzURtdPEY8l5dlUaNsVCptjScX18nUFOD/SXQ13+HcIdUuYKnogG
	 MW0232DWd+YYszEtdBC6js0pw6ErvN23ABSmwYDkVdvyM9jfS+OqhoSHrxoipoLBfPM/i
	 4/HhbGNVeQxwxwei+9N9d2vse8600EgcoF3ZuKZ4kzy/tVz+YzBXGgsaUcc5ArKVDnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053005;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=wtiddpymwR5wAC6z/kTTykt5H1LKvVTKMrPJFDw58JQ=;
	b=5Bn5awhCaXH2J9j0ZW3OIPtl848bLBFBAas/EdD+vrbhJKm/R5BlS0nS9ehwXbRoWz8C
	 O32jqH5Gtv2St+FTmX6+KfI85zoqu0ExYuUlgUgEytlcxMofUUC+cSV2yPkeKWQCQkUC9
	 UGxtAJOY3fNeHvbmHKh+UgKFDN2DvwEu3JlKu4qiWBViL1UHt8My/27kJAd5D18KHG95m
	 jDKcvn84IXqXeRqO/XF7pDIPpidq1dcCsRGpXU6+taKUMQmvxvFGdHRtYYqZzLuYctBVF
	 BsxCiw8UfG/P0XyA8/9FryjXhRGaK1UM8CVnDquL5l5X7CliS1OyuSmZ3OmB45xC8OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJKIQP1c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E920606A32C
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJKIQP1c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484BA1F000C4;
	Thu, 19 Nov 2026 01:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795053005;
	bh=wtiddpymwR5wAC6z/kTTykt5H1LKvVTKMrPJFDw58JQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EJKIQP1cMXPK4bbJyAV4QDtN3pvAJKp5hsW2URBdghB1I4Vxig1R5WfLvcHOr6fVQ
	 bL1Mrwwp26oS4Yzyx8wVBM0RJIGufU6JkN6ToNKVmDbbx3+4gBVb9wfytq/EMMwtwa
	 2BZ5/SL7M49WdJh63FPq79t4EVE1DSBmwWt1RE3foiB6LTIL1SFxLNnIF1/mxTQgX9
	 drcan73rvlCeRGU4lEte/BiaLBDEg1s7g/zkKxQRBZNxIzrla4XW8nbcCM57i/SqV5
	 MwZfpSFHJQTVzahDfsIcAEk9jvNHmqCII2FYUexS7uyz0Uz6Z3/8w1DICRiGB9XWFo
	 lUj425yBpMvzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A28F3808210;
	Thu, 19 Nov 2026 01:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] resolve_btfids: Match the arm64 NOP opcode for
 LLVM
 24 in text_mc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179505300403.2710764.2827752503626665014.git-patchwork-notify@kernel.org>
Date: Thu, 19 Nov 2026 01:50:04 +0000
References: <20261118194030.4103149-1-almagui@kernel.org>
In-Reply-To: <20261118194030.4103149-1-almagui@kernel.org>
To: Alan Maguire <almagui@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, a.s.protopopov@gmail.com,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Nov 2026 19:40:30 +0000 you wrote:
> PR #170968, “[AArch64] Treat NOP as a separate instruction” [1]
> gave NOP its own instruction definition; LLVM 24 decodes
> "1f 20 03 d5" as the opcode NOP. Earlier releases decode it
> as HINT #0, which is what the arm64 table looks for. So the
> test of the nop fails, text_arch_init() gives up and a kernel
> with CONFIG_BPF_FMODRET_SCAN=y cannot be built:
> 
> [...]

Here is the summary with links:
  - [bpf-next] resolve_btfids: Match the arm64 NOP opcode for LLVM 24 in text_mc
    https://git.kernel.org/bpf/bpf-next/c/f8c00958c5b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


