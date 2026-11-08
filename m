Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167270;
	b=T14cFj7RFgvDHmpS4CV5CvTOWnq2tkm8w16u/lR/NGEk54uogBaubMm+MOOVo9YV5hMt
	 9AN9TEwt9MSA12XvRCXK/7d0s2uxqK33s7a7IwpzkEB34CVVWhFDqoIr7dReBpfSCe3dW
	 kBQm8mbXN7FCNsLBvP3JubC6pMJHGSbIawpKXeo04YE8PstLY4msG5SymRz9qsm7slRWX
	 f7N548TbS6UD6GiVun9JezKB79Z1iENmSwMt4lw1eI35JfvoB14Jk4saQnfmlr19F/JTo
	 AzApfaW8PKg+owq51puXqkFtnZ3LBoU6dz3TL+wN9MUC9fGmxswAVXCPCmilrGOU+wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167270;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=rHjYnbl0q32Qm1MJZZPQsLtAMQ2CqvIrSV/1sFV02mI=;
	b=09RDdXgHUBz4THl4P6SzMHAoaRKJomQJ1Ww5sQu6yrc7ko3vcQkV8PuIz90RM3gjKzb7
	 Z6RcqqYvEyGvNFXe36cN6LsZDXHvNl1fQ/NF9ZYgzf/Sj/a9OK6h65okFupqtrdhyweaf
	 LK7vW7FEi5tvz4fuMoj+AzWt3Zc+uA7Al4e004esmV/StI7r1UQsltPK/bw4tX6yCF+QZ
	 l7v9XuFDGx+ZbmaDOWUxwR2SGS8/CAINROmYZNaO/71BTENLOW8K0QxKmTdERLuvx2tMO
	 wcdv9VIpMPg8PWbasIJbHksn8vUuJ5O6sdvlXz5dqZlVW4IKDVaHoxfin03QnVsZiMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=dDvZLi1S;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7CD606A31C;
	Sun,  8 Nov 2026 19:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E7CD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=dDvZLi1S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rHjYnbl0q32Qm1MJZZPQsLtAMQ2CqvIrSV/1sFV02mI=; b=dDvZLi1S85L82gY29WR2bmpD0+
	88jyy0n3vSjLJCztozsUoW1wDbPMNPUlg5tcCTWDchg3kOdiUdYHfpCgP6h3Zq/aJuY6kgvhkU9vi
	72JkH/Xed5vpTwKne9+udvRZmqmGP0u15oDrgq5jFAxF80/C7aiuUv1+WVmjeQGkGJI5UYFMgITUH
	3ir5ZU2AuRBJ5CtBelDbeRG0CsFhmqv9oeCRo51Ad55rmqTb3Bhyuk/lmFItWSHFZ10I4Wh0dTajZ
	NC/dxIYFckqA7/00yUx8GOLgJIac306+XpO6J4CTCjdrrPfWTbsHAi/BIpJ83rKwLyfAaSylhFYRB
	f6a/TeAQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8rk-0002dd-1a;
	Sun, 08 Nov 2026 20:47:48 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8rk-0001Ja-1T;
	Sun, 08 Nov 2026 20:47:48 +0100
Message-ID: <453413a0-e223-4d85-a7a2-4148facb0c54@iogearbox.net>
Date: Sun, 8 Nov 2026 20:47:44 +0100
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
Subject: Re: [PATCH bpf-next v3 24/24] selftests/bpf: Extend the JIT
 instruction tests for arm64 encodings
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <cover.1794165614.git.daniel@iogearbox.net>
 <f16feeec21ead88b0459d967f976fad4f60b750b.1794165614.git.daniel@iogearbox.net>
 <sashiko-outbox-203993@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <sashiko-outbox-203993@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28177/Sun Nov  8 07:23:52 2026)

On 11/8/26 8:45 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] selftests/bpf: misaligned XDP packet load in test_tail_call()
[...]
> [Severity: Medium]
> As reported by bot+bpf-ci@kernel.org on v2 [1], will the verifier reject
> this BPF_DW load from the XDP packet pointer on architectures without
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS?
https://lore.kernel.org/bpf/41b4e2b6-ea57-4483-8e06-142e09cd73aa@iogearbox.net/
