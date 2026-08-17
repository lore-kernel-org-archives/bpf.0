Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705673B14A4
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786993278; cv=none; b=pJOvPzkUvg0+//+sBNaKxzpJm980oy+XPH9TGLYZLgqJr/OYFP5ZiVuypUQUARTdXVObJVz5Se3ICsNUmp9gzIjHAkDMw+mP61AzS4AB7k69RXmZeg3avaqz+w1C9QgYUqCSmuHiIDbCO9VJLXePrnwvAVKDccgpRZC8yWerx4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786993278; c=relaxed/simple;
	bh=XXPYb+WTrSXs3ewLyu6VCRF1Uiq0gH0djF2by8MwFd4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iGrfywBeAZuCObeAmosvy7smLxwN4Z1uT/3Dvsf+lQ76X4MinQUaB2r1hFGf3T16uqjaEboYKAFJOIcMZH30Riet/m9ZTPT4JYVvZwMPgzqf+gpOsRpokqh5Ptqwylnt7ApZtPnUwtZ1T/4z8sMhsgSS2ETZ88mad4Rc9C2GteY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxmiKbVE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxmiKbVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2D31F000E9;
	Mon, 17 Aug 2026 19:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786993277;
	bh=ashqrK8PO+uEPAhC5seKDCgH6g8/giqgPSHIeQCDiLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hxmiKbVEWid7mZoU5MUat8SuhnCWtPlmozZw9hNk+XCD1un3LuHHEU7yHB0fTX+qI
	 hMmbejQ8T0dM6o0FwtURqp9B/NfP9z0l/FzdQR0d0tDRjB1Ps8w8xhyBwXwV3pNfvf
	 uGJFn7NaJVl7s0y1IjyzoMXfc3MU6X5DtGv9tmHjIZq2rEP3oaNJrE5ic0uQgH8mVE
	 dYleEuHw2LCTF+sySVdH/YvTHQB4xgAAkhzdTMtsuxGBiXpbNKJwKeHTOIsqwIQKyA
	 31OhDPgwcGf/ZQHWlsU3HEqc7cyRSkk0XLjB/cz/I6GS7r8nJlUj7E3ksBQTbx7unA
	 BUpQBXEf1g5yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A53926262;
	Mon, 17 Aug 2026 19:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/3] selftests/bpf: Add tests for pointer type
 merge at a shared load
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699322930.1691257.556829959500031509.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:00:29 +0000
References: <20260817141015.878071-1-daniel@iogearbox.net>
In-Reply-To: <20260817141015.878071-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon, 17 Aug 2026 16:10:13 +0200 you wrote:
> Cover the ways in which the type recorded for a shared load used to lose
> the BPF_PROBE_MEM rewrite which would then trigger a NULL deref if not
> handled properly.
> 
>   # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t mem_rdonly_untrusted
>   [...]
>   #242/1   mem_rdonly_untrusted/btf_id_to_ptr_mem:OK
>   #242/2   mem_rdonly_untrusted/ldx_is_ok_bad_addr:OK
>   #242/3   mem_rdonly_untrusted/ldx_is_ok_good_addr:OK
>   #242/4   mem_rdonly_untrusted/offset_not_tracked:OK
>   #242/5   mem_rdonly_untrusted/stx_not_ok:OK
>   #242/6   mem_rdonly_untrusted/atomic_not_ok:OK
>   #242/7   mem_rdonly_untrusted/atomic_rmw_not_ok:OK
>   #242/8   mem_rdonly_untrusted/kfunc_param_not_ok:OK
>   #242/9   mem_rdonly_untrusted/mixed_mem_type:OK
>   #242/10  mem_rdonly_untrusted/mixed_mem_untrusted_btf_id_type:OK
>   #242/11  mem_rdonly_untrusted/mixed_mem_btf_id_type:OK
>   #242/12  mem_rdonly_untrusted/mixed_rdonly_mem_btf_id_type:OK
>   #242/13  mem_rdonly_untrusted/mixed_mem_mem_type:OK
>   #242/14  mem_rdonly_untrusted/mixed_map_value_mem_type:OK
>   #242/15  mem_rdonly_untrusted/mixed_stack_mem_type:OK
>   #242/16  mem_rdonly_untrusted/diff_size_access:OK
>   #242/17  mem_rdonly_untrusted/misaligned_access:OK
>   #242/18  mem_rdonly_untrusted/null_check:OK
>   #242/19  mem_rdonly_untrusted/ldx_is_ok_commuted_addr:OK
>   #242/20  mem_rdonly_untrusted/helper_param_not_ok:OK
>   #242     mem_rdonly_untrusted:OK
>   Summary: 1/20 PASSED, 0 SKIPPED, 0/0 FAILED
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] selftests/bpf: Add tests for pointer type merge at a shared load
    https://git.kernel.org/bpf/bpf-next/c/78d8e5b375c0
  - [bpf-next,v3,2/3] selftests/bpf: Add tests for fault prone loads out of RCU pointers
    https://git.kernel.org/bpf/bpf-next/c/2b918fe2f11f
  - [bpf-next,v3,3/3] selftests/bpf: Add tests for a store on a fault prone qdisc pointer
    https://git.kernel.org/bpf/bpf-next/c/f79066c78402

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


