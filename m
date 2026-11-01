Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571383;
	b=qTk6wXAbJytwNNaH3qZa9q6X45H97lzumhfY9XDT3E5It+B9UN5DZiok7tjJsMkUs2PN
	 4ZeVGp28TRZ0mlHt1/rQfwbqdMzkuBep4D1V1ur/VuQeL/dN0kF92Eaz8yioJTVigC5g4
	 EuTcGrcMX6BQNE+T64/co+Sr6T2kIxB+Nkbg/+sJnECmM+QceU1w/0Irp1nowcwD0C8dU
	 TY3kZ20Bbsjb1zNh68gBYwJhl8RmqEhE/USwts/oeAEQXYpn9BbeZZk/1QQ+G/nxU7XJc
	 piRDCu6dHoWO6/dPp7okSNTJyiKaixL4inaOFzCrcijxW7Cdt44AliVGNSMpnVly3VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571383;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=nBsBcIeqHzTwHRwp6mbkSbzQ3uarBYC6aAPPLwIw/OY=;
	b=E9BrpNY7+Jy02GXzYOSHpbw+yI9xz//GqFPlQvm4+jk2yIqjjE+AecgxRPWFtZgRfECd
	 Unm1yJFZsi/CVmFpO649xf7m3/L3ksjRf8pYMqAVie6NPXEFPs+cnoD/oNww/wY7f8+2M
	 sskr5THUxpenFu0mvGDU4Kd6jMNwQhSVNGN5dm1IuOdxXY3cUWFb2IcTL33A9LhWiW3qo
	 Ga03NLawnztUI0nm5Cgb8l+fV5eB5fFxcfAcbplddmHafFOJU279/9WhqM3/mRWIVxjRs
	 1Ql1gaz8V95FaQh7tJBHhIE4n+49gO4iRuees7EoUFWfXUino6kiEeSkoP47/BHRb/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ge8BG+tp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5012A606B9E8;
	Sun,  1 Nov 2026 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ge8BG+tp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55C31F00919;
	Sun,  1 Nov 2026 22:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571382;
	bh=nBsBcIeqHzTwHRwp6mbkSbzQ3uarBYC6aAPPLwIw/OY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ge8BG+tpekAEo+TZQBgfvGTUGoOFRmuU0sqtbDWsBG1E1UTg6b6J4VfGfd1nqF6Z3
	 dxC7UhyiuirH66kwoe6ZI2qNpzGHPuX1TBFNPb8GqXg1qOAm0/ttZHT9HosQHtZslN
	 woMOtTaVXoa+A7tit4xlZnferQ0ALwKyjKubejIZumpnFlfQ57e5/xfu57Txo3PjF1
	 xErzRFsTYOfQQ6ie+PDBvSFDcBMJBHtcGvirHE49cePICxmiiKRheaTMIGUH9csnus
	 ZfNKmVre6h+JiizjeTSaE/VZJvWIINzapMcyCqc/+GWYS8ZWV2ONnMz3chGRKabrrj
	 6oAV13ouliW4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA3C938003B8;
	Sun,  1 Nov 2026 22:16:22 +0000 (UTC)
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
Subject: Re: [RESEND PATCH bpf-next 0/2] riscv,
 bpf: Support indirect calls to bpf subprogs (callx)
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357138129.2624073.3730426403768307422.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:16:21 +0000
References: <20260930064928.1909085-1-pulehui@huaweicloud.com>
In-Reply-To: <20260930064928.1909085-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: linux-riscv@lists.infradead.org, bjorn@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, puranjay@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, pulehui@huawei.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 30 Sep 2026 06:49:26 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> This series implements support for indirect calls to bpf subprogs on
> riscv64 and enables the corresponding selftests.
> 
> Meanwhile, this series also resolves the test_verifier failures
> previously captured by riscv-bpf-daily due to missing callx support [0].
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf-next,1/2] riscv, bpf: Support indirect calls to bpf subprogs (callx)
    https://git.kernel.org/riscv/c/1cec0b70fdc6
  - [RESEND,bpf-next,2/2] selftests/bpf: Enable callx related testcases for RV64
    https://git.kernel.org/riscv/c/530dfafc6107

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


