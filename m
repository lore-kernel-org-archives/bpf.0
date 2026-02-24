Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE8121A459;
	Tue, 24 Feb 2026 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902026; cv=none; b=TF4PnPX9OfVLVA9MgYI6AJ1WpSb2PsgBjBqqVP6BUgK9wBk9+/huzTBHEeHzRBlIin+WubMhJ32ih64TRkZoIsfdRY5YqH1YBVOAyk62b9Nrw94PBYxl+NfA3B+nszN9sfbcnYoIKJhyfT4RCUK9d7d9tabWvmN8eeLSiWadBy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902026; c=relaxed/simple;
	bh=tSi8HdRwhZ4zapySywIOmzb9ESqD4kwO99QktYIcGvc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qkube+apPXSTVHbJDa3nfsyKUHG58/syX4Yk8I1ovUv0U7mwVECFSuc+OSkBJKgovfbF7cjT+EQWOLiGGidapmn/eSaGW/JGrLvdQxeIRWfYZ/qu8fNfi329VnNW2Cbom7z3VWBxoU/UKlMmi0Nc/gLOJ3YI2zNIQ8rJ8Fdhs8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taMbzKBu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taMbzKBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E9FC116C6;
	Tue, 24 Feb 2026 03:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771902025;
	bh=tSi8HdRwhZ4zapySywIOmzb9ESqD4kwO99QktYIcGvc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=taMbzKBu2Bq9j0Z40WNqVrlTkK/WZbNkdLVQd3OMcP8H+0apETZaxNBzLmkTS0vlu
	 SVfFe//+G4MREZPpHUncvGOZjW1BUv4SecuzoTK5rehRpNrPzeu2UuZkSGlGxRC0JV
	 mJ3XVVdoYaupeeSyFyV9KIomXZeFbfEBCdna0/f2iD0weoSM2vIdKEYQqnN9MpSJGm
	 xq9mQKx+h9FOWERA2128trDBsKn+kMHzI/N1+/yoD6wqYtwtuze1cIVHcnL/17IzE6
	 VjNt2oktcE9Vsl4m8qXUSfnPqOVpL0AvFRURREHU2AqwtXrSIE5sYTMS0e0R+sKwT9
	 aXfL2CuLPu/Fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D643808200;
	Tue, 24 Feb 2026 03:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 00/20] selftests/bpf: Fixes for userspace ASAN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177190203179.3291650.5550860539555741440.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 03:00:31 +0000
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260223190736.649171-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, olsajiri@gmail.com, yatsenko@meta.com,
 alexis.lothore@bootlin.com, ameryhung@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 23 Feb 2026 11:07:16 -0800 you wrote:
> This series includes various fixes aiming to enable test_progs run
> with userspace address sanitizer on BPF CI.
> 
> The first five patches add a simplified implementation of strscpy() to
> selftests/bpf and then replace strcpy/strncpy usages across the tests
> with it. See relevant discussions [1][2].
> 
> [...]

Here is the summary with links:
  - [bpf,v4,01/20] selftests/bpf: Add simple strscpy() implementation
    https://git.kernel.org/bpf/bpf/c/63c49efc987a
  - [bpf,v4,02/20] selftests/bpf: Replace strcpy() calls with strscpy()
    https://git.kernel.org/bpf/bpf/c/6a087ac23f5b
  - [bpf,v4,03/20] selftests/bpf: Replace strncpy() with strscpy()
    https://git.kernel.org/bpf/bpf/c/05849ec34f3d
  - [bpf,v4,04/20] selftests/bpf: Use strscpy in bpftool_helpers.c
    https://git.kernel.org/bpf/bpf/c/f074d8941c29
  - [bpf,v4,05/20] selftests/bpf: Use memcpy() for bounded non-NULL-terminated copies
    https://git.kernel.org/bpf/bpf/c/6fcf7925e334
  - [bpf,v4,06/20] selftests/bpf: Pass through build flags to bpftool and resolve_btfids
    https://git.kernel.org/bpf/bpf/c/b1dc4f39b541
  - [bpf,v4,07/20] resolve_btfids: Fix memory leaks reported by ASAN
    https://git.kernel.org/bpf/bpf/c/08a4ab51771f
  - [bpf,v4,08/20] selftests/bpf: Add DENYLIST.asan
    https://git.kernel.org/bpf/bpf/c/7661538bb7d2
  - [bpf,v4,09/20] selftests/bpf: Refactor bpf_get_ksyms() trace helper
    https://git.kernel.org/bpf/bpf/c/536abce60307
  - [bpf,v4,10/20] selftests/bpf: Fix memory leaks in tests
    https://git.kernel.org/bpf/bpf/c/f8e7eccf33d3
  - [bpf,v4,11/20] selftests/bpf: Fix cleanup in check_fd_array_cnt__fd_array_too_big()
    https://git.kernel.org/bpf/bpf/c/e4093ebf3db1
  - [bpf,v4,12/20] veristat: Fix a memory leak for preset ENUMERATOR
    https://git.kernel.org/bpf/bpf/c/10d19e708d3b
  - [bpf,v4,13/20] selftests/bpf: Fix use-after-free in xdp_metadata test
    https://git.kernel.org/bpf/bpf/c/4650dd3ea4ac
  - [bpf,v4,14/20] selftests/bpf: Fix double thread join in uprobe_multi_test
    https://git.kernel.org/bpf/bpf/c/a9b15811ef10
  - [bpf,v4,15/20] selftests/bpf: Fix resource leaks caused by missing cleanups
    https://git.kernel.org/bpf/bpf/c/547a83e93a48
  - [bpf,v4,16/20] selftests/bpf: Free bpf_object in test_sysctl
    https://git.kernel.org/bpf/bpf/c/1907d7a6ca0f
  - [bpf,v4,17/20] selftests/bpf: Fix array bounds warning in jit_disasm_helpers
    https://git.kernel.org/bpf/bpf/c/68da3afd0bf0
  - [bpf,v4,18/20] selftests/bpf: Fix out-of-bounds array access bugs reported by ASAN
    https://git.kernel.org/bpf/bpf/c/a3f40c2890e9
  - [bpf,v4,19/20] selftests/bpf: Check BPFTOOL env var in detect_bpftool_path()
    https://git.kernel.org/bpf/bpf/c/fe9f7aa74767
  - [bpf,v4,20/20] selftests/bpf: Don't override SIGSEGV handler with ASAN
    https://git.kernel.org/bpf/bpf/c/db7337948c7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


