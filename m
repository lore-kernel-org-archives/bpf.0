Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7FA2D0C8F
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 01:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959845; cv=pass; b=hLFXBgi87lFVku1r4jbDXfHt4EErIQ+n9baqorBqgwKSB7L4fuiCrNIgomcoKQltwoHmeePI0Kaa3/4QJlGM9hGLyn79N1K7jdfziOJWMT8FD7X8UXobaf7pERfBWhw5wQpjMudLh6p+7opZW4u7Axs3KTS4zcJASDRPzl8F6gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959845; c=relaxed/simple;
	bh=d/fzSty3uhFIl7HiRvNQUIsg1oOiQS3b+VaEtmyTm0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDjO/ILE4XIxgSTNRKx2ytzFDZW+tutpy9P2bfvy1S/UXBNpOyY5rJyinYC0wrGk7ev33pxrHCDFRb97uNV9KQuFI1BoCadImpkvO/Imk4FCYqvJ4tGABuwitldDcLx7N7V/fjRfUfeKH3jroPLnkpskLpJnnzIkjlq5kpvrzLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNeb+mUi; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNeb+mUi"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43590777e22so694603f8f.3
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 17:44:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768959838; cv=none;
        d=google.com; s=arc-20240605;
        b=k3sVz4Kzbv78VgfwlvUDKqFnQof8r6lag57eJGn/8YsOyNYGgaL+zuUdDXbYWDMNre
         20IyMCeFSfirjL6W9fvC2ctw4PBx7/za7DOppxvky4qxnafpwvzB5x5OFAZofmm8Maea
         r4KWotcRtxAepy5KhiICmASQ4UuFSpl1A89amTSOvpLXrhvpR4XMMx4kxoKyybjcVqg9
         v80LHVVVeEwIOjyAGSmjjTRNvDvUYIJTunAFkBRZj5vech8EUj2MLty8RTU8FYRT/5Ra
         kjxq//Gz5FRpIWswGUnXb1H3VhIF2gx0w8esg4K1r4s2XG7rutZwOZ5zg9LJr/LDYaE4
         en/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2WuKiVRVgARvTZSPf6fz13gJaSXUGYxCsdsd84fjKM=;
        fh=lOYUSATRsfaSYSPxfw9ZBaTENCUFROvL/UoF7GNXZ7U=;
        b=fVJqrar+/1frTxEK6RMOgHXezrXYhc9Yx7CdJzxF5Tz6mVoRMOoqKFuSFyreT04Ajw
         dNvxjenNUU6p+X7RCLLftR3jSIYMtSnlnwrsVeO55ZEexPQTAB+g8ixOZfCrdCKa0MK1
         ZNbf4NA6BnICatZzf5+RMq6lOPb/hRPjW6QTJGdnQE6T1Kx9aaozV/pUCqiXifkPC8hb
         Ps1bE4kgRv+Rwq4IrdggqCIzcRBx3AIVXMZedTcyOY2JODbywHBHSWdrJevdKgufSRuK
         1pIUz/OIutbnrCMkWYOXtv4Lc2PO2xL87BgzL60Un5XjxTRFfZ5qj6lkRtjL9kEdFiLR
         TBag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768959838; x=1769564638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2WuKiVRVgARvTZSPf6fz13gJaSXUGYxCsdsd84fjKM=;
        b=fNeb+mUiHwQFfKzE2by9AcRQCaJZJ+gxOS5aLzJqzDngHnOd+E/x6G+/w4AzvGH/wb
         Ni5xFeVXsBNUvc2MfOu+NiSxFzo1F7ycKb/w5CXeaIxryFmyEUm2q10wzxj4KaLuz+Qp
         GFxpKgGYDjOUVSy2sbM9ElnALKW7sBHVhygHT3zalnsqWxSc0xCrKl87AivvntnMRY/N
         cl64dm6L0Gxstxp4odvKOWRMhmndHcIGj2BfzNLe7YDz2NhhZ4T5ibMsVfxFq4unIriy
         cuKRS84QYTegycgc2CNmjYQmfu7asoP4Zn+lUr+t7guuXmeRiTWLIunCEdb/zixENpUD
         h1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768959838; x=1769564638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2WuKiVRVgARvTZSPf6fz13gJaSXUGYxCsdsd84fjKM=;
        b=EPSfP4fo9bI/9qrpUhAN6ItSHYdqF9OIxxU/SkGiq9OG6QnOmBvhlf3jlQP6aE6aZO
         Uf4v5AWzfJ6Zvy4WjGAJNjVNFtn/nyLrgeDPfK5syrncNeQtGhKcqBqtmQaeP5Eci9aG
         wGfjGkjSogiIo1cfFyVlreja199lanm0WNSk+W+4b03SEMKUPY9HNqse1qqTFvdwKF8u
         lfhGgCEmjFPPkgx6Z1O9MiWL+WzHElIUabM23UVRgDz61RzvSzLx6QJv1Bw8OPn25y5V
         UMyrU7X9/f3gzCduDW0TLB8TVreY5fip4wGAIcH6rl6JTAfXF3+NHKjvSxgNh09S19B8
         yVxw==
X-Forwarded-Encrypted: i=1; AJvYcCWYi84wAyakybH1M/fTMc/JKYnRbIyidl+dvJDztYxV7+57AUKB4B8OspgJYM0TcKG0A30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xXGZZMK8s/wwHPTrZWg75rimoqpKebSptyouqHBC4SYmET3d
	h3qcHelfl7cM98r3UjStZC2UheLKvgnh3qZkHUYsM7ZuaASjqK3wkMse/6xA0LjsnNmgIj2fKfL
	wmDk0tQFt6p/t0cth2/sLuVCOknPefqk=
X-Gm-Gg: AZuq6aITOvJ3RenchEBXWNjClPRTZA8jOLAtSzB9q6bPzdgYy0dZKLF3tfKWxfE3Iia
	taBipQorGosVYrydymU5+CuFcFecgrdHE7Guh+uNd36v4rtKxD1XSKpqy30GMaHyzqjhq58UgHw
	y9uzAiq8CaQx+NWHcGeH604r5AtyUnTy+PtcIb7hq7uA7sPWMRBcb0CEeORqUUsVLFp8yErDWfn
	yOb8cq3282LNUsacEzUwtY8Dp+VHWtwJCBfDBTSgdeToNwYePWzjXADUSYJTu0LOSvFbRb+QMFD
	PgidqRPs6jQncpBkugPQhYdvY9CNZLwzYFGULlIskvpWAQ83Y9lmN64lL/OCVQIVxcCWwI3PGO/
	i632Jx2xdaymCHQ==
X-Received: by 2002:a05:6000:400c:b0:430:f742:fbc7 with SMTP id
 ffacd0b85a97d-4356a0296e9mr21537226f8f.14.1768959838118; Tue, 20 Jan 2026
 17:43:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
 <20260120070555.233486-2-dongml2@chinatelecom.cn> <CAEf4BzYjbP4KwuVNT_pgjfXy=+7saEezmp1ck2L5txwtik5WYw@mail.gmail.com>
In-Reply-To: <CAEf4BzYjbP4KwuVNT_pgjfXy=+7saEezmp1ck2L5txwtik5WYw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 17:43:47 -0800
X-Gm-Features: AZwV_QiysGGmddkZRTL8WplB-JY8oujb-hYvMvAQnmBEGpUsh1RE0Tcb7O6rnec
Message-ID: <CAADnVQLkNFDvmzmxEzVBo=C1UfcxYsO_sSaTkvwg8LCswypvWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 5:24=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jan 19, 2026 at 11:06=E2=80=AFPM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >
> > Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> > to obtain better performance.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> > v5:
> > - don't support the !CONFIG_SMP case
> >
> > v4:
> > - handle the !CONFIG_SMP case
> >
> > v3:
> > - implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of i=
n
> >   x86_64 JIT.
> > ---
> >  kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9de0ec0c3ed9..c4e2ffadfb1f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -17739,6 +17739,10 @@ static bool verifier_inlines_helper_call(struc=
t bpf_verifier_env *env, s32 imm)
> >         switch (imm) {
> >  #ifdef CONFIG_X86_64
> >         case BPF_FUNC_get_smp_processor_id:
> > +#ifdef CONFIG_SMP
> > +       case BPF_FUNC_get_current_task_btf:
> > +       case BPF_FUNC_get_current_task:
> > +#endif
>
> Does this have to be x86-64 specific inlining? With verifier inlining
> and per_cpu instruction support it should theoretically work across
> all architectures that do support per-cpu instruction, no?
>
> Eduard pointed out [0] to me for why we have that x86-64 specific
> check. But looking at do_misc_fixups(), we have that early
> bpf_jit_inlines_helper_call(insn->imm)) check, so if some JIT has more
> performant inlining implementation, we will just do that.
>
> So it seems like we can just drop all that x86-64 specific logic and
> claim all three of these functions as inlinable, no?
>
> And even more. We can drop rather confusing
> verifier_inlines_helper_call() that duplicates the decision of which
> helpers can be inlined or not, and have:
>
> if (env->prog->jit_requested && bpf_jit_supports_percpu_insn() {
>     switch (insn->imm) {
>     case BPF_FUNC_get_smp_processor_id:
>         ...
>         break;
>     case BPF_FUNC_get_current_task_btf:
>     case BPF_FUNC_get_current_task_btf:
>         ...
>         break;
>     default:
> }
>
> And the decision about inlining will live in one place.
>
> Or am I missing some complications?

I think it needs to be arch specific, since 'current' is arch
specific. x86 is different from arm64.
Though both JITs support percpu pseudo insn, it doesn't help
to make get_current inlining generic.
One has to analyze each arch individually.
