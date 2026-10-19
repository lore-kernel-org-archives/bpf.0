Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439411;
	b=4aIKAKWVpm2jaf6wCcoaVE5rFcQ8r4p7KlZbPHBDSLwP1uJ4XZnTAp7YZrPM3Ii2N5FO
	 +NCRLsDxIp7rpHW4KYCtF5wioSPkDgVd3c2lZewDNeHOMwQVTtFeftPftHFW0UybCjEgX
	 nPtudtGjiC7YZrEniPR1jMo/aTmPKrFAmPI83IYBGaGpN+gDf0tb3E0fd3oqir6MunnWm
	 Jri2TECQSm0ODaBUM6F7saYhvXNonn4wXrF0aVFLFTg7zZZysbAc37bCsknIh/87LowiJ
	 I6TNl6KpPDZVwZ+lXsfbe6vjX5tkHtw2+Ue9ypUqhTXwzYG1gOJN1yiYOZ0F28gQ9IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=TW4CS6cv+nvnkOr0R6JwitX4uLQdBnZYq/XUSM6xcHk=;
	b=dmhtKsEMyN/kxCw6VrX+++XxHcqWxyXDezY2J8SgMXzhj8GYkUl6ILrdQZ1nCy2Xf7e9
	 wdDa9ELK10ZWdKJ1zOutC/A76C7aCjSrrJ5+gZ8aeWiNSJyWbtKnwNx6IJoiC0rRY97Uz
	 xhUKJXIdHsY2Xb/6JadYunr12nv2xMNTPXkksV6Mw467KHtSKtJzoQvGXT1qlutKUZWR0
	 epPuSNNuU5aEKkRxGaJsqFR7FAeYZMUjiOjuv59AksHwtYQ3LxulYhsEzkXqLGTzy0bly
	 ehBUCi85wbd7PKCmSbi7EihKnqBc9pi4on224JCwVB1d65+8K6QcSZwraaZHGARRjaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f02yvpmB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653EA606A31B
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f02yvpmB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BB31F000C4;
	Mon, 19 Oct 2026 19:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792439411;
	bh=TW4CS6cv+nvnkOr0R6JwitX4uLQdBnZYq/XUSM6xcHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f02yvpmB1z1QrQPVl4IbdEjDVhac/S6GZARTbAw1kzhzLikBsGIzu3xq8iP/J1+Dj
	 9kgUNFdTAyzLPENViuLONyEt3LcE14fpHabc7eOr2wAlQXOsVCCt2oL+YtPX2U2NZU
	 3YmZs1Zy5JYijrvzghrLSRIU9199KqZz6IaCXLtItrPZaPHkVwWKm4eR0PGe8J3Db/
	 p6Fo9AoyVaUx7yBHFN3h+tDtH3PBCJBh0bf7yP1erjjPapkYa1obtCJVflPehiVcPi
	 e52IZW4lbCAWI4Y/NJdnxyl35Ban6HMJROnhnBLxfHSI/0RJf3kzO13oKSFm0n16GY
	 s0KntA3n0T6Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15483924A53;
	Mon, 19 Oct 2026 19:50:10 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v5 00/16] Fix some arena paper cuts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179243940978.3292775.11903554212923646408.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 19:50:09 +0000
References: <20261019132203.3034698-1-memxor@gmail.com>
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, tj@kernel.org, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 19 Oct 2026 15:21:42 +0200 you wrote:
> Kernel code that shares arena memory with BPF programs runs into two
> paper cuts, both visible in sched_ext's cid-form schedulers today.
> 
> A kernel struct cannot publish an arena pointer: a pointer member reaches
> the program typed as a kernel pointer, so sched_ext hands out a plain u64
> holding a pre-translated arena address and every program casts it before
> use. __arena and __nullable become BTF type tags, defined in a header of
> their own, bpf_compiler_types.h, that the code tagging a member includes.
> A load through an __arena member of a kernel struct yields PTR_TO_ARENA:
> the member holds the kernel address and the fixup pass appends the
> conversion to the arena pointer form that the struct_ops trampoline
> applies to __arena arguments, with a NULL test for __nullable members.
> A __nullable member on its own yields PTR_MAYBE_NULL where NULL would
> otherwise be assumed away, on trusted, RCU and per-CPU results, and the
> program checks it; through a plain or an untrusted pointer the member is
> probed and tolerates NULL, as the BTF_TYPE_SAFE_*_OR_NULL lists never
> applied there either. libbpf renders the arena tag with its address
> space, so the member arrives in a program built against vmlinux.h ready
> to use, without a cast.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,01/16] bpf: Check exclusive maps once the program digest is final
    https://git.kernel.org/bpf/bpf-next/c/55f17779d649
  - [bpf-next,v5,02/16] selftests/bpf: Bind an exclusive map through a continuous fd_array
    https://git.kernel.org/bpf/bpf-next/c/c2e56c88f14a
  - [bpf-next,v5,03/16] libbpf: Keep the fd_array fill index out of bpf_program__clone()
    https://git.kernel.org/bpf/bpf-next/c/b1eaee8b9a95
  - [bpf-next,v5,04/16] selftests/bpf: Clone a program that calls a module kfunc
    https://git.kernel.org/bpf/bpf-next/c/d837f008bfe6
  - [bpf-next,v5,05/16] bpf: Add the __arena and __nullable BTF type tags
    https://git.kernel.org/bpf/bpf-next/c/10832993c941
  - [bpf-next,v5,06/16] bpf: Recognize __nullable on pointer members of kernel structs
    https://git.kernel.org/bpf/bpf-next/c/bc7c2824682b
  - [bpf-next,v5,07/16] bpf: Turn loads of __arena pointer members into arena pointers
    https://git.kernel.org/bpf/bpf-next/c/7efe1d4e1139
  - [bpf-next,v5,08/16] selftests/bpf: Test __nullable pointer members
    https://git.kernel.org/bpf/bpf-next/c/9278bedb22de
  - [bpf-next,v5,09/16] selftests/bpf: Test __arena pointer members
    https://git.kernel.org/bpf/bpf-next/c/1dad22de9c03
  - [bpf-next,v5,10/16] selftests/bpf: Move the no-arena tests out of objects with an arena map
    https://git.kernel.org/bpf/bpf-next/c/bc4a327d5b87
  - [bpf-next,v5,11/16] libbpf: Bind the arena of an object to every program in it
    https://git.kernel.org/bpf/bpf-next/c/cd7a395838cb
  - [bpf-next,v5,12/16] selftests/bpf: Test arena binding by libbpf
    https://git.kernel.org/bpf/bpf-next/c/8911d7766073
  - [bpf-next,v5,13/16] bpf: Set up the arena base only in functions that use it
    https://git.kernel.org/bpf/bpf-next/c/a8471eb0747f
  - [bpf-next,v5,14/16] libbpf: Render the arena type tag with its address space
    https://git.kernel.org/bpf/bpf-next/c/7418d9291c57
  - [bpf-next,v5,15/16] selftests/bpf: Test the address space rendering of the arena type tag
    https://git.kernel.org/bpf/bpf-next/c/31ef8ab6dfc7
  - [bpf-next,v5,16/16] selftests/bpf: Test an arena kfunc argument passed from a subprogram
    https://git.kernel.org/bpf/bpf-next/c/fb854e2e54a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


