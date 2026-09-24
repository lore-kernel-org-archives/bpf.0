Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D723B5F48
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214678; cv=none; b=OyzvZVEUKsScvx55KPZliyt/1Z0dyRqKzFd0yJoS4ni2IXkDOeDe/jiAKbvgij7IojpvOa1CmUR3NUybfNGsVY7v62B9YkaotTRtjAMCgmlOLHWNzoJ7aU+O9+8nOIkfHMeDYAL4QY0KwgglwIxZss+ls6aa6UqPdlnxCOl8YYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214678; c=relaxed/simple;
	bh=9HgYE3q8aGSgzqYmsFaiteG77wUdES0BZzi1nW2Iv9A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DpNC1ard13v62V2ISu2V4LkW7wZwnZoEn+xjkQKcWD7UqAOEX70bUScXrmmbYk8lXFXQ66Y/Zvr/+EV/SwYvkSkT2HwUwnj1CUPCFIhvWDpnr8e0JMKp7v4wei/z6foO2l7yfJz5P+bTFi+wA6DuSaNiH3vC91+PavmDZffJTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lerCvWoa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lerCvWoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877A11F000FF;
	Thu, 24 Sep 2026 01:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790214675;
	bh=61ZO+nO+ELJ0hqxoqolFd4/zeWzpuOA49/6Pdyok8NA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lerCvWoaa/T1PVTH76Y2R+aY7Cl/fZ2MKDW6qI6AKy2NKvvJEebYJAYnFDYJKStKK
	 zxt6W62+oaXXH+UB7jtvzsMIetCcA8uu9j8PyOHkjxT3mvFE7ERX2xooNv0t3ng871
	 hskXDzooCI6tDSI9cBNOCrLF4DxNTNGBwIRGUagwHKMI5Dd6qKYc3v6tT2TmkfIYgg
	 4sEWsvJ2qi7GdGv98L/RnF7owZxEk+jyj+l3OWPNsDrB+Rr5l1v7nTG62wcmnSSqb8
	 7gh8VD8Q8sySI3FfKuU76TXrALWob5cby4K7JuHeTRuP2KpmaQfYZyXhD7onhVD6wL
	 Kpy7WPIg+Lafw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567FD39E9611;
	Thu, 24 Sep 2026 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Refactor cb_refs selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021460516.1272040.16158974939787437095.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 01:50:05 +0000
References: <20260923230717.3156345-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260923230717.3156345-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org, broonie@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 23 Sep 2026 16:07:17 -0700 you wrote:
> cb_refs matches verifier messages such as "Unreleased reference id=4
> alloc_insn=3". The ID is allocated from env->id_gen, so it changes
> whenever the verifier assigns another ID earlier in the program.
> 
> In the bpf tree commit 71919742c83c ("bpf: Assign lock identity to
> callback map values") gives each callback map value an ID, and the
> nested_cb expectation was changed to id=5.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: Refactor cb_refs selftests
    https://git.kernel.org/bpf/bpf-next/c/11300f54bd88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


