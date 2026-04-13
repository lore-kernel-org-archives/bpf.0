Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450CF37CD3C
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118806; cv=pass; b=aSGbtRAZ/3l5b+D7x9nMLQv1N2CAnPK9ugCtL4DczGKFUL//grdR+PBg1CYnUoQbJ7W3/nT/ZxGIfSoHyglhCaYlDu55bAJQHpdwihSzEegBZA5vg2+rSr17soOy670z+NgeV/efyhbBhxNH/b1JprHew/l/fOUU09oQ3G0ggPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118806; c=relaxed/simple;
	bh=kNKohDEFFmW+7dpbriwJO4wAUSXkwkDI/vzNUTsWEFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WW6ZSJDL8OzHHOu9QLZkKBXEzfwc88R20KuNconJikeJvH9kV2DpfQvqcCwlVcCSAJCbUCc5bn7M0SVr9RxwfbcDrjznBuaX0QHwLW/HHIiLQW/mxly4xDk6sPkN8FtJ0BA19YZiP1bC+FpiulZHe3npjE5y8TA7rvQziy++cT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g03i7k/S; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g03i7k/S"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso4994288f8f.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 15:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776118804; cv=none;
        d=google.com; s=arc-20240605;
        b=I21fXaPEV8KotJxBcZXkWZJBsBxCFhtkm7/Ju3GKh3ULXBEWZTY1FodDLZIZURxk/I
         ZaW5UCaPlUiDw5dN6ZiXWm/dLtjH6bPWesXKKWdUEKhUCB1vOgWdQJIm9rWmnDeu9OKR
         xlnJg843dqHJFW4+DGZjBe2kqDzLJ60yMm16BYsmoajUdRDxKj9KBlV5OqVbGQCk07ZX
         WtMLNN4PLleVRq/u8oY6ZPoxe1G2gTDdwMuJq0l7iLV/4Y5Wr0GRRdvWdreaQJr5SspS
         2prNHBMMNpD0M2XCVWoqANG28dDhjw2osrIgPFZ/6QHmDI71AfQ/+ntu0MU74BqW+qOP
         CIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=00dCXJraG3Nz3xP1Zulfjafowes4Ec60LER8Tb820vo=;
        fh=D0Y8EEUewVvq8wQFdAQeQTDvOnsW3ctSNhufvMybq/0=;
        b=RCAFKqt93l2SHvjI2owZ32iyU+b8mXzLqwxeWVpjdfK+iCJo5hRLcp7CjxBu1eFMJ7
         C5humK4MG650fAsZ91Q+QYP5uvn0gSLFHGpIc3ZvB0YV5osed1t7FmpMuvVuuE0EYsAf
         FsyfyTF066piGbcrJCpYmo64ZM0Qvz6kCbGV0XR4jLv+YkVgtIwzyc37EsCVw8jwtj34
         7DpQ6lQSXk1Efvmg34nWMg3XBC+xes1YyUx0rEjW4oYw4J5VRD2WnPTia9ArTl5wfEn4
         z+arTyzLH9yCnU1qUvXu8z+HhafXsKqWIU7aK0SCZARaTvHei/o5fYe8YIVi09aHtWP0
         rwGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776118804; x=1776723604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00dCXJraG3Nz3xP1Zulfjafowes4Ec60LER8Tb820vo=;
        b=g03i7k/SVwApX7g+StbK7o5DoNWnSQdUBXeflYN78e6cgXdTC1NMSDWX0fA1qNCgiG
         Fe+uEf0ppHM637+NeBB428R0bZiTnKxXceJti+Q+7RyRt0Yk3c2rO+TQH6QrafXV/fx8
         T2xBrwTX6hNdLNXENBcrmwqLNJFlho65WvBrLaE0ZBNbqcmaacyp3Q01yS0vGlGDlt/G
         KLOVD+Ft9DkpsRy4Br5WuFXv9p+fhdFIF4pRdzyuAE7uLLALM6g0X987SkSH0vDOVR01
         4ySURLElGvE3aXojgG+lo1r81r7/D4Jt8twXDlc6FOKHMyqVEs4PxjtLu3a+XhnzkHYG
         xrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776118804; x=1776723604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=00dCXJraG3Nz3xP1Zulfjafowes4Ec60LER8Tb820vo=;
        b=qr0C923KporyESPgA7v5dLvGXRbP4VemUmZb1jPJhOZkr9vQuLHK4yNClv17fY1FbE
         TtR80clVepSTZTJ1QqBVBgu0Ftdv/KDpxfBKTRBzod2BhwIcnzFkf8zCMq/VRqnVf7pD
         AhzlyLCGGa2lkivRGN2S9G7g0JZqEis13MeTgDIWUeq9vSIgM3eLjjz7ODDGFIe0aqlX
         /kiAWUWDLrf2E7Qx15gTJG9fA/a77t+xCU3gi/kUYvHDf96CDIJtV8e/f+eKZ/77RsM4
         hg2blk9HmWyRBkOso9cjgvG2uesiLjUAW7rW1Ga3kQgQz+SR1E+MCCxdqdtXipp/fvcU
         kFZg==
X-Forwarded-Encrypted: i=1; AFNElJ+yyjw1o930rmCwsuSnPCYu+VAKZW4q1n2Org/YVM8Kd3MnzZkid8FMZqLHOezxIXrRLTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmR+Uma+5m3SizngZN7yFuqzUauviAZ9ndkd0kTuwEo3je3b5K
	v740gJtsBYjZ2jJ60RPn8manj86ksYjh2HBnbvnFT/qI+Y1DQGOTxHiYv93jWKr6FuusM60qm2Q
	DN51I3IF4gH5Mu6GtMdh1IFR2hpK0mOM=
X-Gm-Gg: AeBDieui54dznTA5KToomtMwstUehyk1hP1nolXa9s4IcbX8GdlUgqhJL+N6F1SW+5P
	vwWzEVVqRlrOWgaUcfcpLRzEwfHdvnrBH+4x429sdCd44hWSOs6x5F+Luf8DTcB8tA4mUKCgKHj
	ke65MmhyYOHZkgAQmMglSZ+Sh7GDhxWgDOEBz9dkEtfKG7P04WKHGEOp8C6H4E9sUhuahSRg91e
	f063CCHCW8WTHbBSZ9UdGaZe/lkzJwjsddGkYztiFb8Eeo8TgyNRsARE/v/Mg/sTRFCoEIn3T75
	c2NnvH/NJhE37KKfW9+2BbJHkLjB1vkumQTMC3ry
X-Received: by 2002:a05:6000:2c0a:b0:43d:576e:63 with SMTP id
 ffacd0b85a97d-43d642d363bmr22139849f8f.39.1776118803430; Mon, 13 Apr 2026
 15:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-1-1a5831230821@bootlin.com>
In-Reply-To: <20260413-kasan-v1-1-1a5831230821@bootlin.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 14 Apr 2026 00:19:52 +0200
X-Gm-Features: AQROBzDwNCNsQCHGNuFB9CZ_Z628O1o6wbow_4AViz1wzqVpQC382sCN6eDZsJc
Message-ID: <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundatio=
n)
<alexis.lothore@bootlin.com> wrote:
>
> In order to prepare KASAN helpers to be called from the eBPF subsystem
> (to add KASAN instrumentation at runtime when JITing eBPF programs),
> expose the __asan_{load,store}X functions in linux/kasan.h
>
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>
> ---
>  include/linux/kasan.h | 13 +++++++++++++
>  mm/kasan/kasan.h      | 10 ----------
>  2 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 338a1921a50a..6f580d4a39e4 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -710,4 +710,17 @@ void kasan_non_canonical_hook(unsigned long addr);
>  static inline void kasan_non_canonical_hook(unsigned long addr) { }
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
> +#ifdef CONFIG_KASAN_GENERIC
> +void __asan_load1(void *p);
> +void __asan_store1(void *p);
> +void __asan_load2(void *p);
> +void __asan_store2(void *p);
> +void __asan_load4(void *p);
> +void __asan_store4(void *p);
> +void __asan_load8(void *p);
> +void __asan_store8(void *p);
> +void __asan_load16(void *p);
> +void __asan_store16(void *p);
> +#endif /* CONFIG_KASAN_GENERIC */

This looks ugly, let's not do this unless it's really required.

You can just use kasan_check_read/write() instead - these are public
wrappers around the same shadow memory checking functions. And they
also work with the SW_TAGS mode, in case the BPF would want to use
that mode at some point. (For HW_TAGS, we only have kasan_check_byte()
that checks a single byte, but it can be extended in the future if
required to be used by BPF.)



> +
>  #endif /* LINUX_KASAN_H */
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index fc9169a54766..3bfce8eb3135 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -594,16 +594,6 @@ void __asan_handle_no_return(void);
>  void __asan_alloca_poison(void *, ssize_t size);
>  void __asan_allocas_unpoison(void *stack_top, ssize_t stack_bottom);
>
> -void __asan_load1(void *);
> -void __asan_store1(void *);
> -void __asan_load2(void *);
> -void __asan_store2(void *);
> -void __asan_load4(void *);
> -void __asan_store4(void *);
> -void __asan_load8(void *);
> -void __asan_store8(void *);
> -void __asan_load16(void *);
> -void __asan_store16(void *);
>  void __asan_loadN(void *, ssize_t size);
>  void __asan_storeN(void *, ssize_t size);
>
>
> --
> 2.53.0
>
