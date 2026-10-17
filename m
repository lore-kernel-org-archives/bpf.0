Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06EC3451DA;
	Sat, 17 Oct 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248607; cv=none; b=nCs7OlgLYIg2LlaKUrklrbyeOTy5fwU60LnXwFlR3JkbNhUzBs8sSOWNK4REeIfG5qQiMlCtE97bGTLKTJ9ZY2TjWtgoWf0eYOJnwnExXeTFI52mzF7E6L0rOOG18vzND9Va6dN2COVmWSTvQ9eQS+u/thSU/WLIBp4Hpj3a7yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248607; c=relaxed/simple;
	bh=aOw8WTvIUT04mkmectCcHghGlY0fcuUihqp7YFre96M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iXvNTqs1TC3i2G2uV4RZffjSmGAFR2aDOkxU2eKoKzOCq+zBOsDPmZ3bmdQ6Zy25X0+5OsQa20Yt5i4FdiGZGKUCIuT/6Sr9Vu8WhxbVYRKiyZiavCNtndYIZlEDu7I8M7L8Hx+XnnrqkVloqCqFcqRsSWHN4vD2Yxx5X5sZV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbgxpblW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbgxpblW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2871F000C4;
	Sat, 17 Oct 2026 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792248606;
	bh=wG7qiAl+Rvy8noPtXI5iAzwiIXldCE75cshh7ohCKgU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gbgxpblWv7UNtDqrYHfXUA9Bv3ALgqF7O7kYec+eXyR0aX+zb5ec6/syO0WqOB7ww
	 6mPfvZDZD6wYuBQ2HMprAw/TbzBN2uZLWXKL8pW0bAUJ/5A48vGu6qMY5pDIrx7o3q
	 bYtginJuk39pALDQ+fnQNzYx38ppbD/g4xK00JBQKtCG7IsAj1HOalwCu3JMy3ACZu
	 QW4qjBg2KW005eWqorsu7+ANyBgoaUy/gjGgvL9FO09NPaBmbl5wXtEvbG1Ii6IgiP
	 NG7B9mS1fLJuCK2S94r6w3MBECyUV6KvW9pxOH5NqlxyWcLKANPy4S9I4VQfzP7Yzb
	 Y+Sk8PZYttERw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774ED380CFD6;
	Sat, 17 Oct 2026 14:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] bpftool: Fail map dump for maps that
 can't be
 iterated
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179224860527.1268583.11977700163601405121.git-patchwork-notify@kernel.org>
Date: Sat, 17 Oct 2026 14:50:05 +0000
References: <20261016194825.230433-1-skokovmaksimevg@gmail.com>
In-Reply-To: <20261016194825.230433-1-skokovmaksimevg@gmail.com>
To: Maxim Skokov <skokovmaksimevg@gmail.com>
Cc: bpf@vger.kernel.org, qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, kuba@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, hi@tychen.cc

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 16 Oct 2026 22:47:55 +0300 you wrote:
> "bpftool map dump" treats only ENOENT from bpf_map_get_next_key() as the
> end of the map. Map types that can't be iterated (local storage, ringbuf,
> bloom filter, arena, queue, stack) fail on the first key, and bpftool
> prints an empty dump, "[]" or "Found 0 elements", with only a non-zero
> exit status.
> 
> Patch 1 adds a helper that prints ENOTSUPP (524), which the kernel
> returns from some BPF commands, as "Operation not supported" instead of
> "Unknown error 524", and uses it for map create, map element
> operations, map freeze and prog run. Patch 2 asks for the first key
> before printing anything and fails with the map type and the error.
> Patch 3 adds a test_progs case on a socket storage map, and on a queue
> map without BTF for the plain output path.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] bpftool: Print ENOTSUPP as "Operation not supported"
    https://git.kernel.org/bpf/bpf-next/c/b32b4956d451
  - [bpf-next,v5,2/3] bpftool: Fail map dump for maps that can't be iterated
    https://git.kernel.org/bpf/bpf-next/c/70ac4de43ad1
  - [bpf-next,v5,3/3] selftests/bpf: Test bpftool map dump on maps that can't be iterated
    https://git.kernel.org/bpf/bpf-next/c/631fee3f5a18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


