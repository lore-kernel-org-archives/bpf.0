Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415592C21DF
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095223; cv=none; b=bN5UxeUVbFnjV8M33UZmP5nZ231Ves4ZBBTa8a7ohWnZKg0Igi1SDms8hnYKWtZvlgcgEqKHX92csTyZW2XUmnU2T0u4964m2BhQOvy1AGCXoXkDVSBG6uAUTkg4u+vyehM3/ul+ZJnVxqXc4Z7Uieb5i/owzRzgyuYSbbyvOz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095223; c=relaxed/simple;
	bh=AgeXq6QvjOPitG7znwF/1Ku1oyh6lDZoT8rXk8V43D4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V2QTG40r9YFjvKJaeKziMYzpaScb8c/qjzYNtUReM5BmdDvY8g7T3JzF/NjudQG9Jjk7maZfvo6/BYz+ZxU+J7ZUJ2AMfpg2iQEsg1gBGor86O1g2fgrGSIPO7Oy8up8XijfN5AHnnwY6P+FhsgpqSYNQJFwavqqEq4nNE0qAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMCgtk0k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMCgtk0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B9BC4CEF7;
	Thu,  2 Apr 2026 02:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775095222;
	bh=AgeXq6QvjOPitG7znwF/1Ku1oyh6lDZoT8rXk8V43D4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JMCgtk0kJ5bg3xrDEUU7uVMDZRnmMLCuPkQCSYQbqW+IkBOSxFbsP9e3WjTCq0il7
	 n+Lpve5wVvGCnmde5Evu/lWSe86fPD9NVf5d+N4C+WkxY5qpGgIGhlTBfypA1xSNp9
	 C6VRPC3tJVwG8i05PCG3rHQ0Nxht4oOVQpVKJr+7mD4Z5V2T3pjc3F+XL7ibywFhx6
	 wOrOlEEzgUyqQUXHUY+xPtxkVTRYjTCH5AUIoFvz8+9bq6F+89TDl3yoPUEGDwDt3M
	 gqmADG6sshS2No4u3hdj8TjelIG5y84lWthzAdh3dedURh8TlOiJBO9Q3yJaoJjaz0
	 TS0AiFwU0ZMUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EAA3808203;
	Thu,  2 Apr 2026 02:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 bpf] sockmap: Fix use-after-free of sk->sk_socket in
 sk_psock_verdict_data_ready().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177509520554.3948497.7609030558955915031.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 02:00:05 +0000
References: <20260401005418.2452999-1-kuniyu@google.com>
In-Reply-To: <20260401005418.2452999-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, martin.lau@linux.dev,
 ast@kernel.org, cong.wang@bytedance.com, kuni1840@gmail.com,
 bpf@vger.kernel.org, syzbot+2184232f07e3677fbaef@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  1 Apr 2026 00:54:15 +0000 you wrote:
> syzbot reported use-after-free of AF_UNIX socket's sk->sk_socket
> in sk_psock_verdict_data_ready(). [0]
> 
> In unix_stream_sendmsg(), the peer socket's ->sk_data_ready() is
> called after dropping its unix_state_lock().
> 
> Although the sender socket holds the peer's refcount, it does not
> prevent the peer's sock_orphan(), and the peer's sk_socket might
> be freed after one RCU grace period.
> 
> [...]

Here is the summary with links:
  - [v1,bpf] sockmap: Fix use-after-free of sk->sk_socket in sk_psock_verdict_data_ready().
    https://git.kernel.org/bpf/bpf/c/ad8391d37f33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


