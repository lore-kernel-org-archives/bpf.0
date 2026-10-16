Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8B73BE156
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792180810; cv=none; b=sVpT6BXTicuSrIpJGaU4J64ihQD5DxR7nEOnkwSGD3jv25EjoLNivvAZqxQohVXlE1Xu0exG27WFsy+hiJHClhZt/KuC/J+/N2kBfZuITwHAyvE60tu60PBQ/M83CDNbrJXcyt8/CbHb8qvxth9CcUnUd7Su5jmjCi9RJTO75+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792180810; c=relaxed/simple;
	bh=2kKvfOkA+EEdZGoW4I/kHRakmftdIz6eJta9PcfIWWw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bzfouxuuo0W0IBcvDSPlXfBRO4YI5T/jLWE4B7SVpJR2Gibz2obcAhWpjhxwiPNkND6mrQmsWBBsnOfzldsMUdOGwhO/5a7z2ufg9QnSWAPKLROoOBZ+y7En5PyPzwCH3d1bdAn4/quYTcdziuSTn0+YHN1oLstwuGV85ylCLNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlF8tHCy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlF8tHCy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03E31F000C4;
	Fri, 16 Oct 2026 20:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792180808;
	bh=QaBhLXM8/qCyiwbxy1BfsYLsXTT1Yz28BZVp39UlkVw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VlF8tHCy389I9bc3VL3OtgdnJl52ByTPPnB7rZ6nn9T9oKMxrtMz4TBDbVM7sAda3
	 d1lNAiON+Esea0Le+vIcQfROAc2oN2bQ0Dx1LtYMafzHp+MKUDScRBAXBnItnMLHQY
	 ss8v8OFQ4whJqTtWiDnVt8H+tRZT6vk9KFMzViQs1uTide/r+hpN7PARC4WZwdtei2
	 vJ852/pNPoBYCd7TeZpaAdfWLlHQ/VLX8t1w6an0kwTB3j39dEEeqEsytG4t4RsneE
	 ixhir62Np9z7SIQ29lPANVrj/JOpmu7+r+zvlfjHEH7f9nGHxrL6dzURXCplM5E8a+
	 wQBx88cNc9dQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B442D380AA66;
	Fri, 16 Oct 2026 20:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/9] bpf: Follow up by-value struct and
 __int128
 argument support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179218080725.945731.309656099447652892.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 20:00:07 +0000
References: <20261016183039.1132126-1-yonghong.song@linux.dev>
In-Reply-To: <20261016183039.1132126-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 16 Oct 2026 11:30:39 -0700 you wrote:
> This is a follow-up to the series "bpf: Support by-value struct and
> __int128 arguments" [1], which placed kfunc arguments by the kernel
> calling convention in the x86-64 and arm64 JITs, and made the arm64
> trampoline place an argument aligned to 16 bytes: an __int128, or an
> aggregate holding one. This series covers what was left, and a few
> problems found on the way:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/9] bpf, x86: Pass a trampoline's stack arguments by the calling convention
    https://git.kernel.org/bpf/bpf-next/c/9f9c30435ca9
  - [bpf-next,v4,2/9] selftests/bpf: Test trampoline stack args in a program that can tail call
    https://git.kernel.org/bpf/bpf-next/c/6b26307ce697
  - [bpf-next,v4,3/9] selftests/bpf: Test by-value __int128 kfunc arguments at an odd slot
    https://git.kernel.org/bpf/bpf-next/c/98e46955064b
  - [bpf-next,v4,4/9] bpf: Describe a BPF function to its trampoline as one u64 per slot
    https://git.kernel.org/bpf/bpf-next/c/ab70d0d7f1b1
  - [bpf-next,v4,5/9] bpf, x86: Place trampoline arguments by the x86-64 calling convention
    https://git.kernel.org/bpf/bpf-next/c/0e6d7e9669be
  - [bpf-next,v4,6/9] selftests/bpf: Test trampoline args around a 16-byte aligned stack arg
    https://git.kernel.org/bpf/bpf-next/c/b68782116bfd
  - [bpf-next,v4,7/9] selftests/bpf: Test trampoline args of a BPF function at an odd slot
    https://git.kernel.org/bpf/bpf-next/c/9c6fc12a8e4e
  - [bpf-next,v4,8/9] bpf: Refuse a trampoline on an unreliable static function with stack args
    https://git.kernel.org/bpf/bpf-next/c/9b2e5136760a
  - [bpf-next,v4,9/9] selftests/bpf: Test trampolines on more BPF functions with stack args
    https://git.kernel.org/bpf/bpf-next/c/8395b4031881

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


