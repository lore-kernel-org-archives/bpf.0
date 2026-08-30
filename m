Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3C52A1BF
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 01:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788053477; cv=none; b=WcvLESiJNzJNJfQg9JhpAqJbrkLTfE0Ubqjnt6zvb0bqOTFhCwwltGIm7Z7d6/5N+DZ9yTvg9hxNgnk1sdyJJoDT2FJis8Kbw8sq2mC1UMmSZj/knJvQ0VRvB6374MQxZBt25IleK1BMaqwXwC470KFB8LO/Mnn0aTrfbRvditE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788053477; c=relaxed/simple;
	bh=t6p6UbkpImgS8VZm4SgS3lF+PwG+cl4ELeTaDBMLWnM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DG98U10+TOVcGURdy/ol7Cc4DSZ2Q+VPDm64lmnX84s2Gv+Wc1asEtivMA9t1pfzmKBSNeQjYT/NiaT/P9JEQOmA8wQoGCH1/5y8/eJP3h6R++0x8DW5fbDp1Ya8Ag3CrZEIYYljVyy/zk09ZjWPg9SJOZbtDKe6LFDZyZl/3nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxnSZJ+s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxnSZJ+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C8D1F000E9;
	Sun, 30 Aug 2026 01:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788053476;
	bh=at/ivU5IEcNOcAKlyGcvupTZhnY9Cc5I/HIvJba168M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SxnSZJ+sa/0s9FHnuuJPj9wIX1/H9vXZrRxm1NMiRzT5WAY3W4uHsjLxnfOzwBBXp
	 WwsdgARKzh8IaYx2hoIxZQ6gptS0uY30IoeDe8TkfRPfqJhF5JWeyquldWgVBW7Pdr
	 E0zsYM2W3qvw9ZtMz1sJeWj+8OfDRtWi20hIG/YHvBOXfYpi0kjugwClnyHM+mG9QR
	 3gacBozdZYOqWOHm/ficYDyf4uxaPNmpBHKTf8X9HWuuMMcYSVaG/9Rnd7upf6EMrc
	 xCgCpvlluwIStHM+n8hyuFySJw+dzqTbpo7o99HxRFPE3UvvWqajNjvJEeu6KWggRz
	 84vnXgVjV9GSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4273380CEE0;
	Sun, 30 Aug 2026 01:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/6] bpftool,
 selftests: Add tests for C dump and fix a dropped type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178805342039.3194634.18184271808930836434.git-patchwork-notify@kernel.org>
Date: Sun, 30 Aug 2026 01:30:20 +0000
References: <20260828215207.3105313-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260828215207.3105313-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, qmo@kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 28 Aug 2026 14:52:01 -0700 you wrote:
> "bpftool btf dump format c" generates the vmlinux.h that BPF programs
> are built against, and it has no direct test coverage. Building
> against the header is not a substitute for testing it, nothing a
> compiler accepts would break the build.
> 
> Add selftests targeting C dump in particular.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/6] selftests/bpf: Add compare_text_to_expected() helper
    https://git.kernel.org/bpf/bpf-next/c/bd71904697c6
  - [bpf-next,v2,2/6] selftests/bpf: Modernize btf_dump test scaffolding
    https://git.kernel.org/bpf/bpf-next/c/c0722dc3288a
  - [bpf-next,v2,3/6] selftests/bpf: Compare btf_dump expected output in-process
    https://git.kernel.org/bpf/bpf-next/c/122255fb1933
  - [bpf-next,v2,4/6] selftests/bpf: NUL-terminate bpftool command output
    https://git.kernel.org/bpf/bpf-next/c/4f8a4c76f670
  - [bpf-next,v2,5/6] selftests/bpf: Add tests for bpftool btf dump format c
    https://git.kernel.org/bpf/bpf-next/c/438147f7f601
  - [bpf-next,v2,6/6] bpftool: Don't drop a type in the sorted C dump
    https://git.kernel.org/bpf/bpf-next/c/ff01f88a9136

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


