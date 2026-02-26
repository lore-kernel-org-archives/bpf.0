Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88F2C08C4
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096908; cv=none; b=NYzhSQGub7xQSCw+FU5eUsLa9n5xnViPRbCcesXW28QJ3FujZYpywjRT/vUPYNxKRmnCE/2RoKWJgW91HU/7VDhpzlV+yi5JXMKJ31vDcByG/5ENSaokZu8jrd76NwpxDyFNcxmsPoCJuRSgXGDzxlq0mRUDD0sRjJPFLtHJ/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096908; c=relaxed/simple;
	bh=QLNuxpBRcW6ikN9KJUui5XavLnmFS1wkgW+SwDyc6ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FY0D1eeMS+FzLCV4chwrO5nARkkoZ6xUlw5iLw979iqfVO1lf2fhkqSizLoxdiAwNMsPbwRHQ9gnz/l2AUcmcA7m81KybxyFCB8z2joHHenbnWN/+OrDly/F70CqiRegrIacgUAF6jflI4c75jxMVUgZ39BvyaAT9pBjOqHB3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoHtaPgo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoHtaPgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1DDC19422
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 09:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772096908;
	bh=QLNuxpBRcW6ikN9KJUui5XavLnmFS1wkgW+SwDyc6ds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VoHtaPgouxhIjh5sMu71QGz1mWv3vQDFgFxkwPGHjm4Ile5g00TFTrZ+70AN/fMY+
	 ZiZwiw3ohIE5J1N1vVVZnU96odgKZE6DHeQpPxKH8UiaR9fkosOChZDZKFaCeAj1ek
	 BsO2IW9yq9fyhS14hkvZxvLtvWbF91idCFaLG4t+vCv9TcFqvPnWjIWtHbGo+tcV4G
	 FBBMhtqfy+OAuVlWLMF+k8uWX0U/t1/IrjvPgGmilplDlGz1GUjaon7yk2I0f2PvbX
	 82yEHTArnC64+IUSUiNi6+cHi1Dyldpf9rythi09ks6YTB2uNyjTezopC8PvsFjq4p
	 RAIoT3UEH5pdQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65c0d2f5fe1so1323175a12.3
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 01:08:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9iC/L++nIEre/etf3+IekBkN5a1bNMxfIndwkKoqjjp4JiAPrs9kpJqHLLb5JvX9Yv44=@vger.kernel.org
X-Gm-Message-State: AOJu0YykgDpkjAfumxOxY4GbBu50uSvW64awNvE9TSnGDejekwbEvdBK
	xfQ6b9eGja0+652qXqRUnuBMNHZm8fZ3x58JdRHJDH+ntT05LmpWGPIku/SwEZQxLXBmlop744b
	8nSNdUh6FASETH5cJdspY8woP7C4K9fI=
X-Received: by 2002:a05:6402:50ca:b0:65f:a619:22f4 with SMTP id
 4fb4d7f45d1cf-65fb6c90ed1mr866501a12.27.1772096906127; Thu, 26 Feb 2026
 01:08:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225141404.178823-2-xry111@xry111.site>
In-Reply-To: <20260225141404.178823-2-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 26 Feb 2026 17:08:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7rF+XwXmp_wfcHFmAgaybQdtzSUDRinFneLrGJKaNQCw@mail.gmail.com>
X-Gm-Features: AaiRm50YJQAht0mtVj3dMqPC-9kKo-NTXe0r1hNLvYfj16h_8iONkz2X_ZLMdCk
Message-ID: <CAAhV-H7rF+XwXmp_wfcHFmAgaybQdtzSUDRinFneLrGJKaNQCw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix calling smp_processor_id() in preemptible code
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, Hengqi Chen <hengqi.chen@gmail.com>, 
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

Hi, Ruoyao,

On Wed, Feb 25, 2026 at 10:15=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wro=
te:
>
> Fix the warning recently exploited by commit 4ab17e762b34 ("LoongArch:
> BPF: Use BPF prog pack allocator"):
>
>     BUG: using smp_processor_id() in preemptible [00000000] code: systemd=
/1
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
> Fixes: 9fbd18cf4c69 ("LoongArch: BPF: Add dynamic code modification suppo=
rt")
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>
> P.S. I've considered moving the locks inside larch_insn_text_copy() but
> doing so seems not an easy hack.  In bpf_arch_text_poke() obviously the
> memcpy() call must be guarded by text_mutex, so we have to leave the
> acquire of text_mutex out of larch_insn_text_copy.  But in the entire
> kernel the acquire of mutexes is always after cpus_read_lock(), so we
> cannot put cpus_read_lock() into larch_insn_text_copy() while leaving
> the text_mutex acquire out (or we risk a deadlock due to inconsistent
> lock acquire order).  So I'd just submit this as-is to fix the bug and
> leave the posssible refactor for others.
>
>  arch/loongarch/kernel/inst.c | 4 ++--
>  arch/loongarch/net/bpf_jit.c | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> index bf037f0c6b26..db236e2b34a7 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -263,14 +263,14 @@ int larch_insn_text_copy(void *dst, void *src, size=
_t len)
>                 .dst =3D dst,
>                 .src =3D src,
>                 .len =3D len,
> -               .cpu =3D smp_processor_id(),
> +               .cpu =3D raw_smp_processor_id(),
I think we should keep the old function here, because it can help
others to catch new bugs if the code is refactored in future.

Huacai

>         };
>
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
