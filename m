Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2DE3E8C6A
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776177533; cv=pass; b=I+UzmtArcZOwoZwSOFS6OLtnDagMqIqi75dCfmtedJpcPFvk7bUC4YV3fBUvVTrJJTuqMwLiE+VbrqaNSBDib49ZUYZ454aexAm7yoy1URVezFBpwuLxf9XIBMgk9RAIVDqn/En2mJ9smI0Vm7+v8wZFH0NQsUP2HGruDzsB+CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776177533; c=relaxed/simple;
	bh=ZvMerGqSJAlyqgeddQ6lYem489w5ZSqqOzbNiQRZjn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iACY9UjLSvknRboQUM31tkHWRk+GGQxMiQkOej3pLQ81iUJn93gl2QnUIjLRRB6uHLFb1O0VxaZG0UErfVKRRaArEcD4fv2lvAd5S6HcB1uKqzCOtCJQONGmxJYkc031dEam/06X4Enk+6FFq/ZUaucMmFz1uMqAa8fRT4RRr4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mrx6BKQa; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mrx6BKQa"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso4829138f8f.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 07:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776177530; cv=none;
        d=google.com; s=arc-20240605;
        b=P7PXPoXQRiTUHJIjwLLnPj3KtIc/wN4ysIXWSaDhqvE9chhpZRUilnmAl+yMW9mlfY
         kfn9s0PMgy9haoVNnuyRPcVDQiH6+Bk6rW97DiLaV/XVl0JpJwaur1dOSCmIYyp5fb8A
         f24X/SXxxYCo8ldb1ra146OSJDTGjWYO4p2tLRMRBSFYtx2ZitQ8UOUDu0Rzr+8rZOwE
         0nc6gQEXvhKAtPVquGB4fuj/5ntdb+oB6RWSYqc0cfzzUz30MtprklIo5S2bOYlxSj6t
         CeTiih0xPFTKTdtu4ktsYxhrS1nePQtMJid6iWoxVzJ8+1ALn1Tnyiph1v+m5vWu+cYc
         fTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t3FcHIl3IgssSn4hNhLSe6L719nynY/t+2SO5yRqP3Y=;
        fh=KEq7ddak5osSciC5ZS60+J1zgZ0kH09SXscEuFIZO+0=;
        b=CVbb/RgM8HKgC5AiKiMjwtjXkhoz7WNLfuG+5oLANk+WybuWOSVCnlH762q65L6dNu
         Lo1TQB6zdAwWcy0WGJZAzASKaNAa9FZ/H5km/CMDvmjw5UXJ07jtu9CQBO51uGfeouvw
         U0tOR2LNWiFpnGEiohFVE+Fp6raHfgnTlLnL//kqHy0OhvMhODNJIbiWWKiKHs4J3kV8
         njSim0e4axk9LlsHz8H6nwsJoMmLR+uPzrMinLnp+WeeWNtMhHe8NfXQEbX/ar4cMlK0
         U2sieSAiTjxWT6pK9rXkugGCzT4gPw7OCNNIN6JFBKFOaFTihhRV19GbhS6C0QZb5ACH
         GmuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776177530; x=1776782330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3FcHIl3IgssSn4hNhLSe6L719nynY/t+2SO5yRqP3Y=;
        b=Mrx6BKQac/mEAyn4HtM7CA/4zoqjbafFfoOa3S5jeSGGwGbKSXmN2jivtA8VEYQJYw
         z9Ue1GdunUm5I9i9avQeEKnEvBc9lc/FhuMxJp7/ZaQMxjtywG7YwF2oSRuLLMwb7E+Q
         zEAZ/EfdfvZEgvZz3KWjh4FUtdtb1XMKRwb4tOeMnvom+tZUDs2JlSK3l6Z5Zu/z05i3
         0JNubg6yJ+UDiJcZbtNBmu2meWIPmgYH9GfLO4PRhBw2JJ5SFiOd8ZeTigvYHothvHa2
         EEFEeDrnwNaSOp9YHhdwpZ2oqRrZA+wWzkBUBa6q0ME48njcpfFcQG9Ckl2I1im5Wxm4
         /JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776177530; x=1776782330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t3FcHIl3IgssSn4hNhLSe6L719nynY/t+2SO5yRqP3Y=;
        b=h6pfKdt+ySlaU5YPExch8VTKYq/YHwVbnBTEBbpBEVhEquGmdT2FVgSOBOCoLr5bPJ
         yQcxGijz6et2KqpMmPEp21X3p/sG7n9+bL1/LIJ+dOGI5pY0CjxiiCeocSqCn9v2Yqh1
         Nt+JIswlvA6LNGj5HEGjTsNm4KF4lBZTb06+3m/YHkZQYLexgfUVq6BSpRGRVwyK/QoY
         xyiUEP5MAxYlXYdMeGzPh7Oy9xCU7VSNfFzwBcqx/BH1oBFtqG1rs8m1+xzq2zFNYrsc
         Al2lJ/Uj5dmBOlkPsvWNht28n8VZBUS+uLS9QBlb62zETA9Ae3YVitUWCMmbLxWb22ro
         VJZA==
X-Forwarded-Encrypted: i=1; AFNElJ9rBoZj2ml3SKI2fx6O3/QxvxZO2clCsshEkkGkuWe+L0A7w9AcjQ1NCeGo4n/IjJOTS5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxiJFtdBg3sjucBhUgLFhzIMV4Z/ct+UNiwi7WnKwNEjEWA8Xd
	W0JTTB1XZ+jQa42qzrpdf6+RrI+fP4+UA+4igjTnu7+oyrPzHOiI0x3ERt8d1ygpv+NB0WCDgIs
	AQJS6NQcFqqoaTaM29rs7uhhG0dtB6tg=
X-Gm-Gg: AeBDieukP3/f6V54MWEIrjYe6x1M+yJFPHvGYacP1p0aMe4qG/wxpxRjBvQ3pmuUedc
	29H2g193WwrKCEW9uRH6CRrr0NxMzcBqknEYG/svwQ2AxeaCAOyME4VHxarvJ1PpHw5WFwKTulf
	M+BBDVusMQEyeCa+oYoZZdwy50us5/MnnZnhlijwT8PcyANuUkyh/0GPrK691wzJfgyJxxiIdJE
	et102xvROJ3sf9535HV6dQIdGemmZAoJ/UQz3n+HUiRbUjPdkGH/HUXUJKNRXSmgs1xA/BLWB8C
	ZHsVE+DLFDeQpXEJv3dRQnoIEVZU0JduTuO7N00SJ6ztLHDEJpDUQAoyZa1f8CIDquUUVV9hX/C
	IAOWbr7QS80EfDSkQxVDstkfuSw==
X-Received: by 2002:a5d:5d85:0:b0:43d:73de:abd2 with SMTP id
 ffacd0b85a97d-43d73dead51mr14691281f8f.26.1776177529609; Tue, 14 Apr 2026
 07:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-3-1a5831230821@bootlin.com>
 <CA+fCnZf-o8tiv_tX9YB5eBUGx17OpztKZsEB6Awjw3WAqBAiUw@mail.gmail.com> <DHSWSSYRPUVC.2W3G3OU27L3HG@bootlin.com>
In-Reply-To: <DHSWSSYRPUVC.2W3G3OU27L3HG@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 07:38:38 -0700
X-Gm-Features: AQROBzAAc3g7dGJeHc3HZECQFqFuOBrJ_YiWzr60z_aqmL-sqKG6l_qunoKkETU
Message-ID: <CAADnVQLj=UosnsC-4V2+mN92Fe0-kW++U+m-O9c93kk6BwiXgw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
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

On Tue, Apr 14, 2026 at 6:24=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> On Tue Apr 14, 2026 at 12:20 AM CEST, Andrey Konovalov wrote:
> > On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Found=
ation)
> > <alexis.lothore@bootlin.com> wrote:
> >>
> >> Add a new Kconfig option CONFIG_BPF_JIT_KASAN that automatically enabl=
es
> >> KASAN (Kernel Address Sanitizer) memory access checks for JIT-compiled
> >> BPF programs, when both KASAN and JIT compiler are enabled. When
> >> enabled, the JIT compiler will emit shadow memory checks before memory
> >> loads and stores to detect use-after-free, out-of-bounds, and other
> >> memory safety bugs at runtime. The option is gated behind
> >> HAVE_EBPF_JIT_KASAN, as it needs proper arch-specific implementation.
> >>
> >> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@b=
ootlin.com>
> >> ---
> >>  kernel/bpf/Kconfig | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> >> index eb3de35734f0..28392adb3d7e 100644
> >> --- a/kernel/bpf/Kconfig
> >> +++ b/kernel/bpf/Kconfig
> >> @@ -17,6 +17,10 @@ config HAVE_CBPF_JIT
> >>  config HAVE_EBPF_JIT
> >>         bool
> >>
> >> +# KASAN support for JIT compiler
> >> +config HAVE_EBPF_JIT_KASAN
> >> +       bool
> >> +
> >>  # Used by archs to tell that they want the BPF JIT compiler enabled b=
y
> >>  # default for kernels that were compiled with BPF JIT support.
> >>  config ARCH_WANT_DEFAULT_BPF_JIT
> >> @@ -101,4 +105,9 @@ config BPF_LSM
> >>
> >>           If you are unsure how to answer this question, answer N.
> >>
> >> +config BPF_JIT_KASAN
> >> +       bool
> >> +       depends on HAVE_EBPF_JIT_KASAN
> >> +       default y if BPF_JIT && KASAN_GENERIC
> >
> > Should this be "depends on KASAN && KASAN_GENERIC"?
>
> Meaning, making it an explicit user-selectable option ?
>
> If so, the current design choice is voluntary and based on the feedback
> received on the original RFC, where I have been suggested to
> automatically enable the KASAN instrumentation in BPF programs if KASAN
> support is enabled in the kernel ([1]). But if a user-selectable toggle
> is eventually a better solution, I'm fine with changing it.

Let's not add more config knobs.
Even this patch looks redundant.
Inside JIT do instrumentation when KASAN_GENERIC is set.
