Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33E83AF67D;
	Tue, 24 Mar 2026 06:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332459; cv=none; b=UT3+55uANyZB/4Q1N3KVhCaEZgxingcYWSFWCNBeDebj0GCUG12b43jyKgEiTtTKUfj0ou00+cXZ6PHNFcZZN0meCIMXDFNRbbb2CoCwWeJnjvJaRQJrxF+K+R1sJ/E7t2q8zIDW7nNcWQ1DLrbhOwMkDATULH1978aIXngm7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332459; c=relaxed/simple;
	bh=TT5lBm7eFK7nQkMzbSkiD0ZpgTSP9lB6Y+WQbG92bDY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YMXgwM8t/3OiIimud45QgGsyg25k4WMfa/T/bR/y4ncGs23bt/vwYmGQ18nnLDaVbN4T2sYWp81I/sp0PF4L6gaOt0esPzAX7bYgi1+Hv7686ZAiw3El2z+DkRuDsCrpx60Mo7BTJS/CbajH7aWxXsAlzmhM+vzgQU656ohKNVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9IMZw96; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9IMZw96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587FAC2BCB2;
	Tue, 24 Mar 2026 06:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774332459;
	bh=TT5lBm7eFK7nQkMzbSkiD0ZpgTSP9lB6Y+WQbG92bDY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c9IMZw96dsnhrnQzBOWLIHmAeVarlxgOqtcYTgQpm/uaayVF5dZgHWnhRtPboRxPw
	 TwpVCDMR8eKbMqpWaVlUfIpq7EVXV3Oa8OT7E6GE4OSc/BWiJIX4xAyOn5d2eB6aXf
	 cclMkEnuVmUoHGXln6w5FP45wk5y1F4PoFP/SqH7j3l3+NpsnZVGbhsdRP452FTr+G
	 10BxTjY6AgjaVTTtPY5oL//mbl30alGLpHi5Eou7X0fQPj/PRwVIUTbXimCx5npmBT
	 wSAs+dVLF64bV2hzNChgy1w2Zj0nmMYAjwJBb6cZOOqtP1Egib4TNKHZxkIcMEFl9F
	 dHL3xPVZah3iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AC3F43808200;
	Tue, 24 Mar 2026 06:07:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] bpf: fsession support for riscv
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177433244748.469836.11256130083444261497.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 06:07:27 +0000
References: <20260208053311.698352-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260208053311.698352-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: linux-riscv@lists.infradead.org, ast@kernel.org, bjorn@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, pulehui@huawei.com, puranjay@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jiang.biao@linux.dev

Hello:

This series was applied to riscv/linux.git (for-next)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  8 Feb 2026 13:33:08 +0800 you wrote:
> Implement bpf fsession for the riscv architecture.
> 
> Changes v4 -> v3:
> * fix the build error
> * v3: https://lore.kernel.org/bpf/20260206122002.1494125-1-dongml2@chinatelecom.cn/
> 
> Changes v3 -> v2:
> * fix some comments.
> * v2: https://lore.kernel.org/bpf/20260206115823.1070354-1-dongml2@chinatelecom.cn/T/#t
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] bpf, riscv: introduce emit_store_stack_imm64() for trampoline
    https://git.kernel.org/riscv/c/93fd420d71be
  - [bpf-next,v4,2/3] bpf, riscv: add fsession support for trampolines
    https://git.kernel.org/riscv/c/35b3515be0ec
  - [bpf-next,v4,3/3] selftests/bpf: enable fsession_test on riscv64
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


