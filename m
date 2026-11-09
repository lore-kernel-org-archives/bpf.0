Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187619;
	b=d1XK2Ge8d21A4/IIQBB23hBIyggPrvo+7/eSuWTTaYZTZgR9fh53UfvjUIT6axIlVyjK
	 1VcLRizMgAZvHH3dPUqFZvu/BgLFNR7dVfPPUheLYVfRONcrDDkA9ztx2PcPNAbmADpgz
	 kh45whOAe1HgQ6rvj5CDxZJE6tDMhmDZg8wrWUe9e0EkLt1nGvAg3bhZneUxbiLUt4+PW
	 dkrovTEQxVEzcGygBVQcg8HEdS8cZloS65v7+LKWxN76pdiMWzkmX+4MCEtmR4noq60sh
	 /M81QEpQh1jETSEi2dmH967L7Mk69pMaTG3kF/X/2DKDyT3qYEBWMFU14hFKKIVITHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187619;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=iJgvv+vbSYiKu9D2Sb1AjohexiXFRe2YpdqwQmcxyao=;
	b=x24ETJlSuRN3UZNVj9UfZUaVcC29ZxTo7csAE6GCTCSf/1StRowD5f8qyYJDjmwgdO28
	 4+Kryf8r7Xb5LHTQG0Bf+DiUmNZHEES3lsDZ4qW4dOLx5/MmWPrEFWkWLVN+iGgGKdYjz
	 zp4s69VQF2QgwJMcPrvApUNONqZNBvq/VzCc6sSPTqpXFIiiMG0KeGMOS8SKa+3x6xR36
	 uqpjPf2yNs7dCEMshQM5nsAiiAoChHOJnxt6wvwLg+lyVDde2qip/JwkI9qs7jHByBADa
	 ct8azuh9Vh9k4Eaq+1S7piAmIaerMkfvalxivoukwT+HGQdse/10buKmIBgZaLFz9CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mwbMlECO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4AA606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 01:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mwbMlECO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72AD1F0089F;
	Mon,  9 Nov 2026 01:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794187619;
	bh=iJgvv+vbSYiKu9D2Sb1AjohexiXFRe2YpdqwQmcxyao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mwbMlECOCwvPNctzvbuoUlwitEeAMWfhOZADaBNweGXv7OrDAt6iFfEWvvuj5Dt1u
	 ju3mQL2AmT2qizNqgvVvCSgyXXNQ2A1I25U7zxzq4OnxVcvkhsxbdGv9MJL7g9XM/n
	 RYClXqFqsgsIYVpmyPC/0CoV8IDgqTJBwcTq0SRNGblqfu/efBn7IYdBZXWbiE3i/u
	 Xhmoo2l7B+ZvwMBUST6HZWQ5Vmc2ZNhxfCcuBUSWGTGwUE9n9Ol2a1M8rggYKAj8p7
	 zDN/Luqf3UMigGpogNLjcmM+8xPatWgq1mO+epTF/vcglC4Y8lLjk5tC15FmR+vUN6
	 epPk0Ok8+Xp/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D82B4380821F;
	Mon,  9 Nov 2026 01:26:58 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v3 00/24] bpf: Various arm64 BPF JIT improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179418761741.1922711.9741403372080027028.git-patchwork-notify@kernel.org>
Date: Mon, 09 Nov 2026 01:26:57 +0000
References: <cover.1794165614.git.daniel@iogearbox.net>
In-Reply-To: <cover.1794165614.git.daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, puranjay@kernel.org, memxor@gmail.com,
 xukuohai@huaweicloud.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  8 Nov 2026 20:26:26 +0100 you wrote:
> This series changes the arm64 BPF JIT to emit shorter and faster native
> code for the instruction patterns that LLVM-compiled programs hit in the
> real world. Every change stays within the lowering of a single BPF
> instruction. This is a similar effort as done recently for x86-64 BPF
> JIT [0].
> 
> On arm64 under vmtest.sh (qemu TCG), test_verifier, test_maps, jit_insns
> and jit_insns_blinded pass in full, and test_progs and its cpuv4 and
> no_alu32 flavors only fail tests that fail without the series as well
> or only under TCG. The encodings were checked against Arm's machine-readable
> A64 ISA XML: every A64_* macro and directly called encoder, run with
> boundary and invalid operands (39028 cases), gives the encoding and
> fields the Arm ARM expects or AARCH64_BREAK_FAULT for what it cannot
> encode.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/24] bpf, arm64: Remove unused A64_BL, A64_BTI_C and A64_LDR32LIT
    https://git.kernel.org/bpf/bpf-next/c/0931830cc312
  - [bpf-next,v3,02/24] bpf, arm64: Free the offset table of a subprog in bpf_jit_free
    https://git.kernel.org/bpf/bpf-next/c/0ff09166d3d2
  - [bpf-next,v3,03/24] bpf, arm64: Free the private stack when a pass over the image fails
    https://git.kernel.org/bpf/bpf-next/c/346ea1557fd7
  - [bpf-next,v3,04/24] bpf, arm64: Emit ISB SY in the speculation barriers
    https://git.kernel.org/bpf/bpf-next/c/6a5b148dac53
  - [bpf-next,v3,05/24] arm64, insn: Reject sign extending loads of 64 bits
    https://git.kernel.org/bpf/bpf-next/c/182afb043e7e
  - [bpf-next,v3,06/24] bpf, arm64: Keep the ll/sc atomics address apart from the old value
    https://git.kernel.org/bpf/bpf-next/c/207aac32085d
  - [bpf-next,v3,07/24] bpf, arm64: Measure backward branches from the branch itself
    https://git.kernel.org/bpf/bpf-next/c/1963ac21c7c2
  - [bpf-next,v3,08/24] arm64, insn: Reject invalid and unpredictable operands in the encoders
    https://git.kernel.org/bpf/bpf-next/c/d860f6254d60
  - [bpf-next,v3,09/24] bpf, arm64: Widen the branch offsets before scaling them to bytes
    https://git.kernel.org/bpf/bpf-next/c/592f36e960d0
  - [bpf-next,v3,10/24] arm64, insn: Add the LDUR/STUR and TBZ/TBNZ encodings
    https://git.kernel.org/bpf/bpf-next/c/1fdba03c72cb
  - [bpf-next,v3,11/24] bpf: Divide by constants via uhmul and shmul in the verifier
    https://git.kernel.org/bpf/bpf-next/c/ffebe8b3e369
  - [bpf-next,v3,12/24] bpf, arm64: Consolidate the load and store emission into a helper
    https://git.kernel.org/bpf/bpf-next/c/1bb1bc5be527
  - [bpf-next,v3,13/24] bpf, arm64: Use the unscaled forms for negative and unaligned offsets
    https://git.kernel.org/bpf/bpf-next/c/6b3c7bde476f
  - [bpf-next,v3,14/24] bpf, arm64: Store zero immediates from the zero register
    https://git.kernel.org/bpf/bpf-next/c/e4939b2a54b9
  - [bpf-next,v3,15/24] bpf, arm64: Zero extend the arena offset in register offset accesses
    https://git.kernel.org/bpf/bpf-next/c/07d4e6947e37
  - [bpf-next,v3,16/24] bpf, arm64: Adjust compares with unencodable immediates by one
    https://git.kernel.org/bpf/bpf-next/c/a33de9a3bba3
  - [bpf-next,v3,17/24] bpf, arm64: Materialize immediates with fewer instructions
    https://git.kernel.org/bpf/bpf-next/c/e79c67bce1a2
  - [bpf-next,v3,18/24] bpf, arm64: Shorten the tail call sequence
    https://git.kernel.org/bpf/bpf-next/c/7dd5500c2c4f
  - [bpf-next,v3,19/24] bpf, arm64: Use mov or mvn for AND, OR and XOR with all ones
    https://git.kernel.org/bpf/bpf-next/c/4835c45b11d2
  - [bpf-next,v3,20/24] bpf, arm64: Use cbz, cbnz, tbz and tbnz for zero, sign and bit tests
    https://git.kernel.org/bpf/bpf-next/c/abf5971d572c
  - [bpf-next,v3,21/24] bpf, arm64: Multiply by constants with shifts, adds and subs
    https://git.kernel.org/bpf/bpf-next/c/c9c277f5e08f
  - [bpf-next,v3,22/24] selftests/bpf: Let the arm64 private stack check skip the BTI pad
    https://git.kernel.org/bpf/bpf-next/c/75e665d4892b
  - [bpf-next,v3,23/24] selftests/bpf: Test the verifier's division by constants
    https://git.kernel.org/bpf/bpf-next/c/099c2e03f9a0
  - [bpf-next,v3,24/24] selftests/bpf: Extend the JIT instruction tests for arm64 encodings
    https://git.kernel.org/bpf/bpf-next/c/a9fee553d3db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


