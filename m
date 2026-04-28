Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8BB364EA5
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368831; cv=pass; b=GlHLFkeQJ6jLZgSYN+yacaJwrZqEg9dQ3y8w4NzA0ICwTONTulNOoGAy8t57xWnuC1xyysZaMm789efxgxWmwfYyD8iLtI6THV9af3HOwAR6xwQqn8F7mNm+m1o413079MAA1U4OMrOKepIjoZSZVs/MnK4+2xIFUHPigJSZ2C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368831; c=relaxed/simple;
	bh=h6NwF3Le6XVIQrwiJdwOGL8CtReUBCUsNCqF8bCvia0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODU006pAp70QUbCDHDQ1cMlPnRjVDNSxR2gLpBxuvQC0m6c/x4Qif5mjf1SyF+sicjk8LKsO6Krge+3uggb/eZE6Y+UQsCqJ4J1qQfpERWbCSltR7WSeBGeX4rLcL45UBEJTvw3826FU5UE/b5ldmXAE704MUbnOP7kaFJWlS9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNRScxu7; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNRScxu7"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6764e36dc88so12720922a12.1
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 02:33:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777368829; cv=none;
        d=google.com; s=arc-20240605;
        b=JdYspsRXMmPAUahscLucZDms5/sgIajlJ2EpjiSLkrn2fgUxDOuwsZXdJv8HSL+UmX
         3lQEKRuQD63dfs5JIADqjZ14rHbwkSST5EwePm6ZLBqmnXS6r62Vtw0NRWo2vjynaAhG
         cCikAiiQsBskFSrrk8VvLHehhjfRRwb3zM/WQ0BukZc2TnbNFVGMiqrqzLBzzyRRtegH
         KTZdObetIAZgtgFdLQgaq9Lt6dnmJS57O3UIAcoP7TsUWwo0unUK8hT+6riPtx4bG/t3
         N+GCgLCi6Abr9eZegGWgqMIdWQ6hxY3KIjZapyUNkZsQMLDbp7yAD9xrHEKThaBsqQJw
         CX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YvsHjcWiucfudrzDgP/AG+IkarbArZuB1gzHdGlxxm4=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=auH6qCNbdh6eJs0r0CfS7i/BvFNxW8yEoopXupLZiZOE9KBtpk7T9d8yEGYvgPZJ2u
         13+PjoYqaIYp0HYiff/Ef7I1/cLYzEhzkxLucI7jDOXjrS2WucVEWGa7y5O0m3FxmD+0
         n9waaISqP6+e66+pzkntdPgvefls68qcRtgA0NwFK3/dtPwZku/wD25Ia8N2VPeJ3LM4
         4u2HgX5csKkF/7ruuN62nByGvTdX6CYSidr6RgBEP0azvKdpZhPglQWlS2lPI9bbXV5I
         qceiPAEZVvVcIim/SF+pp0+HTp1tar36Nb6o9mdRadnF/rM/6M0ekDct92JUMNafrJNf
         F7Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777368829; x=1777973629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvsHjcWiucfudrzDgP/AG+IkarbArZuB1gzHdGlxxm4=;
        b=WNRScxu7U/qTku2RG2sghR4KbY/QaWnXqYo9+gRvpAjpi95ZGcFBJcT0o+R6UZ0BC7
         RYEu8BsZxZO6EEAiKKxn/swlre75VK3Wfga9PT65t9ENsb148Ks9sWrKmb5bOnc9BPcv
         FXzBdhSf/KZK7rbX+lN9NKTvAlatQftU8cEZd+Lj3cz+7YSCLAv0ZctZLf6hH+uTt9pS
         3srvIdFfhgfS/7o0w7M0yeIf8E4vieOAOp0jZGVTPerqvOnc+qcIUmwb28kjOHxlkfzw
         W6H5PoiYX34a3wDgU/8JSfElIbILFvfw/exD+2WQuhoZtcmICVXLqqW7PNYCR64Gh66x
         pepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368829; x=1777973629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YvsHjcWiucfudrzDgP/AG+IkarbArZuB1gzHdGlxxm4=;
        b=ZRFGYfRX7E8snFbgJCuVBhO+YdnKULdIxuZbQoCC+JnFT3nDM604MmKnbpkUx3gguq
         edrP3HmVJOMJ9eJZXQ+sWX0ginR91vGF9cUZoVrdRidmfqWBJjzW2BVHmNK5CJGH2r7m
         pe4bohHunOrf1mJsasevHQlzbemDjczg+pQ8Qv98Z7Cp3DNz70DgAmmHWuR4PiBn01+1
         Xbw0vAEkDLNnX63ppOPT92VtDbCe/5TGUFGILxP2Nd6z8HlORCCcbvQaGVpqtglNH4BE
         t1deNZ3c9UCQ7aRFNR1QIahQlXBBxGTb+oJnmf32ftZwRDncE5NAyPelvjp75HTHgAfz
         FShw==
X-Gm-Message-State: AOJu0YyDYqpllnXcq3ny90JZf1SuC80EqLTrDBLuSF2nitaKUaSoeFWu
	E9FIdGOYoAeVaJ18EW6xsUqo1DmSLSmr6EpVG1knGygD+cVyvGZEd8NzPe5qpirrwxK6/zWl13t
	gebNJfNhU8d7sxqTbSJ8r8MN0m5tnxBk=
X-Gm-Gg: AeBDiesonVn5h/njvSIdySFJu98TvgLDzb8eaTpq4gljJwjSfxu0VAAs0cZrHt0xXTc
	CFhw0xhvAStVhdElQGn4ZntJ7W/1hu4KYi4ZnXqK9M0ItELs3KnohKpZEFAZIB6vvDPF4pXl2lP
	GxfyGkRs3HGiqDYn9pNe3hg50w9VoKt64Wq06NaL9Jz1ILt6rVUqjaGRFQjLXVaGBVBHaVHoru8
	uUSg3CFscLiNMJ/lEx+j1PObF0dI4focqW7Ax28tejXMABA/Y+GOmGtNBBqKvLLSs6hpoOMNSHs
	dUdyng6F1miArr9yWVGP6O4WK0g=
X-Received: by 2002:a05:6402:2748:b0:677:1d09:56d3 with SMTP id
 4fb4d7f45d1cf-679bafe5717mr1088250a12.5.1777368828542; Tue, 28 Apr 2026
 02:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427232313.1582588-7-puranjay@kernel.org> <20260428012920.C90A1C19425@smtp.kernel.org>
In-Reply-To: <20260428012920.C90A1C19425@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 28 Apr 2026 10:33:37 +0100
X-Gm-Features: AVHnY4Jxb4hehSxDkI_ht63vhXhFkxGUIzfocB3juJXEXlapiQ-CsY7VXNocFKc
Message-ID: <CANk7y0gtBWMxv4DV3tnt78iCFG_Y=0SOiEVcKDcKd0ibxpBp4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] selftests/bpf: Add XDP load-balancer
 benchmark driver
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 2:29=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [Low] Incorrect IPv4 checksum calculation for packets with IP options i=
n test packet generator
> --
>
> commit cc1cb16090fdc833cb82a1c6a168d6cb11005220
> Author: Puranjay Mohan <puranjay@kernel.org>
> selftests/bpf: Add XDP load-balancer benchmark driver
>
> This commit wires up the userspace side of the XDP load-balancer benchmar=
k.
> It covers 24 scenarios and validates correctness before benchmarking by
> comparing the output packet byte-for-byte against an expected packet.
>
> > diff --git a/tools/testing/selftests/bpf/benchs/bench_xdp_lb.c b/tools/=
testing/selftests/bpf/benchs/bench_xdp_lb.c
> > new file mode 100644
> > index 000000000000..0b6709a2b03c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/benchs/bench_xdp_lb.c
> [ ... ]
> > +static void build_packet(int idx)
> > +{
> [ ... ]
> > +     if (sc->is_v6) {
> [ ... ]
> > +     } else {
> > +             struct iphdr iph =3D {};
> > +             __u32 ip_off =3D off;
> > +
> > +             iph.version  =3D 4;
> > +             iph.ihl      =3D sc->set_ip_options ? 6 : 5;
> > +             iph.ttl      =3D 64;
> > +             iph.protocol =3D sc->ip_proto;
> > +             iph.saddr    =3D htonl(sc->src_addr);
> > +             iph.daddr    =3D htonl(sc->vip_addr);
> > +             iph.frag_off =3D sc->set_frag ? htons(IP_MF) : 0;
> > +             off +=3D sizeof(iph);
> > +
> > +             if (sc->set_ip_options) {
> > +                     /* NOP option padding (4 bytes =3D 1 word) */
> > +                     __u32 nop =3D htonl(0x01010101);
> > +
> > +                     memcpy(p + off, &nop, sizeof(nop));
> > +                     off +=3D sizeof(nop);
> > +             }
> > +
> > +             build_l4(sc, p, &off);
> > +
> > +             memcpy(p + off, "bench___payload!", 16);
> > +             off +=3D 16;
> > +
> > +             iph.tot_len =3D htons(off - ip_off);
> > +             iph.check   =3D ip_checksum(&iph, sizeof(iph));
>
> Does this calculation exclude the appended IP options from the checksum?
>
> When sc->set_ip_options is true, the header length is set to 6 words (24
> bytes) and 4 bytes of NOP options are copied directly into the packet
> buffer. However, ip_checksum() is only passed sizeof(iph), which is exact=
ly
> 20 bytes, and computes the checksum over the local iph struct alone.
>
> While this logically malformed packet might not cause the current tests
> to fail because the BPF program validates iph->ihl =3D=3D 5 before verify=
ing
> the IP checksum, could this mask bugs or produce false test failures if
> the BPF program is later modified to validate L3 checksums?

the current BPF program drops on ihl !=3D 5 and never validates checksums.
