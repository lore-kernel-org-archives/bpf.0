Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB12ECEA5
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779615750; cv=pass; b=blrrel7TMBB93LohC8gaxEN38z6+YVJqSwb129XMR/TyKZQCumJvhYP7jvbteOZMmrZr5gdeo5TdcMJ2LQ1j1xSMiBMskgSUmUFqaJWIwxKvRD9wxF0GNiVz1GJv0nS8JD9/y5TWC77nvu5MKz1/u+9xbiK3zGeACdKGA07nh4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779615750; c=relaxed/simple;
	bh=kpGDEHky44D7aGTv8CTz7sc1B6m/sRELfqhdOYIoZT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eo2Io/HypJEBWU1BbW13ddRC2uhjrtUdk8Hzq2k1t+9O9Kdzch7H+19V7ZOPqZt+iNAuexDqVgVryw0WPj3YewIibm2ozOlpxIaQcdfB3DsnVGiN1VHr3gnnjV8SJW2Dl01yxfIlQ4xzO/A1XpGBh+t1K6bo/zl97SgQ0jACOOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCHjleG+; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCHjleG+"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43eb05b1875so4669830f8f.3
        for <bpf@vger.kernel.org>; Sun, 24 May 2026 02:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779615748; cv=none;
        d=google.com; s=arc-20240605;
        b=eZYQ4QkLPDxHd5tIBjwaLqpHivVMGG5q9huQudfXpa4f7jGyhcXD6wRpZqvTnA4qyo
         jKQDhG8a+79fXXxQyKDy1qXWeY1NtUgLuFSFKmJrUAQwkd0iQ/gLjOQdYOvPImoJ/c98
         hPulOtE2/pBHLEy1wuaFXqe47Vk/Sr/QvTrVC85kPb6SjU1JHbnitQz/8illzSfa11Ua
         m/bK0frT7GJf1gkMdLYB5g7YNcoDIJuJC5xDNcFhxUyV5fKQeTLgmtshWvrUwgnU6fFX
         301RtFXXZd7kzJZYWfukhv9DTAjPkMqNwv9ER4D/0/Lb344D6MKutHsWI1jvBKUBevTo
         WDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+YHWJhB00XO9xUYo8X6jeelZAujnKbGOj7a+VulNcKU=;
        fh=ermKvBCul76cIUI/1XqOI16rsdVXJSl+aPn0KT43BBQ=;
        b=ZA7jdAu3MsZBRsC1XRd4VGx4FY6ANV9zxdSMR1rXmgW0jmk7jtTY06e6wjh3zf6PVo
         0J6UyctZa3MQPyNkrra8BLDjtwoQqYV52/3bCJ10w8emkNrBLNLl+OFPkQqy3AViYClM
         oGrlA2SbgyW9B+2d3tHKEU6zvTHzw6/kAfwYB3mPHyoFL9tKzDl1t8xzJEc973+IEcRq
         gQNSSOU5+oRkeDQazWx1JJ/D+UverRvyXh/pvD6r5YHcK30Q6sQuLcdj/tHaBmm/3Jgr
         cqXg0jRFMx1xoEBjRNA9DGjIn3a64/VMawKR50n/zB/QSesm7xRNOS8xsAUtQ7OJ7EcK
         gXAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779615748; x=1780220548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YHWJhB00XO9xUYo8X6jeelZAujnKbGOj7a+VulNcKU=;
        b=XCHjleG+KgdrXqbFwZHVmkZc+yvP10Am2fscOX3Bbe6WBl3hDycTJQlj/JAKCPhlwe
         +/p0+aAm0J6BBGmWqLrN2XhhmAstcXGb8w1V9Sur271UUvjEb3GDoeGnomizubIWBUje
         oEZNlPre15hekfZhdCWiebD/AnZK05FqIRX9Md96LdqgtgykTJeSd0j99WwB5wbPjyD+
         +OXOxshNM/uIwxhGeLIKOuDbmwOQGW0iq9ilBOct3fXIELS5dLUeWUv58FSSpOM8W+7r
         9H/YIxoZsWdzSFAryPo0sE2BBlDcVCWhGwFRu8xMnFZqsvK88s231ScetBYQVMzfU3Go
         0okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779615748; x=1780220548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+YHWJhB00XO9xUYo8X6jeelZAujnKbGOj7a+VulNcKU=;
        b=jmLu4RLPdbuPAyuCXT48zwkOVjHS64WA3xz9d9XSyvfvm8Deg1f0cq9BzgspD3bB9K
         wBbubhkZ8L0u+UtaW2SG0Wqu3xJEp69DY6lsmXHDPdtDZpHBQ1KDBB+TYQGK7s/NwUAm
         S8IH3PwkEaez8vyclOe0t+WaetprpLn7qzB+2d9SEN4ZT3U5vAxBtFpkcT/nNqq8zmY7
         82Ha121/KBN2D16piEOzC03TS4lo/VWi3QqVlTAcaoRtWXdPZBbN1lIBtvc8QRbT52Ib
         IMJgUzhPt+57qf22m0KoTeEdQY+wR2Yvr4dZE3IA+7cskJcyjEwVE9ws07z/Y6oZJdeU
         hanQ==
X-Forwarded-Encrypted: i=1; AFNElJ8TNhIabyf9ZKbTAm7iyp5TJkaIhyyUDlKxYXK6/nBXFLi9vFrHdh/Uf/xhYUgJq4M5tSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt3b8HGr5mbnD2wuJk63RsRjQWnXE+/OK5A0O2/0T6ADW0Pey7
	qN0y8ObgYB7tUXCU03zwUcmQi+QRdXGOFJWvVa8GBen6krWvUpA/j4lAHkpq8Y6ZJ+cvq0DRelj
	MG1pWKdYjqJ/gYul6uZYKYvVLYjYpm9fCasSKM/ZkqQ==
X-Gm-Gg: Acq92OGicW5HIf7eweEJZd2sxlh0h8ATu+C2ElS/NsAuEs7YORQaPLochxn842kRvgY
	C+9cCMcqa66Aui1IygLYUtt1+dt3GJ8Jd9H/NgNzmLIowfspbmGWXlvJbQJ72H1ksM8rY7MCGcX
	X7XSzxP6a7G7O3Mb7gmlDNdlrWWmqSrSGN8RQPUTS1JfZvYZ/ka1TCJr5V4rJt4trMYUa4Ep4hL
	IuvwxcGI/x43Z14ED/SeQRfY4Tp4uXf7yO5DWp+El1RCHuwGvv++i/XKDI2zsg2WA2D94K86g86
	JoMXWhDosicqm/Fbazdpp2PsTsmjBRYjOwokze1r70O9MYvZZ5k1uN8HnavZJIKx00K8Dg==
X-Received: by 2002:a05:6000:260a:b0:452:c246:ab7a with SMTP id
 ffacd0b85a97d-45eb36970dfmr19280461f8f.14.1779615747468; Sun, 24 May 2026
 02:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524082944.10625-1-chensong_2000@126.com> <e5ca9aed83f28248172fb088e55dc1cf7170417b0e45ec564ee0da4791bcee99@mail.kernel.org>
In-Reply-To: <e5ca9aed83f28248172fb088e55dc1cf7170417b0e45ec564ee0da4791bcee99@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 May 2026 11:42:16 +0200
X-Gm-Features: AVHnY4IVWKG8k7bSfLUkleZNHpRfJW5ta8gRjAg90Clhq1l1Dg87PeyarCgG_dQ
Message-ID: <CAADnVQKVwHLX8-jo48zAijROpJ_K1VqgF=gG2oxiO0Mw7EeObA@mail.gmail.com>
Subject: Re: [PATCH v3] kernel/bpf/btf.c: reject to register duplicated kfunc
To: bot+bpf-ci@kernel.org
Cc: Song Chen <chensong_2000@126.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kaitao Cheng <kaitao.cheng@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Chris Mason <clm@meta.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 11:15=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 17d4ab0a8206..425c9f5c64fa 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -8673,6 +8673,47 @@ static int btf_check_iter_kfuncs(struct btf *btf=
, const char *func_name,
> >       return 0;
> >  }
> >
> > +static int btf_check_kfunc_name(struct btf *btf, const char *func_name=
, u32 kind)
> > +{
> > +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> > +     struct btf_module *btf_mod, *tmp;
> > +#endif
> > +     s32 id;
> > +     int ret =3D 0;
> > +
> > +     if (!btf_is_module(btf))
> > +             goto out;
>
> During v2 review, Alexei Starovoitov suggested a different approach: inst=
ead
> of rejecting duplicate kfunc registration, he proposed allowing module kf=
uncs
> to override kernel kfuncs, similar to livepatching. He stated: "imo that'=
s a
> more interesting use case than helping out-of-tree module to produce nici=
er
> error" and "I'm not convinced that we should be doing it... because ^^^ i=
s
> what I think we should be doing instead."
>
> The author requested implementation guidance on how the override mechanis=
m
> would determine which kfunc to call, but received no maintainer response.
>
> Should this implementation be reconsidered?

It was considered and I said later to defer this idea for now.
AI should consider the whole discussion thread instead of immediate replies=
.
I guess in this case the threads were broken into multiple
due to different subjects.

Song,
in the future please try to use one subject.

Also "kernel/bpf/btf.c:" is not a valid prefix.
I will fix it up while applying when trees are ffwded after pending PR.
