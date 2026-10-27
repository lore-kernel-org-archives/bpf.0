Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793077866;
	b=K/cu87d/d5WRbHZ5ccL45LkDXirYc9kr4RfWQzfPN/aRPvXiw+shHNgKG+OtTAOyFggY
	 fM9ipaO8M4EnTYPPa4xLM3XVA30nrydmWxch6E3YvhxNg5qpxKLAgAGTXXwYiaCYU/6TJ
	 moina/Spx69A426ZV2x2kpS7Ingx9HHJQS7Cv8uvy6kpJ8mzUQczPNrl7GRLkcNZ7Ea9Q
	 +3qcXl+GJ2kSGf27PraPDUmGiB0jv1ggsEBgcsHUUpt6fGEWAOrAGB3wZbbH8/aww5szh
	 tj8w7QaYETOwdQ/HWPVBKoLXLmzHoc6nHJW+sAFC5xYtSiwn/C+SpKGbUpgOJyYXl9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793077866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hcNgqETn4qg51KIAcMQi3G8nxBEASfodX0BihEo8ers=;
	b=u+eZ6gUmJ+KWqfrD1zYQ0AP/gL/3PLdw2YWw52a1R593b60heM9EesORvuOmgCc0pPil
	 dcBiFS9ttLdWEXszEr4d4sKLHq50rYA09SE4ylRUKWDRu0huHkBfnhVYJFqP+6N6823zj
	 JSqhlOUegsa26nOvb5a4Or9UGvV76aqON63afc+zkZMAbpHn3B9GcyheWvAyUTxhTE5df
	 whThwnHQD11565+BauiaEBDEG3KdhwBob0CH3k2oYGoxR7qZxfK3xT4kCXjaPi2QOJt7c
	 ldR+JHJ5E2NYvaeoa6gcsIE8fFKvUnABdAXYVV9Bl0/yGxMHKt2YK4jpsfhE3oWdSVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rIng+qXu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF80606A334
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 05:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECF80606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rIng+qXu
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91c751d2769so839826d6.2
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 22:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793077865; cv=none;
        d=google.com; s=arc-20260327;
        b=q0mWzwLB9xMnBUpIIqsonb5Y1EZcjp3bF7C/5jf8LyZe5WrnNFA45eXhHmkPTjtKfv
         3lvsuVxzv6EyXygY8UXQ1l7+Zx2n5qClHFqpLN3wHE0dM5OlFEfNezIXxK1QHBckSVKs
         chs//Ut/EIAlgASX2kKuIkjwfyVH/UwBzJO7MGcgn/lU4rC0RanySxy4WgFnwg9JsYUP
         jPy3bG9B6AxQp9PYj1EJ4shEJxg02nV9q0dR8FVSWe8kN5MvwcJevQ7nZLCko5UTpcMZ
         0VlIsxQ/dfrmCqlUPgEwwxmqN2HzfbaptUw2M5mQTWmvBjyQAdm83pmniCmKxXHWvqfl
         EVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hcNgqETn4qg51KIAcMQi3G8nxBEASfodX0BihEo8ers=;
        fh=L9HzlmgBn+IPfEL7WeLJHThyrHEtC1HCmUvzwIW0pGg=;
        b=EZysG+ILYD3EwDcmxACQTne2oXj9N82ZTcgm9HOr6EvkvMWcCDfEm6tFp7Bz7OSnj1
         bAZPT+XDX/qNPoa8m9VkOTaOpBJFC6t17/TEivcBxB6fz/pd9flnETNH0JuB6iaIzFEH
         8Q3yOobermrfzmxBHCtIpxyRjweqBkuj+W5Kqy+TouIHH5QhuoIu6bzQZgmhTUp2NAAN
         Xw7qbWORtKHD/CIG/IK73Gfb1fJPFkOye7oxekY33R1pjM7qGOFTb4wEG2tnZOXGkQcl
         BS8hFDqZ/39FNyk/fIqn9e5HThlt0m0SYQRGLf8Lwlc0bJp61tqN+QvzhjLsrcCkgI+l
         zOkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793077865; x=1793682665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hcNgqETn4qg51KIAcMQi3G8nxBEASfodX0BihEo8ers=;
        b=rIng+qXurfJFZxT0RCoaYirVO3IL/w0C8jVHZFhFKiLv8JNAlFJMB8he1Buv5BFHNQ
         zQ1By0HSuQJqxazI7ykxj+3rSvVBJdgZN9hefkOCEIAKTxLyb9XDaff/wohWf1F1xS4T
         f5KcfTT6ieuacJXIOqpjAMpKaCpMDSTRe2UMnq6R0m3IgNONvfg/f1cY4iLIYyh4V/K1
         r/oKuzElfxGliQuG9/ji8V7DY9zVBl6Yapg7a3U0AqchoUJFnHSefMtgJt/L5L37K3NU
         uI5p110StyfiNjt1wuHu5+wV400lcxCToLXf8f1aIc56aAEfrXopKOjT/fCnfkKGCeeH
         T2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793077865; x=1793682665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hcNgqETn4qg51KIAcMQi3G8nxBEASfodX0BihEo8ers=;
        b=hRTzwgAqoxv2UarTZ7u8gc4pVi1f8pcw+fxMYk0hX3kOc28WjESx12Q3rFRhP4zf75
         WN/hQubiX3Tkfl63z5Sct614I8tIJxcrmN7/3pqSowyjsDbEmhgLsIqMJhUAysCokSH2
         FEYh6/E2bESOBIV5zsuHvChiOZ3/Fl9oyZgNkZrooxLhGn8fYHOGFOcXme9g78VU+e9I
         MI9u3u7ygPKlVaD3pgWMAIIjQy4SpsrJ9BH6Tn1KqSTUH+KJlagFBt7lVsxzcFUQlFUJ
         hIImcn+vAx06JLQ7gTDXT4f/M/waelAkYl9NnkEkAmQAfKn6Ob/Aklx0Rj9zPKHUnjG7
         xpmg==
X-Forwarded-Encrypted: i=1; AKwUvBwxTl3eLPJdVLlxYtRMIN25IkYxRdW4uhKV5j+Rgndy+yYM7l6yRhd/qWNC0eN/iNGrtQ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1CRjXGt4KQ2gjKDgVZIN5DPbEkiYJUboh0VKn6Y3FExYNGlFs
	k3pxnA3IL8ua6p3E36k/2uUIo61FTBluHDLaRurKoRaf8S9ItVWVd6sHvl0n8mgBLnhES4p9Yzn
	39p/X5ClFkt2zxg7vLCby55QAuctYaRc=
X-Gm-Gg: AYBFou1rgpZ03G/AKhKVmpM89WIrTbIieFHUr6xEab4EpBQx6gauXX4eeCnpm3UjHno
	V34qTpLKV5UDUE7TW6umYfQBV63CBdi1TQ/QazGKkMK9atjNfoXa9zkyWa74/OTr3TQw0s/IvgW
	yMh7foGih7oOVLsmvrP9wtN+QgjEKphIQbqNdgyo//9CDLXJWxeDmMKjSUOrncYDbiFd9rwXQNs
	6i5U/NMJnCRlxhC8Zd0PuCx/bhYsJ8GvkaCEwhjjLkJ2nFGeoOlSrcV0Grqpc11WIUeFEY2c5Gd
	RZdxkX8FvaK1XdwCCZErV018IRAnGfWJlmIQRnZMjpJHbON51agcfjH3ph05VAmezlcS3Ia6C2p
	QSV5iAbvl/r0wU7YiQvXWwztGlWIKoEiUHi53bcM7efxninulzxpGzgofcT/yu/D3kryJWSgNbq
	H4i2YM5TMfHMhYDZ6Bk2c=
X-Received: by 2002:a05:6214:48e:b0:919:8962:53f3 with SMTP id
 6a1803df08f44-91c48e41550mr169271956d6.14.1793077864886; Mon, 26 Oct 2026
 22:11:04 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021155629.68813-1-phx0fer@gmail.com> <20261022054811.35008-1-phx0fer@gmail.com>
 <DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com> <871p9g6ym1.fsf@cloudflare.com>
 <CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com> <87v76o63qv.fsf@cloudflare.com>
In-Reply-To: <87v76o63qv.fsf@cloudflare.com>
From: phx <phx0fer@gmail.com>
Date: Tue, 27 Oct 2026 13:10:52 +0800
X-Gm-Features: AclHuK-szubO8IzEfkitMXTwqSUXBlid_2AlglfmxC79PBz8mekTtdM3GkUQCq4
Message-ID: <CAKvCo-zf6=ABrMEn_8r7rJFFvaaXQrz8GAUQ9Uz4h0Ze9gY68w@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data races
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub, Alexei,

Sorry for the long silence =E2=80=94 my laptop died right after v2 and took=
 the
local mail and the working tree with it. Agreed that the ordering fix is
the right one; please go ahead with the commandeer, Jakub.

I do still have the reproducer (a KCSAN selftest for this race, verified
in QEMU). Say the word and I will post it, or send it to you to fold into
your respin.

Thanks,
Dudu


On Mon, Oct 26, 2026 at 8:33=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Fri, Oct 23, 2026 at 11:53 AM -07, Alexei Starovoitov wrote:
> > On Fri, Oct 23, 2026 at 11:49=E2=80=AFAM Jakub Sitnicki <jakub@cloudfla=
re.com> wrote:
> >>
> >> >
> >> >  static bool sock_map_sk_state_allowed(const struct sock *sk)
> >>
> >> Code LGTM
> >
> > Jakub,
> > Could you commandeer it ?
> > Dudu is clearly a bot and doesn't care.
>
> Ack. Will drive this.
