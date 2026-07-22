Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686AD43BDB5;
	Wed, 22 Jul 2026 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734847; cv=none; b=fLfW2t94StgDnrkhDcLIiKCLjzXjTikXNyMTg4ywJpIbZoOTPO/L7CmbpPc3Vz72HlVCU8sD242XgXa8kJSbZ3kuqhi/bO70PcvwYiI2eLr08EWTaDu84oD1e1CdXd52Ulh8c0iP6ZreX4UmYVibXMsObDCn1CY0oxgM3TtuNNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734847; c=relaxed/simple;
	bh=+EAvx8hCWDjWq5EQmnBdhkQcFzRYbL1lgZKh6BDmJx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eO2XLqUaNzgpvjPOa4OePThcKe4msK5hRKH2Gt4Q4za3CEZav35WgfRqFEwX2jgnz3+vkko99Rkb9T1KrVms6kzrRBsdgtzz8XqqOoNKkTn8T6HEr0+UZ8nV4k7KiCygKt+auK/UW07nz74ilypV7zYuNv2FqENW9/R8W4a9SYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKTJPxyN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKTJPxyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA70C1F000E9;
	Wed, 22 Jul 2026 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784734845;
	bh=QSV0Uf2J2r9zQ5PxWBwKY5V5JG7fThgKbqwiOOMBArg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CKTJPxyNEg291q3GpGhmqWxLzCRHTDzLiXqzWQIJzpk2Q6o2XPT+GeGSZzQHqgyX6
	 QizZybqYvcQtbJfSFmOeKRnUhB8ks4ExI1wO0A8gi+zhHiE1LWkDBTaXOfzsZOa/sK
	 uJMM1rKClpDfQH3gEi3RWLZSo5BQT7q2UTT9XUTl5RQyYpqHugerEFLzxb+5GNGg6N
	 hOEklfLWeJvgWBT4OeOkBJDkVKeqAFFOpm5wLDrepllJd+qMkqTlUs11Of0dXzk1u+
	 ZA67pYjt7VlvToYg078ZKtcfio8BZr+lgzmYQ/pzy2REEccFcPP/M8QQf1mU5AKGem
	 88/0UrgSEhy/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C59380AA5E;
	Wed, 22 Jul 2026 15:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/5] bpf,
 x86: enable EXECMEM_ROX_CACHE for BPF
 allocations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178473481439.1464421.4198838118908627842.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 15:40:14 +0000
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
In-Reply-To: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: ast@kernel.org, andrii@kernel.org, luto@kernel.org, bp@alien8.de,
 daniel@iogearbox.net, dave.hansen@linux.intel.com, eddyz87@gmail.com,
 mingo@redhat.com, memxor@gmail.com, peterz@infradead.org, song@kernel.org,
 tglx@kernel.org, emil@etsalapatis.com, jolsa@kernel.org,
 john.fastabend@gmail.com, martin.lau@linux.dev, hpa@zytor.com,
 yonghong.song@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu, 16 Jul 2026 10:51:34 +0300 you wrote:
> Hi,
> 
> BPF allocations of executable memory on x86 are essentially read-only. Most
> paths that call bpf_jit_alloc_exec() immediately make it ROX with
> set_memory_rox().
> 
> The code generation, at least on x86, uses separately allocated writable
> buffers and then updates the actual text memory with text_poke().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/5] bpf: dispatcher: allocate bpf_dispatcher->rw_image with vzalloc()
    https://git.kernel.org/bpf/bpf-next/c/810a273919df
  - [bpf-next,v3,2/5] bpf: drop __weak from bpf_jit_alloc_exec() and bpf_jit_free_exec()
    https://git.kernel.org/bpf/bpf-next/c/4946eb5d37cb
  - [bpf-next,v3,3/5] bpf: alloc_prog_pack(): skip ROX management for already ROX memory
    https://git.kernel.org/bpf/bpf-next/c/7516714947da
  - [bpf-next,v3,4/5] bpf, x86: make sure allocation in arch_bpf_trampoline_size() is writable
    https://git.kernel.org/bpf/bpf-next/c/5bf02dbf39fa
  - [bpf-next,v3,5/5] x86/bpf: enable EXECMEM_ROX_CACHE for BPF allocations
    https://git.kernel.org/bpf/bpf-next/c/6b88aaec81db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


