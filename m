Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF6B2E228D
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 07:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150015; cv=pass; b=OcmvkcB5tWjWrvIBWpp+8Vre9U0bIm73GsJt2+6mxwhGF3WZqZA1b44p17e7ymTKghqlCur+5psYw846Fk2N0QXRHkqv9yZjY30qy3Prwgs2uvM1CAYIQ1tkUoRVSTJZC83SXeERfQn5b7SmLYHLgTVqdn1zpRU4TSlWHtisuxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150015; c=relaxed/simple;
	bh=FSBUggxj4HWo0N2lK+Hwhq6VzkB4OZVykHxnRZBfbF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOvcBRJm/YslXOUpM91IwgEYt3k3oAtQk8loPx0VpRNVwWSf87zCYe42zBWE9SolwcVkhrlsXkq0w57ZJnhZs7YSKYPHQfiBV6tfFdGN9WTKI8k9W1ZLaR6C4bWDMntk1PutZ/PaPYZq4xFG9u+pbHkoUeyyIfOfVPktm8acrYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ba7H4cd+; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba7H4cd+"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a535e7c00so61573957b3.3
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 00:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776150005; cv=none;
        d=google.com; s=arc-20240605;
        b=f3WoqPilgmEhPqJQWD02uGJ/Dpq7d+ZsaYHUbYIvUM0gN2cJd0pqMD4j9gkvfiwrIk
         MPIj1NdJl+JfKderKSNwKdlvKVpdIItUF8jHZijfT5zA2NQ/602EvWbCs1coC1ZKoLTN
         P6HJHw2lP9SaJyS77zT+5poHQhkzHZR95NIBb69mplro+wCSQjMzmaLEYQLCLZS9uHh6
         zFQXAQ1Zq5dvH7oHZ947qNf0Hbabx8GxniP/aZo+Wb3fovNVLXc+3jqT2Z5zJf+WEmUB
         z+7TJaEtJgQfyU20R+9urdB53CT2MYuegE9wjEkdptGgSsEyzYzM6Wm7qDomDekhPOnK
         /Q5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2MgkN9CqIuRCkkTCnfBEkBgXFdIwwMDPeAwkUBmgo6E=;
        fh=6xL71wcWg8z0ejJpFpHfbL2vVGifKLdKQ1fJbHSW8PE=;
        b=h+fIpgTqsGADKHS8rU4a5sU0UVvdEfk9pqZf1z6yqSuyCeTDFrxhF6CmJcW4AWjIpS
         Im1AvSaprRajZ0pYBTMMP7zZLAMFbixUZRiLOTPy8E8/PVhOWlOgLp+prVdsylcm5+WQ
         hExwhHNXPE1+jlXXwZMhZmcyPaRp+ybMw/AJEhOHmj7Ul1Tyvicja6sOnCXEXw6VEwwE
         MSrub4WnVoBhfPfUXUn3iTx5n67osR/hpHMe69PRD1VkE5SMD4h1NejBeVeAG0VrgquA
         /ZpxnqwQb6UrYdOkvpyCL2ZHBKhV+VPIMxZ20lxiJv4kxDw5XsxeIRHQJ5leA6ddMRgt
         RT2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776150005; x=1776754805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MgkN9CqIuRCkkTCnfBEkBgXFdIwwMDPeAwkUBmgo6E=;
        b=Ba7H4cd+faeu5C2Vu6TTEF78+KXmb9/wBFB7jM0VU9q6ad3zxDl9vOy7fIlPPC3XHi
         KdQP7i1bkP1DAVlRlGZx6xV5xqsChR7885fxCptvJHHAguYvB6g6SU71/6S2NJLRUVbl
         hE3poTrlMNnIbrCgdSk+nN8JLRcAZmFNklPeDY5x4nf9TDfCplxR3QPc8mAeVh7jFcSp
         4yaXux3RuMK1az1534xF3Ma58ltkFjg9dcG3ns0CaoObt+6sDIczXXbMvgDQZBj2L7eM
         v00GL4jxM4XjgqEdPnmG3eobvZxEguLYGUozGpae+8kTYWwBpPgG7RMnN0RowcHFvYgK
         5UBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776150005; x=1776754805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2MgkN9CqIuRCkkTCnfBEkBgXFdIwwMDPeAwkUBmgo6E=;
        b=OPpmBsRSbrUSBAdNPu9mYBC5u9z1nz81s0VSjHpuYbx48WjDgxxVj2kGvu3kjfu3HP
         wZW49CYkiwXbK4wFyji7xz51S+Y+t67NNtvppfcmg+WpzvsQ6+/PzAe4PFrrR9aq77rV
         mEPS+kKal3Gtb7qV1+i281xBEPYHR6QXvL0ep/E8W32NkUleockxxEXFTE0kYbKoE3nh
         Of2QZgHNzy+Kd9oS/1sX81T6QfHsn3CALMRLjJtWSxN7NW9Xk8e6bxFjtE1F8uapSzU9
         nGXeeQAwNQpsE2ZHP/qdnSBooggGW0UCe9spVmpgxP9Kbqtkj5HEkrZ7YoOXew09tLn8
         W9jA==
X-Forwarded-Encrypted: i=1; AFNElJ/C4B7BpXSDZsXF0tys0cEXvoJj/AIeNOVerNloD09IqMktdbQPpt1DYEeB+z0htFgUGvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy2zBVr/YR9tjdqOz4XYZy/KmgGnAxTbR4HNYXWWnRsXFaahAC
	9HcNls2ROk7cf72tvvKFiJGLm23hXW4c+eVmdUSJqhaSiCeTa8qdXwTySu1rbXPDNrnGFv8bi+q
	L+CeWTJ0R1SlqfpJ3Mwe+bAxKkxvQtQE=
X-Gm-Gg: AeBDiesWpod14KOv6XQYdJKZS2fPBVaNzDVWYeXw47YgQR6kEGVXpPDOxebjdttOmhl
	HZwQ07+/YAyth09t2tLoxLPCtJKRfQRviSia8SDiBFjrSa27vqj445r0PJkwRqPu1SS7rbaFzMH
	hxvsKrwRl7NnwkWIzWorPN0pYR8FbAJq/vqItkCeUvezrrrJfvi3V8B8CeCPH3YT9vCJAkSEgdP
	SAxEQajf55pduSes29y3q3oNIztQvzK1CIm227wFw6dIcI3a6K2olrwbwauJniKxKwah7t2wfiQ
	aaZywTB6pXZnpljUEPYzWAmIdBNKlDlvt4OjUlm7
X-Received: by 2002:a05:690c:c4f3:b0:799:3a3:2f25 with SMTP id
 00721157ae682-7af71b5097dmr185894167b3.38.1776150004743; Tue, 14 Apr 2026
 00:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408175217.1011024-1-song@kernel.org> <CAADnVQKMyGyw6vYVPVgT_G-CfbabARTiisd0dKV4U+8SY3qcEQ@mail.gmail.com>
 <CAPhsuW4uCU0SitRErVGr9B3RA9_MCxtGopHcpyZzw-Nm46fGEA@mail.gmail.com>
In-Reply-To: <CAPhsuW4uCU0SitRErVGr9B3RA9_MCxtGopHcpyZzw-Nm46fGEA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 14 Apr 2026 14:59:28 +0800
X-Gm-Features: AQROBzAq1Nd21caQjX3XYQkSSvKXjcxB7DOSBwIH9zxOUVeDVQ9U2AGjnqjw2Cs
Message-ID: <CALOAHbBRVbGEm9ueoxTR4ToxPEvW9U2=8PRxfSWpotf_AkRfmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add BPF struct_ops + livepatch
 integration test
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 5:43=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Sun, Apr 12, 2026 at 2:02=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> [...]
> > >
> > > This shows an alternative solution to the idea proposed in [1]. This
> > > approach doesn't need any kernel change.
> > >
> > > [1] https://lore.kernel.org/bpf/20260402092607.96430-1-laoar.shao@gma=
il.com/
> > > ---
> > >  tools/testing/selftests/bpf/Makefile          |   2 +-
> > >  .../selftests/bpf/prog_tests/test_klp_bpf.c   | 109 ++++++++++++
> > >  .../selftests/bpf/progs/test_klp_bpf.c        |  26 +++
> > >  .../testing/selftests/bpf/test_kmods/Makefile |   3 +-
> > >  .../selftests/bpf/test_kmods/test_klp_bpf.c   | 166 ++++++++++++++++=
++
> > >  .../selftests/bpf/test_kmods/test_klp_bpf.h   |  12 ++
> > >  6 files changed, 316 insertions(+), 2 deletions(-)
> >
> > It looks good, but takes 1.6 seconds on a non-debug kernel.
> > This example can stay out of the tree.
>
> Sure. This is not a typical self test to begin with.

How about adding this test case to
tools/testing/selftests/livepatch/test_modules/? It would serve as an
excellent demonstration of how livepatching can be leveraged for more
creative kernel extensions.

--=20
Regards
Yafang
