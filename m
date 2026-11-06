Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925011;
	b=fmhetvabv+oVrqdZ81xhaRVPchDi04gPm8ZqJDLpolPSvp3L6/gk7EbpcLDspITbdIF1
	 bX1JtscZZvgFvWWq/+yO1kezotDo3LO8VnzRIaTckifX+sGNKa61zExcAjTJd8RXoUR2q
	 aSbm/ocffQy4iyyJrPmkzA9NuSyRpvXt5EISoOSQcYpA6SYcKEbQw0VFrnY1EYOCFnKc6
	 iBi7u1gwkrwQS2l+EhIGByfXTtEC7Dz24E5Y8x9pP9Drr2xkumefIichxfLQpyY9Xdv6O
	 EyrTGh/rBPKJiBsXoFsom1WPeVo3x0mSxkSRyFNoL/hSK3EJW1T4KMqsNQuX3tzPGaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925011;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=KcI965bqcW1rp7HgsbC2UiSIElOlSJK2uBexiK300F0=;
	b=0kuBcuLp4ewXTNORCtzzbgapdmHqq32GcXOmtr73kc/SsB4oVpa1/bW8K5WZbnXpObDQ
	 1xFlzWRncFgM9LeYl/IO159ZdKT/cExJLTytYOJrAXU+UqRpmIIate24hDpPI6Hn35Oac
	 bAkOgRf4RaVoY/2ThUbw6skx8IF6dKLXVrLYwsgMFMeHcDWJUvoZDRoN8LM8lQlFdljw+
	 5jd/78tpmVldJD3jYu+dgdsaNlxLp5jZBrrJ5niYBt+ia1roR4B2eVFYJIVwsH9tTKPYz
	 fE+pXqCvfN/Fw8nvie/9IWAxc6UhJqp8JY6lVNmua1IjggJawRgLHzaHaB1cFxQ4lsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxdFO0DT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3155606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxdFO0DT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCE01F008A1;
	Fri,  6 Nov 2026 00:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793925010;
	bh=KcI965bqcW1rp7HgsbC2UiSIElOlSJK2uBexiK300F0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DxdFO0DTJONHEu1PFFghQ8XzUIlFWr/nbXrP8D2/Fu9nz6O4G9QnknRRa4cUBngW+
	 HUdyQwaLx7Vn/l2vs4ow3Fs1YbKQ2ZO6tk0I3BH/MqU5eoRIFH07MAsG2bWsAGJXMZ
	 UzbQ4SJzbK3Ao7hvnw68MwnDrcRqQEHL7FJzpfLVVbKzeiaPTOC/fUALZ5lz56aPHm
	 L5rCT0cqYB3cnPrRDkzC//s5lttX8m9/+jW5eDcyGlB1m1SvkIKv9R/l6/qZ8HNJpt
	 9YhUFJeLAd7qjzHcBJA2+MoKx20+tNgYjAXILLe5Hjxk/SSWqbiD4UfRGbECBVMy8j
	 KHkgR3hWj53hA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E14C391B1AF;
	Fri,  6 Nov 2026 00:30:10 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v4 00/17] bpftool: Per-record CO-RE attributes in
 the
 C dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179392500918.256564.14359701625669388609.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 00:30:09 +0000
References: <20261105175845.30357-1-ihor.solodrai@linux.dev>
In-Reply-To: <20261105175845.30357-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, qmo@kernel.org, bpf@vger.kernel.org,
 alan.maguire@oracle.com, cupertino.miranda@oracle.com,
 david.faust@oss.qualcomm.com, irogers@google.com, jose.marchesi@oracle.com,
 vineet.gupta@linux.dev, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  5 Nov 2026 10:58:28 -0700 you wrote:
> bpftool's C dump wraps its output in a clang attribute pragma:
> 
>   #pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
> 
> GCC-BPF implements preserve_access_index, but not the pragma. Since
> the commit 675b4e24bc50 ("bpf: Temporarily define
> BPF_NO_PRESEVE_ACCESS_INDEX for GCC") the BPF selftests build GCC
> objects with -DBPF_NO_PRESERVE_ACCESS_INDEX, which disables automatic
> CO-RE for vmlinux.h field accesses.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/17] Revert "libbpf: Render the arena type tag with its address space"
    https://git.kernel.org/bpf/bpf-next/c/be5adbb5dbe7
  - [bpf-next,v4,02/17] libbpf: Look up BTF strings without making BTF modifiable
    https://git.kernel.org/bpf/bpf-next/c/efeb5ab5753d
  - [bpf-next,v4,03/17] bpftool: Dump C through a split BTF
    https://git.kernel.org/bpf/bpf-next/c/7eddda6a121b
  - [bpf-next,v4,04/17] selftests/bpf: Build BTF fixtures in btf_to_tmpfile()
    https://git.kernel.org/bpf/bpf-next/c/525ab88efb6d
  - [bpf-next,v4,05/17] selftests/bpf: Cover unknown BTF header-extension bytes in bpftool C dumps
    https://git.kernel.org/bpf/bpf-next/c/36bf1f2bde41
  - [bpf-next,v4,06/17] libbpf: Let decl tags override how btf_dump renders type tags
    https://git.kernel.org/bpf/bpf-next/c/fbafb695c5d2
  - [bpf-next,v4,07/17] libbpf, bpftool, resolve_btfids: Dump kflagged BTF tags as is
    https://git.kernel.org/bpf/bpf-next/c/79dcfd3e36a7
  - [bpf-next,v4,08/17] selftests/bpf: Cover type tag rendering overrides in btf_dump
    https://git.kernel.org/bpf/bpf-next/c/987293843db2
  - [bpf-next,v4,09/17] selftests/bpf: Cover legacy arena type tags in bpftool C dumps
    https://git.kernel.org/bpf/bpf-next/c/f857eecf674d
  - [bpf-next,v4,10/17] bpftool: Apply __bpf_relocatable per record on BTF dump
    https://git.kernel.org/bpf/bpf-next/c/e35e286214ba
  - [bpf-next,v4,11/17] bpftool: Skip __bpf_relocatable on verifier-rewritten context types
    https://git.kernel.org/bpf/bpf-next/c/8b01716790dc
  - [bpf-next,v4,12/17] bpftool: Emit __bpf_static_offset on verifier-rewritten context types
    https://git.kernel.org/bpf/bpf-next/c/e15918abdd48
  - [bpf-next,v4,13/17] selftests/bpf: Cover record attributes in bpftool BTF dumps
    https://git.kernel.org/bpf/bpf-next/c/a3335b95bd37
  - [bpf-next,v4,14/17] selftests/bpf: Cover context and socket accesses through vmlinux.h
    https://git.kernel.org/bpf/bpf-next/c/1fc6998042e0
  - [bpf-next,v4,15/17] bpftool: Document __bpf_relocatable and __bpf_static_offset
    https://git.kernel.org/bpf/bpf-next/c/aac7a06b609d
  - [bpf-next,v4,16/17] bpftool: Render the arena type tag as __bpf_arena
    https://git.kernel.org/bpf/bpf-next/c/40483927e5b9
  - [bpf-next,v4,17/17] selftests/bpf: Cover the arena type tag in bpftool C dumps
    https://git.kernel.org/bpf/bpf-next/c/325f10b127f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


