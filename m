Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88C22A80D
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776635352; cv=pass; b=ulX99Kkk5KpFEm4Dcy+jwrF7t/eEzSgBTpNbcmnYloXjY475V1sGkfwM9OebftNC4AnoQKuI5ssWcL7QoL/zAqGa3gks+/lwBIlboPffb9u3bz7TylE5aRf3HMdNeNRtwJKsvMejCKN4N51k1Mhh6/TTcXGAN2RT0TsFljeDsow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776635352; c=relaxed/simple;
	bh=cFrGrWFy/krqcVnxXtLhe3ZTOUNcitG9G8OlGBpdvQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WoBqochC6iNWX3OILp1fOldrLI9U4bcUSw0LhYSANEsB5Mp+nZ7cQKRKmj3hb+D/eD7/z0RcH3KXGkyHkUmxg2cyi7woHcct28zWhsJ2W835CtcMF8dGUZs8mh4DwzWu28x7+MNSX7PCcbOVTnTbadh9RGS7pe1B8NY4D4X9R8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0W+Uzab; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0W+Uzab"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so14860555e9.2
        for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 14:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776635350; cv=none;
        d=google.com; s=arc-20240605;
        b=bsiKkvQXsOk86bzY24YGxIELNF7aGAy5eUtwSOLTAGAcvE8oxZZaXgOMq8xae2UrZs
         LHoQa/HF8wDtS/9B6hdWH0/jmB9f3wXq01N6Jn2lnesTLixytSQfFx7dHwn2J1SBA2Gj
         HJ7wGdhoYmSvjCB4xbDvVMW5k/K3zbxHxRoaV0/XvOpdsIZI/ssVhRefDCqRIMc8X9Oi
         KoBvNnzQbz7dF14GJmw2VXi/x2574h+CaHUTEm6Q3n4u8NfJUnbATdjFRI3dVmZNHQ0e
         E8zSAG57mzZtAzOenFPiUNJfTZfngNGDO4+aEH3SuZjhyfBGxMWf//tlRusYOCp3M9m9
         oTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cFrGrWFy/krqcVnxXtLhe3ZTOUNcitG9G8OlGBpdvQs=;
        fh=wKVi46mH2rN6Rhk0tEjcdKTHEJ90ScOGFHveLfiPTLg=;
        b=bI/AQ9cBTdJzVsAKdf5jPoqI6GwAkVBno8tfkFi/nTgCyP6nElW/vxjiREkHlGMI1L
         IWxAqCnBljLI8g1MeeNVVzdHioCb85QDEXjYdxe9kMDlX625P8JZoAoy1ESHiHodoqMF
         GRiHTWM6ks/UIXz6ae3aSE6lOAQwrnEfAUDXxaEp4dC8FUYLre2+XSnz5Ujplb+UvI0n
         6/CSBSO+VNYsUi3eUUJgFf1vbGVFpNi0TM9lMncG4Q2ObgKRTkhQjzRG+bg2Oj+YHH+x
         I9zqNUmgc6cvI7TMP3LVYsySyNXh+vBYTtdWaEqNj6mb+tLwC0HO/hRgEimEQs/RknU6
         438Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776635350; x=1777240150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFrGrWFy/krqcVnxXtLhe3ZTOUNcitG9G8OlGBpdvQs=;
        b=l0W+Uzab8A2jHi9AcxeOjnrxJcFvsXQLbecG8wH73firfOdw3bPZWC8F+EeYZgcGPt
         uDSBJR8ChNkkCUqfQmr4et2FUqcrSKnBOg3hDrCW20sxhxWQ82lMnAu0jipAR8GWWmL+
         mV6yIlsedB5xlg7I3Z25gnMEh3GPxFo1AIGClWI2s9j+7PzpPJxhzJ/s8L6FY0wnDWh3
         tLH7UB/28LPrTqyxOcbUc8Gj2wK+ximgrl+oKN6oWL/gJvEC26DjVpXnOCbMqW/SM04E
         rXAhlOBTIAziv7EnL5nVSKqPNJVvdl6iPMhdbNAmT8uf+VD4BzFKE+a6SzE5C+2zefDf
         offA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776635350; x=1777240150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cFrGrWFy/krqcVnxXtLhe3ZTOUNcitG9G8OlGBpdvQs=;
        b=rfONPZ3udhAD0XUkGLDbTYyTIHl6uJ9Z39mDD9R3JnIHNGVwtxkRnPkcE9H0Kbs3gL
         a1mO/WSsH47Fct/ZemOWydfwSGXEBiWMqz1wgatA3rQcCB9HbJhofMb/4yznp4hq5Mnt
         hmz9qjONI+apsrCRxFtn5OffDtQkVVS4UAGNKf+trhKydIOpiCAiAxwcOSxvXbV2paHR
         PssIqR7IA7gz/UQU514YASBPgy+HNqJsFqja4v/zDhdMO0a0p1qfHJO7SkgkfuUaqIt2
         o5i932D0tJdAUWt/4MoRKVIuoxnpCI5gNVdUlMC+UA8at5drYFaGmQOskxAsMRrdf/h3
         ETTw==
X-Forwarded-Encrypted: i=1; AFNElJ/onEg3VF1Zxde9kzADHRvIlxufDv7xypbUabi4aQ7qVHEKMRdPuY8qJp7oNKuoH/PYMtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc8KKHgOkeFK701X1oSQfOZ8pVEPteSKfgscquwhXJmUTiE4P1
	qECs2W1E3jnidNNbkFvkIe7CO//K5sEPhnVOH6pk7hyixXJ0MIlfHUQBK/ULmIgE5NDM295QzZv
	oKmAK99TvqEunNCL84VTEdULoAMl7MzY=
X-Gm-Gg: AeBDiesglda/9snjCXjUl5U3zhqeREIbOeOk2avS2JdIYSjWP1kN0AQPVIwA79ay2mu
	HnOKaM0E4twY0CGGDFcVMfz1P/KJ8SRZ1MQlKpwxRWG9MrnRzegduvc9LJCNivdvhvhPGge3Xgu
	bW3H83eK3+3kJReKqUea5d6Zd0q5JUdtAQIjhegVgy9j2HYu0oHzmOvUjMi3Qla/3VvmPpMW/Yq
	12o6O/GV5aulUcJNiPucHuy1mu1ccX+I/3R/Mt6QjVdG05qx0ikr9Di4G76rN7FdjC0hKS+zB38
	DHbnnXJyTVQ/RCDuBMJqUEiCki/PGc6lHnJ3ewxvrzYvUrfbDaJ2
X-Received: by 2002:a05:600c:8909:b0:489:1b10:d896 with SMTP id
 5b1f17b1804b1-4891b10dd45mr22100635e9.0.1776635349567; Sun, 19 Apr 2026
 14:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
 <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com> <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
 <CA+fCnZd31GzdpEqR8VhfK4JtUKyyRMgbBoAbeGACJgm7WvB6Vw@mail.gmail.com> <CAADnVQKv5y+gq=TnOAEXSqgBRpmHNjwqCfxpLaw5XkcbQ+23bg@mail.gmail.com>
In-Reply-To: <CAADnVQKv5y+gq=TnOAEXSqgBRpmHNjwqCfxpLaw5XkcbQ+23bg@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 19 Apr 2026 23:48:57 +0200
X-Gm-Features: AQROBzBeG23-litRs0f9sM5oKr7DzVV_-wsJjyIfGuOE5YpAx7fmmNXRz9M5Gbk
Message-ID: <CA+fCnZe-b0Qqbo5gGv3HN20twquQETDfYYkE1r9tPr9zUFbW9Q@mail.gmail.com>
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

On Tue, Apr 14, 2026 at 5:58=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> I think we're talking past each other.
> We're not interested in KASAN_SW_TAGS or KASAN_HW_TAGS.
> We're not going to modify arm64 JIT at all.
>
> This is purely KASAN_GENRIC and only on x86-64.
> JIT will emit exactly what compilers emit for generic
> which is __asan_load/store. This is as stable ABI as it can get
> and we don't want to deviate from it.

OK, I supposed that's fair. You did throw me off point with your
performance comment. But if you decide to add SW_TAGS support at some
point, I think this discussion needs to be revisited.

But please add a comment saying that those functions are only exposed
for BPF JIT and they are not supposed to be used by other parts of the
kernel. And in case you do end up adding a new config option, guard
the public declarations by a corresponding ifdef.

> The goal here is to find bugs in the verifier.
> If something got past it, that shouldn't have,
> kasan generic on x86-64 is enough.

FWIW, I suspect HW_TAGS KASAN already just works with JITed BPF code.
