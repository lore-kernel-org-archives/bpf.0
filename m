Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B13290DB
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575831; cv=none; b=je4alDZ2++bjDB22hJaeZKK9DFhy61O4yx2NnxQcqhvC9Ut63ktD1++RCWchtZYh7SqqygC0ctw783T5+5nwIcPqw8kNToww2XH9IrdjLE3NYGEcrUeWcin2Xl72lXthHA33wXpeP3Ez9plol2faDVvmnBM5FmJ+jin8koppN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575831; c=relaxed/simple;
	bh=5UftzyRGI0gr4MUF3SvpdwOEjeI7Ms51fHbK5Ho/cLA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cKVNBCqNR2TAxTKqjMsHpJDwnzNVqe5NmzJKjA8Rp+uyL8ZkxxPpeiZC8RHbaKqwzwgN4JvelodINUQeKXhpNFOKZKApytbej+EumQvA1M2LbhLPbc1/EVfeXbsDDUhdQatjWuhZSuGcGeSY0lrFu+2FONVz3pNVEy7Q+MAGyhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdaRUNb8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdaRUNb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B1EC116C6;
	Tue,  7 Apr 2026 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775575828;
	bh=5UftzyRGI0gr4MUF3SvpdwOEjeI7Ms51fHbK5Ho/cLA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BdaRUNb8ne3U4oSOnawAF1f4Xr9Oz8ctbrDb23Z9Pf+33VQOZV/fdPhRjT54DTLsq
	 Y9r2in6pJlco+5d3HmPfru3hE+lr9U4C9W72YUDuVwD2TMxxUUfiVv/jDRbvKDq4u6
	 7AqP2jsZXD8iLAszeYcUMlItnYWbjbdXXJLX3RLUaezRfOoyJUv/bv8chyXbX20trd
	 o+fZHbFL77O+rNzoo7TVKElLdKdGP3UEJdTJLwn+GJNyBAbmz/pEuzJkP5pd5t+F8v
	 Zt6q/BuVUamheluseDU2C4hF8HbdfDoIMbKLeLBDx1YODYrWocDLFDqKeeEb8Mzyom
	 WOZ3TBGMGY2hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F363809A2A;
	Tue,  7 Apr 2026 15:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] bpf: reject negative CO-RE accessor indices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177557580655.4040010.4692194924809913504.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 15:30:06 +0000
References: <20260404161221.961828-1-bestswngs@gmail.com>
In-Reply-To: <20260404161221.961828-1-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org, xmei5@asu.edu

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  5 Apr 2026 00:12:19 +0800 you wrote:
> bpf_core_parse_spec() parses CO-RE accessor strings with sscanf("%d"),
> which accepts negative values.  The downstream bounds checks only test
> the upper bound, so a negative index like -1 slips through, gets cast
> to u32 0xffffffff in btf_member_bit_offset(), and crashes the kernel.
> 
> To clarify the kernel-side concern from v2 review:
> tools/lib/bpf/relo_core.c is shared code -- the kernel compiles it
> directly via kernel/bpf/relo_core.c (#include).  So the fix does
> apply in the kernel's BPF_PROG_LOAD -> check_core_relo() ->
> bpf_core_apply() -> bpf_core_parse_spec() path.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: reject negative CO-RE accessor indices in bpf_core_parse_spec()
    https://git.kernel.org/bpf/bpf-next/c/1c22483a2c4b
  - [bpf,v3,2/2] selftests/bpf: add test for negative CO-RE accessor index rejection
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


