Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D527DDCD;
	Mon, 15 Jun 2026 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484615; cv=none; b=okcZoOTU2unttdb1labQZpRXliw4vMrv48TiB5hJWzqBTCoLqTI8GBZjnIRDKR+g7C5RPS56nIGAn2usyyaHBuRvRI2Ouvjodsk/abvhylT5fxWZnwSFWv2WBUN3iJBxAkfU349EfpRWiwwXg74jYoouIvYT4KUG8AHvzo9AYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484615; c=relaxed/simple;
	bh=rSxKc/N/tH+uwzNkiWE4KIoX0y7JGcbdRUe2EnBy/a0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WiWVF+A/GXGIKbQSk+r32aKqT34UZX9yb9MifMNNIlG6Vys9OXAyIekTNzsDCceJX4CqMK+F8NQWsQxKyTa05/DkMKZc5gZaPjTMdA5cKRcKbajVi1ouxnPRfZpWqfLGRKYJGiFv7dn0TVMrnwFvx8yERCXdaV9eHW9z9IAMfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz7rW4iy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz7rW4iy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981361F00A3A;
	Mon, 15 Jun 2026 00:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781484613;
	bh=YWWI/90L+aoxO/PYplJC9Vjepxw4Tfe3yAFXN/NOWHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Vz7rW4iyAmd8NnKTk18OuCKtmHSw9nNa5HzS5blMaZysarw1hwtIZINA4L7yCMD2I
	 ui8X7z61b9DItkWuLvbgCq6M269HoIQ91UNOuOeAeEzp7P9SgEipG6ng5qw8cMt37F
	 UjfUykk+ex3RT5hXttcr+Pa4Ew6WvwKVwIu9rGO8M6S7KlOqeuV7DmE97WsxcuiHAw
	 RUj7QI6DxJwe5/lX8EhyEz05STGDOH18+mXQXR6t+OysjQevsYx/Pi0SYxBNiK5FIm
	 T+zxEBnKRh3XFpml+feigYemg1rBvbv4MKDCcgjTgqgkyeDYPhnKqxWDruoF+QaGit
	 xBW6VDXBr+Scg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569653A566D2;
	Mon, 15 Jun 2026 00:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf: Fix bpf_get/setsockopt to tos for
 ipv4-mapped ipv6 socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178148460889.2365545.16232674085836025115.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 00:50:08 +0000
References: <20260613162443.60515-1-leon.hwang@linux.dev>
In-Reply-To: <20260613162443.60515-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, ihor.solodrai@linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 14 Jun 2026 00:24:41 +0800 you wrote:
> When TCP over IPv4 via INET6 API, sk->sk_family is AF_INET6, but it is a
> v4 pkt. inet_csk(sk)->icsk_af_ops is ipv6_mapped and use ip_queue_xmit.
> The tos sockopt does not work for bpf [get,set]sockopt() helpers.
> 
> Changelog:
> v3 -> v4:
> * Add 'sk->sk_type != SOCK_RAW && !ipv6_only_sock(sk)' check.
> * Re-implement test with LLM assistance.
> * v3: https://lore.kernel.org/all/20240914103226.71109-1-zhoufeng.zf@bytedance.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Fix bpf_get/setsockopt to tos for ipv4-mapped ipv6 socket
    https://git.kernel.org/bpf/bpf-next/c/ca0f587c029a
  - [bpf-next,v4,2/2] selftests/bpf: Add test to verify the fix for bpf_setsockopt() helper
    https://git.kernel.org/bpf/bpf-next/c/5cf2c21ab090

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


