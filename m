Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4747F2FE;
	Tue, 25 Aug 2026 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664664; cv=none; b=CfkYhB+5HL0AVOmMgx1t97YbsUsErId73F9Bcn3o8vbzwjNll0gSEev1mO65/WqtiEUdNFZ8vpdkgduMFWNcn70ykzLS3iUr0824v/VZh5q23gQ3H0Tm1+XtHmqH4P+qJge6PSoDTtIx/VzI/4kgDNG9aCDmw4JNjdP5a0e0mTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664664; c=relaxed/simple;
	bh=liSnL5xg2UWbYzGRAbQx/sVfvr27yOO1SLDutZe8kdw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IlLgio69pPBzejWR4WqSAEIxTfamGbORetM2r0MYJVrbbztTvaTNFTftMWsw8LVqZoCzRW3I9PqpEFpHDXvROuyU3LIM9kwvRLMaM/NX5m3lEws4pBbQ5tvdyiNZ0PcJlGtL0fiZhd0lmaI1CmOILCQ24z06RgpwKNjwykPec7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wye9uPAe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wye9uPAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7942B1F00A3A;
	Tue, 25 Aug 2026 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787664662;
	bh=rcQPzWhwx3z2g1/wBrGHg1S/27bZzFFY1Azsw35SFwY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Wye9uPAeHlxC9LD0tDxAj47nlRGvpv364yZ5lV1OsCRylTaI2A2zzERoR95Qd5neD
	 7whQViXiD/RyCHH1JkggA+G35wt54fmIVm+ulIcywpCyo/rdviEmqPLJksMx6osV21
	 ROZIH4pkvvRnXOUoJ5xf4m67np4pgJ3uepA0gw/tCHK61GP1o6jayBYMa/PGF8vsMd
	 DXXXB6Kd4uIemWUhd5Q5ZYgTYf83aBZr0bjIfja2lLumJJpHbn2SlFBYtsejlzDUF2
	 TykDsdMcrdAQsGLzIL0A6Z5DokU6K6eP+V4FUJMKBNSexPzTvBLPqmNkeC2n7i2r80
	 ZSOYHjmOLKWIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BB23924FE1;
	Tue, 25 Aug 2026 13:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf,
 riscv: Add support for signed arena loads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178766460914.3460835.2556196507996630304.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 13:30:09 +0000
References: <cover.1787140923.git.cp0613@linux.alibaba.com>
In-Reply-To: <cover.1787140923.git.cp0613@linux.alibaba.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 bjorn@kernel.org, puranjay@kernel.org, ihor.solodrai@linux.dev,
 eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 pulehui@huawei.com, pjw@kernel.org, palmer@dabbelt.com, shuah@kernel.org,
 guoren@kernel.org, bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 19 Aug 2026 20:09:22 +0800 you wrote:
> Hi,
> 
> Signed loads from arena memory are currently unsupported on riscv64:
> bpf_jit_supports_insn() rejects BPF_MEMSX loads when in_arena is set,
> so the verifier fails such programs with "sign extending loads from
> arena are not supported yet". The x86 and arm64 JITs gained support
> for them in v6.18 (a91ae3c89311, eab2a71f3a6a). Since compilers are
> free to generate signed loads into arena memory (e.g. GCC-14 was
> reported to do so), otherwise valid BPF programs fail to load on
> riscv64.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf, riscv: Add support for signed arena loads
    https://git.kernel.org/bpf/bpf-next/c/b4757714cc63
  - [bpf-next,v3,2/2] selftests/bpf: Enable arena LDSX tests for riscv64
    https://git.kernel.org/bpf/bpf-next/c/8f2087a1b43b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


