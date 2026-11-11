Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412017;
	b=03RPLiLM5Zt2IhWhssdMOASuNGMLhOl4bFxGNkqXADNJchMAQAR23Xx8lyGtJNK8kFv6
	 Xr1c25wqpm8BLVON1w/2OXLV/AGa4XhNR3chFvz1w9bTU8++/U0Rt7WdzUPEiNffrdneS
	 EZm5C9+bDqa3FUq0AXdrh4oDP/s4QEx3Pjw/LeK6Npp8f9EEWZ7ub7EDBApQ4ByKdxdW9
	 1AZjc0abzxHM8gcA+CNbPrCMv+ENQV0NN67CjqYvX8rjYYBmsEjJvRIbCLV1o3veTYbg3
	 6jnDhGDIuIntpIpMrFQqwu5MVyEXrodncx6uU2E/tO3C9Lctp4kBbsn2kvwQsgQk87A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=wQKRbkibDLGyy8037Dj5AspxGYwDtlAwEFieE15dtAI=;
	b=kdhQFUFJnAJeBgZkPj6K+7iZ03dIKLi/b0PwEr5FLGjszlT8WhCcpdeUberXTcZFrwpE
	 IjGxPbd4enA8aPZ2K/2JkaWfeUjnegqjImIRd7U5biKHBmFsVeWFd+TiY6sflwe1V0x/C
	 xg1CrWB9g7B81kHOoRm9IcUqXvLo2na46qXENEMY5MucjTAm9hI/oHxGYNNGBppyCftyX
	 YRhK89RZweGCaUxYy44fGfhTRHd2vz55fAwzD821o24Ffk8/1dlEM+zyqP4M56l2R9Tol
	 g6KJWnrdJ8bue/WvVPHpTyCve1fR101PACA3vXT+4hwnLqK/087Q/geyKlRxnVnqwZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vc1xSdt4;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB09606A334
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 15:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACB09606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vc1xSdt4
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a05b210703so1735757b3a.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 07:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794412016; x=1795016816; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wQKRbkibDLGyy8037Dj5AspxGYwDtlAwEFieE15dtAI=;
        b=Vc1xSdt4cebm4rMu5+0OB509uCTBmt2Rxt5nC6VpC9wA9OsUtrQdWNdvltU5JLltcJ
         4BRbLKV/GU5khpkhtyxpZPtUmuCW6J/sE1prp8NTe1OJIzH7mIPSKltLHk9sQ9bDbVfF
         dRFpUEJdYLCdRjAALSwLFHoWTFTBI7IM0t9ABZ6urb/oQ4nW56XDulIEB7YHD+MQ+rQa
         jWPJNJ6MCeFUYvmiGxBCxqaxEkMOqU1onw+zBpB0PKmWRXf0wzH8YI2rzBcCQsYCVFre
         l3tXSLyDqfTSyaNqz1GSztwlfrVzDGoMsDeWcAmVCMx7UuguAKaImjAEOOewXJF+Mdq9
         dCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412016; x=1795016816;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wQKRbkibDLGyy8037Dj5AspxGYwDtlAwEFieE15dtAI=;
        b=VMkHckiT5B4hjewb5OWsondUqnGuZtRLlIs8Mz/FCOt5/XsFLNarkrdGS5TAw90EZy
         /w4j3E5J8Z+z/KMKi01l3L8cN0mlq9ijvLOXbOJfAM/Su+efjNiuBrUuZwbjoKiH4poo
         wZ4veevPC8hRk/jFJbEwCHrfbtD0qe9OngmuGZiguZhvfeRxNQt+JBkzvwQSJ3U9g2+h
         smjDJAsaIy9XgiJOdQwhYC5RGmzCZPwSR8xsmwE74SLt2A+ld/2ogzqznMzcDrh0dtxr
         rf2M03PmiYUKw5n52auH+YDTGPSODDkQu1n4bYzRvrtGEVs8D8c7RAFd3TFwpzj0CRer
         Bm+w==
X-Forwarded-Encrypted: i=1; AL+hErGzp9SdMEZ5Clnw9iPnxAnEwdD3AccRyvc3zdtlP4CKX3EUQPGCPxbnCLY9rWwlM1emoo4=@vger.kernel.org
X-Gm-Message-State: APuU4Z99sxh2sJxjM27DwKPSEUwUlSFH1MBbkU6PvDwR3sG0TghAnsyS
	5OCMOpsdbdOrt5pxh/BbiL/26epDZX9VOMTZ1VhZUcvKStEnEiO6qJoV
X-Gm-Gg: AYBFou2Xo4tZC747J65k0nvaOdPrUBNTxvyqBEj81xQ2/AMKPE0F0RvvMq/Ckq3dbsk
	B98pIAh2255HrLETmUggtLgcxRWB88ji3YVaVSMg3bTUaxKXEwdgkfdUKA54r5plyMQqOOzeJBe
	6eqfTMySoS9JnJgBqEhb1PN4V4KdswVN6fxZA2dCIi+SOegje01PxBtCtsXXy9ANgDM7ORUiUhY
	M2AO7vWG99c17BBotPIlXqSHiqC+TY7FvDEGl70Art2N5goLaBjH/zkSjcd8YRpsbTL9TkSRneW
	ZqVAa+ERQGfwOpxsM3jrsxIz3VrNJhaYSgv22gQaFlGXcWhTZZz3KBmVANA0v79D8pWf8RR2uJV
	D9bd1cffaqMrr+isblkLMZuaW06jg7g9LX3/CO6x/PfxAmQrmoU0rszyhixzpsQX/GwNYuqWYG2
	fy9l55V2RY9uEFkE2wGQ+Q3zvqFoBrRkR8BG5/gHT0ozKZ2UAQa8VDsZDEH7k1510P4+3QjSbP6
	P2uFSK7NYCQ8GwMOFp88qsN5h8SUmW7lXbv8kX8g6GmLz0Ad0R5oLofUhhMx/f+hRmxu6grj1OQ
	ag6/Wj0aRIJErxSoI1ySAz/PIR1GT6i3sSMAwd9wCUHscvseb73i8Zc3tWHY6ynYfxxGpqcOj43
	Zoa6XpEZ3ZzF1RfEB2dWszcr9mca83HX6+JHd00V8CMzzVVycN0U7e9L/
X-Received: by 2002:a05:6a00:21c8:b0:8a0:3ed7:939b with SMTP id d2e1a72fcca58-8bc1d913140mr3244215b3a.29.1794412015861;
        Wed, 11 Nov 2026 07:46:55 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa1b1bf1sm2278182b3a.12.2026.11.11.07.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 07:46:55 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 15:46:54 +0000
Message-Id: <DMSHYZIRPY2U.1XX05ZPV3IA7G@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] libbpf: Fix incorrect module BTF fd index in
 warning
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Rahad Bhuiya" <rahadbhuiya2021@gmail.com>, <bpf@vger.kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>
In-Reply-To: <20261111064428.1902-1-rahadbhuiya2021@gmail.com>
References: <20261111064428.1902-1-rahadbhuiya2021@gmail.com>
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

On Tue, Nov 10, 2026 at 10:44 PM Rahad Bhuiya <rahadbhuiya2021@gmail.com> wrote:
> Fixes: 9dbe6015636c ("libbpf: Support kernel module function calls")

That's not a fix. Nothing is broken.
One object has to call kfuncs from more than 32766 modules to see
this message.

pw-bot: cr
