Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823011;
	b=aBhtrGdHXv0BWETeXIcVka3Yyt1PR5joLDjrxTE8gKuw+f4u4nNNduhnUR2EgI6dpfa8
	 pBL0tpvfrDV9GFSe2Y7uttIkNh36N+26iUDv2DbQpdSuHC/PJkbPSB9GHcwYo+u9F6c1/
	 0p0cnvDpftWJNP4+wAg/BS1ldfgXzKJG6m4uMnm1EGf3QOVLWtXx0k3x0esOIzlD1/EuV
	 AjepP2gh1T7s86Jdzmf9cs85pL5HMM9jqFbnqzWMPwz+DEfFCMQq1K6QXMKpdi1s88ISR
	 8TZzDVoUNyLsELrsR2r1QkjVmk1p/RUp/qkbEhov08MneEgIaeYhCUbgHOGFviEJs5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823011;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=qSE7WfIMifDdTWH2DkLt+4YrcWt7MTQkNz951vsu0P8=;
	b=o+unOtZIXOKRqLgwiHqrstaHvNSSdRYwurOsMuU/9ptOfvqQiXmCxzlsvO9Yt0/vUWpk
	 Hb9RIeIJTZzTF4PwT5lOzgDVbiTbjTXOTGEdArLCw2Fk8wEMAWyUMO17nUVjHsOYcWLR0
	 v/11T4W9oVCbSX20JjAGwY3Hq338umBjQYue8vFIWRvn0VyVgT1hQ+RWExs1bOWaOZTCS
	 HBNLssKfgs6ekdBCzioAh+vf5yX4TzdPwZ7XYImhkzYwQmBYSwW6YCsqqqPIN137NXwGR
	 4wJHxLQYB1z8Or6+RpAOLILrIszdgWrFoLcTUi+tCx7mHZ1KOWi8NxevWx1ph8EnYqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b6xZMf/a";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4451E6070F39
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6xZMf/a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47631F000C1;
	Wed,  4 Nov 2026 20:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793823010;
	bh=qSE7WfIMifDdTWH2DkLt+4YrcWt7MTQkNz951vsu0P8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b6xZMf/aIDL/GcbMKwQ8EdRUX+Tje7Oo0gV0pnTIAKnktI4kGNwRs2Uenla+D4AsK
	 99dB3Rw+Wdy7HXkdwO8aDx71rzEyL/ETWbAXsnZ+hDOhIU2tQOhYuRtOzk6Yqc1fA4
	 Zkqtc4WuOPG7qsk/kaF4jjn1pPc0trgs7Smi8aifokXQWaTuVpNLMoX3Sy2ahaRc0y
	 MBQ7/piE+Xm7tLPIewbnDlYn465Azd+PdEwUWHSC+PdOZP6Xh75gQzg3t6dXp366E3
	 xxZctrlbvYEtQs2fuGkPcmr/SE5cY8i++RXACgxYf94VbAdlrzKzppCeGgLJ8NhOpv
	 GhggdheWl2dZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA241380046C;
	Wed,  4 Nov 2026 20:10:10 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v3 00/14] bpf: A stack in arena
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179382300955.3179385.15900582877179884287.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 20:10:09 +0000
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  4 Nov 2026 01:23:46 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The goal is to load Rust programs as rustc and LLVM compile them. The test
> programs are in https://github.com/4ast/rust-bpf
> 
> This is part 2 of "bpf: Stack in arena and a verifier that joins states"
> [1], as a series of its own. Part 1 is merged. This series does not depend
> on part 3, and it does not change the main pass of the verifier.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/14] libbpf: Make arena 4 Gbyte when max_entries is not set
    https://git.kernel.org/bpf/bpf-next/c/a3405322d2f2
  - [bpf-next,v3,02/14] selftests/bpf: Test the default size of arena
    https://git.kernel.org/bpf/bpf-next/c/e7ef59089c74
  - [bpf-next,v3,03/14] bpf: Treat addr_space_cast of a pointer that is not in arena as a move
    https://git.kernel.org/bpf/bpf-next/c/8adaa3791632
  - [bpf-next,v3,04/14] selftests/bpf: Test addr_space_cast of pointers that are not in arena
    https://git.kernel.org/bpf/bpf-next/c/6a52d60c0932
  - [bpf-next,v3,05/14] libbpf: Support .bss.addr_space.1 section
    https://git.kernel.org/bpf/bpf-next/c/f9420eb3626e
  - [bpf-next,v3,06/14] libbpf: Relocate pointers that are stored in arena
    https://git.kernel.org/bpf/bpf-next/c/32d56ccb1d30
  - [bpf-next,v3,07/14] selftests/bpf: Test pointers in arena and .bss.addr_space.1
    https://git.kernel.org/bpf/bpf-next/c/66c4a3b9bf82
  - [bpf-next,v3,08/14] bpf: Introduce bpf register BPF_REG_ARENA_SP
    https://git.kernel.org/bpf/bpf-next/c/51a641232390
  - [bpf-next,v3,09/14] bpf: Add stacks for programs to arena
    https://git.kernel.org/bpf/bpf-next/c/df664dbd6e98
  - [bpf-next,v3,10/14] bpf, x86: Add BPF_ATOMIC_LOCAL
    https://git.kernel.org/bpf/bpf-next/c/f02597ebe9dc
  - [bpf-next,v3,11/14] bpf: Support BPF_REG_ARENA_SP in the verifier
    https://git.kernel.org/bpf/bpf-next/c/c3c27a5b489b
  - [bpf-next,v3,12/14] bpf, x86: Support BPF_REG_ARENA_SP
    https://git.kernel.org/bpf/bpf-next/c/1298d494a71d
  - [bpf-next,v3,13/14] bpf, arm64: Support BPF_REG_ARENA_SP
    https://git.kernel.org/bpf/bpf-next/c/9eb00cb851d2
  - [bpf-next,v3,14/14] selftests/bpf: Add tests for BPF_REG_ARENA_SP
    https://git.kernel.org/bpf/bpf-next/c/cf8e78c1073e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


