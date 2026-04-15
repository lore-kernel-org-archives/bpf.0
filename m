Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A232A3EC
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 03:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776224831; cv=none; b=mAC2N6YznWDmsERYBH8jGO1zXjqZYpjHaRu+3ESbRPy278G+59XyeVu6PyQgiCp6wjMtWhQzA4Fw1NyxJklMhjE+Vry5g8WRMN3YSlleuWpCaKE0qrbjtKFNLPWvjYBMUA53qBi4c/0P44OMIGa4waoI3xOh0AyB7wIubBMaZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776224831; c=relaxed/simple;
	bh=8Fhipxe7y3f0Q5g6ZxelI3bBZS834wn1hM9Sq09qjb4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GATWHADWw54jVPVOedzc4kXr7UDZfEbXROQy3Dzdeagrj3/WZ3LEEV1rScVzQDc3qwPtgUuR2CrN+1M2ln4SwkQR/VCs/XfBc9RDedNN5A3R+qRjmwHqmTuLfFssYasZqnH1xDjlg9KD8SG7e9TV+hA4x29uwfjeVuTHycCp86M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRERVpHt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRERVpHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBC4C19424;
	Wed, 15 Apr 2026 03:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776224830;
	bh=8Fhipxe7y3f0Q5g6ZxelI3bBZS834wn1hM9Sq09qjb4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tRERVpHt6b0aCpjpoypI9hWwwtsn+xqe+AhWSsexjg1FabdoGlpDA2PILuCZvYwdn
	 3l6Tx0O192hqEpMtnWYzKu1xb1S4ylIr+u/d8cq/wD5B8aeESyXbUX1bSL7qCtav7T
	 AyOIqFZaHQFDvrvsisezegL09JhXLEi1JktsCVzgg+De2A6pKgLWsHl0YMsEzJAZiQ
	 uQ1EULCZIDAmtu6kKlT9O4dqjVhgOOOZ9WE6J1hn5/NQKr4tGJNdTZNzZzVRwyXvRn
	 86Bidn65xMSPJYxS3BXtQnLmQX+b4B62rubAbRxdZzvgc2UrtlDEFCrvDbk6rJgny/
	 ghBdczblrGyYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F953809A33;
	Wed, 15 Apr 2026 03:46:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] BPF changes for 7.1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177622480029.1597933.8340078808998982134.git-patchwork-notify@kernel.org>
Date: Wed, 15 Apr 2026 03:46:40 +0000
References: <20260413174732.87983-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260413174732.87983-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Mon, 13 Apr 2026 10:47:31 -0700 you wrote:
> Hi Linus,
> 
> The following changes since commit d8a9a4b11a137909e306e50346148fc5c3b63f9d:
> 
>   Merge tag 'v7.0-rc6-smb3-client-fix' of git://git.samba.org/sfrench/cifs-2.6 (2026-04-02 21:04:28 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] BPF changes for 7.1
    https://git.kernel.org/bpf/bpf/c/f5ad4101009e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


