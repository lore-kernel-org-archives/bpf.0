Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478975;
	b=FCFiuXEcLWJfTrpB+PDWe/nKuEo/mNBlDOkcnt/1z3+ocK9m6CQEtbYpo9ueXLlc0K+r
	 LLQOznFht2GqUuBSQ33Z4srZz0XUg8r9A7/H5mqPeQMIeFHNSNSqyhR5H3noKc0oATrVx
	 OVIIX2m802rK1CrZ2/mZP55Q6hto0r4wpWkeNAPoDQuLZd4zOVBP7Q2n6qBE8Z4s/CCqa
	 EILRlJYHTiHDPOdDFrUVr/pb2N1bVadTkaTdl0toZgDMOy8/h19juMSXCnNsXyfocc8Ny
	 DYEyBBPmUdGNMu4uYe17S0quMRuopSidxWHhnGNIbY/rP21qL0s0iG6FHN78IDJLFFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=E/4cjgmZrvsEDLvCrqONn7jSN+CoIj9kGy+TZqvJBHY=;
	b=xmAHMs45pQYq44gsB+u2WhAxxDS6ldvV5tpclnDpB5piNKbWVCuz/m8hM4yYD94/Vkv/
	 cs7bIvMpkrhDSCgl4gnuqOG7CFFmXzltLpoiUi6UY80SXcG8T8yKUWuca3XpLzN80oWmH
	 K8zYkuymhVcCOSrhcpn7Xpz6vdZGN6albfKPBB/uzz3vepNEoijWXVBmMzXTYa3c0roJm
	 1WVJTiP3nrVyV2+iz6QIhxwa5zaeGzT5GETIIrCGUnhUOj4o0iVPQGMHY6Nb/kL8kV0lQ
	 5bavFDOwJVSyM93dGav+GGGJRIKLHW0UAegwUiJfvKU6JEWe6LbIk9AQt3fRX0AlmpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pDt2tmkr;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9397606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 00:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9397606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pDt2tmkr
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f04ad2c46dso21366865ad.2
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 16:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795478974; x=1796083774; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E/4cjgmZrvsEDLvCrqONn7jSN+CoIj9kGy+TZqvJBHY=;
        b=pDt2tmkrFCg6Y17UawlM165SOXL1vJgFG5mOPhPlm4nLhxwMRDba+gstMunrqCPPjN
         HrSOYhuJP4BdtZ3U3FW7TQ5v/xUVo/VYBewKLEu81jB5pxDY9U8foDC6WpeL5DKp6kSO
         Ik0CTfPholQbVMypjBlQx13gK/TZmI6VfGfSFA7Eo7JiOZ+nm+4gqYhTk4ytzLDaspOu
         No8kDr8BjXm4ijRu/21Mvf3prXvydH+B5HjLKOgsFxjxcGWsMauF5PVKPlp62u0uIucP
         eDo0rew4M97n3WZbHuDHbyPzyspr0cZqWyfHwG5+aXAW8sZXoI/ofVFPYyaGNYgAx56J
         hhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795478974; x=1796083774;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E/4cjgmZrvsEDLvCrqONn7jSN+CoIj9kGy+TZqvJBHY=;
        b=2Scp5WoKgqku9mZkRF9hX1FGXCl4zEjbduDkr0pExXBhcRtsU0+X1apP3v9Nvz6Vkc
         zcl1Kvu6Ex5U/Ky4jHZ29FpIlb4CXgaPcHeIRoqd1nMRnEdUhE+cnEHDiMBHGlgfDoqm
         pwtP19bgrxZUmyMP42/IbQ5ndAKkI8HFk4Zd3b8NC1eexTqYPForGVXEfmW7x9dMf+/n
         6Yswp21wLooCW3KSELdh1PKxsFkSoSefs+gOq8DKX7RaOsAouDAJC11vpf8EBJdLR2vJ
         JsWiKRc7BMuaYeyrOhfzvdQfVgq+fQTsd2Vq3ok2z8rM3iFSpWGdaP4lOsf0EZXBFJ+c
         g1/w==
X-Forwarded-Encrypted: i=1; AL+hErEy6OrKcxeSD8JhYf7K/MMi3jUfyKc8vCwWOJwkGkwbRcKq7dNf58+YMKz8c0Ilqa7wzaA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xeDX3L5n6i4iOmmAo+NFwUUOn3DTMFb6XxJQ/zUOwmvleVUiA
	9odL07SxuT9NcjtAvrfLOs96Gpg/l89cJcRfEld4/UEuEy4dj6IMMYxN
X-Gm-Gg: AZFdTZdxDf8Wn68LCBxyy9xcddiCnF0y4KXDiWRul8T2WYLP+5vah9atmBAv55goM0K
	NHWWq/1hO1fsk2Aofs5liqTuzF/6kINu3Eg4yLR1XVDMla0r5N7TtLWV7qfT6NU33ZYuQ/6vfxU
	i/kvS9VtqrZ1gkK9F1DEaPyoZPCr95i2iGxnoieZzubjWyEsJ/ydk2CSb4smU1xFxy9IZZRVhaW
	QQz2NlRMvO6zenAT3nf+nOGSGoqMkrS4K1ngiRI3T7kFi7gnS9H2Z5l1LGG2E1hQQu45T7eDSeC
	E2O52UHSJ8xNQi3bDu/1eM4bikCXnYhmGMzLZ20wsr9wIP/tt33Ky/rAG/oY1XYAla1Etq5ci0U
	J9HA8rDVgCblde83z5HM0Qmu4nyJWQApik5+Vvug5W7iwNnCxpLKRFjYQn1j5Z6pRtYz6d65oIv
	Esd4hLVOX+JZ+Tw6j+RjbxvwodY8F/fmK5ipKPdlSY5x3buWiPGvGwQMkDP0Nkb1QPHSKNseVMl
	j5BHxHlQbWK5SehKm5qXXpDMX+1INPu6iuDdONMx3GhHJkeHC0n0Wqw9XsSnjXpYrj16qmDO0hZ
	vPih9NPWQTmET2IIsT7bWGS8TfbL+AZUic301dcszz0spUu2qFY+5b5reShPnljXJ8KqOJFEf3k
	f4tGETh4TcWbXcIwoOGXAX0p8pioo2Vc9b2Q=
X-Received: by 2002:a17:903:19cb:b0:2f0:3b78:29fa with SMTP id d9443c01a7336-2f03f1df637mr136503295ad.50.1795478973914;
        Mon, 23 Nov 2026 16:09:33 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f04ed9620esm51747835ad.26.2026.11.23.16.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 16:09:33 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 00:09:32 +0000
Message-Id: <DN306D66I504.3FVD9L4Y73WQH@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <almagui@kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <nathan@kernel.org>, <ndesaulniers@google.com>,
 <morbo@google.com>, <justinstitt@google.com>, <a.s.protopopov@gmail.com>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] resolve_btfids: Match the arm64 NOP opcode for
 LLVM 24 in text_mc
In-Reply-To: <dbf929f8-5ff9-43ec-9eb3-380936ea6568@kernel.org>
References: <20261118194030.4103149-1-almagui@kernel.org> <DMYT224YKW0Z.2NAT6FTR68NQE@gmail.com> <dbf929f8-5ff9-43ec-9eb3-380936ea6568@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 23, 2026 at 02:26 PM Alan Maguire <almagui@kernel.org> wrote:
>> But should we go further and skip unknown names? Like:
>
> It works for me, fixing the original issue, so if you want to apply
> it feel free to add
>
> Tested-by: Alan Maguire <almagui@kernel.org>
>
> The optional approach that's in-tree currently maybe gives a bit more
> up-front diagnostic info for failures, but either approach works for me.

Thanks for testing.
I guess let's keep .optional for now.
