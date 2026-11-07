Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081006;
	b=3k/L75W14eRXfzIfc8nnASnGr0wogS4+jrJbQISU7Ix+qgzATx4Yt60XDchDY7J+sjkU
	 KIP5OrDGtRzfKlPNl4i7uySYwN6q4H3n6spm+hN8C3Nw2xRNQA98f+ivEnju0wPTtO//u
	 0OAh/jyH7YgLZ8ZKI84mXMl4y+qMlj+QxVpJj5wPnMk2flzPCZrIuAXUXR+iX+uh4Nx33
	 RNj+kySQJkTn9ESF3/piGCyn1wcOCnD/1s4jG20Vbvm8NwnGzJ3JUUXvpw8/wAVO4zXIW
	 yBn4XJnlYsPayTiaM7/x0IG8u7zzBuvNWQuW4jUxsiL8/3GY0EgnSirs48hPbwcjmxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=6/JMqKVAYuMjJS0fnmKqvu75PgqTSI/S/QQ1Ld+jviA=;
	b=W1CWLHan3gFnoX4e3ZOoHkIRUITPpoNYqmNpftxTaVP1bDR2IoUvQmRJ2c7dVDvCsxvq
	 LsU5vkC8El7o/qr7+V2cTnDRPbi5EqGsMrBAGxrSbK734LfPZYsXNOd7uI4/7t73N+nGC
	 lOeKd5WR2plYJEW8835LOD9yfNFiXMEVYfiAykrfhD/pNxDqLhjaXJwkjEnvqyJo4vbiv
	 h0YxKG9BUWdDOl4jEu/UVSoetYDjtWXJj5tzx2N/ygfAeYvNpTroLUenmztqgxtD4QWCE
	 L4VzTtbPrA3I84wl6fOfHTqs+YEVhkMcVQcoKJrfFC/mraonctIs38ipn0PGJUYb1Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rh1CHGbt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FC9606A32F
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rh1CHGbt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E258A1F0089F;
	Sat,  7 Nov 2026 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081005;
	bh=6/JMqKVAYuMjJS0fnmKqvu75PgqTSI/S/QQ1Ld+jviA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Rh1CHGbtorwEHryMimRJGY5exV4koNEvngAX9DCHQCfRw78jty6GDhlBAaw/vPrVb
	 sjXKtpZAl+/dgz3ra8GsK+f0FdAXgJwDBBST0KJZb0EsMB7U9iT02qKI8p200MfdvS
	 3PmfHPbZP9rHAZXT/sNKq7AK+0q6UgbD9RcW47uTOPurvQ2ilWrfd8O3tu3wpJLbSQ
	 K6wCqQTB21idlG8UH602L6BwO1Z7ou0HBm9tM96QT0QL7XeFOdc0Zy4IFdGt1Jzf7c
	 ZKTqXw9YlMQ2bTOZShCAc/VDhNAJXryeXUzZO4IFASmYLbzPZiymh+yfq+du5xyBNq
	 lNCe2E8cBt5Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D8282380821F;
	Sat,  7 Nov 2026 19:50:05 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next] bpf: Don't attach to a subprog that is called in
 a
 recursion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179408100468.1307894.12620244029285495163.git-patchwork-notify@kernel.org>
Date: Sat, 07 Nov 2026 19:50:04 +0000
References: <20261107175006.3591773-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261107175006.3591773-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  7 Nov 2026 17:50:06 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> sum_to() of verifier_budget.c calls itself:
> 
>   sum_to:  if r1 != 0 goto 1f; r0 = 0; exit;
>   1:       r6 = r1; r1 += -1; call sum_to; r0 += r6; exit;
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Don't attach to a subprog that is called in a recursion
    https://git.kernel.org/bpf/bpf-next/c/dfc18dfc0da7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


