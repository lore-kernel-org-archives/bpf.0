Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BB532ABCA
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191876; cv=none; b=kTG0WoAfjqa+HqV9q/39P8tmTmlpX3pn+WBUic6zNBlXPQe1jZjzudNlDBEIhWpVIzZi5I79NJcyC19YnZdYhlt3qQcosPOuqzFmLamJf6qwylnoIbgY8QIyFGDTXB7bazpUiFQ0tQjMqbvYMlLnUBJZHIK5QDWUgMlcya0Zrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191876; c=relaxed/simple;
	bh=OZ9zey8Xq74GCXcykVwRNxAl/41otoGSvxxyJmH7ggI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GH9Yi+IOVWV2rw1LXr5cjS4rYTwRpcHfqav2BWE6UnSJg5EGfZunGTAKeiQAkvc5qyKpMNXMMEkb94wevNFRWtZZ1rNIZkchrB7nr7AFCG7IYclFMtm/4FWqFyDN6IXR0Wrnc3TskDg5y+7fU2vXdCKvtr/dR0AYgn0LrKfrZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEGnUhvF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEGnUhvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A1AC2BCB2;
	Thu,  7 May 2026 22:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778191875;
	bh=OZ9zey8Xq74GCXcykVwRNxAl/41otoGSvxxyJmH7ggI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gEGnUhvFJdUPiU3QQQUrCybsRMwfANdfPCRhxj3ffa29q40ZCn+pRinodCCOOnEBo
	 0Wqlr4ulJiETIppzH9Bf0V6J4tJEwjxpu6/qv68e1U6b33BymU8RD3U8YbvNW6Xxz5
	 r/k15+G2rptnp388cIYyXL/fySwIy2fw6n/7GpcEE+y/KIUgVRyA9LBVeqB9r1pu0f
	 YpnfbWYQE2/FajNnwajHAGry16m+Dwdh2iynWKijZ+D7YvRXTiaUqem/GpRZQQ7qdv
	 181D6HsA0UE9fFuCLvD5cPvIYhq1D1K3va3qfPd32hNH7uoiIIYasYUGL3Zr5FlG5b
	 geA1uJo/1ZyJw==
Content-Type: multipart/mixed; boundary="===============6665946157370292591=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2e3846a6e56348cf5818b8ea835474d4cf0f3c0296536577c3ff60e332ef5559@mail.kernel.org>
In-Reply-To: <20260507213054.1131645-1-yonghong.song@linux.dev>
References: <20260507213054.1131645-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 14/23] bpf: Reject stack arguments if tail call reachable
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  7 May 2026 22:11:15 +0000 (UTC)

--===============6665946157370292591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Reject stack arguments if tail call reachable
>
> Tail calls are deprecated and will be replaced by indirect calls
> in the future. Reject programs that combine tail calls with stack
> arguments rather than adding complexity for a deprecated feature.

Is the claim that tail calls are deprecated accurate?

Multiple reviewers across v4, v5, v6, and regular patch versions raised
concerns that the commit message inaccurately states tail calls are deprecated
when the actual technical reason is that tail calls and stack arguments
require incompatible stack frame handling.

Looking at the mailing list discussion on the v1 series, Alexei's guidance
was to disallow mixing 6+ args and tailcalls due to stack frame layout
incompatibility, not because tail calls are being deprecated.

Could the commit message more precisely describe the actual reason for the
restriction, such as "tail calls and stack arguments require incompatible
stack frame handling" to better explain the technical limitation to future
readers?

Reference: https://lore.kernel.org/bpf/f163dcbf46e9511eba14b22ed10467984bda3bf07a3d1bd6cd27ae14eadc2056@mail.kernel.org/

Should this commit include a Fixes tag? It appears to fix a bug introduced
when stack arguments support was added. Suggested: Fixes: c364b7a0f7ae
("bpf: Support stack arguments for bpf functions")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25523765323
--===============6665946157370292591==--
