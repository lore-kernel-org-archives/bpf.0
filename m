Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794248186;
	b=iq/F/nG7VukmWSqpbqfbLUi9UgS21fnM91j43F58kLHjg/EuqFeNRWg7+kR+sH0zRPEk
	 9HhkZVNFEun3ZntB0YGYmOy0NNufIP0gpx+Cpx2pa5XvcdC/u1SJt8QTKP7wHp1mW9gjG
	 5m0MMFHVRPM12QBgFw6pz+YGMxfb8eQ0ndZuKUlrRlcRat1ohw7FJAxra7zNGuXWYft0t
	 +BxBO49wmASqhIlDrM+RzcC3ywOABkccpjf4Yb+1wdRo7xIWuUJWS7KpzxN0iQ9oQEUBd
	 Z7cTAbo30C/ryDGIc4FdCobSC6EXAao3Gk7NceJ82b66XwaBdn8n0nJG6hPZeHJdp/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=WguHA39buDjvDkUGeUWcjbqwEXew9kThI1dbTtyCUGs=;
	b=CeYbjOxG+67AJi7Oga7MIh3cHvTbxnlZ5LTn2+3jK1f1d/UPoxcTBf997UXDWFMmDFLX
	 yPbwCnJ6jAXqzkgUA+H5SCiZV9hGJw3NoeWh4uTbkUo/5w5nSrym4wQr9SeVHfSZm5puq
	 0kkzHWNn57T1s6gvofxiRmDTu2owNoWsH1AasKZNkOCZ6ClcfAdc7JzSI9wTyjnmNW+/V
	 rOkIYOgTOv5vcX8iwH77w6ssdt+jgiy8Mjv9ewHOibCTEgCQ+79IW+j4fuSrSOaPyZef1
	 guRlomlWq5C5GOpWyEO+Xy0ZzYTjvGxX3db3hUACt1yPt5Ul+NAEEvFF2oj1iMwibpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=akzXAS6V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7C606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BB7C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=akzXAS6V
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b0cf2c0785so11299477b3.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:16:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794248185; cv=none;
        d=google.com; s=arc-20260327;
        b=gf7gF+kANJeXXsWnBJClaqc56hgR7r07ThBahGYrnw+stCVNJJ401ZW9maemyM9SMH
         J4/zqkjmHCikduZzVzamCxmUKduMyWoNg5zQn66KRE7Jxzup7psGniwYQ/EYj7W4YU7X
         JlILj16CRCFbBcdbsAOctYhZ1Uj1WpDI4bv5S/yc0UCE3fFmmcbo+sANlIUbjXfhylgY
         kQaL7qmnItdi1t75HmNUm5uDaC/b9alBEcC7E52gHjD8Teze7kpoqYIDoxqD9GWZZn3E
         tOgCL0dtHMK3tVJkoMS4NkJfHrl8U12RkzxvvoEgDrsFqsIrVGBrU4NtW9F4zPYnILp4
         jHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WguHA39buDjvDkUGeUWcjbqwEXew9kThI1dbTtyCUGs=;
        fh=zZGdbyEGxm8XejUPzWnVw8323rc896TrcmWZOhzlpyo=;
        b=CFpDsjWvQlz2uER3pcwNl0Qp695XhaOsG9T7fGaDbVQoVpIDM6FFmnM+MifVIMB/z+
         n2Qnk3VBLzDg9gfAWXU1O/R8Repn2yDpvG1/1ZhxgOyuBVKrFQUoxH9nPLlXpMpy8btU
         1x2mVppfAa82iK1Cw0Lb7UGTNK5G/mN0wXteAwvVWriz2YVqz9MfsN9KAcNe59178JRr
         w7CoxEqUwcHtqqDjd5puGAV23SJVPQHw15Az7ZYj6pHGEzrV2yIH/7kozPBGZePA6qmH
         nGIDi5nb0cS7lJxcSQ5Yf7+1/oN/SJ9H0p4JP/q0T7M0OCau9TNVW7Q7GQhY1RiLq0PL
         QxYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794248185; x=1794852985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WguHA39buDjvDkUGeUWcjbqwEXew9kThI1dbTtyCUGs=;
        b=akzXAS6VvgZQdwydBpiHrBqKmC17dbITpKkm0yJ59PgGtbOLnz081MkgWit+tQTy4r
         FFhqSpe0aXk4/hWfHD1Bzr9lGLnj7WwbRgdCj0xLJkejWGY7BxhjgH7c4WsXgJZOK5Cr
         i0Yb9JguBMs6CTRjnYA8o21Zvl86pU3mNV680qNuN1JTk8E31ikqESDCSbYVvqlPpIL6
         OAjBXQszcI4vQz685iXQQrlm/JT1bCW7BW2qRFyprCeA87yCqpvMdjOpd7iuU5JYAWH+
         OZRxSj0Wmc03D3PEyx8kc/i9xGHj/HS8c3T17ykRq0ZT4wBVkrJFqXEWw9a6UvpFlrTt
         5o2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248185; x=1794852985;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WguHA39buDjvDkUGeUWcjbqwEXew9kThI1dbTtyCUGs=;
        b=mea5YmNVCgoHcDRXQk6ZniDsKvbFikHfNmcIKC14ZSp2Bn8Y4fIECKMQcuZB5B4Hr+
         eGuYSF50PLBhlJ80J7S6760qy7vpC35JlmHt+zzEE+mieFUlbdorKvZo9TvA2Z63ZCA/
         Jpk9qEEE839mhrK2PQgDqvy00BSdu6HGsU9tvragP89kAf49HHEyv7cj6DfqMSwhqNZ3
         gMR+dqXGgspA9o3TUAz76mR+CuI+089/efm6MgjJ0eytACybrY+0T26tgcFEm94N3dDR
         ILd3SCd4nyY/Feab28HSnl9UtvDP5ZFJT4BL/N9C96UOkaGRogBttpk7c9gJ0P54lpCO
         dB5Q==
X-Gm-Message-State: APuU4Z/UjLAtBd6MCZpzVWHS4DApa2w5e6eJqYSbAyQIqfN84fjE/c5e
	nq8HC3M9uee5V5zd6sWJcll8J3YnlwGa5oY0MtaTRGOzgjdDdKJp3P3c+WOKnQhBCDtZGMapFyV
	a2FM87Oxv75/LFlwdZlkgDI2m+Ze69JJp/y8w
X-Gm-Gg: AYBFou3G8ons0/TiSZFS9MpLCRZDFnkpO+uGznLsg7+np0D5jmiTNssAvWApOui7//3
	aEhyVc5h3e/E69+s1vNQQ6RfkKDFM7pnqhmJsO5d2BvuTdoCQhSZmefDpqKcV8xnp6snwHtEF39
	xWWfTknI5BL2v6pgXifleAGvL6j3xyByBxkmn5m0sTs0tbKNuERd4hEY7j+4aH1lIVDQ+xtPg4o
	OQsNvlLCwxQpGAS52AsDY9pba2FVJ7DSQhb7bQJjOkmqiWScG/ElWsg45kSAhMikYvp6HfjhIXE
	pa2RQSc1hxExO8naqTUJ6E3ALV+0pKm8pjaSv0Ot0Dta0BAJN1Lzvgm3XEOVI6PPcyev+xO48AZ
	inVHT4zoAmURvAjeUmz5DoZMPJue9TXpQ8uaDlcuD1s9pU/EjXKtbHtj33pnhyIu1kUfjhVepsN
	MW9uCImDPo9gd9BQ6uFNcQe+Irn+CFfAojE0F5XKQIXFaCcwyN7fA=
X-Received: by 2002:a05:690c:102:b0:8ab:a473:fde9 with SMTP id
 00721157ae682-8b392c78248mr933677b3.95.1794248183992; Mon, 09 Nov 2026
 10:16:23 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Nov 2026 10:16:11 -0800
X-Gm-Features: AclHuK_1-KxkDJrw-5_U4HDm2IfgGXbo_lg0YtOMALh6-47yirom5b7AmLH10do
Message-ID: <CAADnVQJcUAE291v2DWr=NOrTHWRVvsTrcrqyPsSytMg3-aLoiQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/26] bpf: Find linked registers by scalar
 evolution, remove scalar ids
To: bpf <bpf@vger.kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 10:47=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
>
> People do not write that, compilers do. In a loop over strings or records
> in a buffer clang computes 'buf + i' at the end of an iteration and tests
> i at the start of the next one. Patch 15 has such a loop.

and I finally guessed the fix for:
syar_file_open        |failure -> success

but broke metarmor.

If somebody can paste the last 30 lines of veristat it would be great.
Or embrace more spam.
