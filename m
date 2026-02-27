Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0C63624D3
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186355; cv=pass; b=KhQXODAWtGetCMQdRZhxTjHXQRTyiTgfHwfreXRE72JFkCax9YIGJQFj8AEAEDlV32cL4nmCGXSkp6DYQdvSFN8wMuq9iODkcLeQNQ+5ZrNNLQn5pToRnK3LIFgi/nsau7HIszpm9j2S3YSmXVZlWMk2rFpfjzFHnh9bSqaXRTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186355; c=relaxed/simple;
	bh=1vBVfxbWzORpb66HVlLCE2dd8V6VpJNY2GJfZMZOAKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ioo3BkrCxG4qj0WNM6JhZLBBW2IOGljYXyqtYeNUg1TctwEJ+SPrBiyERWsOdYUZr7MPUL7/pQQQnleEBlu3QWZE5EHRw0tj5KxThvRnDfiv5KzBC0KYLyWGFBYqUWQtHfPsQX16pXAkjoGlS5MtUInIwgW3RjD3MO7xKx5rSVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DireHtcL; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DireHtcL"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4638e6bb8a5so743164b6e.0
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 01:59:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772186353; cv=none;
        d=google.com; s=arc-20240605;
        b=MmQ9psF34DFi4z1MQ87eWWjgS+ePl0dZC2B05J78McPXUo2cMjyKTqiK10q5/HwhYZ
         DdAs+ZGeFs30/P1HGlilDfXWhyEL4w7Ma3BeQaSJt/6AssjOpwdv8yR5OFnJU7Mqg7Bm
         BDuwUFSwyZMIYXv/Z760k2EmsVoQRc+i8LAQnoUmKNAnzkAiMdopZx/oUCHADvxrWpaa
         3+Eafiq81i8KUda/+n//MQoWYdgYdyWin+jlpIF9mRp1tz2Q2GE+8AQqB0g2RDPTNCPy
         0IymF/QtfNcYjX+tNIhJFBPXs+bGw60USa2Y0PoQ+DciNcNpflpHks99G45CKquge+UQ
         HSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MZxbbYV5Eqxi7oT1bKKex/IDE3KfHdf0FkD5wvKYxJ8=;
        fh=a8Cy/kvD0ctH+W2DM7HZwXegUxR0AyZ5qHhpjcHnU68=;
        b=AlCXHl2LL9XV9JQYx9aBq6Bz7nbLHI/QSK7NP4TYCsNIpsE71HvQkLqK7+5L076TMD
         An5djrrcLfVDpw6AGsSSnjDiHWzBmzGjIMjeaz/MwaeKLK49oVSyTaRSGvqrOxYJcNG+
         /+k7CC9wqicB6pX9AZDPA0Gj9WFpwmadOjkIlPMbm8lnsDrd1nOLfdtwl9siLaQne2ON
         Na4Diz1Dm010xAgmoFMX+MiszRp6EpkP1OqmPO2HVjJMtD0KTAr29211rY+oTpCQrY8L
         zJRrJnDlTgkenmIF8qI4B8Cvv7UsamLRNPh/gfQT8jhJjCzsF6PJILR1UFpsQBpinnQH
         LaQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772186353; x=1772791153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZxbbYV5Eqxi7oT1bKKex/IDE3KfHdf0FkD5wvKYxJ8=;
        b=DireHtcLFRBspYq+r3P9NJLRe6ChrRt0+p0+L9kOugjl71LcPgqIuHgxQhycfeAeRL
         vy9tB40GVfIeJYGog/G5zKAcFGc3Cnmoeyy951o1M58TblQL6alayg1y2uYXhKN6ZeY+
         7CHQVOYqJtQzX31ijEB5O/BMxMVRiVlYQ7GxSwnYmqxU4Oezg1Y9BFDZHUyYPtlo5Cxc
         s7267ki3yvmIFsXX4TURIGuoSR04jnbIzDm9mB2BWXw9doiWOQa2MEJwNOYR1V/I7Pv3
         UdOljrLBbMfN6wigf6on1wfSMWi+oWbpwey0mXDKuoo5mZ/XkXMKUTvRJr8kKsIq95iP
         k43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772186353; x=1772791153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MZxbbYV5Eqxi7oT1bKKex/IDE3KfHdf0FkD5wvKYxJ8=;
        b=FoHJgBreDnsIzxRD3WF+CLKyea69qTih0lE7fWhMq6YbOT93jXsrHv41CmmLgXiRpn
         1Z1ATMGBBXpKS//yDnKVd6uWYNSNcFegmQrrDez+qKWQHXzSJIIzEqh8DEqePbLaWNt/
         ivC7GGb9u0wBIr4orQsFp2KP9YpeS3AtDNcpzE6cBXFiQjUKnscGxLex79WhFNo9G94/
         Rgkfp1zmAPRzwBITGwF6qb1GHZwioTu/otttIVpjEWm3T6aoB6C0gr9sejrH31GXw1F5
         FfSPErQCCyGcuaB+QZ800mE9N9eY/gRNu1XmXaz6BjhqsQmoNP/cqz9qafWvQbNp/iOf
         E4DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfXcUD/f8ZMxPIK8PrfLTYjNvvEfLQLL2nvBcaAq6DfoigOAd6ofrbigD78VnEaNF9Rm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVTiCw3pHLtNE93LCirFRr144+yXw3fAEuOXFze9XGPvMnsoX0
	CkNiyLBRI1i9YEbZi+hJCWVMI1QkHzi6kM0dpz5aM9ptF3CxUOVGG464k0EyrVJkYaXVVtX/bnw
	Jo0D2s4ux/pyxv/ppdCPmI5Ggnm90DLo=
X-Gm-Gg: ATEYQzyQOtzMeReogaSaOVUtq/azXofq9D+R1Twu3VInuDMoxt0GkPnm1X6UdKIg09E
	kIH9FQT0dCYxb8ODk+XzTUriSE6re2fPk77PyptMIhDiAkwcaGCraPjWrDN3efwa688dvkBaInz
	/1vsItkAWq20ecShtVC8eYUKciNOt3obzK3W60CRGE6Yz0MhPzQRO5hnFNvDY+68Z8RMgp/dMIZ
	MK2QL/w2wOoj9wpKlpm6n4T3Icd/lv7WV/cYdFXjTai5/3eWSFS1+6jhcZ3z2bg06kUyyGXRmX+
	p5VTDuFf
X-Received: by 2002:a05:6808:4f62:b0:464:1ecc:b95b with SMTP id
 5614622812f47-464becb2f6fmr1199762b6e.63.1772186353013; Fri, 27 Feb 2026
 01:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227080351.663693-1-xry111@xry111.site>
In-Reply-To: <20260227080351.663693-1-xry111@xry111.site>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Fri, 27 Feb 2026 17:59:02 +0800
X-Gm-Features: AaiRm50JNpd6FGS0D9Ubgnt7sflVCqPk94W3Y__-LWd4REaI_QyZqSzreM1KbIs
Message-ID: <CAEyhmHTeDvWu1cZv59c80eZ31KjRtcXLcXuXphJ6_=oBk4rmZw@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Fix calling smp_processor_id() in
 preemptible code
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Mingcong Bai <jeffbai@aosc.io>, Zixing Liu <liushuyu@aosc.io>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	George Guo <guodongtai@kylinos.cn>, Chenghao Duan <duanchenghao@kylinos.cn>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 4:04=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> Fix the warning:
>
>     BUG: using smp_processor_id() in preemptible [00000000] code: sys
> temd/1
>     caller is larch_insn_text_copy+0x40/0xf0
>
> Simply changing it to raw_smp_processor_id() is not enough: if preempt
> and CPU hotplug happens after raw_smp_processor_id() but before
> stop_machine(), the CPU where raw_smp_processor_id() has run may be
> offline when stop_machine() and no CPU will run copy_to_kernel_nofault()
> in text_copy_cb().  Thus guard the larch_insn_text_copy() calls with
> cpus_read_lock() and change stop_machine() to stop_machine_cpuslocked()
> to prevent this.
>

I think you should include the P.S. part from v1 in the commit message.

> Fixes: 9fbd18cf4c69 ("LoongArch: BPF: Add dynamic code modification suppo=
rt")
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>
> Change since [v1]:
> - Add lockdep_assert_cpus_held() with a comment to prevent people from
>   calling larch_insn_text_copy() w/o acquiring the cpus lock in the
>   future.
>
> [v1]:https://lore.kernel.org/20260225141404.178823-2-xry111@xry111.site
>
>  arch/loongarch/kernel/inst.c | 10 ++++++++--
>  arch/loongarch/net/bpf_jit.c |  6 ++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> index bf037f0c6b26..7545ae3c796e 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -263,14 +263,20 @@ int larch_insn_text_copy(void *dst, void *src, size=
_t len)
>                 .dst =3D dst,
>                 .src =3D src,
>                 .len =3D len,
> -               .cpu =3D smp_processor_id(),
> +               .cpu =3D raw_smp_processor_id(),
>         };
>
> +       /*
> +        * Ensure copy.cpu won't be hot removed before stop_machine.  If
> +        * it's removed nobody will really update the text.
> +        */
> +       lockdep_assert_cpus_held();
> +
>         start =3D round_down((size_t)dst, PAGE_SIZE);
>         end   =3D round_up((size_t)dst + len, PAGE_SIZE);
>
>         set_memory_rw(start, (end - start) / PAGE_SIZE);
> -       ret =3D stop_machine(text_copy_cb, &copy, cpu_online_mask);
> +       ret =3D stop_machine_cpuslocked(text_copy_cb, &copy, cpu_online_m=
ask);
>         set_memory_rox(start, (end - start) / PAGE_SIZE);
>
>         return ret;
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 3bd89f55960d..e8e0ad34928c 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1379,9 +1379,11 @@ void *bpf_arch_text_copy(void *dst, void *src, siz=
e_t len)
>  {
>         int ret;
>
> +       cpus_read_lock();
>         mutex_lock(&text_mutex);
>         ret =3D larch_insn_text_copy(dst, src, len);
>         mutex_unlock(&text_mutex);
> +       cpus_read_unlock();
>
>         return ret ? ERR_PTR(-EINVAL) : dst;
>  }
> @@ -1429,10 +1431,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_po=
ke_type old_t,
>         if (ret)
>                 return ret;
>
> +       cpus_read_lock();
>         mutex_lock(&text_mutex);
>         if (memcmp(ip, new_insns, LOONGARCH_LONG_JUMP_NBYTES))
>                 ret =3D larch_insn_text_copy(ip, new_insns, LOONGARCH_LON=
G_JUMP_NBYTES);
>         mutex_unlock(&text_mutex);
> +       cpus_read_unlock();
>
>         return ret;
>  }
> @@ -1450,10 +1454,12 @@ int bpf_arch_text_invalidate(void *dst, size_t le=
n)
>         for (i =3D 0; i < (len / sizeof(u32)); i++)
>                 inst[i] =3D INSN_BREAK;
>
> +       cpus_read_lock();
>         mutex_lock(&text_mutex);
>         if (larch_insn_text_copy(dst, inst, len))
>                 ret =3D -EINVAL;
>         mutex_unlock(&text_mutex);
> +       cpus_read_unlock();
>
>         kvfree(inst);
>
> --
> 2.53.0
>
