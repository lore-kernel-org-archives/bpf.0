Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740809;
	b=ic8VvliphqCXeQXFlXKAWVDzgXTgXZsbL3YDG2ZiD9DSO4BF4lqhNenPbnFNGvGUM/Uc
	 pnCzpfhfQcZJzPM6ZkukoT/9WWebp2PqSHqNj46U3mpSUtewqAgBF2B9l54rtpWEzszEF
	 JUJK6fQ48FCGKEp+ImrrIhd+6rES1yKyrpqfJvw4nu6CgGL+aqx0Y/w+0tYA8EPBFB+OX
	 DDVSGi0SptQ10cKqeg6U92XbrHTONQkhvMPr9DVTatwGXFMgrnqoAVni0XgfIDNIm61Qw
	 xwvyPV5W56zbLQEyM5StdNc24k5h13XHUi11GUw3pg/iqg+ZfdTCuf7jZIYEZg7e9fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=C/5YYMN2ZgdbpmSIHlvzQMkG6vvXS4pBNreZkDhVc6o=;
	b=gu+EUSZFFBdwtb94D0a1xoaze1h0YRDDifLu+pVFZpz6hcLSXNlVss7KN9MUWVhTuiY3
	 Ig5Oe5fGrFBRf6BGoDZmMek+gDazNVvIcOtEniTyvUjtSVCa79s+i7ZfOlUyRIpWozYTf
	 SY0NgHOxnq1znCE1zkAZrGsa+QqytpCE6pP9RAjr0X9n4a3MaRSnoqEuPsUBEk+ku5/Dj
	 w4mC/Acsl+LqAzJailEPJ5BHTRP1jmOumkuiF/tS12Ty5m5e7njI02PKfWpEY0CnSHY8y
	 WJrxB5S9gU8SRAOOUofi5DJGF/K5OFMCMg9YE94KVuVGrM9thzt9vdvfLjvpM5OdIiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=in3LaZXP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080E1606A324;
	Tue,  3 Nov 2026 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=in3LaZXP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBCA1F000C1;
	Tue,  3 Nov 2026 21:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793740808;
	bh=C/5YYMN2ZgdbpmSIHlvzQMkG6vvXS4pBNreZkDhVc6o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=in3LaZXPDcQqZ7E7vWB0kFun9YW4/Dm30Sv4NjHnClWpuTdygkSgxUaffyzZNduO4
	 LSSiTsFb8CJkhJ7wwupKGeuPEHK21LiSZUT6XbRkf5bPA+oTCpS9mQXDxGztrPSz61
	 dBFbvQ5Zpyu0bV7yYntt+iFwMwVa+wJ/I1Lx2YxSjTHa1s12/12kEbB5w/Mj6Vz+gO
	 XdZfL7lhfMTGOwLkAIPBAMq3oGEb8SF59Q2SBgi9qlvHclxBpCEINtX2mw5JrR4r77
	 J36zyjrVURv8pEn4LMPr0Z/Lshi199wTQyyC3NYCw7UWWXMNhfzxtroPSuxMmMOmdT
	 AFZYyKR8fuFbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2DF391B0A1;
	Tue,  3 Nov 2026 21:20:08 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v4 0/8] selftests/bpf: let the arena tests build
 with
 GCC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179374080755.1885738.6613699311027745325.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 21:20:07 +0000
References: <20261103181816.254686-1-vineet.gupta@linux.dev>
In-Reply-To: <20261103181816.254686-1-vineet.gupta@linux.dev>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, jose.marchesi@oracle.com,
 david.faust@oss.qualcomm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Nov 2026 10:18:08 -0800 you wrote:
> The arena selftests cannot be built by GCC today. Three separate
> build failures stand in the way, and they are all hidden rather than
> avoided by the __BPF_FEATURE_ADDR_SPACE_CAST guards wrapped around
> those tests -- the moment a GCC defines that macro, which is what the
> in-progress arena support does, the guards stop hiding them and the
> build breaks.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/8] selftests/bpf: Build callx tests with GCC that defines __BPF_FEATURE_CALLX
    https://git.kernel.org/bpf/bpf-next/c/5b127a2d9d44
  - [bpf-next,v4,2/8] selftests/bpf: don't pass clang-only warning flags to GCC
    https://git.kernel.org/bpf/bpf-next/c/a74a26a8f284
  - [bpf-next,v4,3/8] selftests/bpf: make arena_base() opaque to GCC's -Warray-bounds
    https://git.kernel.org/bpf/bpf-next/c/2775ec48ecaa
  - [bpf-next,v4,4/8] selftests/bpf: spell the addr_space_cast address spaces in decimal
    https://git.kernel.org/bpf/bpf-next/c/0a2eb9a7fa34
  - [bpf-next,v4,5/8] selftests/bpf: write the mixed arena/scalar ALU tests in asm
    https://git.kernel.org/bpf/bpf-next/c/db06ab42ec4b
  - [bpf-next,v4,6/8] selftests/bpf: drop the arena guards and tag the tests that need arena
    https://git.kernel.org/bpf/bpf-next/c/84459cc976cd
  - [bpf-next,v4,7/8] selftests/bpf: cast explicitly in the struct_ops arena triggers
    https://git.kernel.org/bpf/bpf-next/c/7eead323843a
  - [bpf-next,v4,8/8] selftests/bpf: cast explicitly in the arena subprog and callback faults
    https://git.kernel.org/bpf/bpf-next/c/b64845f6280f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


