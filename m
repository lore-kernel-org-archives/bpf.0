Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C037D38F935
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023938; cv=pass; b=ljuuw+1mB8EfoyY1zzUCnohE/lH49guLwMXUPnCxAQMFi2xQnRVplquuvBxoLS4Uhee1Goqrw8pKTWL8Kmz6OEm4kC5gIEbZIjpIeeQoTrlNECWoK6KPodVOZYOcl08nowXvLTmkZxOSvpY3ZdL8EwffJkiXXizAN/3tuBjwEVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023938; c=relaxed/simple;
	bh=BKWJTReTdw+LMAVvVwFW5qLVtx7m6cVom+p9AYVg2D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItrcfwASvDo15fGq+6DYmf0uokrHo47KNno1ztHRK3sSI5Uijvm58HVrYNrBfE1dtE7MYuIUxX7qtmWlOwx831stejAZPANxnMi6xiPr93QKmXBxGILyt10w/1iipiwoOheTOqfvQd+mH0CuVjsRrWKYuCnV5/kKI2bhcp32kPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJQCLgba; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJQCLgba"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e57a753f9so178008185a.2
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 06:45:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786023935; cv=none;
        d=google.com; s=arc-20260327;
        b=H8EcYEFtLONco+SeS1PascViw60qBoOWdHoEUwUk9klOlpLluuDfXqjKH7mD1GAHWz
         x6uuBU3usAL4dLYun7Mq8EwyEIyWRfOi1yX9uBpkLzD7iak+8e+vwE0B/n3pnDm0Bguk
         UvzJ1Yu5y6nalDpFaTBz3MWOIVMZrdESVGIeywmto5jjP/00Tt4p/RivwfRVLqL0Oh9v
         3boHgtp4o7+dA84ciLhVd/vJYLD3IbS0KoVHJ+h6LPNJ9X/1q/v+887E7GaErztQUCIM
         Ht9yETAj804w/O0MEfMN93ohxiAKssqpolICUUlWMbd7veJVGlxSawniQxkDzAoC7wRy
         o9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BSeHeIOsrbYVt/cFGZ3Mudq1FYtZux95e0DZcHfkyoA=;
        fh=yd0Rco7ICpNXJSn4DoQuGZ7fgxI2CogEl7vkrWGrHW0=;
        b=SOOmJI6Az8rwY+lu+0fcd/wchYY84D5eo4lhWTxloHNPDh1VDQXTZMt316pTQ0cpUg
         DBNXL8a5SDMKZ3XTszmzPiILAsbmftDUbhQkHXCXDeOWP5SskTcbdJDolePkDJncj+5i
         exjjxBnb1o3RAtmIveI5qkDgItPOJJL1j8XJshOXrdjcUkR7UU4KQDP3zsYS7Zp38gUy
         obllnZpMN+xfDFeNwAm6VsL4XAlDcagQ9ZBLa68He0l0JYocS1FRwMPxtTRHW7n/gihL
         QJu8cd47PAoAFpgFUY0wYlh3eL5SI3Nr/F0yB7Ri8KwrXGLvipXMETmM1Pu368AIPwVs
         851w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786023935; x=1786628735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BSeHeIOsrbYVt/cFGZ3Mudq1FYtZux95e0DZcHfkyoA=;
        b=sJQCLgbaC/McfgMuD8v8IvAPx0ogptrKbO8CKL7OO7jt3QRkqLS05HNZ5upR9Wjhp4
         iWLdbbHASrc5NjUIqAlgHt3/w5KE/fyvd+HrYO9xxThIc+Nzc+TjwPcM8jXD9zRdERa2
         EtHaNy6Sahe2Vym9yRyn8xcy00IjwtglyB8Tli6Yo2kUo8/nmB2L/iRabFhlTd7o1Zn0
         4t3KAPEybwjoDf2rhbpsuKhNcilx+/8Q+BNTo9EaMHdZk6ios5zAVsmZV7AFBNnMfeyO
         qhjO/3326ifnhjBhzuL2bLBiwVkEiXaIYuqedyidv40qNUAbTMbZIcNqg1wCUAcvpP6r
         mUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786023935; x=1786628735;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BSeHeIOsrbYVt/cFGZ3Mudq1FYtZux95e0DZcHfkyoA=;
        b=CK49PTbvEYVeduLTFC2QaeDPBIL0ImmLy1cXT8pJSjj+GPhHKelnQ5bnB5gu805B54
         ubJbQkTOIiTkX6WTf3ohVL4ChId688chApkpbrVouJuh0V81Pr0gknzIEndV4iQyXR3c
         iGaZEZvQQiApyq76TB15OLQhvEWlbPVrQCft0TEAS5iwP3nfqYHInVnn7YEH4p5KgFsb
         xuq49XxQa4+BAuH0z+mIiUzwTyfIN2LDfjUGS3AtTiqSmUDyIt6Eemytu5dBim9obImY
         bwqp7UtssnWB4a4j+Jllv7hRYnfHE37fY/6nMez0T66Q/WACsCR8w57OslKHKe6GaatP
         Q/Aw==
X-Forwarded-Encrypted: i=1; AHgh+Rqn/K2HTvG8sZF8HL3obNX2wDVt//HDlXeKXmpKWcGJ1uhDQk7VuC4kli9knzdunabw06U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJQ01FWalDdb6M3d45PMqxtc723ZboAQbFTPcok76ZE25pg/X
	YqxqCgzEz5d7Wxh3tMXFbPFvdaBQ7Ha4up/3sRbXr6nvU/jOhdSvn3DRG57VzSD2wycUcZ37HTf
	bJGl7OrqmWjAa/veB05hoMrZpUgsw1SU6GKmtRWHR
X-Gm-Gg: AR+sD13SD1vo/FwY+kTBlrgM6SrU6LWkRvcJdn1jl+6WNKXkd6tNO4W17MBqGluR/ry
	zkLKBL0WmijPMeBWgChCdXkYSn7kRnRQuKsTZHwQt8+WAnvC6VT/BeCL/4Cp2KVox9bO3WQMR+W
	ivYDQQoCs1Bnvm/kw+NL3SjEmzzeWkk5dh20u7V81R7R0XVUz4Gl39x9djjuHCHHlDDWJkxTqDC
	oQPJLn+X3kRHe94dHdVB99Xtlnees9RMD+1a1gz+XRT+chStvB77AsPvoJXueiklYSvLaK4RMGY
	88MoWcLwL8rWo/MiA+4dErXW1RvPEEkTZeEX+vSfUXqRl6mCZInJiKG3bQKVORNKyqnK2RpCh69
	qPb+bz7uEO6kikDVPFlnBj9Z8Kx/deaV0tRPcGU21vR0Hojn4XaaWFYk=
X-Received: by 2002:a05:620a:8c89:b0:92e:541e:632b with SMTP id
 af79cd13be357-93649056dc5mr1186003185a.2.1786023933857; Thu, 06 Aug 2026
 06:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730220055.2946171-1-tejasbirajdar@meta.com>
 <20260731220124.B0C621F00AC4@smtp.kernel.org> <1f36d5be-906a-4ba5-8679-24cbcf899254@redhat.com>
In-Reply-To: <1f36d5be-906a-4ba5-8679-24cbcf899254@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Aug 2026 15:45:22 +0200
X-Gm-Features: AUfX_mwdvTEom7e3WZw1jtKlW4Jx4hI_DGQwZjfU5OQKTgLw-QKbrPG4mz7zWVg
Message-ID: <CANn89i+P6Y+uBSKa4S7CAqJWrZNqHOTKY2A2jaVs2iFG4_wRhA@mail.gmail.com>
Subject: Re: [PATCH net-next v3] tcp: honor BPF_SOCK_OPS_RWND_INIT on the
 active connect path
To: Paolo Abeni <pabeni@redhat.com>
Cc: Tejas Birajdar <tejasbirajdar@meta.com>, bpf@vger.kernel.org, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 11:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/1/26 12:01 AM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> >
> > Pre-existing issues:
> > - [Medium] The `SOCK_RCVBUF_LOCK` check executes before the BPF program=
 runs and before `full_space` is inflated, silently defeating BPF-requested=
 windows and bypassing dynamic `SO_RCVBUF` adjustments.
> > --
> >
> > --- Patch [1]: [PATCH net-next v3] tcp: honor BPF_SOCK_OPS_RWND_INIT on=
 the active connect path ---
> > commit 2cf5d1d17ae1c7488533ecaa0fcbb83ae4591ec8
> > Author: Tejas Birajdar <tejasbirajdar@meta.com>
> >
> > tcp: honor BPF_SOCK_OPS_RWND_INIT on the active connect path
> >
> > This commit updates tcp_connect_init() to honor the initial TCP receive
> > window requested by a BPF_SOCK_OPS_RWND_INIT program on the active conn=
ect
> > path. It inflates full_space if the program returns a non-zero window,
> > matching the listener path's behavior, and uses u64 arithmetic to preve=
nt
> > overflows.
> >
> > Link: https://lore.kernel.org/netdev/20260723214208.3655474-1-tejasbira=
jdar@meta.com/
> > Link: https://lore.kernel.org/netdev/20260722170033.2763794-1-tejasbira=
jdar@meta.com/
> >
> >> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> >> index d7c1444b5e304..fcaa04e65189b 100644
> >> --- a/net/ipv4/tcp_output.c
> >> +++ b/net/ipv4/tcp_output.c
> >
> > [ ... ]
> >
> >> @@ -4137,10 +4138,13 @@ static void tcp_connect_init(struct sock *sk)
> >>              WRITE_ONCE(tp->window_clamp, tcp_full_space(sk));
> >>
> >>      rcv_wnd =3D tcp_rwnd_init_bpf(sk);
> >> +    full_space =3D tcp_full_space(sk);
> >>      if (rcv_wnd =3D=3D 0)
> >>              rcv_wnd =3D dst_metric(dst, RTAX_INITRWND);
> >> +    else if (full_space < (u64)rcv_wnd * tp->advmss)
> >> +            full_space =3D min_t(u64, (u64)rcv_wnd * tp->advmss, INT_=
MAX);
> >
> > [Severity: Medium]
> > This is a pre-existing issue, but does the SOCK_RCVBUF_LOCK check happe=
ning
> > before the BPF program runs defeat the purpose of allowing BPF to adjus=
t
> > the receive window?
> >
> > If an application sets SO_RCVBUF prior to connect(), SOCK_RCVBUF_LOCK i=
s
> > set. In tcp_connect_init(), this caps tp->window_clamp to the old
> > tcp_full_space() before tcp_rwnd_init_bpf() is invoked.
> >
> > When the BPF program returns a large requested window and full_space is
> > inflated, tcp_select_initial_window() bounds space by
> > min(window_clamp, space).
> >
> > This caps it right back to the pre-BPF full_space and discards the BPF
> > request.
> >
> > Conversely, if the application did not set SO_RCVBUF but the BPF progra=
m
> > adjusts it dynamically (which sets SOCK_RCVBUF_LOCK),
>
> I read the above alike: 'a badly written bpf program could be
> ineffective'; not much relevant.
>
> This version LGTM; Eric do you have some comments?

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
