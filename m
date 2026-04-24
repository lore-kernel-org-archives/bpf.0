Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE5C2F619D
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777002049; cv=none; b=GwooR7k4e1L8S0vjplLdour+2jicAQVBqTLTJ/F9iCsnvf0c5PBri3BgCaofcB5+YHs0Q4JNl4Dl+mPybzC8/A1mpjxsnmqX5doq5dwYNopg+NbTgWU1kHqR9NYcuVwC7dckBxqiidMhfOnOAoWjEqdS0eUx7BBlIjy7BkaAJFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777002049; c=relaxed/simple;
	bh=/YR11Lb5/5n/d+1qZoVCIOZw0aorg646tTm4B0P92UM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UgR4weuP3ZzTFJKfm4u06GWlTMQotFrilGLxdwnpcVlJb49P5jppkk+Sx1ZWbMihswjE99V1PO5yTLdeJq24swNc7XJLJSfrMFUcmalSYohrbV9afwERbcQlZ3Y+BTBYly5LaXPbdJhE5PA8yegU9azPvAWv0VpbsI7c4bJXsME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgcdMVRY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgcdMVRY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817E2C19425;
	Fri, 24 Apr 2026 03:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777002049;
	bh=/YR11Lb5/5n/d+1qZoVCIOZw0aorg646tTm4B0P92UM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TgcdMVRYxKBTx+GTooFrFqb95n6Cz1wtDv8H/a+WaM/0yrMJgSxf9lhyIcTSEgChM
	 7SjJcL55M/O1bN3ypOzfB45bV7x2RrSZbxRh/zXZOOyi7FfD1CHul4PSsAemvqjpXG
	 Yi1VtEtCMesUyYWgJt7I8DLNNmRqUM94JozihmpjFkepCkGR6C8AFzJEK4qS1RvatO
	 piU8FYirDpHWCRBQNaIEz6x8/PluDYvvyrkPLVhPzfIaIc1Q3cI/eIL8yh9ACCRUF2
	 v2cpWPzzz7bZ5/qmMgQy0QsXzamWi+xAe3mj5oX9MwmZdK5y2fOioxOM0THEdmZePV
	 6wmqb5V/hxAvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9CFD3811955;
	Fri, 24 Apr 2026 03:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf] sockmap: Fix sk_psock_drop() race vs
 sock_map_{unhash,close,destroy}().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177700201030.900079.374070181715062663.git-patchwork-notify@kernel.org>
Date: Fri, 24 Apr 2026 03:40:10 +0000
References: <20260420194846.1089595-1-kuniyu@google.com>
In-Reply-To: <20260420194846.1089595-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, martin.lau@linux.dev,
 wangyufen@huawei.com, kuni1840@gmail.com, bpf@vger.kernel.org,
 syzbot+b0842d38af58376d1fdc@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 20 Apr 2026 19:48:41 +0000 you wrote:
> syzbot reported a splat in sock_map_destroy() [0], where psock was
> NULL even though sk->sk_prot still pointed to tcp_bpf_prots[][].
> 
> The stack trace shows how badly the path was excercised, see
> inet_release() calls tcp_close(), not sock_map_close() yet, but
> finally reaching sock_map_destroy().
> 
> [...]

Here is the summary with links:
  - [v2,bpf] sockmap: Fix sk_psock_drop() race vs sock_map_{unhash,close,destroy}().
    https://git.kernel.org/bpf/bpf/c/6451d58a3556

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


