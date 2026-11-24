Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491008;
	b=FXsYzB3fi6wOEZcEjxGHoAOD/EHqAbKFkoVkCA6CbR0hST8HaDajybQynTHOORCzdRsy
	 gXSE2kv96sjqm9Ff3RMG7RBRfIP25fq5ha8FaB59acBEB16KiDoauxjNISNwrNCw9xdi3
	 BnsOHSM01pDQcvrn5vEgqj1YtJtsb4OzPcaod42sYxdKpQUFBJV3LxkTt4/L+oF61tcqv
	 F9SqzLSL0sCjH8JU81AU2SNvWCXV6Z/MipmcUXozFD0R5Yv/FgebtW8usBKtL3Za9xsnd
	 i/z4KmTQn1Oom/goD+4mKKBbtQguyDxHEIHAEesIL/dpmijR2KBZhlzI2isRkpEYPJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=woosih2AuG1beuJR/JI+IORd2NX0LXJKFkEno0hX+sE=;
	b=GrwD7lbbzpL+80YCz9g7OXbuhcHkOfqlE80LvpFdq7/6cpq5yUF0n0VeQ6dHJFSmg2ac
	 Ul99h2mtjaWdZUu27YUIkn2kC9CcaSgY+8AOqYPqYGg5ZOf+a8FOCUviayHTQpUUMrohw
	 joyoL5AQVLZypOM8jERzpLPPoFzKggrqKb4VVOaR5nzHmzfzGzo96KCTKaukMxSdc/JPs
	 dkbOEiTgRu0fWjX3yupmyXnU+EpDG7kLmMFnjsOh1uRqEWdYoYjmsMByf68vAMBF+178v
	 lR97xTI7tzlbsdmRsjNVUPEMG4/dSNuJowgqNF6vCtNJMTAktOCYFPzwwVNTH/g4L1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYt0+Q3E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0B4606A327
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYt0+Q3E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05611F000CF;
	Tue, 24 Nov 2026 03:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795491007;
	bh=woosih2AuG1beuJR/JI+IORd2NX0LXJKFkEno0hX+sE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PYt0+Q3EHf0NFWRUuPIiaqYZAS422cCIPu8mrDrmwfIR+9dxMg5mLnQzLXKKx3Du2
	 gv1lbLSeT5+xwMv5FAHsOd9Jhxvu+HKu7DsFDsL+z65uXuq6h5k/PrziFjXf81ImsP
	 T+Z2XmlnyBgSv3PEZLe5St36WWe1bgM6fXt1DO04fDmKutLSobSaDg01rdvrTR958L
	 +yMHhst19M0ya7sEh2g5fZjBFLgV8SIHjndoeAtNQsPISfKCREwtkAFMw5jifiiXwb
	 HiZMBnmXrCEIA+0x1d+yc0VO7+j6Z+e1gV62mXcwUxSrn/PXz0b3NkRvDEfZFA/GKP
	 KTlun5B51iJXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44CB39302D7;
	Tue, 24 Nov 2026 03:30:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v6 0/2] libbpf: Fix CO-RE relocations of unsigned
 32-bit enum values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179549100653.3259463.11833009507292610295.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 03:30:06 +0000
References: <20261124000514.2955878-1-yonghong.song@linux.dev>
In-Reply-To: <20261124000514.2955878-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 23 Nov 2026 16:05:14 -0800 you wrote:
> For a BPF_CORE_ENUMVAL_VALUE relocation, libbpf sign-extends the value
> of a 32-bit enumerator even if the enum is unsigned. A value in
> [0x80000000, 0xffffffff], e.g., DCACHE_PRIVATE of enum dentry_flags,
> then doesn't match the zero-extended value clang emits, and the whole
> object is refused. And a target value in that range is patched
> sign-extended.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/2] libbpf: Fix CO-RE relocations of unsigned 32-bit enum values
    https://git.kernel.org/bpf/bpf-next/c/4fad237494f1
  - [bpf-next,v6,2/2] selftests/bpf: Test CO-RE relocations of unsigned 32-bit enum values
    https://git.kernel.org/bpf/bpf-next/c/885fd5836d3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


