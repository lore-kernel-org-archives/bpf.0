Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541408;
	b=dgbV4aVXUmASN6LKQ5iKq1HYFoAfMyh03ZY+fuZ4Ll+5yJDA/4axwQFEiOtMvBGwaWgg
	 qI938Q8/+kv3myLdTe2PO4xwX1KQ71PPJImHluK0RTQM5+BmSPT+QLpXYeiDtWNIvG/sD
	 6ewNuBzj261R25NQ1qHyQCg4No7zdKShiFet6LncnXvdwHmiVN7Oj7mKVWZO9cm5JdQJR
	 ECP78WZsW8DgOSaotAuRAxdcqJ/4r20v5OY8FkVXpKU204usyXOVuruWOuCiD4gCIO9P0
	 jpQxtz5Hys1SeWJwMcHbGXmckfOzWQgXy28KIay1MBfZT/S8i8MDALrusANYMwojADA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=JhT305djb4B9NJ5aYACCaD47/9dBV/1zrqONa2BTC9Y=;
	b=QFaGlVOJ+9weXG1GKJSCL5PZ4FJ9w9Fcb1XLL5N1wF1h1i/E9YNgiq5+PMo7B4v15egk
	 2cwpSGfoo0z+vVL78TA2pxKDCUfJMN4zVrvY3oG7oJzx6vmBH4N9Jpctj6iUCecRtnpJl
	 S01ESiEvc+C95V6tkFh1R7Ex2OcbbSDqxeAOFEGDk8JFiyGuD9PgZfIyutb6BEfG5ZNDl
	 /xZOxtXzxrjNOVkIB+UGa3qJyF8QxRh1pV+fWhnQ4AYo8BeFH7t7AXZnUNJUfj2Snr6Hc
	 b1k9TWeOKkR9azv9qXiBWfonJo3vrxab5U47AD/8z9NlAIHK08Na2M8pOgN8cVWNZBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KN1gImqT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF2E606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KN1gImqT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF1F1F000C9;
	Wed, 21 Oct 2026 00:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792541407;
	bh=JhT305djb4B9NJ5aYACCaD47/9dBV/1zrqONa2BTC9Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KN1gImqTaRe51wgmr0z3DcK66xMrf+K9XgurRnoSxGUiVAwzXLaLmb4KekRePWpTP
	 nBPTFdhjf5ZMhTjHXo5qZCe7U0wmdPfeAlB7UFv0HLErwvgpk9R0f4tYtTfdRG8SL6
	 1XmKIs2OJTaFhqvYT8l8Dtj7HvrBq7c8q+maORTS+w9ZXV8BffUn89mAHP/ax1iH/4
	 62ku4HVyDxk4gdsQMO/Lb9mmihBB1LYAdTIp6Eknx84WI0wxlNZueIA1g//9r/T7b6
	 4zVRrYTCgjRVRdzJfGCjv01txSF/TtAc2rQV8vfCLUeYk8UMX6v7BCf/bSHX3r8NeJ
	 0wIJAUanTo7Nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773AA3809A0C;
	Wed, 21 Oct 2026 00:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] bpf: Fixes for unwind_goto and unwind_exit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179254140628.280032.5891719215381607213.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 00:10:06 +0000
References: <20261020231942.2568163-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261020231942.2568163-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 20 Oct 2026 23:19:38 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Two fixes for what the bots found in v4 [1] of the series that added
> unwind_goto and unwind_exit.
> 
> Patch 1. unwind_exit of an exception callback is exit for the verifier, but
> JITs looked up the return address. The callback returns from the frame of
> the main prog. After freplace or a tail call that's a return to a prog, and
> the callback could end up in a pad that wasn't verified with it.
> It came with 'unwind_exit of an async or an exception callback is exit' in
> v4. For an async callback that's fine: it has a frame of its own.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: Make unwind_exit of an exception callback exit in JITs
    https://git.kernel.org/bpf/bpf-next/c/6ff297f98b0c
  - [bpf-next,2/3] bpf: Reject unwind_goto and unwind_exit in offloaded progs
    https://git.kernel.org/bpf/bpf-next/c/9d1fbfc23675
  - [bpf-next,3/3] selftests/bpf: Test unwind_exit of an exception callback
    https://git.kernel.org/bpf/bpf-next/c/ad223de6d346

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


