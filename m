Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794087570;
	b=OFyiIZvV0favueeZRHK8S7O0GzL5H7/+cmz1C/bQM3dPOO4KcvktbKKjyiqXTveyeZX4
	 3HHsOXJ8Oqh3uCYvsyob7xwOOKLaDYMBr0/AaQUdv5+uIU4lUED0qTPEHNK4//b89DKah
	 PvJU1+4nLc1rBoIdMBLUmMlFi8RDJe8c8KGt1Lbd6MxIpLJHLOSdj1Kt8zEknXpzur70+
	 bOICzDbV8Q3kD+ajknOE4cwVItn6kfYHw+W6sU3xgA8DwfT5JpdVHcY8c4RNOCLAU4hvY
	 h+h7KYSKi30GxWy76gmlOX1F8X5C3Af6UKF0WDPhue2b0WtWnL4bjv1gTCjI2U+J2tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794087570;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=s0PskjzyKOgVTkdWlIWq06GwklN9Ea2DyxPcIh2zfYs=;
	b=HOwpLVjXguyEJ7kLsO4I/rySJVGg2vzVjlX33mv9Hd37aJsSfOv4IJHyIZKC6uN3bRB2
	 xvsJQLRjBLsAhAXOUyDd7oUfbyf8cX/NIzGx62PAfhSRpluSi5RND1ByxdoFrX1XoRhKS
	 cqPTDoHWo272Bpv0zJ6sB1JHVpVj13B+Ahvxg07SkGz9ohQPWiQNlOEywlNCqIV2o5ZB6
	 8iXashq74TBuKoZRZm1H4DnBEyge2bP6Gk15Huh9+nXfkoMx+1BqqnRXczn0fPWX06R+O
	 Y+1ZFp0Fsm8MROxI0KqqpjyDUKgkoBYgGF4Lqwoc2kGfL55YkXiUjuN+96kVHQPA66A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=WpUUYdxv;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C6D606A326;
	Sat,  7 Nov 2026 21:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4C6D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=WpUUYdxv
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xPo8E-008AgK-7z; Sat, 07 Nov 2026 22:39:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=s0PskjzyKOgVTkdWlIWq06GwklN9Ea2DyxPcIh2zfYs=; b=WpUUYdxvqTgi+AT/EFXxZNT1+n
	ylOBj4p7hCPbTcm7eW6JSmKQHnBy1FB7CcSeSAalh/wKAU4X/x7ZqoEvwEJ830TlmAvvFGxYzovwh
	hx30IbqYaUfuBfswYoKPZCfU+bGH2OAiRbwmYMxJqCRZ4GspSQj7s00LqAo1BkXdSDdb1Dtl2Npow
	WrteSZEzQPRCTZhd0xRcJdCNeQVEOM0LN+K36mkNSxtyBdd5V0mcj1FQzNGy9iMCMPWjiuZA8z4gg
	jMPkfwdjcx5VibNXswAo301JuPRzsey1HDkLcUCxwfkP7qrLhDEx4pOCYC4jgHIoME1BOMKrbMJGh
	3EtvIcHg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xPo8D-00035F-Re; Sat, 07 Nov 2026 22:39:25 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xPo8A-007imK-3o;
	Sat, 07 Nov 2026 22:39:22 +0100
Message-ID: <9c411cda-cac9-4287-868f-79ac7dcf3b27@rbox.co>
Date: Sat, 7 Nov 2026 22:39:20 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf-next v3 8/8] bpf: Fix "unresolved symbol
 tcp_request_sock" build error
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
 <20261107-sockmap-update-limit-iter-v3-8-7c0bad1ad036@rbox.co>
 <sashiko-outbox-203160@kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <sashiko-outbox-203160@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/26 19:14, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] bpf: missing Fixes: trailer for tcp_request_sock BTF build fix
> --
> 
> commit 96ec9bcc071c52f5537149bdc9a41b81773ef3e6
> Author: Michal Luczaj <mhal@rbox.co>
> 
>> bpf: Fix "unresolved symbol tcp_request_sock" build error
>>
>> CONFIG_WERROR=y CONFIG_NET=y CONFIG_INET=n build fails:
>>
>>     WARN: resolve_btfids: unresolved symbol tcp_request_sock
>>     Failed to generate BTF for vmlinux
>>     Try to disable CONFIG_DEBUG_INFO_BTF
>>     make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
>>     make[1]: *** [.../Makefile:1379: vmlinux] Error 2
>>     make: *** [Makefile:248: __sub-make] Error 2
>>
>> Handle it in the style of commit d82a532a6115 ("bpf: Fix "unresolved
>> symbol" build error with resolve_btfids"): force BTF generation.
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> [Severity: Low]
> Commit fce557bcef11 ("bpf: Make btf_sock_ids global") exposed btf_sock_ids
> to resolve_btfids under CONFIG_NET=y, and commit a90765c6f603 ("tcp: move
> reqsk_fastopen_remove to net/ipv4/tcp_fastopen.c") moved the last
> CONFIG_NET=y user of struct tcp_request_sock into a file built only under
> CONFIG_INET=y.
> 
> Should this include a Fixes: tag?
> 
>   Fixes: a90765c6f603 ("tcp: move reqsk_fastopen_remove to net/ipv4/tcp_fastopen.c")
> 

Right, that makes sense.

thanks,
Michal

