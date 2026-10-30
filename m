Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399424;
	b=vJj44HUffpe2ZSbh2wnBD7uDkBSWWqXeetxCrbeE2+DEN4FyjbyZl9RHcQLrJyfzgHU2
	 MrJX13uZJjJc0triTrS8Hb/ejjyAztcoJ0P/Q5vHlmoPTM1A2bFpuRg/wRWdwZQlCsBmM
	 vpwE2OIQ1tI+nFczqFsOF0NItwK+BykfHO3ZZgMv1K7zokhrzFZGVoAsGTp38sNY1ZQLq
	 xwUW84J+HxTz0gZdhx4kM4cByQkiweGQ6zbmfLEtFgYHF1kpjF/FuZnheE+8iuqFHFgNa
	 KaRYPvGsk8PSNXzi+qRcfnT8DQInQIXXVYc2c38oVYp77mB9J3xgmE5rnZUmYmGpkIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399424;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=dVkm8zvKQXVLLuyqIgzY9dSoIh5QazfvxEH685+2UD0=;
	b=OoqOteIy4e4moRvcVjwWDWVMi0y8jz/H7EH4NYtQrDA2WyTCSXIH38bdFMhi9QFhjcaQ
	 4/oAhyKlSidI6BdazzaDiDzio3OnEJUhbWHBmwqOPfDXgLDAoT0Jfu8Z7rxtVZ2qM7nZH
	 Eq0LubpxruVX68P9rDLo6ZS3R//jVPntO6ef6IdMDOLJPdkJec3nQnl5GG10QceDaY2ZU
	 vAshljtRlTdYxN7phiNRRh0eHwJ8m0gmj/u+VFU05F+WpxJxKw5QLfjWPd+XVrxSy7iu5
	 d8lIAvSk+aJBqidN3isqwJZzgOAoCTC2kxUdFXdTcbwdedAwclK8d9fP7ak9FFc8QDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ns+pgqaB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7523A606A320;
	Fri, 30 Oct 2026 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ns+pgqaB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E80F1F000C1;
	Fri, 30 Oct 2026 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793399424;
	bh=dVkm8zvKQXVLLuyqIgzY9dSoIh5QazfvxEH685+2UD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ns+pgqaBaqlEZGgZaWtTnMQ1ce6C0/Z49ia3x/KJY+m406KGjhpdv3mzJVCxs70i5
	 +FBQR8iPzDuOw1ge8xdp2UEciSyuxarhQNX9kyKmrQVDElQAzDNnNMG2/rq+Bb5r4Z
	 /UEUefqorIS2Ne29jMMM1FA77Jys8aR22WtX0hZXGpjZHSu3+xgyG1VQZi3rzy/sti
	 onI/yoXaaxjmmiibDrVCPQNF6nxX8h8KeZUxmAFTlmrheFCyJvC7txASk2o1gvRZOz
	 t4Ac4FP0yWu5CCRdlXJu3n2r74z7Rd3MYn7EwGJglSfWSMLinrL6ajE+Taf7zCmo3T
	 is0LnL5UKr8ZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 032643800478;
	Fri, 30 Oct 2026 22:30:24 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add bpf_ksock_bind() kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179339942259.1805657.15391838052896137149.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 22:30:22 +0000
References: <20261026190342.137069-1-mahe.tardy@gmail.com>
In-Reply-To: <20261026190342.137069-1-mahe.tardy@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, willemb@google.com,
 eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
 kuba@kernel.org, horms@kernel.org, liamwisehart@meta.com,
 martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
 netdev@vger.kernel.org, sdf.kernel@gmail.com, yonghong.song@linux.dev,
 jolsa@kernel.org, kuniyu@google.com, memxor@gmail.com, emil@etsalapatis.com,
 almagui@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 26 Oct 2026 19:03:41 +0000 you wrote:
> Part of the effort to make ksock have all basic socket operations. This
> is for example useful when replying to a peer which expects a message
> from a particular source port.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  net/core/bpf_ksock.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Add bpf_ksock_bind() kfunc
    https://git.kernel.org/bpf/bpf-next/c/d5b5913f03b9
  - [bpf-next,v2,2/2] selftests/bpf: Test bpf_ksock_bind() kfunc
    https://git.kernel.org/bpf/bpf-next/c/e6fd1b7163cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


