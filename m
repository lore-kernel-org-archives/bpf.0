Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC1423773
	for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591233; cv=none; b=uuSMki83QsjLG6BmDsKgI8dAVmeGNUdJaeeVCzMkv7DkL+EQB02jXhlsx5/kUHpN2m0XJnzeBB4VkT9ZhaLCX7skP/2FgMy4OPbE5iffNSFNjAZ3jbiAKQORApRZI+Lr1JwalRK3yo1+mL8bY6RqdIVuy9kA8mTnzN6rI7c6/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591233; c=relaxed/simple;
	bh=ztzwhAx9QyovKIbqUWmr8NLeDc7klSii1xxtKWycqNg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b3t5KBTvSAA2IivWye4HPhvMTLFeMyTwZRMkQ49t8rxsxoSVGldZNE14QyjD+sxsyqtOzg+EIzoev+PjqcBWSz9zo7FNGvj2fj3zCC+uvRNYokRQZrVXmX4KHSDFMeC6LuNUkba2iB1HFZC0BOKtkLzS2mRH/UFi0p3FizFXHRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6QR12Yb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6QR12Yb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D823C43390;
	Thu, 28 Mar 2024 02:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711591232;
	bh=ztzwhAx9QyovKIbqUWmr8NLeDc7klSii1xxtKWycqNg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d6QR12YbChSCB43huIzAP+x5QXpSmtt7sdapvWtFRYH15kA4Z9fI0Ti/o42CI8CoC
	 o32aLpo3kL11M17sXhpwjUMhr50qmykzm3tHe6jRoRhH1AhBfwBUEjw8RECgIPBaH+
	 JokZQjh1E/p5ZNuCF21eh9CbL9aZIqobc5eZmwWtukH32Q//jn7c2vkeOJu6Rn99ZF
	 ktA+tv0lQCxgxckfI8XnSm1fdYP5vLIuXDNrPPn4ywdFpDZr1jlA7svNdFOSxauLOw
	 iMW0FkxWLMYpPCXIbQprz99fsI2MF8T4ATzW+6f66nOyWvKUhUSY/juRnS8JkJemzQ
	 tXE27s3TUs81w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E8CAD2D0EB;
	Thu, 28 Mar 2024 02:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/8] bpf: Fix a couple of test failures with LTO
 kernel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171159123231.4663.15865277356511584592.git-patchwork-notify@kernel.org>
Date: Thu, 28 Mar 2024 02:00:32 +0000
References: <20240326041443.1197498-1-yonghong.song@linux.dev>
In-Reply-To: <20240326041443.1197498-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 25 Mar 2024 21:14:43 -0700 you wrote:
> With a LTO kernel built with clang, with one of earlier version of kernel,
> I encountered two test failures, ksyms and kprobe_multi_bench_attach/kernel.
> Now with latest bpf-next, only kprobe_multi_bench_attach/kernel failed.
> But it is possible in the future ksyms selftest may fail again.
> 
> Both test failures are due to static variable/function renaming
> due to cross-file inlining. For Ksyms failure, the solution is
> to strip .llvm.<hash> suffixes for symbols in /proc/kallsyms before
> comparing against the ksym in bpf program.
> For kprobe_multi_bench_attach/kernel failure, the solution is
> to either provide names in /proc/kallsyms to the kernel or
> ignore those names who have .llvm.<hash> suffix since the kernel
> sym name comparison is against /proc/kallsyms.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/8] selftests/bpf: Replace CHECK with ASSERT macros for ksyms test
    https://git.kernel.org/bpf/bpf-next/c/779012842209
  - [bpf-next,v3,2/8] libbpf: Mark libbpf_kallsyms_parse static function
    https://git.kernel.org/bpf/bpf-next/c/2c8bc4cf4d03
  - [bpf-next,v3,3/8] libbpf: Handle <orig_name>.llvm.<hash> symbol properly
    https://git.kernel.org/bpf/bpf-next/c/afc6524702c5
  - [bpf-next,v3,4/8] selftests/bpf: Refactor some functions for kprobe_multi_test
    https://git.kernel.org/bpf/bpf-next/c/de2c50ce88ec
  - [bpf-next,v3,5/8] selftests/bpf: Refactor trace helper func load_kallsyms_local()
    https://git.kernel.org/bpf/bpf-next/c/8cfdd77e94e6
  - [bpf-next,v3,6/8] selftests/bpf: Add {load,search}_kallsyms_custom_local()
    https://git.kernel.org/bpf/bpf-next/c/3fa5b1626130
  - [bpf-next,v3,7/8] selftests/bpf: Fix kprobe_multi_bench_attach test failure with LTO kernel
    https://git.kernel.org/bpf/bpf-next/c/ba4a347e17d0
  - [bpf-next,v3,8/8] selftests/bpf: Add a kprobe_multi subtest to use addrs instead of syms
    https://git.kernel.org/bpf/bpf-next/c/aa17f462133f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


