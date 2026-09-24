Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A32931DE;
	Thu, 24 Sep 2026 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260278; cv=none; b=ZsjP3s5t/vMgzZtvGg0v7jnUUJ3UDBG7aVADBIMKqNU9/pXx/609Tp/XG6OcBf3KSPKXoriUbdAUQQ0X4kvkH97jvhlKFj1UGVC671lov29fcKQVOt0MLLiroIPnRUg9RhXJQY9ea26g+UueKoEwmIPnPfrsm++G7iXI9Wnqxn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260278; c=relaxed/simple;
	bh=ngp6nqseZTFc/LE2NeCfcUunmIIP/m6og8cwvXWoyZs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q6uEUGixMDJGWR4UN8uGF2Iyodr8CQert4zj6cJl5VjpSCSvmgekBxxgWZkhbJaF1MFL7X9MsPQZhLW6ZQET4fEljWwP1ZrCOTBZxX5mw/QTSSZvxMoAlaRK9bw9VSOkPRHg+zpFBNIf5L9ENLMHal1Ppum9FAyCIpFcYvBZPCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnTx6/B1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnTx6/B1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B60B1F000FF;
	Thu, 24 Sep 2026 14:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260277;
	bh=CyqTXHBnBgDvWSHHD1p6YOrcTxq/O2Gx3MDF1gtQ7vA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UnTx6/B1VnJACDVgiHEP3Smh74CaI0TCJr4Ji3FF7DflO5HB/Z+R9INSHj9kv/Z6A
	 P5cHS4gNOwYlJAaupHmwrVixndtRRScW0DqvXDT4UhQJaPI7nioTKnUqi9M5UshH54
	 W9VxtsCSSwRin+BKDW6XMHIQxEc5FH1VaSsgh66JQQKHxyup4Q2b7xe9hw4kY6VdHW
	 Zl526Zj+dEzO55tvT9cMXl/di0Dvz/Ml4cXLnY8sM3vP/0AIcrdWzQFcOmuiIzRBx5
	 O4gbK74MUG29GvIPs9UyqWepVyREW/vyOrwWqQLj+Lag/+lt9xV2ywwydd5b+jPV27
	 TvtezbQv+9/7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BDA380A965;
	Thu, 24 Sep 2026 14:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] bpf: fix per-cpu initialization of a BPF_F_CPU
 created hash element
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179026020640.1578080.12631069595950386099.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 14:30:06 +0000
References: <20260924102321.2120434-1-donggeunyoo.kernel@gmail.com>
In-Reply-To: <20260924102321.2120434-1-donggeunyoo.kernel@gmail.com>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, leon.hwang@linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Sep 2026 19:23:19 +0900 you wrote:
> A BPF_F_CPU update that creates a [lru_]percpu_hash element writes the
> named CPU's slot and leaves the others holding the recycled element's
> values, so a lookup of the new key returns a deleted key's per-cpu
> values.
> 
> Patch 1 zero-fills the other CPUs.  Patch 2 adds the selftest: the
> existing cpu_flag subtests always prime a key with BPF_F_ALL_CPUS
> first, so the create path is not covered today.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: Zero-fill other CPUs when BPF_F_CPU creates a per-cpu hash element
    https://git.kernel.org/bpf/bpf/c/c3a66e5f5bab
  - [bpf,v3,2/2] selftests/bpf: Test per-cpu initialization of a BPF_F_CPU created element
    https://git.kernel.org/bpf/bpf/c/3422808f4e95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


