Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389806;
	b=48DR3u+Hd3DiMbmsV5CvBtuy0AKy5k6YJEGeYoHIHq2sNt32n66z6QiszHKjQ1lNSLgI
	 NJU9evZBLCuSehgJw8Plxgp9AKLWFl+jO1LAfWQiOtjtc6AEKDRDOxkVVh6GhXFJkQWC9
	 tG0yVXje8tH+OvNYokE229mdEYb/Apthu966luwc1A+ijYuBIw1e3BUmswBENHitfQCOB
	 14lSdhCmp0XlYjiS2XgYN1qGS5MU062gq39gs9nuG7CNFvWBgQ8tB27/VM7yth0iX08DI
	 ZFRnELkmXk9VWWGOl0+Jidp8/4zAX+anxR5T4Mx9pABKQ22/3hh8HD1E9QMsqYYuqwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=dA9Guq3WRPXg1QdzKvDtdnhH9jUcQWooa2DjMScfK2Y=;
	b=B11c3j9BUVLIHQH++sCncBdWcIyYiA3bwEkM3HMTwQV1K97orhvz9p3A5Wh/kVj8cClB
	 PYxNNRxuKcJRLkKEhsvyIxnxNdVFJDyLG6qOO1G68jLXZm4CUPLzESgiSwQMqtUONBSv+
	 a3b/k2QNw25VZOdEvd53uO1ZPs7cnDEqNqRuL741lpQaurbz8O1h0aMn1OHRazqQfET7x
	 QugjgKc5gS+P3xoEMwlbphMaDQYcd/Jf3OzcNFdtJDwKformVY5082IqPvaJo5UhqY1I0
	 8vO9PpiA4jxvh+IQ5ccG6rn6shmEAKnJT1poStRekc+nJwaQvmhK0+dYceHwhOECP3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAJXd6wO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491D606A31A;
	Fri, 30 Oct 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAJXd6wO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2EE1F000C1;
	Fri, 30 Oct 2026 19:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793389806;
	bh=dA9Guq3WRPXg1QdzKvDtdnhH9jUcQWooa2DjMScfK2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DAJXd6wOkEJQ01SdrAogNTCElnoFOOBr8dCFkBxDl4ZaZUzhJdQqe7WdUXtPDLix9
	 7ovSOiMJm7xRI6bTPFfkX+LjrFli5AR8Sn1IuW/NnJ28/grnlwKGS51mZKO08Wk5nu
	 skxkvCETVONOcF/mblvsyyFeoSSEZJ5k/RJvMtGdjcNkt9o4k52J5/7E2uPxiKoMr5
	 h+NkZm/rO0ip2vEYs9WQOr+p4sFQjkmhA09Smuh9eXMyehNtmb6Iy9ULfmQsKebT4s
	 K3nEvpZ60wimVQmlgA7EHJusw1/R54PJ1BqMcWXWtLBgLFheUshllFxvpXpdIU/Stx
	 z4q/DBBKJRbsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02FE53800476;
	Fri, 30 Oct 2026 19:50:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Enable signed overflow and
 small
 value tests for LoongArch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179338980481.1738842.11750741745247206819.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 19:50:04 +0000
References: <20261030091305.3277-1-yangtiezhu@loongson.cn>
In-Reply-To: <20261030091305.3277-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 30 Oct 2026 17:13:05 +0800 you wrote:
> The LoongArch hardware divider handles signed overflow boundaries (such
> as INT_MIN/-1 or LLONG_MIN/-1) natively and perfectly well on physical
> silicon: (1) for division operations, it naturally returns the dividend
> itself; (2) for modulo operations, it returns 0.
> 
> Furthermore, small value signed calculations with negative divisors work
> correctly as expected.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Enable signed overflow and small value tests for LoongArch
    https://git.kernel.org/bpf/bpf-next/c/aef18c73c961

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


