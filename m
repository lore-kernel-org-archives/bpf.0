Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795726813;
	b=4PonOJBgPo1F2UOdagq0IwzhFq15h8gLg+/BdoFUOYvorxoeMhpfMxTuFw/617PIMhEd
	 I+L/mLRL+a98dacRuxc7DQnHAmyxt12bbrNKnOtL7yut/CP+rsoCYV4chwRXi3I2jlGgT
	 7DWy2v8tr9aw7/ZgOex8GeoeUENTx+fceCIkZuP/n9623H3xqq2ilEs+paWoOT8HGSS9W
	 pwQfKFVN54RuRVE6v6yzMpnzxf4cf8Zc47dyzUjPEKSOc6kCqKX2/KEN+KZwxs8TT1aUN
	 D4wTfsGWPXJ1QsWpNHu9VDp80yfLaIRRCBJ/jevt+kFpyEvEZczsV3sjFp04+pDyiOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795726813;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=PLT/2lDKmHbd4JDe5EJl4vYRRb/4MLtJHPKtDIyvg7k=;
	b=3rldY9rTZeH2rGXbL5ae8mVRtnLBtsM9IJJufva0LgiCXWmYUf5Z6jafSWCz4oJJxFhG
	 gsaB8lpR9nMMNxflKEYOeWu7D0T6R6M84FqdDoINSwGEWIl0VvanjZqpkGTe0dWMUC/np
	 tG0+hdlnffkzVJbhaI0Ey+Ge3NC3qLt+hasCoQdVb/8G7NkYUEP1Trhzdctvg6n8/2e+F
	 AEKofMZyGwAxxOST+jKaTIqZb9b+AoeQ4tOdK4Tj17iYsV8dRkuVFs6dPbfRWHeDrNMib
	 JL9hvRAASAyc6+Y60cM0qNvaydh/mWqk5Aaizz33EdbqsvYNy0UZ+9rPfe6WqBdj8xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIkjM2EL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E46606A690;
	Thu, 26 Nov 2026 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIkjM2EL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC421F0089C;
	Thu, 26 Nov 2026 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795726812;
	bh=PLT/2lDKmHbd4JDe5EJl4vYRRb/4MLtJHPKtDIyvg7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JIkjM2EL/0IAgJ0PWvYlEqPvY8zaXXWIw4TN6n05PSWSsDd7ABpfKWC+/OCwA3V3h
	 j0hAJMDFpE2GiHAejtvcOJU272TEXjiLO3uYGtVlIy0blgY4jS9/vwSBVT2Wi1zAs5
	 PAJVqcZdaURFcdfIpg0nYSng5FTWlrYhv0yM8O0W+CSxflixNzdbBi5r2oi49pkz2w
	 1kmcF+58IdSDczMuEXdTbiWM0oXyepnLZdKEagiz2P37rvG3qcRLMuWcgewD2lLUII
	 D7Y0wFdvKmbsttu0TBrJqK8GlYFNqdkj1YXn9vI5nGcwsc9J3Na7COKHTscfAkF044
	 XETPVNqZRQ4sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE7923803329;
	Thu, 26 Nov 2026 21:00:12 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v4 0/3] Fix unaligned enum values in btf_dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179572681124.617567.14070682184136195830.git-patchwork-notify@kernel.org>
Date: Thu, 26 Nov 2026 21:00:11 +0000
References: <20261126011222.92180-1-dennylin0707@gmail.com>
In-Reply-To: <20261126011222.92180-1-dennylin0707@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 alan.maguire@oracle.com, shuah@kernel.org, alexis.lothore@bootlin.com,
 luisflavieira@gmail.com, ameryhung@gmail.com, david.laight.linux@gmail.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 26 Nov 2026 01:12:19 +0000 you wrote:
> btf_dump_get_enum_value() reads unaligned enum values through
> btf_dump_get_bitfield_value() with a zero bit size, which shifts a
> __u64 by 64. Patch 1 copies unaligned enum data into an aligned buffer
> instead, as btf_dump_int_data() does. Patch 2 makes the zero check of
> enum bitfields read only the bytes of the bitfield, as Alexei suggested
> in the v3 review. Patch 3 adds the tests Alexei posted in the v1 review.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] libbpf: Fix sign extension of unaligned enums in btf_dump_get_enum_value()
    https://git.kernel.org/bpf/bpf-next/c/74ff49675ee3
  - [bpf-next,v4,2/3] libbpf: Fix zero detection of enum bitfields in BTF dumper
    https://git.kernel.org/bpf/bpf-next/c/3a3224cd0866
  - [bpf-next,v4,3/3] selftests/bpf: Dump unaligned enums and a zeroed fs_context
    https://git.kernel.org/bpf/bpf-next/c/dda6568362cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


