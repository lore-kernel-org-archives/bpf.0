Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814411;
	b=zZkbDw6rk/BvIrfmCznaKCFenLWQ3ge4TY+rpHsttC16JrYZjcDIvt1d2oIKYIQ2ZroD
	 O2BxUNx9JRojhcGKFBUNXnsfWs15kXSA6ieeCdJdckcNlCerz0xpu17RMldbZUNIhrSHn
	 D2K7JWSTRAXHfbhGul0cf8k5Ldp+SH8vF0JYDgGr46tqRjtkZ2A/uLTOW3nysWV431x9j
	 ymjgShdt5KKkEzDM8r44lbB3mhx9Ju5eugvHkd5sLYRBuedELOVMwbFOkoAAlc3imZmRU
	 pAQabygXOZ87Q5oNeYexrxGfCIqFpmz3kT/BCrTU6CqKGm0cwdLnFERRz9ThN+19zwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=pj7x8YuGt0pgB1PYOp/bih6oBnaUdEGTISR4jtMdBN4=;
	b=A1zKuAb9NRoeM7p4YIPFEeEf2hAXbLAUrtZ4asRCx3X1iJa/DiTqVYxvXpDgqw6DDlWb
	 6XT9tW42B6jIzFEYgOnrx6mHSA3cacxuql7x9nxsd8LYIRaWOzc0vKXFwOOCj9PvvYGJi
	 XqNms2XJ/lOouf+w/3n3lWH1on7nn0T/L2l1vk0yXEv6xZvtnyYmMH3amVY30fpMM/aft
	 50Bvwk1CrRxQFmng32w1MuZZ4J15eZJJlZwqzXWWDUHudf7jpuYlG4WeWBS6At+W4wxyN
	 5ayCx38gH1NWXES3RWUB/K1iEXS2ji2MvMnGiT2W7OZIAHd9brP5Qhc8jOL04mtS42A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ot2D/KNE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B679D606A31E;
	Sat, 24 Oct 2026 04:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ot2D/KNE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2EB1F01825;
	Sat, 24 Oct 2026 04:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792814410;
	bh=pj7x8YuGt0pgB1PYOp/bih6oBnaUdEGTISR4jtMdBN4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ot2D/KNEoZj54uqTVWQUdMayibFXqRBGxHlxp7YVwLTgVWqEv9ligngi8nqTwtlL0
	 mu6Db4VEQRZ/BxZEixBTzKt53vGgjPnaDZPg3nPnTielem7FsE585j9fffkTBndeOa
	 QJOfVYQy5DVae+iAv0CQk20IU8QUKcUXXQ5WHZdgQyUQAQPAqhDtmZf92EghOiAuop
	 LzJMyAzj5kv128qo8MREDSkf/rZTIZwwTfxQveHyHRMKyF8SSUEa+CEZpxmU1Sj9Rb
	 5UI8RfLsO0LYaplpwaXo7vIqOPODUG15BehQIaMVDh06ZEAuybdJQeGJ153J48ftf4
	 jEQjPVN+AJ9GA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 815F0391B17A;
	Sat, 24 Oct 2026 04:00:10 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2] bpf: Use memmove() to load bytes from an skb
 and
 an xdp_buff
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179281440907.1452471.10626063487064025333.git-patchwork-notify@kernel.org>
Date: Sat, 24 Oct 2026 04:00:09 +0000
References: <20261022112312.31563-1-ayushmanrout27@gmail.com>
In-Reply-To: <20261022112312.31563-1-ayushmanrout27@gmail.com>
To: Ayushman Rout <ayushmanrout27@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hawk@kernel.org,
 drosen@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 22 Oct 2026 16:53:11 +0530 you wrote:
> bpf_dynptr_read() on an skb or xdp dynptr ends in bpf_skb_load_bytes()
> or bpf_xdp_load_bytes(). The destination can be a slice of the same
> packet, so it can overlap the source, which memcpy() does not allow.
> On x86 with FSRM memcpy() copies forward, so a destination above the
> source gets the first bytes repeated:
> 
>   p = bpf_dynptr_slice_rdwr(&ptr, 8, NULL, 64);
>   bpf_dynptr_read(p, 64, &ptr, 0, 0);
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Use memmove() to load bytes from an skb and an xdp_buff
    https://git.kernel.org/bpf/bpf/c/b93cf2c8a055

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


