Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400008;
	b=PCH8xTbCVUyD6ZddH1AlLAMVYPypRkz9Pzei+WCHZpFOB+yJn21Us2YWBCED/TgmlhXC
	 l1/tqYavwRL94Dafvlou/8SDkOAK88jpfNqrkQkCoWigtce0970XKuDf4N/FsEz+l/KNH
	 IsqU2WHueEAkvLucH3cG/R08nLxYODsmLgj21QLxpdEvsNAX00AM2uAoFUs0nXmytnNsn
	 xENVrBK0J5kzV9ZcZ/EGcc77NKj+p1ofbrvfoRds4+0DnDctdmvYawb2w1mCHkdoEqTj1
	 hnhHilm/fIbtW4nX5B/2tv8A+ALRyQzK7P10Cj1x32dw7ObaExYcZfb7m+Gspy+ZNtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ecYBPT5GqcUj9LPuzgG/3Gd0N6uHXecLUJSZJemLsZs=;
	b=FRRSziNBoOzK0S6zcnaiaznnAN3ibbyL9fj39Hj1zBpBZb7fQRqJZ6J781mjbZ+ASKlS
	 zGvfxPaueBcoNinauVG8H8Zm79xfdDcrgcQsE1HeduLhmw/4rN3cvd4YXnM7BsPPw+nsx
	 G/Xrg1jObAa4jwUinPLG0N2o9Wg8TCuYPE8C9TzQJpQLVODSVtx11O0bdEtu+91wkiw8x
	 wKvWXPmeMeoWkUmqq91OkUufO9OZ2lgaV/mO3JXrP0dn9NMakyFZE5pRP+nEzCMTjl25z
	 7nGkHlwxX0PFvCpx8uVuQWY6D7gQvEkjfKW9UPy6EAIxLj0KhNYYA3GsmwF1T2Uwmcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xa0oDYiZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB9606A32D;
	Fri, 30 Oct 2026 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xa0oDYiZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57221F0093A;
	Fri, 30 Oct 2026 22:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400007;
	bh=ecYBPT5GqcUj9LPuzgG/3Gd0N6uHXecLUJSZJemLsZs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Xa0oDYiZQHrepStLkWjdcQnrVgh1inC8GzbbV3WyBmesRvnKIyIOWrWusSSuZCSUG
	 9xuNgpBW53seyMuuuEsu21/X2R+ULdoJfAdA1GmOjl4MkuS8QVeqyCbyqsctfDZdI2
	 +idSomy0tgsL0hRwvaegRWQJ3MNSrSRqunH0LnzGv8jw1nOoD1Y9bsgJkRB3RSWuI4
	 ZVwjSi55F0lors5Wj2oaBaLxGIXlqAGMv8h68LPXMGpN5KIocDtGeM6fHG8/xdo1NB
	 snJtPjeVixaxJ4QrIgzrcnuqrvTP0Nh5tIFDSoQSEhpn0itc0yfRbwnxbr6cMiXxuW
	 GgcxpmKKReTrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2963800478;
	Fri, 30 Oct 2026 22:40:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2] bpftool: avoid sign extension in unsigned
 enum
 JSON dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179340000629.1810026.13611068664375441982.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 22:40:06 +0000
References: <20261030195343.79712-1-dennylin0707@gmail.com>
In-Reply-To: <20261030195343.79712-1-dennylin0707@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: qmo@kernel.org, bpf@vger.kernel.org, andrii.nakryiko@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 30 Oct 2026 19:53:43 +0000 you wrote:
> The BTF enum value is stored in a signed 32-bit field even when the
> enum is unsigned. Passing it directly to jsonw_uint_field(), which
> takes a uint64_t, sign-extends values with bit 31 set. For example,
> 0xffffffffU is printed as 18446744073709551615 instead of 4294967295
> by bpftool -j btf dump.
> 
> Cast the value to __u32 before widening it, matching the conversion
> already used for plain-text output.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpftool: avoid sign extension in unsigned enum JSON dumps
    https://git.kernel.org/bpf/bpf-next/c/eaae576c34d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


