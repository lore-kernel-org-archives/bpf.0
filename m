Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87299492539;
	Thu,  4 Jun 2026 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591817; cv=none; b=byejXMX6VRWB2n3dmACX+EqQ9U+S3OYJJk9bVdTjiDeL/zHeF4IKEciq5oncOiNxF6xyeb7972R6yX81xd8sCCnvxPNAB0Ri5uHLbn/hZrs6cUw7lSd73zh3yMIO7mhIgNuikd+M5xRVL+DxruTszrNDMoH4RFUQNr7WvQIKd3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591817; c=relaxed/simple;
	bh=EWsxN+/lUbnqwhZP0Rgc0rHGQoqion+jXM7PA8ek6t8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Aiu3s9lzWicJA/bIKLP38u7McsR62KEpBm6oh8Ehx1dw+3HV3XDFJee2lgBQ8yZoIEHODnSru6bm9SLPx4g4NUPxwF6vmvbE08Xeteuf4e+7OW2sRiduQjqU6Gv3CHe3Zwq6+Z9gzcpEoUEe7+ogyj/jVgeYWZWEQ6shCNtkut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyGUj2gK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyGUj2gK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D211F00893;
	Thu,  4 Jun 2026 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780591814;
	bh=PeC55/8TJlUll3PzjhXf4oLJdtQRejIy20Nor0AjlYM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OyGUj2gKo2vty4mfsxE/rnQpg7xXCgWdt4wymdnjrmfKXy/LXumWWJjP1C92Ciudu
	 NlmtScm9CctwMTNTE8wFbEJlE++Ph32oxr5/YzGSBLExIsPyM/U+r1HDDNjVMa9eY/
	 bk9D9azbl/wBVbg0OwS7gyD9w2p9tg/ZHCsjqKQ7fSt+VjbgdrhPL+x6qAOD+0vg9b
	 7aUiF9u7mpentvHUyXlj2/vvpW2Thay0Tk2blJ2+LBSY4I84q18WdUUXxBiXnzs0nU
	 +sZ8fTVfmauDVpbXGQZXNvLpdRq0F7tMaP7SVZ4dQTbaEh60KjsD9uEz27hSqxLmDt
	 sZ0phiundg0UA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B8C3930A0F;
	Thu,  4 Jun 2026 16:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: ignore call depth accounting for
 retbleed in verifier tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178059181541.2942053.15567465384217176140.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:50:15 +0000
References: 
 <20260528-fix_tests_for_retbleed_stuff-v1-1-c2022a1f3bee@bootlin.com>
In-Reply-To: 
 <20260528-fix_tests_for_retbleed_stuff-v1-1-c2022a1f3bee@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 ebpf@linuxfoundation.org, bastien.curutchet@bootlin.com,
 thomas.petazzoni@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 28 May 2026 15:27:14 +0200 you wrote:
> When running the selftests on a retbleed-affected platform (eg:
> Skylake), with call depth accounting enabled
> (CONFIG_CALL_DEPTH_TRACKING=y) _and_ with retbleed=stuff, some verifier
> selftests fail to validate the jited instructions. For example:
> 
>   MATCHED    SUBSTR: '	endbr64'
>   MATCHED    SUBSTR: '	nopl	(%rax,%rax)'
>   MATCHED    SUBSTR: '	xorq	%rax, %rax'
>   MATCHED    SUBSTR: '	pushq	%rbp'
>   MATCHED    SUBSTR: '	movq	%rsp, %rbp'
>   MATCHED    SUBSTR: '	endbr64'
>   MATCHED    SUBSTR: '	cmpq	$0x21, %rax'
>   MATCHED    SUBSTR: '	ja	L0'
>   MATCHED    SUBSTR: '	pushq	%rax'
>   MATCHED    SUBSTR: '	movq	%rsp, %rax'
>   MATCHED    SUBSTR: '	jmp	L1'
>   MATCHED    SUBSTR: 'L0:	pushq	%rax'
>   MATCHED    SUBSTR: 'L1:	pushq	%rax'
>   MATCHED    SUBSTR: '	movq	-0x10(%rbp), %rax'
>   WRONG LINE  REGEX: '	callq	0x{{.*}}'
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: ignore call depth accounting for retbleed in verifier tests
    https://git.kernel.org/bpf/bpf-next/c/bf29346fc393

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


