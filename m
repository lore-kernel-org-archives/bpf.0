Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655407;
	b=cdxEB1qBvS2XCAc9lupcxBhNMPnhmG8788Zkoguunys9VBHv0CbaszpTLInur7gyUoEN
	 rBLsGotFfPpVUwK8RZ3zngqU6JfgVAQuuOtih1i9jMec6iuwc/NQHaC8lXpjRmdV0Ynb8
	 npateh/z4laay7tk/nZLEh5akfhu3pRTGXfdwC1cFczb2QSfMSkGA8Mc0M6aqHmqfnB2p
	 K2+S52p4zGtjdNgi00gRa9AhZVukgsDa8aHg/f+baFyj7C7y0roekp/+9952tkamrqF3Y
	 iPGBVOSMs/Y1mRK5+TGds4+HksZ9OwNqI94fJNFgWn1QEeMLd7hbSINa6e/bUSFa6kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=n3eDNRFNkis7rRhskdmMxswZGudGLnk3t4gSHbRSwfs=;
	b=LHuazlSAZCvU296RcAzyoBPjw2dSuUFVI/sfDfMyQ4Jsxty/l3H/ZPX+jirT5sxBF0UX
	 d/xEIPBVZaZk6wMJ+Q9gxt4tqDXFJiCYQgonP7dkNZXVExD5OnGu79I4TEkB04mw/TIE+
	 8zdLqD+TiN37C/AmYfqNmEeYdhFJPJ/WEcsbJ7tXwza4E36p9FzLElN0VUL3/933TM6lC
	 bnNOah385TqUgJ52mxBYF1v+l5wbo49IFzWUtLWZVt+yBoL5tmsDD5mgBTxgOV7LEp/rn
	 wyMgi/4Ev/sJZzu0NbftCH+ax8FIMZnEMIvJZqOnR7YmwNEuvQj70dxIMjCNPzIMM9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bc1Oroi2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E3B606A68D;
	Thu, 26 Nov 2026 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bc1Oroi2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DF61F01563;
	Thu, 26 Nov 2026 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795655406;
	bh=n3eDNRFNkis7rRhskdmMxswZGudGLnk3t4gSHbRSwfs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bc1Oroi26uPkyEsALHrZUf5G9DEPdcDpYa/lyMgb607YBDOuZ//wSlKHBzJpQjn6Y
	 p8alsnXQHbNbvdhO72hsGUsytiZeUBH8qJjAw111jj5+yDRQfVv8h30of9MMg13l0C
	 pcSevcG5b6dL+d8VHazb3+yMmE8zscJF8VVQYtC2+NYPWAhNcOxcgv/GYiwbZKAYJi
	 6NPKAUd999ahIHMX7NvnXDvcOgmujxdH+vhKcag0isBo5rnB/giQqryuuiBGTJBsgh
	 Pdijmke+Hrxa7o65FuNgL2TLc7spDvLpoOzkoJCy6azRmogyq5BjcwDRz2k9OJERuG
	 11+Hpv7iT6olw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774C43809A24;
	Thu, 26 Nov 2026 01:10:06 +0000 (UTC)
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
Subject: Re: [PATCH v4 bpf-next 0/3] riscv: bpf: Add BPF private stack support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179565540527.1427026.16404193754358900267.git-patchwork-notify@kernel.org>
Date: Thu, 26 Nov 2026 01:10:05 +0000
References: <20261125122126.939-1-cp0613@linux.alibaba.com>
In-Reply-To: <20261125122126.939-1-cp0613@linux.alibaba.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 bjorn@kernel.org, puranjay@kernel.org, alexei.starovoitov@gmail.com,
 eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, pulehui@huawei.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 luke.r.nels@gmail.com, xi.wang@gmail.com, shuah@kernel.org,
 rgbi3307@gmail.com, guoren@kernel.org, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 25 Nov 2026 20:21:23 +0800 you wrote:
> This series adds private-stack support to the RV64 BPF JIT.
> 
> The verifier rejects a struct_ops program that requests a private stack
> with -EACCES when the JIT does not report
> bpf_jit_supports_private_stack(), and sched_ext requests one for its
> dispatch callback, so no sched_ext scheduler can load on riscv64 today.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/3] riscv: bpf: Add BPF private stack support
    https://git.kernel.org/bpf/bpf-next/c/15a0f4bb0dd5
  - [v4,bpf-next,2/3] selftests/bpf: Enable private stack tests for riscv64
    https://git.kernel.org/bpf/bpf-next/c/02f7413abb36
  - [v4,bpf-next,3/3] selftests/bpf: Test a private stack together with stack arguments
    https://git.kernel.org/bpf/bpf-next/c/805728c7feb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


