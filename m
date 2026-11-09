Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794251328;
	b=Drh7WTu1s0XPyNGbG1nTaQAlZacIFlDhZB3eygiAqm1JhiRxH8FSvnCyrA8gPzXz/sX7
	 Yq4Gnv2kWR5kH3Xu/r7oYUtB2uxRvjDWjpC+7VSbeA+klcLBUbi4PI2tZPTzqK2xdZmmN
	 igG92MI2OfgE8YtLat62KoaMoqC4PSjZ/au52jFeJ/bki6XoHm244VTRPeLN4xFN/cJmS
	 aSaHsv+FiI7c0/2jU5bVVPj+fx4NcvecsrOw6Fy0MWy3jzWaYeHY6G21y8OHON8/mRTqy
	 604oRCBZd2ZUdgcgm+IsDnRlXvJUk+ryg/pShTiBC5HkB1N4pfBrpiJxGN0HFj7Aoqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=tTRjXdR2+YuaFcagVtcmTZTaJOgk5hMpEYeu8xEycjs=;
	b=ZEg0DD9jGsfjOTJdgbfe7jLaAXHfCW+U87DzEzUQ8PibF3lfo4xUue4MmZOZkzi3MwQj
	 Vjutauvb3XNCNYoO6nO1gSqiinySBk+W0VJXU08DxXMotWEvTL8eOPSieNOW8K66K1nPw
	 qbIt1dfRyOVmRAYuFcoPA8cKp5xpi1UKeehDB8ku+t8ahRYaqmt+IEeygdq/t4+tVM3L+
	 ID41HEH1cEWSdH8gUa+RRc1EmbQbD34zilR5oURgBTAM6g5miEXQe47Jchqjj77UpHh9y
	 ostjBCAIFsads7X1J5SWP4wASWJNGB/u/WmGZxmNsBNrb8hAPDncRDl1yHHhD3yXbdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=rArTE2ep;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C7A606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 19:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C7A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=rArTE2ep
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b0d126f631so12392057b3.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 11:08:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794251327; cv=none;
        d=google.com; s=arc-20260327;
        b=PFRz6bbLvbTSBoY6Rgxzywsj4X875dUqfYorf02Zg9qZGcsAquePOtZQfjs10R8IKm
         buUc7/DSpkuV4cjwd7DSFB4zi/CXWlOs5vKSzHTJBp+Hq4zQaWaKl45jJaz8sIbf7Cbf
         1AZOe9R31kywtOeOCy89Fp3t3fO/jFaynz7LeVnOkNnFT4at7+nAP6EIRUMbkRb92MWD
         aqQ9vT4kkT0J928o0vwIdpItXhx+WU+swufg6HLN0C+teL+QMWCFVwCUwv8SpQDb4opJ
         cUErSbuvszT+Tf/lOLuvYarAapfwVKCWTy+Z5X5t1aqqLydMFJeft8xwm4dbj7MNJHr6
         eWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tTRjXdR2+YuaFcagVtcmTZTaJOgk5hMpEYeu8xEycjs=;
        fh=rBgo+NZkEDlI/mj5sFFe2AhXFLUrO82xK7AtsziifKY=;
        b=IiAX+TQQiiOaeZp5k8fN9QBUTDMsfEtngxtuT6bSSeczYI+AKIHC2tX18xkOKPwTQX
         /GzounVe2LV7ZfuZDPqpTqCAkw/fwczXMk1W39s/uAwoongWt8ZHmHp9HN2YjODSIhgi
         ZeKQrQe27prA1IpOE0SFa8aSvDVKgQXwAJoNrb4ToMyKzGiGQ+mJ/BxmSWjdE7WsVKIN
         S6BquBVI6Xc0Vh3DVm/GgxYrBQP5H6J9ogovC9qtvdk2tJrNJlnQKwbNvls0LpkV3c0o
         7NNQqXcFoproH99zOh1Ep3vfudCh+EDIKg8RYvXpnVtiVFyULv0Iucitmqq9xbQFtE8m
         PvIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794251327; x=1794856127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tTRjXdR2+YuaFcagVtcmTZTaJOgk5hMpEYeu8xEycjs=;
        b=rArTE2epRinQQ/L77FkTBjG+cYzig5C/DJPvfz1O5w49ym1/hlpw+c53Lhc37QoxNy
         /eG9jMBdgwI4wDbw93r0Tcr0TCMauxdlAciyNXi+QmLwJcYhrq5EFkG7aM1vLwnv4Mkp
         oLhcOOIlqN/UHrn6m0/JKU7U0i9nSxM07U/CzFRJ94LLjIX9dNwS28Rz11VjkxjM9Ck1
         FePktN/M99rACA8zZ0Yea+y/9ClMW5THT1N8bBuCmbwWpXzPW0dOTgGLF+2QJnAQJuBZ
         2gSd19hzbnyCMvJbFROwmrctMtAqXwDpRChX+TXunBMeXxhRUH08jUQtngfEKZS+Qr50
         CSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794251327; x=1794856127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tTRjXdR2+YuaFcagVtcmTZTaJOgk5hMpEYeu8xEycjs=;
        b=WJoCxKcwhw9cCSwANwzrtMTsPyH2kUNN9VhA8EI1ciGuAVaR90uw4qIdmeaS7qtOKQ
         qAnXN2DIixCTtxUYiI4IzQgDIoP8DzUBNgCiL+BDbegrRxBS7TZl40GAJ8/w66aB5Vnf
         o70mfkR94GLIdyaL2qmikqv6LnpXz2Bx6JWGklmiatqOpC4FWSWp8QnfqpCF5qUyFMyl
         Da5lAjoHTozNNZoea837+UCjh2qSXyeqojUHBzSoJ5O3wb9NJI8As/CU/oor7NcoacTm
         xreCAS2yEQf/0J/z4xkdh16/KNAhO9MrSbXEuOYcSILAbjulRxz4cqKmvmYyJSEczBS5
         a6Gg==
X-Gm-Message-State: APuU4Z/N2vGLDqX5eOdMInZbJ18TAEQVViIp8AlT1Y+BSyPNDaQkUqPd
	u0FTadJCnhsVkjLe6ZtTFzRoe5H7kH6cciFJbKht4yVZ6+aIQ72u1QLJ0qYbz7ZYvvrR2Tf+rL9
	YNa3TWdpwYezX/TJt+2MnyrezX1U5seN5PlnmgokOSQ==
X-Gm-Gg: AYBFou1g09I4OQMuLK7fv76Er/WPSju0bJoWtl4i5HgiSK8uBzGx0EGOwS/FelbSVok
	Qi7ABLmE/hjKWQhBbIXFAdWOGGOtEy3R3Br1qT44gqE52er/07QE+GnrZgmgLsLIogVvq1CydP9
	OmWKenPMcUneje/4nXLNdvJGnvO8rANyXtkOdZZXJMIJIKJI9lG3GXvnRaYK7QyTIFjU+RKnjbS
	WAiQoMYTbLFjinKQy6IBGttvjSbCnSmWhnnUYINpjVVvnV9Vc4iE4eUtDWUY5FnWrxGbby4IIOV
	uSTSqkBK6uCjEy4j4sces2jPu6fHYpF5UdLVRhTAPPM+Z6BF1lbt5ZFU4V5PNlAaWIS9ZqY3yUj
	wK4Eq6VMhKO34qS3C/IAv/4rclID9Ojbbkr6cUr71hXrYqPqW/FUKTaVW9J/ronGFUqkZ20bjUJ
	N5UbvRLj9bZeXHz6bY7A==
X-Received: by 2002:a05:690c:c4e5:b0:8b0:d9c9:3fc6 with SMTP id
 00721157ae682-8b39297cb6fmr2740507b3.13.1794251327276; Mon, 09 Nov 2026
 11:08:47 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109182055.7581-7-emil@etsalapatis.com> <3e1b58f40db74480c81dfd7dad54398d76742185fa68fa9160af5369d1e8785c@mail.kernel.org>
In-Reply-To: <3e1b58f40db74480c81dfd7dad54398d76742185fa68fa9160af5369d1e8785c@mail.kernel.org>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Mon, 9 Nov 2026 19:08:35 +0000
X-Gm-Features: AclHuK_Wt0UfvChImItuNjCsMT6q9gEvqhg7Q6FDQk39R37r2KIDG8NAR4jgeLA
Message-ID: <CABFh=a6f5dd9eAGbUg-1RZHytqebzyTdSgtzh+-Zqq34+q5szQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/9] selftests/bpf: libarena: Handle NMI reentrancy
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, martin.lau@kernel.org, 
	yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 7:05=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > selftests/bpf: libarena: Handle NMI reentrancy
>
> TL;DR: The prototype fix for buddy_alloc_memory() in this patch appears t=
o
> repair a build break introduced by the previous per-CPU caches commit, wh=
ich
> may break bisection; consider folding it into that commit.
>
> > diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/too=
ls/testing/selftests/bpf/libarena/src/buddy.bpf.c
> > --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> > +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
>
> [ ... ]
>
> > @@ -46,10 +47,14 @@ static int idx_is_allocated(struct buddy_chunk __ar=
ena *chunk, u64 idx, bool *al
> >  static u64 arena_next_pow2(__u64 n);
> >  static u64 size_to_order(size_t size);
> >  static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, s=
ize_t size,
> > -                                     int order, size_t norder);
> > +                                     int order, size_t norder, bool gr=
ow);
>
> This isn't a bug in the final tree, but this hunk appears to fix a build
> break from the previous commit, b92c329df4ab ("selftests/bpf: libarena:
> Add buddy per-CPU caches").  That commit added the forward declaration:
>
>         static void __arena *buddy_alloc_memory(struct buddy __arena *bud=
dy, size_t size,
>                                                 int order, size_t norder)=
;
>
> while the definition takes five parameters:
>
>         static void __arena *buddy_alloc_memory(struct buddy __arena *bud=
dy, size_t size,
>                         int order, size_t norder, bool grow)
>
> Won't b92c329df4ab fail with "conflicting types for buddy_alloc_memory",
> which breaks bisection?  The prototype change is unrelated to NMI
> reentrancy and the commit message does not mention it.
>
> Could it be folded into b92c329df4ab so that each commit in the series
> builds on its own?
>

Ack, the other nits are valid too but this definitely needs fixing.

pw-bot: cr

> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/426764=
08513
