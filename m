Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5360155747;
	Fri, 11 Sep 2026 00:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084871; cv=none; b=DRSE68ilki3vK2+cVfz/TkkA2/aMUDGgIpBhaR+NrYvFfCuRzm6+pSeiPIc47TCsJXUY69uY/29PU678SCrxPv15aV5sKjl2Z1I7gqIQB9ca+6CVk6ZOWCEeEJTBbafNE1sGaf5WqqJVXrhN1vXKMa81bKLEUxLTlWRGYRojNP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084871; c=relaxed/simple;
	bh=kYOCWEPyTwYJ+UXMhHHPV90gDLB+s9KdK/WnD+3jswU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TpF4qHCSUBPbJzIq+EjjB5gZDz4LnojoSBdHMwLL4yhiKvP5hSaFSfOn9vyKSCty3+ZmbyQaqW4d+OpWmRPjrVvJHRSvBVg2zRoozmjl2U7LwjWsfSjc1WUyNVhHRNOmi7C6SJed1+oRI2yOA46DAD5iHE3tIJrLcaK5FluWW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TS8lRSh4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TS8lRSh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10481F00893;
	Fri, 11 Sep 2026 00:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789084869;
	bh=QB486oFxzAhnhFSsmKGYqnG8JaJNWaIYF0JI1tL5CbA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TS8lRSh4DOzEn5htqnj2j4gGtHtDRA71l3KaGeuoPu38gBseLrICquaiyt0YJPavk
	 dzDYy0yta8G0EJbn9oyBPWt0yFXLI9Bfh2zl4zXQ5k3KY6pDiAVFX3G9W4mcNTW6Gm
	 KbgURHav3g6qYr5ppe7xk4y7jNtK8iMB9LkWJ0KzVFF7pNVfwDcubc7lN/6+HmKyL5
	 ybLPNGKhbC5GGTOj1qUEMCmeRLtTYWMl9R5t7sOHF16Gc/7QDKFrdQ3OTfpPq7LIEo
	 epsbSDenrnGZnsW8zbqM/Ya8W/kDuIgl6AC3RQgK+QrGUUXuykYRYvKHBOIAfoxSH2
	 L4zZgWxDRLdVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 196FC3810901;
	Fri, 11 Sep 2026 00:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/3] bpf,tcp: Fix bpf_sock_destroy() on TIME_WAIT
 and
 listener socks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178908480688.2150752.11574192436514906023.git-patchwork-notify@kernel.org>
Date: Fri, 11 Sep 2026 00:00:06 +0000
References: <20260910112107.148770-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260910112107.148770-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, aditi.ghag@isovalent.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 10 Sep 2026 19:20:44 +0800 you wrote:
> Fix two bugs in bpf_sock_destroy(). One is an out-of-bounds read of
> sk->sk_protocol on TIME_WAIT and NEW_SYN_RECV socks, since the field is
> not in struct sock_common. The other is a might_sleep splat when
> destroying a listener with children in its accept queue, the
> cond_resched() in inet_csk_listen_stop() runs under the iterator's
> rcu_read_lock(). Patch 3 adds a subtest for each.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/3] bpf: Fix out-of-bounds read of sk_protocol in bpf_sock_destroy()
    https://git.kernel.org/bpf/bpf/c/01b245ba016d
  - [bpf,v3,2/3] tcp: Skip cond_resched() in inet_csk_listen_stop() under BPF context
    https://git.kernel.org/bpf/bpf/c/eaab8cab451b
  - [bpf,v3,3/3] selftests/bpf: Test bpf_sock_destroy() on TIME_WAIT and listener socks
    https://git.kernel.org/bpf/bpf/c/8036d3a5a658

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


