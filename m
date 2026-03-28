Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2E72BE65F
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774661363; cv=pass; b=JXELEWKaRFvskQnbLICA4jyxLTmvS8kknEOG3wD4sx3I+x8jkSttoAruqBVBNBaXsKKLu8ZWf/NoSQR/tuVD5KkFM1Iu7UU8OHtKFFDQt8/t21SBWxRU+u5cYa8kTS6nA1HwvoOWLJYwtNsO2qfUJsZXCFgLJXvTHSCho+klB/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774661363; c=relaxed/simple;
	bh=bztnsvudfJGtKrmm++qllQqmxFXWeodR8eyj5SOdoiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVey7NOW/U7NwZxnC10xhomSmVHyY8TkgKgLGHazzqwr8GRoxd3xhW0TLd28ifCpSzXMyJCl2v2HeqX8R4t+Q9AsHzsz1TXx2svlFJq4nF6CrBEkOACcnB8YU82Wmpk3v6Q/ZDE3ZWTzZI+pxSUcgi/7M8TLR+SHe/TcWOYvE4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrGLOjbP; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrGLOjbP"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b9f43a1feso895412f8f.1
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 18:29:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774661361; cv=none;
        d=google.com; s=arc-20240605;
        b=beMa6jPbF56tmZ7Fv8kdanyvG74PVxAjQdV5678a+6urs8h3KIv2TM3zvC4/cJeWIJ
         ufXxJNThEWz4YbXqvTE49ejUyWLcKOin+FTfqKTH7KNUH/cUKzdy+42ZHAtXPNp2QDhz
         LES4e/KO2nEaDmE0rhlGW39f73tqmDhaZMb7wzKTyRAwroWPst1UaSOnNL5SsaDT2j6S
         Sw/zPwVQINRY6qZmvM0leIWSM+57DaQveEHjs4M/YigQhlT2hJ+XmGqkSIS0mWmtctMH
         gqznHFunyI4Uu3XbOu2rR2CSWmjSZ4Q0pOULzV4DdWBOL+XjaREV1po8FVKbVy+58kOg
         cd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UzNfKC90+8359qGzd4JuRrR+gMSegXg0iaSZehf1RII=;
        fh=QkgQ90jHN/rJUw7BCbvbdoj0J5ngHrGcnxTnT/sT3hw=;
        b=KDdeV0XktQtyRlU4p/QIBXnF03bde1nB1jqGEiiPkab5bPAH7IFRczGfQgOCldDfZ0
         qU56c5ESiiZB2U6fzY5F0l1eJQ/fA9xAh4PIfx7BULKa7Lf0bB/ixPegwx2sSEx7zBnD
         xLgTg1zPpqiYEj/7zgdcFhFfLeP7LLLLSR7umR7doeZH/adpa/bJrhTFlL1N57l59fUv
         f94FDohHksyqBxW4RACieljRhOnQABtz8nmlolYOOum2lYGbo09I7rQ9Ec7p2mQpOl7Z
         PRuNyrsJiNNlaJ4WyBA8Cvpnud7by3vnk4k6k5VMuTtKDDAsQ88l3rDLM7NjjGdsLMft
         MIhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774661361; x=1775266161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzNfKC90+8359qGzd4JuRrR+gMSegXg0iaSZehf1RII=;
        b=jrGLOjbPzUXrvKuRiqEo/Uqj2DaLRbPhO2Fn1Xm19/Njq3IAiUyRqtZOPQhyhgkU5t
         YZZVq9680f2902/oXMOoupofR8V+m6CNWpmApb6EUb4nxKTzuLzRv9qzaG+mnVDjZD3D
         VrgDBhCRbaLIqtJ3IvRJAybrT/PdgBWj1TsiajphYSAUWmZkyqd8zfr7OEGiPPyo5Iol
         N2XBhUbe4JmAl/XdOHWYJVXDhKyHITPHZ8VTzdLDPIS6o9Y5/3WvCZyYrK96+1Uiy1MB
         d0wmMa7X5dYE0nWRXK3/2IQ8NfcGO5ueHb2gSvIixDy0wWyQiyd+7AuC7tTFBfblcuVr
         ZEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774661361; x=1775266161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UzNfKC90+8359qGzd4JuRrR+gMSegXg0iaSZehf1RII=;
        b=pS32QLSkz3AtVlxVgCNMFRah1mwfFN/OutnNHej/s9juKsxOo9jqy+HjyHnPgMsIC5
         vvgVtM/R2WlWuSiI+gikwv5jMfNllJ8h1v+NBqrYjRG9ihDdKqOaRqCra5oVVgHmbrcR
         34LL03qLGFHfBlRiVBdMFxT30ywwzE+JtR+Op9xWyMy8Vfz1/H3802vtZGJgN5hyClS/
         T1KkAEM1muHWDBZyVByvpYEimoTN7inZlFDJvnWbcooOJIhAh/WMrvf9/0DIP+8qi0xh
         VLUnhznpSr7rHDEZYm2aTuL4JcI4uNW2ocbbml17oQnNFWAVVzIeVonKEAczMcOUPvTv
         bj2w==
X-Forwarded-Encrypted: i=1; AJvYcCXJAiVj1n88I1xjDdGasKubkGOhesGoN7LVeQ5NwRx1gIb0JW8rWwKDxaQQX60ixG1xevE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOIS5b75Egr87E69/0IsTZO0rEbkD12YP7L20oadAF0YGF3cXK
	Io1BCIex01iUxqcfuTAYxY51qEnKzF+AhTRjYUDWChee6L0S7B5TlKjNiFfjVe+Lxduymlyn3uV
	Q+R66QX9BenQ/F7QuUwZy9Bqh0AwH1Bc=
X-Gm-Gg: ATEYQzyCt4PdZsVQGqleBPnpKDCYRuVpkslg6+GrvPrPrhEBt4MczQ/zzTC535iePVq
	wcal9b3gRIq1BE92/hmcSOHPwlkjeIH1rW2rUjV73a9qbhuzDh+SocLQSuW2muw5hF/mp/kTQ0F
	KidKEYop+AzWV6PoFJ2xcT4sMwyRaT2ZtegVRD9cs9TSoOiMoue71jU3CyAot5YGOAtmagFWpsb
	MS0qxIebKtTDZ6mCKQHUTUOI2JMfs1t8kGYD2/U/Rw/7SENBEt1H3GjtXLG4C/a7fu7zktVQQ3r
	w9aW6bdHFw2ObS/qHAXwYfwWTeQb7qp6aM2DMYoY6DpkbW3VV/irC9HUWzEz46wPsWo3+LXthe5
	vFyiJjqWSOtQ/BWPQo6Kek4DOug==
X-Received: by 2002:a05:6000:200c:b0:439:b4dc:1e1e with SMTP id
 ffacd0b85a97d-43b9ea4a1f1mr7132103f8f.29.1774661360697; Fri, 27 Mar 2026
 18:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
 <ed857a23-bd73-4915-b080-558b5934bc8f@kxxt.dev> <79ac0188db82c675e62c36c8ab036b45cef3f3f7.camel@gmail.com>
 <9a418287-f8e3-4064-8364-ff85793de74e@google.com> <1c7bfc3f-c327-4777-a70f-48144aa0864f@google.com>
In-Reply-To: <1c7bfc3f-c327-4777-a70f-48144aa0864f@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Mar 2026 18:29:09 -0700
X-Gm-Features: AQROBzA1_rvbLenQXQDO8il8TPMcJPbwdzf1l_UkH2uYHdLqZO1bl6Wv_2-VjY4
Message-ID: <CAADnVQJqs-z00-m-Qdavv0bGSwqV2tUz+61+h-aw5ze_EPDoXw@mail.gmail.com>
Subject: Re: [PATCH 0/2] bpf: calls to bpf_loop() should have an SCC and
 accumulate backedges
To: Barret Rhoden <brho@google.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Levi Zim <i@kxxt.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Matt Bobrowski <mattbobrowski@google.com>, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 1:10=E2=80=AFPM Barret Rhoden <brho@google.com> wro=
te:
>
> On 3/27/26 3:41 PM, Barret Rhoden wrote:
> > are there any tricks with this new SCC stuff to help with verification?
>
> i was able to work around it, at least for now, by taking the guts of
> whatever i was calling from within bpf_loop() and making it a global
> function, thereby making the loop function easy to verify.
>
> hope i don't run out of stack space or depth...  =3D)
>
> please let me know if you have any other tips for bpf_loop().

See Ed's reply.

I'll double down on request to share your prog that hits 1M.
We're working on removing the limit completely,
so the more tests the better.
