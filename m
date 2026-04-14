Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A833E6398
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179424; cv=pass; b=ncTZG7XOXPo4+liI1MLLAFY8IlH9VjDWZdJVbGvMB7H0H8f6xm6OoRcH/pTd/BX8DmtHOWsTbXTyHmLXNdfo7V+jScxHBFsHxi0Ps1qqRYy8iXtjaMYyAHfACxq6d3SqNwVZTZMyZQsDoOQ9HwgztUBRqWlChTR01S0Mj2l6ais=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179424; c=relaxed/simple;
	bh=A7c7tKPqaKq3NgFiv2DNK8q/BvKoh1wbxDHgCCrA1+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVuDQ7CD1lUaLOClnp4ERb2rHTgVcM/EpNvBuJJrFnOkzGgfue7p/lsR4rxW2n2ikxHJjmbbUZlCfB9pZ8kpQeJsGfNVPAtovtcqjYmiBTBEbBlRr2+v3mkRkiiX8WonncpqFWPEeZhZvns0dcqRzoMIsYCrTc10wiSiMy/rMq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUKFA+2A; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUKFA+2A"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d734223e4so1665840f8f.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 08:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776179421; cv=none;
        d=google.com; s=arc-20240605;
        b=MkYKHoOozrOicXAYAzlIxCWoPezNabA2bGNL5mOMcXJ4dD3oputqz7RQ/K0A1kCJ6o
         RTENZgAqyzrpk5pKFTuLUJ4Kg4BuVwMpzHMNqDiFscADxVkyoA55SP7EIPXealVbnG6v
         bxuGmdT87N8BZoG4mMnkHVumGhrAIkzsDcd128KM6goWv0EmxAgd5+VbuO9xS+1ufZMc
         v63aYs4YylGDz9IHktHY4MuLgQS0TzIrzI4FQUa5VOeAD4jLG87UrWjgxz970rnLmG+I
         MiqEtZ/drKyAwapO3+SC8Bqy5RZg4nM6hUOLJOAbF5sDqEao9Ok+pZH0oxoAxVz7oFp1
         z/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A7c7tKPqaKq3NgFiv2DNK8q/BvKoh1wbxDHgCCrA1+c=;
        fh=xLFmWPTUt3pgg6mrFDsK52YQyOm24x7GryxnGNPcBAg=;
        b=LUidYlF+AI53EM2jerapODh/GjzCorgau9woviFPkoZGwld/XwyDga77DhUjIQoYJd
         +Pd7VzxRoLRcF5qdY+eGfMHkxJHrYdsr9iKohy9yThNr6x3xseuDiumI6P48RZzbFEcF
         ycyPsFlj/BkcFOZRRmfKdey2Ps8hGcvPl/EwCU8aTy1KypRG/CVkeF4ccQSJiSO2wk5c
         VcmTSSA3/o6QFeVXdXU3tgXcHnvXF4CRI6ia9kHYqp4m5t1m27/kNHNMFrUXUa47iWz1
         z6myVKO9rgrVIb3chppL9ldSKRzJCmVGGHQD1ckbk+RUKpEiB/kklx+1nQCraAzEk18N
         fTfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776179421; x=1776784221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7c7tKPqaKq3NgFiv2DNK8q/BvKoh1wbxDHgCCrA1+c=;
        b=eUKFA+2AoQREtn0iyQraI6Pd872uELauer8EVJrgJNhwKAL5DDkqWPhcB/7eDyozrx
         qbp9AJD0LHtNW1OtDScOl8AJVcbQOTNhU6w3VpD4FhCfMk0lNNP/jQ+LJwQ0drfIq1wI
         0oNyhdBZv/fo7rrKJ1W5X9KGjMvlW7rSLEGpsjo/XfKYyglsnire53d/4PbfQJEqNXDL
         3lOmas2U6pCwaTfM++sGZBaeyn5QXX/V/ErK0tawok/bWwzgOHtquIHAdxnsqGJhX+u4
         ocUpxh0rqMDOtK4blQIOE61GbogTPRhfyYmworZTWngPik83hC1PFpMdJF4kTzTTk8wX
         ZgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776179421; x=1776784221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A7c7tKPqaKq3NgFiv2DNK8q/BvKoh1wbxDHgCCrA1+c=;
        b=UabjrDZx8zqUlyziKMn2LcAyOPi4ggI1dqa4me1bVC5WPdfKPISVMiwHle5ErWyq6r
         biHrv+ru/+yxpJOTLNAjNI7B1CI3vrkClvTnuKPbrZowAQGyQuEszreA1CQUtV+PzZ40
         OlI9H4rWdraaXcv3qmyrW5zIt69XDoGocug0EZNIIP6ev/EnD2ZGoHykECeTKavX9sjm
         my0xIEsJinzneQtL9yHvc9+hG+tq2Ro7cPWYHNhBmlM42eufe9aYru1eF8m/59QCLpC/
         +tRp9Ec8LFXFwVc4wJvIDRlL/ftEl8R/S6dPKVQR710rutM1zGhdPuwSwLgM0JuWrGbo
         ZxzQ==
X-Forwarded-Encrypted: i=1; AFNElJ910ZQGMb9OyH9aDzDlcfRndzPjY0waSMh57S/Jtu2g5UjsB7YTrifkWmjK76Q1czrsvPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwBI2DLW0jNJoLhgCZ1we7mXWf6ajESiWXsCmZ82e7dh+N5vjb
	FPM/Nft78uXmGooSNSMNVjSdTK+0OnKz9iwuteP+yQuyr1xnqQ1VvmbBQ51wwaAdV46EPQRBQnF
	pXR4pJrYoX2S31xUstvtJgQn9z0ErSNE=
X-Gm-Gg: AeBDievqxWO/fbf4l4dSRkAH5E04K+OpjSt4m0GjHVGfWjhnIYvOHXeTlxGcPW/jvKH
	+81vvdF9h3khg2HVl+GB9fvYrmO2VZQAbrQE53ViszK9H7bLnhZnAUe0HOFAUw9LeiG+kV5sRxi
	63wvdHVwJ0CTqU+NazuLkwU95XcJ4jLVVHqPvk+3XNLxV+uDXqX6OSfAhvk05yTKsfouFAwoAzr
	GaJU6o/KT7QnXs552eB7HjRZU8lLbud53q6hT2BXRLU1dfiGosiYZFGbh8ff88LxlxGG7x2lI7t
	gBh+6PSbGVQs4VWJ528eci/0ro6VIP0gZk0vkV6r
X-Received: by 2002:a05:6000:4110:b0:43e:a8cc:89b7 with SMTP id
 ffacd0b85a97d-43ea8cc8c24mr1517128f8f.3.1776179420992; Tue, 14 Apr 2026
 08:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
 <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com> <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
In-Reply-To: <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 14 Apr 2026 17:10:08 +0200
X-Gm-Features: AQROBzAtXSFwPeCMpZ2dGca-DBLsSXREgEyBZSQFf7Waht1WxQ2QIbb8WTtAIYs
Message-ID: <CA+fCnZd31GzdpEqR8VhfK4JtUKyyRMgbBoAbeGACJgm7WvB6Vw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Xu Kuohai <xukuohai@huawei.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 4:36=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> > ACK, I'll try to use those kasan_check_read and kasan_check_write rathe=
r
> > than __asan_{load,store}X.
>
> No. The performance penalty will be too high.

With using __asan_load/storeX(), it will be one function call to get
to check_region_inline(): __asan_load/storeX->check_region_inline.

With kasan_check_read/write(), right now, it would be two function
calls: __kasan_check_read->kasan_check_range->check_region_inline.

I doubt an extra function call would make a difference in terms of
performance: the shadow checking itself is also expensive.

But if the second call is a concern, we can move kasan_check_range()
and lower-level functions into mm/kasan/generic.h and include it into
shadow.c, and then it will be just one function call.

To improve performance further, the JIT compiler could emit inlined
shadow checking instructions, same as the C compiler does with
KASAN_INLINE=3Dy.

> hw_tags won't work without corresponding JIT work.

You probably meant SW_TAGS here.

HW_TAGS will likely just work without any JIT changes (even the
kasan_check_byte() thing I mentioned should not be required), assuming
JIT'ed BPF code just accesses kernel-returned pointers as is.

> I see no point sacrificing performance for aesthetics.

With the change I suggested above, there would be no performance
difference. And the code stays cleaner.

> __asan_load/storeX is what compilers emit.

For Generic mode. For SW_TAGS, the function names are different.
Keeping this detail within the KASAN code is cleaner.


> In that sense JIT is a compiler it should emit exactly the same.
