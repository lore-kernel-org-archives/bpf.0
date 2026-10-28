Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191124;
	b=cutJ+FDz+P/BT8XIyJFn9cD8EyBXjrqzHI8w0xM91839SnwPAa03sQ4Wzc26b2Bp65EW
	 6UQQuJK7SetPSgo44ECd2TUq6ImCpxkNchsuXmy7D/oE5TqBewSVjGlFtEm4vpObToUBN
	 QFsQNLb1kkn073Jhlq92qsNcmmiyxYo0XqlE2Yf8dgpCqh7AfSybd4qkzShSPshYx99Mg
	 uOBJP8UhY0iq8J478sxgLFVNLgIFg5m/4js/MVVbwqwOSjOhX/LIAiE1fUdVrNoj2ji0Y
	 PtGjuLsd/C8bx2QK28wJYEmUfz6RWFsIKNhPnbDEUpUXVJOcVL8Ow0C/92y1sbuT+0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191124;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=Y35jB/7Gsfr5AxAtB06a5rjbDLtINtAQhefmyIZOHpI=;
	b=nQy1cWyCfI39qUcNL1LeCfIxGcihHzs4a+bHEEAFEyIBm/h0WGWFqviC7FmBw0VUJxx4
	 9QmnYzCXMRytK4VjXA2td2MMi3q1vl5jNWhAK/BixmVFGtIrNPGqJfwY9japn849Yfv5j
	 nR6DhUnvrqrAsGLMSSrbAqsdw/Tgp+8JPyOLAImHFOL8rDC0SsiinO+A1mZ2P3JJUEmpv
	 6N/cO95A2zsUAZY1+3UGd4lPKgoy3/hSN8fJ/WuGBw8l+lEpNFaoGfA98dptsIhQ5kAtK
	 Yqx50xUNwIC19PDaq5vVyI9sli5gjl87yD0CKNmnIWrbuJbbQnU8tv04WRvizVRzesw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Y1cDorAS;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EBC606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 12:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1EBC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Y1cDorAS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Y35jB/7Gsfr5AxAtB06a5rjbDLtINtAQhefmyIZOHpI=; b=Y1cDorAS1kbemFHldYdME6k6R/
	884KGZE2yNx34Nzt5E2bbSHDrfK1FG3QfhbeweGAliXrCovYDTou46q428K/RGhbq6bI8e8QvO7Gi
	VUSLuW3mHRtQuq9V7fAuf9NyMrMsrgK22UQ0+ra/tGOkUSKPvS1GV2I6eLg0wKoH3bCDKRyATTE7O
	VBEwXq4TSMO7HK3lLS0/nmnp4vg0uDI4fePTfcIRB2rM1WyGEpuAfWFUcTn17ZXBhTwDfYwWjG2J5
	RVVp3BRo27m1LcMTgW0LDl9H+zNKEiL3uovAGQh/nD8Bg2JRPbe/WSTg81Xr/BzSqkukV7Dd/aneX
	7MC/MiPA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xM2vG-0006EW-0m;
	Wed, 28 Oct 2026 13:38:30 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xM2vF-0009rL-1S;
	Wed, 28 Oct 2026 13:38:29 +0100
Message-ID: <d06830ab-7858-43fa-bbcb-aeab92a3e042@iogearbox.net>
Date: Wed, 28 Oct 2026 13:38:28 +0100
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
Subject: Re: [PATCH bpf-next 21/21] selftests/bpf: Extend the JIT instruction
 tests for arm64 encodings
To: bot+bpf-ci@kernel.org, puranjay@kernel.org
Cc: memxor@gmail.com, ast@kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261027182445.1156335-22-daniel@iogearbox.net>
 <9832ca99bb2aed8262e1986075a6bab1b7c84ebc69ef5cc3a73bb63da06e4306@mail.kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <9832ca99bb2aed8262e1986075a6bab1b7c84ebc69ef5cc3a73bb63da06e4306@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28167/Wed Oct 28 07:24:17 2026)

On 10/27/26 8:08 PM, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Extend the JIT instruction tests for arm64 encodings
> 
> TL;DR: Nit only, not a bug: the hand-packed INSN()/ATOMIC() macros for
> load-acquire/store-release in jit_insns_arena.c could use struct bpf_insn with
> __imm_insn(), dropping the byte-order variants.
This and the other suggestions look good, I'll implement them and spin a v2.

Thanks,
Daniel
