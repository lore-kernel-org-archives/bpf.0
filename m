Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642143;
	b=Pu8ag3XsrDg0M/x6C+30cntFLmRa9MGw59NsoQ1ilAs7Yobm/fwc8q3XOiyjPwuU029h
	 t3013mlhMhlYTnynFqK2huaZCkbHe8hcKlau75jFkgFGnx5URqQ+Uevi6poTOb1JQPfde
	 +drwNUkLY2tDTWMTqlTjqnIZembXqiSOcbc4/GhQvOO3Pr0YphrHkdVwy//AEC55TngVH
	 jpgu+n9w0ldJsZxjknz8JsVyuSiZpXTGO+eubAPM33kznuS2c1xe9fhk5bQC2P3Cf3xeL
	 SJnqSwdyNhGTtpHZ1CuvqOClc4N7Dvcgu01m1yir6YnFuay67Q3TID9TgY+Ym3rh1oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:X-Mailer:References:In-Reply-To;
	bh=2WTgLxU/cT4wIbyRNLveIp7uJXijLoRr40GvNqXPiVA=;
	b=oTWXOJ5Vb12dd25iJYGy08UtlBC0QSWPcpIszG6feaWOMDXedJd8otQ5MBbrUPNCfID3
	 MCihLRylBQktIFAQ3O2FYzaOKCUJnH3+5LMnkA06NFw5yvxR6GQS1y+YS/u/z8JyYoXMM
	 oWMb3qBKqmg9p3/aED6b9tEHBCgj9bkAeh5CGpq2/J9xxC1kCX0xYFtpBU9Yoe7F4urJL
	 QKbO7jzOkfu8e7scxkKntNoBGNyluP4AsKucMfAiFoCAHW620gc1cgvgilFlfaqyuzi7I
	 yN23le6MHIST7LfrLNLsx2I7ykBinVLj6fk3vxRtNYrTZVtEGKo/3ufdNbewN0EDR3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0wUg3TlL;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65C606D804
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 17:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E65C606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0wUg3TlL
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8fe8e343fso22405735ad.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 09:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793642143; x=1794246943; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2WTgLxU/cT4wIbyRNLveIp7uJXijLoRr40GvNqXPiVA=;
        b=0wUg3TlLt45tO35LvguqoavmVCea8liQsxVmAwyyKA2nLXrg1WBQSgCILRKMHkxqcU
         uMQsWRikgmtbno9wr1pSfpRSlMiZpAoTUimIiMNqQl+QsWL+4jSBFi3+Dg8cMxeuLPtK
         3wIE6hT25m0uxhHTkXWhRraJpDwQjJPChXANTbZLmO87BMrpOuEsq2Gg5x1o/fi9lbRh
         ATEdtjZ0fWyNjEhzYcYXN9Ml92YK6L+vQ7IRh39UT2drOzZ13LuRXzumBZwW/Ztz8fjG
         R99HguCymOya2HGlgDhka2TgyDLKEKQrxCPYdChGy/nXT7aRy/fsGOaT/MXtInhkmFAE
         QNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642143; x=1794246943;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2WTgLxU/cT4wIbyRNLveIp7uJXijLoRr40GvNqXPiVA=;
        b=SGh+YxwbIS9Fa7ZX81eM7dTH78YcG/GHnfLmRldXT9ahqwphsKzBn2ZnSjp285My5n
         WHwve1IhJVxGLW8nTQb5xSGHakxkU6JrvsEQ2V2bpTPh2GxXGvO2LKG2n88JpupaJHx+
         SssK07Fv9YZaE9g/43Cama30V0t1+6IdjVJo0MxoW4tsIiJlR9hnLrKzPH+wHO3nlzAJ
         hV9saGD8rRUJR17U9x62ND5MPETTzj4D/ftD1uuE8kao471JxWcEp8tTcXJloQlqzsQE
         kMYIWV9FJ68gyYKexOGLd0tHiDDoBAkqzr3OOdJqs5ozOC9yIrEZMDnBrEpWtaKGAnO7
         /30Q==
X-Gm-Message-State: APuU4Z8BeItr907xwrO8+1HWDke85ceGXe9UUeBsZJhjL68V8Y19ukRi
	+w775DaVFrBj8vAuecq4CJZW5vQRkgoeQu15M5r86LkCssaiKHAo4s1A
X-Gm-Gg: AYBFou023R4rXubvXBhVs8aNwMZigUXyJLh5xOEJPz6SqalsUk/m2TIf+RzlasYYu+o
	jhkCmNkII1Fm/tlZlSTFtwPL4re/blIWVt0mnfEeP9dWr2OufQhlRso/ezZH1Qs/buTnAb4MZEf
	N+7Lso4VLqAyIfwrmQ2djZfP7Mz1sZnzDYlj38m0J1drynstulOp4jgliHQwWIsvlxxfqCQS2qX
	jeov1zKWFat40wUpuC2MsMtIhOBqmz6gDOKl1axBThDoYqLhbwhXoelldod4OZF+hYivBCYx/fX
	HTwSb2GQh/1uzlCAdMubf8BUx+jgFX6V48c3gF+zf4+J+0XQq3DIMOPKlVfElrTYoRjXivP1lvh
	o9E6ORjBRK6hj4W6xWXjtAJN+e02wUKVjQaS9g4K9il6CpcOKQkmqaHQjLbXEyCYy32bKJV7TXl
	ayoK7YqEp9uOhCovozChjQjwMmLhhjYPFc9l+PMxtgvsKTeF/QTSJtvQ5mU+qfVdiadK4p0gEQm
	i/UVs5XhrQqXgHCI0BwD4COrdC/5FuRkWIhZadgDyKoYywqkCXZuoaD6iCxFfDq5z/C7tMOSLED
	7IlLekKeCsXCsJ9F/q1dBOVLYfrt6CI3maGuJypJoCDzffnI4zZnpHkRj8pn+VLlL3oBh7Gp5ze
	ICR7mOuyftWwRHzcVIg9OkDw8Qd+D3ZoRLVQ+Lx/wZUV0hBN4Pf5Ahvo=
X-Received: by 2002:a17:903:19c8:b0:2dd:c0ff:e72c with SMTP id d9443c01a7336-2eb3648766dmr91684985ad.62.1793642142679;
        Mon, 02 Nov 2026 09:55:42 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392ae011sm29914295ad.69.2026.11.02.09.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 09:55:41 -0800 (PST)
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
Date: Mon, 02 Nov 2026 17:55:41 +0000
Message-Id: <DMKX2OGTCFW1.3K140NUR106DC@gmail.com>
To: "Alan Maguire" <almagui@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Alan Maguire"
 <alan.maguire@oracle.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: resolve_btfids segmentation fault with
 CONFIG_DEBUG_INFO_BTF_INLINE
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261031040305.GA2789538@ax162>
 <DMJB936DLIAX.3166HNLTM50U4@gmail.com>
 <b32cb1d9-3ab7-4c2b-b18c-c8d1989637fd@kernel.org>
In-Reply-To: <b32cb1d9-3ab7-4c2b-b18c-c8d1989637fd@kernel.org>

On Mon Nov 2, 2026 at 5:47 PM UTC, Alan Maguire wrote:
> On 10/31/26 8:36 PM, Alexei Starovoitov wrote:
>> Thanks for the report.
>>=20
>> It's a use-after-free in libbpf that resolve_btfids --inline runs into
>> on a module whose BTF has no strings of its own.
>>=20
>> With the patch below that module builds and ASAN is quiet. The output of
>> resolve_btfids for vmlinux and for the modules of my other test builds
>> is the same byte for byte with and without the patch.
>>=20
>> Please give it a try.
>>=20
>> [PATCH bpf] libbpf: Fix use-after-free in btf__add_type()
>>=20
>> For every string btf_rewrite_str() does:
>>=20
>>   off =3D btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));
>>=20
>> When the string belongs to the base, the pointer goes into the raw data
>> of the base. btf__add_str() looks the string up in the base first,
>> btf__find_str() calls btf_ensure_modifiable() on the base, and that
>> frees the raw data. Then strset__find_str() reads the freed string.
>>=20
>> Make all the bases of dst modifiable before the pointer is taken.=20
>>=20
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
>
> Thanks for the report and the proposed fix! I've reproduced the
> failure with Nathan's config + latest LLVM 24, and can confirm
> that the suggested fix works. So feel free to add
>
> Tested-by: Alan Maguire <almagui@kernel.org>
>
> I'll try and come up with a test that exercises the failure path.
> Thanks again!

Could you pls commandeer it and send a patch?

