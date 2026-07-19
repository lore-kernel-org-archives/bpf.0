Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF2539D6FC;
	Sun, 19 Jul 2026 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784478642; cv=none; b=qUp7HnsmavAWRVr0N85wfDrKrVDCebZ/Jo4YeoAkCDcnFt+0hvp6HsHZsVGqpdtQLfJHDDH04GZ975SfKA9rhOl+AF0rNDbT22+F5UUkovF1uLqxsHIqcwPR8GPzJISzXU+QJ5sbXsAmaIyOJALvvdIV5A1VMjDFeU/v/5A2AlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784478642; c=relaxed/simple;
	bh=+kZENFSshQT6Ai2WBMT1cJ3Llv2j3UPsQXz8/TYP2Xg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AWVYg6QYG/lM77ugT+iAcxb3ga7a+SF0GeefgarT05IkCcSbkzwNwAoP0mq/hH7N6za4DGN6+bs8xn0h7ssdChcJRpRmm0hJHFaGAKgBILApwELJXH0IQDuEZJ0ScOarusB1qC0wXWhTuvrnDzBWlX3yj6omG7LMYEZvFQPR4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ54kTGU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ54kTGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDABC1F000E9;
	Sun, 19 Jul 2026 16:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784478640;
	bh=RRapGTsGtbx7AnvVAOYh9BqiiWT8W0qCvoOYZZ9kcY8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nJ54kTGUdL3IZNEwJ2u9pSbsh1yNonY3bSK7hUYOWUXnwIw3iLVqv0UDaKyOEz4uD
	 UMVXXGXUGP1hutyB26v4MtVkHl9CPsrqxzfgepVZv1CSox9VrWmpDnSNJeWHo+s7XI
	 ig8cctcqf2M48T/AnwWVA9Bs3O1JYneJf7kv9ksSFAIGo+YWgDXs7oeKa8umX1SX27
	 VcMIFif6AmL+LHy2VDCiBJ1oE+Xnk8MuCdLn7SgCPg3P5BSc755qSkKRfjbVydlBto
	 HMIzT3h5QNsqoZdfjCRzBKr9pHNtKOX7JYKdprHl4HqTWuxpozo910Y8J83mqLwX7k
	 P/LVfO8UEcM2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CA238119C8;
	Sun, 19 Jul 2026 16:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: remove redundant config option
 from selftests fragments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178447861140.2768115.4487511323893385210.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jul 2026 16:30:11 +0000
References: <20260709-testing-fragments-v1-1-65244b0650ff@bootlin.com>
In-Reply-To: <20260709-testing-fragments-v1-1-65244b0650ff@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, ebpf@linuxfoundation.org, bastien.curutchet@bootlin.com,
 thomas.petazzoni@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, jakub@cloudflare.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu, 09 Jul 2026 20:42:59 +0200 you wrote:
> CONFIG_IPV6_SEG6_LWTUNNEL is currently enabled in each arch-specific
> config fragment for the BPF selftests. Commit 33a971d549d8
> ("selftests/bpf: Add LWT encap tests for skb metadata") has enabled this
> config in the generic config as well, resulting in a small warning when
> configuring a kernel for selftests:
> 
>  $ cat tools/testing/selftests/bpf/{config,config.vm,config.x86_64}>.config
>  $ make olddefconfig
>    HOSTCC  scripts/kconfig/conf.o
>    HOSTCC  scripts/kconfig/confdata.o
>    HOSTLD  scripts/kconfig/conf
>  config:269:warning: override: reassigning to symbol IPV6_SEG6_LWTUNNEL
>  #
>  # configuration written to .config
>  #
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: remove redundant config option from selftests fragments
    https://git.kernel.org/bpf/bpf-next/c/45bf95da6de8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


