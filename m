Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E042340DFAF
	for <bpf@vger.kernel.org>; Sun, 15 Mar 2026 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773560943; cv=none; b=i0cnjgKndj4t71CGWapq4IFoL0Js5tFA4FEO8/Ne6B5tGREg30yCgaphpXCpY9Inw3cTGN0zYPnqKXxOy1RFzs1i8PJiJDoFpzT8rfJCo+eMsA1af8c5BrMAcxJsYZ+BomRQvP74uayzk0wreRsxDnfbUmxr+uv0blbqi5plbVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773560943; c=relaxed/simple;
	bh=9+4WEo4/E7Ja2Uugyi2TnrkC0M1eH8c1DA4EnTfUmsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EaPzphR+IvXEMhn1huzXyQdTjJILArl2LHQ8eTXuT0Ee5Dj9135WzCfM/KoELly5io9FZZvt/10imfWnqZEgstTa7KBq55HSG6ngbhVYUEugz+1jj4+hw0eepz0Q4RtnoVxSP3waz9MVq6PVraexmb/ehRlYfQzHk6QENTsF7e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK7T/FrX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK7T/FrX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBDBC2BCB4
	for <bpf@vger.kernel.org>; Sun, 15 Mar 2026 07:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773560942;
	bh=9+4WEo4/E7Ja2Uugyi2TnrkC0M1eH8c1DA4EnTfUmsQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CK7T/FrX5FZS7o+zenPMYzRCa4G8OitUfsBOEcs5SygEMPsptzXeoOwXtJjF3oNE7
	 FvzC6hyTNtvtU+hIDx0zZ4LoQrYGaNhYVBaLURXCmHyhbx0q+imHydbhmzTwfCMDZR
	 tJDRxYg8DyzwbgE2IFT6puizsIAwu4MZGcvRIl33JQcCz2bi1xkC7VZy8lfvTMEPUZ
	 LwD98Xx1gHnScUyfvee5ieLxS3dtJq+s3o+bz10rl7KS28ClK28NhLrxLvn0VCU66i
	 LrW8zuQzsqb0DXCjCg1ZnEy2pppIYv5AZz7aqkx7mmO1UPlbKxv3cw11PrfDrzaJVQ
	 KsSdD4Jd8yGSA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9795ca4e6dso139729766b.2
        for <bpf@vger.kernel.org>; Sun, 15 Mar 2026 00:49:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUON2YdHLqnt/gtWZ/WlHtL5S9nXpRxvP209DGJH12IOuqZJkxUtBnhKC+8gREw4GCCI7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFJWwa89FIQ9m39Eq6CMKBgsOSCzyiGNLYCHKQEjqiPTVDlPX3
	xrmRxI+XGId2jUtcG/jIaFkKmZbcvw+HTi7RFkI3lcoRHu18MDtRbSWXQX3YBVwqB4kAVZIZ1wj
	hA3kQxAKbpl1lH2eHHg19vJvBH9d/zok=
X-Received: by 2002:a17:906:209c:b0:b96:f9c9:9d2b with SMTP id
 a640c23a62f3a-b9764f4ba23mr342750866b.8.1773560940809; Sun, 15 Mar 2026
 00:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303084314.628311-1-xry111@xry111.site>
In-Reply-To: <20260303084314.628311-1-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 15 Mar 2026 15:48:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6RXYGkt4uLgOCd_1UvmKvUyQBnvoZqFEXH=Qchq3TZfw@mail.gmail.com>
X-Gm-Features: AaiRm52aiU_o36LSlB2hsQZX7tuT4jvOtCTcnbwsPZbPZNmEOqTUp5FGztod56A
Message-ID: <CAAhV-H6RXYGkt4uLgOCd_1UvmKvUyQBnvoZqFEXH=Qchq3TZfw@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch: Fix calling smp_processor_id() in
 preemptible code
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

Applied, thanks.

Huacai

On Tue, Mar 3, 2026 at 4:43=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
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
> I've considered moving the locks inside larch_insn_text_copy() but
> doing so seems not an easy hack.  In bpf_arch_text_poke() obviously the
> memcpy() call must be guarded by text_mutex, so we have to leave the
> acquire of text_mutex out of larch_insn_text_copy.  But in the entire
> kernel the acquire of mutexes is always after cpus_read_lock(), so we
> cannot put cpus_read_lock() into larch_insn_text_copy() while leaving
> the text_mutex acquire out (or we risk a deadlock due to inconsistent
> lock acquire order).  So let's fix the bug first and leave the
> posssible refactor as future work.
>
> Fixes: 9fbd18cf4c69 ("LoongArch: BPF: Add dynamic code modification suppo=
rt")
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>
> Change since [v2]:
> - Include the annotation of v1 in the commit message.
>
> Change since [v1] to v2:
> - Add lockdep_assert_cpus_held() with a comment to prevent people from
>   calling larch_insn_text_copy() w/o acquiring the cpus lock in the
>   future.
>
> [v1]:https://lore.kernel.org/20260225141404.178823-2-xry111@xry111.site
> [v2]:https://lore.kernel.org/20260227080351.663693-1-xry111@xry111.site
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
>
