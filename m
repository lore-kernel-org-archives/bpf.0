Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8481C1E0E14
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098157; cv=none; b=SeeuUSfcpHzeoIkzM5/FWWyoXfIjbvgQguP3I6fFucVEQxzKVfhNwG68kCUdYwV8HLbJeaMexpcwqlSy8iNfLlUPKxZg7WjHNL9N2LhisFM1zZ55S3/sLCdROSb2oU1zFQUca8TluCmuamYQDLQOraQQ2GKgZ0gsMcXNu5BDafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098157; c=relaxed/simple;
	bh=4hXzQ57bqe8efvD6C7753GoZQM5ixjUvbDNFqvE1KnY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oWgEdrhTELXS3Vytg0zCfTEpaYozFUl5dbg90ZXUXIMDHWMkGaaGB9JTKyfxJXGv19uqQN807+x/cyUerJBpX+oMdu+VY8ZEEkGDTK8XPvPEFXJM6rLq6ueBO9toN7m8IOeijjSaixMXHJaWSXPDmqUnRIY2yZ0ov78Pfvo+t9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSOokBEg; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSOokBEg"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c15849aa2cso545393eec.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 19:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775098156; x=1775702956; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b477warS+kAmNLttsa1TfMsRaPnmNljqFqWtpb08NvQ=;
        b=ZSOokBEgVyISutK5cABdT4Iiw8qMBuW10cDqNA9BblNzElsF3vJC5OJVcZ2wtR8NWJ
         Vd2mznH5RRzfQw/sj3L0Xm4hfFFlk5EbVVZeVuRTzxSi0g/YSf+I4LJKv7Cj3gHe9DDk
         3JtLhTIdnQYyOGddbP+YvszwDBIGkz9d/twm9sPEse+W6UNH8g/vpQnR/QkdT+cR9IY/
         iMwMSCuAGNtjEVE7VWgyzIZUku4iIrkJnnpvKLLr1aB3DQPtwOrPueRJ/gF3kab+7B7O
         Hcp+5jyTJaBgDYNlJ2aKjE4J+7Wr7k07Hca07+/iR16dmQK9HcU+hYUEfg/dUjB+VpLI
         IDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775098156; x=1775702956;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b477warS+kAmNLttsa1TfMsRaPnmNljqFqWtpb08NvQ=;
        b=B5hBRK6yjVXXhi+DFuT4WixeSgW3mStYkwkW4HmWEfoxOOCEbba21xXOranDj18Bai
         Ibr2sGxfEitXzgB+mcqm5sORw1V3qP0IEzahc/Fq6pDaEah2KWLpllhEE0zK1AgjYDrH
         iTczUnWXhau+kP4dMVaCYUTi+oNSaZqZNPR8sYrmHRX9jCwkInCnOdQ3bQWojVqWQ/Lh
         J+c7Mtckro3O3IYz9MpmZ5qgkzjwTKQEiS6sokA6uMNjXIRxcyKp4J4AXUih76RvkRgn
         k6CE78a5nN6lXruLjMnggWuwxHGTPkj3U2tjsoj7g8G7ht8kM2jAAPD5mMBEdQOh9+tx
         qXVA==
X-Gm-Message-State: AOJu0YzNRUw/SoaMy3Nv+Hgl2wzAwbc+ShpipwvFqit/E9HCgZGNn2FF
	4Pkkdeqc1Hwl6X/OAib51N0QWzxwjQSnWnPXDnBz6MCNIY6hRDJ3d5nQ
X-Gm-Gg: ATEYQzwm2V4EN5k1aVLh6r5WmiSmEx3IavF+0+07ibFX8vVunhlgsGkMBu/PitvK6sq
	nIJ/l/EjABdAv/JZ8ZtWoOPVf4rAo4c+Q5cUKRO6BFsWsTfVb1iKi7fQ9Y1II9yTkfdf7blybw2
	FSd1IIlWl71OZqEoVBCXuik3BBwr41OMe9+eiTJ6FoSahiLpUqEK1pYi0SUZ8XeHw3EyLDLJKSH
	BIYc2vppVNutVqJlrDuaszWNNx9C3IVsfJiahQXFnOC2PCrh9a+xsk6hwfO3RPDF2uRTm4A0nTm
	3ReWhytT2Tziuz5JDDPr9gouI2WVBaoN5iP4+ug0ahGoJqaW5wY5oAvBxwCp8NFBU6M/QIsjNQs
	afWhKn2h6hQyVj8hJhf2WD5Vd+AeveDvIMEwRRrlmAfA6kj6JRKvsZ2wtJesLxr/7OQ2zj4h9wP
	oeSuzDDcBHz/Ao81lZ1gEkfmgVa8iX3cPGEE1VUetJ1d5dj1nl1lNhkPKXupHwmTxwdtTyHetCR
	et4RW3AmIqKXnGvwO4=
X-Received: by 2002:a05:693c:2c88:b0:2be:171c:5048 with SMTP id 5a478bee46e88-2c930790b2cmr3131117eec.5.1775098155544;
        Wed, 01 Apr 2026 19:49:15 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:7aba:8184:a91b:bf1f? ([2620:10d:c090:500::3:f883])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca79e1d93bsm1286282eec.12.2026.04.01.19.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 19:49:15 -0700 (PDT)
Message-ID: <657cd945186971fef9b30b856c0ca68e05839de5.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/6] bpf: Add compute_const_regs() and
 prune_dead_branches() passes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Date: Wed, 01 Apr 2026 19:49:13 -0700
In-Reply-To: <CAADnVQJhXVri5XC8YScjUs1ShPiSokSCWt5F6LDJ-YDnivzb6g@mail.gmail.com>
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
	 <20260401021635.34636-5-alexei.starovoitov@gmail.com>
	 <3c091ab744676990e90469a89a4f0110d724ce19.camel@gmail.com>
	 <CAADnVQJtw5A4GbknXoA-BtobOVMiBc+pC8nUQZ+1zX5wbj3ipg@mail.gmail.com>
	 <CAADnVQJhXVri5XC8YScjUs1ShPiSokSCWt5F6LDJ-YDnivzb6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-01 at 19:45 -0700, Alexei Starovoitov wrote:

[...]

> > > Q: What is the policy regarding naming exported functions?
> > >    So far I always used "bpf_..." prefix assuming that this
> > >    is a requirement, was I wrong?
> >=20
> > It's nice to have but not mandatory.
> > imo the names are unique enough, so unlikely to clash.
>=20
> This one I still think is ok, but the other patch does:
>=20
> -__printf(2, 3) static void verbose(void *private_data, const char *fmt, =
...)
> +__printf(2, 3) void verbose(void *private_data, const char *fmt, ...)
>=20
> and this is definitely too much.

Let's do a bulk rename to bpf_verbose() it is super useful when moving
some parts of the verifier outside of the verifier.c
