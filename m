Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795830910;
	b=N9T6xopjdqAM1B0RRfihYOuuoCRX/RU/lTGRxrcpUaYrXcLc+1aopmP53NosmorWLm7M
	 AQqhSMUa2zg2QdIRmoLbsiNW7oBmxbgWVAsveEKSramMrSaRxjW25C5lki5YXFqewRMXs
	 QfqpiROVuCqDbbaLPMaUg9CrWZnn/AwmaWVyTXQROonkcZBgeylgJ+SSteOxOlcqTum18
	 MEfwnzgonFyQZaLdxQsnAQdLDaTZ0CGRAMN7XmBMXDeOYpKSiSsz9qzkz0n3+ut/OzFAp
	 kGmaNYHfMDGJLuL6NBC91lhwXp7Mk1xnGuog1AjqnZpCvPddwcDhix5oZ8GsCS8VSqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795830910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=yg+nF3/DHZWeCaclfzP17sLUa502E0ljh1IjEbDb6aA=;
	b=bQ9gh7ClhrTCidhSEOyPdjFjNNiS/11jo8/zF+Ud/xa7aF/21M2frMoedMGEucQXgaMl
	 zUcThWUqMIJv0LZ3XnMv2+njrrsEf6tU9AEslOPcBJqqk4AU9DZbkVhNLG7j28jHqjkRx
	 gEuxtswOPMQ1MsogpghKjWpM4ijG/0BaB1FQ1N5t+M1q6KcOTW+a0vND76yG1n5ip+vqW
	 YwW+K6IIJNfL3zjh1TrrQFvCiAlbasXlJPj9ezoUMW7aEaK58rTuzSzMJjm1zCoR5joAc
	 lutnXRppVVqunEp1naQ1xWf1r5iLvJfZSN+QpuV6K8IaYCVGA5NorLx8VnevALA5KZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aRbNcXqq;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BDB606A31E
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 01:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96BDB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aRbNcXqq
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b51a9606e8so1453590a91.3
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 17:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795830910; x=1796435710; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yg+nF3/DHZWeCaclfzP17sLUa502E0ljh1IjEbDb6aA=;
        b=aRbNcXqquXrzlHDhQ/WiHF1nWVm7wRVifH0QKrfHvm4lRbtM0U8Dd7uXsDC7/eU8XP
         paZjJ192mFNh+jFDIHeh6MpMtFXXHw63KsgsAI2aMQ3DQ0uMnb/2jieMB24cRQi+wY/v
         d8qk+NW/uO0jfWpzoSPD7lAkj6DWWYWhcgPMXfdS9rAaZH47o7mfBoednZPfRWx0J+a9
         2MDQVqHcqgqhhwfCN4lSuLJYoyDQ1x4HK+QwiLY5FxUjOw+bQ0fQSeryHhxY5x9qxJwP
         6khDFa7yZQQ3F0wKgBb5ju4qWXKxGVb5Kx7p9Inv+s35Dijngb6wUYitDGyFSA+A/Be6
         uX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795830910; x=1796435710;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yg+nF3/DHZWeCaclfzP17sLUa502E0ljh1IjEbDb6aA=;
        b=RYimSY3yFCfNky1NOvx6hNlrpIjxswjhaffUBs9E0YB9/K94vc6DjN7FJOSs6iXn8x
         vsk+49FT0pFZ5em0fCiYBVHUNdD8lorZDCxpuqoC5RUZWIqk41/WcA4FnEf6DLoT5PMy
         GZkpOrho2vFE8NbUtIrCyBwlVYUJ+WlkBoANqDGJksEI5H//wjWwhMzF2Q0FTQXO2XS7
         QS+Y33tvkYU8qNMo1Y9ISPwu3m7skMS9vuG530k8IeE/B3/tGUzy2NohOProEQej/7OU
         O+WE0ziAniaiOEsN0la7QjzgpRx7k+AxdleM38fFGit6LGNyx+Aj/1x73c+/0Yn53x/U
         /UvQ==
X-Forwarded-Encrypted: i=1; AL+hErGWiDZzjd0tZZCRL0nVECMv+pa4TkvtuYbNUIRHAAUwHmdEl1j+41viHY4glIrnSyWzvPU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mCamjMqvuxxxmznEow0YfSsFYbcHQqLBPygt0VG0+sh5+bjxY
	Ffb+SAVaFw5/gmPrIFvAT+oXejohUSfRwAZ+iXS6e8nRFPQxDuVxJFL7
X-Gm-Gg: AZFdTZeh9yJ9m1zQVaGkwjIchgQu9j8z1iTzC3SiiBW5IJq2VeNoLMTQlHOyGmLMiq/
	XZapw5Ku+dT4c6NWrrObT50+WDlSYZAw32nLKOIuxQnn6ThwWEysg3+HTrvgUNCDEnHC/MHHpAX
	wUAj2DlBDsSvfJ0tNeb+LOPLRhaILlAur5X8VhIOI0ESWZa1FZb+fmnY5WxAYufgcF6EB0tkuiV
	bib4MlaWNKkfKm5K0mG40F8ioWswy1lVranF5IiuJSRVPNkBb4QhpRHNxpKmdB322Ql/s34xa0g
	phgj1hRxKhOWDAVFXOJvQPmThQDs1/9KSSwQBd0rliuZZehCCzB6WJMGJIJ3hFkrU3SUuJcWAiP
	OgZV1JnnGc8iffajGUUXleOR/akUICmnCi1uFRg6F4a6rc7laupBGIuRV46LhNI4Xe/8XBhF6tj
	8nDdrSiHjmDeIu7iQFIkuNptYSZSJBZInUJul7TWxNJlJJ7Mpa/r7ZKPUJJd4o12zCUuvr1ExKa
	W1AkFPgjLdJDEDwiMHH/LD4aYj4g/fxLd+NBjNsp50ROsYCWGPsiRIDEcyoh+fvtqmdlN+mbFLm
	iEcFhK5zL2lRsgjBLYmQlO2mqMeYJ1TTi3C3LXlxFO36bxmENX7xHcMrFxew3+aBzxWxcH7WQ90
	YRIqcCZ9MNfp5Y/ATT5YX/UYrEi/CZMfxCA==
X-Received: by 2002:a17:90b:1a92:b0:3b5:32db:124 with SMTP id 98e67ed59e1d1-3b532db04e4mr5148880a91.9.1795830909886;
        Fri, 27 Nov 2026 17:55:09 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b559644e16sm116344a91.12.2026.11.27.17.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 17:55:09 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 01:55:08 +0000
Message-Id: <DN6GXEDDDMGG.16VXQP61BMM2P@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups
 for user address faults under SMAP
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Andy Lutomirski"
 <luto@kernel.org>, <bpf@vger.kernel.org>
Cc: "Puranjay Mohan" <puranjay@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, <kkd@meta.com>,
 <kernel-team@meta.com>, "the arch/x86 maintainers" <x86@kernel.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261009024925.3169077-1-memxor@gmail.com>
 <20261009024925.3169077-2-memxor@gmail.com>
 <df69ab5d-bc97-4651-8668-a2b3e4bb272a@app.fastmail.com>
 <DN437OYZ5FGP.20VLV7ZEXQ5YY@gmail.com>
 <5f46d1c1-fdce-4f3b-9d56-675a822b2d65@app.fastmail.com>
 <DN4X9KVYMONH.VHKD1QED1BUQ@gmail.com>
 <03275761-8de2-41be-92fd-8e3012a87eeb@app.fastmail.com>
 <DN5K8Y9824AE.3GPOE0WP9ELFN@gmail.com>
 <DN6GS9V7A3HS.1COD0JUQQDHQ@gmail.com>
In-Reply-To: <DN6GS9V7A3HS.1COD0JUQQDHQ@gmail.com>

On Sat Nov 28, 2026 at 1:48 AM UTC, Kumar Kartikeya Dwivedi wrote:
> On Fri Nov 27, 2026 at 1:18 AM CET, Alexei Starovoitov wrote:
>> On Thu, Nov 26, 2026 at 09:30 AM Andy Lutomirski <luto@kernel.org> wrote=
:
>>> Okay.  So maybe there should be a nice patch set to *fix* it.
>>
>> [[...]
>>
>> The main point that it's orgonal to this patchset.
>>
>
> I was wondering whether one concrete improvement could be to emit BTF typ=
e tags
> for __iomem annotations in the kernel, then reject accesses on BTF pointe=
rs
> formed using such walks in the verifier, so such programs would fail to l=
oad.
>
> I think in practice, at least for BPF users, this will close the issue.

That's a great idea. Much better than Andy's 1-3 options.
