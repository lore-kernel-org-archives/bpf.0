Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791DE3C1969;
	Mon, 17 Aug 2026 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955456; cv=none; b=V2BL9aHVL7OWnZHVe5MIRXJbCeoFV2FbRXXxG186bNfNpPlGnl0/PJvuXrG4zfzKSAbNC8HfXzHKASDtcAYWxYWo9bvzGmpMhVQBAc8XEb1ZNoamzMS+saVZ98C7AR4Lcbs6dofH9ER+ivpjeMWpKFasxICbo6/dmyN75icz6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955456; c=relaxed/simple;
	bh=pubBK28YGQPYP9leBOM8pTWtR2dTBOEfilcYD4fIJRg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NsF9AgSDSisjd0bZoCEhgeNMGW2oxis4BV6SR2iO093Oa8Tdn1gx+FN1LkAOv4symAtVhim6VpIU4U5vE02hE28hWDXb4ADKqqepv/h7U/efY5CRNGYXV5ZlltSJD2Q7LAHF64qGvnBP6JBxde4Or+PEzeM3wnbcxrLSjgPxrEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9luvSEa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9luvSEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90F31F000E9;
	Mon, 17 Aug 2026 08:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786955454;
	bh=GX9hcnnkO7o5+JS87yeLaSc8Q5EbM/YDQW0+u5qquT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j9luvSEalTGEuUMPnf5RGCl6/O3NGQ5heW+6AHRmrNnFBPpShULgNhPAfLneldeCX
	 tNtIfN4nrFxjeI8/pBJ670WKMrOXrMlNoFDMJ9JWx2OAJ+xe3VAlOwb+YCAQplTTlc
	 BU55oUzHVfcdJwpFgVcyOMK1C05tjZrqSQ4DBcepeSYltkek/1LKAQ9Qx4hvf8vEti
	 Lgbbsh0DMsIupJuYzrpidy5+cDwxZameMPcJwBO0aqMqZt5wHwI+cYcIjNGwXPsV5y
	 1MiKmqqeS7QqiXMarTZWwlEjE8XHBuyN9qjj8KNgPzLA2q6fylj6sLJJloz2eqC1Ez
	 edhSWtCy+aCTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568A53924FFD;
	Mon, 17 Aug 2026 08:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: Cleanup & optimization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178695540692.1014497.7617215673490859159.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 08:30:06 +0000
References: <20260813-sockmap-lookup-get-ref-v1-0-31f5d55f44ac@rbox.co>
In-Reply-To: <20260813-sockmap-lookup-get-ref-v1-0-31f5d55f44ac@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 kuniyu@google.com, willemb@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 13 Aug 2026 14:41:58 +0200 you wrote:
> Non-functional cleanup and a refcnt bumping simplification.
> 
> Series extracted from a fix attempt[1] currently under discussion.
> 
> [1]: https://lore.kernel.org/bpf/20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co/
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Extract shared reqsk-to-listener upgrade
    (no matching commit)
  - [bpf-next,2/2] bpf, sockmap: Use sock_hold() instead of refcount_inc_not_zero() in lookup
    https://git.kernel.org/bpf/bpf-next/c/34e0eb763bec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


