Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640235;
	b=UEV71fXwmbH19rJQQ2XyZScvrXY91Tuf+4K9dgiC4YxXcalLfRCG3KQ1PSA0CzvB9JS9
	 fGyV3mxIGaSRmHItGnWSkdElMk7S245BMx1lARpSuRMLTS6ON4O0icE0KldnMbAv5lDy+
	 Bego6ZxVXwt42zNvVV64lmweexcFkQv4bwO0rpyRIHBt2gHP0g2NJLdDosxa9CR78mrpr
	 kD5/1wZE/VcUdQraCVgVZPgG4S9lPpMH+r+lnktqCvdh9eR89Okx81hpC5TJ5ZQZcmsS0
	 8gffFEu8d7L4fqqEQJ4r/22TB6qcm3oGi8KYEFomuiIFcun24nAYpDlf9QndY8l4H9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640235;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=mgKk29cEMPjhkL/nlf6+/Mbk4gVlKk12lMtS/g48E/Y=;
	b=5mwTnAuQS4azQI1jzCqFqPwP5ZWxplPPwBna3LdUZaFITnnwYGZoOOC9qm07N8A37mo8
	 kq9KB471WciyEypICiJCSpxkx3FZgei+VSZ/bK63yBg+7yzWOYJK8F+V4vd+QxIrVzepr
	 cLPRi1w12tpCgZNXnEKs90dO1m7e4g0S+aP5hVl7QYDZ2wWOq6IsecbU/TMHA9fgAIsB3
	 VYm6q24+fQSNVRQg4DGG5NdtmUCty7Z/MpLJF5/X1UA7ONsi2zWU31nCs/EJ2Ldp2DmfR
	 +JjIXFVKsK1csthgMdBtHnRqCkaMWriEvtIVYG3kk4WBlTgcQSjBqT2WreeM2jXcPjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pPKMCILm;
	arc=none smtp.remote-ip=95.215.58.138
Received: from mta1.migadu.com (out-138.mta1.migadu.com [95.215.58.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F281606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 03:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F281606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pPKMCILm
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=v/+HvHqCDL8KYF8wOBFc643AIKQ4/I0Ny3wDaVlxt+E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792640232; v=1; x=1793245032;
 b=pPKMCILmja6Z+PWBaYW7Eo7OZuyOR4KCx329VPpB251MHNPXPiQlV8fqD2mrk9qG3WQMtpaJ
 ses3l/V5Y0XIm8z3OF0q6vt+ImzMHFUMiGlUcf5Uq0dy3VC3qt39MVtHuBYk+nW4PZYXAq+EG88
 tvllewqy1caWKwXOPXYky3ic=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 75c4dd5b6378d2f3;
	Thu, 22 Oct 2026 03:37:12 +0000
X-Mizu-Trace-ID: 75c4dd5b6378d2f3
X-Migadu-Flow: FLOW_OUT
Message-ID: <a9d1939f-1787-4b9a-ae5d-f2f9852ddc67@linux.dev>
Date: Thu, 22 Oct 2026 11:37:10 +0800
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
Subject: Re: [PATCH bpf] bpf, sockmap: use READ_ONCE/WRITE_ONCE for
 saved_data_ready in the verdict path
To: bpf@vger.kernel.org
References: <20261021155629.68813-1-phx0fer@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261021155629.68813-1-phx0fer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/21/26 11:56 PM, Dudu Lu wrote:
> sk_psock_start_verdict() and sk_psock_stop_verdict() access
> psock->saved_data_ready with plain loads and stores, while the sibling
> sk_psock_stop_strp() uses WRITE_ONCE for the same field.  sock_map_link()
> / sock_map_unref() touch the same psock from another CPU without the
> lock, so KCSAN reports the race:
>
>    BUG: KCSAN: data-race in sock_map_link / sock_map_unref
>    BUG: KCSAN: data-race in sk_psock_start_verdict / sock_map_unref
>
> Use READ_ONCE() for the reads and WRITE_ONCE() for the writes, matching
> the strp sibling.
>
> Fixes: 2ef2b20cf4e0 ("net: annotate data-races around sk->sk_{data_ready,write_space}")


I think it's just an incomplete fix which you shouldn't  blame.


