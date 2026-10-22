Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675100;
	b=stV+D3XEaZUhF4ZfAsziz7f8tlXUsWofAUy7iipn8O8vRpUEjFCM2/zbbrIFqj7msx+Q
	 3SzbPPWIwhEkmDuD2WgvIoa0yWiXpmHcdQxlRyXVFMqo4DJyBpx2ttFhzTrvL2AXAuPdN
	 ODLv7saSjs47V4f7lBu+Z+VsIbNvAphEbSb2ImoAT2G9iOrQIGwBEcCx3ZJU6EywUxhHs
	 rQe3pM/BCeZi5sHcwS65HXOgBdbvDGbi/1/zIJB7rwaHriTY0Hgx/xXo3SqITvchAetz8
	 +/KmRQAsNeaS303UvhViyzJV8StvLTz1dnXTfz9uCJh43GLXn8pK4yi+vXBfTDuGEtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675100;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=g/fqxNHaQdahJuDAFIZyhRZ/KI45mRDafHTZutuxPcE=;
	b=ZRkdTpEynmIcuIzLMJnBwQYtKnAqcglhFlOJzdt4eEFwTfIg6FcE8MEUlb8fFagl0iEM
	 eubO/NE1hPwC0IfxQpWNKWCAc9oi61Z7t13pABusedJeUcKhykPKwyIpBPJozgb5BJDnS
	 5dw4JGQu5UBTkXnIUE9v+3bXLN1+dG7QDzmSDW3JEq8wQeELcPEq1L7lHCSQx/9xby//X
	 YhYq03wfsrM6j5pZYdvKa93HybDwnnJsMo8Aa8VmCCtASO+hAmgDRRI524ev3FT1sH3pD
	 ztXrw90lh5UBi7g7hvf6cIoNqf3Owia2CclTbbRmonKaS7+94A/4b7vlfR9OD0lcPFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Il5cLbcR;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D5606A31B
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 13:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F6D5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Il5cLbcR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=g/fqxNHaQdahJuDAFIZyhRZ/KI45mRDafHTZutuxPcE=; b=Il5cLbcRkps1nU/nF1YbguH5p6
	Zz4N/E02kz8xI0rKQLXb5+XZEsK+z2xSUhYW/CTOjqlu/SJPiBSK4YhXau4hz/WEyT3oD0ivXZ6hh
	A6Ze9Iv73BguTGIoS7BWVN4eHVVvQfdftKonoao8E7TOqIEDVDAg0Hjb6fWvnGTLub9B6ZKc1NxnF
	XHHz2h5tqEfgYZJtePdWJoAUFrKES1zxM/9jvUOfGfeOosHOJ+i3x1L6Ozr9BD5/3ZKrj0A9yC17M
	W6qEScuZY19IyAqB0GMij8iGwg2Fy+XiB7LBqOOasIuYi7FWjTfYQ0QF2ZUmsHcnkAdPx5P6oH8lj
	eqfx4TSQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xJsgK-0001wr-2r;
	Thu, 22 Oct 2026 15:18:08 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xJsgK-000C8q-0W;
	Thu, 22 Oct 2026 15:18:08 +0200
Message-ID: <b6b06eeb-8558-432a-93b9-3f7f4f04392d@iogearbox.net>
Date: Thu, 22 Oct 2026 15:18:07 +0200
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
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Size backward jumps by the insns
 they jump over
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, kernel-team@meta.com, eddyz87@gmail.com,
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20261022-jit_size_fix-v2-0-4bee6921b218@meta.com>
 <20261022-jit_size_fix-v2-1-4bee6921b218@meta.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20261022-jit_size_fix-v2-1-4bee6921b218@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28161/Thu Oct 22 08:24:11 2026)

On 10/22/26 2:04 PM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> A backward jump is sized from its target's current-pass address and its
> own previous-pass address, so it can grow while other jumps shrink. Two
> passes may then give the same image length with jumps still changing,
> which ends in "bpf_jit: fatal error", and a jump growing in a padding
> pass ends in "unexpected jmp_cond padding".
> 
> Shift the jump's previous-pass address by how far the current pass has
> moved it, so a backward jump is sized by the insns it jumps over, like
> a forward one. Also start every insn at BPF_MAX_INSN_SIZE instead of 64,
> so none can grow in the first pass. Then no insn grows from one pass to
> the next, and a repeated image length means nothing moved. The 123
> limit on imm8 offsets worked around that growth and is dropped. The
> ja -1 special case is subsumed, such a jump is now imm8 from the first
> pass.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
small nit $subj should be "bpf, x86: [...]"

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
