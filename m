Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793558339;
	b=qI5kQXewiKFezM8O3Lri6nmjass4tQlVINgXolkDg0/IwYmOeK5ifVzlrlLh23LD6LLq
	 RKpt1Nh9UaQuP9XLuV0om6qYsusIZvLfI74+CzpkAd91AfKDWq0C3RuW8Ciu4/0CqSOuU
	 GLzm9JvOIX5m6Zx1AHpGF3s5EFqVxu3irVpFewquq56MYrSXcRRhf+KmPt4O3TdJ8HTVP
	 2qXHeh3wBFfQYpWqP+qh+VeSckoM5uUb+ks3FW8mIGld7Z/2vlhuZ3RFqDOm8492kPaXn
	 wpCeuvBB4D2Y2hPsRPJ2tQxGdqTXo/nT9ermlSB8rnORK++MWfM1tMDfdFXIUOks3vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793558339;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=P2cTxEodlx1mrdaG6vZ5j/uK66L7NEyql53bANo4ga4=;
	b=2c1bUWdPNOxdTFloFfaBCGIEBf0sSd+Es52SW8zrMFTuSF1g45CdSS62NLktXqa4IKs1
	 QvOdAvFIbhYBtFMMjEJepIr+uM6va88Uc+jYRuj9CT70rCgqbL8bRDugPHa0FDA6YO2+A
	 A8iRN3DYQH95NMYiLUQYl+y+KmXXcdcuyfkoezXGUGWq1WIO0Xso1NhiblkOI/U7bzTZL
	 Tig6oWFQnsEAiM9UEdgkazdI2i+mkmXxUVtgFC307eyrvREyoavsIkn141D7Z3BxgBjxZ
	 lQb5ujdw29cxyHPNhtgk7ktIYfnRuiNb8hgCggOY/pXt+RlpwvzUZ4sPq8alEsTE3qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECEW+2J7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E892A606A324;
	Sun,  1 Nov 2026 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECEW+2J7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9D41F000C1;
	Sun,  1 Nov 2026 18:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793558338;
	bh=P2cTxEodlx1mrdaG6vZ5j/uK66L7NEyql53bANo4ga4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ECEW+2J717K/PqiIzx364cFS24fmMPWhzn+o8gUmJ3wcW5j+eTuzyDQ22rz5jHykW
	 B8tunzAMu1i/sKQiPt8RVU3Yz3XYKdSxRFO0oou6XmPAgmZS9TNapo94xkdceEQb3y
	 nVI1UMJ/ePQc06xou58jNbOutxSbQ4Sj7rC/fJ7w2GzktJrz+RUpZ9eTlEvVAYAcgl
	 043Bh1Hs5iyarvncHZ1bogAIIxei33gt4KRPVe2ZsaAwoJPfQHb3G2LHEV38ul1wKR
	 mHul8kLIlpHjITnGyi1I9U9MPrkYrVLo1DrvlKQ/RGaU22TQ1CDeY9BZwDmKQWEmOL
	 6CHCKJOnNLGNA==
Message-ID: <7de128f0-4f17-4a33-9a7a-14d5bbf62e64@kernel.org>
Date: Sun, 1 Nov 2026 10:38:57 -0800
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
Subject: Re: [PATCH] ARC: Strip libgcc debug information when generating BTF
To: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
 Sasha Levin <sashal@kernel.org>, linux-snps-arc@lists.infradead.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>
References: <20261015154044.4058618-1-sashal@kernel.org>
 <09db4d22-2836-4656-8c6a-a7e5377710fb@kernel.org>
 <8b4688ca-db5c-4122-b616-8e3964e403f8@app.fastmail.com>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <8b4688ca-db5c-4122-b616-8e3964e403f8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/26 03:09, Arnd Bergmann wrote:
>> I'm working on getting rid of libgcc linking for ARC.
>> This requires adding some GENERIC_LIB_* routines, but as part of that
>> series I'll propose a revert of this and then the dropping the first link.
>> Don't intend to revert this per se, but revert just makes it cleaner.
> Have you seen Simon's series?

No I didn't until now.

> https://lore.kernel.org/all/20261030-nios2-remove-usage-of-libgcc-v1-3-4e341c66082e@siemens-energy.com/
>
> I hope there is some overlap with what you need for arc in the
> lib/*.c functions. I can take both through the asm-generic tree
> to reduce the dependencies if that helps.

Oh that fits the bill perfectly. Mine also switched the others (with 
build test using their cross tool-chains).
Anyhow I'll wait for that to land. Would this need to wait full cycle ? 
If it can land in 7.4-rcX, I can hold off my existing patches for 
switching to current in-tree lib/* to also use the new ones and be done 
with libgcc.

Thx,
-Vineet
