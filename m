Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85202BD00C
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169810; cv=none; b=sCUNb6ES+Z9OnHI5yeeznaajbfMVRTb2gUzQySGQXqwHMMTMUHBxiYXK7SYSSIJ146WkQ8bvaTAYeV26OGfMWH/w8xx5tDL8HuHtssSNXocuR8arDlpVICHg8nDtB99nE0xFhV3YPhYWZQHPQGp+hl79T4nKZHRUjgz4V8ryhAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169810; c=relaxed/simple;
	bh=4b66wyxKf5H+nD95WG8h7ysE8D5iM9uK3UeTodefuKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UZLojZxoO7pjcEpk50Z3lFDl0wsGEOnKyOunLn9ugjtZUR+fBpHde1jR1vDKWHUXRYYQjeeu3wYsHicYB9kPI7RFXp6foLfVqRpdaGo6oGl5IdZuBWXuP1cziZKdl3cbi/8n+n81GAi79XlElY/RLxg80ONtjUHszeMNLe1Sww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKBtTwy4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKBtTwy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5927FC19423;
	Tue, 10 Mar 2026 19:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773169810;
	bh=4b66wyxKf5H+nD95WG8h7ysE8D5iM9uK3UeTodefuKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EKBtTwy4XFoAiyRnzr2Sa7H/fevqrdCLl17bc8nU0JLdtEjG/YC4FYNJMLmlwJ2Iv
	 3HwgrsAf3PuJngwr/7ZEjaCeSyfqBkeGdfYCEBBhvu59MC6+eTFJDiEuQDV6xCLN+C
	 YbR79JLPcNHmqlQtYwic4nhGHn9x3tcqYXYUZzsmmAQDOhbCHYcb85BocSKjt01jX5
	 W+UQykbGl6rLnB9Bj2FjkfeF9ZYuB4VDrzqja6y6cImVRRdrYTxpgqODkzHXAHaAAZ
	 vMky7vRSXRH1LiOeTELAPXdcwIhhHB2h/1lDMVyUg+t39fU8y0o8opNdydYtzUyw5b
	 4dqqnJ4zyZcLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF493808200;
	Tue, 10 Mar 2026 19:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Fix pkg-config call on static builds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177316980680.2469448.6126882075540124991.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 19:10:06 +0000
References: <abADBwn_ykblpABE@mail.gmail.com>
In-Reply-To: <abADBwn_ykblpABE@mail.gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 10 Mar 2026 12:39:51 +0100 you wrote:
> For commit b0dcdcb9ae75 ("resolve_btfids: Fix linker flags detection"),
> I suggested setting HOSTPKG_CONFIG to $PKG_CONFIG when compiling
> resolve_btfids, but I forgot the quotes around that variable.
> 
> As a result, when running vmtest.sh with static linking, it fails as
> follows:
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Fix pkg-config call on static builds
    https://git.kernel.org/bpf/bpf/c/e06e6b800123

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


