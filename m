Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C63149C7B
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792025410; cv=none; b=PjGjbbPw6J4z7uQOOoy1L9NvYHpoYhrsCbfFja4ZVdcdS1vkkvkcfms6Z4c63BStnyvi2gVXi9D96d+Ye045KnKoE8GDpbIoaGQ4G6OQXxpiTiULc9OhNGBmTpXvycci5GYHVc7DEsf3kWZgapuGau3R00ISYyGm5EKSwpvmWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792025410; c=relaxed/simple;
	bh=7cY79lixcFilTJqekUZ3xvqHjOkxxIw2l0R4YwuaGTk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U+rYdCDyXhUoW0+FITQj6zBHH0OyQH/mpZSgRW9hR949tOzz2t2UktyITbZfvgrwG/AkVIVN4HQl6LZ25bRMtXoSbzUDUeaA2KCoiWLJVWWK/VU+Cug7DU3eywVeBOcxGBIuKE0KZWVtG3cXlFqALd22R2A6kNmdEUBaXFYeUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyYb8mUs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyYb8mUs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422DA1F000C4;
	Thu, 15 Oct 2026 00:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792025409;
	bh=fWO44WhlTdZYNInrHLIOsscs0RtimR5zTrjYDrpHIjI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LyYb8mUsRbAxp/zbXIIPQOdLqifTdmYAWFJsJCsDmXr/yoDWFc88NDdMnWkpeHYVk
	 jkYc7rdbyvXwE29GZEW5ouTFQwN9Q5G67klG/9NsBsU4xf2CzYnNafKQ4f1NF5rDeG
	 lebyBonRZkgHyiTQXvxyAV01OqPlzH8oU2d9QfvaH9cuHRk4Su/3dMXKBi+FboD9L0
	 R7TOG3gNOpMrToJGwLegvkM9o/mAsMuz1J7v5tI8QhrxNXTzP33G7hcT0HNiT6gPsz
	 VY6lgqDRzlVWPRIy8GgVRl6YWL6tdF2T9I2BNQNyG8W8P9f4jZ6kKEU7Y23rXsVqp7
	 BpARCA8lMDzQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A218391B078;
	Thu, 15 Oct 2026 00:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 00/18] bpf: Various x86-64 BPF JIT improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179202540802.3104381.4401216511627780535.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 00:50:08 +0000
References: <20261013171230.523677-1-daniel@iogearbox.net>
In-Reply-To: <20261013171230.523677-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: alexei.starovoitov@gmail.com, memxor@gmail.com, yonghong.song@linux.dev,
 puranjay@kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue, 13 Oct 2026 19:12:12 +0200 you wrote:
> This series changes the x86-64 BPF JIT to emit shorter and faster native
> code for the instruction patterns that LLVM-compiled programs hit in the
> real world. Every change stays within the lowering of a single BPF
> instruction, nothing is optimized across instructions. The patterns were
> checked against what clang's BPF backend actually emits, and the native
> forms follow what LLVM's own X86 backend picks for the same operations.
> 
> [...]

Here is the summary with links:
  - [bpf-next,01/18] bpf, x86: Drop redundant REX prefixes from zero and sign extensions
    https://git.kernel.org/bpf/bpf-next/c/63d4c99d25ae
  - [bpf-next,02/18] bpf, x86: Omit the displacement byte for zero offsets
    https://git.kernel.org/bpf/bpf-next/c/44df4d88aa63
  - [bpf-next,03/18] bpf, x86: Shorten the stack adjusts and the tail call counter loads
    https://git.kernel.org/bpf/bpf-next/c/c4da703867ed
  - [bpf-next,04/18] bpf, x86: Use shorter test and cmp encodings for immediates
    https://git.kernel.org/bpf/bpf-next/c/649caad437d7
  - [bpf-next,05/18] bpf, x86: Compare against 0, 127 and -128 with the adjusted condition
    https://git.kernel.org/bpf/bpf-next/c/fa6979fde9f6
  - [bpf-next,06/18] bpf, x86: Use movzx for byte and word masks and a not for xor with -1
    https://git.kernel.org/bpf/bpf-next/c/135b45cf05b9
  - [bpf-next,07/18] bpf, x86: Consolidate the ALU, shift and neg encodings into helpers
    https://git.kernel.org/bpf/bpf-next/c/707e1331f52b
  - [bpf-next,08/18] bpf, x86: Use shorter and faster forms for some ALU immediates
    https://git.kernel.org/bpf/bpf-next/c/d59f47e031ae
  - [bpf-next,09/18] bpf, x86: Swap 16-bit values with bswap and shr, not ror and movzx
    https://git.kernel.org/bpf/bpf-next/c/0847f6cb2e6a
  - [bpf-next,10/18] bpf, x86: Use BMI2 shifts also when the count is in rcx
    https://git.kernel.org/bpf/bpf-next/c/f2a5c00a80f1
  - [bpf-next,11/18] bpf, x86: Fold the PROBE_MEM address computation into a lea
    https://git.kernel.org/bpf/bpf-next/c/74309a9294a7
  - [bpf-next,12/18] bpf, x86: Compare the PROBE_MEM address range with a shift
    https://git.kernel.org/bpf/bpf-next/c/181576ebd87d
  - [bpf-next,13/18] bpf, x86: Divide by constants via multiplication with a magic number
    https://git.kernel.org/bpf/bpf-next/c/02cfd66f3d9a
  - [bpf-next,14/18] bpf, x86: Multiply by 3, 5 and 9 with lea
    https://git.kernel.org/bpf/bpf-next/c/36b383f5abc3
  - [bpf-next,15/18] bpf, x86: Use emit_sub_rsp() for the trampoline stack
    https://git.kernel.org/bpf/bpf-next/c/2378e471a6a2
  - [bpf-next,16/18] bpf, x86: Shorten the cast to a user address
    https://git.kernel.org/bpf/bpf-next/c/b878ba01b67a
  - [bpf-next,17/18] selftests/bpf: Add JIT instruction tests
    https://git.kernel.org/bpf/bpf-next/c/54e8bde13a3a
  - [bpf-next,18/18] selftests/bpf: Remove the old test_bpf module
    https://git.kernel.org/bpf/bpf-next/c/4532e525b286

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


