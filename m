Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792989007;
	b=IXysd95Qj3HT6QwenF+YCg2zTfuK0NfT2I7TwsSC0hmtCfMj4x06lqLD+0QNYL18me5R
	 6wU2E8IQ7KiqfloKR1o2hiY48NOEwxBieZhpsRU3+xDxul8I1ohz4NTrsLvCpFqlOO3sB
	 FbtWVFm/1DBlXfakToLFe3kPU+l2QMYIi6gQF376lU831NeyE8dyqrD8vzpgThNynDeDa
	 gKr5oTLAa8uTLbt7YiDnwt4iV31fLEtRI57FLzxcgtHHJ+8CglUkiH/HsS2PZ54r24rbR
	 KonOxw3yxplhG1ot/Tk9utmYnEcS9Aia1QjBFnptmSRva1LYYQBOBii5AN+MSjS9HiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792989007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=EuveSYZxvjMwdG3eWJqms3fOhDKBp2n6TwGN5Hewj7o=;
	b=0T1gnQk9d1ot5XDCYmxcvZVtxcqfQAf/SFwTBzHFFnKn+jgF4Q8jtJ9vkgcON76Yi0Fz
	 ZDbAXwCwbjxSf7P8ugHyFF7Ed8cdya25xq4xY+h6vhkrwlC3vmih6DibQDbcCgFlnG+ew
	 6DjeWpS9lBFqvQ5sWFBMYTdvvzTgb+Czw8WjHV526Q4TV42eUaze5cOrLJ8s8fT1s1GUT
	 VHMxdzlBVBxcazHRB0V0YQtJdjkfYCxqc7eeqmFOiGNZcxY4/8kC6hPnVqM7IDjaMG53G
	 unsy4SBtVMMNz09Gg28uNi4t3gd35DW5gREYhL3WkYOwMIyxB3E/H1dcc1g2l0UAAKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vpkw1aFL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C9606A31E;
	Mon, 26 Oct 2026 04:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vpkw1aFL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896181F01825;
	Mon, 26 Oct 2026 04:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792989006;
	bh=EuveSYZxvjMwdG3eWJqms3fOhDKBp2n6TwGN5Hewj7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Vpkw1aFLHADKuYm2VNkS50RygSCi664Ys3rNrH4lKnAomEmA9vJocvnMx813p0N1k
	 i12bUf6w1VjNE5ooYVX4Wkapaux/jcy3k5EYVflvl2CEhWdeW1GtTjEHidWSe1pT7V
	 BwQF6EnfsvZqTVhXWF19ojaoEwiL5KI03xyU4B+G8qtsCKUKXg167TmgzY/X29Qlak
	 qUnLL4aGLSue/qNzymvhjMwloYZTd/NfP+qUmvrqNgum0Qfh4acsBqyrkG/hlwjFJg
	 z8snjsB6ApkKjSsStMFfLi4W9LJFgf89Sbgp6WRg9eS0WWZ1z0C3SjufkUwjbnTfmP
	 pGgVHVZGcfS2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 815B939EA761;
	Mon, 26 Oct 2026 04:30:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf v3 1/2] bpf: Validate stack arg reads against caller
 state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179298900532.2459690.805384045244174324.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 04:30:05 +0000
References: <20261026015250.1674676-1-bestswngs@gmail.com>
In-Reply-To: <20261026015250.1674676-1-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, co+eada64ce90ecebce@bugs.sh, xmei5@asu.edu,
 alexei.starovoitov@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 25 Oct 2026 18:52:49 -0700 you wrote:
> check_stack_arg_read() bounds a stack argument index with the callee's
> BTF-derived argument count, then uses the index in the caller's
> stack_arg_regs[] array. The array's actual logical length is recorded in
> caller->out_stack_arg_cnt, so the bound and indexed object can diverge.
> 
> A crafted BPF_PROG_LOAD can use an argument mismatch to mark a static
> subprogram's BTF information unreliable. Later calls return from
> btf_check_subprog_call() before check_outgoing_stack_args(), while
> check_func_call() continues the static call on -EINVAL. The callee can
> then read a slot that the caller never allocated or initialized. The
> earlier commit 4286f5deee14 ("bpf: Validate outgoing stack args when
> btf_prepare_func_args fails") closed this hole for the first call, but
> not for later calls after the subprogram has been marked unreliable.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: Validate stack arg reads against caller state
    https://git.kernel.org/bpf/bpf/c/90aedf8854c0
  - [bpf,v3,2/2] selftests/bpf: Test missing and callback stack arguments
    https://git.kernel.org/bpf/bpf/c/195a3519ff27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


