Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D6501F20;
	Fri,  4 Sep 2026 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541284; cv=none; b=pFk1XrI8vYQDXduWUvtcHdwNcpYtmNzqN0/wYHIEKZirYNvAyBKr9BSbK5bFKbz6I2aAcTHeoVTd9/KAcV0ktJkknHqJZFhV36OnyKDCtrk4t4Cq7uTC7WvrP0eao7pKWFrQVFmXW3Xm9aJ+YBX6Fe+LFqbVPPRpwP5zfmd0cjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541284; c=relaxed/simple;
	bh=PBIJm9PGJA2rg5PfzVOojx5Pj+TrNJKVHgxXlXEh0to=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FLNkb27y+L3ccUpTEv7VsNk+zc9Fb6fvpKr4UP9l0sj5RYTbjmwirTVLAmnJWl92vtr4RcD0HMQRpBuXW70Kr+cB6dL38BJ7Yk8U2qzZwut5Qqf12ByObGfjGExTLvTdOtUlCNAR0G3qrlJa8kH+DioepDlDp079r5+XWmenwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0y1AtdM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0y1AtdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362761F00A3D;
	Fri,  4 Sep 2026 17:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541282;
	bh=ZE19tjQV++uxCuX44HWypuHxk/eqCnq3HtKWU01h7DM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=C0y1AtdMBxKbuKaUt5kBYLmcia/QHwKUcsU/ED8eAtAX5mt3849WTczvRQEqYzDs6
	 7VEjM8JTis5JAHZjuueXmIU2+Vg75MeTdCXookJU5WIgyhd41wr2qta3VoTgOM0GU3
	 135+J48EeE/GnyNyC5UxG54pCeJIudhA2mSMfpZchAvso3B/k2Eq/2dHc/EYctgYCa
	 EGomYhk77rIreEVF1Dq66pC5KhVnyr0N8ktiUtAccwW1lBfl1khrvDOasdXVUVj4gC
	 fyWdRjuUgqYG/Dv1HXXabCy/5TgW0mFVio4uvzOlno6BQSnyg50Art2Qlgd+KPfn3u
	 mvCRQIcKLK+Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 316603924A53;
	Fri,  4 Sep 2026 17:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v9 0/8] bpf: add support for KASAN checks in
 JITed
 programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178854122304.442795.2582545330493893301.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 17:00:23 +0000
References: <20260903-kasan-v9-0-2407fe99255a@bootlin.com>
In-Reply-To: <20260903-kasan-v9-0-2407fe99255a@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, tglx@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 shuah@kernel.org, mingo@redhat.com, andreyknvl@gmail.com,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, laoar.shao@gmail.com,
 ebpf@linuxfoundation.org, bastien.curutchet@bootlin.com,
 thomas.petazzoni@bootlin.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 03 Sep 2026 15:51:29 +0200 you wrote:
> Hello,
> this is v9 of the series aiming to bring basic support for KASAN checks
> to BPF JITed programs. Among a few minor optimizations, this revision
> fixes some wrong kasan instrumentation on some unwanted stack access
> (stack access ending up being instrumented AND targeting the wrong stack
> offset). To mitigate this risk further, this revision introduces a
> systematic KASAN check skip when (addr_reg == BPF_REG_FP || addr_reg ==
> BPF_REG_PARAMS) in emit_kasan_check. This secondary check (on top of the
> non_stack_access flag), should hopefully prevent the issues raised in
> v8. I've also reworked the emit_st refactoring to realign it with
> BPF_STX management in the x86 JIT compiler, as the "arguments on stack"
> feature made me realize that it could be kept more symmetric with
> BPF_STX; so I've dropped Ihor's Acked-by on this.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v9,1/8] bpf: mark instructions accessing program stack
    https://git.kernel.org/bpf/bpf-next/c/d02bfbc49c8e
  - [bpf-next,v9,2/8] bpf: add BPF_JIT_KASAN for KASAN instrumentation of JITed programs
    https://git.kernel.org/bpf/bpf-next/c/90769ad233ca
  - [bpf-next,v9,3/8] bpf, x86: refactor BPF_ST management in do_jit
    https://git.kernel.org/bpf/bpf-next/c/b3b45e9d72df
  - [bpf-next,v9,4/8] bpf, x86: emit KASAN checks in x86 JITed programs
    https://git.kernel.org/bpf/bpf-next/c/92b73b708b17
  - [bpf-next,v9,5/8] bpf, x86: enable KASAN for JITed programs on x86
    https://git.kernel.org/bpf/bpf-next/c/cfc821c029fd
  - [bpf-next,v9,6/8] selftests/bpf: make cmdline_contains stricter
    https://git.kernel.org/bpf/bpf-next/c/040ef1f8b02e
  - [bpf-next,v9,7/8] selftests/bpf: add helpers for KASAN in JIT testing
    https://git.kernel.org/bpf/bpf-next/c/9123a4d4c4f3
  - [bpf-next,v9,8/8] selftests/bpf: add tests to validate KASAN on JIT programs
    https://git.kernel.org/bpf/bpf-next/c/2cbbb035977a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


